/*******************************************************************************
 *
 * This file contains proprietary information of Convergys, Inc.
 * Copying or reproduction without prior written approval is prohibited.
 * Copyright (C) 2009  Convergys, Inc.  All rights reserved.
 *
 *******************************************************************************/
package com.convergys.custom.geneva.j2ee.util;


/**
 * 
 * @author tkon2950
 * @author sjoshi1
 */

public final class Constants {
 
    private Constants() {
    }

    public static final String QUERY_INVOICE_SUMMARY_DATA = "QueryInvoiceSummary";
    
    public static final String SEND_INVOICE_BYMAIL = "SendInvoiceByMail";
    
    public static final String QUERY_DUFFile_DATA = "QueryDUFFile";
   
    public static final int PENDING_STATUS = 0;
    public static final int COMPLETE_STATUS = 1;
    public static final int ERROR_STATUS = 2;
    public static final String UPDATE_SUCCESS = "Update Sucessful";
    public static final String UPDATE_FAILURE = "Update Failed";
    public static final String CREATE_API_NAME = "CreateBillingProfile";
    public static final String UPDATE_API_NAME = "UpdateBillingProfile";
    public static final String QUERY_RATED_USAGE_API_NAME = "QueryLastRatedUsage";
    public static final String CANCEL_PAYMENTS_API_NAME = "CancelPayments";
    public static final String CREATE_ACCOUNT_PAYMENTS_API_NAME = "createAccountPayment";
    public static final String QUERY_CDR_DETAILS_API_NAME = "QueryCDRDetails";
    public static final String CANCEL_ADJUSTMENT__API_NAME = "CancelAdjustment";
    public static final String CREATE_ADJUSTMENT__API_NAME = "CreateAdjustment";
    public static final String CREATE_ADJUSTMENT2__API_NAME = "CreateAdjustment_2";
    public static final String TILDE_OPERATOR = "~";
    public static final String PIPE_OPERATOR = "|";
    public static final String QUERY_PBF_API_NAME = "QueryPatnerBillingandFinanceData";
    
    public static final String QUERY_INVOICE_SUMMARYDATA  = "QueryInvoiceSummaryData";
    public static final String QUERY_INVOICE_SECTIONDETAILS  = "QueryInvoiceSectionDetails";
    public static final String QUERY_LINEITEMDETAILS  = "QUERYLINEITEMDETAILS";
    public static final String QUERY_CDR_DATA  = "QUERYCDRDATA";
    public static final String CREATE__PAYMENT_CHANNEL_API_NAME = "createPaymentChannel";
    public static final String MODIFY__PAYMENT_CHANNEL_API_NAME = "modifyPaymentChannel";
    public static final String Add_TAX_EXEMPTION_API_NAME = "AddPartnerUSTaxExemption";
    public static final String DELETE_TAX_EXEMPTION_API_NAME = "DeletePartnerUSTaxExemption";
	public static final String CREATE_CUSTOMER_AND_ACCOUNT_API_NAME = "CreateCustomerAndAccount";
    
    
    //ADD\MODIFY\REMOVE 
    
/*  public static final String ACTION_MODIFY = "Modify";
    public static final String ACTION_ADD = "Add";
    public static final String ACTION_TERMINATE = "Terminate";*/
    
    public static final String ACTION_MODIFY = "MODIFY";
    public static final String ACTION_ADD = "ADD";
    public static final String ACTION_TERMINATE = "REMOVE";
    public static final int MAX_COUNT =10;
    public static final String TomsKey = "TOMS_SVC_INSTANCE_ID";
    public static final String TomsCompKey ="TOMS_SVC_COMP_INST_ID";
    public static final String CREATE_SUCCESS = "Create Product Instance Sucessful";
    public static final String CREATE_FAILURE = "Create Product Instance Failed";

