package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.iml.commonIML.ParameterException;
import com.convergys.logging.TraceLog;

public class CreateBulkRequestDao {

	private static TraceLog traceLog = new TraceLog(CreateBulkRequestDao.class);
	private Util util;

	public CreateBulkRequestOutputElements createBulkRequest(IntegratorContext integratorContext, String partnerID,
			String portalUserID, String requestFile, long createdDateTime) throws Exception {
		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;
		CreateBulkRequestOutputElements createBulkRequestOutputElements = null;
		traceLog.traceFinest("Start of createbulkrequest method in BillingProfileDao");
		Connection conn = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;

		if (integratorContext == null || integratorContext.equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_BULK_REQUEST_API_NAME);
		}
		if (integratorContext.getExternalBusinessTransactionId() == null
				|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CREATE_BULK_REQUEST_API_NAME);
		}
		if (partnerID == null || partnerID.equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_9001, Constants.CREATE_BULK_REQUEST_API_NAME);
		}
		if (requestFile == null) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_9002, Constants.CREATE_BULK_REQUEST_API_NAME);
		}
		Pattern fileExtnPtrn = Pattern.compile("([^\\s]+(\\.(?i)(csv))$)");
		Matcher matcher = fileExtnPtrn.matcher(requestFile);
		if (!matcher.find()) {
			throw new ParameterException(ErrorCodes.ERR_RBM_9002, Constants.CREATE_BULK_REQUEST_API_NAME);
		}
		// To fetch CUSTOMER_REF
		String customerRef = " ";
		CreateBulkRequestInput createBulkRequestInput = new CreateBulkRequestInput();
		das = util.getDataSource();
		try {
			BulkRequestInfoElements bulkRequestInfoElements = new BulkRequestInfoElements();
			createBulkRequestOutputElements = new CreateBulkRequestOutputElements();
			createBulkRequestInput.setIntegratorContext(integratorContext);
			createBulkRequestInput.setPartnerID(partnerID);
			createBulkRequestInput.setRequestFile(requestFile);
			createBulkRequestInput.setCreatedDateTime(createdDateTime);

			conn = util.getDataSource().getConnection();
			preparedStatement = conn.prepareStatement(SQLStatements.GET_CUSTOMER_REF_SQL);
			preparedStatement.setInt(1, Integer.parseInt(partnerID));
			preparedStatement.setInt(2, Integer.parseInt(partnerID));
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				customerRef = resultSet.getString(1);
			} else {
				endTime = System.currentTimeMillis();
				diff = endTime - startTime;
				responseStatus = Constants.FAIL_STATUS;
				BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
						createBulkRequestInput, createBulkRequestOutputElements, responseStatus,
						Constants.CREATE_BULK_REQUEST_API_NAME, das, String.valueOf(diff), node);
				if (traceLog.isFinerEnabled())
					traceLog.traceFinest("Partner Id " + (partnerID) + " not found.");
				createBulkRequestOutputElements.setOperationStatus(Constants.FAIL_STATUS);
				// throw new NullParameterException(ErrorCodes.ERR_RBM_9004,
				// Constants.CREATE_BULK_REQUEST_API_NAME);
				return createBulkRequestOutputElements;
			}

			String userName = integratorContext.getExternalUserName();
			if (userName == null || userName.equals("")) {
				userName = "testUser";
			}

			String operationStatus = insertBulkRequest(customerRef, createdDateTime, Constants.PENDING_STATUS, userName,
					requestFile, portalUserID, partnerID, bulkRequestInfoElements);

			createBulkRequestOutputElements.setOperationStatus(operationStatus);
			createBulkRequestOutputElements.setBulkRequestInfo(bulkRequestInfoElements);
			// responseStatus = Constants.TRANSACTION_SUCCESS;
			endTime = System.currentTimeMillis();
			diff = endTime - startTime;
			traceLog.traceFinest("operationStatus *: " + operationStatus);
			if (Constants.SUCCESS_STATUS.equals(operationStatus)) {
				BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
						createBulkRequestInput, createBulkRequestOutputElements, Constants.TRANSACTION_SUCCESS,
						Constants.CREATE_BULK_REQUEST_API_NAME, das, String.valueOf(diff), node);
			} else {
				responseStatus = Constants.FAIL_STATUS;
				BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
						createBulkRequestInput, createBulkRequestOutputElements, responseStatus,
						Constants.CREATE_BULK_REQUEST_API_NAME, das, String.valueOf(diff), node);
			}

		} catch (Exception e) {
			endTime = System.currentTimeMillis();
			diff = endTime - startTime;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createBulkRequestInput,
					createBulkRequestOutputElements, responseStatus, Constants.CREATE_BULK_REQUEST_API_NAME, das,
					String.valueOf(diff), node);
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside createBulkRequest: " + e.getMessage());
		
		} finally {
			util.closeResources(resultSet, conn, preparedStatement, null);
		}

		traceLog.traceFinest("End of createBulkRequest method in BillingProfileDao");

		return createBulkRequestOutputElements;

	}

	private String insertBulkRequest(String customerRef, long createdDateTime, int pendingStatus, String userName,
			String requestFile, String portalUserID, String partnerID,
			BulkRequestInfoElements bulkRequestInfoElements) {

		traceLog.traceFinest("Start of insertBulkRequest method in in BillingProfileDao");
		Connection connection = null;
		CallableStatement callableStatement = null;
		String status = null;

		try {

			connection = util.getDataSource().getConnection();
			// String dateAsString =
			// DateUtil.convertStringToDateString(createdDateTime,
			// Constants.DATETIME_MASK_INCLUDE_TIME_ZONE,
			// Constants.DATETIME_MASK_WITHOUT_TIME_ZONE);

			String sql = SQLStatements.CREATE_BULK_REQUEST_SQL;
			traceLog.traceFinest("insertBulkRequest - Printing the SQL: " + sql);

			if (sql == null || !sql.toUpperCase().startsWith("{") || !sql.toUpperCase().contains("CALL")) {
				throw new RuntimeException("SQL is null or not start with { or not contain CALL :" + sql);
			}
			callableStatement = connection.prepareCall(sql);
			int requestId = 0;
			if (requestFile != null) {
				String tempStr = requestFile.substring(requestFile.lastIndexOf("/") + 1, requestFile.length());
				String file[] = tempStr.split("_");
				requestId = Integer.parseInt(file[2]);
			}
			callableStatement.setString(1, customerRef);
			callableStatement.setDate(2, new java.sql.Date(createdDateTime));
			callableStatement.setString(3, userName);
			callableStatement.setInt(4, Constants.PENDING_STATUS);
			callableStatement.setString(5, requestFile);
			callableStatement.setString(6, portalUserID);
			callableStatement.setInt(7, Integer.parseInt(partnerID));
			// callableStatement.registerOutParameter(8, OracleTypes.INTEGER);
			callableStatement.setInt(8, requestId);
			callableStatement.executeQuery();

			traceLog.traceFinest("insertBulkRequest query is executed ");
			// int request_id = callableStatement.getInt(8);

			bulkRequestInfoElements.setRequestId(requestId);
			bulkRequestInfoElements.setStatus(Constants.PENDING_STATUS);
			// Long timeInMilliSec =
			// DateUtil.convertStringToDate(dateAsString).getTime();
			bulkRequestInfoElements.setCreatedDateTime(createdDateTime);
			bulkRequestInfoElements.setUserId(portalUserID);
			bulkRequestInfoElements.setRequestFile(requestFile);

			traceLog.traceFinest("End of insertBulkRequest method in in BillingProfileDao");
			status = Constants.SUCCESS_STATUS;

		} catch (Exception e) {
			traceLog.traceFinest("Exception occured" + e.getMessage());
			util.closeResources(null, connection, null, callableStatement);
			status = Constants.FAIL_STATUS;
		}

		return status;

	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

}
