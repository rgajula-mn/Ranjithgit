package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.HashMapPlus;
import com.convergys.custom.geneva.j2ee.util.IrbClientParam;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class QueryInvoiceSectionDetailsDao {

	private static TraceLog traceLog = new TraceLog(QueryInvoiceSectionDetailsDao.class);
	private Util util;

	private int totalCount = 0;

	public QueryInvoiceSectionDetailsDao() {
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

	public QueryInvoiceDetailsOutPutElements queryInvoiceSectionDetails(IntegratorContext integratorContext,
			String invoiceNumber, Pagination pagination, InvoiceSummaryKey invoiceSummaryKey) throws Exception {
		traceLog.traceFinest("QueryInvoiceSectionDetails method started ");

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;
		traceLog.traceFinest("QueryInvoiceSectionDetails method started ...startTime " + startTime);
		QueryInvoiceDetailsOutPutElements queryInvoiceDetailsOutPutElements = null;
		QueryInvoiceDetails[] queryInvoiceDetailsAsArray = null;
		long subTotal = 0;
		double sum = 0;

		QueryInvoiceSectionDetailsInput queryInvoiceSectionDetailsInput = new QueryInvoiceSectionDetailsInput();
		QueryInvoiceSectionDetailsOutput queryInvoiceSectionDetailsOutput = new QueryInvoiceSectionDetailsOutput();

		try {

			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.INVOICE_SECTION_DETAILS_API_NAME);
			}

			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.INVOICE_SECTION_DETAILS_API_NAME);
			}

			if (invoiceNumber == null || invoiceNumber.trim().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_10001, Constants.INVOICE_SECTION_DETAILS_API_NAME);
			}

			if (invoiceSummaryKey == null || invoiceSummaryKey.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_10004, Constants.INVOICE_SECTION_DETAILS_API_NAME);
			}

			if (invoiceSummaryKey.getSectionType() == null || invoiceSummaryKey.getSectionType().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_10007, Constants.INVOICE_SECTION_DETAILS_API_NAME);
			}

			if (pagination == null || pagination.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_10005, Constants.INVOICE_SECTION_DETAILS_API_NAME);
			}

			queryInvoiceSectionDetailsInput.setIntegratorContext(integratorContext);
			queryInvoiceSectionDetailsInput.setInvoiceNumber(invoiceNumber);
			queryInvoiceSectionDetailsInput.setInvoicSummaryKey(invoiceSummaryKey);
			queryInvoiceSectionDetailsInput.setPagination(pagination);

			if (!util.validateInvoice(invoiceNumber)) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_10001);
			}

			String[] array = invoiceNumber.toUpperCase().split("-");
			String sectionType = invoiceSummaryKey.getSectionType().trim();
			String eventTypeIds = invoiceSummaryKey.getEventSumTypeIds();
			String partnerName = invoiceSummaryKey.getPartnerName();
			IrbClientParam[] params = new IrbClientParam[2];
			String accountNum = array[0].trim();
			int billSeq = Integer.parseInt(array[1].trim());
			params[0] = new IrbClientParam(1, accountNum, Types.VARCHAR);
			params[1] = new IrbClientParam(2, billSeq, Types.INTEGER);
			String query = buildInvoiceSectionDetailsQuery(sectionType, eventTypeIds, partnerName, pagination, params);
			List<HashMapPlus> results = util.executeQueryForList(query, params, null);
			queryInvoiceDetailsAsArray = new QueryInvoiceDetails[results.size()];
			
			
			if (IsLatestInvoice(accountNum, billSeq)) {

				for (int i = 0; i < results.size(); i++) {

					QueryInvoiceDetails queryInvoiceDetails = new QueryInvoiceDetails();
					InvoiceLineItemDetailsKey key = new InvoiceLineItemDetailsKey();

					if (sectionType.equalsIgnoreCase("OTF") || sectionType.equalsIgnoreCase("GTF")) {
						queryInvoiceDetails.setDescription(results.get(i).getString("DESCRIPTION"));
						queryInvoiceDetails.setType(results.get(i).getString("TYPE"));
						if (results.get(i).getDouble("TOTAL_AMOUNT") != null) {
							sum = sum + results.get(i).getDouble("TOTAL_AMOUNT");
							queryInvoiceDetails.setTotalAmount(results.get(i).getDouble("TOTAL_AMOUNT"));
						}
						key.setSectionType(sectionType);
						queryInvoiceDetails.setInvoiceLineItemDetailsKey(key);
						queryInvoiceDetailsAsArray[i] = queryInvoiceDetails;
					} else {

						if (results.get(i).getDouble("UNIT_PRICE") != null) {
							queryInvoiceDetails.setUnitPrice(results.get(i).getDouble("UNIT_PRICE"));
							key.setUnitPrice(results.get(i).getDouble("UNIT_PRICE"));
						}

						queryInvoiceDetails.setUnitType(results.get(i).getString("UNIT_TYPE"));
						queryInvoiceDetails.setDescription(results.get(i).getString("DESCRIPTION"));
						queryInvoiceDetails.setType(results.get(i).getString("TYPE"));
						queryInvoiceDetails.setQuantity(results.get(i).getString("QUANTITY"));

						if (results.get(i).getDouble("TOTAL_AMOUNT") != null) {
							sum = sum + results.get(i).getDouble("TOTAL_AMOUNT");
							queryInvoiceDetails.setTotalAmount(results.get(i).getDouble("TOTAL_AMOUNT"));
						}

						if (sectionType.equalsIgnoreCase("ADJ") && results.get(i).getDate("ADJ_DATE") != null) {
							queryInvoiceDetails.setAdjustmentDateNbl((results.get(i).getDate("ADJ_DATE")).getTime());
						}

						key.setEventSumTypeIds(results.get(i).getString("EVENT_SUMMARY_ID"));
						key.setSectionType(sectionType.toUpperCase());
						key.setPartnerName(results.get(i).getString("PARTNER_NAME"));
						key.setQuantity(results.get(i).getString("QUANTITY"));
						if (!sectionType.equalsIgnoreCase("ADJ")) {
							queryInvoiceDetails.setTechType(results.get(i).getString("TECH_TYPE"));
							queryInvoiceDetails.setPlan(results.get(i).getString("PLAN"));
							key.setEventClassPPA(results.get(i).getString("EVENT_CLASS"));
							key.setCostBandDesc(results.get(i).getString("COST_BAND_DESC"));
							key.setPlan(results.get(i).getString("PLAN"));
							key.setTechType(results.get(i).getString("TECH_TYPE"));
							key.setTLOObjectID(results.get(i).getString("TLO_OBJECT_ID"));
							key.setBillingTariffName(results.get(i).getString("BILLING_TARIFF_NAME"));
						}
						if (sectionType.equalsIgnoreCase("MRC")) {
							queryInvoiceDetails.setCategory(results.get(i).getString("CATEGORY"));
						}
						key.setDescription(results.get(i).getString("DESCRIPTION"));
						key.setSectionName(util.getSectionName(sectionType.toUpperCase(),
								results.get(i).getString("PARTNER_NAME")));
						queryInvoiceDetails.setInvoiceLineItemDetailsKey(key);
						queryInvoiceDetailsAsArray[i] = queryInvoiceDetails;
					}

				}
			} else {
				for (int i = 0; i < results.size(); i++) {

					QueryInvoiceDetails queryInvoiceDetails = new QueryInvoiceDetails();

					if (sectionType.equalsIgnoreCase("OTF") || sectionType.equalsIgnoreCase("GTF")) {
						queryInvoiceDetails.setDescription(results.get(i).getString("DESCRIPTION"));
						queryInvoiceDetails.setType(results.get(i).getString("TYPE"));
						if (results.get(i).getDouble("TOTAL_AMOUNT") != null) {
							sum = sum + results.get(i).getDouble("TOTAL_AMOUNT");
							queryInvoiceDetails.setTotalAmount(results.get(i).getDouble("TOTAL_AMOUNT"));
						}
						queryInvoiceDetailsAsArray[i] = queryInvoiceDetails;
					} else {

						if (results.get(i).getDouble("UNIT_PRICE") != null) {
							queryInvoiceDetails.setUnitPrice(results.get(i).getDouble("UNIT_PRICE"));
						}

						queryInvoiceDetails.setUnitType(results.get(i).getString("UNIT_TYPE"));
						queryInvoiceDetails.setDescription(results.get(i).getString("DESCRIPTION"));
						queryInvoiceDetails.setType(results.get(i).getString("TYPE"));
						queryInvoiceDetails.setQuantity(results.get(i).getString("QUANTITY"));

						if (results.get(i).getDouble("TOTAL_AMOUNT") != null) {
							sum = sum + results.get(i).getDouble("TOTAL_AMOUNT");
							queryInvoiceDetails.setTotalAmount(results.get(i).getDouble("TOTAL_AMOUNT"));
						}

						if (sectionType.equalsIgnoreCase("ADJ") && results.get(i).getDate("ADJ_DATE") != null) {
							queryInvoiceDetails.setAdjustmentDateNbl((results.get(i).getDate("ADJ_DATE")).getTime());
						}

						if (!sectionType.equalsIgnoreCase("ADJ")) {
							queryInvoiceDetails.setTechType(results.get(i).getString("TECH_TYPE"));
							queryInvoiceDetails.setPlan(results.get(i).getString("PLAN"));
						}
						if (sectionType.equalsIgnoreCase("MRC")) {
							queryInvoiceDetails.setCategory(results.get(i).getString("CATEGORY"));
						}
						queryInvoiceDetailsAsArray[i] = queryInvoiceDetails;
					}

				}

			}
			

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after queryInvoiceSectionDetails.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("Time taken for the execution of queryInvoiceSectionDetails is " + diff
						+ "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;

		} catch (Exception ex) {
			traceLog.traceFinest("Exception occured   in method InvoiceSectionDetails " + ex.getMessage());
			responseStatus = ex.getMessage();
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					queryInvoiceSectionDetailsInput, queryInvoiceSectionDetailsOutput, responseStatus,
					Constants.QUERY_INVOICE_SECTIONDETAILS, das, diffStr, node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_10006 + ex.getMessage().toString());
		}

		subTotal = Math.round(sum);
		queryInvoiceDetailsOutPutElements = new QueryInvoiceDetailsOutPutElements(queryInvoiceDetailsAsArray, subTotal,
				String.valueOf(totalCount));
		traceLog.traceFinest("QueryInvoiceSectionDetails method ended ");
		queryInvoiceSectionDetailsOutput.setQueryInvoiceDetailsOutPut(queryInvoiceDetailsOutPutElements);
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
				queryInvoiceSectionDetailsInput, queryInvoiceSectionDetailsOutput, responseStatus,
				Constants.QUERY_INVOICE_SECTIONDETAILS, das, diffStr, node);
		return queryInvoiceDetailsOutPutElements;
	}

	private String buildInvoiceSectionDetailsQuery(String sectionType, String eventTypeIds, String partnerName,
			Pagination pagination, IrbClientParam[] params) throws Exception {
		traceLog.traceFinest("buildInvoiceSectionDetailsQuery method started ");

		boolean eventTypeFlag = false;
		StringBuilder sb = null;
		String query = null;
		if (eventTypeIds != null && !eventTypeIds.trim().equals("")) {
			eventTypeFlag = true;

		}

		switch (sectionType.toUpperCase()) {
		case "USG":
			if (eventTypeFlag) {
				query = String.format(SQLStatements.INVOICE_SECTION_DETAILS_USAGE_SQL, eventTypeIds);
			} else {
				query = String.format(SQLStatements.INVOICE_SECTION_DETAILS_USAGE_SQL,
						Constants.SectionType.USG.getEventTypeIds());
			}
			break;

		case "MRC":
			if (eventTypeFlag) {
				query = String.format(SQLStatements.INVOICE_SECTION_DETAILS_MRC_SQL, eventTypeIds);
			} else {
				traceLog.traceFinest(
						"Constants.SectionType.USG.getEventTypeIds() " + Constants.SectionType.MRC.getEventTypeIds());
				query = String.format(SQLStatements.INVOICE_SECTION_DETAILS_MRC_SQL,
						Constants.SectionType.MRC.getEventTypeIds());
			}
			break;

		case "ADJ":
			if (eventTypeFlag) {
				query = String.format(SQLStatements.INVOICE_SECTION_DETAILS_ADJ_SQL, eventTypeIds);
			} else {
				query = String.format(SQLStatements.INVOICE_SECTION_DETAILS_ADJ_SQL,
						Constants.SectionType.ADJ.getEventTypeIds());
			}
			break;

		case "TAX":
			query = SQLStatements.INVOICE_SECTION_DETAILS_TAX_SQL;
			break;

		case "OTF":
			query = SQLStatements.INVOICE_SECTION_DETAILS_OTF_TAX_SQL;
			break;

		case "GTF":
			query = SQLStatements.INVOICE_SECTION_DETAILS_GTF_TAX_SQL;
			break;

		default:
			throw new ApplicationException(ErrorCodes.ERR_RBM_10007);

		}
		sb = new StringBuilder(query);
		if (!(sectionType.equalsIgnoreCase("TAX") || sectionType.equalsIgnoreCase("GTF")
				|| sectionType.equalsIgnoreCase("OTF"))) {
			if (partnerName != null && !partnerName.trim().equals("")) {
				StringBuffer nameBuffer = new StringBuffer();
				String[] partnersArray = partnerName.split(",");
				if (partnersArray.length > 1) {
					for (int i = 0; i < partnersArray.length; i++) {
						if (!(i == partnersArray.length - 1)) {
							nameBuffer.append(" '" + partnersArray[i].trim() + "' " + " , ");
						} else {
							nameBuffer.append(" '" + partnersArray[i].trim() + "' ");
						}

					}
				} else {
					nameBuffer.append(" '" + partnersArray[0].trim() + "' ");

				}
				sb.append(" AND  PARTNER_NAME IN ( " + nameBuffer.toString() + ") ");
			}

		}
		traceLog.traceFinest(" query for invoice section" + sb.toString());
		totalCount = getTotalCountForInvoiceSection(sb, params);

		if (!(sectionType.equalsIgnoreCase("TAX") || sectionType.equalsIgnoreCase("GTF")
				|| sectionType.equalsIgnoreCase("OTF"))) {
			if (sectionType.equalsIgnoreCase("USG")) {
				sb.append(" ORDER BY PARTNER_NAME, ORDER_NUM, DESCRIPTION,PLAN,UNIT_PRICE,TYPE ");
			} else if (sectionType.equalsIgnoreCase("MRC")) {
				sb.append(" ORDER BY PARTNER_NAME, DESCRIPTION,PLAN,UNIT_PRICE ");
			} else {
				sb.append(" ORDER BY DESCRIPTION,UNIT_PRICE ");
			}

		}

		sb = util.buildPaginationQuery(pagination, sb);
		traceLog.traceFinest(" buildInvoiceSectionDetailsQuery method ended");
		return sb.toString();
	}

	private int getTotalCountForInvoiceSection(StringBuilder viewName, IrbClientParam[] params) throws Exception {
		traceLog.traceFinest(" getTotalCountForInvoiceSection method started");
		int rowCount = 0;
		if (viewName != null) {
			StringBuilder query = new StringBuilder();
			query.append("SELECT COUNT(*) AS ROWCOUNT FROM ( " + viewName + " )");

			HashMapPlus results = util.executeQueryForItem(query.toString(), params, null);
			if (results != null && results.size() != 0) {
				rowCount = results.getInt("ROWCOUNT");
			}
		}
		traceLog.traceFinest(" getTotalCountForInvoiceSection method ended");
		return rowCount;
	}	
	
	private boolean IsLatestInvoice(String accountNum, int billSeq) throws Exception {
		traceLog.traceFinest(" IsLatestInvoice method started");
		boolean isLatestInvoice = false;
		IrbClientParam[] params = new IrbClientParam[1];
		params[0] = new IrbClientParam(1, accountNum, Types.VARCHAR);
		HashMapPlus results = util.executeQueryForItem(SQLStatements.GET_MAX_BILL_SEQ, params, null);
		if (results != null && results.size() != 0) {
			int maxBillSeq = results.getInt("MAX_BILL_SEQ");
			if(billSeq == maxBillSeq) {
				isLatestInvoice = true;
			}
		}
		traceLog.traceFinest(" IsLatestInvoice method ended");
		return isLatestInvoice;
	}	

}
