package com.convergys.custom.geneva.j2ee.util;

import java.io.StringWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.namespace.QName;

import oracle.jdbc.OraclePreparedStatement;

import org.springframework.core.task.TaskExecutor;





import com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext;
import com.convergys.custom.geneva.j2ee.util.BillingProfileForm;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.logging.TraceLog;

public class BillingProfileErrorLog {
    private static TraceLog traceLog = new TraceLog(BillingProfileErrorLog.class);
    private static DataSource ds = null;
    //   private static Connection con = null;
    private static TaskExecutor taskExecutorins;
    private static Util utilins;
   

    static {
        InitialContext initCtx = null;

        try {
            initCtx = new InitialContext();
            ds = (javax.sql.DataSource) initCtx.lookup("jdbc/CVG_SEC_TX_DATASOURCE");
            // ds = (javax.sql.DataSource)initCtx.lookup("jdbc/CVG_NON_TX_DATASOURCE");
            // con = ds.getConnection();
        } catch (NamingException e) {
            e.printStackTrace();

        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    /**
     * @param provisioningBillingProfile
     * @throws SQLException
     */

    /**
     * @param provisioningBillingProfile
     * @throws SQLException
     */

    private static void insertTransactonLog(BillingProfileForm billingProfileForm, DataSource das)
            throws SQLException {

        // PreparedStatement ps = null;
        CallableStatement callableStatement = null;
        Connection con = null;
        con = das.getConnection();
        try {
            callableStatement = con.prepareCall(SQLStatements.INSERT_REQUEST_SQL_PROC);
            callableStatement.setDate(1, (Date) billingProfileForm.getCreatedDtm());
            callableStatement.setString(2, billingProfileForm.getWholesaleTransId());
            callableStatement.setString(3, billingProfileForm.getServiceName());
            callableStatement.setString(4, billingProfileForm.getCustomerRef());
            callableStatement.setInt(5, billingProfileForm.getStatus());
            callableStatement.setString(6, billingProfileForm.getEventsource());
            ((OraclePreparedStatement) callableStatement).setStringForClob(7,
                    billingProfileForm.getRequestDetails());
            ((OraclePreparedStatement) callableStatement).setStringForClob(8,
                    billingProfileForm.getResponseDetails());
            callableStatement.setString(9, billingProfileForm.getDuration());
            callableStatement.setString(10, billingProfileForm.getNode());
            callableStatement.execute();
        } catch (SQLException e) {
            if (traceLog.isFinestEnabled())
                traceLog.traceFinest("Exception inside insertTransactonLog:: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(null, con, null, callableStatement);
            }

    }

    /**
     * @param billingProfileForm
     */

    public static void insertTransactonLogInErr(BillingProfileForm billingProfileForm) {
        Connection con = null;
        CallableStatement cs = null;

        try {
            traceLog.traceFinest("Before Connection:: " + con + " ::DataSource::  " + ds);
            con = ds.getConnection();

            cs = con.prepareCall(SQLStatements.INSERT_REQUEST_SQL_PROC);
            traceLog.traceFinest("After Connection:: " + con);
            cs.setDate(1, (Date) billingProfileForm.getCreatedDtm());
            cs.setString(2, billingProfileForm.getWholesaleTransId());
            cs.setString(3, billingProfileForm.getServiceName());
            cs.setString(4, billingProfileForm.getCustomerRef());
            cs.setInt(5, billingProfileForm.getStatus());
            cs.setString(6, billingProfileForm.getEventsource());
            ((OraclePreparedStatement) cs).setStringForClob(7,
                    billingProfileForm.getRequestDetails());
            ((OraclePreparedStatement) cs).setStringForClob(8,
                    billingProfileForm.getResponseDetails());
            cs.setString(9, billingProfileForm.getDuration());
            cs.setString(10, billingProfileForm.getNode());
            traceLog.traceFinest("InsertTransactonLog New before execute:: ");
            cs.execute();
            traceLog.traceFinest("InsertTransactonLog New after execute:: ");

        } catch (Exception e) {
            traceLog.traceFinest("Exception inside insertTransactonLog New after execute:: "
                    + e.getMessage());
            e.printStackTrace();
            //throw new EJBException(e);
        } finally {
            closeResources(null, con, null, cs);
        }
    }

    /**
     * @param integratorContext
     * @param customerRef
     * @param msisdn
     * @param reqObj
     * @param respObject
     * @param responseStatus
     * @param das
     */
    
    public static <T, T1> void insertAPITransactionDetails(final IntegratorContext integratorContext,
    		final java.lang.String customerRef, final java.lang.String msisdn, final T reqObj, final T1 respObject,
    		final String responseStatus, final String serviceName, final DataSource das,final String diff, final String node) {    
        
        taskExecutorins.execute(new Runnable() {
            @Override
            public void run() {
            	traceLog.traceFinest("TaskExecutor-Thread:"+Thread.currentThread().getName()+"  started...");            	
                BillingProfileForm billingProfileForm = new BillingProfileForm();

                traceLog.traceFinest("  responseStatus insertAPITransactionDetails " + responseStatus);
                try {

                    Class c = reqObj.getClass();
                    JAXBElement<T> jaxbElement = new JAXBElement<T>(new QName(c.getSimpleName()), c,
                            (T) reqObj);

                    StringWriter writerRequest = new StringWriter();

                    // create JAXBContext which will be used to update writer      
                    JAXBContext context = JAXBContext.newInstance(reqObj.getClass());

                    // marshall or convert jaxbElement containing object to xml format

                    context.createMarshaller().marshal(jaxbElement, writerRequest);

                    if (traceLog.isFinestEnabled()) {
                        traceLog.traceFinest("In APITransactionDetails Request XML :"
                                + writerRequest.toString());
                    }

                    //UpdateBillingProfileOutput updateBillingProfileOutput = new UpdateBillingProfileOutput();
                    String responseData = null;
                    traceLog.traceFinest("In APITransactionDetails after Intialization");


                                     
                    java.sql.Date gnvdate=utilins.getGnvSystemDate();
                    
                    traceLog.traceFinest("gnvdate="+gnvdate);
            
                    billingProfileForm.setWholesaleTransId(integratorContext.getExternalBusinessTransactionId());
                    billingProfileForm.setCreatedDtm(gnvdate);
                    billingProfileForm.setCustomerRef(customerRef);
                    billingProfileForm.setEventsource(msisdn);
                    billingProfileForm.setServiceName(serviceName);
                    billingProfileForm.setRequestDetails(writerRequest.toString());
                    billingProfileForm.setNode(node);
                    billingProfileForm.setDuration(diff);

                    if (Constants.TRANSACTION_SUCCESS.equals(responseStatus)) {

                        Class c1 = respObject.getClass();
                        JAXBElement<T1> jaxbElement2 = new JAXBElement<T1>(new QName(c1.getSimpleName()),
                                c1, (T1) respObject);

                        StringWriter writerResponse = new StringWriter();

                        // create JAXBContext which will be used to update writer      
                        JAXBContext context2 = JAXBContext.newInstance(respObject.getClass());

                        // marshall or convert jaxbElement containing object to xml format

                        context2.createMarshaller().marshal(jaxbElement2, writerResponse);
                        responseData = writerResponse.toString();
                        if (traceLog.isFinestEnabled()) {
                            traceLog.traceFinest(" Response XML :" + responseData);
                        }
                        billingProfileForm.setStatus(Constants.COMPLETE_STATUS);
                        billingProfileForm.setResponseDetails(responseData);
                        insertTransactonLog(billingProfileForm, das);
                    } else {
                        traceLog.traceFinest("In insertAPITransactionDetails after Intialization in else");
                        responseData = responseStatus;
                        billingProfileForm.setStatus(Constants.ERROR_STATUS);
                        billingProfileForm.setResponseDetails(responseData);
                        insertTransactonLogInErr(billingProfileForm);
                    }

                    traceLog.traceFinest("In insertAPITransactionDetails after insertAPITransactionDetails end of method");
                } catch (Exception e) {
                    if (traceLog.isFinestEnabled())
                        traceLog.traceFinest("Exception inside insertAPITransactionDetails:: "
                                + e.getMessage());
                    e.printStackTrace();
                }
            }
        });

    }

    /**
     * This method is used to close the DB Resources
     * 
     * @param ResultSet
     * @param Connection
     * @param PreparedStatement
     * @param CallableStatement
     */
    public static void closeResources(ResultSet rs, Connection con, PreparedStatement ps,
            CallableStatement cs) {
        if (traceLog.isFinestEnabled())
            traceLog.traceFinest("closeResources method Start");
        if (rs != null) {
            try {
                rs.close();
            } catch (Exception rse) {
                if (traceLog.isFinerEnabled())
                    traceLog.traceFiner("Exception while closing the resultset" + rse);
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (Exception cone) {
                if (traceLog.isFinerEnabled())
                    traceLog.traceFiner("Exception while closing the connection" + cone);
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (Exception pse) {
                if (traceLog.isFinerEnabled())
                    traceLog.traceFiner("Exception while closing the statement" + pse);
            }
        }
        if (cs != null) {
            try {
                cs.close();
            } catch (Exception cse) {
                if (traceLog.isFinerEnabled())
                    traceLog.traceFiner("Exception while closing the callable statement" + cse);
            }
        }
        if (traceLog.isFinestEnabled())
            traceLog.traceFinest("closeResources method Exit");
    }
    public TaskExecutor getTaskExecutorins() {
		return taskExecutorins;
	}

	public void setTaskExecutorins(TaskExecutor taskExecutorins) {
		this.taskExecutorins = taskExecutorins;
	}
	public Util getUtilins() {
		return utilins;
	}

	public void setUtilins(Util utilins) {
		this.utilins = utilins;
	}

}
