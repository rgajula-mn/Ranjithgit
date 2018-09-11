package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;

public class QueryPatnerBillingandFinanceDataDao {

	private static TraceLog traceLog = new TraceLog(QueryPatnerBillingandFinanceDataDao.class);
	private Util util;
	private int totalCount = 0;

	public QueryPartnerBillingAndFinanceOutPutElements queryPatnerBillingandFinanceData(

			IntegratorContext integratorContext,

			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput)
			throws NullParameterException {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;
		traceLog.traceFinest("Entered into queryPatnerBillingandFinanceData API...startTime " + startTime);

		QueryPatnerBillingandFinanceDataInput queryPatnerBillingandFinanceDataInput = new QueryPatnerBillingandFinanceDataInput();
		QueryPatnerBillingandFinanceDataOutput queryPatnerBillingandFinanceDataOutput = new QueryPatnerBillingandFinanceDataOutput();

		QueryPartnerBillingAndFinanceOutPutElements outPutResult = new QueryPartnerBillingAndFinanceOutPutElements();
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("Entered into queryPatnerBillingandFinanceData API "
					+ queryPartnerBillingAndFinanceInput.getQueryType());
		}
		if (integratorContext == null || integratorContext.equals("")) {

			throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_PBF_API_NAME);
		}
		if (integratorContext.getExternalBusinessTransactionId() == null
				|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {

			throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.QUERY_PBF_API_NAME);
		}

		if (queryPartnerBillingAndFinanceInput == null || queryPartnerBillingAndFinanceInput.equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_8001, Constants.QUERY_PBF_API_NAME);
		}
		queryPatnerBillingandFinanceDataInput.setIntegratorContext(integratorContext);
		queryPatnerBillingandFinanceDataInput.setQueryPartnerBillingAndFinanceInput(queryPartnerBillingAndFinanceInput);
		try {

			outPutResult = queryPartnerBillingAndFinance(integratorContext, queryPartnerBillingAndFinanceInput);
			queryPatnerBillingandFinanceDataOutput.setQueryPartnerBillingAndFinanceOutPut(outPutResult);
			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after queryPatnerBillingandFinanceData.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of queryPatnerBillingandFinanceData is " + diff + "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("Before calling thread to writelog.... ");
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					queryPatnerBillingandFinanceDataInput, queryPatnerBillingandFinanceDataOutput, responseStatus,
					Constants.QUERY_PBF_API_NAME, das, diffStr, node);
			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("After calling thread to writelog.... ");

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside queryPartnerBillingAndFinanceData:: " + e.getMessage());
			responseStatus = e.getMessage();

			
			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("Before calling thread to writelog....Catch ");
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
			queryPatnerBillingandFinanceDataInput, queryPatnerBillingandFinanceDataOutput, responseStatus,
			Constants.QUERY_PBF_API_NAME, das, diffStr, node);			
			
			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("After calling thread to writelog....Catch ");
			

		}

		if (traceLog.isFinerEnabled())
			traceLog.traceFinest("Stmt before returning response....");
		return outPutResult;
	}

	/**
	 * 
	 * @param integratorContext
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */

	private QueryPartnerBillingAndFinanceOutPutElements queryPartnerBillingAndFinance(
			IntegratorContext integratorContext,
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput) {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside queryPartnerBillingAndFinance");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;

		QueryPartnerBillingAndFinanceOutPutElements queryOutput = new QueryPartnerBillingAndFinanceOutPutElements();
		try {
			conn = util.getDataSource().getConnection();
			pstmt = conn.prepareStatement(SQLStatements.QUERY_VIEW);

			if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.ADJUSTMENTS) {
				pstmt.setString(1, "TMO_ADJUSTMENT_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.ADJUSTMENT_TYPES) {
				pstmt.setString(1, "TMO_ADJUSTMENT_TYPEVIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.BILLING_HISTORY) {
				pstmt.setString(1, "TMO_BILLINGHISTORY_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.CCPC) {
				pstmt.setString(1, "TMO_CCPC_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.EVENT_TYPES) {
				pstmt.setString(1, "TMO_EVENTTYPES_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.GL_ACCOUNT) {
				pstmt.setString(1, "TMO_GLACCOUNT_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.PAYMENTS) {
				pstmt.setString(1, "TMO_PAYMENT_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.PROMOTIONS_AND_DISCOUNTS) {
				pstmt.setString(1, "TMO_PROMOTIONDISCOUNT_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.TAX_EXEMPTIONS) {
				pstmt.setString(1, "TMO_TAXEXEMPTION_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.SKF_CATEGORY) {
				pstmt.setString(1, "TMO_SKFCATEGORY_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.GL_ADJUST_TYPE_MAPPING) {
				pstmt.setString(1, "TMO_GLADJUSTTYPEMAPPING_VIEW");
			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.INVOICE_HISTORY) {
				pstmt.setString(1, "TMO_BILLING_HISTORY_VIEW");
			}
			else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.PAYMENT_CHANNELS) {
                pstmt.setString(1, "TMO_PAYMENT_CHANNELS_VIEW");
            }
			else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.TAX_EXEMPTION_TYPE) {
                pstmt.setString(1, "TMO_TAX_EXEMPTIONTYPE_VIEW");
            }
			else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.ACCT_EXEMPTION) {
                pstmt.setString(1, "TMO_ACCT_EXEMPTION_VIEW");
            }

			traceLog.traceFinest("QUERY_VIEW " + pstmt.toString());
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

			colArr = (Column[]) resultColumnList.toArray(new Column[resultColumnList.size()]);
			queryOutput.setColumnArray(colArr);
			traceLog.traceFinest("queryOutput " + queryOutput.getColumnArray());

			resultList = getResult(conn, resultColumnList, queryPartnerBillingAndFinanceInput, colArr);

			queryOutput.setTotalRowsCount(String.valueOf(totalCount));
			resultArr = new ResultSetArray[resultList.size()];
			for (int k = 0; k < resultList.size(); k++) {
				resultArr[k] = new ResultSetArray();
				resultArr[k].setResult(resultList.get(k));
			}
			queryOutput.setResultSetArray(resultArr);
			/*
			 * 
			 * for (int j = 0; j < queryOutput.getColumnArray().length; j++) {
			 * traceLog.traceFinest("getColumnArray " +
			 * queryOutput.getColumnArray()[j]); }
			 * 
			 * for (int j = 0; j < queryOutput.getResultSetArray().length; j++)
			 * { traceLog.traceFinest ("getResultSetArray " +
			 * queryOutput.getResultSetArray()[j]); }
			 */

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside queryPartnerBillingAndFinance:: " + e.getMessage());
			e.printStackTrace();
		} finally {
			util.closeResources(resultSet, conn, pstmt, null);
		}
		return queryOutput;
	}

	/**
	 * 
	 * @param conn
	 * @param column
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */
	private List<String> getResult(Connection conn, List<Column> column,
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput, Column[] colArr) {
		String resultStr = null;
		String resultStr1 = null;

		PreparedStatement pstmt2 = null;
		ResultSet resultSet1 = null;
		List<String> resultList = new ArrayList<String>();
		String queryFinanceDataSql = null;
		try {

			if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.ADJUSTMENTS) {
				queryFinanceDataSql = buildAdustmentQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.ADJUSTMENT_TYPES) {
				queryFinanceDataSql = buildAdustmentTypeQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.BILLING_HISTORY) {
				queryFinanceDataSql = buildBillingHistory(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.CCPC) {
				traceLog.traceFinest("Calling the buildCCPCQuery");
				queryFinanceDataSql = buildCCPCQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.EVENT_TYPES) {
				traceLog.traceFinest("Calling the buildEventTypesQuery");
				queryFinanceDataSql = buildEventTypesQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.GL_ACCOUNT) {
				traceLog.traceFinest("Calling the buildGLAccountQuery");
				queryFinanceDataSql = buildGLAccountQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.PAYMENTS) {
				queryFinanceDataSql = buildPaymentQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.TAX_EXEMPTIONS) {
				queryFinanceDataSql = buildTaxExemptionQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.PROMOTIONS_AND_DISCOUNTS) {
				traceLog.traceFinest("Calling the buildPromotionDiscountQuery");
				queryFinanceDataSql = buildPromotionDiscountQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.SKF_CATEGORY) {
				traceLog.traceFinest("Calling the buildSKFCategoryQuery");
				queryFinanceDataSql = buildSKFCategoryQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.GL_ADJUST_TYPE_MAPPING) {
				traceLog.traceFinest("Calling the buildGLAdjustTypeMappingQuery");
				queryFinanceDataSql = buildGLAdjustTypeMappingQuery(queryPartnerBillingAndFinanceInput, colArr);

			} else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.INVOICE_HISTORY) {
				traceLog.traceFinest("Calling the buildBillingHistory for Invoice history");
				queryFinanceDataSql = buildBillingHistoryPlus(queryPartnerBillingAndFinanceInput, colArr);

			}
			else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.PAYMENT_CHANNELS) {
                traceLog.traceFinest("Calling the buildPaymentChannelsQuery");
                queryFinanceDataSql = buildPaymentChannelsQuery(queryPartnerBillingAndFinanceInput,colArr);

            } 			
			else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.TAX_EXEMPTION_TYPE) {
				traceLog.traceFinest("Calling the buildTaxExemptionQuery2");
				queryFinanceDataSql = buildTaxExemptionQuery2(queryPartnerBillingAndFinanceInput,colArr);
                
            }
			else if (queryPartnerBillingAndFinanceInput.getQueryType() == EnumQueryType.ACCT_EXEMPTION) {
				traceLog.traceFinest("Calling the buildAcctExemptionQuery");
				queryFinanceDataSql = buildAcctExemptionQuery(queryPartnerBillingAndFinanceInput,colArr);
                
            }
			

			traceLog.traceFinest("The Query executing queryFinanceDataSql is: " + queryFinanceDataSql);
			pstmt2 = conn.prepareStatement(queryFinanceDataSql);

			resultSet1 = pstmt2.executeQuery();

			while (resultSet1.next()) {

				for (int i = 0; i < column.size(); i++) {

					resultStr = resultSet1.getString(column.get(i).getName());
					if (resultStr == null || resultStr == "") {
						resultStr = "";
					}
					// traceLog.traceFinest("resultStr 1234 " + resultStr);

					if (resultStr1 != null) {

						// traceLog.traceFinest("resultStr 12345 " +
						// resultStr1);

						if (i < column.size() - 1) {

							resultStr1 = resultStr1 + "'" + resultStr + "'|";
						} else {
							resultStr1 = resultStr1 + "'" + resultStr + "'";
						}
						// traceLog.traceFinest("resultStr 123456 " +
						// resultStr1);
					} else {
						if(column.size()==1)
						resultStr1 = "'" + resultStr + "'";
						else
						resultStr1 = "'" + resultStr + "'|";

						// traceLog.traceFinest("resultStr 12345678 " +
						// resultStr1);
					}
				}
				resultList.add(resultStr1);
				resultStr1 = null;
			}
		} catch (Exception ex) {
			traceLog.traceFinest("Exception from  getResult: " + ex.getMessage());
			ex.printStackTrace();
		} finally {
			util.closeResources(resultSet1, conn, pstmt2, null);
		}
		traceLog.traceFinest(" Result list before return " + resultList.toString());
		return resultList;

	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */
	private String buildAdustmentQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {

		traceLog.traceFinest("Entering into buildAdustmentQuery : ");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_ADJUSTMENT_VIEW ")

				.append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);

		traceLog.traceFinest("End of the buildAdustmentQuery : " + query.toString());

		return query.toString();
	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */
	private String buildAdustmentTypeQuery(
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput, Column[] colArr) {
		traceLog.traceFinest("START of the buildAdustmentTypeQuery");
		StringBuilder query = new StringBuilder();

		query.append("SELECT * FROM TMO_ADJUSTMENT_TYPEVIEW ").append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildAdustmentTypeQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);
		traceLog.traceFinest("IN buildAdustmentTypeQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildAdustmentTypeQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildAdustmentTypeQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildAdustmentTypeQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */
	private String buildBillingHistory(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_BILLINGHISTORY_VIEW ")

				.append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);

		traceLog.traceFinest("End of the buildBillingHistory : " + query.toString());

		return query.toString();
	}

	/**
	 * Building the Query for the CCPCQuery View TMO_CCPC_VIEW
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @return String
	 * 
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private String buildCCPCQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		traceLog.traceFinest("START of the buildCCPCQuery");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_CCPC_VIEW ");

		boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

		query = buildFilter(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildCCPCQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag);
		traceLog.traceFinest("IN buildCCPCQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildCCPCQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildCCPCQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildCCPCQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * Building the Query for the EventTypes View TMO_EVENTTYPES_VIEW
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @return String
	 * 
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private String buildEventTypesQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		traceLog.traceFinest("START of the buildEventTypesQuery");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_EVENTTYPES_VIEW ");

		boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

		query = buildFilter(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildEventTypesQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag);
		traceLog.traceFinest("IN buildEventTypesQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildEventTypesQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildEventTypesQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildEventTypesQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * Building the Query for the GLAccount View TMO_GLACCOUNT_VIEW
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @return String
	 * 
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private String buildGLAccountQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		traceLog.traceFinest("START of the buildGLAccountQuery");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_GLACCOUNT_VIEW ");

		boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

		query = buildFilter(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildGLAccountQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag);
		traceLog.traceFinest("IN buildGLAccountQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildGLAccountQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildGLAccountQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildGLAccountQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */
	private String buildPaymentQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_PAYMENT_VIEW ")

				.append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);

		traceLog.traceFinest("End of the buildPaymentQuery : " + query.toString());

		return query.toString();
	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @author sjoshi1
	 * @return
	 */
	private String buildTaxExemptionQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_TAXEXEMPTION_VIEW ")

				.append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);

		traceLog.traceFinest("End of the buildTaxExemptionQuery : " + query.toString());
		return query.toString();
	}

	/**
	 * Building the Query for the PromotionDiscount View
	 * TMO_PROMOTIONDISCOUNT_VIEW
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @return String
	 * 
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private String buildPromotionDiscountQuery(
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput, Column[] colArr) {
		traceLog.traceFinest("START of the buildPromotionDiscountQuery");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_PROMOTIONDISCOUNT_VIEW ");

		boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

		query = buildFilter(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildPromotionDiscountQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag);
		traceLog.traceFinest("IN buildPromotionDiscountQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildPromotionDiscountQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildPromotionDiscountQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildPromotionDiscountQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * Building the Query for the GLAdjustTypeMapping View
	 * TMO_GLADJUSTTYPEMAPPING_VIEW
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @return String
	 * 
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private String buildGLAdjustTypeMappingQuery(
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput, Column[] colArr) {
		traceLog.traceFinest("START of the buildGLAdjustTypeMappingQuery");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_GLADJUSTTYPEMAPPING_VIEW ");

		boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

		query = buildFilter(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildGLAdjustTypeMappingQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag);
		traceLog.traceFinest("IN buildGLAdjustTypeMappingQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildGLAdjustTypeMappingQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildGLAdjustTypeMappingQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildGLAdjustTypeMappingQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * Building the Query for the SKFCategory View TMO_SKFCATEGORY_VIEW
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @return String
	 * 
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private String buildSKFCategoryQuery(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			Column[] colArr) {
		traceLog.traceFinest("START of the buildSKFCategoryQuery");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMO_SKFCATEGORY_VIEW ");

		boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

		query = buildFilter(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildSKFCategoryQuery buildFilter : " + query.toString());

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag);
		traceLog.traceFinest("IN buildSKFCategoryQuery buildSearch : " + query.toString());

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);
		traceLog.traceFinest("IN buildSKFCategoryQuery buildSorting : " + query.toString());

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);
		traceLog.traceFinest("IN buildSKFCategoryQuery buildPagination : " + query.toString());

		traceLog.traceFinest("END of the buildSKFCategoryQuery Final : " + query.toString());
		return query.toString();
	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @author paku0216
	 * @return
	 */
	private String buildBillingHistoryPlus(
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput, Column[] colArr) {
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMOBILE_CUSTOM.TMO_BILLING_HISTORY_VIEW ")

				.append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);

		traceLog.traceFinest("End of the buildBillingHistory : " + query.toString());

		return query.toString();
	}

	/**
	 * This method builds the Search Criteria
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @param query
	 * @param flag
	 * @return StringBuilder
	 * 
	 * @author sgad2315(Sreekanth Gade)
	 */
	private StringBuilder buildSearch(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			StringBuilder query, boolean flag) {

		if (queryPartnerBillingAndFinanceInput.getSearchFilter() != null
				&& queryPartnerBillingAndFinanceInput.getSearchFilter().length > 0) {
			int counter = queryPartnerBillingAndFinanceInput.getSearchFilter().length;
			if (flag) {
				query.append(" AND ");
			} else {
				query.append(" WHERE ");
			}

			for (int i = 0; i < queryPartnerBillingAndFinanceInput.getSearchFilter().length; i++) {
				if (counter > 1) {
					query.append(queryPartnerBillingAndFinanceInput.getSearchFilter()[i].getColumnName() + " like '%"
							+ queryPartnerBillingAndFinanceInput.getSearchFilter()[i].getSearchText() + "%' OR ");
				} else {
					query.append(queryPartnerBillingAndFinanceInput.getSearchFilter()[i].getColumnName() + " like '%"
							+ queryPartnerBillingAndFinanceInput.getSearchFilter()[i].getSearchText() + "%' ");
				}
				counter--;
			}
		}
		return query;
	}

	/**
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @param query
	 * @author sjoshi1
	 * @return
	 */
	private StringBuilder buildFilterWithDate(
			QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput, StringBuilder query) {
		traceLog.traceFinest("started the buildFilterWithDate : " + query.toString());
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length != 0) {
			try {
				for (int i = 0; i < queryPartnerBillingAndFinanceInput.getFilterArray().length; i++) {

					query.append(" AND ");
					if (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator()
							.equalsIgnoreCase("between")
							|| queryPartnerBillingAndFinanceInput.getFilterArray()[i]
									.getDateNullCondNbl() == EnumDateNullCond.NA
							|| queryPartnerBillingAndFinanceInput.getFilterArray()[i]
									.getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
							|| queryPartnerBillingAndFinanceInput.getFilterArray()[i]
									.getDateNullCondNbl() == EnumDateNullCond.BOTH) {
						boolean isDateNull = false;
						if (queryPartnerBillingAndFinanceInput.getFilterArray()[i]
								.getDateNullCondNbl() == EnumDateNullCond.NA) {
							isDateNull = true;
						}
						if (isDateNull
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() == null
										|| queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().trim()
												.isEmpty())
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() == null
										|| queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2()
												.isEmpty())) {// NA-1
							query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
									+ " IS NULL ");
						} else if (queryPartnerBillingAndFinanceInput.getFilterArray()[i]
								.getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() == null
										|| queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().trim()
												.isEmpty())
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() == null) {// withDate-2
							query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
									+ " IS NOT NULL ");
						} else if (isDateNull
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() != null
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() == null) {// NA-3.1
							query.append(
									" (TRUNC( " + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " >= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1()
											+ "' ,'yyyy/mm/dd')) OR "
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " IS NULL ");
						} else if (isDateNull
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() == null
										|| queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().trim()
												.isEmpty())
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() != null) {// NA-3.2
							query.append(
									" (TRUNC( " + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " <= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2()
											+ "' ,'yyyy/mm/dd')) OR "
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " IS NULL ");
						} else if (isDateNull
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() != null
										|| !queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().trim()
												.isEmpty())
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() != null) {// NA-3.3
							query.append(
									" (TRUNC( " + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " >= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1()
											+ "' ,'yyyy/mm/dd') AND " + " TRUNC( "
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " <= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2()
											+ "' ,'yyyy/mm/dd') OR "
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " IS NULL ) ");
						} else if (queryPartnerBillingAndFinanceInput.getFilterArray()[i]
								.getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() != null
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() == null) {// 4.1
							query.append(
									" TRUNC( " + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " >= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1()
											+ "' ,'yyyy/mm/dd') ");
						} else if (queryPartnerBillingAndFinanceInput.getFilterArray()[i]
								.getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() == null
										|| queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().trim()
												.isEmpty())
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() != null) {// 4.2
							query.append(
									" TRUNC( " + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " <= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2()
											+ "' ,'yyyy/mm/dd') ");
						} else if (queryPartnerBillingAndFinanceInput.getFilterArray()[i]
								.getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
								&& (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() != null
										|| !queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().trim()
												.isEmpty())
								&& queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2() != null) {// 4.3
							query.append(
									" (TRUNC( " + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " >= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1()
											+ "' ,'yyyy/mm/dd') AND " + " TRUNC( "
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
											+ " ) " + " <= TO_DATE('"
											+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2()
											+ "' ,'yyyy/mm/dd')) ");
						} else if (queryPartnerBillingAndFinanceInput.getFilterArray()[i]
								.getDateNullCondNbl() == EnumDateNullCond.BOTH) {
							query.append(" (" + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
									+ " IS NULL OR "
									+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName()
									+ " IS NOT NULL)");
						}
					} /*
						 * if
						 * (!queryPartnerBillingAndFinanceInput.getFilterArray()
						 * [i].getValue2().trim().isEmpty() &&
						 * queryPartnerBillingAndFinanceInput.getFilterArray()[i
						 * ].getValue2() != null) { traceLog.traceFinest(
						 * "queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue2()"
						 * ); query.append(queryPartnerBillingAndFinanceInput.
						 * getFilterArray()[i] .getColumnName() + " " +
						 * queryPartnerBillingAndFinanceInput.getFilterArray()[
						 * i] .getReOperator()); query.append(" TO_DATE('" +
						 * queryPartnerBillingAndFinanceInput.getFilterArray()[i
						 * ].getValue1() + "' ,'yyyy/mm/dd')" + "AND TO_DATE ('"
						 * +
						 * queryPartnerBillingAndFinanceInput.getFilterArray()[i
						 * ].getValue2() + "' ,'yyyy/mm/dd')");
						 * 
						 * }
						 */else if (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator()
							.equalsIgnoreCase("LIKE")) {
						query.append(" Upper(");
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + ") "
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator() + " ");
						query.append(
								"'%" + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().toUpperCase()
										+ "%'");
					} else {
						String enumValues[] = util.getSearchedEnumType(
								queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1());
						if (enumValues != null && enumValues.length > 0) {
							query.append(" Upper(");
							query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + ") ");
							query.append("in ('");
							boolean flag = false;
							for (String s : enumValues) {
								if (flag) {
									query.append("','");
								}
								query.append(s.toUpperCase());
								flag = true;
							}
							query.append("') ");
						} else {
							query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + " "
									+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator() + " ");
							query.append(
									"'" + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() + "'");
						}
					}
				}
			} catch (Exception e) {
				traceLog.traceFinest("Error occured in buildFilterWithDate method " + e.getMessage());
				e.printStackTrace();
			}
		}
		traceLog.traceFinest("ended the buildFilterWithDate : " + query.toString());
		return query;
	}

	/**
	 * This method builds the Sorting Query
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @param query
	 * @return StringBuilder
	 * 
	 * @author sgad2315(Sreekanth Gade)
	 */
	private StringBuilder buildSorting(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			StringBuilder query, Column[] colArr) {
		if (queryPartnerBillingAndFinanceInput.getSortingArray() != null
				&& queryPartnerBillingAndFinanceInput.getSortingArray().length > 0) {
			int counter = queryPartnerBillingAndFinanceInput.getSortingArray().length;
			query.append(" ORDER BY ");

			for (int i = 0; i < queryPartnerBillingAndFinanceInput.getSortingArray().length; i++) {
				if (counter > 1) {
					String dataType = null;
					for (int j = 0; j < colArr.length; j++) {
						Column col = colArr[j];
						if (col.getName()
								.equals(queryPartnerBillingAndFinanceInput.getSortingArray()[i].getColumnName())) {
							dataType = col.getType();
							traceLog.traceFinest("Find Column data type before sorting..inside if** " + dataType);
						}
					}
					traceLog.traceFinest("Find Column data type before sorting..after for** " + dataType);

					if (!(dataType.equalsIgnoreCase("NUMBER") || dataType.equalsIgnoreCase("DATE"))) {
						traceLog.traceFinest("Add upper as we found Column data type ** " + dataType);
						query.append("UPPER(replace(");

						query.append(
								queryPartnerBillingAndFinanceInput.getSortingArray()[i].getColumnName() + ", ' ', '')) "
										+ queryPartnerBillingAndFinanceInput.getSortingArray()[i].getOrder() + " ,");
					} else {
						query.append(queryPartnerBillingAndFinanceInput.getSortingArray()[i].getColumnName() + " "
								+ queryPartnerBillingAndFinanceInput.getSortingArray()[i].getOrder() + " ,");
					}

				} else {
					String dataType = null;
					for (int j = 0; j < colArr.length; j++) {
						Column col = colArr[j];
						if (col.getName()
								.equals(queryPartnerBillingAndFinanceInput.getSortingArray()[i].getColumnName())) {
							dataType = col.getType();
							traceLog.traceFinest("Find Column data type before sorting..inside if**** " + dataType);
						}
					}
					traceLog.traceFinest("Find Column data type before sorting..after for** " + dataType);
					if (!(dataType.equalsIgnoreCase("NUMBER") || dataType.equalsIgnoreCase("DATE"))) {
						traceLog.traceFinest("Add upper as we found Column data type **** " + dataType);
						query.append("UPPER(replace(");
						query.append(
								queryPartnerBillingAndFinanceInput.getSortingArray()[i].getColumnName() + ", ' ', '')) "
										+ queryPartnerBillingAndFinanceInput.getSortingArray()[i].getOrder() + " ");
					} else {
						query.append(queryPartnerBillingAndFinanceInput.getSortingArray()[i].getColumnName() + " "
								+ queryPartnerBillingAndFinanceInput.getSortingArray()[i].getOrder() + " ");

					}

				}
				counter--;
			}
		}
		return query;
	}

	/**
	 * This method builds the Pagination Query
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @param query
	 * @return StringBuilder
	 * 
	 * @author sgad2315(Sreekanth Gade)
	 */
	private StringBuilder buildPagination(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			StringBuilder query) {

		if (queryPartnerBillingAndFinanceInput.getPagination() != null
				&& queryPartnerBillingAndFinanceInput.getPagination().getOffSetStartNbl() >= 0
				&& queryPartnerBillingAndFinanceInput.getPagination().getOffSetEndNbl() > 0) {
			query.append(" OFFSET " + queryPartnerBillingAndFinanceInput.getPagination().getOffSetStartNbl()
					+ " ROWS FETCH NEXT " + queryPartnerBillingAndFinanceInput.getPagination().getOffSetEndNbl()
					+ " ROWS ONLY");
		}
		return query;
	}

	/**
	 * This Method builds the Filter Query
	 * 
	 * @param queryPartnerBillingAndFinanceInput
	 * @param query
	 * @return StringBuilder
	 * 
	 * @author sgad2315(Sreekanth Gade)
	 */
	private StringBuilder buildFilter(QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,
			StringBuilder query) {

		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {

			int counter = queryPartnerBillingAndFinanceInput.getFilterArray().length;
			for (int i = 0; i < queryPartnerBillingAndFinanceInput.getFilterArray().length; i++) {
				if (queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator().equalsIgnoreCase("LIKE")) {
					query.append(" Upper(");
					if (counter > 1) {
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + ") "
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator() + " ");
						query.append(
								"'%" + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().toUpperCase()
										+ "%' AND ");
					} else {
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + ") "
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator() + " ");
						query.append(
								"'%" + queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1().toUpperCase()
										+ "%' ");
					}
					counter--;
				} else if (counter > 1) {
					String enumValues[] = util
							.getSearchedEnumType(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1());
					if (enumValues != null && enumValues.length > 0) {
						query.append(" Upper(");
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + ") ");
						query.append("in ('");
						boolean flag = false;
						for (String s : enumValues) {
							if (flag) {
								query.append("','");
							}
							query.append(s.toUpperCase());
							flag = true;
						}
						query.append("') AND ");
					} else {
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + " "
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator() + " '"
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() + "' AND ");
					}
				} else {
					String enumValues[] = util
							.getSearchedEnumType(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1());
					if (enumValues != null && enumValues.length > 0) {
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + " ");
						query.append("in ('");
						boolean flag = false;
						for (String s : enumValues) {
							if (flag) {
								query.append("','");
							}
							query.append(s);
							flag = true;
						}
						query.append("') ");
					} else {
						query.append(queryPartnerBillingAndFinanceInput.getFilterArray()[i].getColumnName() + " "
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getReOperator() + " '"
								+ queryPartnerBillingAndFinanceInput.getFilterArray()[i].getValue1() + "' ");
					}
				}
				counter--;
			}
		}

		return query;
	}
	private String buildPaymentChannelsQuery(
            QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,Column[] colArr) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT * FROM TMOBILE_CUSTOM.TMO_PAYMENT_CHANNELS_VIEW ");
        
        boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

        
        query = buildFilter(queryPartnerBillingAndFinanceInput, query);

        query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag); //true

        totalCount = util.getTotalRowCount(query.toString());
        
        query = buildSorting(queryPartnerBillingAndFinanceInput, query,colArr);

        query = buildPagination(queryPartnerBillingAndFinanceInput, query);

        traceLog.traceFinest("End of the buildPaymentChannelsQuery method : " + query.toString());

        return query.toString();
    }
	
	private String buildTaxExemptionQuery2(
            QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,Column[] colArr) {
        StringBuilder query = new StringBuilder();
        query.append("SELECT * FROM TMOBILE_CUSTOM.TMO_TAX_EXEMPTIONTYPE_VIEW ");
        
        boolean flag = false;
		if (queryPartnerBillingAndFinanceInput.getFilterArray() != null
				&& queryPartnerBillingAndFinanceInput.getFilterArray().length > 0) {
			query.append(" WHERE ");
			flag = true;
		}

        
        query = buildFilter(queryPartnerBillingAndFinanceInput, query);

        query = buildSearch(queryPartnerBillingAndFinanceInput, query, flag); //true

        totalCount = util.getTotalRowCount(query.toString());
        
        query = buildSorting(queryPartnerBillingAndFinanceInput, query,colArr);

        query = buildPagination(queryPartnerBillingAndFinanceInput, query);

        traceLog.traceFinest("End of the buildTaxExemptionQuery2 method : " + query.toString());

        return query.toString();       
        
        
    }

	private String buildAcctExemptionQuery(
            QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput,Column[] colArr) {
                
        StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM TMOBILE_CUSTOM.TMO_ACCT_EXEMPTION_VIEW ")

				.append("WHERE CUSTOMER_REF =  ");
		query.append("'" + queryPartnerBillingAndFinanceInput.getCustomerReference() + "'");

		query = buildFilterWithDate(queryPartnerBillingAndFinanceInput, query);

		query = buildSearch(queryPartnerBillingAndFinanceInput, query, true);

		totalCount = util.getTotalRowCount(query.toString());

		query = buildSorting(queryPartnerBillingAndFinanceInput, query, colArr);

		query = buildPagination(queryPartnerBillingAndFinanceInput, query);

		traceLog.traceFinest("End of the buildAcctExemptionQuery : " + query.toString());

		return query.toString();
        
    }


	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}
}
