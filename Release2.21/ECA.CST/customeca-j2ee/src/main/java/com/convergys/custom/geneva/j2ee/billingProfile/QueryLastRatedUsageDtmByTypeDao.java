package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import com.convergys.platform.ApplicationException;

import oracle.jdbc.OracleTypes;

public class QueryLastRatedUsageDtmByTypeDao {

	private static TraceLog traceLog = new TraceLog(QueryLastRatedUsageDtmByTypeDao.class);
	private Util util;

	/**
	 * This method is to query the last rated usage date and time by usage type
	 * for a ‘SUBSCRIBER’
	 * 
	 * @param integratorContext
	 * @param msisdn
	 * @param accountNum
	 * @return QueryLastRatedUsageDtmByTypeResult[] Array
	 * @throws java.rmi.RemoteException
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @author sgad2315 (Sreekanth Gade)
	 */
	public com.convergys.custom.geneva.j2ee.billingProfile.QueryLastRatedUsageDtmByTypeResult[] queryLastRatedUsageDtmByType(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String msisdn, java.lang.String accountNum)
			throws java.rmi.RemoteException, com.convergys.iml.commonIML.NullParameterException,
			com.convergys.platform.ApplicationException, com.convergys.iml.commonIML.ParameterException {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("Entered into queryLastRatedUsageDtmByType API...startTime.. " + startTime);
		}

		traceLog.traceFinest("Entered into queryLastRatedUsageDtmByType API");

		QueryLastRatedUsageDtmByTypeResult[] queryLastRatedUsageDtmByTypeResultArray = null;
		DataSource das = null;
		String responseStatus = null;
		QueryLastRatedUsageDtmByTypeOutput queryLastRatedUsageDtmByTypeOutput = new QueryLastRatedUsageDtmByTypeOutput();
		QueryLastRatedUsageDtmByTypeInput queryLastRatedUsageDtmByTypeInput = new QueryLastRatedUsageDtmByTypeInput();
		queryLastRatedUsageDtmByTypeInput.setIntegratorContext(integratorContext);
		queryLastRatedUsageDtmByTypeInput.setMSISDN(msisdn);
		queryLastRatedUsageDtmByTypeInput.setAccountNum(accountNum);

