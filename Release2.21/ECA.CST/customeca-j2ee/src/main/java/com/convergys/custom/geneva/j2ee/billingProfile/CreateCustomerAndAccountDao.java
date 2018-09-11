package com.convergys.custom.geneva.j2ee.billingProfile;



import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.AttributeDefination;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.Constants.PartnerAccountType;
import com.convergys.custom.geneva.j2ee.util.DateUtil;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.HashMapPlus;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.AttributeField;
import com.convergys.geneva.j2ee.Null;
import com.convergys.geneva.j2ee.account.AccountPK;
import com.convergys.geneva.j2ee.account.NewAccountData_19;
import com.convergys.geneva.j2ee.address.r5_1.NewAddressData;
import com.convergys.geneva.j2ee.contact.r5_1.NewContactData;
import com.convergys.geneva.j2ee.contact.r5_1.NewHistoriedContactData;
import com.convergys.geneva.j2ee.customer.CustomerPK;
import com.convergys.geneva.j2ee.customer.CustomerService;
import com.convergys.geneva.j2ee.customer.NewCustomerData_8;
import com.convergys.geneva.j2ee.customer.r5_3.CreateCustomerAndAccountResult;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

import oracle.jdbc.OracleTypes;

public class CreateCustomerAndAccountDao {
	private static TraceLog traceLog = new TraceLog(CreateCustomerAndAccountDao.class);
	private Util util;
	
	
	
	
	AttributeField[] billingAccountAttributesArray = null;
	AttributeField[] ratingAccountAttributesArray = null;
	NewAddressData billingAddressdata = null;
	NewAddressData ratingAddressdata = null;
	Map<String, String> billingAcctAttrMap = null;
	String billingCustomerRef ;
	String ratingCustomerRef ;
	String billingAccountNum;
	String ratingAccountNum ;
	int mrkt_segment_id;
	NewAccountData_19 billingAccountData;
	NewAccountData_19 ratingAccountData;
	NewCustomerData_8 billingCustomerData;
	NewCustomerData_8 ratingCustomerData;
	String partnerAcctType;
	String partnerName;
	String eventProfileDispatcher;
	Date gnvdate;
	String isDemoAcct;
	String jcode="";
	String shortName = "";

	
	public CreateCustomerAndAccountOutputElements createCustomerAndAccount(IntegratorContext integratorContext,
			NewCustomerAndAccountData newCustomerAndAccountData, NewAddress newAddress,
			AccountAttributes accountAttributes, NewCustomData[] newCustomDataArray)  
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
		
		traceLog.traceFinest("createCustomerAndAccount method started ...startTime " + startTime);
		
		CreateCustomerAndAccountOutputElements createCustomerAndAccountOutputElements = null;
	
		CreateCustomerAndAccountInput createCustomerAndAccountInput = new CreateCustomerAndAccountInput();
		CreateCustomerAndAccountOutput createCustomerAndAccountOutput = new CreateCustomerAndAccountOutput();