    public static final String QUERY_RATED_USAGE_SUCCESS = "Query Rated Usage Sucessful";
    public static final String QUERY_RATED_USAGE_NO_USAGE = "Did Not find Query Rated Usage";
    public static final String CREATE_ACCOUNT_PAYMENTS_SUCCESS = "Create Account Paymnets Sucessful";
    public static final String QUERY_CDRDETAILS_SUCCESS = "Query CDR Details Sucessful";
    public static final String QUERY_CDRDETAILS_NO_EVENTS_FOUND = "QueryCDRDetails NO Events";
    public static final String TRANSACTION_SUCCESS = "Transaction Sucessful";
    
    
    public static final String SMS = "2";
    public static final String INTL_ROAM_SMS = "28";
    public static final String VOICE = "1";
    public static final String INTL_ROAM_VOICE = "20";
    public static final String MMS = "4";
    public static final String INTL_ROAM_GPRS = "21";
    public static final String GPRS = "3";
    public static final String DATETIME_MASK = "yyyyMMdd HHmmss";
    
    
    public static final String grps_mapping="name,GPRS|recordType,event_type_id|eventRef,event_ref|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|recordStartTime,event_dtm|accessPointName,event_attr_9|imei,event_attr_2|homeSid,event_attr_13|serveSid,event_attr_14|serverPdpAddress,event_attr_39|cellIdentify,event_attr_15|locationAreaCode,event_attr_36|duration,event_attr_4|dataRate,event_attr_27|uplinkVolume,event_attr_3|downlinkVolume,event_attr_5|event_attr_26,event_attr_26|event_attr_29,event_attr_29|event_cost_mny,event_cost_mny|createtime,created_dtm|recordingEntity,event_attr_10|technologyUsed,event_attr_22|eventClass,event_attr_19|romerFlag,event_attr_20|sgsnAddress,event_attr_8|utcTime,event_attr_38";
    public static final String intl_roam_grps_mapping="name,International Roaming GPRS|recordType,event_type_id|eventRef,event_ref|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|recordStartTime,event_dtm|accessPointName,event_attr_9|imei,event_attr_2|homeSid,event_attr_13|serveSid,event_attr_14|serverPdpAddress,event_attr_39|cellIdentify,event_attr_15|locationAreaCode,event_attr_36|duration,event_attr_4|dataRate,event_attr_27|uplinkVolume,event_attr_3|downlinkVolume,event_attr_5|plmnCode,event_attr_18|countryName,event_attr_28|event_attr_26,event_attr_26|event_attr_29,event_attr_29|event_cost_mny,event_cost_mny|createtime,created_dtm|recordingEntity,event_attr_10|technologyUsed,event_attr_22|eventClass,event_attr_19|romerFlag,event_attr_20|sgsnAddress,event_attr_8|utcTime,event_attr_38";
    public static final String mms_mapping="name,MMS|recordType,event_type_id|eventRef,event_ref|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|recordStartTime,event_dtm|serverPdpAddress,event_attr_2|totalVolume,event_attr_3|duration,event_attr_4|dataChargeCode,4|dataRate,event_attr_24|calledNumberUrl,event_attr_39|event_cost_mny,event_cost_mny|createtime,created_dtm|mmsTypeIndicator,event_attr_25|technologyUsed,event_attr_14|roamingIndicator,event_attr_15|utcTime,event_attr_38";

