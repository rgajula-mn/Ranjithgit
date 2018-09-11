package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import java.util.Date;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

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

public class DeletePartnerUSTaxExemptionDao {

	private static TraceLog traceLog = new TraceLog(DeletePartnerUSTaxExemptionDao.class);
	private Util util;
	
	public DeletePartnerUSTaxExemptionDao() {
		traceLog.traceFinest(" DeletePartnerUSTaxExemptionDao:..!!!!!!! ");
	}

	public java.lang.String
	  deletePartnerUSTaxExemption
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    java.lang.String customerRef,
	    java.lang.String exemptionType
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException {
		
		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = util.getHostName();
		String diffStr = null;
		DataSource das = null;
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		String deleteTaxExemptionStatus = null;
		traceLog.traceFinest("deletePartnerUSTaxExemption method started ...startTime " + startTime);
		DeletePartnerUSTaxExemptionInput deleteTaxExemptionInput = new DeletePartnerUSTaxExemptionInput();
		DeletePartnerUSTaxExemptionOutput deleteTaxExemptionOutput = new DeletePartnerUSTaxExemptionOutput();

		try {

			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_18001, Constants.DELETE_TAX_EXEMPTION_API_NAME);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_18005, Constants.DELETE_TAX_EXEMPTION_API_NAME);
			}

			if (customerRef == null || customerRef.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_18002, Constants.DELETE_TAX_EXEMPTION_API_NAME);
			}			
			if (exemptionType == null || exemptionType.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_18004, Constants.DELETE_TAX_EXEMPTION_API_NAME);
			}

			deleteTaxExemptionInput.setIntegratorContext(integratorContext);
			deleteTaxExemptionInput.setCustomerRef(customerRef);
			deleteTaxExemptionInput.setExemptionType(exemptionType);
			
			deleteTaxExemptionStatus=deleteTaxExemptionCall(customerRef, exemptionType);

			if (deleteTaxExemptionStatus.toUpperCase().equals("COMPLETED")) 
				deleteTaxExemptionStatus=Constants.COMPLETED;
			else
				deleteTaxExemptionStatus=Constants.ERROR;
			
			
			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after deletePartnerUSTaxExemption.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of deletePartnerUSTaxExemption is " + diff + "........." + diffStr);
			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
		}

		catch (Exception ex) {
			responseStatus = ex.getMessage();
			deleteTaxExemptionStatus=Constants.ERROR;
			traceLog.traceFinest("Exception from  deletePartnerUSTaxExemption API : " + ex.getMessage());

			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					deleteTaxExemptionInput, deleteTaxExemptionOutput, responseStatus,
					Constants.DELETE_TAX_EXEMPTION_API_NAME, das, diffStr, node);
			throw new ApplicationException(ex.getMessage());
		}
		deleteTaxExemptionOutput.setDeletePartnerUSTaxExemptionOutput(deleteTaxExemptionStatus);
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
				deleteTaxExemptionInput, deleteTaxExemptionOutput, responseStatus,
				Constants.DELETE_TAX_EXEMPTION_API_NAME, das, diffStr, node);

		traceLog.traceFinest("deletePartnerUSTaxExemption method ended ");
		return deleteTaxExemptionStatus;
	}
	
	private String deleteTaxExemptionCall(final String customerRef, final String exemptionType) throws com.convergys.platform.ApplicationException {
		String status = "Pending";
		
		traceLog.traceFinest("Starting deleteTaxExemptionCall ");
		
		ExecutorService es = Executors.newSingleThreadExecutor();
		Future<String> future = es.submit(new Callable<String>() {

			@Override
			public String call() throws Exception {
				 Connection connectionObject = util.getDataSource().getConnection();
				 String st = null;
				 
				 CallableStatement callableStatement = connectionObject.prepareCall(SQLStatements.DELETE_EXEMPTION_PROC);
				 traceLog.traceFinest("customerRef object "+ customerRef);
				 traceLog.traceFinest("exemptionType object "+ exemptionType);
				 
				 
				 	callableStatement.setString(1, customerRef);
					callableStatement.setString(2, exemptionType);
					callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
					callableStatement.registerOutParameter(4, java.sql.Types.VARCHAR);
					traceLog.traceFinest("before execute DELETE_EXEMPTION_PROC");
					callableStatement.execute();
					st = callableStatement.getString(3);
					traceLog.traceFinest("status-----"+st);
					traceLog.traceFinest("after execute DELETE_EXEMPTION_PROC-----"+callableStatement.getString(3)+"@"+callableStatement.getString(4));
					
			return st;
			}
			
		});
		traceLog.traceFinest("future object "+ future);
		es.shutdown();
		
		try {
			status = future.get(50, TimeUnit.SECONDS);
			if(status==null)
			status="Processing";	
		} catch (InterruptedException | ExecutionException  e) {
			status = "Error";
			traceLog.traceFinest("InterruptedException "+ e.getMessage());
		}
		catch (TimeoutException e) {
			status = "Processing";
			traceLog.traceFinest("time out is reached "+ e.getMessage());
			
		}
		catch(Exception e)
		{	traceLog.traceFinest("Exception in deleteTaxExemptionCall -----"+ e.getMessage());
			throw new ApplicationException("Exception in deleteTaxExemptionCall  "+e.getMessage());
		}
		traceLog.traceFinest("End of deleteTaxExemptionCall method status :" + status);		
		
		return status;
		
	}
	
	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

}
