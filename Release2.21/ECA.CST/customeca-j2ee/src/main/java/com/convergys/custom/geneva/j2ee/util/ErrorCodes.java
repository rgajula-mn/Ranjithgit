package com.convergys.custom.geneva.j2ee.util;

/**
 * 
 * @author tkon2950
 * @author sgad2315 (Sreekanth Gade)
 *
 */
public class ErrorCodes {
	
	//constants related to errors.
	
	public static final String ERR_RBM_1000 = "ERR_RBM_1000 Null Parameter Exception (Required value was not supplied)";
	public static final String ERR_RBM_1001 = "ERR_RBM_1001 IntegratorContext cannot be null";
	public static final String ERR_RBM_1002 = "ERR_RBM_1002 External Business Transaction ID cannot be null.";
	public static final String ERR_RBM_1003 = "ERR_RBM_1003 NewSuperProductInstanceData cannot be null.";
	public static final String ERR_RBM_1004 = "ERR_RBM_1004 TOMS primary key was not supplied in the product attribute list for product.";
	public static final String ERR_RBM_1005 = "ERR_RBM_1005 Account Number cannot be null";
	public static final String ERR_RBM_1006 =  "ERR_RBM_1006 Parent Product Id passed wrong";
	public static final String ERR_RBM_1007 =  "ERR_RBM_1007 Exception in createBillingProfile. ";
	public static final String ERR_RBM_1008 = "ERR_RBM_1008 Parent Product Id should be supplied for child product creation";
	public static final String ERR_RBM_1009 = "ERR_RBM_1009 Product Attribute Name cannot be null ";
	public static final String ERR_RBM_1010 = "ERR_RBM_1010 Parent Product Id must be  same as Product ID while creating Bae product";
	public static final String ERR_RBM_1011 =  "ERR_RBM_1011 Wrong Product Id or Mandatory Input data (Customer Ref,MSISDN etc) passed";
	public static final String ERR_RBM_1012 = "ERR_RBM_1012 Both TOMsServiceInstancekey and TOMsServiceCompInstancekey are mandatory and not supplied for product.";
	public static final String ERR_RBM_1013 = "ERR_RBM_1013 ProductInstanceAttributesData cannot be null.";
	public static final String ERR_RBM_1014 = "ERR_RBM_1014 TOMsServiceInstancekey should be same for modifyEventSource and modifyProduct for price plan change of base product";
	public static final String ERR_RBM_1015 = "ERR_RBM_1015 Start Date should not be in future";
	
	public static final String ERR_RBM_2000 = "ERR_RBM_2000 Invalid Parameter combination (Customer or account mismatch between two or more values).";
	public static final String ERR_RBM_2001 = "ERR_RBM_2001 Both ModifyProductInstanceData and ModifyEventSourceData can not be null.";
	public static final String ERR_RBM_2002 = "ERR_RBM_2002 Customer Number cannot be null";
	public static final String ERR_RBM_2003 = "ERR_RBM_2003 Exception in updateBillingProfile. ";
	public static final String ERR_RBM_2004 = "ERR_RBM_2004 Both ModifyProductInstanceData and ModifyEventSourceData should be passed for price plan change of base product.";
	public static final String ERR_RBM_2005 = "ERR_RBM_2005 Start ate shouldn't be greater than gnv system date.";
	
	//queryLastRatedUsageDtmByType Error Codes
	public static final String ERR_RBM_3000 = "ERR_RBM_3000 Parameter Exception (Invalid Parameter).";
	public static final String ERR_RBM_3001 = "ERR_RBM_3001 MSISDN  cannot be null.";
	public static final String ERR_RBM_3002 = "ERR_RBM_3002 Exception in queryLastRatedUsageDtmByType.";
	
	public static final String ERR_RBM_4000 = "ERR_RBM_4000 No Such Entity Exception (thrown when the customer or product instance does not exist, or the product does not define the given attribute).";
	public static final String ERR_RBM_4001 = "ERR_RBM_4001 Product Attribute sub ID does not exist for product id ";
	public static final String ERR_RBM_4002 = "ERR_RBM_4002 Product instance not found for the TOMS key.";
	public static final String ERR_RBM_0000 = "ERR_RBM_0000 An unexpected Error has occurred, please contact the system administrator.";
	