    public static final String voice_mapping="name,Voice|recordType,event_type_id|eventRef,event_ref|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|channelSeizureDt,event_dtm|switchId,event_attr_6|imei,event_attr_2|homeSid,event_attr_14|serveSid,event_attr_15|cellIdentity,event_attr_36|callToPlace,event_attr_33|callToRegion,event_attr_33|outgoingCellTrunkId,event_attr_8|incomingTrunkId,event_attr_7|answerTimeDurRoundMin,event_attr_35|answerTimeCallDurSec,event_attr_4|airTime,event_attr_34|airChargeAmount,event_attr_27|callDirection,event_attr_9|translatedNumber,event_attr_16|event_attr_9,event_attr_9|event_attr_10,event_attr_10|event_attr_11,event_attr_11|onNet,event_attr_13|event_attr_22,event_attr_22|event_attr_24,event_attr_24|event_attr_30,event_attr_30|event_attr_35,event_attr_35|createtime,created_dtm|technologyUsed,event_attr_22|utcTime,event_attr_38|countryCode,event_attr_23";
    public static final String intl_roam_voice_mapping="name,International Roaming Voice|recordType,event_type_id|eventRef,event_ref|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|channelSeizureDt,event_dtm|switchId,event_attr_6|imei,event_attr_2|homeSid,event_attr_14|serveSid,event_attr_15|cellIdentity,event_attr_36|callToPlace,event_attr_33|callToRegion,event_attr_33|outgoingCellTrunkId,event_attr_8|incomingTrunkId,event_attr_7|answerTimeDurRoundMin,event_attr_35|answerTimeCallDurSec,event_attr_4|airTime,event_attr_34|airChargeAmount,event_attr_27|callDirection,event_attr_9|translatedNumber,event_attr_16|plmnCode,event_attr_19|countryName,event_attr_30|event_attr_9,event_attr_9|event_attr_10,event_attr_10|event_attr_11,event_attr_11|onNet,event_attr_13|event_attr_19,event_attr_19|event_attr_22,event_attr_22|event_attr_24,event_attr_24|event_attr_30,event_attr_30|event_attr_35,event_attr_35|createtime,created_dtm|technologyUsed,event_attr_22|utcTime,event_attr_38|countryCode,event_attr_23";
    public static final String intl_roam_sms_mapping="name,International Roaming SMS|eventRef,event_ref|recordType,event_type_id|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|channelSeizureDt,event_dtm|switchId,event_attr_6|imei,event_attr_2|homeSid,event_attr_14|serveSid,event_attr_15|cellIdentity,event_attr_29|outgoingCellTrunkId,event_attr_8|incomingTrunkId,event_attr_7|answerTimeDurRoundMin,1|answerTimeCallDurSec,1|airTime,event_attr_26|airChargeAmount,event_cost_mny|tollRate,0|translatedNumber,event_attr_16|plmnCode,event_attr_18|countryName,event_attr_27|event_attr_9,event_attr_9|event_attr_10,event_attr_10|event_attr_11,event_attr_11|romerFlag,event_attr_20|createtime,created_dtm|technologyUsed,event_attr_22|utcTime,event_attr_38";
    public static final String sms_mapping="name,SMS|recordType,event_type_id|eventRef,event_ref|accountNumber,account_num|sequenceNumber,event_seq|imsi,event_attr_1|msisdn,event_attr_12|channelSeizureDt,event_dtm|switchId,event_attr_6|imei,event_attr_2|homeSid,event_attr_14|serveSid,event_attr_15|cellIdentity,event_attr_29|outgoingCellTrunkId,event_attr_8|incomingTrunkId,event_attr_7|answerTimeDurRoundMin,1|answerTimeCallDurSec,1|airTime,event_attr_26|airChargeAmount,event_cost_mny|tollRate,0|translatedNumber,event_attr_16|event_attr_9,event_attr_9|event_attr_10,event_attr_10|event_attr_11,event_attr_11|romerFlag,event_attr_20|createtime,created_dtm|technologyUsed,event_attr_22|countryName,event_attr_27|plmnCode,event_attr_18|utcTime,event_attr_38";
    
    public static final String CREATE_BULK_REQUEST_API_NAME = "CreateBulkRequest";
    public static final String GET_BULK_REQUEST_API_NAME = "GetBulkRequest";
    public static final String SUCCESS_STATUS = "Successful";
    public static final String FAIL_STATUS = "FAILED";
    public static final String DATETIME_MASK_INCLUDE_TIME_ZONE = "yyyy-MM-dd'T'HH:mm:ss.SSSX";
    public static final String DATETIME_MASK_WITHOUT_TIME_ZONE = "MM/dd/yyyy hh:mm:ss";
    
    public static final String INVOICE_SECTION_DETAILS_API_NAME = "InvoiceSectionDetails";
    public static final String QUERY_LINE_ITEM_DETAILS_API_NAME = "QueryLineItemDetails";
    
