package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
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

public class QueryLineItemDetailsDao {

	private static TraceLog traceLog = new TraceLog(QueryLineItemDetailsDao.class);
	private Util util;

	private int totalCount = 0;

	public QueryLineItemDetailsDao() {
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

	public com.convergys.custom.geneva.j2ee.billingProfile.QueryLineItemDetailsResult queryLineItemDetails(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String invoiceNumber,
			com.convergys.custom.geneva.j2ee.billingProfile.FilterArrayElements[] filterArray,
			com.convergys.custom.geneva.j2ee.billingProfile.SortingArrayElements[] sortArray,
			com.convergys.custom.geneva.j2ee.billingProfile.InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			com.convergys.custom.geneva.j2ee.billingProfile.Pagination pagination) throws Exception {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;

		QueryLineItemDetailsInput queryLineItemDetailsInput = new QueryLineItemDetailsInput();
		QueryLineItemDetailsOutput queryLineItemDetailsOutput = new QueryLineItemDetailsOutput();

		traceLog.traceFinest("start of queryLineItemDetails method ...startTime " + startTime);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;

		QueryLineItemDetailsResult queryLineItemOutput = new QueryLineItemDetailsResult();

		try {

			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_LINE_ITEM_DETAILS_API_NAME);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.QUERY_LINE_ITEM_DETAILS_API_NAME);
			}
			if (invoiceNumber == null || invoiceNumber.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_12000, Constants.QUERY_LINE_ITEM_DETAILS_API_NAME);
			}
			if (invoiceLineItemDetailsKey == null || invoiceLineItemDetailsKey.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_12001, Constants.QUERY_LINE_ITEM_DETAILS_API_NAME);
			}
			if (pagination == null || pagination.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_10005, Constants.QUERY_LINE_ITEM_DETAILS_API_NAME);
			}

			queryLineItemDetailsInput.setIntegratorContext(integratorContext);
			queryLineItemDetailsInput.setFilterArray(filterArray);
			queryLineItemDetailsInput.setInvoiceLineItemDetailsKey(invoiceLineItemDetailsKey);
			queryLineItemDetailsInput.setInvoiceNumber(invoiceNumber);
			queryLineItemDetailsInput.setPagination(pagination);

			if (!util.validateInvoice(invoiceNumber)) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_10001);
			}

			conn = util.getDataSource().getConnection();
			pstmt = conn.prepareStatement(SQLStatements.QUERY_VIEW);
			String eventClassPPA = null;

			if (invoiceLineItemDetailsKey.getSectionType().trim().equalsIgnoreCase("USG")) {
				pstmt.setString(1, "SUBBILLEDUSAGE_VIEW");
				traceLog.traceFinest("start of queryLineItemDetails method if USG:"
						+ Constants.LineItemView.USAGE_LINE.getLineItemView());

			} else if (invoiceLineItemDetailsKey.getSectionType().trim().equalsIgnoreCase("MRC")) {
				traceLog.traceFinest("start of queryLineItemDetails method if MRC");
				eventClassPPA = invoiceLineItemDetailsKey.getEventClassPPA().trim();
				switch (eventClassPPA.toUpperCase()) {
				case Constants.STD_RECURRING:
					pstmt.setString(1, "SUBACTIVEDAYS_VIEW");
					break;
				case Constants.STD_ACTIVATION:
					return queryLineItemOutput;
				case Constants.HSD_CHARGE:
					pstmt.setString(1, "SUBHSDCHARGE_VIEW");
					break;
				case Constants.HSD_CREDIT:
					pstmt.setString(1, "SUBHSDCREDIT_VIEW");
					break;
				case Constants.SUSPEND:
					pstmt.setString(1, "SUBSUSPENDDAYS_VIEW");
					break;
				case Constants.DORMANCY:
					pstmt.setString(1, "SUBSUSPENDDAYS_VIEW");
					break;
				case Constants.ILD_MEXICO:
					return queryLineItemOutput;
				case Constants.NONLTE_PENALTY:
					pstmt.setString(1, "IMEIPENALTY_VIEW");
					break;
				case Constants.ACCESS_FEE:
					pstmt.setString(1, "ACCESSFEE_VIEW");
					break;
				case Constants.IMSI_PENALTY:
					pstmt.setString(1, "IMSIPENALTY_VIEW");
					break;
				case Constants.NUMIMSI1_MRC:
					pstmt.setString(1, "NUMIMSI_MRC_VIEW");
					break;
				case Constants.NUMIMSI10_MRC:
					pstmt.setString(1, "NUMIMSI_MRC_VIEW");
					break;
				case Constants.SIMFEE:
					return queryLineItemOutput;
				case Constants.MULTI_IMSI_FEE:
					return queryLineItemOutput;
				default:
					traceLog.traceFinest("queryLineItemDetails eventClassPPA:default");
					return queryLineItemOutput;
				}
			} else {

				return queryLineItemOutput;
			}

			traceLog.traceFinest("queryLineItemDetails QUERY_VIEW: " + pstmt.toString());
			resultSet = pstmt.executeQuery();
			Column[] colArr = null;
			ResultSetArray[] resultArr = null;
			List<String> resultList = new ArrayList<String>();
			List<Column> resultColumnList = new ArrayList<Column>();

			Column col = null;

			while (resultSet.next()) {

				col = new Column();
				col.setName(resultSet.getString("COLUMN_NAME"));
				col.setType(resultSet.getString("DATA_TYPE"));
				col.setSizeNbl(Integer.parseInt(resultSet.getString("DATA_LENGTH")));
				resultColumnList.add(col);
			}
			if (invoiceLineItemDetailsKey.getSectionType().trim().equals("USG")) {
				col = new Column();
				col.setName("CDR_Data");
				col.setType("CDRDetailsKey");
				resultColumnList.add(col);
			}

			colArr = (Column[]) resultColumnList.toArray(new Column[resultColumnList.size()]);
			queryLineItemOutput.setColumnArray(colArr);

			resultList = getResultSetArrayForQueryLineItemDetails(conn, resultColumnList, invoiceNumber, eventClassPPA,
					filterArray, sortArray, invoiceLineItemDetailsKey, pagination);
			resultArr = new ResultSetArray[resultList.size()];
			for (int k = 0; k < resultList.size(); k++) {
				resultArr[k] = new ResultSetArray();
				resultArr[k].setResult(resultList.get(k));
			}

			queryLineItemOutput.setResultSetArray(resultArr);
			queryLineItemOutput.setTotalRowsCount(String.valueOf(totalCount));

			queryLineItemDetailsOutput.setQueryLineItemDetailsResult(queryLineItemOutput);

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after queryLineItemDetails.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of queryLineItemDetails is " + diff + "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, queryLineItemDetailsInput,
					queryLineItemDetailsOutput, responseStatus, Constants.QUERY_LINEITEMDETAILS, das, diffStr, node);

		} catch (Exception ex) {
			traceLog.traceFinest("Exception from  queryLineItemDetails API : " + ex.getMessage());
			responseStatus = ex.getMessage();
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, queryLineItemDetailsInput,
					queryLineItemDetailsOutput, responseStatus, Constants.QUERY_LINEITEMDETAILS, das, diffStr, node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_12003 + ex.getMessage().toString());
		}

		traceLog.traceFinest("end of queryLineItemDetails method");
		return queryLineItemOutput;
	}

	private List<String> getResultSetArrayForQueryLineItemDetails(Connection conn, List<Column> column,
			String invoiceNumber, String eventClassPPA, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			Pagination pagination) {
		String resultStr = null;
		String resultStr1 = null;

		PreparedStatement pstmt2 = null;
		ResultSet resultSet1 = null;
		List<String> resultList = new ArrayList<String>();
		String queryLineItemDetailsSql = null;

		String[] splitOutput = invoiceNumber.split("-");
		String accountNum = splitOutput[0].trim();
		String billSeq = splitOutput[1].trim();

		try {

			if (invoiceLineItemDetailsKey.getSectionType().trim().equalsIgnoreCase("USG")) {
				queryLineItemDetailsSql = buildUsageLineItemQuery(accountNum, billSeq, filterArray, sortArray,
						invoiceLineItemDetailsKey, pagination);

			} else if (invoiceLineItemDetailsKey.getSectionType().trim().equalsIgnoreCase("MRC")) {
				traceLog.traceFinest("start of getResultSetArrayForQueryLineItemDetails method try block else MRC");
				switch (eventClassPPA.toUpperCase()) {
				case Constants.STD_RECURRING:
					queryLineItemDetailsSql = buildSTDRecurringLineItemQuery(accountNum, billSeq, filterArray,
							sortArray, invoiceLineItemDetailsKey, pagination);
					break;
				case Constants.HSD_CHARGE:
					queryLineItemDetailsSql = buildHSDChargeLineItemQuery(accountNum, billSeq, filterArray, sortArray,
							invoiceLineItemDetailsKey, pagination);
					break;
				case Constants.HSD_CREDIT:
					queryLineItemDetailsSql = buildHSDCreditLineItemQuery(accountNum, billSeq, filterArray, sortArray,
							invoiceLineItemDetailsKey, pagination);
					break;
				case Constants.SUSPEND:
					queryLineItemDetailsSql = buildSuspendDormancyLineItemQuery(accountNum, billSeq, filterArray,
							sortArray, invoiceLineItemDetailsKey, pagination);
					break;
				case Constants.DORMANCY:
					queryLineItemDetailsSql = buildSuspendDormancyLineItemQuery(accountNum, billSeq, filterArray,
							sortArray, invoiceLineItemDetailsKey, pagination);
					break;
				case Constants.NONLTE_PENALTY:
					queryLineItemDetailsSql = buildNonLTEPenaltyLineItemQuery(accountNum, null, filterArray, sortArray,
							null, pagination);
					break;
				case Constants.ACCESS_FEE:
					queryLineItemDetailsSql = buildAccessFeeLineItemQuery(accountNum, billSeq, filterArray, sortArray,
							invoiceLineItemDetailsKey, pagination);
					break;
				case Constants.IMSI_PENALTY:
					queryLineItemDetailsSql = buildIMSIPenaltyLineItemQuery(accountNum, billSeq, filterArray, sortArray,
							null, pagination);
					break;
				case Constants.NUMIMSI1_MRC:
					queryLineItemDetailsSql = buildNUMIMSILineItemQuery(billSeq,"NUMIMSI1", filterArray,sortArray, null, pagination);
					break;
				case Constants.NUMIMSI10_MRC:
					queryLineItemDetailsSql = buildNUMIMSILineItemQuery(billSeq,"NUMIMSI10", filterArray,sortArray, null, pagination);
					break;
				}

			}

			pstmt2 = conn.prepareStatement(queryLineItemDetailsSql);
			resultSet1 = pstmt2.executeQuery();

			while (resultSet1.next()) {
				CDRDetailsKey cdrKey = new CDRDetailsKey();
				cdrKey.setDescription(invoiceLineItemDetailsKey.getDescription());
				cdrKey.setPlan(invoiceLineItemDetailsKey.getPlan());
				cdrKey.setSectionName(invoiceLineItemDetailsKey.getSectionName());
				for (int i = 0; i < column.size(); i++) {
					if (column.get(i).getName().equals("CDR_Data")) {

					} else {
						resultStr = resultSet1.getString(column.get(i).getName());
					}
					if (resultStr == null || resultStr == "") {
						resultStr = "";
					}

					if (resultStr1 != null) {

						if (i < column.size() - 1) {

							resultStr1 = resultStr1 + "'" + resultStr + "'|";
						} else {

							if (invoiceLineItemDetailsKey.getSectionType().equalsIgnoreCase("USG")) {
								resultStr1 = resultStr1 + cdrKey;
							} else {
								resultStr1 = resultStr1 + "'" + resultStr + "'";
							}

						}

					} else {
						resultStr1 = "'" + resultStr + "'|";
					}
					if (invoiceLineItemDetailsKey.getSectionType().equalsIgnoreCase("USG")) {
						buildCDRDetailsKeyObject(cdrKey, column.get(i).getName(), resultStr);
					}

				}

				resultList.add(resultStr1);
				resultStr1 = null;
			}
		} catch (Exception ex) {
			traceLog.traceFinest("Exception from  getResultSetArrayForQueryLineItemDetails: " + ex.getMessage());

		}
		return resultList;

	}

	private String buildUsageLineItemQuery(String accountNumber, String billSeq, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			Pagination pagination) {

		StringBuilder query = buildConditionQuery(Constants.LineItemView.USAGE_LINE.getLineItemView(), accountNumber,
				billSeq, invoiceLineItemDetailsKey);
		if (invoiceLineItemDetailsKey.getEventClassPPA() != null
				&& !invoiceLineItemDetailsKey.getEventClassPPA().trim().equals("")) {
			query.append("AND EVENT_CLASS LIKE '" + invoiceLineItemDetailsKey.getEventClassPPA() + "' ");
		}
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildUsageLineItemQuery : " + query.toString());
		return query.toString();
	}

	private String buildSTDRecurringLineItemQuery(String accountNumber, String billSeq,
			FilterArrayElements[] filterArray, SortingArrayElements[] sortArray,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey, Pagination pagination) {

		StringBuilder query = buildConditionQueryForActiveDays(Constants.LineItemView.MRC_STD_RECURRING_LINE.getLineItemView(),
				accountNumber, billSeq, invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildSTDRecurringLineItemQuery : " + query.toString());
		return query.toString();
	}

	private String buildHSDChargeLineItemQuery(String accountNumber, String billSeq, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			Pagination pagination) {

		StringBuilder query = buildConditionQuery(Constants.LineItemView.MRC_HSD_CHARGE_LINE.getLineItemView(),
				accountNumber, billSeq, invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildHSDChargeLineItemQuery : " + query.toString());

		return query.toString();
	}

	private String buildHSDCreditLineItemQuery(String accountNumber, String billSeq, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			Pagination pagination) {

		StringBuilder query = buildConditionQuery(Constants.LineItemView.MRC_HSD_CREDIT_LINE.getLineItemView(),
				accountNumber, billSeq, invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildHSDCreditLineItemQuery : " + query.toString());

		return query.toString();
	}

	private String buildSuspendDormancyLineItemQuery(String accountNumber, String billSeq,
			FilterArrayElements[] filterArray, SortingArrayElements[] sortArray,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey, Pagination pagination) {

		StringBuilder query = buildConditionQueryForSuspendDormancy(
				Constants.LineItemView.MRC_SUSPENDDORMANCY_LINE.getLineItemView(), accountNumber, billSeq,
				invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildSuspendDormancyLineItemQuery : " + query.toString());

		return query.toString();
	}

	private String buildNonLTEPenaltyLineItemQuery(String accountNumber, String billSeq,
			FilterArrayElements[] filterArray, SortingArrayElements[] sortArray,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey, Pagination pagination) {

		StringBuilder query = buildConditionQuery(Constants.LineItemView.MRC_NONLTEPENALTY_LINE.getLineItemView(),
				accountNumber, billSeq, invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildNonLTEPenaltyLineItemQuery : " + query.toString());
		return query.toString();
	}

	private String buildAccessFeeLineItemQuery(String accountNumber, String billSeq, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			Pagination pagination) {

		StringBuilder query = buildConditionQuery(Constants.LineItemView.MRC_ACCESSFEE_LINE.getLineItemView(),
				accountNumber, billSeq, invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildAccessFeeLineItemQuery : " + query.toString());
		return query.toString();
	}

	private String buildIMSIPenaltyLineItemQuery(String accountNumber, String billSeq,
			FilterArrayElements[] filterArray, SortingArrayElements[] sortArray,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey, Pagination pagination) {

		StringBuilder query = buildConditionQueryForIMSIPenality(accountNumber, billSeq);
		query = util.buildFilterQuery(filterArray, query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildIMSIPenaltyLineItemQuery : " + query.toString());
		return query.toString();
	}


	
	private StringBuilder buildConditionQueryForIMSIPenality(String accountNumber, String billSeq) {
		StringBuilder query = new StringBuilder();
    	String billDate = getBillDate(accountNumber,billSeq) ;
        query.append(" SELECT * FROM "+Constants.LineItemView.MRC_IMSIPENALTY_LINE.getLineItemView()+" ");
       
    	if(billDate != null && !billDate.trim().equals(""))
    	{
    		 query.append("WHERE BILL_DATE = TO_DATE( '"+billDate+"' , 'DD-MON-YY') ");
    	}
    	if(accountNumber != null && !accountNumber.trim().equals(""))
    	{
    		 query.append("AND ACCOUNT_NUM = '"+accountNumber+"' ");
    	}
    	
		
    	return query;
		
	}

	private String getBillDate(String accountNumber, String billSeq) {
		String billDate = null;
    	IrbClientParam[] params = new IrbClientParam[2];
    	params[0] = new IrbClientParam(1, accountNumber, Types.VARCHAR);
    	params[1] = new IrbClientParam(2, Integer.parseInt(billSeq), Types.INTEGER);
    	HashMapPlus results;
		try {
			results = util.executeQueryForItem(SQLStatements.GET_BILL_DATE_WITH_ACCOUNT_NUM, params, null);
			if(results != null && results.size() !=0) {
            	billDate = results.getString("BILL_DATE");
            }
		} catch (Exception e) {
			  e.printStackTrace();
		}
    	
		return billDate;
	}

	private String buildNUMIMSILineItemQuery(String billSeq, String planName,
	        FilterArrayElements [] filterArray,SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey, Pagination pagination) {
    	
    	 StringBuilder query = buildConditionQueryForNUMIMSI(planName,billSeq);
         query = util.buildFilterQuery(filterArray, query);
         totalCount = util.getTotalRowCount(query.toString());
         query = util.buildSortingQuery(sortArray, query);
         query = util.buildPaginationQuery(pagination, query);
         traceLog.traceFinest("End of the buildNUMIMSI1LineItemQuery : " + query.toString());
         return query.toString();
    }
    private StringBuilder buildConditionQueryForNUMIMSI( String planName, String billSeq) {
    	StringBuilder query = new StringBuilder();
    	String billDate = getBillDate(billSeq) ;
        query.append(" SELECT * FROM "+Constants.LineItemView.MRC_NUMIMSILINE_LINE.getLineItemView()+" ");
    	
    	if(billDate != null && !billDate.trim().equals(""))
    	{
    		 query.append("WHERE BILL_DATE = TO_DATE( '"+billDate+"' , 'DD-MON-YY') ");
    	}
    	if(planName != null && !planName.trim().equals(""))
    	{
    		 query.append("AND PLAN_NAME = '"+planName+"' ");
    	}
		
    	return query;
    
    }
	private String getBillDate(String billSeq) {
    	String billDate = null;
    	IrbClientParam[] params = new IrbClientParam[1];
    	params[0] = new IrbClientParam(1, Integer.parseInt(billSeq), Types.INTEGER);
    	HashMapPlus results;
		try {
			results = util.executeQueryForItem(SQLStatements.GET_BILL_DATE, params, null);
			if(results != null && results.size() !=0) {
            	billDate = results.getString("BILL_DATE");
            }
		} catch (Exception e) {
			  e.printStackTrace();
		}
    	
		return billDate;
    	
    }

	/*private String buildNUMIMSI10LineItemQuery(String accountNumber, String billSeq, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			Pagination pagination) {

		StringBuilder query = buildConditionQuery(Constants.LineItemView.MRC_NUMIMSI10_LINE.getLineItemView(),
				accountNumber, billSeq, invoiceLineItemDetailsKey);
		query = util.buildFilterQuery(filterArray, query);
		traceLog.traceFinest("query in buildfilter " + query);
		totalCount = util.getTotalRowCount(query.toString());
		query = util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildNUMIMSI10LineItemQuery : " + query.toString());
		return query.toString();
	}*/

	private void buildCDRDetailsKeyObject(CDRDetailsKey cdrKey, String column, String resultStr) {

		if (column.equals("COST_BAND")) {
			cdrKey.setCostBand(resultStr);
		} else if(column.equals("EVENT_CLASS")){
  		     cdrKey.setEventClass(resultStr);
  	     }else if (column.equals("DISCOUNT_NAME")) {
			cdrKey.setDiscountName(resultStr);
		} else if (column.equals("EVENT_TYPE_ID")) {
			cdrKey.setEventTypeID(Integer.parseInt(resultStr));
		} else if (column.equals("EVENT_SOURCE")) {
			cdrKey.setEventSource(resultStr);
		} else if (column.equals("EVENT_SEQ")) {
			cdrKey.setEventSeq(resultStr);
		} else if (column.equals("TECH_TYPE")) {
			cdrKey.setTechType(resultStr);
		} else if (column.equals("TLO_OBJECT_ID")) {
			cdrKey.setTLOObjectID(resultStr);
		} else if (column.equals("ROMER_FLAG")) {
			cdrKey.setRomerflag(resultStr);
		} else if (column.equals("CHARGING_RATE")) {
			cdrKey.setChargingRate(Double.parseDouble(resultStr));
		} else if (column.equals("BILLING_TARIFF_NAME")) {
			cdrKey.setBillingTariffName(resultStr);
		}

	}

	private StringBuilder buildConditionQuery(String view, String accountNumber, String billSeq,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey) {
		StringBuilder query = new StringBuilder();
		if (view != null && !view.trim().equals("")) {
			query.append(" SELECT * FROM " + view + " ");
		}
		if (accountNumber != null && !accountNumber.trim().equals("")) {
			query.append("WHERE ACCOUNT_NUM = '" + accountNumber + "' ");
		}
		if (billSeq != null && !billSeq.trim().equals("")) {
			query.append("AND BILL_SEQ = " + billSeq + " ");
		}
		if (invoiceLineItemDetailsKey != null) {

			if (invoiceLineItemDetailsKey.getPartnerName() != null
					&& !invoiceLineItemDetailsKey.getPartnerName().trim().equals("")) {
				query.append("AND PARTNER_NAME = '" + invoiceLineItemDetailsKey.getPartnerName() + "' ");
			}
			if (invoiceLineItemDetailsKey.getEventSumTypeIds() != null
					&& !invoiceLineItemDetailsKey.getEventSumTypeIds().trim().equals("")) {
				query.append("AND EVENT_SUMMARY_ID IN ('" + invoiceLineItemDetailsKey.getEventSumTypeIds() + "') ");
			}
			if (invoiceLineItemDetailsKey.getBillingTariffName() != null
					&& !invoiceLineItemDetailsKey.getBillingTariffName().trim().equals("")) {
				query.append("AND BILLING_TARIFF_NAME = '" + invoiceLineItemDetailsKey.getBillingTariffName() + "' ");
			}
			if (invoiceLineItemDetailsKey.getTLOObjectID() != null
					&& !invoiceLineItemDetailsKey.getTLOObjectID().trim().equals("")) {
				query.append("AND TLO_OBJECT_ID = '" + invoiceLineItemDetailsKey.getTLOObjectID() + "' ");
			}
			if (invoiceLineItemDetailsKey.getCostBandDesc() != null
					&& !invoiceLineItemDetailsKey.getCostBandDesc().trim().equals("")) {
				if (invoiceLineItemDetailsKey.getSectionType().trim().equalsIgnoreCase("USG")) {
					query.append("AND COST_BAND LIKE '" + invoiceLineItemDetailsKey.getCostBandDesc() + "' ");
				} else {
					query.append("AND COST_BAND = '" + invoiceLineItemDetailsKey.getCostBandDesc() + "' ");
				}
			}
			/*
			 * if (invoiceLineItemDetailsKey.getQuantity() != null &&
			 * !invoiceLineItemDetailsKey.getQuantity().trim().equals("")) {
			 * query.append("AND QUANTITY = '" +
			 * invoiceLineItemDetailsKey.getQuantity() + "' "); }
			 */
			query.append("AND CHARGING_RATE =  " + invoiceLineItemDetailsKey.getUnitPrice() + "  ");
		}
		return query;
	}

	private StringBuilder buildConditionQueryForSuspendDormancy(String view, String accountNumber, String billSeq,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey) {
		StringBuilder query = new StringBuilder();
		if (view != null && !view.trim().equals("")) {
			query.append(" SELECT * FROM " + view + " ");
		}
		if (accountNumber != null && !accountNumber.trim().equals("")) {
			query.append("WHERE ACCOUNT_NUM = '" + accountNumber + "' ");
		}
		if (billSeq != null && !billSeq.trim().equals("")) {
			query.append("AND BILL_SEQ = " + billSeq + " ");
		}
		if (invoiceLineItemDetailsKey != null) {

			if (invoiceLineItemDetailsKey.getBillingTariffName() != null
					&& !invoiceLineItemDetailsKey.getBillingTariffName().trim().equals("")) {
				query.append("AND BILLING_TARIFF_NAME = '" + invoiceLineItemDetailsKey.getBillingTariffName() + "' ");
			}
			if (invoiceLineItemDetailsKey.getTLOObjectID() != null
					&& !invoiceLineItemDetailsKey.getTLOObjectID().trim().equals("")) {
				query.append("AND TLO_OBJECT_ID = '" + invoiceLineItemDetailsKey.getTLOObjectID() + "' ");
			}
			if (invoiceLineItemDetailsKey.getEventClassPPA() != null
					&& !invoiceLineItemDetailsKey.getEventClassPPA().trim().equals("")) {
				query.append("AND UPPER(FEE_TYPE) = '"
						+ invoiceLineItemDetailsKey.getEventClassPPA().trim().toUpperCase() + "' ");
			}

		}
		return query;
	}
	
	private StringBuilder buildConditionQueryForActiveDays(String view, String accountNumber, String billSeq,
			InvoiceLineItemDetailsKey invoiceLineItemDetailsKey) {
		StringBuilder query = new StringBuilder();
		if (view != null && !view.trim().equals("")) {
			query.append(" SELECT * FROM " + view + " ");
		}
		if (accountNumber != null && !accountNumber.trim().equals("")) {
			query.append("WHERE ACCOUNT_NUM = '" + accountNumber + "' ");
		}
		if (billSeq != null && !billSeq.trim().equals("")) {
			query.append("AND BILL_SEQ = " + billSeq + " ");
		}
		if (invoiceLineItemDetailsKey != null) {
			
			if (invoiceLineItemDetailsKey.getPartnerName() != null
					&& !invoiceLineItemDetailsKey.getPartnerName().trim().equals("")) {
				query.append("AND PARTNER_NAME = '" + invoiceLineItemDetailsKey.getPartnerName() + "' ");
			}

			if (invoiceLineItemDetailsKey.getBillingTariffName() != null
					&& !invoiceLineItemDetailsKey.getBillingTariffName().trim().equals("")) {
				query.append("AND BILLING_TARIFF_NAME = '" + invoiceLineItemDetailsKey.getBillingTariffName() + "' ");
			}
			if (invoiceLineItemDetailsKey.getTLOObjectID() != null
					&& !invoiceLineItemDetailsKey.getTLOObjectID().trim().equals("")) {
				query.append("AND TLO_OBJECT_ID = '" + invoiceLineItemDetailsKey.getTLOObjectID() + "' ");
			}
			if (invoiceLineItemDetailsKey.getDescription() != null
					&& !invoiceLineItemDetailsKey.getDescription().trim().equals("")) {
				String indicator = (invoiceLineItemDetailsKey.getDescription().trim().toUpperCase().contains("PARTIAL")) ? "PARTIAL" : "WHOLE";
				query.append("AND FLAG = '" + indicator + "' ");
			}

		}
		return query;
	}

}