	public static final String ERR_RBM_5001 = "ERR_RBM_5001 User Name cannot be null";
	public static final String ERR_RBM_5002 = "ERR_RBM_5002 NewAccountPaymentData cannot be null.";
	public static final String ERR_RBM_5003 = "ERR_RBM_5003 PaymentCancelData cannot be null.";
	
	public static final String ERR_RBM_5005 = "ERR_RBM_5005 Exception in cancelPayments.";
	public static final String ERR_RBM_5006 = "ERR_RBM_5006 Exception in createAccountPayments.";
	
	
	public static final String ERR_RBM_6001 = "ERR_RBM_6001 Customer Reference cannot be null";
    public static final String ERR_RBM_6002 = "ERR_RBM_6002 Event Seq cannot be null.";
    public static final String ERR_RBM_6003 = "ERR_RBM_6003 Start Date cannot be null.";
    public static final String ERR_RBM_6004 = "ERR_RBM_6004 Exception in queryCDRDetails.";
    public static final String ERR_RBM_6005 = "ERR_RBM_6005 Exception in getAllEventTypes.";
    public static final String ERR_RBM_6006 = "ERR_RBM_6006 Event Type id cannot be null.";
    public static final String ERR_RBM_6007 = "ERR_RBM_6007 Created Dtm cannot be null.";
    
    
    public static final String ERR_RBM_7001 = "ERR_RBM_7001 AdjustmentPK cannot be null.";
    public static final String ERR_RBM_7002 = "ERR_RBM_7002 AccountPK cannot be null."; 
    public static final String ERR_RBM_7003 = "ERR_RBM_7003 AdjustmentDate cannot be null.";
    public static final String ERR_RBM_7004 = "ERR_RBM_7004 AdjustmentTypeId cannot be null.";
    public static final String ERR_RBM_7005 = "ERR_RBM_7005 AdjustmentText cannot be null.";
    public static final String ERR_RBM_7006 = "ERR_RBM_7006 AdjustmentMny cannot be null.";
    public static final String ERR_RBM_7007 = "ERR_RBM_7007 ContractedPointOfSupplyId cannot be null.";
    
    public static final String ERR_RBM_8001 = "ERR_RBM_8001 QueryPartnerBillingAndFinanceInput cannot be null.";
    
  //createBulkRequest Error Codes
    public static final String ERR_RBM_9001 = "ERR_RBM_9001 PartnerID cannot be null";
    public static final String ERR_RBM_9002 = "ERR_RBM_9002 RequestFile extension should be in CSV or cannot be null";
    public static final String ERR_RBM_9003 = "ERR_RBM_9003 SFTP path not found.";
    public static final String ERR_RBM_9004 = "ERR_RBM_9004 PartnerID not found";
    public static final String ERR_RBM_9005 = "ERR_RBM_9005 Exception in getBulkRequest.";
    
    //QueryInvoiceSectionDetails
    public static final String ERR_RBM_10001 = "ERR_RBM_10001 Invoice number cannot be null or not valid.";
    public static final String ERR_RBM_10002 = "ERR_RBM_10002 Exception in queryInvoiceSummary.";
    

    //InvoiceSectionDetails
    
    public static final String  ERR_RBM_10003 = "ERR_RBM_10003 Type cannot be null.";
    public static final String  ERR_RBM_10004 = "ERR_RBM_10004 InvoicSummaryKey cannot be null.";
    public static final String  ERR_RBM_10005 = "ERR_RBM_10005 pagination cannot be null.";
    public static final String  ERR_RBM_10006 = "ERR_RBM_10006 Exception occured in queryInvoiceSectionDetails.";
    public static final String  ERR_RBM_10007 = "ERR_RBM_10007 section type cannot be null or not valid";
    
    //queryLineItemDetails Error Codes
    public static final String ERR_RBM_12000 = "ERR_RBM_12000 Invoice Number cannot be null.";
    public static final String ERR_RBM_12001 = "ERR_RBM_12001 invoiceLineItemDetailsKey cannot be null.";
    public static final String ERR_RBM_12002 = "ERR_RBM_12001 Filter Type Array cannot be empty.";
    public static final String ERR_RBM_12003 = "ERR_RBM_12003 Exception in queryLineItemDetails.";
    
