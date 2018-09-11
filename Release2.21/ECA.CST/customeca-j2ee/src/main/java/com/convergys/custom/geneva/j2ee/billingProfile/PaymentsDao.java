package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;

import javax.sql.DataSource;

import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class PaymentsDao {
	private static TraceLog traceLog = new TraceLog(PaymentsDao.class);
	private Util util;	

	public java.lang.String
	  createPaymentChannel
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    int paymentChannelId,
	    java.lang.String paymentChannelName,
	    int invoicingCoId
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException
	    {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		DataSource das = null;
		String responseStatus = null;
		String createPaymentChannelResult = null;

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("Entered into createPaymentChannel API...startTime.. " + startTime);
		}

		traceLog.traceFinest("Entered into createPaymentChannel API");
		traceLog.traceFinest("In createPaymentChannel paymentChannelId: " + paymentChannelId);
		traceLog.traceFinest("In createPaymentChannel paymentChannelName: " + paymentChannelName);
		traceLog.traceFinest("In createPaymentChannel invoicingCoId: " + invoicingCoId);

		CreatePaymentChannelOutput createPaymentChannelOutput = new CreatePaymentChannelOutput();
		CreatePaymentChannelInput createPaymentChannelInput = new CreatePaymentChannelInput();
		try {
			
			//String paymentChannelIdStr=String.valueOf(paymentChannelId);
			//String invoicingCoIdStr=String.valueOf(invoicingCoId);
			
			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17001, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}

			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17002, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}
			/*if (paymentChannelIdStr == null || paymentChannelIdStr.trim().equals("")) {			
				throw new NullParameterException(ErrorCodes.ERR_RBM_17003, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}*/
			if (String.valueOf(paymentChannelId) == null || paymentChannelId == Null.INT) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17003, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}

			if (paymentChannelName == null || paymentChannelName.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17004, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}
			/*if (invoicingCoIdStr == null || invoicingCoIdStr.trim().equals("")) {			
				throw new NullParameterException(ErrorCodes.ERR_RBM_17005, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}*/
			if (String.valueOf(invoicingCoId) == null || invoicingCoId == Null.INT) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17005, Constants.CREATE__PAYMENT_CHANNEL_API_NAME);
			}
			
			
			
			
			createPaymentChannelInput.setIntegratorContext(integratorContext);
			createPaymentChannelInput.setPaymentChannelId(paymentChannelId);
			createPaymentChannelInput.setPaymentChannelName(paymentChannelName);
			createPaymentChannelInput.setInvoicingCoId(invoicingCoId);

			createPaymentChannelResult = createPaymentChannelDetails(paymentChannelId, paymentChannelName,
					invoicingCoId);
			createPaymentChannelOutput.setCreatePaymentChannelOutput(createPaymentChannelResult);

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after createPaymentChannel.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of createPaymentChannel is " + diff + "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createPaymentChannelInput,
					createPaymentChannelOutput, responseStatus, Constants.CREATE__PAYMENT_CHANNEL_API_NAME, das,
					diffStr, node);

		} catch (Exception ex) {

			responseStatus = ex.getMessage();
			traceLog.traceFinest("Exception from  createPaymentChannel API : " + ex.getMessage());

			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, createPaymentChannelInput,
					createPaymentChannelOutput, responseStatus, Constants.CREATE__PAYMENT_CHANNEL_API_NAME, das,
					diffStr, node);
			throw new ApplicationException(ex.getMessage());
		}
		traceLog.traceFinest("End of createPaymentChannel API");
		return createPaymentChannelResult;

	}

	public java.lang.String
	  modifyPaymentChannel
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    int paymentChannelId,
	    java.lang.String paymentChannelName
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException
	    {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		DataSource das = null;
		String responseStatus = null;
		String modifyPaymentChannelResult = null;

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("Entered into modifyPaymentChannel API...startTime.. " + startTime);
		}

		traceLog.traceFinest("Entered into modifyPaymentChannel API");
		traceLog.traceFinest("In modifyPaymentChannel paymentChannelId: " + paymentChannelId);
		traceLog.traceFinest("In modifyPaymentChannel paymentChannelName: " + paymentChannelName);
		
		ModifyPaymentChannelOutput modifyPaymentChannelOutput = new ModifyPaymentChannelOutput();
		ModifyPaymentChannelInput modifyPaymentChannelInput = new ModifyPaymentChannelInput();
		

		try {
			//String paymentChannelIdStr=String.valueOf(paymentChannelId);
			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17001, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME);
			}

			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17002, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME);
			}

			/*if (paymentChannelIdStr == null || paymentChannelIdStr.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17003, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME);
			}*/
			
			if (String.valueOf(paymentChannelId) == null || paymentChannelId == Null.INT) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17003, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME);
			}

			if (paymentChannelName == null || paymentChannelName.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_17004, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME);
			}
			
			
			modifyPaymentChannelInput.setIntegratorContext(integratorContext);
			modifyPaymentChannelInput.setPaymentChannelId(paymentChannelId);
			modifyPaymentChannelInput.setPaymentChannelName(paymentChannelName);
			

			modifyPaymentChannelResult = modifyPaymentChannelDetails(paymentChannelId, paymentChannelName);
			modifyPaymentChannelOutput.setModifyPaymentChannelOutput(modifyPaymentChannelResult);
			

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after modifyPaymentChannel.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of modifyPaymentChannel is " + diff + "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, modifyPaymentChannelInput,
					modifyPaymentChannelOutput, responseStatus, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME, das,
					diffStr, node);

		} catch (Exception ex) {

			responseStatus = ex.getMessage();
			traceLog.traceFinest("Exception from  modifyPaymentChannel API : " + ex.getMessage());

			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, modifyPaymentChannelInput,
					modifyPaymentChannelOutput, responseStatus, Constants.MODIFY__PAYMENT_CHANNEL_API_NAME, das,
					diffStr, node);
			throw new ApplicationException(ex.getMessage());
		}
		traceLog.traceFinest("End of modifyPaymentChannel API");
		return modifyPaymentChannelResult;

	}
	

    
	@SuppressWarnings("resource")
	public String createPaymentChannelDetails(int paymentMethodId,String paymentMethodName,int invoicing_co_id) throws ParseException, SQLException{
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest(
					"Inside createPaymentChannelDetails method:" + paymentMethodId + "|" + paymentMethodName);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;		
		String createPaymentChannelResult = null;

		try {
			connectionObject = util.getDataSource().getConnection();
						
			connectionObject = util.getDataSource().getConnection();
            preparedStatement = connectionObject.prepareStatement(SQLStatements.CREATE_PAYMENT_CHANNEL_SQL);
            traceLog.traceFinest("SQLStatements.CREATE_PAYMENT_CHANNEL_SQL: "+ SQLStatements.CREATE_PAYMENT_CHANNEL_SQL);
            preparedStatement.setInt(1, paymentMethodId);
			preparedStatement.setString(2, paymentMethodName);
			
            int records = preparedStatement.executeUpdate();
            if (records>0) { 
            	traceLog.traceFinest(records+"record(s) are inserted into GENEVA_ADMIN.PAYMENTMETHOD table");
            	preparedStatement = connectionObject.prepareStatement(SQLStatements.CREATE_PAYMENT_CHANNEL_SQL2);
    			preparedStatement.setInt(1, invoicing_co_id);
    			preparedStatement.setInt(2, paymentMethodId);
    			records=0;
    			records = preparedStatement.executeUpdate();
    			if (records>0) {
    			traceLog.traceFinest(records+"record(s) are inserted into GENEVA_ADMIN.ICOHASPAYMENTMETHOD table");
            	createPaymentChannelResult = "Created New Payment Method";
    			}
    			
    			
            }

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside createPaymentChannelDetails:: " + e.getMessage());
			//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw new SQLException(e.getMessage());
			
		} finally {
			util.closeResources(null, connectionObject, preparedStatement, null);

		}
		traceLog.traceFinest("End of createPaymentChannelDetails method");
		return createPaymentChannelResult;
    }
  	
  	public String modifyPaymentChannelDetails(int paymentMethodId,String paymentMethodName) throws ParseException, SQLException{
    	if (traceLog.isFinestEnabled())
            traceLog.traceFinest("Inside ModifyPaymentChannelDetails method:" + paymentMethodId + "|"+ paymentMethodName);
        Connection connectionObject = null;
        PreparedStatement preparedStatement = null;
        String modifyPaymentChannelResult=null;
        
        try {
            connectionObject = util.getDataSource().getConnection();
            preparedStatement = connectionObject.prepareStatement(SQLStatements.UPDATE_PAYMENT_CHANNEL_SQL);
            traceLog.traceFinest("SQLStatements.UPDATE_PAYMENT_CHANNEL_SQL: "+ SQLStatements.UPDATE_PAYMENT_CHANNEL_SQL);
            preparedStatement.setString(1, paymentMethodName);
            preparedStatement.setInt(2, paymentMethodId);
            int records = preparedStatement.executeUpdate();
            if (records>0) {
            	traceLog.traceFinest(records+"record(s) are updated in GENEVA_ADMIN.PAYMENTMETHOD table |" + paymentMethodId+"|"+paymentMethodName);
            	modifyPaymentChannelResult="Payment Channel is Updated";            	
            }

        } catch (SQLException e) {
            if (traceLog.isFinestEnabled())
                traceLog.traceFinest("Exception inside ModifyPaymentChannelDetails:: " + e.getMessage());
            throw new SQLException(e.getMessage());
        } finally {
            util.closeResources(null, connectionObject, preparedStatement, null);
        }
        traceLog.traceFinest("End of modifyPaymentChannelDetails method");
        return modifyPaymentChannelResult;
    }
  	
  	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}


}
