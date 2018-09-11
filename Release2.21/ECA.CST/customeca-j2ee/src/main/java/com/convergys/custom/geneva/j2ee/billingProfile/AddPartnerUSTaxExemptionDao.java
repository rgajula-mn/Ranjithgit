package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.CallableStatement;
import java.sql.Connection;
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
import com.convergys.custom.geneva.j2ee.util.DateUtil;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class AddPartnerUSTaxExemptionDao {
	private static TraceLog traceLog = new TraceLog(AddPartnerUSTaxExemptionDao.class);
	private Util util;
	
	public com.convergys.custom.geneva.j2ee.billingProfile.AddTaxExemptionOutputElements
	  addPartnerUSTaxExemption
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    java.lang.String customerRef,
	    long startDate,
	    long endDateNbl,
	    java.lang.String exemptionType,
	    java.lang.String createdByUser
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException
	    {			
			long startTime = Null.LONG;
			long endTime = Null.LONG;
			long diff = Null.LONG;
			String node = util.getHostName();
			String diffStr = null;
			DataSource das = null;
			startTime = System.currentTimeMillis();
			String responseStatus = null;
			String addTaxExemptionStatus = null;
			String addTaxExemptionDescription = null;
			String[] addTaxExemptionPkgOutput = null;
			traceLog.traceFinest("addPartnerUSTaxExemption method started ...startTime " + startTime);
			
			AddTaxExemptionOutputElements addTaxExemptionOutputElements = new AddTaxExemptionOutputElements();
			AddPartnerUSTaxExemptionInput addTaxExemptionInput = new AddPartnerUSTaxExemptionInput();
			AddPartnerUSTaxExemptionOutput addTaxExemptionOutput = new AddPartnerUSTaxExemptionOutput();

			try {

				if (integratorContext == null || integratorContext.equals("")) {

					throw new NullParameterException(ErrorCodes.ERR_RBM_18001, Constants.Add_TAX_EXEMPTION_API_NAME);
				}
				if (integratorContext.getExternalBusinessTransactionId() == null
						|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
					throw new NullParameterException(ErrorCodes.ERR_RBM_18005, Constants.Add_TAX_EXEMPTION_API_NAME);
				}

				if (customerRef == null || customerRef.equals("")) {

					throw new NullParameterException(ErrorCodes.ERR_RBM_18002, Constants.Add_TAX_EXEMPTION_API_NAME);
				}
				if (startDate == Null.LONG) {
					throw new NullParameterException(ErrorCodes.ERR_RBM_18003, Constants.Add_TAX_EXEMPTION_API_NAME);
				}
				if (exemptionType == null || exemptionType.equals("")) {
					throw new NullParameterException(ErrorCodes.ERR_RBM_18004, Constants.Add_TAX_EXEMPTION_API_NAME);
				}

				addTaxExemptionInput.setIntegratorContext(integratorContext);
				addTaxExemptionInput.setCustomerRef(customerRef);
				addTaxExemptionInput.setStartDate(startDate);
				addTaxExemptionInput.setExemptionType(exemptionType);
				String enDateStr=null;
				String stDateStr = DateUtil.convertDateToString(new Date(startDate));
				if (endDateNbl != Null.LONG)
					enDateStr =	DateUtil.convertDateToString(new Date(endDateNbl));
				traceLog.traceFinest("stDateStr value is  : " + stDateStr);
				traceLog.traceFinest("enDateStr value is  : " + enDateStr);
				
							
				addTaxExemptionPkgOutput=executeProcedure(customerRef, exemptionType, stDateStr, enDateStr, createdByUser).split("@");
				addTaxExemptionStatus=addTaxExemptionPkgOutput[0];
				addTaxExemptionDescription=addTaxExemptionPkgOutput[1];
				
				traceLog.traceFinest("addTaxExemptionStatus.. " + addTaxExemptionStatus);
				traceLog.traceFinest("addTaxExemptionDescription.. " + addTaxExemptionDescription);
				
				addTaxExemptionOutputElements.setStatus(addTaxExemptionStatus);
				addTaxExemptionOutputElements.setDescription(addTaxExemptionDescription);
				
				endTime = System.currentTimeMillis();

				if (traceLog.isFinerEnabled())
					traceLog.traceFinest("End time after addPartnerUSTaxExemption.. " + endTime);

				diff = endTime - startTime;
				diffStr = String.valueOf(diff);

				if (traceLog.isFinerEnabled())
					traceLog.traceFinest(
							"Time taken for the execution of addPartnerUSTaxExemption is " + diff + "........." + diffStr);
				das = util.getDataSource();
				responseStatus = Constants.TRANSACTION_SUCCESS;
			}

			catch (Exception ex) {
				responseStatus = ex.getMessage();
				traceLog.traceFinest("Exception from  addPartnerUSTaxExemption API : " + ex.getMessage());

				BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
						addTaxExemptionInput, addTaxExemptionOutput, responseStatus,
						Constants.Add_TAX_EXEMPTION_API_NAME, das, diffStr, node);
				throw new ApplicationException(ex.getMessage());
			}
			addTaxExemptionOutput.setAddPartnerUSTaxExemptionOutput(addTaxExemptionOutputElements);
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					addTaxExemptionInput, addTaxExemptionOutput, responseStatus,
					Constants.Add_TAX_EXEMPTION_API_NAME, das, diffStr, node);

			traceLog.traceFinest("addPartnerUSTaxExemption method ended ");
			
			return addTaxExemptionOutputElements;
			
			
		    
	    }
	
	private String executeProcedure(final String customerRef, final String exemptionType, final String startDate, final String endDate, final String createdByUser) throws com.convergys.platform.ApplicationException {
		String status = "Pending";
		
		traceLog.traceFinest("Starting  executeProcedure method");
		
		ExecutorService es = Executors.newSingleThreadExecutor();
		Future<String> future = es.submit(new Callable<String>() {

			@Override
			public String call() throws Exception {
				 Connection connectionObject = util.getDataSource().getConnection();
				 String st = null;
				 
				 CallableStatement callableStatement = connectionObject.prepareCall(SQLStatements.ADD_EXEMPTION_PROC);
				 traceLog.traceFinest("customerRef object "+ customerRef);
				 traceLog.traceFinest("exemptionType object "+ exemptionType);
				 
				 traceLog.traceFinest("startDate object "+ startDate);
				 traceLog.traceFinest("endDate object "+ endDate);
				 callableStatement.setString(1, customerRef);
					callableStatement.setString(2, exemptionType);
					callableStatement.setString(3, startDate);
					callableStatement.setString(4, endDate);
					callableStatement.setString(5, createdByUser);
					callableStatement.registerOutParameter(6, java.sql.Types.VARCHAR);
					callableStatement.registerOutParameter(7, java.sql.Types.VARCHAR);
					traceLog.traceFinest("before execute load_exemption_proc");
					callableStatement.execute();
					st = callableStatement.getString(6)+"@"+callableStatement.getString(7);
					traceLog.traceFinest("after execute load_exemption_proc-----"+st);
					
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
		{	traceLog.traceFinest("Exception in executeProcedure -----"+ e.getMessage());
			throw new ApplicationException("Exception in executeProcedure  "+e.getMessage());
		}
		traceLog.traceFinest("End of executeProcedure method status :" + status);		
		
		return status;
		
	}
	
	public Util getUtil() {
		return util;
	}
	public void setUtil(Util util) {
		this.util = util;
	}
	
	

}
