package com.convergys.custom.geneva.j2ee.billingProfile;

import java.rmi.RemoteException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.ServiceLocator;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.BusinessLogicException;
import com.convergys.geneva.j2ee.NoSuchEntityException;
import com.convergys.geneva.j2ee.Null;
import com.convergys.geneva.j2ee.account.AccountPK;
import com.convergys.geneva.j2ee.adjustment.AdjustmentService;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class CreateAdjustmentDao {

	private static TraceLog traceLog = new TraceLog(CreateAdjustmentDao.class);
	private Util util;
	private AdjustmentService adjustmentService = null;

	public CreateAdjustmentDao() {
		traceLog.traceFinest(" CreateAdjustmentDao:..!!!!!!! ");
	}

	public com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult createAdjustment(
			IntegratorContext integratorContext, AccountPK accountPK, long adjustmentDate, String adjustmentTypeId,
			String adjustmentText, long adjustmentMny, int budgetCentreSeqNblNbl, Boolean requestCreditNote,
			long createdDtmNbl, int contractedPointOfSupplyId, String createdByUser) throws NullParameterException,
			com.convergys.geneva.j2ee.NullParameterException, NoSuchEntityException, BusinessLogicException,
			RemoteException, com.convergys.geneva.j2ee.ApplicationException, ApplicationException {

		com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult adjustmentResult = null;
		String responseStatus = null;
		DataSource das = null;
		CreateAdjustmentInput createAdjustmentInput = new CreateAdjustmentInput();
		CreateAdjustmentOutput createAdjustmentOutput = new CreateAdjustmentOutput();

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("In createAdjustment API...startTime.. " + startTime);
		}

		traceLog.traceFinest("In createAdjustment");
		try {
			das = util.getDataSource();
			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_API_NAME);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CREATE_ADJUSTMENT__API_NAME);
			}
			if (accountPK == null || accountPK.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7002, Constants.CREATE_ADJUSTMENT__API_NAME);
			}
			/*
			 * if (adjustmentDate < 0) { throw new
			 * NullParameterException(ErrorCodes.ERR_RBM_7003,
			 * Constants.CREATE_ADJUSTMENT__API_NAME); }
			 */
			if (adjustmentDate == Null.LONG) {
				traceLog.traceFinest("In createAdjustment adjustmentDate from gnvDate : " + adjustmentDate);
				adjustmentDate = util.getGnvSystemDate().getTime();
				traceLog.traceFinest("In createAdjustment adjustmentDate from gnvDate in long : " + adjustmentDate);
			}

			if (adjustmentTypeId == null || adjustmentTypeId.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7004, Constants.CREATE_ADJUSTMENT__API_NAME);
			}
			if (adjustmentText == null || adjustmentText.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7005, Constants.CREATE_ADJUSTMENT__API_NAME);
			}
			if (String.valueOf(adjustmentMny) == null || adjustmentMny == Null.LONG) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7006, Constants.CREATE_ADJUSTMENT__API_NAME);
			}

			if (contractedPointOfSupplyId <= 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7007, Constants.CREATE_ADJUSTMENT__API_NAME);
			}
			traceLog.traceFinest("In createAdjustment after Mandatory parameters validations");
			IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
			integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
			integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
			integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
			integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());

			com.convergys.geneva.j2ee.adjustment.AdjustmentResult result = new com.convergys.geneva.j2ee.adjustment.AdjustmentResult();

			adjustmentResult = new com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult();

			int adjTypeId = 0;
			if (adjustmentTypeId.contains(Constants.TILDE_OPERATOR)) {
				String[] parts = adjustmentTypeId.split(Constants.TILDE_OPERATOR);
				adjTypeId = Integer.parseInt(parts[0]);
				if (parts.length > 1) {
					createdByUser = createdByUser + Constants.PIPE_OPERATOR + parts[1];
				}
				if (parts.length > 2) {
					createdByUser = createdByUser + Constants.PIPE_OPERATOR + parts[2];
				}
			} else {
				adjTypeId = Integer.parseInt(adjustmentTypeId);
			}
			createAdjustmentInput.setAccountPK(accountPK);
			createAdjustmentInput.setAdjustmentDateNbl(adjustmentDate);
			createAdjustmentInput.setAdjustmentMny(adjustmentMny);
			createAdjustmentInput.setAdjustmentText(adjustmentText);
			createAdjustmentInput.setAdjustmentTypeId(adjustmentTypeId);
			createAdjustmentInput.setBudgetCentreSeqNblNbl(budgetCentreSeqNblNbl);
			createAdjustmentInput.setContractedPointOfSupplyId(contractedPointOfSupplyId);
			createAdjustmentInput.setContractedPointOfSupplyId(contractedPointOfSupplyId);
			createAdjustmentInput.setCreatedByUser(createdByUser);
			createAdjustmentInput.setCreatedDtmNbl(createdDtmNbl);
			createAdjustmentInput.setRequestCreditNote(requestCreditNote);
			traceLog.traceFinest("In createAdjustment calling createAdjustment_1");

			result = getAdjustmentService().createAdjustment_1(integratorContext_1, accountPK, adjustmentDate,
					adjTypeId, adjustmentText, adjustmentMny, budgetCentreSeqNblNbl, requestCreditNote, createdDtmNbl,
					contractedPointOfSupplyId, createdByUser);

			responseStatus = Constants.TRANSACTION_SUCCESS;
			adjustmentResult.setAdjustmentPK(result.getAdjustmentPK());
			adjustmentResult.setBillRequestPK(result.getBillRequestPK());
			createAdjustmentOutput.setAdjustmentResult(adjustmentResult);
			traceLog.traceFinest("In createAdjustment after calling createAdjustment_1 getAdjustmentPK :"
					+ adjustmentResult.getAdjustmentPK());

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after createAdjustment_1.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of createAdjustment_1 is " + diff + "........." + diffStr);

		} catch (Exception ex) {
			responseStatus = ex.getMessage();
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createAdjustmentInput,
					createAdjustmentOutput, responseStatus, Constants.CREATE_ADJUSTMENT__API_NAME, das, diffStr, node);
			traceLog.traceFinest("In createAdjustment Exception calling createAdjustment_1 :" + ex.getMessage());
			throw new ApplicationException(ex.getMessage());
		}

		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createAdjustmentInput,
				createAdjustmentOutput, responseStatus, Constants.CREATE_ADJUSTMENT__API_NAME, das, diffStr, node);
		return adjustmentResult;
	}	
	
	public com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult_2 createAdjustment_2(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			com.convergys.geneva.j2ee.account.AccountPK accountPK, long adjustmentDateNbl,
			java.lang.String adjustmentTypeId, java.lang.String adjustmentText, long adjustmentMny,
			int budgetCentreSeqNblNbl, java.lang.Boolean requestCreditNote, long createdDtmNbl,
			int contractedPointOfSupplyId, java.lang.String createdByUser, java.lang.String wpsInfo)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.iml.commonIML.ParameterException,
			com.convergys.platform.ApplicationException {
				
		
		com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult_2 adjustmentResult2 = null;
		
		String responseStatus = null;
		DataSource das = null;
		CreateAdjustmentInput_2 createAdjustmentInput_2 = new CreateAdjustmentInput_2();
		CreateAdjustmentOutput_2 createAdjustmentOutput_2 = new CreateAdjustmentOutput_2();
		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("In createAdjustment_2 API...startTime.. " + startTime);
		}

		traceLog.traceFinest("In createAdjustment_2");
		try {
			das = util.getDataSource();
			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_API_NAME);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CREATE_ADJUSTMENT2__API_NAME);
			}
			if (accountPK == null || accountPK.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7002, Constants.CREATE_ADJUSTMENT2__API_NAME);
			}
			/*
			 * if (adjustmentDate < 0) { throw new
			 * NullParameterException(ErrorCodes.ERR_RBM_7003,
			 * Constants.CREATE_ADJUSTMENT__API_NAME); }
			 */
			if (adjustmentDateNbl == Null.LONG) {
				traceLog.traceFinest("In createAdjustment2 adjustmentDate from gnvDate : " + adjustmentDateNbl);
				adjustmentDateNbl = util.getGnvSystemDate().getTime();
				traceLog.traceFinest("In createAdjustment2 adjustmentDate from gnvDate in long : " + adjustmentDateNbl);
			}

			if (adjustmentTypeId == null || adjustmentTypeId.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7004, Constants.CREATE_ADJUSTMENT2__API_NAME);
			}
			if (adjustmentText == null || adjustmentText.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7005, Constants.CREATE_ADJUSTMENT2__API_NAME);
			}
			if (String.valueOf(adjustmentMny) == null || adjustmentMny == Null.LONG) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7006, Constants.CREATE_ADJUSTMENT2__API_NAME);
			}

			if (contractedPointOfSupplyId <= 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_7007, Constants.CREATE_ADJUSTMENT2__API_NAME);
			}
			traceLog.traceFinest("In createAdjustment2 after Mandatory parameters validations");
			IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
			integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
			integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
			integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
			integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());

			com.convergys.geneva.j2ee.adjustment.AdjustmentResult result = new com.convergys.geneva.j2ee.adjustment.AdjustmentResult();

			//adjustmentResult = new com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult();
			adjustmentResult2 = new com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult_2();

			int adjTypeId = 0;
			if (adjustmentTypeId.contains(Constants.TILDE_OPERATOR)) {
				String[] parts = adjustmentTypeId.split(Constants.TILDE_OPERATOR);
				adjTypeId = Integer.parseInt(parts[0]);
				if (parts.length > 1) {
					createdByUser = createdByUser + Constants.PIPE_OPERATOR + parts[1];
				}
				if (parts.length > 2) {
					createdByUser = createdByUser + Constants.PIPE_OPERATOR + parts[2];
				}
			} else {
				adjTypeId = Integer.parseInt(adjustmentTypeId);
			}
			createAdjustmentInput_2.setAccountPK(accountPK);
			createAdjustmentInput_2.setAdjustmentDateNbl(adjustmentDateNbl);
			createAdjustmentInput_2.setAdjustmentMny(adjustmentMny);
			createAdjustmentInput_2.setAdjustmentText(adjustmentText);
			createAdjustmentInput_2.setAdjustmentTypeId(adjustmentTypeId);
			createAdjustmentInput_2.setBudgetCentreSeqNblNbl(budgetCentreSeqNblNbl);
			createAdjustmentInput_2.setContractedPointOfSupplyId(contractedPointOfSupplyId);
			createAdjustmentInput_2.setContractedPointOfSupplyId(contractedPointOfSupplyId);
			createAdjustmentInput_2.setCreatedByUser(createdByUser);
			createAdjustmentInput_2.setCreatedDtmNbl(createdDtmNbl);
			createAdjustmentInput_2.setRequestCreditNote(requestCreditNote);
			traceLog.traceFinest("In createAdjustment calling createAdjustment_2");

			result = getAdjustmentService().createAdjustment_1(integratorContext_1, accountPK, adjustmentDateNbl,
					adjTypeId, adjustmentText, adjustmentMny, budgetCentreSeqNblNbl, requestCreditNote, createdDtmNbl,
					contractedPointOfSupplyId, createdByUser);

			
			//adjustmentResult.setAdjustmentPK(result.getAdjustmentPK());
			//adjustmentResult.setBillRequestPK(result.getBillRequestPK());
			
			String adjAccNum = result.getAdjustmentPK().getAccountNum();
			int adjSeq = result.getAdjustmentPK().getAdjustmentSeq();
			traceLog.traceFinest("In createAdjustment calling createAdjustment_2 - wpsInfo:" +wpsInfo);
			if(wpsInfo!=null && wpsInfo.trim().length()>0)
			{
			createWPS(adjAccNum, adjSeq, wpsInfo);
			}
			traceLog.traceFinest("In createAdjustment calling createAdjustment_2 - After createWPS");
			responseStatus = Constants.TRANSACTION_SUCCESS;
			adjustmentResult2.setAdjustmentPK(result.getAdjustmentPK()); 
			adjustmentResult2.setBillRequestPK(result.getBillRequestPK());
			
			createAdjustmentOutput_2.setAdjustmentResult(adjustmentResult2);
			traceLog.traceFinest("In createAdjustment after calling createAdjustment_2 getAdjustmentPK :"
					+ adjustmentResult2.getAdjustmentPK());

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after createAdjustment_2.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of createAdjustment_2 is " + diff + "........." + diffStr);
			} catch (Exception ex) {
			responseStatus = ex.getMessage();
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createAdjustmentInput_2,
					createAdjustmentOutput_2, responseStatus, Constants.CREATE_ADJUSTMENT2__API_NAME, das, diffStr, node);
			traceLog.traceFinest("In createAdjustment Exception calling createAdjustment_2 :" + ex.getMessage());
			throw new ApplicationException(ex.getMessage());
		}

		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createAdjustmentInput_2,
				createAdjustmentOutput_2, responseStatus, Constants.CREATE_ADJUSTMENT2__API_NAME, das, diffStr, node);
				
		return adjustmentResult2;				
	}
	public void createWPS(String adjAccNum, int adjSeq, String wpsInfo) throws ParseException, SQLException {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside createWPS method:" + adjAccNum + "|" + adjSeq + "|" + wpsInfo);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;

		try {
			connectionObject = util.getDataSource().getConnection();
			// inserting into TMO_ADJUSTMENT_ATTRIBUTES
			preparedStatement = connectionObject.prepareStatement(SQLStatements.CREATE_ADJUSTMENT_ATTRS_SQL);
			preparedStatement.setString(1, adjAccNum);
			preparedStatement.setInt(2, adjSeq);
			preparedStatement.setString(3, wpsInfo);
			int records = preparedStatement.executeUpdate();

			if (records > 0) {

				traceLog.traceFinest(records + " record(s) are inserted..");
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside createWPS:: " + e.getMessage());
			throw new SQLException(e.getMessage());

		} finally {
			util.closeResources(null, connectionObject, preparedStatement, null);

		}
		traceLog.traceFinest("End of createWPS method");
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