  //QueryCDRData Error Codes
	  public static final String ERR_RBM_11000 = "ERR_RBM_11000  Account Number cannot be null.";
	  public static final String ERR_RBM_11001 = "ERR_RBM_11001 Pagination cannot be null.";
	  public static final String ERR_RBM_11002 = "ERR_RBM_11002 Exception in queryCDRData.";
	  public static final String ERR_RBM_11003 = "ERR_RBM_11003 EventSource cannot be null.";
	  public static final String ERR_RBM_11004 = "ERR_RBM_11004 cdrDetailsKey cannot be null.";
	  public static final String ERR_RBM_11005 = "ERR_RBM_11005 EventTypeId cannot be null.";
	  public static final String ERR_RBM_11006 = "ERR_RBM_11006 EventSeq cannot be null.";
	  public static final String ERR_RBM_11007 = "ERR_RBM_11007 EventCost cannot be null.";
	   
 //SendInvoiceByMail Error Codes
	  public static final String ERR_RBM_13000 = "ERR_RBM_13000  Invoice Number cannot be null.";
	  public static final String ERR_RBM_13001 = "ERR_RBM_13001 E-Mail cannot be null.";
	  public static final String ERR_RBM_13002 = "ERR_RBM_13002 Not a valid E-Mail Id.";
	  public static final String ERR_RBM_13003 = "ERR_RBM_13003 Execption in SendInvoiceByMail.";
	  public static final String ERR_RBM_13004 = "ERR_RBM_13004 Invoice number not found";
	  public static final String ERR_RBM_13005 = "ERR_RBM_13005 PERL GPARAM path not found";
	  public static final String ERR_RBM_13006 = "ERR_RBM_13006 Bill version is null";
      //product status updates
      
      public static final String ERR_RBM_11020 = " Only base product can be suspended";
      public static final String ERR_RBM_11021 = " productStatus (DEACTIVE) should be populated to Terminate Base product";
      
      //ACC Error Codes
      public static final String ERR_RBM_14000 = "ERR_RBM_14000 Returned more than one contact for given partner ";
      public static final String  ERR_RBM_14001 = "ERR_RBM_14001 Exception occured in queryPartnerContactDetails.";
	  
	  public static final String ERR_RBM_17001 = "ERR_RBM_17001 IntegratorContext cannot be null";
  	  public static final String ERR_RBM_17002 = "ERR_RBM_17002 External Business Transaction ID cannot be null.";
  	  public static final String ERR_RBM_17003 = "ERR_RBM_17003 Payment Channel Id cannot be null";
  	  public static final String ERR_RBM_17004 = "ERR_RBM_17004 Payment Channel Name cannot be null";
  	  public static final String ERR_RBM_17005 = "ERR_RBM_17005 Invoicing Co Id cannot be null";
  	  public static final String ERR_RBM_17006 = "ERR_RBM_17006 User Name cannot be null";
  	  
  	  public static final String ERR_RBM_18001 = "ERR_RBM_18001 IntegratorContext cannot be null";
  	  public static final String ERR_RBM_18005 = "ERR_RBM_18005 External Business Transaction ID cannot be null.";
	  public static final String ERR_RBM_18002 = "ERR_RBM_18002 Customer Reference cannot be null.";
	  public static final String ERR_RBM_18003 = "ERR_RBM_18003 Exemption Start Date cannot be null";
	  public static final String ERR_RBM_18004 = "ERR_RBM_18004 Exemption Type cannot be null";
	  
	  public static final String ERR_RBM_19001 = "ERR_RBM_19001 AddTaxExemption for this partner is in process";
	  public static final String ERR_RBM_19002 = "ERR_RBM_19002 This Tax Exemption is already associated with this partner";
	  
	  //Partner Onboarding wizard error codes
	  public static final String ERR_RBM_20000 = "ERR_RBM_20000 newCustomerAndAccountData cannot be null.";
	  public static final String ERR_RBM_20001 = "ERR_RBM_20001 newAddress cannot be null.";
	  
