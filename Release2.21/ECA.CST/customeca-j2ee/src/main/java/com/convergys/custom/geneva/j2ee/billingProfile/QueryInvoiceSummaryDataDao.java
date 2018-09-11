package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

public class QueryInvoiceSummaryDataDao {

	private static TraceLog traceLog = new TraceLog(QueryInvoiceSummaryDataDao.class);
	private Util util;

	public QueryInvoiceSummaryDataDao() {
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

	/**
	 * 
	 * @param integratorContext
	 * @param invoiceNumber
	 * @return
	 * @author tkon2950
	 * @throws ApplicationException
	 */
	public QueryInvoiceSummaryOutPut queryInvoiceSummaryData(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String invoiceNumber) throws ApplicationException {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		// node = getHostName();
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;
		traceLog.traceFinest("Entered into BillingProfileDao queryCDRDetails API...startTime " + startTime);
		QueryInvoiceSummaryDataInput queryInvoiceSummaryDataInput = new QueryInvoiceSummaryDataInput();
		QueryInvoiceSummaryDataOutput queryInvoiceSummaryDataOutput = new QueryInvoiceSummaryDataOutput();
		QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut = new QueryInvoiceSummaryOutPut();

		try {
			traceLog.traceFinest("Entered into QueryInvoiceSummary API");

			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_INVOICE_SUMMARY_DATA);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.QUERY_INVOICE_SUMMARY_DATA);
			}