    public  enum SectionType {
    	USG("78,79,80,81,82,83,84,92,87,88,89"),
    	MRC("85"),
    	ADJ("86");
    	private String eventTypeIds;
    	SectionType(String eventTypeIds) {
    		this.eventTypeIds = eventTypeIds;
    	}
    	public String getEventTypeIds() {
    		return this.eventTypeIds;
    	}
    }
    
	// Constant needed for QueryCDRData API
	public static final String QUERY_CDR_DATA_API_NAME = "QueryCDRData";

	// QueryLineItemDetails EventClassPPA
	public static final String STD_RECURRING = "STD-RECURRING";
	public static final String STD_ACTIVATION = "STD-ACTIVATION";
	public static final String HSD_CHARGE = "HSD CHARGE";
	public static final String HSD_CREDIT = "HSD CREDIT";
	public static final String SUSPEND = "SUSPEND";
	public static final String DORMANCY = "DORMANCY";
	public static final String NONLTE_PENALTY = "NONLTE PENALTY";
	public static final String ACCESS_FEE = "ACCESS FEE";
	public static final String IMSI_PENALTY = "IMSI PENALTY";
	public static final String NUMIMSI1_MRC = "NUMIMSI1-MRC";
	public static final String NUMIMSI10_MRC = "NUMIMSI10-MRC";
	public static final String ILD_MEXICO = "ILD MEXICO";
	public static final String SIMFEE = "SIMFEE";
	public static final String MULTI_IMSI_FEE = "MULTI IMSI FEE";
	
	//MINT Attributes and TESTSUB
	public static final String LAST_TERM_RENEWAL_DATE = "LAST_TERM_RENEWAL_DATE";
	public static final String LAST_RENEWAL_DATE = "LAST_RENEWAL_DATE";
	public static final String PLAN_NAME = "PLAN_NAME";
	public static final String TERM_LENGTH = "TERM_LENGTH";
	public static final String TERM_EXPIRATION_DATE = "TERM_EXPIRATION_DATE";
	public static final String SUBSCRIBER_TYPE = "SUBSCRIBER_TYPE";
	//MINT Attributes and TESTSUB default values
	public static final String LAST_TERM_RENEWAL_DATE_VALUE = "1900-01-01";
	public static final String LAST_RENEWAL_DATE_VALUE= "1900-01-01";
	public static final String PLAN_NAME_VALUE = "None";
	public static final String TERM_LENGTH_VALUE = "-1";
	public static final String TERM_EXPIRATION_DATE_VALUE = "1900-01-01";
	public static final String SUBSCRIBER_TYPE_VALUE = "None";
	
	public  enum SectionName {
    	USG_NAME("Service Usage Charges"),
    	MRC_NAME("Monthly & One-time Charges"),
    	ADJ_NAME("Promotions/Credits & Adjustments"),
    	TAX_NAME("Taxes, Fees & Surcharges"),
		OTF_NAME("Other Fees and Government Obligations"),
		GTF_NAME("Government Fees and Taxes");
    	private String sectionName;
    	SectionName(String sectionName) {
    		this.sectionName = sectionName;
    	}
    	public String getSectionName() {
    		return this.sectionName;
    	}
    }
	
	public enum LineItemView {
		USAGE_LINE("TMOBILE_CUSTOM.SUBBILLEDUSAGE_VIEW"),
		MRC_STD_RECURRING_LINE("TMOBILE_CUSTOM.SUBACTIVEDAYS_VIEW"),
		MRC_HSD_CHARGE_LINE("TMOBILE_CUSTOM.SUBHSDCHARGE_VIEW"),
		MRC_HSD_CREDIT_LINE("TMOBILE_CUSTOM.SUBHSDCREDIT_VIEW"),
		MRC_SUSPENDDORMANCY_LINE("TMOBILE_CUSTOM.SUBSUSPENDDAYS_VIEW"),
		MRC_ACCESSFEE_LINE("TMOBILE_CUSTOM.ACCESSFEE_VIEW"),
		MRC_NONLTEPENALTY_LINE("TMOBILE_CUSTOM.IMEIPENALTY_VIEW"),
		MRC_IMSIPENALTY_LINE("TMOBILE_CUSTOM.IMSIPENALTY_VIEW"),
		MRC_NUMIMSILINE_LINE("TMOBILE_CUSTOM.NUMIMSI_MRC_VIEW");
		
		
		private String lineItemView;
		LineItemView(String lineItemView) {
			this.lineItemView = lineItemView;
		}
		public String getLineItemView() {
			return this.lineItemView;
		}
		
	}
	
