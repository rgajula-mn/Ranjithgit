package com.convergys.custom.geneva.j2ee.billingProfile;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.ServiceLocator;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.AttributeField;
import com.convergys.geneva.j2ee.Null;
import com.convergys.geneva.j2ee.account.AccountPK;
import com.convergys.geneva.j2ee.customer.CustomerPK;
import com.convergys.geneva.j2ee.payment.AccountPaymentResult_1;
import com.convergys.geneva.j2ee.payment.NewAccountPaymentData_5;
import com.convergys.geneva.j2ee.payment.PaymentService;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class CreateAccountPaymentsDao {

	private static TraceLog traceLog = new TraceLog(CreateAccountPaymentsDao.class);
	PaymentService paymentService = null;
	private Util util;

	public CreateAccountPaymentsDao() {
		traceLog.traceFinest(" CreateAccountPaymentsDao:..!!!!!!! ");
	}

	/**
	 * The service shall create the Account Payment in RB. This will update the
	 * payment details in RB key tables i.e. AccountPayment and PysicalPayment
	 * tables. The user and additional transaction related details will be
	 * logged into ecaaudittrail table
	 * 
	 * @param integratorContext
	 * @param accountNum
	 * @param userName
	 * @param newAccountPaymentData
	 * @return AccountPaymentResult
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @author sgad2315
	 */
	public com.convergys.custom.geneva.j2ee.billingProfile.AccountPaymentResult createAccountPayments(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String accountNum, java.lang.String userName,
			com.convergys.custom.geneva.j2ee.billingProfile.NewAccountPaymentData newAccountPaymentData)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.platform.ApplicationException,
			com.convergys.iml.commonIML.ParameterException {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("Entered into createAccountPayments API...startTime.. " + startTime);
		}

		traceLog.traceFinest("Entered into createAccountPayments API");
		traceLog.traceFinest("In createAccountPayments accountNum: " + accountNum);
		traceLog.traceFinest("In createAccountPayments userName: " + userName);

		AccountPaymentResult accountPaymentResult = new AccountPaymentResult();
		DataSource das = null;
		String responseStatus = null;

		CreateAccountPaymentsOutput accountPaymentsOutput = new CreateAccountPaymentsOutput();
		CreateAccountPaymentsInput accountPaymentsInput = new CreateAccountPaymentsInput();
		accountPaymentsInput.setIntegratorContext(integratorContext);
		accountPaymentsInput.setAccountNum(accountNum);
		accountPaymentsInput.setUserName(userName);
		accountPaymentsInput.setNewAccountPaymentData(newAccountPaymentData);
		try {

			if (integratorContext == null || integratorContext.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME);
			}

			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME);
			}

			if (accountNum == null || accountNum.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1005, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME);
			}

			if (userName == null || userName.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_5001, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME);
			}
			if (newAccountPaymentData == null) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_5002, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME);
			}

			String customerRef = newAccountPaymentData.getPhysicalCustomerRef();
			traceLog.traceFinest("In createAccountPayments customerRef: " + customerRef);

			long paymentdate = newAccountPaymentData.getPaymentdateNbl();
			traceLog.traceFinest("In createAccountPayments paymentdate: " + paymentdate);
			if (paymentdate == Null.LONG) {
				traceLog.traceFinest("In createAccountPayments paymentdate from gnvDate : " + paymentdate);
				paymentdate = util.getGnvSystemDate().getTime();
				traceLog.traceFinest("In createAccountPayments paymentdate from gnvDate in long : " + paymentdate);
			}

			long paymentMny = newAccountPaymentData.getPaymentMny();
			traceLog.traceFinest("In createAccountPayments paymentMny: " + paymentMny);

			int paymentMethodId = newAccountPaymentData.getPaymentMethodId();
			traceLog.traceFinest("In createAccountPayments paymentMethodId: " + paymentMethodId);

			long createdDtm = newAccountPaymentData.getCreatedDtmNbl();
			traceLog.traceFinest("In createAccountPayments createdDtm: " + createdDtm);
			if (createdDtm == Null.LONG) {
				traceLog.traceFinest("In createAccountPayments createdDtm from gnvDate : " + createdDtm);
				createdDtm = util.getGnvSystemDate().getTime();
				traceLog.traceFinest("In createAccountPayments createdDtm from gnvDate in long : " + createdDtm);
			}

			// Setting to Core IntegratorContext_1
			IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
			integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
			integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
			integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
			integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());

			das = util.getDataSource();

			AccountPK accountPK = new AccountPK();
			accountPK.setAccountNum(accountNum);

			CustomerPK custPK = new CustomerPK();
			custPK.setCustomerRef(customerRef);

			AttributeField[] attributeFieldArray = new AttributeField[2];
			AttributeField attributeField_1 = new AttributeField();
			// Adding the Portal User
			attributeField_1.setFieldIndex(0);
			attributeField_1.setFieldType(0);
			attributeField_1.setFieldLength(20);
			attributeField_1.setFieldValueString(userName);
			attributeFieldArray[0] = attributeField_1;

			// Adding the Create Date
			AttributeField attributeField_2 = new AttributeField();
			attributeField_2.setFieldIndex(1);
			attributeField_2.setFieldType(1);
			attributeField_2.setFieldLength(40);
			attributeField_2.setFieldValueDtmNbl(newAccountPaymentData.getCreatedDtmNbl());
			attributeFieldArray[1] = attributeField_2;

			NewAccountPaymentData_5 newAccountPaymentData_5 = new NewAccountPaymentData_5();
			newAccountPaymentData_5.setWhenDtm(paymentdate);
			newAccountPaymentData_5.setPaymentMny(paymentMny);
			newAccountPaymentData_5.setCreatedDtm(createdDtm);
			newAccountPaymentData_5.setPaymentMethodIdNbl(paymentMethodId);
			newAccountPaymentData_5.setPaymentCurrency("USD");
			newAccountPaymentData_5.setCustomerPK(custPK);
			newAccountPaymentData_5.setAccountPaymentAttributesArray(attributeFieldArray);

			if (newAccountPaymentData.getPaymentRef() != null) {
				newAccountPaymentData_5.setPaymentRef(newAccountPaymentData.getPaymentRef());
			}

			if (newAccountPaymentData.getPaymentTxt() != null) {
				newAccountPaymentData_5.setPaymentTxt(newAccountPaymentData.getPaymentTxt());
			}

			// TODO test by changing the refundBoo value
			if (newAccountPaymentData.getRefundBoo() != null) {
				newAccountPaymentData_5.setRefundBoo(newAccountPaymentData.getRefundBoo());
			}

			traceLog.traceFinest("In createAccountPayments API before Calling the ECA Call");

			AccountPaymentResult_1 result = getPaymentService().createAccountPayment_5(integratorContext_1, accountPK,
					newAccountPaymentData_5, Null.INT);

			accountPaymentResult.setAccountNum(result.getAccountPaymentPK().getAccountNum());
			accountPaymentResult.setAccountPaymentSeqNbl(result.getAccountPaymentPK().getAccountPaymentSeq());
			accountPaymentResult.setPhysicalPaymentSeqNbl(result.getPhysicalPaymentSeqNbl());
			traceLog.traceFinest("In createAccountPayments API after Calling the ECA Call");

			responseStatus = Constants.TRANSACTION_SUCCESS;
			accountPaymentsOutput.setAccountPaymentResult(accountPaymentResult);

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after createAccountPayments.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of createAccountPayments is " + diff + "........." + diffStr);

			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, accountPaymentsInput,
					accountPaymentsOutput, responseStatus, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME, das, diffStr,
					node);

		} catch (Exception e) {
			responseStatus = e.getMessage();
			traceLog.traceFinest("Exception from createAccountPayments API : " + e.getMessage());
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, accountPaymentsInput,
					accountPaymentsOutput, responseStatus, Constants.CREATE_ACCOUNT_PAYMENTS_API_NAME, das, diffStr,
					node);
			throw new ApplicationException(e.getMessage());
		}

		traceLog.traceFinest("END of createAccountPayments API returing accountPaymentResult");
		return accountPaymentResult;
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
