package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.ServiceLocator;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.payment.PaymentService;
import com.convergys.geneva.j2ee.payment.PhysicalPaymentPK;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class CancelPaymentsDao {

	private static TraceLog traceLog = new TraceLog(CancelPaymentsDao.class);
	PaymentService paymentService = null;
	private Util util;

	public CancelPaymentsDao() {
		traceLog.traceFinest(" CancelPaymentsDao:..!!!!!!! ");
	}

	/**
	 * The service shall cancel the physical payments in RB for a customer.
	 * Authorized user can cancel list of physical payments belongs to a
	 * customer
	 * 
	 * @param integratorContext
	 * @param userName
	 * @param cancelledText
	 * @param paymentCancelData
	 * @return String
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * @author sgad2315
	 */
	public java.lang.String cancelPayments(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String userName, java.lang.String cancelledText,
			com.convergys.custom.geneva.j2ee.billingProfile.PaymentCancelData[] paymentCancelData)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.iml.commonIML.ParameterException,
			com.convergys.platform.ApplicationException {
		traceLog.traceFinest("Entered into BillingProfileDao CancelPayments API");
		String status = "Failure";
		try {
			traceLog.traceFinest("Entered into cancelPayments API");
			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CANCEL_PAYMENTS_API_NAME);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CANCEL_PAYMENTS_API_NAME);
			}

			if (paymentCancelData == null || paymentCancelData.length <= 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_5003, Constants.CANCEL_PAYMENTS_API_NAME);
			}

			if (userName == null || userName.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_5001, Constants.CANCEL_PAYMENTS_API_NAME);
			}

			// Setting to Core IntegratorContext_1
			IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
			integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
			integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
			integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
			integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());

			for (PaymentCancelData paymentCancelData1 : paymentCancelData) {
				String customerRef = paymentCancelData1.getCustomerRef();
				traceLog.traceFinest("In the cancelPayments customerRef : " + customerRef);

				String accountNum = paymentCancelData1.getAccountNum();
				traceLog.traceFinest("In the cancelPayments accountNum : " + accountNum);

				int physicalPaymentSeq = paymentCancelData1.getPhysicalPaymentSeq();
				traceLog.traceFinest("In the cancelPayments physicalPaymentSeq : " + physicalPaymentSeq);

				int accountPaymentSeq = paymentCancelData1.getAccountPaymentSeq();
				traceLog.traceFinest("In the cancelPayments accountPaymentSeq : " + accountPaymentSeq);

				PhysicalPaymentPK paymentPK = new PhysicalPaymentPK();
				paymentPK.setCustomerRef(customerRef);
				paymentPK.setPhysicalPaymentSeq(physicalPaymentSeq);
				// paymentPK.setHintNbl(arg0);

				traceLog.traceFinest("In cancelPayments API before Calling the ECA Call");
				PhysicalPaymentPK physicalPaymentPK = getPaymentService().cancelPhysicalPayment_1(integratorContext_1,
						paymentPK, cancelledText);
				traceLog.traceFinest("In cancelPayments API AFTER Calling the ECA Call : " + physicalPaymentPK);

				traceLog.traceFinest("ECA Call physicalPaymentPK CustomerRef : " + physicalPaymentPK.getCustomerRef());
				traceLog.traceFinest(
						"ECA Call physicalPaymentPK PhysicalPaymentSeq : " + physicalPaymentPK.getPhysicalPaymentSeq());

				traceLog.traceFinest("In cancelPayments API before Calling updateAcctPayAttributes");
				updateAcctPayAttributes(accountNum, accountPaymentSeq, userName);
				traceLog.traceFinest("In cancelPayments API AFTER Calling updateAcctPayAttributes");
			}

			status = "Success";

		} catch (Exception e) {
			status = "Faliure";
			throw new ApplicationException(e.getMessage());

		}

		traceLog.traceFinest("In cancelPayments API the Status value: " + status);
		return status;
	}

	/**
	 * This method updates the ACCOUNTPAYATTRIBUTES table with CANCELLED_DTM and
	 * WEB_PORTAL_USER with the given userName for the accountNumber and account
	 * Payment Sequence
	 * 
	 * @param accountNum
	 * @param accountPaymentSeq
	 * @param userName
	 * @author sgad2315
	 */
	public void updateAcctPayAttributes(String accountNum, int accountPaymentSeq, String userName) {

		traceLog.traceFinest("Inside updateAcctPayAttributes before connection");

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int updatedRows = 0;

		try {
			traceLog.traceFinest("In TRY BLOCK");
			connection = util.getDataSource().getConnection();
			preparedStatement = connection.prepareStatement(SQLStatements.UPDATE_ACCT_PAY_ATTRIBUTES);
			preparedStatement.setString(1, userName);
			preparedStatement.setString(2, accountNum);
			preparedStatement.setInt(3, accountPaymentSeq);
			updatedRows = preparedStatement.executeUpdate();
			traceLog.traceFinest("Updated rows updateAcctPayAttributes :" + updatedRows);

		} catch (SQLException se) {
			traceLog.traceFinest("Exception occurred in updateAcctPayAttributes due to : " + se.getMessage());
		} finally {
			util.closeResources(resultSet, connection, preparedStatement, null);
		}
	}

	private PaymentService getPaymentService() {
		if (paymentService != null)
			return paymentService;
		try {
			paymentService = (PaymentService) ServiceLocator.getInstance().getBean("ECA_Payment");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return paymentService;
	}

	public void setPaymentService(PaymentService paymentService) {
		this.paymentService = paymentService;
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

}