	public enum Order{
		ASC("ASC"),
		DESC("DESC");
		private String order;
		Order(String order) {
			this.order = order;
		}
		public String getOrder() {
			return this.order;
		}
	}
	
	// Product attribute status.......
    
    public static final String PRODUCT_DEACTIVE = "DEACTIVE";
    public static final String PRODUCT_SUSPEND = "SUSPEND";
    public static final String PRODUCT_ACTIVE = "ACTIVE"; //pranavi
    public static final String QUERY_PARTNER_CONTACT_DETAILS_API = "QueryPartnerContactDetails"; 
    public static final String PENDING = "Pending";
    public static final String PROCESSING = "Processing";
    public static final String COMPLETED = "Completed";
    public static final String ERROR = "Error";
	
	
	
	
	 //Partner On boarding wizard
    //Account attributes fields
    public static final String ACC_ATTR_COMPANY_CODE = "COMPANY_CODE";
    public static final String ACC_ATTR_CCPC = "CCPC";
    public static final String ACC_ATTR_ATTRIBUTE_2 = "ATTRIBUTE_2";
    public static final String ACC_ATTR_PARTNER_NAME = "PARTNER_NAME";
    public static final String ACC_ATTR_JCODE = "JCODE";
    public static final String POS_Values = "POS";
    
    //TMO_ACCT_MAPPING Mandatory fields
    public static final String TMO_ACCT_MAPPING_TABLE= "TMO_ACCT_MAPPING";
    public static final String DAILY_DIR= "DAILY_DIR";
    public static final String MONTHLY_DIR= "MONTHLY_DIR";
    public static final String SHORTNAME= "SHORTNAME";
    public static final String TIBCO_PARTNER_ID= "TIBCO_PARTNER_ID";
    
    //Other required parameters
    public static final String SPACE= " ";
    public static final String ACCRUALS_= "ACCRUALS_";
    public static final String UNDERSCORE= "_";
    public static final String VAR= "Var";
    public static final String WHOLESALE= "Wholesale";
    public static final String IOT= "IOT";
    public static final String RETAIL= "Retail";
    
  //Attribute Definition
    public static final String FILEDNAME= "FIELDNAME";
    public static final String FILEDINDEX= "FIELDINDEX";
    public static final String FILEDLENGTH= "FIELDLENGTH";
    
    //table definition
    public static final String TABLE_NAME= "TABLE_NAME";
    public static final String COLUMN_NAME= "COLUMN_NAME";
    public static final String DATA_TYPE= "DATA_TYPE";
    public static final String DATA_LENGTH= "DATA_LENGTH";
    
