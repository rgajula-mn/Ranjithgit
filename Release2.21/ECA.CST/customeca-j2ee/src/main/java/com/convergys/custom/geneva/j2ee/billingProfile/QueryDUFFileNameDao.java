package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.DateUtil;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class QueryDUFFileNameDao {

	private static TraceLog traceLog = new TraceLog(QueryDUFFileNameDao.class);
	private Util util;

	/**
	 * 
	 * @param integratorContext
	 * @param invoiceNumber
	 * @return
	 * @author paku0216
	 * @throws ApplicationException
	 */
	public QueryDUFFileNameResult getQueryDUFFileName(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String accountNum, java.lang.String eventSeq, int eventTypeIDNbl, long ratedDtmNbl)
			throws ApplicationException {

		traceLog.traceFinest("Entered into getQueryDUFFileName API");

		QueryDUFFileNameResult queryDUFFileNameResult = new QueryDUFFileNameResult();
		Date startDate = null;

		try {

			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_DUFFile_DATA);
			}

			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.QUERY_DUFFile_DATA);
			}

			if (accountNum == null || accountNum.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1005, Constants.QUERY_DUFFile_DATA);
			}

			if (eventSeq == null || eventSeq.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_6002, Constants.QUERY_DUFFile_DATA);
			}

			if (eventTypeIDNbl == 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_6006, Constants.QUERY_DUFFile_DATA);
			}

			if (ratedDtmNbl < 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_6003, Constants.QUERY_DUFFile_DATA);
			} else {
				startDate = new Date(ratedDtmNbl);
			}

			String startRange = (startDate != null) ? DateUtil.getDateTime("yyyy-MM-dd hh:mm:ss", startDate)
					: DateUtil.getDateTime("yyyy-MM-dd hh:mm:ss", DateUtil.getDateFromToday(0));

			traceLog.traceFinest("Printing the startRange: " + startRange);

			traceLog.traceFinest("Executing getQueryDUFFileName API");
			String dufFileName = getDUFFilename(eventTypeIDNbl, startRange, eventSeq, accountNum);
			traceLog.traceFinest("Executed getQueryDUFFileName API");
			queryDUFFileNameResult.setDufFileName(dufFileName);

		} catch (Exception ex) {
			traceLog.traceFinest("Exception from  getQueryDUFFileName API : " + ex.getMessage());
			throw new ApplicationException(ErrorCodes.ERR_RBM_10002 + ex.getMessage().toString());
		}
		traceLog.traceFinest("End of getQueryDUFFileName API");
		return queryDUFFileNameResult;

	}

	private String getDUFFilename(Integer eventTypeIDNbl, String createdDtmNbl, String eventSeq, String accountNum)
			throws Exception {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getDUFFilename createdDtm:" + createdDtmNbl + " EventTypeID:" + eventTypeIDNbl
					+ " eventSeq :" + eventSeq + " accountNum :" + accountNum);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String dUFFileName = null;
		try {
			StringBuilder query = new StringBuilder();
			connectionObject = util.getDataSource().getConnection();
			String sql = getDufFileQuery(eventTypeIDNbl, createdDtmNbl, eventSeq, accountNum, query);
			traceLog.traceFinest("DUFFile Query : " + sql);
			preparedStatement = connectionObject.prepareStatement(sql);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				dUFFileName = resultSet.getString(1);
				if (traceLog.isFinestEnabled())
					traceLog.traceFinest("DdUFFileName:: " + dUFFileName);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getDUFFilename:: " + e.getMessage());
		} finally {
			util.closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		return dUFFileName;
	}

	private String getDufFileQuery(Integer eventTypeIDNbl, String createdDtmNbl, String eventSeq, String accountNum,
			StringBuilder query) {
		query.append("Select DUF_FILENAME from TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS ");
		query.append(" where (first_event_created_dtm  <= TO_DATE('" + createdDtmNbl + "', 'YYYY-MM-DD HH24:MI:SS') ");
		query.append(" and last_event_created_dtm  >= TO_DATE('" + createdDtmNbl + "', 'YYYY-MM-DD HH24:MI:SS')) ");
		query.append(" and account_num = '" + accountNum + "' and event_seq = " + eventSeq + " ");
		if (eventTypeIDNbl == 1 || eventTypeIDNbl == 2) {
			query.append(" and event_type = 'VOICE' ");
		} else {
			query.append(" and event_type = 'DATA' ");
		}

		return query.toString();
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}
}