		try {

			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			
			//newCustomerAndAccountData validations
			if (newCustomerAndAccountData == null || newCustomerAndAccountData.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20000, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newCustomDataArray == null || newCustomDataArray.length == 0) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20003, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			
			if (newCustomerAndAccountData.getBillingAccountName() == null || newCustomerAndAccountData.getBillingAccountName().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20005, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newCustomerAndAccountData.getCompanyName() == null || newCustomerAndAccountData.getCompanyName().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20037, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newCustomerAndAccountData.getStartDtm() == Null.LONG) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_20010, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newCustomerAndAccountData.getRequestedBillCycleRunDate() <= 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_20038, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newCustomerAndAccountData.getPartnerAccountType() == null || newCustomerAndAccountData.getRequestedBillCycleRunDate() <= 0 || -1 == validatePartnerAccountType(newCustomerAndAccountData.getPartnerAccountType())) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_20039, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			
			if (newCustomerAndAccountData.getPartnerDUFFrequency() == null || newCustomerAndAccountData.getPartnerDUFFrequency().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_20042, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			//Address validations
			if (newAddress == null || newAddress.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20001, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newAddress.getNewBillingAddressData() == null || newAddress.getNewBillingAddressData().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20007, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}				
			if (newAddress.getNewBillingAddressData().getCountryId() == Null.INT) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20011, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newAddress.getNewBillingAddressData().getAddressLine1() == null || newAddress.getNewBillingAddressData().getAddressLine1().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20012, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			
			if (newAddress.getNewBillingAddressData().getAddressLine3() == null || newAddress.getNewBillingAddressData().getAddressLine3().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20014, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (newAddress.getNewBillingAddressData().getAddressLine4() == null || newAddress.getNewBillingAddressData().getAddressLine4().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20015, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
						
			if (newAddress.getNewBillingAddressData().getZipcode() == null || newAddress.getNewBillingAddressData().getZipcode().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20017, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}				
			if (newAddress.getNewBillingAddressData().getUSTJcode() == null || newAddress.getNewBillingAddressData().getUSTJcode().equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20018, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			
			
			//accountAttributes validations
			if (accountAttributes == null || accountAttributes.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20002, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			if (accountAttributes.getBillingAccountAttributes() == null || accountAttributes.getBillingAccountAttributes().length == 0) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20021, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}
			//new custom data validation
			if (newCustomDataArray == null || newCustomDataArray.length == 0) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_20021, Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME);
			}

			createCustomerAndAccountInput.setIntegratorContext(integratorContext);
			createCustomerAndAccountInput.setNewCustomerAndAccountData(newCustomerAndAccountData);
			createCustomerAndAccountInput.setNewAddress(newAddress);
			createCustomerAndAccountInput.setAccountAttributes(accountAttributes);
			createCustomerAndAccountInput.setNewCustomDataArray(newCustomDataArray);
			
			createCustomerAndAccountOutputElements = createCustRefAndAccountNum(integratorContext,newCustomerAndAccountData, newAddress, accountAttributes, newCustomDataArray);
			createCustomerAndAccountOutput.setCreateCustomerAndAccountOutput(createCustomerAndAccountOutputElements);
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
			responseStatus = Constants.FAIL_STATUS;
			String error_message =ex.getMessage(); 
			traceLog.traceFinest("Exception from  createCustomerAndAccount API : " + ex.getMessage());
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					createCustomerAndAccountInput, createCustomerAndAccountOutput, responseStatus,
					Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME, das, diffStr, node);
			throw new ApplicationException(error_message);
		}
		
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
				createCustomerAndAccountInput, createCustomerAndAccountOutput, responseStatus,
				Constants.CREATE_CUSTOMER_AND_ACCOUNT_API_NAME, das, diffStr, node);

		traceLog.traceFinest("createCustomerAndAccount method ended ");
		return createCustomerAndAccountOutputElements;
	
	

}
	private CreateCustomerAndAccountOutputElements createCustRefAndAccountNum(IntegratorContext integratorContext, NewCustomerAndAccountData newCustomerAndAccountData, NewAddress newAddress,
			AccountAttributes accountAttributes, NewCustomData[] newCustomDataArray) throws ApplicationException {
		
		CreateCustomerAndAccountOutputElements createCustomerAndAccountOutputElements = new CreateCustomerAndAccountOutputElements();
		CustomerAndAccountInfo billingCustomerAndAccountInfo = null;
		CustomerAndAccountInfo ratingCustomerAndAccountInfo = null;
		Map<String, ColumnDetails[]> customMapData = null;
		customMapData = validateCustomData(newCustomDataArray);
		traceLog.traceFinest("Before newAddress.getNewBillingAddressData().getUSTJcode()"+ newAddress.getNewBillingAddressData().getUSTJcode());
		newAddress.getNewBillingAddressData().setUSTJcode(newAddress.getNewBillingAddressData().getUSTJcode() != null ? newAddress.getNewBillingAddressData().getUSTJcode().replaceAll("-","") : newAddress.getNewBillingAddressData().getUSTJcode());
		traceLog.traceFinest("after newAddress.getNewBillingAddressData().getUSTJcode()"+ newAddress.getNewBillingAddressData().getUSTJcode());
		loadAccountAttributes(accountAttributes,newAddress);
		loadAddress(newAddress);
		NewContactData newContactData = createContact(newCustomerAndAccountData);
		loadCustomer(newCustomerAndAccountData);
		loadAccount(newCustomerAndAccountData);
		// Setting to Core IntegratorContext_1
		IntegratorContext_1 integratorContext_1 = getCoreIntegratorContext(integratorContext);
		if(newContactData == null || billingCustomerData == null || billingAddressdata == null || billingAccountData == null || billingAccountAttributesArray == null ) {
			throw new ApplicationException(ErrorCodes.ERR_RBM_20034);
		}
		
		//call core API for creating billing customer and account
		traceLog.traceFinest("calling  core API for creating rating cust and account");
		if(ratingAddressdata != null && ratingAccountAttributesArray !=null && ratingAccountAttributesArray.length>0){
			ratingCustomerAndAccountInfo = callCoreAPI(integratorContext_1,ratingCustomerData,ratingAccountData,newContactData,ratingAddressdata,ratingAccountAttributesArray);
		} else
		{
			ratingCustomerAndAccountInfo = callCoreAPI(integratorContext_1,ratingCustomerData,ratingAccountData,newContactData,billingAddressdata,billingAccountAttributesArray);
		}
		
		//call core API for creating billing customer and account
		traceLog.traceFinest("calling  core API for creating billing cust and account");
		billingCustomerAndAccountInfo = callCoreAPI(integratorContext_1,billingCustomerData,billingAccountData,newContactData,billingAddressdata,billingAccountAttributesArray);
				
		createCustomerAndAccountOutputElements.setBillingInfo(billingCustomerAndAccountInfo);
		createCustomerAndAccountOutputElements.setRatingInfo(ratingCustomerAndAccountInfo);
		eventProfileDispatcher = Integer.toString(getPartnerDUFFrequencyIntegerValue(newCustomerAndAccountData.getPartnerDUFFrequency()));
		for(String tableName : customMapData.keySet()) {
			insertCustomData(tableName, customMapData.get(tableName));
		}
		
		
		return createCustomerAndAccountOutputElements;
		
		
	}
	
	
	
	
	private CustomerAndAccountInfo callCoreAPI(IntegratorContext_1 integratorContext_1, NewCustomerData_8 customerData,
			NewAccountData_19 accountData, NewContactData newContactData, NewAddressData addressdata,
			AttributeField[] accountAttributesArray) throws ApplicationException {
		traceLog.traceFinest("callCoreAPI values cust : " + customerData.toString() + " account " + accountData.toString() + " cotact " 
			+ newContactData.toString() + " Addressdata " + addressdata.toString() + " Accountattributes " + accountAttributesArray.toString());
		CreateCustomerAndAccountResult createCustomerAndAccountResult = null;
		CustomerService customerService = util.getCustomerService();
		CustomerAndAccountInfo customerAndAccountInfo = new CustomerAndAccountInfo();
		try {
			createCustomerAndAccountResult = customerService.createCustomerAndAccount_19(integratorContext_1,
					customerData, accountData, newContactData, addressdata, null,
					accountAttributesArray, Constants.ASSIGN_HOLIDAY_PROFILE_BOO,
					Constants.CREATE_DEPOSIT_BALANCE_BOO);
			customerAndAccountInfo.setCustomer_Ref(createCustomerAndAccountResult.getCustomerPK().getCustomerRef());
			customerAndAccountInfo.setAccount_Num(createCustomerAndAccountResult.getAccountPK().getAccountNum());
		} catch (RemoteException | com.convergys.geneva.j2ee.ApplicationException e) {
			traceLog.traceFinest(ErrorCodes.ERR_RBM_20035 + e.getMessage());
			e.printStackTrace();
			throw new ApplicationException(ErrorCodes.ERR_RBM_20035 + " " +e.getMessage());

		}
		return customerAndAccountInfo;

	}
	private void loadCustomer(NewCustomerAndAccountData newCustomerAndAccountData) throws ApplicationException {
		traceLog.traceFinest("loadCustomer method started");
		isDemoAcct="N";
		traceLog.traceFinest("isDemoAcct1>>>>>"+isDemoAcct);
		traceLog.traceFinest("IsDemoPartner>>>>>"+newCustomerAndAccountData.getIsDemoPartner());
		if(newCustomerAndAccountData.getIsDemoPartner()) {
			traceLog.traceFinest("if cond- DemoPartner=true>>>>>");
			isDemoAcct = "Y";
		}
		traceLog.traceFinest("isDemoAcct2>>>>>"+isDemoAcct);
		getAutoCustomerAndAccount(shortName);
		if(billingCustomerRef == null || ratingCustomerRef == null || billingAccountNum == null || ratingAccountNum == null 
				|| mrkt_segment_id == com.convergys.core.Null.INT || mrkt_segment_id == 0) {
			throw new ApplicationException(ErrorCodes.ERR_RBM_20032);
		}
		billingCustomerData = createCustomer(newCustomerAndAccountData,billingCustomerRef);
		ratingCustomerData  = createCustomer(newCustomerAndAccountData,ratingCustomerRef);		
		traceLog.traceFinest("loadCustomer method ended-isDemoAcct :"+isDemoAcct);
	}
	private void loadAccount(NewCustomerAndAccountData newCustomerAndAccountData) throws ApplicationException {
		traceLog.traceFinest("loadAccount method started");
		billingAccountData = createAccount(newCustomerAndAccountData, billingAccountNum,billingCustomerRef, Constants.BILLING_ACCOUNT_BILL_STYLE_ID,false);
		ratingAccountData = createAccount(newCustomerAndAccountData, ratingAccountNum,ratingCustomerRef, Constants.RATING_ACCOUNT_BILL_STYLE_ID,true);
		traceLog.traceFinest("loadAccount method ended");
	}
	private NewAccountData_19 createAccount(NewCustomerAndAccountData newCustomerAndAccountData, String accountNum, String customerRef, int accountBillStyleId,boolean eventDispatch) throws ApplicationException {
		NewAccountData_19 newAccountData_19 = new NewAccountData_19();
		traceLog.traceFinest("createAccount method started");
		try {
			AccountPK accountPK = new AccountPK();
			accountPK.setAccountNum(accountNum);
			newAccountData_19.setAccountPK(accountPK);
			CustomerPK customerPK = new CustomerPK();
			customerPK.setCustomerRef(customerRef);
			newAccountData_19.setCustomerPK(customerPK);
			newAccountData_19.setAccountName(newCustomerAndAccountData.getBillingAccountName());
			newAccountData_19.setTicketBoo(Constants.TICKET_BOO);
			newAccountData_19.setCurrencyCode(Constants.CURRENCY_CODE);
			newAccountData_19.setGoLiveDtmNbl(newCustomerAndAccountData.getStartDtm());
			newAccountData_19.setBillStyleId(accountBillStyleId);
			newAccountData_19.setPaymentMethodId(Constants.PAYMENT_METHOD_ID);
			newAccountData_19.setCreditClassId(Constants.CREDIT_CLASS_ID);
			newAccountData_19.setCreditLimitMnyNbl(Constants.CREDIT_LIMIT_MNY);
			newAccountData_19.setPrePayBoo(Constants.PREPAY_BOO);
			newAccountData_19.setAccountingMethod(Constants.ACCOUNTING_METHOD);
			newAccountData_19.setTaxInclusiveBoo(Constants.TAX_INCLUSIVE_BOO);
			newAccountData_19.setAutoDeleteBilledEventsBoo(Constants.AUTO_DELETE_BILLED_EVENTS_BOO);
			newAccountData_19.setUSTAccountClassIdNbl(Constants.UST_ACCOUNTCLASS_ID);
			newAccountData_19.setInvoicingCoId(Constants.INVOICING_CO_ID);
			newAccountData_19.setBillPeriodNbl(Constants.BILL_PERIOD);
			newAccountData_19.setBillsPerStatementNbl(Constants.BILLSPERSTATEMENT);
			newAccountData_19.setBillPeriodUnitsNbl(Constants.BILL_PERIOD_UNITS);
			if (newCustomerAndAccountData.getRequestedBillCycleRunDate() > 0) {
			    //For Ticket- 74321
				Date date=DateUtil.convertDayIntoDateFormat(newCustomerAndAccountData.getRequestedBillCycleRunDate(), util.getGnvSystemDate());
				newAccountData_19.setNextBillDtmNbl(date.getTime());
			}
			newAccountData_19.setEventsPerDay(Constants.EVENTSPERDAY);
			newAccountData_19.setMaskBillBoo(Constants.MASK_BILL_BOO);
			newAccountData_19.setMaskStoreBoo(Constants.MASK_STORE_BOO);
			newAccountData_19.setReGuidedMaskBillBoo(Constants.REGUIDED_MASK_BILL_BOO);
			newAccountData_19.setReGuidedMaskStoreBoo(Constants.REGUIDED_MASK_STORE_BOO);
			newAccountData_19.setLanguageId(Constants.LANGUAGE_ID);
			if(eventDispatch){
				newAccountData_19.setEventDispatchProfileIdNbl(getPartnerDUFFrequencyIntegerValue(newCustomerAndAccountData.getPartnerDUFFrequency()));
				newAccountData_19.setAggregateStartDatNbl(newCustomerAndAccountData.getStartDtm());
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
			throw new ApplicationException(ErrorCodes.ERR_RBM_20033 + e.getMessage());
		}
		traceLog.traceFinest("createAccount method ended");
		return newAccountData_19;
	}
	private void getAutoCustomerAndAccount(String partner_name) throws ApplicationException {
		traceLog.traceFinest("getAutoCustomerAndAccount method started");
		String sql = SQLStatements.GET_CUSTOMRREF_ACCOUNNUM;
		traceLog.traceFinest("Printing the SQL " + sql);
		Connection connection = null;
		CallableStatement callableStatement = null;

		if (sql == null || !sql.toUpperCase().startsWith("{") || !sql.toUpperCase().contains("CALL")) {
			throw new RuntimeException("SQL is null or not start with { or not contain CALL :" + sql);
		}

		try {
			connection = util.getDataSource().getConnection();
			callableStatement = connection.prepareCall(sql);

			callableStatement.setString(1, partner_name);
			callableStatement.registerOutParameter(2, OracleTypes.VARCHAR);
			callableStatement.registerOutParameter(3, OracleTypes.VARCHAR);
			callableStatement.registerOutParameter(4, OracleTypes.VARCHAR);
			callableStatement.registerOutParameter(5, OracleTypes.VARCHAR);
			callableStatement.registerOutParameter(6, OracleTypes.NUMBER);
			
			callableStatement.executeUpdate();
			 billingCustomerRef = callableStatement.getString(2);
			 traceLog.traceFinest("billingCustomerRef value : " + billingCustomerRef);
			 ratingCustomerRef = callableStatement.getString(3);
			 traceLog.traceFinest("ratingCustomerRef value : " + ratingCustomerRef);
			 billingAccountNum = callableStatement.getString(4);
			 traceLog.traceFinest("billingAccountNum value : " + billingAccountNum);
			 ratingAccountNum = callableStatement.getString(5);
			 traceLog.traceFinest("ratingAccountNum value : " + ratingAccountNum);
			 mrkt_segment_id = callableStatement.getInt(6);
			 traceLog.traceFinest("mrkt_segment_id value : " + mrkt_segment_id);
		}catch(SQLException e) {
			traceLog.traceFinest("error in getAutoCustomerAndAccount method " + e.getMessage());
			e.printStackTrace();
			throw new ApplicationException(ErrorCodes.ERR_RBM_20031 + e.getMessage());
		}
		traceLog.traceFinest("getAutoCustomerAndAccount method ended");
			
		
	}
	private NewContactData createContact(NewCustomerAndAccountData newCustomerAndAccountData) {
		traceLog.traceFinest("createContact method started");
		NewContactData newContactData = new NewContactData();
		newContactData.setContactTypeId(Constants.CONTACT_TYPE_ID);
		newContactData.setLanguageId(Constants.LANGUAGE_ID);
		NewHistoriedContactData historiedContactData = new NewHistoriedContactData();
		gnvdate = util.getGnvSystemDate();
		historiedContactData.setStartDat(gnvdate.getTime());
		historiedContactData.setDaytimeContactTel(newCustomerAndAccountData.getTelephoneNumber());
		newContactData.setNewHistoriedContactData(historiedContactData);
		traceLog.traceFinest("createContact method ended");
		
		return newContactData;
		
	}
	private void loadAddress(NewAddress newAddress) {
		traceLog.traceFinest("loadAddress method started");
		billingAddressdata = createAddress(newAddress.getNewBillingAddressData());
		if(newAddress.getNewDataCentreAddressData() != null) {
			ratingAddressdata = createAddress(newAddress.getNewDataCentreAddressData());
		}
		traceLog.traceFinest("loadAddress method ended");
	}
	
	private NewAddressData createAddress(NewAddressDataDetails newAddressDataDetails) {
		traceLog.traceFinest("createAddress method started");
		NewAddressData newAddressData = new NewAddressData();
		newAddressData.setCountryId(newAddressDataDetails.getCountryId());
		newAddressData.setAddressFormatId(Constants.ADDRESS_FORMAT_ID);
		newAddressData.setZipcode(newAddressDataDetails.getZipcode());
		String[] addressLines = new String[5];
		addressLines[0] = newAddressDataDetails.getAddressLine1();
		addressLines[1] = newAddressDataDetails.getAddressLine2();
		addressLines[2] = newAddressDataDetails.getAddressLine3();
		addressLines[3] = newAddressDataDetails.getAddressLine4();
		addressLines[4] = newAddressDataDetails.getAddressLine5();
		newAddressData.setAddressLines(addressLines);
		//newAddressData.setUSTJcode(newAddressDataDetails.getUSTJcode());
		newAddressData.setUSTJcode(newAddressDataDetails.getUSTJcode() != null ? newAddressDataDetails.getUSTJcode().replaceAll("-","") : newAddressDataDetails.getUSTJcode());
		newAddressData.setUSTIncityBoo(Constants.USTINCITYBOO);
		traceLog.traceFinest("createAddress method ended");
		return newAddressData;
		
	}
	private void loadAccountAttributes(AccountAttributes accountAttributes,NewAddress newAddress) throws ApplicationException {
		traceLog.traceFinest("loadAccountAttributes method started");
		jcode=newAddress.getNewBillingAddressData().getUSTJcode();
		billingAcctAttrMap = validateAccountAttributes(accountAttributes.getBillingAccountAttributes());
		partnerName = billingAcctAttrMap.get(Constants.ACC_ATTR_PARTNER_NAME).substring(0, 1).toUpperCase() 
				+ billingAcctAttrMap.get(Constants.ACC_ATTR_PARTNER_NAME).substring(1).toLowerCase();
		partnerName = partnerName.replace(" ","_");
		/*if(partnerAcctType.contains(Constants.IOT)) {
			partnerName = partnerName + Constants.UNDERSCORE + Constants.IOT;	
		}*/
		Map<String,AttributeDefination> attributeDefinationMap = loadAccountAttributesDefinition();
		if (billingAcctAttrMap != null) {
			billingAccountAttributesArray = createAccountAttributes(billingAcctAttrMap,attributeDefinationMap);
		}
		if(accountAttributes.getRatingAccountAttributes() != null) {
			if(newAddress.getNewDataCentreAddressData() != null && newAddress.getNewDataCentreAddressData().getUSTJcode() != null) {
				//jcode=newAddress.getNewDataCentreAddressData().getUSTJcode();
				jcode=newAddress.getNewDataCentreAddressData().getUSTJcode() != null ? newAddress.getNewDataCentreAddressData().getUSTJcode().replaceAll("-","") : newAddress.getNewDataCentreAddressData().getUSTJcode();
			}
			Map<String, String> RatingAcctAttrMap = validateAccountAttributes(accountAttributes.getRatingAccountAttributes());
			ratingAccountAttributesArray = createAccountAttributes(RatingAcctAttrMap,attributeDefinationMap);
			
		}
		traceLog.traceFinest("loadAccountAttributes method ended");
		
	}
	
	private AttributeField[] createAccountAttributes(Map<String,String> AcctAttrMap, Map<String,AttributeDefination> attributeDefinationMap) throws ApplicationException {
		traceLog.traceFinest("createAccountAttributes method started");
		List<AttributeField> billingAccountAttributesList = new ArrayList<AttributeField>(AcctAttrMap.size());
		for (String attrName : AcctAttrMap.keySet()) {
			AttributeField attributeField = new AttributeField();
			if (attributeDefinationMap.containsKey(attrName) && AcctAttrMap.get(attrName)
					.length() <= attributeDefinationMap.get(attrName).getFieldLength()) {
				
				attributeField.setFieldName(attrName);
				attributeField.setFieldIndex(attributeDefinationMap.get(attrName).getFieldIndex());
				attributeField.setFieldLength(attributeDefinationMap.get(attrName).getFieldLength());
				attributeField.setFieldValueString(AcctAttrMap.get(attrName));
			} else {
				throw new ApplicationException(ErrorCodes.ERR_RBM_20030 + " Attribue Name: "+ attrName);

			}
			billingAccountAttributesList.add(attributeField);
		}
		AttributeField[] AccountAttributesArray =  billingAccountAttributesList.toArray(new AttributeField[billingAccountAttributesList.size()] );
		traceLog.traceFinest("createAccountAttributes method ended");
		return AccountAttributesArray;
		
	}
	private NewCustomerData_8 createCustomer(NewCustomerAndAccountData newCustomerAndAccountData, String customerRef) throws ApplicationException {
		traceLog.traceFinest("createCustomer method started");
		NewCustomerData_8  newCustomerData_8 = new NewCustomerData_8();
		CustomerPK customerPK = new CustomerPK();
		customerPK.setCustomerRef(customerRef);
		customerPK.setHintNbl(0);
		newCustomerData_8.setCustomerPK(customerPK);
		newCustomerData_8.setCustomerTypeId(validatePartnerAccountType(newCustomerAndAccountData.getPartnerAccountType()));
		newCustomerData_8.setInvoicingCoIdNbl(Constants.INVOICING_CO_ID);
		newCustomerData_8.setMarketSegmentIdNbl(mrkt_segment_id);
		newCustomerData_8.setConcatenateBillsBoo(Constants.CONCATENATE_BILLS_BOO);
		newCustomerData_8.setCompanyName(newCustomerAndAccountData.getCompanyName());
		traceLog.traceFinest("createCustomer method ended");
		return newCustomerData_8;
		
	}
	private Map<String, ColumnDetails[]> validateCustomData(NewCustomData[] newCustomDataArray) throws ApplicationException{
		traceLog.traceFinest("validateCustomData method started");
		 Map<String,ColumnDetails[]> customDataMap = new HashMap<String,ColumnDetails[]>();
		for(int i=0;i<newCustomDataArray.length;i++) {
			if(customDataMap.containsKey(newCustomDataArray[i].getTableName().trim())) {
				List<ColumnDetails> list = Arrays.asList(customDataMap.get(newCustomDataArray[i].getTableName()));
				list.addAll(Arrays.asList(newCustomDataArray[i].getColumnDataArray()));
				ColumnDetails[] columnDetailsArr = list.toArray(new ColumnDetails[list.size()]);
				
				customDataMap.put(newCustomDataArray[i].getTableName().trim(), columnDetailsArr);
			}
			else
			{
				customDataMap.put(newCustomDataArray[i].getTableName().trim(), newCustomDataArray[i].getColumnDataArray());
			}
		}
		
		if(! (customDataMap.containsKey(Constants.TMO_ACCT_MAPPING_TABLE))) {
			
			throw new ApplicationException(ErrorCodes.ERR_RBM_20027);
		}
		ColumnDetails[] coludetailsArray= customDataMap.get(Constants.TMO_ACCT_MAPPING_TABLE);
		List<String> columnNameList = new ArrayList<String>();
		for(int y=0;y<coludetailsArray.length;y++) {
			columnNameList.add(coludetailsArray[y].getColumnName());
			if(coludetailsArray[y].getColumnName().equalsIgnoreCase(Constants.SHORTNAME)) {
				shortName = coludetailsArray[y].getColumnValue();
			}
		}
		if(!(columnNameList.contains(Constants.DAILY_DIR)&&columnNameList.contains(Constants.MONTHLY_DIR)
				&&columnNameList.contains(Constants.SHORTNAME)&&columnNameList.contains(Constants.TIBCO_PARTNER_ID))) {
			
			throw new ApplicationException(ErrorCodes.ERR_RBM_20028 + " Values: " + columnNameList.toString());
		}
		validateColumnsAndDataType(customDataMap);
		traceLog.traceFinest("validateCustomData method ended");
		return customDataMap;
		
		
	}
	private void validateColumnsAndDataType(Map<String, ColumnDetails[]> customDataMap) throws ApplicationException {
		
		traceLog.traceFinest("validateColumnsAndDataType method started");
		
		try {
			List<HashMapPlus> results  = util.executeQueryForList(SQLStatements.CUSTOM_DATA_VIEW, null, null);
			for(String tableName : customDataMap.keySet()) {
				boolean tableFoundBoo = false;
				traceLog.traceFinest("validating input tableName " + tableName);
				for (int i = 0; i < results.size(); i++) {
					if(tableName.trim().equalsIgnoreCase(results.get(i).getString(Constants.TABLE_NAME))) {
						tableFoundBoo = true;
						break;
					}

				}
				//traceLog.traceFinest("after for loop " + tableName);
				
				if(!tableFoundBoo) {
					throw new ApplicationException(ErrorCodes.ERR_RBM_20040 + " tableName: " + tableName);
				}
			}
			for(String tableName : customDataMap.keySet()) {
				ColumnDetails[] columnDetailsArray = customDataMap.get(tableName);
				for(int a=0;a<columnDetailsArray.length;a++) {
					boolean columnFoundBoo = false;
					traceLog.traceFinest("table name  " + tableName);
				for (int i = 0; i < results.size(); i++) {
					
						if (tableName.equalsIgnoreCase(results.get(i).getString(Constants.TABLE_NAME))
								&& columnDetailsArray[a].getColumnName().trim()
										.equalsIgnoreCase(results.get(i).getString(Constants.COLUMN_NAME))
								&& columnDetailsArray[a].getColumnDataType().trim().equalsIgnoreCase(results.get(i).getString(Constants.DATA_TYPE))
								&& columnDetailsArray[a].getColumnValue().trim().length() <= results.get(i).getInt(Constants.DATA_LENGTH)) {
							traceLog.traceFinest("after column name loop " + columnDetailsArray[a].getColumnName().trim());
							 columnFoundBoo = true;
							 break;
						}

				}
				if(!columnFoundBoo) {
					throw new ApplicationException(ErrorCodes.ERR_RBM_20041 + " columnName: " + columnDetailsArray[a].getColumnName());
				}
			}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			traceLog.traceFinest("error in loadAccountAttributesDefinition method " + e.getMessage());
			throw new ApplicationException(e.getMessage());

		}
		traceLog.traceFinest("validateColumnsAndDataType method ended");
		
		
	}
	private Map<String, String> validateAccountAttributes(AccountAttributeDetails[] accountAttributeDetails) throws ApplicationException  {
		traceLog.traceFinest("validateAccountAttributes method started");
		Map<String, String> AcctAttrMap = new HashMap<String, String>();
		for (int i = 0; i < accountAttributeDetails.length; i++) {
			if (AcctAttrMap.containsKey(accountAttributeDetails[i].getAccountAttributeName().trim())) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_20023 + " duplicate attribute: "
						+ accountAttributeDetails[i].getAccountAttributeName());
			} else {
				AcctAttrMap.put(accountAttributeDetails[i].getAccountAttributeName().trim(),
						accountAttributeDetails[i].getAttributeValue().trim());
			}

		}
		if (!(AcctAttrMap.containsKey(Constants.ACC_ATTR_COMPANY_CODE)
				&& AcctAttrMap.containsKey(Constants.ACC_ATTR_CCPC)
				&& AcctAttrMap.containsKey(Constants.ACC_ATTR_PARTNER_NAME)
				&& AcctAttrMap.containsKey(Constants.ACC_ATTR_ATTRIBUTE_2))) {
			throw new ApplicationException(ErrorCodes.ERR_RBM_20025 + " Values: " + AcctAttrMap.keySet().toString());
		}
		
		String npa_nxx = AcctAttrMap.get(Constants.ACC_ATTR_ATTRIBUTE_2);
		String npa_nxx_without_underscore = (null != npa_nxx && npa_nxx.length() > 6) ? npa_nxx.replaceAll("-","").substring(0, 6) : npa_nxx;
		AcctAttrMap.put(Constants.ACC_ATTR_ATTRIBUTE_2,npa_nxx_without_underscore);
				
		AcctAttrMap.put(Constants.ACC_ATTR_JCODE, jcode != null ? jcode.replaceAll("-","") : jcode);
		traceLog.traceFinest("validateAccountAttributes method ended");
			
		return AcctAttrMap;
		
	}

	private Map<String, AttributeDefination> loadAccountAttributesDefinition() throws ApplicationException {
		traceLog.traceFinest("loadAccountAttributesDefinition method started");
		Map<String,AttributeDefination> attributeDefinationMap = new HashMap<String, AttributeDefination>();
		try {
			List<HashMapPlus> results  = util.executeQueryForList(SQLStatements.ACCOUNT_ATTRIBUTES_VIEW, null, null);
			for (int i = 0; i < results.size(); i++) {
				attributeDefinationMap.put(results.get(i).getString(Constants.FILEDNAME), new AttributeDefination(
						results.get(i).getInt(Constants.FILEDINDEX), results.get(i).getInt(Constants.FILEDLENGTH)));

			}
		} catch (Exception e) {
			e.printStackTrace();
			traceLog.traceFinest("error in loadAccountAttributesDefinition method " + e.getMessage());
			throw new ApplicationException(ErrorCodes.ERR_RBM_20029);

		}
		traceLog.traceFinest("loadAccountAttributesDefinition method ended");
		return attributeDefinationMap;

	}
	
	private IntegratorContext_1 getCoreIntegratorContext(IntegratorContext integratorContext) {
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the Core IntegratorContext_1  integratorContext : " + integratorContext);
		}
		IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
		integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
		integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
		integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
		integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("Get the IntegratorContext in createCustomerAndAccount API");
		}

		return integratorContext_1;
	}
	
	private int validatePartnerAccountType(String partnerType) {
		int accountType = -1;
		for (PartnerAccountType type : Constants.PartnerAccountType.values()) {
			if (type.name().equals(partnerType.trim().toUpperCase())) {
				partnerAcctType = partnerType;
				accountType = type.getPartnerType();
				traceLog.traceFinest("accountType is "+ accountType);
			}
		}

		return accountType;
	}
	