			if (invoiceNumber == null || invoiceNumber.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_10001, Constants.QUERY_INVOICE_SUMMARY_DATA);
			}

			// if (!validateInvoice(invoiceNumber)) {
			if (!util.validateInvoice(invoiceNumber)) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_10001);
			}

			queryInvoiceSummaryDataInput.setIntegratorContext(integratorContext);
			queryInvoiceSummaryDataInput.setInvoiceNumber(invoiceNumber);

			traceLog.traceFinest("Executing getQueryInvoiceSummaryData");
			queryInvoiceSummaryOutPut = getQueryInvoiceSummaryStorProc(invoiceNumber, queryInvoiceSummaryOutPut);
			traceLog.traceFinest("Executed getQueryInvoiceSummaryData");

			traceLog.traceFinest("Executing InvoiceDetailsUsage");
			queryInvoiceSummaryOutPut = getQueryInvoiceSummaryUsage(invoiceNumber, queryInvoiceSummaryOutPut);
			traceLog.traceFinest("Executed InvoiceDetailsUsage");

			traceLog.traceFinest("Executing InvoiceDetailsMrc");
			queryInvoiceSummaryOutPut = getQueryInvoiceMRCSummary(invoiceNumber, queryInvoiceSummaryOutPut);
			traceLog.traceFinest("Executed InvoiceDetailsMrc");

			traceLog.traceFinest("Executing InvoiceDetailsAdj");
			queryInvoiceSummaryOutPut = getQueryInvoiceAdjSummary(invoiceNumber, queryInvoiceSummaryOutPut);
			traceLog.traceFinest("Executed InvoiceDetailsAdj");

			traceLog.traceFinest("Executing InvoiceDetailsTaxes");
			queryInvoiceSummaryOutPut = getQueryInvoiceTaxesSummary(invoiceNumber, queryInvoiceSummaryOutPut);
			traceLog.traceFinest("Executed InvoiceDetailsTaxes");

			queryInvoiceSummaryDataOutput.setQueryInvoiceSummaryOutPut(queryInvoiceSummaryOutPut);

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after queryInvoiceSummaryData.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of queryInvoiceSummaryData is " + diff + "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					queryInvoiceSummaryDataInput, queryInvoiceSummaryDataOutput, responseStatus,
					Constants.QUERY_INVOICE_SUMMARYDATA, das, diffStr, node);

		} catch (Exception ex) {
			ex.printStackTrace();
			traceLog.traceFinest("Exception from  getQueryInvoiceSummaryStorProc API : " + ex.getMessage());
			responseStatus = ex.getMessage();

			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					queryInvoiceSummaryDataInput, queryInvoiceSummaryDataOutput, responseStatus,
					Constants.QUERY_INVOICE_SUMMARYDATA, das, diffStr, node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_10002 + ex.getMessage().toString());
		}
		traceLog.traceFinest("End of QueryInvoiceSummary API");
		return queryInvoiceSummaryOutPut;

	}

	public QueryInvoiceSummaryOutPut getQueryInvoiceSummaryStorProc(String invoiceNumber,
			QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut) throws ParseException {
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getQueryInvoiceSummaryStorProc method:" + invoiceNumber);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connectionObject = util.getDataSource().getConnection();
			preparedStatement = connectionObject.prepareStatement(SQLStatements.GET_INVOICE_SUMMARY_SQL);
			traceLog.traceFinest("SQLStatements.GET_INVOICE_SUMMARY_SQL: " + SQLStatements.GET_INVOICE_SUMMARY_SQL);
			preparedStatement.setString(1, invoiceNumber);
			preparedStatement.setString(2, invoiceNumber);
			preparedStatement.setString(3, invoiceNumber);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				CustomerDetailsResult customer = new CustomerDetailsResult();
				customer.setCustomerRef(resultSet.getString("CUSTOMER_REF"));
				customer.setCustomerName(resultSet.getString("COMPANY_NAME"));
				customer.setAddressLn1(resultSet.getString("ADDRESSLN1"));
        		if(resultSet.getString("ADDRESSLN2") != null)
        		{
        			customer.setAddressLn2(resultSet.getString("ADDRESSLN2"));
        		}
				customer.setCity(resultSet.getString("CITY_NAME"));
				customer.setState(resultSet.getString("STATE_NAME"));
				customer.setZipCode(resultSet.getString("ZIP_CODE"));
				customer.setCountry(resultSet.getString("COUNTRY_NAME"));
				customer.setAddressName(resultSet.getString("ADDRESS_NAME"));
				queryInvoiceSummaryOutPut.setCustomerDetailsResult(customer);

				// PaymentinformationResult
				PaymentinformationResult paymentInfo = new PaymentinformationResult();
				paymentInfo.setPaymentTerms(resultSet.getString("PAYMENT_TERM"));
				if (resultSet.getString("PAYMENT_DUE_DATE") != null) {
					traceLog.traceFinest("Date1 " + resultSet.getString("PAYMENT_DUE_DATE"));
					SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					Date date = dt.parse(resultSet.getString("PAYMENT_DUE_DATE"));
					SimpleDateFormat dt1 = new SimpleDateFormat("yyyyy-MM-dd");
					traceLog.traceFinest("Date2: " + dt1.format(date));
				}
				paymentInfo.setPaymentDuedate(resultSet.getString("PAYMENT_DUE_DATE"));

				// RemitToAddress
				RemitToAddressDetails remitToAddDetails = new RemitToAddressDetails();
				remitToAddDetails.setRemitToName(resultSet.getString("INVOICING_CO_NAME"));
				remitToAddDetails.setRemitToAddress1(resultSet.getString("REG_ADDR_1"));
				remitToAddDetails.setRemitToAddress2(resultSet.getString("REG_ADDR_2"));
				remitToAddDetails.setRemitToAddress3(resultSet.getString("REG_ADDR_3"));
				paymentInfo.setRemitToAddressDetails(remitToAddDetails);
				queryInvoiceSummaryOutPut.setPaymentinformationResult(paymentInfo);

				// Invoice Details
				InvoiceDetails inv = new InvoiceDetails();
				inv.setInvoiceNumber(resultSet.getString("INVOICE_NUM"));
				inv.setInvoiceDate(resultSet.getString("INVOICE_DTM"));
				inv.setInvoicePeriod(resultSet.getString("INVOICE_PERIOD"));
				inv.setCurrentMonthInvoiceAmt(resultSet.getDouble("CURRENT_INVOICE_TOTAL"));
				inv.setTotalDueAmt(resultSet.getDouble("TOTAL_DUE"));
				queryInvoiceSummaryOutPut.setInvoiceDetails(inv);

				// Invoice Summary Last Month Details
				InvoiceSummaryResult invSummary = new InvoiceSummaryResult();

				LastMonthInvoiceDetails lastMonthInvDetails = new LastMonthInvoiceDetails();
				lastMonthInvDetails.setPreviousBalanceMny(resultSet.getDouble("PREVIOUS_BALANCE"));
				;
				lastMonthInvDetails.setPaymentReceivedMny(resultSet.getDouble("PAYMENT_RECEIVED"));
				lastMonthInvDetails.setOutstandingBalanceMny(resultSet.getDouble("OUTSTANDING_BALANCE"));
				invSummary.setLastMonthInvoiceDetails(lastMonthInvDetails);
				queryInvoiceSummaryOutPut.setInvoiceSummaryResult(invSummary);

				// Current Month Invoice Details
				CurrentMonthInvoiceDetails currentMonthInvoiceDetails = new CurrentMonthInvoiceDetails();
				currentMonthInvoiceDetails.setCurrentInvoiceTotal(resultSet.getDouble("CURRENT_INVOICE_TOTAL"));
				invSummary.setCurrentMonthInvoiceDetails(currentMonthInvoiceDetails);
				queryInvoiceSummaryOutPut.setInvoiceSummaryResult(invSummary);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getQueryInvoiceSummaryStorProc:: " + e.getMessage());
		} finally {
			util.closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		return queryInvoiceSummaryOutPut;
	}

	public QueryInvoiceSummaryOutPut getQueryInvoiceSummaryUsage(String invoiceNumber,
			QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut) throws ApplicationException {
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getQueryInvoiceSummaryUsage method:" + invoiceNumber);
		try {
			traceLog.traceFinest("GET_INVOICE_SUMMARY_USAGE_SQL: " + SQLStatements.GET_INVOICE_SUMMARY_USAGE_SQL);
			List<HashMapPlus> results = getResults(invoiceNumber, SQLStatements.GET_INVOICE_SUMMARY_USAGE_SQL);
			SubTotalChargesResult subTotalChargesResult = null;
			double totalAmount = 0.0;
			String Partner = getPartners(invoiceNumber);
			if (results.size() > 0) {
				traceLog.traceFinest("ResultSet USAGE.. ");
				totalAmount = getTotalAmount(results);
			}
			subTotalChargesResult = getSubTotalChargesResult("USG", 1, Partner, totalAmount,
					Constants.SectionType.USG.getEventTypeIds());

			InvoiceSummaryResult invSummary = queryInvoiceSummaryOutPut.getInvoiceSummaryResult();
			invSummary.getCurrentMonthInvoiceDetails().setServiceUsageCharge(totalAmount);
			SubTotalChargesResult[] subTotalChargesResultArray = new SubTotalChargesResult[4];
			subTotalChargesResultArray[0] = subTotalChargesResult;
			invSummary.setSubTotalChargesResultArray(subTotalChargesResultArray);
			queryInvoiceSummaryOutPut.setInvoiceSummaryResult(invSummary);

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getQueryInvoiceSummaryUsage:: " + e.getMessage());
		}
		traceLog.traceFinest("End of getQueryInvoiceSummaryUsage method");
		return queryInvoiceSummaryOutPut;
	}

	public QueryInvoiceSummaryOutPut getQueryInvoiceMRCSummary(String invoiceNumber,
			QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut) throws ApplicationException {
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getQueryInvoiceMRCSummary method:" + invoiceNumber);
		try {
			traceLog.traceFinest("GET_INVOICE_SUMMARY_MRC_SQL: " + SQLStatements.GET_INVOICE_SUMMARY_MRC_SQL);
			List<HashMapPlus> results = getResults(invoiceNumber, SQLStatements.GET_INVOICE_SUMMARY_MRC_SQL);
			SubTotalChargesResult subTotalChargesResult = null;
			double totalAmount = 0.0;
			String Partner = getPartners(invoiceNumber);
			if (results.size() > 0) {
				traceLog.traceFinest("ResultSet MRC.. ");
				totalAmount = getTotalAmount(results);
			}
			subTotalChargesResult = getSubTotalChargesResult("MRC", 2, Partner, totalAmount,
					Constants.SectionType.MRC.getEventTypeIds());

			InvoiceSummaryResult invSummary = queryInvoiceSummaryOutPut.getInvoiceSummaryResult();
			invSummary.getCurrentMonthInvoiceDetails().setMRCCharges(totalAmount);
			SubTotalChargesResult[] subTotalChargesResultArray = invSummary.getSubTotalChargesResultArray();
			subTotalChargesResultArray[1] = subTotalChargesResult;
			invSummary.setSubTotalChargesResultArray(subTotalChargesResultArray);
			queryInvoiceSummaryOutPut.setInvoiceSummaryResult(invSummary);

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getQueryInvoiceMRCSummary:: " + e.getMessage());
		}
		traceLog.traceFinest("End of getQueryInvoiceCurrentMonthMRCSummary");
		return queryInvoiceSummaryOutPut;
	}

	public QueryInvoiceSummaryOutPut getQueryInvoiceAdjSummary(String invoiceNumber,
			QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut) throws ApplicationException {
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getQueryInvoiceAdjSummary method:" + invoiceNumber);
		try {
			traceLog.traceFinest("GET_INVOICE_SUMMARY_ADJ_SQL: " + SQLStatements.GET_INVOICE_SUMMARY_ADJ_SQL);
			List<HashMapPlus> results = getResults(invoiceNumber, SQLStatements.GET_INVOICE_SUMMARY_ADJ_SQL);
			SubTotalChargesResult subTotalChargesResult = null;
			double totalAmount = 0.0;
			String Partner = getPartners(invoiceNumber);
			if (results.size() > 0) {
				traceLog.traceFinest("ResultSet ADJ.. ");
				totalAmount = getTotalAmount(results);
			}
			subTotalChargesResult = getSubTotalChargesResult("ADJ", 3, Partner, totalAmount,
					Constants.SectionType.ADJ.getEventTypeIds());
			InvoiceSummaryResult invSummary = queryInvoiceSummaryOutPut.getInvoiceSummaryResult();
			invSummary.getCurrentMonthInvoiceDetails().setPromotionsAndAdjustments(totalAmount);
			SubTotalChargesResult[] subTotalChargesResultArray = invSummary.getSubTotalChargesResultArray();
			subTotalChargesResultArray[2] = subTotalChargesResult;
			invSummary.setSubTotalChargesResultArray(subTotalChargesResultArray);
			queryInvoiceSummaryOutPut.setInvoiceSummaryResult(invSummary);

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getQueryInvoiceAdjSummary:: " + e.getMessage());
		}
		traceLog.traceFinest("End of getQueryInvoiceAdjSummary");
		return queryInvoiceSummaryOutPut;
	}

	public QueryInvoiceSummaryOutPut getQueryInvoiceTaxesSummary(String invoiceNumber,
			QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut) throws ApplicationException {
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getQueryInvoiceTaxesSummary method:" + invoiceNumber);
		try {
			traceLog.traceFinest("GET_INVOICE_SUMMARY_ADJ_SQL: " + SQLStatements.GET_INVOICE_SUMMARY_TAXES_SQL);
			List<HashMapPlus> results = getResults(invoiceNumber, SQLStatements.GET_INVOICE_SUMMARY_TAXES_SQL);
			SubTotalChargesResult subTotalChargesResult = null;
			SubSectionTotalChargesResult[] SubSectionTotalChargesResultArray = new SubSectionTotalChargesResult[2];
			double totalAmount = 0.0;
			String Partner = getPartners(invoiceNumber);
			if (results.size() > 0) {
				traceLog.traceFinest("ResultSet TAX.. ");
				totalAmount = getTotalAmount(results);
			}
			subTotalChargesResult = getSubTotalChargesResult("TAX", 4, Partner, totalAmount, null);

			SubSectionTotalChargesResultArray[0] = getSubSectionModel(invoiceNumber, subTotalChargesResult, "GTF", 4,
					SQLStatements.GET_INVOICE_SUMMARY_TAXES_GTF_SQL, Partner);
			SubSectionTotalChargesResultArray[1] = getSubSectionModel(invoiceNumber, subTotalChargesResult, "OTF", 4,
					SQLStatements.GET_INVOICE_SUMMARY_TAXES_OTF_SQL, Partner);
			subTotalChargesResult.setSubSectionTotalChargesResultArray(SubSectionTotalChargesResultArray);
			InvoiceSummaryResult invSummary = queryInvoiceSummaryOutPut.getInvoiceSummaryResult();
			invSummary.getCurrentMonthInvoiceDetails().setTaxCharges(totalAmount);
			SubTotalChargesResult[] subTotalChargesResultArray = invSummary.getSubTotalChargesResultArray();
			subTotalChargesResultArray[3] = subTotalChargesResult;
			invSummary.setSubTotalChargesResultArray(subTotalChargesResultArray);
			queryInvoiceSummaryOutPut.setInvoiceSummaryResult(invSummary);

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getQueryInvoiceTaxesSummary:: " + e.getMessage());
		}
		traceLog.traceFinest("End of getQueryInvoiceCurrentMonthTAXESSummary");
		return queryInvoiceSummaryOutPut;
	}

	private List<HashMapPlus> getResults(String invoiceNumber, String query) {

		traceLog.traceFinest("Inside getResults method");
		List<HashMapPlus> results = null;

		try {

			String[] array = invoiceNumber.toUpperCase().split("-");
			IrbClientParam[] params = new IrbClientParam[2];
			params[0] = new IrbClientParam(1, array[0].trim(), Types.VARCHAR);
			params[1] = new IrbClientParam(2, Integer.parseInt(array[1].trim()), Types.INTEGER);
			results = util.executeQueryForList(query, params, null);

		} catch (Exception e) {
			traceLog.traceFinest("exception in  getResults method " + e.getMessage());
			e.printStackTrace();
		}

		traceLog.traceFinest("ended getResults method");
		return results;

	}

	private String getPartners(String invoiceNumber) {
		traceLog.traceFinest("Inside getPartners method");
		String partnerName = null;
		try {

			String[] array = invoiceNumber.toUpperCase().split("-");
			IrbClientParam[] params = new IrbClientParam[1];
			params[0] = new IrbClientParam(1, array[0].trim(), Types.VARCHAR);
			List<HashMapPlus> results = util.executeQueryForList(SQLStatements.GET_PARTNERS, params, null);
			StringBuffer sb = new StringBuffer();
			if (results.size() > 0) {

				if (results.size() > 1) {
					for (int i = 0; i < results.size(); i++) {
						if (!(i == results.size() - 1)) {
							sb.append(results.get(i).getString("PARTNER_NAME") + " , ");
						} else {
							sb.append(results.get(i).getString("PARTNER_NAME"));
						}

					}
					partnerName = sb.toString();

				} else {
					partnerName = results.get(0).getString("PARTNER_NAME");

				}

			}
		} catch (Exception e) {
			traceLog.traceFinest("exception in  getPartners method " + e.getMessage());
			e.printStackTrace();
		}
		traceLog.traceFinest("ended getResults method partnerName:" + partnerName);
		return partnerName;

	}

	private Double getTotalAmount(List<HashMapPlus> results) {
		traceLog.traceFinest("Inside getTotalAmount method:");

		double totalAmount = 0.0;

		if (results.size() > 0) {
			if (results.get(0).getDouble("TOTAL_AMOUNT") != null) {
				totalAmount = results.get(0).getDouble("TOTAL_AMOUNT");
			}
		}
		traceLog.traceFinest("Ended getPartnerNameAndTotalAmount:");
		return totalAmount;

	}

	private SubTotalChargesResult getSubTotalChargesResult(String sectionType, int sectionNumber, String partner,
			Double amount, String eventSummaryId) {

		if (sectionType.equals("TAX")) {

			SubTotalChargesResult subTotalChargesResult = new SubTotalChargesResult();
			subTotalChargesResult.setSectionType(sectionType);
			subTotalChargesResult.setSectionName(util.getSectionName(sectionType, partner));
			subTotalChargesResult.setSubTotal(amount);

			if (partner != null && !partner.trim().equals(" ")) {
				subTotalChargesResult.setPartnerName(partner);
			}

			return subTotalChargesResult;
		} else {
			SubTotalChargesResult subTotalChargesResult = new SubTotalChargesResult();
			subTotalChargesResult.setSectionType(sectionType);
			subTotalChargesResult.setSectionName(util.getSectionName(sectionType, partner));
			subTotalChargesResult.setSubTotal(amount);
			InvoiceSummaryKey invSummaryKey = new InvoiceSummaryKey();
			if (partner != null && !partner.trim().equals(" ")) {
				subTotalChargesResult.setPartnerName(partner);
				invSummaryKey.setPartnerName(partner);
			}
			invSummaryKey.setSectionType(sectionType);
			invSummaryKey.setSectionNumber(sectionNumber);
			if (eventSummaryId != null && !eventSummaryId.trim().equals(" ")) {
				invSummaryKey.setEventSumTypeIds(eventSummaryId);
			}

			subTotalChargesResult.setInvoiceSectionDetailsKey(invSummaryKey);

			return subTotalChargesResult;
		}
	}

	private SubSectionTotalChargesResult getSubSectionModel(String invoiceNumber,
			SubTotalChargesResult subTotalChargesResult, String subSectionType, int sectionNumber, String query,
			String partner) {
		double totalAmount = 0.0;
		List<HashMapPlus> results = getResults(invoiceNumber, query);
		if (results.size() > 0) {
			traceLog.traceFinest("ResultSet TAX.. ");
			totalAmount = getTotalAmount(results);
		}
		return getSubSectionSubTotalChargesResult(subSectionType, sectionNumber, partner, totalAmount, null);

	}

	private SubSectionTotalChargesResult getSubSectionSubTotalChargesResult(String subSectionType, int sectionNumber,
			String partner, double totalAmount, String eventSummaryId) {
		SubSectionTotalChargesResult subSectionTotalChargesResult = new SubSectionTotalChargesResult();
		subSectionTotalChargesResult.setSubSectionType(subSectionType);
		subSectionTotalChargesResult.setSubSectionName(util.getSectionName(subSectionType, partner));
		subSectionTotalChargesResult.setSubTotal(totalAmount);
		InvoiceSummaryKey invSummaryKey = new InvoiceSummaryKey();
		if (partner != null && !partner.trim().equals(" ")) {
			subSectionTotalChargesResult.setPartnerName(partner);
			invSummaryKey.setPartnerName(partner);
		}
		invSummaryKey.setSectionType(subSectionType);
		invSummaryKey.setSectionNumber(sectionNumber);
		if (eventSummaryId != null && !eventSummaryId.trim().equals(" ")) {
			invSummaryKey.setEventSumTypeIds(eventSummaryId);
		}

		subSectionTotalChargesResult.setInvoiceSectionDetailsKey(invSummaryKey);

		return subSectionTotalChargesResult;

	}

}