    //Default values
    public static final int ADDRESS_FORMAT_ID= 20;
    public static final int CONTACT_TYPE_ID= 1000001;
    public static final int LANGUAGE_ID= 7;
    public static final boolean USTINCITYBOO = true;
    public static final int CUSTOMER_TYPE_VAR_ID= 2;
    public static final int CUSTOMER_TYPE_WSALE_ID= 1;
    public static final int INVOICING_CO_ID= 2;
	public static final boolean CONCATENATE_BILLS_BOO = false;
	public static final boolean TICKET_BOO = false;
	public static final String CURRENCY_CODE = "USD";
	public static final int BILLING_ACCOUNT_BILL_STYLE_ID = 34;
	public static final int RATING_ACCOUNT_BILL_STYLE_ID = 35;
	public static final int PAYMENT_METHOD_ID = 1;
	public static final int CREDIT_CLASS_ID = 1;
	public static final long CREDIT_LIMIT_MNY = 10000000000L;
	public static final boolean PREPAY_BOO = false;
	public static final int ACCOUNTING_METHOD = 1;
	public static final boolean TAX_INCLUSIVE_BOO = false;
	public static final boolean AUTO_DELETE_BILLED_EVENTS_BOO = false;
	public static final int UST_ACCOUNTCLASS_ID = 1;
	public static final int BILLSPERSTATEMENT = 1;
	public static final int BILL_PERIOD = 1;
	public static final int BILL_PERIOD_UNITS = 2;
	public static final long EVENTSPERDAY = 300000;
	public static final boolean MASK_BILL_BOO = true;
	public static final boolean MASK_STORE_BOO = true;
	public static final boolean REGUIDED_MASK_BILL_BOO = true;
	public static final boolean REGUIDED_MASK_STORE_BOO = true;
	public static final boolean ASSIGN_HOLIDAY_PROFILE_BOO = false;
	public static final boolean CREATE_DEPOSIT_BALANCE_BOO = false;
	
	
	//enum for partner type
	
	public enum PartnerAccountType{
		M2M_IOT(CUSTOMER_TYPE_VAR_ID),
		M2M(CUSTOMER_TYPE_VAR_ID),
		MVNO(CUSTOMER_TYPE_WSALE_ID),
		MVNO_IOT(CUSTOMER_TYPE_WSALE_ID),
		POS_IOT(CUSTOMER_TYPE_VAR_ID);
		private int type;
		PartnerAccountType(int type) {
			this.type = type;
		}
		public int getPartnerType() {
			return this.type;
		}
	}
	
	//DataTypes
	public static final String VARCHAR2_TYPE = "VARCHAR2";
	public static final String NUMBER_TYPE = "NUMBER";
	public static final String DATE_TYPE = "DATE";
	
	//derived column and values
	public static final String RATING_CUST_REF = "RATING_CUST_REF";
	public static final String BILLING_CUST_REF = "BILLING_CUST_REF";
	public static final String RATING_ACCT_NBR = "RATING_ACCT_NBR";
	public static final String BILLING_ACCT_NBR = "BILLING_ACCT_NBR";
	public static final String BILLING_EVENT_SRC = "BILLING_EVENT_SRC";
	public static final String ACCRUALS_EVENT_SRC = "ACCRUALS_EVENT_SRC";
	public static final String CUSTOMER_NAME = "CUSTOMER_NAME";
	public static final String CUST_CLASS = "CUST_CLASS";
	public static final String PROCESS_DAILY_USAGE = "PROCESS_DAILY_USAGE";
	public static final String CUST_TYPE = "CUST_TYPE";
	public static final String SIM_FEE_BOO = "SIM_FEE_BOO";
	public static final String SIM_FEE_BOO_VALUE = "0";
	public static final String UF_FORMAT = "UF_FORMAT";
	public static final String REFACTORED_FLAG = "REFACTORED_FLAG";
	public static final String REFACTORED_FLAG_VALUE = "T";
	public static final String ACCT_TYPE = "ACCT_TYPE";
	public static final String REFACTORED_DTM = "REFACTORED_DTM";
	public static final String DEMO_INDICATOR = "DEMO_INDICATOR";
	public static final String DEMO_INDICATOR_VALUE = "N";
	public static final String OTC_BOO = "OTC_BOO";
	public static final String OTC_BOO_VALUE = "0";
	
	 public static final String ONE_HR_EVENT_DISPATCH = "1 HR EVENT DISPATCH";
     public static final String FIFTIN_MIN_EVENT_DISPATCH = "15 MIN EVENT DISPATCH";
     public static final String THIRTY_MIN_EVENT_DISPATCH = "30 MIN EVENT DISPATCH";
     public static final int ONE_HR_EVENT_DISPATCH_ID=3;
     public static final int FIFTIN_MIN_EVENT_DISPATCH_ID=1;
     public static final int THIRTY_MIN_EVENT_DISPATCH_ID=4;
    
}