private void insertCustomData(String tableName, ColumnDetails[] columnDetailsArray) throws ApplicationException {
		traceLog.traceFinest("insertCustomData method started");
		traceLog.traceFinest("tableName " + tableName);
		
		try {
			Connection connection = null;
			CallableStatement callableStatement = null;
			if (tableName.equals(Constants.TMO_ACCT_MAPPING_TABLE)) {
				traceLog.traceFinest("TMO_ACCT_MAPPING_TABLE  started");
				traceLog.traceFinest("partnerName "+partnerName);
				traceLog.traceFinest("partnerAcctType "+partnerAcctType);
				traceLog.traceFinest("eventProfileDispatcher "+eventProfileDispatcher);
				traceLog.traceFinest("gnvdate "+gnvdate);
				List<ColumnDetails> list = new ArrayList<ColumnDetails>();
				list.addAll(Arrays.asList(columnDetailsArray));
				list.add(new ColumnDetails(Constants.RATING_CUST_REF, Constants.VARCHAR2_TYPE, ratingCustomerRef));
				list.add(getColumnDetails(Constants.BILLING_CUST_REF, Constants.VARCHAR2_TYPE, billingCustomerRef));
				list.add(getColumnDetails(Constants.RATING_ACCT_NBR, Constants.VARCHAR2_TYPE, ratingAccountNum));
				list.add(getColumnDetails(Constants.BILLING_ACCT_NBR, Constants.VARCHAR2_TYPE, billingAccountNum));
				list.add(getColumnDetails(Constants.BILLING_EVENT_SRC, Constants.VARCHAR2_TYPE,shortName.toUpperCase()));
				list.add(getColumnDetails(Constants.ACCRUALS_EVENT_SRC, Constants.VARCHAR2_TYPE,Constants.ACCRUALS_ + shortName.toUpperCase()));
				list.add(getColumnDetails(Constants.CUSTOMER_NAME, Constants.VARCHAR2_TYPE,partnerName));
				list.add(getColumnDetails(Constants.CUST_CLASS, Constants.VARCHAR2_TYPE,partnerName.toLowerCase()));
				String custType = null;
				if (partnerAcctType.startsWith(Constants.PartnerAccountType.MVNO.name())) {
					custType = Constants.WHOLESALE;
				} else if(partnerAcctType.startsWith(Constants.POS_Values)) {
					custType = Constants.RETAIL;
				}else {
					custType = Constants.VAR;
				}
				list.add(getColumnDetails(Constants.CUST_TYPE, Constants.VARCHAR2_TYPE, custType));
				list.add(getColumnDetails(Constants.PROCESS_DAILY_USAGE, Constants.NUMBER_TYPE, eventProfileDispatcher));
				list.add(getColumnDetails(Constants.SIM_FEE_BOO, Constants.NUMBER_TYPE, Constants.SIM_FEE_BOO_VALUE));
				traceLog.traceFinest("isDemoAcct3>>>>>insertCustomData"+isDemoAcct);
				list.add(getColumnDetails(Constants.DEMO_INDICATOR, Constants.VARCHAR2_TYPE,isDemoAcct));
				if(partnerAcctType.startsWith(Constants.POS_Values)){
					list.add(getColumnDetails(Constants.UF_FORMAT, Constants.VARCHAR2_TYPE, Constants.VAR));
				}else{
					list.add(getColumnDetails(Constants.UF_FORMAT, Constants.VARCHAR2_TYPE, custType));
				}
				list.add(getColumnDetails(Constants.OTC_BOO, Constants.NUMBER_TYPE, Constants.OTC_BOO_VALUE));
				list.add(getColumnDetails(Constants.REFACTORED_FLAG, Constants.VARCHAR2_TYPE,
						Constants.REFACTORED_FLAG_VALUE));
				list.add(getColumnDetails(Constants.ACCT_TYPE, Constants.VARCHAR2_TYPE,	partnerAcctType.replace(Constants.UNDERSCORE, Constants.SPACE).toUpperCase()));
				list.add(getColumnDetails(Constants.REFACTORED_DTM, Constants.DATE_TYPE,
						DateUtil.convertDateToString(gnvdate)));
				columnDetailsArray = list.toArray(new ColumnDetails[list.size()]);
				traceLog.traceFinest("TMO_ACCT_MAPPING_TABLE  ended");
			}

			util.insertQuery(tableName, columnDetailsArray);
			String sql = SQLStatements.INSERT_CUSTOM_DATA;
			traceLog.traceFinest("Printing the SQL " + sql);
			connection = util.getDataSource().getConnection();
			callableStatement = connection.prepareCall(sql);

			callableStatement.setString(1, partnerName);
			callableStatement.setString(2, ratingAccountNum);
			callableStatement.setString(3, partnerAcctType);
			callableStatement.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
			traceLog.traceFinest("error occured in insertCustomData method " + e.getMessage());
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("insertCustomData method ended");
	
}
	private ColumnDetails getColumnDetails(String columnName, String columndataType, String columnValue) {
		ColumnDetails columnDetails = new ColumnDetails();
		columnDetails.setColumnName(columnName);
		columnDetails.setColumnDataType(columndataType);
		columnDetails.setColumnValue(columnValue);
		//traceLog.traceFinest("columnDetails" + columnDetails.toString());
	return columnDetails;
}
	
	private int getPartnerDUFFrequencyIntegerValue(String eventDispatchProfileName) throws ApplicationException {
        eventDispatchProfileName=eventDispatchProfileName.trim().toUpperCase();
        if(Constants.ONE_HR_EVENT_DISPATCH.equals(eventDispatchProfileName)) {
        	return Constants.ONE_HR_EVENT_DISPATCH_ID;
        }
        else if(Constants.FIFTIN_MIN_EVENT_DISPATCH.equals(eventDispatchProfileName)) {
             return Constants.FIFTIN_MIN_EVENT_DISPATCH_ID;
        }
        else if(Constants.THIRTY_MIN_EVENT_DISPATCH.equals(eventDispatchProfileName)) {
             return Constants.THIRTY_MIN_EVENT_DISPATCH_ID;
        }
        else {
        	throw new ApplicationException(ErrorCodes.ERR_RBM_20044);
        }
       	
}

	public Util getUtil() {
		return util;
	}
	public void setUtil(Util util) {
		this.util = util;
	}

}
