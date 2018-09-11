package com.convergys.custom.geneva.j2ee.billingProfile;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.ServiceLocator;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.geneva.j2ee.adjustment.AdjustmentPK;
import com.convergys.geneva.j2ee.adjustment.AdjustmentService;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class CancelAdjustmentDao {

	private static TraceLog traceLog = new TraceLog(CancelAdjustmentDao.class);
	private Util util;
	private AdjustmentService adjustmentService = null;

	public CancelAdjustmentDao() {
		traceLog.traceFinest(" CancelAdjustmentDao:..!!!!!!! ");
	}

	public void cancelAdjustment(com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			AdjustmentPK adjustmentPK) throws NullParameterException, ApplicationException {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("In cancelAdjustment API...startTime.. " + startTime);
		}

		traceLog.traceFinest("In cancelAdjustment API");
		if (integratorContext == null || integratorContext.equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_API_NAME);
		}
		if (integratorContext.getExternalBusinessTransactionId() == null
				|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CANCEL_ADJUSTMENT__API_NAME);
		}

		if (adjustmentPK == null || adjustmentPK.equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_7001, Constants.CANCEL_ADJUSTMENT__API_NAME);
		}
		String responseStatus = null;
		DataSource das = null;
		CancelAdjustmentInput cancelAdjustmentInput = null;
		try {
			das = util.getDataSource();
			IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
			integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
			integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
			integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
			integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());
			cancelAdjustmentInput = new CancelAdjustmentInput();
			cancelAdjustmentInput.setAdjustmentPK(adjustmentPK);
			cancelAdjustmentInput.setIntegratorContext(integratorContext);

			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest("In cancelAdjustment calling cancelAdjustment_1");
			}
			getAdjustmentService().cancelAdjustment_1(new IntegratorContext_1(), adjustmentPK);
			responseStatus = Constants.TRANSACTION_SUCCESS;

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after cancelAdjustment.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of cancelAdjustment is " + diff + "........." + diffStr);

		} catch (Exception ex) {
			responseStatus = ex.getMessage();
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest("Exception in cancelAdjustment API :" + ex.getMessage());
			}
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, cancelAdjustmentInput,
					null, responseStatus, Constants.CANCEL_ADJUSTMENT__API_NAME, das, diffStr, node);
			throw new ApplicationException(ex.getMessage());
		}
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("In cancelAdjustment after calling cancelAdjustment_1");
		}
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, cancelAdjustmentInput, null,
				responseStatus, Constants.CANCEL_ADJUSTMENT__API_NAME, das, diffStr, node);
	}

	public AdjustmentService getAdjustmentService() {
		if (adjustmentService != null)
			return adjustmentService;
		try {
			adjustmentService = (AdjustmentService) ServiceLocator.getInstance().getBean("ECA_Adjustment");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return adjustmentService;
	}

	public void setAdjustmentService(AdjustmentService adjustmentService) {
		this.adjustmentService = adjustmentService;
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

}