	  public static final String ERR_RBM_20002 = "ERR_RBM_20002 accountAttributesArray cannot be null.";
	  public static final String ERR_RBM_20003 = "ERR_RBM_20003 newCustomDataArray cannot be null.";
	  public static final String ERR_RBM_20004 = "ERR_RBM_20004 PartnerName cannot be null.";
	  public static final String ERR_RBM_20005 = "ERR_RBM_20005 BillingAccountName cannot be null.";
	  public static final String ERR_RBM_20006 = "ERR_RBM_20006 PartnerAccountType cannot be null.";
	  public static final String ERR_RBM_20007 = "ERR_RBM_20007 BillingAddressData cannot be null.";
	  //public static final String ERR_RBM_20008 = "ERR_RBM_20008 RequestedBillCycleCloseDate cannot be null."; 
	  //public static final String ERR_RBM_20009 = "ERR_RBM_20009 RequestedBillCycleRunDate cannot be null.";
	  public static final String ERR_RBM_20010 = "ERR_RBM_20010 startDate cannot be null.";
	  public static final String ERR_RBM_20011 = "ERR_RBM_20011 Country cannot be null.";
	  public static final String ERR_RBM_20012 = "ERR_RBM_20012 AddressLine1 cannot be null.";
	  public static final String ERR_RBM_20013 = "ERR_RBM_20013 AddressLine2 cannot be null.";
	  public static final String ERR_RBM_20014 = "ERR_RBM_20014 AddressLine3 cannot be null.";
	  public static final String ERR_RBM_20015 = "ERR_RBM_20015 AddressLine4 cannot be null.";
	  public static final String ERR_RBM_20016 = "ERR_RBM_20016 AddressLine5 cannot be null.";
	  public static final String ERR_RBM_20017 = "ERR_RBM_20017 Zipcode cannot be null.";
	  public static final String ERR_RBM_20018 = "ERR_RBM_20018 USTJcode cannot be null.";
	  public static final String ERR_RBM_20019 = "ERR_RBM_20019 CompanyCode cannot be null.";
	  public static final String ERR_RBM_20020 = "ERR_RBM_20020 PartnerShortName cannot be null.";
	  public static final String ERR_RBM_20021 = "ERR_RBM_20021 BillingAccountAttributes cannot be null.";
	  public static final String ERR_RBM_20022 = "ERR_RBM_20022 new custom data array cannot be null.";
	  public static final String ERR_RBM_20023 = "ERR_RBM_20023 Provided duplicate  account attribute names.";
	  public static final String ERR_RBM_20024 = "ERR_RBM_20024 Provided duplicate rating account attribute names.";
	  public static final String ERR_RBM_20025 = "ERR_RBM_20025 Required   account attributes not passed.";
	  public static final String ERR_RBM_20026 = "ERR_RBM_20026 Required  rating account attributes not passed.";
	  public static final String ERR_RBM_20027 = "ERR_RBM_20027 Required  tmo_acct_mapping table data not passed.";
	  public static final String ERR_RBM_20028 = "ERR_RBM_20028 Required  data not passed in tmo_acct_mapping table.";
	  public static final String ERR_RBM_20029 = "ERR_RBM_20029 Failed while loading accountattribute definition.";
	  public static final String ERR_RBM_20030 = "ERR_RBM_20030 The account attribute not found.";
	  public static final String ERR_RBM_20031 = "ERR_RBM_20031 Failed to execute the procedure.";
	  public static final String ERR_RBM_20032 = "ERR_RBM_20032 got null values for customer and account .";
	  public static final String ERR_RBM_20033 = "ERR_RBM_20033 requestedBillCycleRunDate should be in MM/DD/YYYY format .";
	  public static final String ERR_RBM_20034 = "ERR_RBM_20034 one of the required element is null";
	  public static final String ERR_RBM_20035 = "ERR_RBM_20035 got exception in core API";
	  public static final String ERR_RBM_20036 = "ERR_RBM_20036 got exception in core API";
	  public static final String ERR_RBM_20037 = "ERR_RBM_20037 Company name cannot not be null";
	  public static final String ERR_RBM_20038 = "ERR_RBM_20038 nextbill dtm cannot not be null";
	  public static final String ERR_RBM_20039 = "ERR_RBM_20039 partner Account type cannot be null or not passed correct value";
	  public static final String ERR_RBM_20040 = "ERR_RBM_20040 table not found ";
	  public static final String ERR_RBM_20041 = "ERR_RBM_20041 column not found ";
	  public static final String ERR_RBM_20042 = "ERR_RBM_20042 partnerDufFrequency cannot be null ";
	  public static final String ERR_RBM_20044 = "ERR_RBM_20043 Event Dispatch value is invalid";
}
