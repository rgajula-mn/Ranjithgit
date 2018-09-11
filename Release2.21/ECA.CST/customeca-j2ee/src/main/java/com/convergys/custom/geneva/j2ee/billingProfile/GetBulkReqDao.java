package com.convergys.custom.geneva.j2ee.billingProfile;

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

public class GetBulkReqDao {

	private static TraceLog traceLog = new TraceLog(GetBulkReqDao.class);
	private Util util;

	public GetBulkReqDao() {
		traceLog.traceFinest(" GetBulkRequestDao:..!!!!!!! ");
	}

	public GetBulkRequestOutputElements getBulkRequests(IntegratorContext integratorContext, String partnerID,
			String portalUserID) throws Exception {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;
		GetBulkRequestsInput getBulkRequestInput = new GetBulkRequestsInput();
		GetBulkRequestsOutput getBulkRequestOutput = new GetBulkRequestsOutput();
		das = util.getDataSource();
		GetBulkRequestOutputElements getBulkRequestOutputElements = null;
		try {
			traceLog.traceFinest("start of getBulkRequests method in GetBulkRequest!!!");

			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.GET_BULK_REQUEST_API_NAME);
			}

			if (partnerID == null || partnerID.trim().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_9001, Constants.GET_BULK_REQUEST_API_NAME);
			}
			getBulkRequestInput.setIntegratorContext(integratorContext);
			getBulkRequestInput.setPartnerID(partnerID);
			getBulkRequestInput.setPortalUserID(portalUserID);

			StringBuilder query = new StringBuilder(SQLStatements.GET_BULK_REQUEST_SQL);

			// append portalUserID in query when it is not null
			if (portalUserID != null && !portalUserID.trim().equals("")) {
				query.append(" AND  PORTAL_USER_ID = '" + portalUserID + "'");
			}

			traceLog.traceFinest("getBulkRequests query: " + query);

			IrbClientParam[] IrbClientParamAsArray = {
					(new IrbClientParam(1, Integer.parseInt(partnerID), Types.INTEGER)) };

			List<HashMapPlus> list = util.executeQueryForList(query.toString(), IrbClientParamAsArray, null);
			traceLog.traceFinest("getBulkRequests query is executed ");
			int size = list.size();
			BulkRequestDetailInfoElements[] bulkRequestDetailInfoElementsAsArray = new BulkRequestDetailInfoElements[size];
			for (int i = 0; i < size; i++) {

				BulkRequestDetailInfoElements bulkRequest = new BulkRequestDetailInfoElements();

				if (list.get(i).getInt("REQUEST_ID") == null) {
					throw new ApplicationException("Unable to fetch request_id from database");
				}

				bulkRequest.setRequestId(list.get(i).getInt("REQUEST_ID"));

				if (list.get(i).getDate("CREATED_DTM") == null) {
					throw new ApplicationException("Unable to fetch createdDate from database");
				}

				bulkRequest.setCreatedDateTimeNbl(list.get(i).getDate("CREATED_DTM").getTime());
				bulkRequest.setUserId(list.get(i).getString("PORTAL_USER_ID"));
				bulkRequest.setStatus(list.get(i).getInt("STATUS"));

				if (list.get(i).getDate("COMPLETED_DTM") != null) {

					bulkRequest.setCompletedDateTimeNbl(list.get(i).getDate("COMPLETED_DTM").getTime());
				}

				bulkRequest.setRequestFile(list.get(i).getString("REQUEST_FILE"));
				bulkRequest.setResultFile(list.get(i).getString("RESULT_FILE"));
				bulkRequest.setErrorFile(list.get(i).getString("ERROR_FILE"));
				bulkRequest.setParseFile(list.get(i).getString("PARSE_FILE"));
				bulkRequest.setNumberRequests(list.get(i).getInt("NUMBER_REQUESTS"));
				bulkRequest.setPartnerId(list.get(i).getInt("TIBCO_PARTNER_ID"));

				bulkRequestDetailInfoElementsAsArray[i] = bulkRequest;
			}

			getBulkRequestOutputElements = new GetBulkRequestOutputElements();
			getBulkRequestOutputElements.setBulkRequestDetailInfo(bulkRequestDetailInfoElementsAsArray);

			traceLog.traceFinest("End of getBulkRequests method in in GetBulkRequest!!!");

			getBulkRequestOutputElements = new GetBulkRequestOutputElements();
			getBulkRequestOutputElements.setBulkRequestDetailInfo(bulkRequestDetailInfoElementsAsArray);
			endTime = System.currentTimeMillis();
			diff = endTime - startTime;
			traceLog.traceFinest("Before Logs");
			getBulkRequestOutput.setGetBulkRequestOutput(getBulkRequestOutputElements);
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, getBulkRequestInput,
					getBulkRequestOutputElements, Constants.TRANSACTION_SUCCESS, Constants.GET_BULK_REQUEST_API_NAME,
					das, String.valueOf(diff), node);
			traceLog.traceFinest("After Logs");
		} catch (Exception e) {
			endTime = System.currentTimeMillis();
			diff = endTime - startTime;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, getBulkRequestInput,
					getBulkRequestOutput, responseStatus, Constants.GET_BULK_REQUEST_API_NAME, das,
					String.valueOf(diff), node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_9005 + Constants.GET_BULK_REQUEST_API_NAME);
		}

		return getBulkRequestOutputElements;
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

}