		try {
			traceLog.traceFinest("Entered into queryLastRatedUsageDtmByType API");

			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_RATED_USAGE_API_NAME);
			}

			///////////////////////////////////////////
			if (integratorContext.getExternalAPICallId() != null
					&& !integratorContext.getExternalAPICallId().isEmpty()) {
				traceLog.traceFinest(
						"integratorContext.getExternalAPICallId() " + integratorContext.getExternalAPICallId());
				integratorContext.setExternalAPICallId(null);
				traceLog.traceFinest(
						"integratorContext.getExternalAPICallId() " + integratorContext.getExternalAPICallId());
			}
			////////////////////////////////////////////

			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.QUERY_RATED_USAGE_API_NAME);
			}

			if (msisdn == null || msisdn.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_3001, Constants.QUERY_RATED_USAGE_API_NAME);
			}

			das = util.getDataSource();
			traceLog.traceFinest("Executing getLastRatedUsageStoredProc");
			List<QueryLastRatedUsageDtmByTypeResult> lastRatedUsageList = getLastRatedUsageStoredProc(msisdn,
					accountNum);
			traceLog.traceFinest("Executed getLastRatedUsageStoredProc");

			if (lastRatedUsageList != null && lastRatedUsageList.size() > 0) {
				traceLog.traceFinest("The lastRatedUsageList is NOT NULL ");
				queryLastRatedUsageDtmByTypeResultArray = lastRatedUsageList
						.toArray(new QueryLastRatedUsageDtmByTypeResult[lastRatedUsageList.size()]);

				responseStatus = Constants.TRANSACTION_SUCCESS;
				queryLastRatedUsageDtmByTypeOutput
						.setQueryLastRatedUsageDtmByTypeOutput(queryLastRatedUsageDtmByTypeResultArray);

			} else {
				traceLog.traceFinest("The lastRatedUsageList is NULL ");
				responseStatus = Constants.TRANSACTION_SUCCESS;
			}

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after queryLastratedUsage.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of queryLastRatedUsage is " + diff + "........." + diffStr);

			// return queryLastRatedUsageDtmByTypeResultArray;

		} catch (Exception ex) {
			responseStatus = ex.getMessage();
			traceLog.traceFinest("Exception from  queryLastRatedUsageDtmByType API : " + ex.getMessage());
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, msisdn,
					queryLastRatedUsageDtmByTypeInput, queryLastRatedUsageDtmByTypeOutput, responseStatus,
					Constants.QUERY_RATED_USAGE_API_NAME, das, diffStr, node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_3002 + ex.toString());
		}
		traceLog.traceFinest("End of queryLastRatedUsageDtmByType API");
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, msisdn,
				queryLastRatedUsageDtmByTypeInput, queryLastRatedUsageDtmByTypeOutput, responseStatus,
				Constants.QUERY_RATED_USAGE_API_NAME, das, diffStr, node);
		return queryLastRatedUsageDtmByTypeResultArray;

	}

	/**
	 * This method invokes the stored procedure and fetches the values and
	 * returns the object QueryLastRatedUsageDtmByTypeResult
	 * 
	 * @param msisdn
	 * @param accountNum
	 * @return
	 * @author sgad2315 (Sreekanth Gade)
	 */
	private List<QueryLastRatedUsageDtmByTypeResult> getLastRatedUsageStoredProc(String msisdn, String accountNum) {

		List<QueryLastRatedUsageDtmByTypeResult> lastRatedUsageList = new ArrayList<QueryLastRatedUsageDtmByTypeResult>();
		QueryLastRatedUsageDtmByTypeResult queryLastRatedUsageDtmByTypeResultObj = null;

		String sql = SQLStatements.GET_LASTRATEDUSAGE;

		traceLog.traceFinest("Printing the SQL " + sql);
		traceLog.traceFinest("START of getLastRatedUsageStoredProc");

		Connection connection = null;
		CallableStatement callableStatement = null;
		ResultSet rs = null;

		if (sql == null || !sql.toUpperCase().startsWith("{") || !sql.toUpperCase().contains("CALL")) {
			throw new RuntimeException("SQL is null or not start with { or not contain CALL :" + sql);
		}

		try {
			traceLog.traceFinest("In TRY BLOCK");
			connection = util.getDataSource().getConnection();
			callableStatement = connection.prepareCall(sql);

			callableStatement.setString(1, msisdn);
			callableStatement.setString(2, accountNum);
			callableStatement.registerOutParameter(3, OracleTypes.CURSOR); // Scenario
																			// 1,
																			// 2,
																			// 3
			callableStatement.registerOutParameter(4, OracleTypes.CURSOR); // Scenario
																			// 4,
																			// 5,
																			// 6
			callableStatement.execute();

			traceLog.traceFinest("In TRY BLOCK after the execute ");
			rs = (ResultSet) callableStatement.getObject(3);
			traceLog.traceFinest("Printing the value of Result Set getObject(3) : " + rs);

			if (rs == null) {
				rs = (ResultSet) callableStatement.getObject(4);
				traceLog.traceFinest("Printing the value of Result Set getObject(4) : " + rs);
			}

			if (rs != null) {
				while (rs.next()) {
					traceLog.traceFinest("In the Result Set START ");

					String acc_num = rs.getString("ACCOUNT_NUM");
					String msisdn_num = rs.getString("MSISDN");
					long value = rs.getDate("LASTRATEUSAGEDATE").getTime();
					String event_type = String.valueOf(rs.getInt("EVENT_TYPE_ID"));

					traceLog.traceFinest("In the Result Set Printing ACCOUNT_NUM : " + acc_num);
					traceLog.traceFinest("In the Result Set Printing MSISDN : " + msisdn_num);
					traceLog.traceFinest("In the Result Set Printing LASTRATEUSAGEDATE long value : " + value);
					traceLog.traceFinest("In the Result Set Printing EVENT_TYPE_ID : " + event_type);
					traceLog.traceFinest("In the Result Set END ");

					queryLastRatedUsageDtmByTypeResultObj = new QueryLastRatedUsageDtmByTypeResult();
					queryLastRatedUsageDtmByTypeResultObj.setAccountNum(acc_num);
					queryLastRatedUsageDtmByTypeResultObj.setMSISDN(msisdn_num);
					queryLastRatedUsageDtmByTypeResultObj.setLastRatedUsageDtmNbl(value);
					queryLastRatedUsageDtmByTypeResultObj.setUsageType(event_type);
					lastRatedUsageList.add(queryLastRatedUsageDtmByTypeResultObj);
				}
			} else {
				traceLog.traceFinest("In the ELSE condition Result Set is NULL");
			}

		} catch (SQLException sqlex) {
			traceLog.traceFinest("SQLException from getLastRatedUsageStoredProc " + sqlex.getMessage());
		} finally {
			util.closeResources(rs, connection, null, callableStatement);
		}
		traceLog.traceFinest(" End of getLastRatedUsageStoredProc");
		return lastRatedUsageList;
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}
}
