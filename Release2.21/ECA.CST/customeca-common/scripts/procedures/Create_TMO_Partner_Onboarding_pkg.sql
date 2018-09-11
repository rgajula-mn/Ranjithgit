CREATE OR REPLACE EDITIONABLE PACKAGE "TMO_PARTNER_ONBOARDING_PKG" AS
pragma serially_reusable;

  type discount_details_row_type is record(
    pricing_tier          varchar2(10),
    threshold_start_range number,
    threshold_end_range   number,
    discount_amount       number);
  type discount_details_list_type is table of discount_details_row_type index by pls_integer;
  type discount_row_type is record(
    event_type_name      varchar2(40),
    UOM                  varchar2(100),
    charge_applied_attr  varchar2(40),
    threshold_value_attr varchar2(40),
    discount_Details     discount_details_list_type);
  type rt_details_row_type is record(
    event_class          varchar2(100),
    charge               number,
    UOM                  varchar2(100),
    MRC_aggregation_type varchar2(200),
    MRC_included         number,
    overage_unit         varchar2(100),
    scale_rounding_type  varchar2(100),
    scale_unit_size      varchar2(50),
    scale_rounding_value number,
    cost_rounding_type   varchar2(100));

  type rt_details_list_type is table of rt_details_row_type index by pls_integer;
  type rating_tariff_row_type is record(
    event_type_name varchar2(40),
    rt_details      rt_details_list_type);

  type rating_tariff_list_type is table of rating_tariff_row_type index by pls_integer;
  type discount_list_type is table of discount_row_type index by pls_integer;
  type tlo_object_id_list_type is table of varchar2(40) index by pls_integer;
  type partner_id_list_type is table of number index by pls_integer;
  type price_plan_row_type is record(
    transaction_id       varchar2(40),
    price_plan_name      varchar2(40),
    tlo_object_id_list   tlo_object_id_list_type,
    pricing_tier_boo     boolean,
    MRC_aggregation_type varchar2(200),
    MRC_category         varchar2(255),
    MRC_charge           number,
    TaxCat_Code          varchar2(100),
    rating_tariff_list   rating_tariff_list_type,
    discount_list        discount_list_type,
	sim_bank_tlo_id      tlo_object_id_list_type,
	link_to_demo_partner_id_list partner_id_list_type);

  type price_plan_list_type is table of price_plan_row_type index by pls_integer;
  type rate_plan_output_row_type is record(
    rate_plan_id   number,
    rate_plan_name varchar2(40),
    event_type_id  number);
  type rate_plan_output_list_type is table of rate_plan_output_row_type index by pls_integer;

  type price_plan_output_row_type is record(
    transaction_id        varchar2(40),
    price_plan_id         number,
    price_plan_name       varchar2(40),
    product_id            number,
    WPS_valid_from        date,
    WPS_end_date          date,
    rate_plan_output_list rate_plan_output_list_type);

  type price_plan_output_list_type is table of price_plan_output_row_type index by pls_integer;

  Procedure getAutoCustomerRefAndAccount(Partner_Name       varchar,
                                         BillingCustomerRef out varchar,
                                         RatingCustomerRef  out varchar,
                                         BillingAccountNum  out varchar,
                                         RatingAccountNum   out varchar,
                                         mrkt_segment_id    out number);

  Procedure customTablesUpdate(Partner_Name     varchar,
                               RatingAccountNum varchar,
                               AcctType         varchar);

  Procedure createCatalogue(p_transaction_id        varchar,
                            p_rating_account_number varchar,
                            suspend_MRC_flag        boolean,
                            Suspend_Charge          number,
							suspend_category        varchar,
                            TaxCat_Code             varchar,
                            p_price_plan_list       price_plan_list_type,
                            price_plan_output_list  out price_plan_output_list_type);
							
								   
  Procedure addTaxExemptionsOnAccount(p_transaction_id  varchar,
                                   p_billing_acct_num varchar,
                                   status out      varchar,
							       description out varchar);

END TMO_PARTNER_ONBOARDING_PKG;
/

CREATE OR REPLACE PACKAGE BODY "TMO_PARTNER_ONBOARDING_PKG" AS
  pragma serially_reusable;

  type ovg_details_row_type is record(
    ovg_rating_tariff_id      number,
    ovg_rating_tariff_type_id number,
    rate_PP_id                number,
    event_class               varchar2(100),
    threshold                 number);
  type ovg_rating_tariff_id_list_type is table of ovg_details_row_type index by pls_integer;
  subtype rating_element_row_type is geneva_admin.ratingelement%rowtype;
  subtype tariff_basis_row_type is geneva_admin.tariffbasis%rowtype;

  --tax exemption changes_
  type record_type is record(
    state_code geneva_admin.ustaccounthasexemption.state_code%type,
    tax_type   geneva_admin.ustaccounthasexemption.external_tax_type_id%type);
  type jcode_type is record(
    jcode       geneva_admin.ustaccounthasexemption.exemption_jcode%type,
    county_name geneva_admin.ustaccounthasexemption.county_name%type,
    city_name   geneva_admin.ustaccounthasexemption.city_name%type);
  type state_taxtype_type is table of record_type;
  type tax_auth_type is table of geneva_admin.ustaccounthasexemption.exemption_tax_authority%type;
  type tax_jcode_type is table of jcode_type;

  ----Global Variables-----
  g_partner_name     varchar(100);
  g_sales_start_date date;
  g_sales_end_date   date;
  --g_tax_cat_code      varchar2(50);
  g_acct_type                 varchar2(50);
  g_rating_cat_change_id      number;
  g_cat_change_id             number;
  g_product_family_id         number;
  g_product_id                number;
  g_dummy_PP_id               number;
  g_billing_PP_id             number;
  g_ovg_rating_tariff_id_list ovg_rating_tariff_id_list_type;
  --g_use_sequence         varchar2(1);
  g_shortname     varchar2(20);
  g_mktsegment_id number;

  --call_stack  varchar2(4096) default dbms_utility.format_call_stack;

  ---Gparams-----
  gparam_POBCatStatusType constant varchar2(100) := 'POBCatalogueChangeStatusType';
  gparam_POBUseSequence   constant varchar2(100) := 'POBUseSequence';

  -----Constant variables-----
  --Product related constants---
  C_MVNO_PRODUCT_FAMILY_NAME constant varchar(40) := 'MVNO Billing Acct Prod';
  C_MVNO_PRODUCT_FAMILY_DESC constant varchar(80) := 'MVNO Billing Account Products';
  C_SPACE                    constant varchar(1) := ' ';
  C_MVNO_PRODUCT_NAME        constant varchar(40) := 'MVNO Mobile Summ Pro';
  C_MVNO_PRODUCT_DESC        constant varchar(80) := 'MVNO Mobile Summary Product';
  C_PARAMETRIC_BOO           constant varchar2(1) := 'F';
  C_PROVISIONING_SYSTEM_ID   constant number := 1;
  C_PRODUCT_CLASS_ID         constant number := 3;
  C_REGULATED_BOO            constant varchar2(1) := 'F';
  C_DEBIT_BOO                constant varchar2(1) := 'F';
  C_ON_NETMATCH_TYPE         constant number := 4;
  C_PRODUCT_TYPE             constant number := 1;
  C_CHARGE_TYPE              constant number := 2;

  --Catalogue related constants--
  C_CATALOGUE_DESIGN_STATUS constant number := 1;
  C_CATALOGUE_LIVE_STATUS   constant number := 3;
  C_RATING_CATALOGUE_NAME   constant varchar2(100) := '_POB_Wizard' ||
                                                      to_char(sysdate,
                                                              'MMDDYYY');
  C_RATING_CATALOGUE_DESC   constant varchar2(100) := '_Partner Onboarding Wizard rating catalogue changes_' ||
                                                      to_char(sysdate,
                                                              'MMDDYYY');
  C_CATALOGUE_DESC          constant varchar2(100) := '_Partner Onboarding Wizard catalogue changes_' ||
                                                      to_char(sysdate,
                                                              'MMDDYYY');
  --C_CAT_CURRENCY            CONSTANT VARCHAR(3) := 'USD';
  --C_TMOBILE_CUSTOM_USER     CONSTANT VARCHAR2(20) := 'TMOBILE_CUSTOM';
  --C_LANGUAGE_ID             CONSTANT NUMBER := 7;
  --C_ENCRYPT_PASSWORD_BOO    CONSTANT VARCHAR2(1) := 'F';
  C_INVOICING_COID CONSTANT NUMBER := 2;

  --billing price plan related constants--
  C_VAR_BILLING_TARIFF  constant varchar2(50) := 'VAR Billing Tariff';
  C_MVNO_BILLING_TARIFF constant varchar2(50) := 'Billing Standalone PP';

  --Tariff related constants---
  C_MVNO_PRICE_PLAN_ID           CONSTANT NUMBER := 501;
  C_M2M_PRICE_PLAN_ID            CONSTANT NUMBER := 503;
  C_MVNO_PRODUCT_FAMILY_ID       CONSTANT NUMBER := 51;
  C_M2M_PRODUCT_FAMILY_ID        CONSTANT NUMBER := 52;
  C_MVNO_PRODUCT_ID              CONSTANT NUMBER := 1501;
  C_M2M_PRODUCT_ID               CONSTANT NUMBER := 1509;
  C_TARIFF_TYPE_ID               CONSTANT NUMBER := 1;
  C_CONTRACT_TERMS_BOO           CONSTANT VARCHAR2(1) := 'F';
  C_TAX_INCLUSIVE_BOO            CONSTANT VARCHAR2(1) := 'F';
  C_CHARGE_PERIOD                CONSTANT NUMBER := 1;
  C_CHARGE_PERIOD_UNITS          CONSTANT VARCHAR2(1) := 'M';
  C_INADVANCE_BOO                CONSTANT VARCHAR2(1) := 'F';
  C_PRORATE_BOO                  CONSTANT VARCHAR2(1) := 'F';
  C_REFUNDABLE_BOo               CONSTANT VARCHAR2(1) := 'F';
  C_MARGINAL_BOO                 CONSTANT VARCHAR2(1) := 'F';
  C_M2M_GENESIS_PRODUCT_CHARGES  CONSTANT NUMBER := 64;
  C_MVNO_GENESIS_PRODUCT_CHARGES CONSTANT NUMBER := 86;
  C_UNDEFINED                    CONSTANT NUMBER := -1;
  C_TRACK_CHANGES_BOO            CONSTANT VARCHAR2(1) := 'T';
  C_EARLY_TERMPRORATE_BOO        CONSTANT VARCHAR2(1) := 'F';
  C_AT_MIDNIGHT_ON_THAT_DAY      CONSTANT NUMBER := 1;
  C_AT_MIDNIGHT_ON_THE_FOLLW_DAY CONSTANT NUMBER := 2;
  C_MODTYPE_NO_CHARGE            CONSTANT NUMBER := 4;
  C_M2MDEMO_MKTSEGMNT_ID         CONSTANT NUMBER := 20;
  C_STD_REC_PPA_ID               CONSTANT NUMBER := 2;
  C_SUSPEND_REC_PPA_ID           CONSTANT NUMBER := 3;
  C_PRORATE                      CONSTANT VARCHAR2(10) := 'PRORATE';

  --Error codes----
  ERR_001 constant varchar2(100) := 'Partner_Name is null. Please pass value.';
  ERR_002 constant varchar2(100) := 'Existing customer already having same partner name. Please pass diff partnerName.';
  ERR_003 constant varchar2(100) := 'length of customer_ref or account num length is crossed max 20 limit';
  ERR_004 constant varchar2(100) := 'RatingAccountNum is null. Please pass value.';
  ERR_005 constant varchar2(100) := 'Either tax_category or tax_code is null. Please pass correct values.';
  ERR_006 constant varchar2(100) := 'Sales start date is null. Please pass correct values.';
  ERR_007 constant varchar2(100) := 'Partner information cannot find with the given rating account num.';
  ERR_008 constant varchar2(100) := 'ProductFamilyId value cannot be null';
  ERR_009 constant varchar2(100) := 'ProductId value cannot be null';
  ERR_010 constant varchar2(100) := 'Unkown value for gparam POBCatalogueChangeStatusType. Pass either 1 or 3 value';
  ERR_011 constant varchar2(100) := 'Price plan list should not be null';
  ERR_012 constant varchar2(100) := 'Price plan details cannot not be null';
  ERR_013 constant varchar2(100) := 'MRC cannot not be null';
  ERR_014 constant varchar2(100) := 'MRC details cannot not be null';
  ERR_015 constant varchar2(100) := 'Rating tariff list cannot not be null';
  ERR_018 constant varchar2(100) := 'Rating tariff details cannot not be null';
  ERR_016 constant varchar2(100) := 'Discount list cannot not be null';
  ERR_017 constant varchar2(100) := 'Discount details cannot not be null';
  ERR_019 constant varchar2(100) := 'Suspend MRC flag cannot not be null';
  ERR_020 constant varchar2(100) := 'If suspend MRC flag is true ,required all other suspend attribute values cannot be null';
  ERR_021 constant varchar2(100) := 'Failed to get event type id for given event type name';
  ERR_022 constant varchar2(100) := 'Suspend charge and suspend tax_cat_code cannot be null';
  ERR_023 constant varchar2(100) := 'POBUseSequence gparam value cannot be null';
  ERR_024 constant varchar2(100) := 'Rating tariff name exceeding max length 40';
  ERR_025 constant varchar2(100) := 'Please pass correct MRC aggregation type value';
  ERR_026 constant varchar2(100) := 'Scale unit size should be either KB or MB.';
  ERR_027 constant varchar2(100) := 'Cannot indentify scaler rounding type or cost rounding id with given values';
  ERR_028 constant varchar2(100) := 'Unable to derive costing rule name';
  ERR_029 constant varchar2(100) := 'Subscriber level charges are conflicting with tiered discounts';
  ERR_030 constant varchar2(100) := 'Cannot find billing catalogue and rating catalogue id';
  ERR_031 constant varchar2(200) := 'Cannot find billing catalogue and rating catalogue id with design status on top of live billing catalogue id';
  ERR_032 constant varchar2(200) := 'Cannot find max rating catalogue id with design status on top of live rating  catalogue id';
  ERR_033 constant varchar2(200) := 'Max rating catalogue is not linked to max billing catalogue id in design status';
  ERR_034 constant varchar2(200) := 'Cannot find cost band with the country name ';
  ERR_035 constant varchar2(200) := 'Cannot find tariff and product information for billing acct num ';
  ERR_036 constant varchar2(200) := 'Cannot find partner with the given rating acct num ';
  ERR_037 constant varchar2(200) := 'Cannot find sim bank tariff for given sim bank TLO ID ';
  ERR_038 constant varchar2(200) := 'Cannot find demo partner with given demo partner id ';
  ERR_039 constant varchar2(200) := 'Cannot find partner with passed billing acct num or found empty tax exem data';
  ERR_040 constant varchar2(200) := 'Tax exemptions already created  and cannot support modify or delete for this account ';
  ERR_041 constant varchar2(200) := 'MRC included should be same for both offnet and onenet ';
  ERR_042 constant varchar2(200) := 'Overage unit should be same for both offnet and onenet ';
  ERR_043 constant varchar2(200) := 'Cannot find attr num with given attr name and  event type id ';
  ERR_044 constant varchar2(200) := 'Cannot find rating tariff type with given event type name and ovg unit ';
  ERR_045 constant varchar2(200) := 'Found multiple records for given counry name ';
  ERR_046 constant varchar2(200) := 'Cannot find ref data for given cost band ref  ';

  /* type event_type_name_type is table of varchar2(10) index by pls_integer;
  v_event_type_name_list event_type_name_type;
  v_event_type_name_list(1) := 'Voice';
  v_event_type_name_list(2) := 'SMS';
  v_event_type_name_list(3) := 'GPRS';
  v_event_type_name_list(4) := 'MMS';
   */

  Procedure logErrorMessages(p_transaction_id varchar,
                             p_account_num    varchar,
                             p_method         varchar,
                             p_error_message  varchar) as
    pragma autonomous_transaction;
  begin
    insert into TMO_POB_ERROR_MESSAGES
      (error_message_id,
       transaction_id,
       account_num,
       method_name,
       error_message1)
    values
      (POB_ERROR_MESSAGE_SEQ.NEXTVAL,
       p_transaction_id,
       p_account_num,
       p_method,
       p_error_message);
    commit;
  end;

  Procedure getAutoCustomerRefAndAccount(Partner_Name       varchar,
                                         BillingCustomerRef out varchar,
                                         RatingCustomerRef  out varchar,
                                         BillingAccountNum  out varchar,
                                         RatingAccountNum   out varchar,
                                         mrkt_segment_id    out number) as
    testCust     varchar2(1);
    custPrefix   varchar2(5);
    accNumPrefix varchar2(5);
    nextNum      number;
    v_max_id     number;
    v_sql        clob;
    v_exist      number;
  begin
    if (Partner_Name is null) then
      raise_application_error(-20000, ERR_001);
    end if;
    select count(1)
      into v_exist
      from TMOBILE_CUSTOM.TMO_ACCT_MAPPING
     where customer_name = Partner_Name;
    if (v_exist > 0) then
      raise_application_error(-20001, ERR_002);
    end if;
    testCust := gnvgen.getgparamString('PartnerOnBoardingTestAccount');
    if (testCust = 'T') then
      custPrefix   := gnvgen.getgparamString('POBcustomerRefPrefix');
      accNumPrefix := gnvgen.getgparamString('POBAccountNumPrefix');
    else
      custPrefix   := gnvgen.getgparamString('SYScustomerRefPrefix');
      accNumPrefix := gnvgen.getgparamString('SYSaccountNumPrefix');
    end if;
  
    select TMOBILE_CUSTOM.POBCUSTOMERANDACCOUNT_SEQ.NEXTVAL
      INTO nextNum
      from dual;
    if (mod(nextNum, 2) != 0) then
      nextNum := nextNum + 1;
    end if;
    RatingCustomerRef := custPrefix || to_char(nextNum);
    RatingAccountNum  := accNumPrefix || to_char(nextNum);
  
    select TMOBILE_CUSTOM.POBCUSTOMERANDACCOUNT_SEQ.NEXTVAL
      INTO nextNum
      from dual;
    if (mod(nextNum, 2) = 0) then
      nextNum := nextNum + 1;
    end if;
    BillingCustomerRef := custPrefix || to_char(nextNum);
    BillingAccountNum  := accNumPrefix || to_char(nextNum);
    if (length(BillingCustomerRef) > 20 or length(BillingAccountNum) > 20 or
       length(RatingCustomerRef) > 20 or length(RatingAccountNum) > 20) then
      raise_application_error(-20002, ERR_003);
    end if;
    dbms_output.put_line(BillingCustomerRef || ' ' || BillingAccountNum || ' ' ||
                         RatingCustomerRef || ' ' || RatingAccountNum);
    v_sql := q'[insert INTO geneva_admin.marketsegment (MARKET_SEGMENT_ID, MARKET_SEGMENT_NAME, REFERENCED_BOO, MARKET_SEGMENT_DESC, INVOICING_CO_ID) values( :mrkt_segment_id,:partnerName,'T',:Offerings,2)]';
    select max(market_segment_id) + 1
      INTO mrkt_segment_id
      from marketsegment;
    execute immediate v_sql
      using mrkt_segment_id, Partner_Name, Partner_Name || ' Offerings';
  exception
    when others then
      dbms_output.put_line(sqlcode);
      raise;
  end getAutoCustomerRefAndAccount;

  Procedure customTablesUpdate(Partner_Name     varchar,
                               RatingAccountNum varchar,
                               AcctType         varchar) AS
  begin
    if (Partner_Name is null or RatingAccountNum is null or
       AcctType is null) then
      raise_application_error(-20000, ERR_004);
    end if;
    ---insert data INTO extract_info table---
    INSERT ALL INTO TMOBILE_CUSTOM.TMO_EXTRACTINFO
      (ACCOUNT_NUM,
       EXTRACT_TYPE,
       EXTRACT_CATEGORY,
       EXTRACT_FILE_SEQ,
       MVNO_ID,
       LAST_EXTRACT_DTM)
    VALUES
      (RatingAccountNum, 'M', 'D', '0', Partner_Name, systimestamp) INTO TMOBILE_CUSTOM.TMO_EXTRACTINFO
      (ACCOUNT_NUM,
       EXTRACT_TYPE,
       EXTRACT_CATEGORY,
       EXTRACT_FILE_SEQ,
       MVNO_ID,
       LAST_EXTRACT_DTM)
    VALUES
      (RatingAccountNum, 'M', 'V', '0', Partner_Name, systimestamp) INTO TMOBILE_CUSTOM.TMO_EXTRACTINFO
      (ACCOUNT_NUM,
       EXTRACT_TYPE,
       EXTRACT_CATEGORY,
       EXTRACT_FILE_SEQ,
       MVNO_ID,
       LAST_EXTRACT_DTM)
    VALUES
      (RatingAccountNum, 'D', 'D', '1', Partner_Name, systimestamp) INTO TMOBILE_CUSTOM.TMO_EXTRACTINFO
      (ACCOUNT_NUM,
       EXTRACT_TYPE,
       EXTRACT_CATEGORY,
       EXTRACT_FILE_SEQ,
       MVNO_ID,
       LAST_EXTRACT_DTM)
    VALUES
      (RatingAccountNum, 'D', 'V', '1', Partner_Name, systimestamp)
      SELECT * FROM dual;
    ---insert data INTO TMO_SUMM_POP_METHODS_80---
    if (INSTR(AcctType, 'MVNO') > 0) then
      INSERT ALL INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'gprs',
         '_populateGPRSandOverageEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'international gprs',
         '_populateDataEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'international sms',
         '_populateMsgEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name), 'sms', '_populateMsgEvent', 'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name), 'mms', '_populateMsgEvent', 'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'international voice',
         '_populateVoiceEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'voice',
         '_populateVoiceEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'genesis_mvno_sum_gprs_ovg',
         null,
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
		 (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
	  values
        (lower(Partner_Name),
         'genesis_mvno_sum_voice_ovg',
         null,
         'EVENTSUMMARY')INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'genesis_mvno_sum_sms_ovg',
         null,
         'EVENTSUMMARY')
        SELECT * FROM dual;
    else
    
      INSERT ALL INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'gprs',
         '_populateGPRSandOverageEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'international gprs',
         '_populateDataEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'international sms',
         '_populateMsgEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name), 'sms', '_populateMsgEvent', 'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'international voice',
         '_populateVoiceEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'voice',
         '_populateVoiceEvent',
         'EVENTSUMMARY') INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'genesis_mvno_sum_gprs_ovg',
         null,
         'EVENTSUMMARY')INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80 
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'genesis_mvno_sum_voice_ovg',
         null,
         'EVENTSUMMARY')INTO TMOBILE_CUSTOM.TMO_SUMM_POP_METHODS_80
        (CLIENT_NAME, SUMM_EVENT_TYPE, POP_METHOD, PROCESS_NAME)
      values
        (lower(Partner_Name),
         'genesis_mvno_sum_sms_ovg',
         null,
         'EVENTSUMMARY')
        SELECT * FROM dual;
    end if;
    insert into tmo_canned_reportid_mapping
      (select script_id || substr(tam.rating_acct_nbr, 4),
              script_id,
              (case
                when script_id in (150) then
                 report_identifier || '_' || tam.customer_name
                when script_id in (160, 169) then
                 report_identifier || '.' || tam.customer_name
                when script_id = 161 then
                 report_identifier || '.' || tam.rating_cust_ref
                when script_id in (162, 175) then
                 tam.customer_name || '_' || report_identifier
                when script_id = 171 then
                 report_identifier || '_' || tam.billing_event_src
              end) Actual_report_identifier
         from tmo_canned_report_details can, tmo_acct_mapping tam
        where script_id in (150, 160, 169, 162, 175, 171, 161)
          and tam.rating_acct_nbr = RatingAccountNum);
  exception
    when others then
      dbms_output.put_line(sqlcode);
      raise;
  end customTablesUpdate;

  --Get max id of given column name from table ---
  function getmaxId(p_tablename         varchar,
                    p_columnname        varchar,
                    p_cataloguechangeid number,
                    p_ratingcatalogueid number) return number as
    v_sql    clob := 'select max(##p_columnname##)+1 from ##p_tablename## ';
    v_max_id number;
  begin
    if (p_cataloguechangeid is not null and p_ratingcatalogueid is not null) then
      raise_application_error(-20000,
                              'Cannot pass both p_cataloguechangeid and p_ratingcatalogueid');
    end if;
    v_sql := replace(v_sql, '##p_columnname##', p_columnname);
    v_sql := replace(v_sql, '##p_tablename##', p_tablename);
    if (p_cataloguechangeid is not null) then
      v_sql := v_sql || ' where catalogue_change_id = ' ||
               p_cataloguechangeid;
    elsif (p_ratingcatalogueid is not null) then
      v_sql := v_sql || ' where rating_catalogue_id = ' ||
               p_ratingcatalogueid;
    end if;
    dbms_output.put_line('v_sql is ' || v_sql);
    execute immediate v_sql
      into v_max_id;
    dbms_output.put_line(v_max_id);
    return v_max_id;
  exception
    when others then
      raise;
  end getmaxId;
  
  /* create procedure getTaxCatCode(p_tax_cat_code varchar,
                                 tax_cat out number,
								 tax_code out number)
  as
  v_part1 varchar2(200);
  begin
  SELECT trim(Substr(p_tax_cat_code, 1, Instr(p_tax_cat_code, ' - ') - 1)) into v_part1 
  FROM   dual;
  SELECT to_number(SUBSTR(v_part1,
                            0,
                            instr(v_part1, '|') - 1)),
           to_number(SUBSTR(v_part1, instr(v_part1, '|') + 1))
      into tax_cat, tax_code
      from dual;
      dbms_output.put_line(tax_cat);
       dbms_output.put_line(tax_code);
  end getTaxCatCode; */

  ---creates product related information--
  Procedure createProductInfo(p_tax_cat_code varchar) as
    v_tax_cat  number;
    v_tax_code number;
    v_max_id   number;
  begin
    dbms_output.put_line('createProductInfo procedure started');
    SELECT to_number(SUBSTR(p_tax_cat_code,
                            0,
                            instr(p_tax_cat_code, '|') - 1)),
           to_number(SUBSTR(p_tax_cat_code, instr(p_tax_cat_code, '|') + 1))
      into v_tax_cat, v_tax_code
      from dual;
    if (v_tax_cat is null or v_tax_code is null) then
      raise_application_error(-20000, ERR_005);
    end if;
    dbms_output.put_line('v_tax_cat and v_tax_code is ' || v_tax_cat ||
                         v_tax_code);
    /* if (g_use_sequence = 'F') then
      g_product_family_id := getmaxId('GENEVA_ADMIN.PRODUCTFAMILY',
                                      'PRODUCT_FAMILY_ID',
                                      null,
                                      null);
      g_product_id        := getmaxId('GENEVA_ADMIN.PRODUCT',
                                      'PRODUCT_ID',
                                      null,
                                      null);
    end if; */
  
    --create new product family for MVNO--
    dbms_output.put_line('before g_product_family_id is ' ||
                         g_product_family_id);
    geneva_admin.gnvproductfamily.createproductfamily1nc(p_productfamilyid   => g_product_family_id,
                                                         p_productfamilyname => g_shortname ||
                                                                                C_SPACE ||
                                                                                C_MVNO_PRODUCT_FAMILY_NAME,
                                                         p_productfamilydesc => g_partner_name ||
                                                                                C_SPACE ||
                                                                                C_MVNO_PRODUCT_FAMILY_DESC);
    geneva_admin.gnvbillstylehasprodfam.createprodfamilybillstyle1nc(p_billstyleid     => 34,
                                                                     p_productfamilyid => g_product_family_id);
    if (g_product_family_id is null) then
      raise_application_error(-20000, ERR_008);
    end if;
    dbms_output.put_line('g_product_family_id is ' || g_product_family_id);
    --create new product for MVNO--
    geneva_admin.gnvproducttype.createProducttype2NC(p_productid                 => g_product_id,
                                                     p_productname               => g_shortname ||
                                                                                    C_SPACE ||
                                                                                    C_MVNO_PRODUCT_NAME,
                                                     p_productdesc               => g_partner_name ||
                                                                                    C_SPACE ||
                                                                                    C_MVNO_PRODUCT_DESC,
                                                     p_salesstartdat             => g_sales_start_date,
                                                     p_salesenddat               => g_sales_end_date,
                                                     p_productfamilyid           => g_product_family_id,
                                                     p_parentproductid           => null,
                                                     p_productunitsingularname   => null,
                                                     p_productunitpluralname     => null,
                                                     p_parametricboo             => C_PARAMETRIC_BOO,
                                                     p_producteventsourcecaption => null,
                                                     p_eventsourcebreakoutobject => null,
                                                     p_provisioningsystemid      => C_PROVISIONING_SYSTEM_ID,
                                                     p_productclassid            => C_PRODUCT_CLASS_ID,
                                                     p_regulatedboo              => C_REGULATED_BOO,
                                                     p_debitboo                  => C_DEBIT_BOO,
                                                     p_onnetmatchtype            => C_ON_NETMATCH_TYPE,
                                                     p_producttype               => C_PRODUCT_TYPE);
    if (g_product_id is null) then
      raise_application_error(-20001, ERR_009);
    end if;
    dbms_output.put_line('g_product_id is ' || g_product_id);
    --add event types for above product---
    for rec in (select distinct summary_event_type
                  from tmobile_custom.tmo_event_mapping) loop
      geneva_admin.gnvprodhaseventtype.createprodhaseventtype1nc(p_productid   => g_product_id,
                                                                 p_eventtypeid => rec.summary_event_type);
    end loop;
    dbms_output.put_line('asscoiated events to product is completed');
    ---- Configure Product Tax Classification
    geneva_admin.gnvustprodcatcode.createustprodcatcode1nc(p_productid     => g_product_id,
                                                           p_chargetype    => C_CHARGE_TYPE,
                                                           p_ustcategoryid => v_tax_cat,
                                                           p_ustcodeid     => v_tax_code);
    dbms_output.put_line('createProductInfo procedure ended');
  exception
    when others then
      raise;
  end createProductInfo;

  Procedure createCatalogueChange as
    v_gparam_value       number;
    v_cnt                number;
    v_copylivecat        boolean := false;
    v_live_cat_id        number;
    v_live_rating_cat_id number;
    v_max_cat_id         number;
    v_rating_cat_id      number;
    v_max_rating_cat_id  number;
  begin
    dbms_output.put_line('createCatalogueChange procedure started');
    v_gparam_value := geneva_admin.gnvgen.getgparaminteger(gparam_POBCatStatusType);
    dbms_output.put_line('v_gparam_value value ' || v_gparam_value);
    select cc.catalogue_change_id, rc.rating_catalogue_id
      into v_live_cat_id, v_live_rating_cat_id
      from geneva_admin.cataloguechange cc, geneva_admin.ratingcatalogue rc
     where cc.catalogue_status = C_catalogue_live_status
       and cc.invoicing_co_id = C_INVOICING_COID
       and rc.rating_catalogue_id = cc.rating_catalogue_id
       and rc.invoicing_co_id = cc.invoicing_co_id;
    dbms_output.put_line('v_live_cat_id value ' || v_live_cat_id);
    dbms_output.put_line('v_live_rating_cat_id value ' ||
                         v_live_rating_cat_id);
    if (v_gparam_value = 1) then
      select max(cc.catalogue_change_id), max(rc.rating_catalogue_id)
        into v_max_cat_id, v_rating_cat_id
        from geneva_admin.cataloguechange cc,
             geneva_admin.ratingcatalogue rc
       where cc.catalogue_status = v_gparam_value
         and cc.invoicing_co_id = C_INVOICING_COID
         and rc.rating_catalogue_id = cc.rating_catalogue_id
         and rc.invoicing_co_id = cc.invoicing_co_id
         and cc.catalogue_change_id > v_live_cat_id
         and rc.rating_catalogue_id > v_live_rating_cat_id;
      dbms_output.put_line('v_max_cat_id value ' || v_max_cat_id);
      dbms_output.put_line('v_rating_cat_id value ' || v_rating_cat_id);
      if (v_max_cat_id is null) then
        raise_application_error(-20000, ERR_031);
      end if;
      select max(rating_catalogue_id)
        into v_max_rating_cat_id
        from geneva_admin.ratingcatalogue
       where catalogue_status = v_gparam_value
         and invoicing_co_id = C_INVOICING_COID
         and rating_catalogue_id > v_live_rating_cat_id;
      if (v_max_rating_cat_id is null) then
        raise_application_error(-20000, ERR_032);
      end if;
      if (v_rating_cat_id is not null and
         v_rating_cat_id != v_max_rating_cat_id) then
        raise_application_error(-20000,
                                ERR_033 || ' billing cat id ' ||
                                v_max_cat_id || ' rating cat id is ' ||
                                v_rating_cat_id);
      elsif (v_rating_cat_id is null) then
        geneva_admin.gnvbcp.linkratingcataloguenocommit(billcatid => v_max_cat_id,
                                                        ratecatid => v_max_rating_cat_id);
      end if;
      g_cat_change_id        := v_max_cat_id;
      g_rating_cat_change_id := v_max_rating_cat_id;
    elsif (v_gparam_value = 3) then
      geneva_admin.gnvbcp.copycataloguenocommit(catid     => g_cat_change_id,
                                                catname   => g_shortname ||
                                                             C_RATING_CATALOGUE_NAME,
                                                catdesc   => g_partner_name ||
                                                             C_catalogue_desc,
                                                copycatid => v_live_cat_id);
      dbms_output.put_line('g_cat_change_id value is ' || g_cat_change_id);
      --copy rating catalogue change id--
      geneva_admin.gnvrcp.copycataloguenocommit(catid     => g_rating_cat_change_id,
                                                catname   => g_shortname ||
                                                             C_RATING_CATALOGUE_NAME,
                                                catdesc   => g_partner_name ||
                                                             C_RATING_CATALOGUE_DESC,
                                                copycatid => v_live_rating_cat_id);
      dbms_output.put_line('g_rating_cat_change_id value is ' ||
                           g_rating_cat_change_id);
      --link rating catalogue change id  to billing catalogue change id--
      geneva_admin.gnvbcp.linkratingcataloguenocommit(billcatid => g_cat_change_id,
                                                      ratecatid => g_rating_cat_change_id);
    else
      raise_application_error(-20000, ERR_010);
    end if;
    dbms_output.put_line('createCatalogueChange procedure ended');
  end createCatalogueChange;

  function createPredicate(p_ratingtarifftypeid  number,
                           p_predicatename       varchar,
                           p_predicatetype       varchar,
                           p_predicatedesc       varchar,
                           p_spredicateoperator  number,
                           p_cpredicateoperator  number,
                           p_operand1attributeid number,
                           p_operand2attributeid number,
                           p_operand2value       varchar) return number as
    v_predicate_id number;
  begin
  
    geneva_admin.gnvpredicate.createpredicate1nc(p_predicateid         => v_predicate_id,
                                                 p_ratingcatalogueid   => g_rating_cat_change_id,
                                                 p_ratingtarifftypeid  => p_ratingtarifftypeid,
                                                 p_predicatename       => p_predicatename,
                                                 p_predicatetype       => p_predicatetype,
                                                 p_predicatedesc       => p_predicatedesc,
                                                 p_spredicateoperator  => p_spredicateoperator,
                                                 p_cpredicateoperator  => p_cpredicateoperator,
                                                 p_operand1attributeid => p_operand1attributeid,
                                                 p_operand2attributeid => p_operand2attributeid,
                                                 p_operand2value       => p_operand2value);
  
    return v_predicate_id;
  end;

  Procedure createCompositePredicate(p_predicateid        number,
                                     p_operandpredicateid number) as
  begin
    --create composite predicate--
    dbms_output.put_line('before createCompositePredicate ');
    geneva_admin.gnvcompositepredicate.createcompositepredicate1nc(p_ratingcatalogueid  => g_rating_cat_change_id,
                                                                   p_predicateid        => p_predicateid,
                                                                   p_operandpredicateid => p_operandpredicateid,
                                                                   p_negateoperandboo   => 'F');
    dbms_output.put_line('after createCompositePredicate ');
  end createCompositePredicate;

  function createEventClass(p_ratingtarifftypeid number,
                            p_eventclassname     varchar,
                            p_eventclassdesc     varchar) return number as
    v_event_class_id number;
  begin
    geneva_admin.gnveventclass.createeventclass1nc(p_eventclassid       => v_event_class_id,
                                                   p_ratingcatalogueid  => g_rating_cat_change_id,
                                                   p_ratingtarifftypeid => p_ratingtarifftypeid,
                                                   p_eventclassname     => p_eventclassname,
                                                   p_eventclassdesc     => p_eventclassdesc);
    return v_event_class_id;
  end createEventClass;

  function createModifer(p_modifiergroupid number,
                         p_modifiername    varchar,
                         p_predicateid     number,
                         p_modifierdesc    varchar,
                         p_eventclassid    number) return number as
    v_modifierid       number;
    v_modifierpriority number;
  begin
  
    geneva_admin.gnvmodifier.createmodifier3nc(p_modifierid           => v_modifierid,
                                               p_ratingcatalogueid    => g_rating_cat_change_id,
                                               p_modifiergroupid      => p_modifiergroupid,
                                               p_modifiergroupversion => 1,
                                               p_modifiername         => p_modifiername,
                                               p_predicateid          => p_predicateid,
                                               p_modifierdesc         => p_modifierdesc,
                                               p_eventclassid         => p_eventclassid,
                                               p_modifierpriority     => v_modifierpriority);
  
    return v_modifierid;
  end createModifer;

  function createRatingTariff(p_tariffname          varchar,
                              p_tariffdesc          varchar,
                              p_ratingtarifftypeid  number,
                              p_bandingmodelid      number,
                              p_defaultcostbandid   number,
                              p_modifiergroupid     number,
                              p_defaulteventclassid number) return number as
    v_ratingtariffid      number;
    v_priorratingtariffid number;
    v_nextratingtariffid  number;
  begin
  
    geneva_admin.gnvratingtariff.createratingtariff2nc(p_ratingtariffid      => v_ratingtariffid,
                                                       p_ratingcatalogueid   => g_rating_cat_change_id,
                                                       p_tariffname          => p_tariffname,
                                                       p_tariffdesc          => p_tariffdesc,
                                                       p_salesstartdat       => g_sales_start_date,
                                                       p_salesenddat         => g_sales_end_date,
                                                       p_ratingtarifftypeid  => p_ratingtarifftypeid,
                                                       p_bandingmodelid      => p_bandingmodelid,
                                                       p_defaultcostbandid   => p_defaultcostbandid,
                                                       p_modifiergroupid     => p_modifiergroupid,
                                                       p_defaulteventclassid => p_defaulteventclassid,
                                                       p_intratingtariffid   => null,
                                                       p_extratingtariffid   => null,
                                                       p_suppratingtariffid  => null,
                                                       p_taxinclusiveboo     => 'F',
                                                       p_plugintariffboo     => 'F',
                                                       p_automaticboo        => 'F',
                                                       p_partialtariffboo    => 'F',
                                                       p_predicateid         => null,
                                                       p_priorratingtariffid => v_priorratingtariffid,
                                                       p_nextratingtariffid  => v_nextratingtariffid);
    return v_ratingtariffid;
  end createRatingTariff;

  Procedure createTariffBasis(p_ratingtariffid  number,
                              p_costbandid      number,
                              p_eventclassid    number,
                              p_timeratediaryid number,
                              p_stepgroupid     number,
                              p_costingrulesid  number) as
  v_cnt number;
  begin
  select count(1) into v_cnt
  from geneva_admin.tariffbasis
  where rating_tariff_id = p_ratingtariffid
  and cost_band_id = p_costbandid
  and event_class_id = p_eventclassid
  and time_rate_diary_id = p_timeratediaryid
  and step_group_id = p_stepgroupid
  and costing_rules_id = p_costingrulesid
  and rating_catalogue_id = g_rating_cat_change_id
  and end_dat is null;
  if(v_cnt = 0) then 
    geneva_admin.gnvtariffbasis.createtariffbasis1nc(p_ratingtariffid    => p_ratingtariffid,
                                                     p_costbandid        => p_costbandid,
                                                     p_eventclassid      => p_eventclassid,
                                                     p_onnetboo          => 'F',
                                                     p_startdat          => g_sales_start_date,
                                                     p_ratingcatalogueid => g_rating_cat_change_id,
                                                     p_enddat            => g_sales_end_date,
                                                     p_timeratediaryid   => p_timeratediaryid,
                                                     p_stepgroupid       => p_stepgroupid,
                                                     p_costingrulesid    => p_costingrulesid);
   end if;
  
  end createTariffBasis;

  Procedure createRatingElement(p_ratingtariffid  number,
                                p_costbandid      number,
                                p_eventclassid    number,
                                p_timerateid      number,
                                p_chargesegmentid number,
                                p_chargingrate    number,
                                p_fixedchargemny  number) as
  v_cnt number;								
  begin
  select count(1) into v_cnt
  from geneva_admin.ratingelement
  where rating_tariff_id = p_ratingtariffid
  and cost_band_id = p_costbandid
  and event_class_id = p_eventclassid
  and time_rate_id = p_timerateid
  and charge_segment_id = p_chargesegmentid
  and NVL(charging_rate,-1) = NVL(p_chargingrate,-1)
  and NVL(fixed_charge_mny,-1) = NVL(p_fixedchargemny,-1)
  and rating_catalogue_id = g_rating_cat_change_id
  and end_dat is null;
  
  if(v_cnt = 0) then 
    geneva_admin.gnvratingelement.createratingelement5nc(p_ratingtariffid    => p_ratingtariffid,
                                                         p_costbandid        => p_costbandid,
                                                         p_eventclassid      => p_eventclassid,
                                                         p_onnetboo          => 'F',
                                                         p_timerateid        => p_timerateid,
                                                         p_chargesegmentid   => p_chargesegmentid,
                                                         p_startdat          => g_sales_start_date,
                                                         p_ratingcatalogueid => g_rating_cat_change_id,
                                                         p_enddat            => g_sales_end_date,
                                                         p_fixedchargemny    => p_fixedchargemny,
                                                         p_chargingrate      => p_chargingrate,
                                                         p_mincostmny        => null,
                                                         p_maxcostmny        => null,
                                                         p_fixedpoints       => null,
                                                         p_pointrate         => null,
                                                         p_unitduration      => null,
                                                         p_revenuecodeid     => null,
                                                         p_ustcodeid         => null,
                                                         p_ustcategoryid     => null,
                                                         p_taxoverrideid     => null,
                                                         p_unitname          => null,
                                                         p_dropeventboo      => 'F');
  end if;
  end createRatingElement;

  Function getColumnValue(p_tablename             varchar,
                          p_condition_columnname  varchar,
                          p_condition_columnvalue varchar,
                          p_columnname            varchar,
                          p_tariff_type_id        number) return number as
    v_sql clob;
    v_id  number;
  begin
    v_sql := 'select ' || p_columnname || ' from ' || p_tablename ||
             ' where RATING_CATALOGUE_ID = ' || g_rating_cat_change_id ||
             ' and RATING_TARIFF_TYPE_ID = ' || p_tariff_type_id || ' and ' ||
             p_condition_columnname || ' = ' || '''' ||
             p_condition_columnvalue || '''';
    dbms_output.put_line('v_sql is ' || v_sql);
    execute immediate v_sql
      into v_id;
    return v_id;
  exception
    when NO_DATA_FOUND then
      dbms_output.put_line('not returned any data v_sql' || v_sql);
      raise_application_error('-20000',
                              'not found any data v_sql' || v_sql);
  end getColumnValue;

  Function derivedNameFromTariff(p_tariffname varchar, p_addon varchar)
    return varchar as
    v_rating_tariff_name varchar2(100);
    v_shortname          varchar2(50);
  begin
    v_rating_tariff_name := p_tariffname || ' ' || p_addon;
    if (length(v_rating_tariff_name) > 40) then
      select substr(p_tariffname, 1, instr(p_tariffname, ' ', 1) - 1) || ' ' ||
             substr(regexp_replace(p_tariffname, '(^| )([^ ])([^ ])*', '\2'),
                    2)
        into v_shortname
        from dual;
      v_rating_tariff_name := v_shortname || ' ' || p_addon;
      if (length(v_rating_tariff_name) > 40) then
        select regexp_replace(p_tariffname, '(^| )([^ ])([^ ])*', '\2')
          into v_shortname
          from dual;
        v_rating_tariff_name := v_shortname || ' ' || p_addon;
      end if;
      if (length(v_rating_tariff_name) > 40) then
        raise_application_error('-20000', ERR_024);
      end if;
    end if;
    return v_rating_tariff_name;
  end derivedNameFromTariff;

  Procedure createRTAndTB(p_rating_tariff_id      number,
                          p_cost_band_id          number,
                          p_charge_event_class_id number,
                          p_free_event_class_id   number,
                          p_charge_amt            number,
                          p_tariff_type_id        number,
                          p_event_type_name       varchar,
                          p_ovg_unit_size         varchar) as
    v_time_rate_diary_id number;
    v_step_group_id      number;
    v_costing_rules_id   number;
    v_time_rate_id       number;
    v_charge_segment_id  number;
    v_cost_band_id       number;
    v_fixed_mny          number;
    v_chg_mny            number;
  begin
    v_cost_band_id       := p_cost_band_id;
    v_time_rate_diary_id := getColumnValue('GENEVA_ADMIN.TIMERATEDIARY',
                                           'TIME_RATE_DIARY_NAME',
                                           'Standard',
                                           'TIME_RATE_DIARY_ID',
                                           p_tariff_type_id);
    v_step_group_id      := getColumnValue('GENEVA_ADMIN.STEPGROUP',
                                           'STEP_GROUP_NAME',
                                           'Standard',
                                           'STEP_GROUP_ID',
                                           p_tariff_type_id);
    v_time_rate_id       := getColumnValue('GENEVA_ADMIN.TIMERATE',
                                           'TIME_RATE_NAME',
                                           'Standard',
                                           'TIME_RATE_ID',
                                           p_tariff_type_id);
    v_charge_segment_id  := getColumnValue('GENEVA_ADMIN.CHARGESEGMENT',
                                           'CHARGE_SEGMENT_NAME',
                                           'Standard',
                                           'CHARGE_SEGMENT_ID',
                                           p_tariff_type_id);
    v_costing_rules_id   := getColumnValue('GENEVA_ADMIN.COSTINGRULES',
                                           'COSTING_RULES_NAME',
                                           'Scalar Rnd None-Cost Rnd Nearest',
                                           'COSTING_RULES_ID',
                                           p_tariff_type_id);
    dbms_output.put_line('v_time_rate_diary_id v_cost_band_id' ||
                         v_time_rate_id || ' ' || v_charge_segment_id || ' ' ||
                         v_costing_rules_id || ' ' || v_step_group_id || ' ' ||
                         v_time_rate_diary_id);
    if (p_event_type_name = 'Voice') then
      v_chg_mny := p_charge_amt;
      createTariffBasis(p_rating_tariff_id,
                        v_cost_band_id,
                        p_charge_event_class_id,
                        v_time_rate_diary_id,
                        v_step_group_id,
                        v_costing_rules_id);
      createRatingElement(p_rating_tariff_id,
                          v_cost_band_id,
                          p_charge_event_class_id,
                          v_time_rate_id,
                          v_charge_segment_id,
                          v_chg_mny,
                          null);
      if (p_free_event_class_id is not null) then
        createTariffBasis(p_rating_tariff_id,
                          v_cost_band_id,
                          p_free_event_class_id,
                          v_time_rate_diary_id,
                          v_step_group_id,
                          v_costing_rules_id);
      
        createRatingElement(p_rating_tariff_id,
                            v_cost_band_id,
                            p_free_event_class_id,
                            v_time_rate_id,
                            v_charge_segment_id,
                            0,
                            null);
      end if;
      v_cost_band_id := getColumnValue('GENEVA_ADMIN.COSTBAND',
                                       'COST_BAND_NAME',
                                       'Airtime-Intrastate',
                                       'COST_BAND_ID',
                                       p_tariff_type_id);
    
    elsif (p_event_type_name = 'GPRS') then
      v_chg_mny := p_charge_amt;
      if (p_ovg_unit_size = 'MB') then
        v_costing_rules_id := getColumnValue('GENEVA_ADMIN.COSTINGRULES',
                                             'COSTING_RULES_NAME',
                                             'Scalar Rnd Up KB-Cost Rnd Nearest',
                                             'COSTING_RULES_ID',
                                             p_tariff_type_id);
      elsif (p_ovg_unit_size = 'GB') then
        v_costing_rules_id := getColumnValue('GENEVA_ADMIN.COSTINGRULES',
                                             'COSTING_RULES_NAME',
                                             'Scalar Rnd None-Cost Rnd Nearest',
                                             'COSTING_RULES_ID',
                                             p_tariff_type_id);
      end if;
    elsif (p_event_type_name = 'SMS') then
	v_chg_mny := p_charge_amt;
      --v_fixed_mny := p_charge_amt;
    end if;
  dbms_output.put_line('before v_chg_mny is ' || v_chg_mny);
    createTariffBasis(p_rating_tariff_id,
                      v_cost_band_id,
                      p_charge_event_class_id,
                      v_time_rate_diary_id,
                      v_step_group_id,
                      v_costing_rules_id);
    createRatingElement(p_rating_tariff_id,
                        v_cost_band_id,
                        p_charge_event_class_id,
                        v_time_rate_id,
                        v_charge_segment_id,
                        v_chg_mny,
                        v_fixed_mny);
  
    if (p_free_event_class_id is not null) then
      createTariffBasis(p_rating_tariff_id,
                        v_cost_band_id,
                        p_free_event_class_id,
                        v_time_rate_diary_id,
                        v_step_group_id,
                        v_costing_rules_id);
        createRatingElement(p_rating_tariff_id,
                            v_cost_band_id,
                            p_free_event_class_id,
                            v_time_rate_id,
                            v_charge_segment_id,
                            0,
                            null);
      
    end if;
  
  end createRTAndTB;

  Procedure createOvgRatingTariff(p_event_type_name varchar,
                                  p_tariffname      varchar,
                                  p_tariffid        number,
                                  p_threshold       number,
                                  p_ovg_unit_size   varchar,
                                  p_standard_ovg    boolean,
                                  p_standard_charge number,
                                  p_roaming_ovg     boolean,
                                  p_roaming_charge  number) as
    v_tariff_type_id            number;
    v_PP_predicate_id           number;
    v_charge_PP_id              number;
    v_free_PP_id                number;
    v_charge_predicate_id       number;
    v_free_predicate_id         number;
    v_charge_event_class_id     number;
    v_free_event_class_id       number;
    v_modifer_group_id          number;
    v_modifiergroupversion      number;
    v_charge_modifer            number;
    v_free_modifier             number;
    v_rating_tariff_id          number;
    v_cost_band_id              number;
    v_banding_model_id          number;
    v_event_class_id            number;
    v_time_rate_diary_id        number;
    v_step_group_id             number;
    v_costing_rules_id          number;
    v_time_rate_id              number;
    v_charge_segment_id         number;
    v_charge_amt                number;
    v_std_ovg                   boolean;
    v_roam_ovg                  boolean;
    v_std_predicate_id          number;
    v_roam_predicate_id         number;
    v_both_ovg                  boolean;
    v_charge_predicate_name     varchar2(40);
    v_event_class_charge_name   varchar2(40);
    v_ovg_existsboo             boolean := false;
	v_ovg_rate_plan_existsboo   boolean := false;
    v_cnt                       number;
    v_diff_chg_ovg              boolean;
    v_std_charge_predicate_name varchar2(40);
    v_ex_charge_predicate_name  varchar2(40);
    v_event_class_regexp        varchar2(100);
    v_std_charge_PP_id          number;
    v_std_charge_event_class_id number;
    v_std_charge_amt            number;
  begin
    dbms_output.put_line('createOvgRatingTariff procedure started');
    v_std_ovg  := p_standard_ovg;
    v_roam_ovg := p_roaming_ovg;
	 dbms_output.put_line('p_standard_charge is ' || p_standard_charge);
	 dbms_output.put_line('p_roaming_charge is ' || p_roaming_charge);
    if (p_standard_ovg and p_roaming_ovg and
       p_standard_charge = p_roaming_charge) then
      v_both_ovg := true;
      v_std_ovg  := false;
      v_roam_ovg := false;
    elsif (p_standard_ovg and p_roaming_ovg and
          p_standard_charge != p_roaming_charge) then
      v_diff_chg_ovg := true;
      v_std_ovg      := false;
      v_roam_ovg     := false;
    end if;
    begin
      select rating_tariff_type_id
        into v_tariff_type_id
        from GENEVA_ADMIN.RATINGTARIFFTYPE
       where rating_catalogue_id = g_rating_cat_change_id
         and rating_tariff_type_name like
             decode(p_event_type_name,
                    'GPRS',
                    '%' || p_event_type_name || '_Ovg_' || p_ovg_unit_size,
                    '%' || p_event_type_name || '_Ovg');
      dbms_output.put_line(v_tariff_type_id);
    exception
      when no_data_found then
        raise_application_error(-20000, ERR_044);
    end;
  
    --create simple predicate with price plan name ---
    v_PP_predicate_id := createPredicate(v_tariff_type_id,
                                         p_tariffname,
                                         'S',
                                         g_partner_name || p_tariffname,
                                         3,
                                         null,
                                         20,
                                         null,
                                         p_tariffname);
    dbms_output.put_line('v_PP_predicate_id' || v_PP_predicate_id);
    v_charge_predicate_id := getColumnValue('GENEVA_ADMIN.PREDICATE',
                                            'PREDICATE_NAME',
                                            'Charge',
                                            'PREDICATE_ID',
                                            v_tariff_type_id);
    dbms_output.put_line('v_charge_predicate_id' || v_charge_predicate_id);
    v_free_predicate_id := getColumnValue('GENEVA_ADMIN.PREDICATE',
                                          'PREDICATE_NAME',
                                          'Free',
                                          'PREDICATE_ID',
                                          v_tariff_type_id);
    v_std_predicate_id  := getColumnValue('GENEVA_ADMIN.PREDICATE',
                                          'PREDICATE_NAME',
                                          'Standard',
                                          'PREDICATE_ID',
                                          v_tariff_type_id);
    v_roam_predicate_id := getColumnValue('GENEVA_ADMIN.PREDICATE',
                                          'PREDICATE_NAME',
                                          'Roaming',
                                          'PREDICATE_ID',
                                          v_tariff_type_id);
										  
	v_cnt := g_ovg_rating_tariff_id_list.count;
    if (v_cnt > 0) then
      for x in 1 .. g_ovg_rating_tariff_id_list.count loop
		if (v_tariff_type_id = g_ovg_rating_tariff_id_list(x)
           .ovg_rating_tariff_type_id ) then
		  v_ovg_existsboo    := true;
		  v_rating_tariff_id := g_ovg_rating_tariff_id_list(x)
                                .ovg_rating_tariff_id;
		  exit;
        end if;
      end loop;
    end if;
    --create modifer group---
	if (not v_ovg_existsboo) then
    geneva_admin.gnvmodifiergroup.createmodifiergroup2nc(p_modifiergroupid      => v_modifer_group_id,
                                                         p_ratingcatalogueid    => g_rating_cat_change_id,
                                                         p_ratingtarifftypeid   => v_tariff_type_id,
                                                         p_modifiergroupname    => g_shortname ||
                                                                                   ' Modifier Group',
                                                         p_modifiergroupdesc    => g_partner_name ||
                                                                                   ' Modifier Group',
                                                         p_startdat             => g_sales_start_date,
                                                         p_enddat               => g_sales_end_date,
                                                         p_modifiergroupversion => v_modifiergroupversion);
    dbms_output.put_line('v_modifer_group_id' || v_modifer_group_id);
	v_free_event_class_id   := getColumnValue('GENEVA_ADMIN.EVENTCLASS',
                                           'EVENT_CLASS_NAME',
                                           'Free',
                                           'EVENT_CLASS_ID',
                                           v_tariff_type_id);
    dbms_output.put_line('v_free_event_class_id' || v_free_event_class_id);
    v_free_modifier := createModifer(v_modifer_group_id,
                                     'Free',
                                     v_free_predicate_id,
                                     g_partner_name || ' ' || p_tariffname ||
                                     ' Free',
                                     v_free_event_class_id);
    dbms_output.put_line('v_free_modifier' || v_free_modifier);
	
	else
	select modifier_group_id into v_modifer_group_id
	from geneva_admin.modifiergroup 
	where rating_catalogue_id = g_rating_cat_change_id
	and rating_tariff_type_id = v_tariff_type_id
	and modifier_group_name = g_shortname || ' Modifier Group'
	and end_dat is null;
	
	end if;
    if (v_diff_chg_ovg) then
      dbms_output.put_line('v_diff_chg_ovg are true');
      v_event_class_regexp        := 'Standard|Roaming';
      v_std_charge_predicate_name := derivedNameFromTariff(p_tariffname,
                                                           'Std Chg');
      v_std_charge_PP_id          := createPredicate(v_tariff_type_id,
                                                     v_std_charge_predicate_name,
                                                     'C',
                                                     g_partner_name || ' ' ||
                                                     p_tariffname ||
                                                     ' Charge',
                                                     null,
                                                     1,
                                                     null,
                                                     null,
                                                     null);
      createCompositePredicate(v_std_charge_PP_id, v_charge_predicate_id);
      createCompositePredicate(v_std_charge_PP_id, v_PP_predicate_id);
      createCompositePredicate(v_std_charge_PP_id, v_std_predicate_id);
      dbms_output.put_line('createCompositePredicate are called');
      v_std_charge_event_class_id := createEventClass(v_tariff_type_id,
                                                      v_std_charge_predicate_name,
                                                      g_partner_name || ' ' ||
                                                      p_tariffname || ' Chg');
      v_charge_modifer            := createModifer(v_modifer_group_id,
                                                   v_std_charge_predicate_name,
                                                   v_std_charge_PP_id,
                                                   g_partner_name || ' ' ||
                                                   p_tariffname || ' Charge',
                                                   v_std_charge_event_class_id);
      dbms_output.put_line('v_charge_modifer' || v_charge_modifer);
      v_std_charge_amt        := p_standard_charge;
      v_charge_predicate_name := derivedNameFromTariff(p_tariffname,
                                                       'Roam Chg');
      v_charge_amt            := p_roaming_charge;
    else
      if (v_both_ovg) then
        v_event_class_regexp    := 'Standard|Roaming';
        v_charge_predicate_name := derivedNameFromTariff(p_tariffname,
                                                         'Chg');
        v_charge_amt            := p_standard_charge;
      elsif (v_std_ovg) then
        v_event_class_regexp    := 'Standard';
        v_charge_predicate_name := derivedNameFromTariff(p_tariffname,
                                                         'Std Chg');
        v_charge_amt            := p_standard_charge;
      elsif (v_roam_ovg) then
        v_event_class_regexp    := 'Roaming';
        v_charge_predicate_name := derivedNameFromTariff(p_tariffname,
                                                         'Roam Chg');
        v_charge_amt            := p_roaming_charge;
      end if;
    end if;
    v_charge_PP_id := createPredicate(v_tariff_type_id,
                                      v_charge_predicate_name,
                                      'C',
                                      g_partner_name || ' ' || p_tariffname ||
                                      ' Charge',
                                      null,
                                      1,
                                      null,
                                      null,
                                      null);
    dbms_output.put_line('v_charge_PP_id' || v_charge_PP_id);
    /* v_free_PP_id := createPredicate(v_tariff_type_id,
                                    derivedNameFromTariff(p_tariffname,
                                                          'Free'),
                                    'C',
                                    g_partner_name || ' ' || p_tariffname ||
                                    ' Free',
                                    null,
                                    1,
                                    null,
                                    null,
                                    null);
    dbms_output.put_line('v_free_PP_id' || v_free_PP_id); */
    createCompositePredicate(v_charge_PP_id, v_charge_predicate_id);
    createCompositePredicate(v_charge_PP_id, v_PP_predicate_id);
  
    --createCompositePredicate(v_free_PP_id, v_free_predicate_id);
    --createCompositePredicate(v_free_PP_id, v_PP_predicate_id);
    dbms_output.put_line('composite predicates are associated');
    if (v_std_ovg) then
      createCompositePredicate(v_charge_PP_id, v_std_predicate_id);
      --createCompositePredicate(v_free_PP_id, v_std_predicate_id);
      dbms_output.put_line('std composite predicates are associated');
    end if;
    if (v_diff_chg_ovg) then
      createCompositePredicate(v_charge_PP_id, v_roam_predicate_id);
    end if;
    if (v_roam_ovg) then
      createCompositePredicate(v_charge_PP_id, v_roam_predicate_id);
      --createCompositePredicate(v_free_PP_id, v_roam_predicate_id);
    end if;
    v_charge_event_class_id := createEventClass(v_tariff_type_id,
                                                v_charge_predicate_name,
                                                g_partner_name || ' ' ||
                                                p_tariffname || ' Chg');
    dbms_output.put_line('v_charge_event_class_id' ||
                         v_charge_event_class_id);
   /*  v_free_event_class_id := createEventClass(v_tariff_type_id,
                                              derivedNameFromTariff(p_tariffname,
                                                                    'Free'),
                                              g_partner_name || ' ' ||
                                              p_tariffname || ' Free'); */
	 /* v_free_event_class_id   := getColumnValue('GENEVA_ADMIN.EVENTCLASS',
                                           'EVENT_CLASS_NAME',
                                           'Free',
                                           'EVENT_CLASS_ID',
                                           v_tariff_type_id);
    dbms_output.put_line('v_free_event_class_id' || v_free_event_class_id);
    v_free_modifier := createModifer(v_modifer_group_id,
                                     derivedNameFromTariff(p_tariffname,
                                                           'Free'),
                                     v_free_PP_id,
                                     g_partner_name || ' ' || p_tariffname ||
                                     ' Free',
                                     v_free_event_class_id);
    dbms_output.put_line('v_free_modifier' || v_free_modifier); */
    v_charge_modifer := createModifer(v_modifer_group_id,
                                      v_charge_predicate_name,
                                      v_charge_PP_id,
                                      g_partner_name || ' ' || p_tariffname ||
                                      ' Charge',
                                      v_charge_event_class_id);
    dbms_output.put_line('v_charge_modifer' || v_charge_modifer);
    if (p_event_type_name = 'Voice') then
    
      v_banding_model_id := getColumnValue('GENEVA_ADMIN.BANDINGMODEL',
                                           'BANDING_MODEL_NAME',
                                           'Standard',
                                           'BANDING_MODEL_ID',
                                           v_tariff_type_id);
      v_cost_band_id     := getColumnValue('GENEVA_ADMIN.COSTBAND',
                                           'COST_BAND_NAME',
                                           'Airtime-Interstate',
                                           'COST_BAND_ID',
                                           v_tariff_type_id);
      v_event_class_id   := getColumnValue('GENEVA_ADMIN.EVENTCLASS',
                                           'EVENT_CLASS_NAME',
                                           'Free',
                                           'EVENT_CLASS_ID',
                                           v_tariff_type_id);
      dbms_output.put_line('v_banding_model_id' || v_banding_model_id);
    
    elsif (p_event_type_name = 'SMS') then
    
      v_cost_band_id := getColumnValue('GENEVA_ADMIN.COSTBAND',
                                       'COST_BAND_NAME',
                                       'Standard',
                                       'COST_BAND_ID',
                                       v_tariff_type_id);
    
    elsif (p_event_type_name = 'GPRS') then
    
      v_banding_model_id := getColumnValue('GENEVA_ADMIN.BANDINGMODEL',
                                           'BANDING_MODEL_NAME',
                                           'Standard',
                                           'BANDING_MODEL_ID',
                                           v_tariff_type_id);
      v_cost_band_id     := getColumnValue('GENEVA_ADMIN.COSTBAND',
                                           'COST_BAND_NAME',
                                           'Standard',
                                           'COST_BAND_ID',
                                           v_tariff_type_id);
      v_event_class_id   := getColumnValue('GENEVA_ADMIN.EVENTCLASS',
                                           'EVENT_CLASS_NAME',
                                           'Free',
                                           'EVENT_CLASS_ID',
                                           v_tariff_type_id);
      dbms_output.put_line('v_banding_model_id v_cost_band_id' ||
                           v_banding_model_id || ' ' || v_cost_band_id || ' ' ||
                           v_event_class_id);
    end if;
    if (not v_ovg_existsboo) then
      v_rating_tariff_id := createRatingTariff('Genesis_Summ_' ||
                                               p_event_type_name || '_Ovg_' ||
                                               g_shortname,
                                               'Genesis_Summ_' ||
                                               p_event_type_name || '_Ovg_' ||
                                               g_partner_name,
                                               v_tariff_type_id,
                                               v_banding_model_id,
                                               v_cost_band_id,
                                               v_modifer_group_id,
                                               v_event_class_id);
      dbms_output.put_line('v_rating_tariff_id ' || v_rating_tariff_id);
	   
	  end if;
	  v_cnt := v_cnt + 1;
       g_ovg_rating_tariff_id_list(v_cnt).ovg_rating_tariff_id := v_rating_tariff_id;
      g_ovg_rating_tariff_id_list(v_cnt).ovg_rating_tariff_type_id := v_tariff_type_id;
      g_ovg_rating_tariff_id_list(v_cnt).rate_PP_id := p_tariffid;
      g_ovg_rating_tariff_id_list(v_cnt).event_class := v_event_class_regexp;
      g_ovg_rating_tariff_id_list(v_cnt).threshold := p_threshold;
  dbms_output.put_line('v_charge_amt is ' || v_charge_amt);
    createRTAndTB(v_rating_tariff_id,
                  v_cost_band_id,
                  v_charge_event_class_id,
                  v_free_event_class_id,
                  v_charge_amt,
                  v_tariff_type_id,
                  p_event_type_name,
                  p_ovg_unit_size);
    if (v_diff_chg_ovg) then
      createRTAndTB(v_rating_tariff_id,
                    v_cost_band_id,
                    v_std_charge_event_class_id,
                    null,
                    v_std_charge_amt,
                    v_tariff_type_id,
                    p_event_type_name,
                    p_ovg_unit_size);
    end if;
  
    dbms_output.put_line('createOvgRatingTariff procedure ended ' ||
                         v_rating_tariff_id);
  end createOvgRatingTariff;

  Procedure createtariffelementmarketseg(p_productid     number,
                                         p_tariffid      number,
                                         v_mktsegment_id number) as
    v_cnt number;
  begin
    dbms_output.put_line('createtariffelementmarketseg');
    dbms_output.put_line('p_productid ' || p_productid);
    dbms_output.put_line('p_tariffid ' || p_tariffid);
    dbms_output.put_line('g_cat_change_id ' || g_cat_change_id);
    dbms_output.put_line('v_mktsegment_id ' || v_mktsegment_id);
    select count(1)
      into v_cnt
      from geneva_admin.tariffelementhasmktsegment
     where tariff_id = p_tariffid
       and catalogue_change_id = g_cat_change_id
       and market_segment_id = v_mktsegment_id
       and product_id = p_productid;
    if (v_cnt = 0) then
      geneva_admin.gnvtariffelmntmktseg.createtariffelmntmktseg1nc(p_productid         => p_productid,
                                                                   p_tariffid          => p_tariffid,
                                                                   p_cataloguechangeid => g_cat_change_id,
                                                                   p_marketsegmentid   => v_mktsegment_id);
    end if;
  
  end createtariffelementmarketseg;

  function createEventFilter(p_filtername      varchar,
                             p_filterdesc      varchar,
                             p_filtertypeid    number,
                             p_eventtypeid     number,
                             p_attributenumber number) return number as
    v_event_filter_num number;
  begin
    --creates event filter----
    geneva_admin.gnveventfilter.createeventfilter2nc(p_eventfilterid     => v_event_filter_num,
                                                     p_cataloguechangeid => g_cat_change_id,
                                                     p_filtername        => p_filtername,
                                                     p_filtertypeid      => p_filtertypeid,
                                                     p_filterdesc        => p_filterdesc,
                                                     p_eventtypeid       => p_eventtypeid,
                                                     p_attributenumber   => p_attributenumber,
                                                     p_maxelementcount   => null,
                                                     p_matchtype         => null);
  
    return v_event_filter_num;
  end createEventFilter;

  Procedure createFilterElement(p_eventfilterid  number,
                                p_attributevalue varchar,
                                p_matchtypeid    number) as
    v_element_num number;
  begin
    --creates  filter element ----
    geneva_admin.gnvfilterelement.createfilterelement1nc(p_eventfilterid     => p_eventfilterid,
                                                         p_elementnumber     => v_element_num,
                                                         p_cataloguechangeid => g_cat_change_id,
                                                         p_attributevalue    => p_attributevalue,
                                                         p_matchtypeid       => p_matchtypeid);
  
  end createFilterElement;

  function getEventTypeId(p_event_type_name varchar, p_ovg_boo boolean)
    return number as
    v_event_type    varchar2(50);
    v_event_type_id number;
  begin
  
    if (p_ovg_boo) then
      v_event_type := 'Sum_' || p_event_type_name || '_Ovg';
    else
      v_event_type := 'Sum_' || p_event_type_name;
    end if;
    SELECT SUMMARY_EVENT_TYPE
      into v_event_type_id
      FROM TMOBILE_CUSTOM.TMO_EVENT_MAPPING
     WHERE EVENT_SUMMARY_NAME LIKE '%' || V_EVENT_TYPE;
    return v_event_type_id;
  exception
    when others then
      raise_application_error(-20002, ERR_021);
  end;

  Procedure createCompositeFilter(p_compositefilterid number,
                                  p_eventfilterid     number) as
    v_FilterNumber number;
  begin
    --Create Composite filter---
    geneva_admin.gnvcompositefilter.createcompositefilter1nc(p_compositefilterid => p_compositefilterid,
                                                             p_filternumber      => v_FilterNumber,
                                                             p_cataloguechangeid => g_cat_change_id,
                                                             p_eventfilterid     => p_eventfilterid);
  
  end createCompositeFilter;

  Function getAttributeNum(p_event_type_id number, p_attr_name varchar)
    return number as
    v_attr_num number;
  begin
    select ATTR_NUM
      into v_attr_num
      from TMOBILE_CUSTOM.TMO_THRESHOLD_ATTRIBUTES
     where event_type_id = p_event_type_id
       and plugin_input_name = p_attr_name;
    return v_attr_num;
  exception
    when no_data_found then
      raise_application_error(-20000,
                              ERR_043 || p_attr_name || ' ' ||
                              p_event_type_id);
  end;

  Procedure createTiredDiscounts(p_discount_list discount_list_type,
                                 p_tariffname    varchar,
                                 p_tariffid      number) as
    v_comp_event_filter_id    number;
    v_eq_event_filter_id      number;
    v_low_event_filter_id     number;
    v_high_event_filter_id    number;
    v_discount_data           discount_row_type;
    v_discount_details        discount_Details_row_type;
    v_event_discount_id       number;
    v_event_type_id           number;
    v_amount_divisor          number;
    v_actual_charge           number;
    v_ovg_rating_tariff_id    number;
    v_threshold_attr_num      number;
    v_charge_applied_attr_num number;
    v_discountsummultiplier   number;
    v_charge                  number;
    v_ovg_charge              number;
    v_derive_UOM              varchar2(40);
  begin
    dbms_output.put_line('createTiredDiscounts function started');
    for X in 1 .. p_discount_list.count loop
      v_discount_data           := p_discount_list(X);
      v_event_type_id           := getEventTypeId(v_discount_data.event_type_name,
                                                  true);
      v_threshold_attr_num      := getAttributeNum(v_event_type_id,
                                                   v_discount_data.threshold_value_attr);
      v_charge_applied_attr_num := getAttributeNum(v_event_type_id,
                                                   v_discount_data.charge_applied_attr);
      if (v_discount_data.UOM = 'MB') then
        v_amount_divisor        := 1048576;
        v_discountsummultiplier := 1048576;
        v_derive_UOM            := v_discount_data.UOM;
      elsif (v_discount_data.UOM = 'GB') then
        v_amount_divisor        := 1073741824;
        v_discountsummultiplier := 1048576;
        v_derive_UOM            := v_discount_data.UOM;
      elsif (v_discount_data.UOM = 'Minute') then
        v_amount_divisor        := 60;
        v_discountsummultiplier := 60;
        v_derive_UOM            := v_discount_data.UOM;
      else
        v_amount_divisor        := 1;
        v_discountsummultiplier := 1;
        v_derive_UOM            := 'SMS';
      end if;
    
      v_eq_event_filter_id := createEventFilter(p_tariffname,
                                                'BTN=' || g_partner_name ||
                                                'tiered' || p_tariffname,
                                                1,
                                                v_event_type_id,
                                                10);
      createFilterElement(v_eq_event_filter_id, p_tariffname, 3);
    
      for Y in 1 .. v_discount_data.discount_Details.count loop
        v_discount_details := v_discount_data.discount_Details(Y);
        v_charge           := v_discount_details.discount_amount * power(10, 4);
        if (v_discount_details.pricing_tier = 'Tier1') then
          v_actual_charge := v_charge;
          v_ovg_charge := v_actual_charge * power(10, 2);
		   dbms_output.put_line('v_ovg_charge is ' ||
                               v_ovg_charge);
          createOvgRatingTariff(v_discount_data.event_type_name,
                                p_tariffname,
                                p_tariffid,
                                0,
                                v_discount_data.UOM,
                                true,
                                v_ovg_charge,
                                true,
                                v_ovg_charge);
        else
          v_event_discount_id    := null;
          v_comp_event_filter_id := createEventFilter(g_shortname ||
                                                      ' Tier ' || Y || '- ' ||
                                                      v_discount_details.threshold_start_range ||
                                                      ' to ' ||
                                                      nvl(cast(v_discount_details.threshold_end_range as
                                                               varchar2),
                                                          'Above') ||
                                                      v_derive_UOM,
                                                      g_partner_name ||
                                                      ' Tier ' || Y || '- ' ||
                                                      v_discount_details.threshold_start_range ||
                                                      v_discount_data.UOM ||
                                                      ' to ' ||
                                                      nvl(cast(v_discount_details.threshold_end_range as
                                                               varchar2),
                                                          'Above') ||
                                                      v_discount_data.UOM,
                                                      4,
                                                      v_event_type_id,
                                                      null);
          dbms_output.put_line('v_comp_event_filter_id is ' ||
                               v_comp_event_filter_id);
        
          v_low_event_filter_id := createEventFilter(g_shortname ||
                                                     ' Tier ' || Y ||
                                                     '-  >= ' ||
                                                     v_discount_details.threshold_start_range ||
                                                     v_discount_data.UOM,
                                                     g_partner_name ||
                                                     ' Tier ' || Y ||
                                                     '-  >= ' ||
                                                     v_discount_details.threshold_start_range ||
                                                     v_discount_data.UOM,
                                                     1,
                                                     v_event_type_id,
                                                     v_threshold_attr_num);
          dbms_output.put_line('v_low_event_filter_id is ' ||
                               v_low_event_filter_id);
        
          createFilterElement(v_low_event_filter_id,
                              v_discount_details.threshold_start_range *
                              v_amount_divisor,
                              9);
        
          createCompositeFilter(v_comp_event_filter_id,
                                v_eq_event_filter_id);
          createCompositeFilter(v_comp_event_filter_id,
                                v_low_event_filter_id);
        
          if (v_discount_details.threshold_end_range is not null) then
            v_high_event_filter_id := createEventFilter(g_shortname ||
                                                        ' Tier ' || Y ||
                                                        '-  < ' ||
                                                        v_discount_details.threshold_end_range ||
                                                        v_discount_data.UOM,
                                                        g_partner_name ||
                                                        ' Tier ' || Y ||
                                                        '-  < ' ||
                                                        v_discount_details.threshold_end_range ||
                                                        v_discount_data.UOM,
                                                        1,
                                                        v_event_type_id,
                                                        v_threshold_attr_num);
            createFilterElement(v_high_event_filter_id,
                                v_discount_details.threshold_end_range *
                                v_amount_divisor,
                                1);
            createCompositeFilter(v_comp_event_filter_id,
                                  v_high_event_filter_id);
          end if;
          dbms_output.put_line('createCompositeFilter are associated');
        
          --creates event discount----
          geneva_admin.gnvflatratdiscount.createflatratdiscount1nc(p_eventdiscountid          => v_event_discount_id,
                                                                   p_cataloguechangeid        => g_cat_change_id,
                                                                   p_discountname             => g_shortname ||
                                                                                                 ' Tier ' || Y || '- ' ||
                                                                                                 v_discount_details.threshold_start_range ||
                                                                                                 ' to ' ||
                                                                                                 nvl(cast(v_discount_details.threshold_end_range as
                                                                                                          varchar2),
                                                                                                     'Above') ||
                                                                                                 v_derive_UOM,
                                                                   p_discountdesc             => g_partner_name ||
                                                                                                 ' Tier ' || Y || '- ' ||
                                                                                                 v_discount_details.threshold_start_range ||
                                                                                                 v_discount_data.UOM ||
                                                                                                 ' to ' ||
                                                                                                 nvl(cast(v_discount_details.threshold_end_range as
                                                                                                          varchar2),
                                                                                                     'Above') ||
                                                                                                 v_discount_data.UOM,
                                                                   p_summationattrnum         => v_threshold_attr_num,
                                                                   p_marginaldiscountboo      => 'T',
                                                                   p_revenuecodeid            => null,
                                                                   p_assessmentaggreglevel    => 5,
                                                                   p_assessmenteventtypeid    => v_event_type_id,
                                                                   p_assessmentfilterid       => v_comp_event_filter_id,
                                                                   p_proratingboo             => 'F',
                                                                   p_parametricboo            => 'F',
                                                                   p_discacttholdsetid        => null,
                                                                   p_ratingassessmentcriteria => 2,
                                                                   p_includeposttermboo       => 'T',
                                                                   p_ratingaccumulateboo      => 'F',
                                                                   p_ratingdiscountpct        => null,
                                                                   p_ratingdiscountamt        => v_actual_charge -
                                                                                                 v_charge,
                                                                   p_amountperunitboo         => 'T',
                                                                   p_discountsumattrnum       => v_charge_applied_attr_num,
                                                                   p_discountsummultiplier    => v_discountsummultiplier,
                                                                   p_discountsumname          => v_discount_data.UOM,
                                                                   p_periodmaximummny         => null,
                                                                   p_prioritynum              => 2);
        
          dbms_output.put_line('v_event_discount_id is ' ||
                               v_event_discount_id);
        
          --Associate event discount to Tariff- Product---
        
          geneva_admin.gnvtariffelmntdisc.createtariffelmntdisc1nc(p_tariffid                 => g_billing_PP_id,
                                                                   p_productid                => g_product_id,
                                                                   p_eventdiscountid          => v_event_discount_id,
                                                                   p_startdat                 => g_sales_start_date,
                                                                   p_cataloguechangeid        => g_cat_change_id,
                                                                   p_productquantitythreshold => 1,
                                                                   p_enddat                   => g_sales_end_date);
        end if;
      
      end loop;
    end loop;
    dbms_output.put_line('createTiredDiscounts function ended ' ||
                         v_event_discount_id);
  
  end createTiredDiscounts;

  Procedure createtariffhasratingtariff(p_tariffid          number,
                                        p_ratingtariffid    number,
                                        p_cataloguechangeid number) as
    v_cnt number;
  begin
    select count(1)
      into v_cnt
      from geneva_admin.tariffhasratingtariff
     where tariff_id = p_tariffid
       and rating_tariff_id = p_ratingtariffid
       and catalogue_change_id = p_cataloguechangeid;
    if (v_cnt = 0) then
      geneva_admin.gnvtariffratingtariff.createtariffratingtariff1nc(p_tariffid          => p_tariffid,
                                                                     p_ratingtariffid    => p_ratingtariffid,
                                                                     p_cataloguechangeid => p_cataloguechangeid);
    
    end if;
  end createtariffhasratingtariff;

  function createCopyRatingTariff(p_copyfromratingtariffid number,
                                  p_tariffid               number,
                                  p_newtariffname          varchar,
                                  p_newtariffdesc          varchar)
    return number as
    v_rating_tariff_id number;
    subtype rating_tariff_type is geneva_admin.ratingtariff%rowtype;
    rating_tariff_details rating_tariff_type;
  begin
    dbms_output.put_line('createCopyRatingTariff function is started');
    /* if (g_use_sequence = 'F') then
      v_rating_tariff_id := getmaxId('GENEVA_ADMIN.RATINGTARIFF',
                                     'RATING_TARIFF_ID',
                                     null,
                                     g_rating_cat_change_id);
    end if; */
    geneva_admin.gnvratingtariff.copyratingtariff2nc(p_copyfromratingtariffid => p_copyfromratingtariffid,
                                                     p_ratingcatalogueid      => g_rating_cat_change_id,
                                                     p_copytoratingtariffid   => v_rating_tariff_id);
  
    select *
      into rating_tariff_details
      from geneva_admin.ratingtariff
     where rating_catalogue_id = g_rating_cat_change_id
       and rating_tariff_id = v_rating_tariff_id;
  
    geneva_admin.gnvratingtariff.modifyratingtariff3nc(p_ratingtariffid             => v_rating_tariff_id,
                                                       p_ratingcatalogueid          => g_rating_cat_change_id,
                                                       p_ratingtarifftypeid         => rating_tariff_details.rating_tariff_type_id,
                                                       p_priorratingtariffid        => rating_tariff_details.prior_rating_tariff_id,
                                                       p_nextratingtariffid         => rating_tariff_details.next_rating_tariff_id,
                                                       p_importedratingtarifftypeid => rating_tariff_details.imported_tariff_type_id,
                                                       p_oldtariffname              => rating_tariff_details.tariff_name,
                                                       p_oldtariffdesc              => rating_tariff_details.tariff_desc,
                                                       p_oldsalesstartdat           => rating_tariff_details.sales_start_dat,
                                                       p_oldsalesenddat             => rating_tariff_details.sales_end_dat,
                                                       p_oldbandingmodelid          => rating_tariff_details.banding_model_id,
                                                       p_olddefaultcostbandid       => rating_tariff_details.default_cost_band_id,
                                                       p_oldmodifiergroupid         => rating_tariff_details.modifier_group_id,
                                                       p_olddefaulteventclassid     => rating_tariff_details.default_event_class_id,
                                                       p_oldintratingtariffid       => rating_tariff_details.internal_rating_tariff_id,
                                                       p_oldextratingtariffid       => rating_tariff_details.external_rating_tariff_id,
                                                       p_oldsuppratingtariffid      => rating_tariff_details.supplementary_rating_tariff_id,
                                                       p_oldtaxinclusiveboo         => rating_tariff_details.tax_inclusive_boo,
                                                       p_oldplugintariffboo         => rating_tariff_details.plugin_tariff_boo,
                                                       p_oldautomaticboo            => rating_tariff_details.automatic_boo,
                                                       p_oldpartialtariffboo        => rating_tariff_details.partial_rating_tariff_boo,
                                                       p_oldpredicateid             => rating_tariff_details.predicate_id,
                                                       p_newtariffname              => p_newtariffname,
                                                       p_newtariffdesc              => p_newtariffdesc,
                                                       p_newsalesstartdat           => g_sales_start_date,
                                                       p_newsalesenddat             => g_sales_end_date,
                                                       p_newbandingmodelid          => rating_tariff_details.banding_model_id,
                                                       p_newdefaultcostbandid       => rating_tariff_details.default_cost_band_id,
                                                       p_newmodifiergroupid         => rating_tariff_details.modifier_group_id,
                                                       p_newdefaulteventclassid     => rating_tariff_details.default_event_class_id,
                                                       p_newintratingtariffid       => rating_tariff_details.internal_rating_tariff_id,
                                                       p_newextratingtariffid       => rating_tariff_details.external_rating_tariff_id,
                                                       p_newsuppratingtariffid      => rating_tariff_details.supplementary_rating_tariff_id,
                                                       p_newtaxinclusiveboo         => rating_tariff_details.tax_inclusive_boo,
                                                       p_newplugintariffboo         => rating_tariff_details.plugin_tariff_boo,
                                                       p_newautomaticboo            => rating_tariff_details.automatic_boo,
                                                       p_newpartialtariffboo        => rating_tariff_details.partial_rating_tariff_boo,
                                                       p_newpredicateid             => rating_tariff_details.predicate_id);
  
    createtariffhasratingtariff(p_tariffid,
                                v_rating_tariff_id,
                                g_cat_change_id);
    dbms_output.put_line('createCopyRatingTariff function ended ' ||
                         v_rating_tariff_id);
    return v_rating_tariff_id;
  end createCopyRatingTariff;

  Procedure modifyRatingElement(p_ratingtariffid   number,
                                p_event_type_name  varchar,
                                p_event_class_name varchar,
                                p_action           varchar,
                                p_charge           number) as
    type rating_element_list_type is table of geneva_admin.ratingelement%rowtype index by pls_integer;
    rating_element_list rating_element_list_type;
    v_fixed_charge_mny  number;
    v_charged_mny       number;
  begin
    dbms_output.put_line('modifyRatingElement procedure started');
    select re.*
      bulk collect
      into rating_element_list
      from geneva_admin.ratingtariff  rt,
           geneva_admin.ratingelement re,
           geneva_admin.eventclass    ec
     where rt.rating_tariff_id = p_ratingtariffid
       and rt.rating_catalogue_id = g_rating_cat_change_id
       and re.rating_tariff_id = rt.rating_tariff_id
       and re.rating_catalogue_id = rt.rating_catalogue_id
       and re.end_dat is null
       and ec.rating_catalogue_id = re.rating_catalogue_id
       and ec.event_class_id = re.event_class_id
       and ec.rating_tariff_type_id = rt.rating_tariff_type_id
       and ec.event_class_name like p_event_class_name || '%';
  
    if (p_action = 'Delete') then
      for rec in 1 .. rating_element_list.count loop
        --delete rating element---
        geneva_admin.gnvratingelement.deleteratingelement5nc(p_ratingtariffid    => rating_element_list(rec)
                                                                                    .rating_tariff_id,
                                                             p_costbandid        => rating_element_list(rec)
                                                                                    .cost_band_id,
                                                             p_eventclassid      => rating_element_list(rec)
                                                                                    .event_class_id,
                                                             p_onnetboo          => rating_element_list(rec)
                                                                                    .on_net_boo,
                                                             p_timerateid        => rating_element_list(rec)
                                                                                    .time_rate_id,
                                                             p_chargesegmentid   => rating_element_list(rec)
                                                                                    .charge_segment_id,
                                                             p_startdat          => rating_element_list(rec)
                                                                                    .start_dat,
                                                             p_ratingcatalogueid => g_rating_cat_change_id,
                                                             p_enddat            => rating_element_list(rec)
                                                                                    .end_dat,
                                                             p_fixedchargemny    => rating_element_list(rec)
                                                                                    .fixed_charge_mny,
                                                             p_chargingrate      => rating_element_list(rec)
                                                                                    .charging_rate,
                                                             p_mincostmny        => rating_element_list(rec)
                                                                                    .min_cost_mny,
                                                             p_maxcostmny        => rating_element_list(rec)
                                                                                    .max_cost_mny,
                                                             p_fixedpoints       => rating_element_list(rec)
                                                                                    .fixed_points,
                                                             p_pointrate         => rating_element_list(rec)
                                                                                    .point_rate,
                                                             p_unitduration      => rating_element_list(rec)
                                                                                    .unit_duration,
                                                             p_revenuecodeid     => rating_element_list(rec)
                                                                                    .revenue_code_id,
                                                             p_ustcodeid         => rating_element_list(rec)
                                                                                    .ust_code_id,
                                                             p_ustcategoryid     => rating_element_list(rec)
                                                                                    .ust_category_id,
                                                             p_taxoverrideid     => rating_element_list(rec)
                                                                                    .tax_override_id,
                                                             p_unitname          => rating_element_list(rec)
                                                                                    .unit_name,
                                                             p_dropeventboo      => rating_element_list(rec)
                                                                                    .drop_event_boo);
      end loop;
    end if;
    if (p_action = 'Modify') then
      if (p_event_type_name = 'Voice' or p_event_type_name = 'GPRS') then
        v_charged_mny := p_charge;
      else
        v_fixed_charge_mny := p_charge;
      end if;
      for rec in 1 .. rating_element_list.count loop
        geneva_admin.gnvratingelement.modifyratingelement5nc(p_ratingtariffid    => p_ratingtariffid,
                                                             p_costbandid        => rating_element_list(rec)
                                                                                    .cost_band_id,
                                                             p_eventclassid      => rating_element_list(rec)
                                                                                    .event_class_id,
                                                             p_onnetboo          => rating_element_list(rec)
                                                                                    .on_net_boo,
                                                             p_timerateid        => rating_element_list(rec)
                                                                                    .time_rate_id,
                                                             p_chargesegmentid   => rating_element_list(rec)
                                                                                    .charge_segment_id,
                                                             p_ratingcatalogueid => g_rating_cat_change_id,
                                                             p_oldstartdat       => rating_element_list(rec)
                                                                                    .start_dat,
                                                             p_oldenddat         => rating_element_list(rec)
                                                                                    .end_dat,
                                                             p_oldfixedchargemny => rating_element_list(rec)
                                                                                    .fixed_charge_mny,
                                                             p_oldchargingrate   => rating_element_list(rec)
                                                                                    .charging_rate,
                                                             p_oldmincostmny     => rating_element_list(rec)
                                                                                    .min_cost_mny,
                                                             p_oldmaxcostmny     => rating_element_list(rec)
                                                                                    .max_cost_mny,
                                                             p_oldfixedpoints    => rating_element_list(rec)
                                                                                    .fixed_points,
                                                             p_oldpointrate      => rating_element_list(rec)
                                                                                    .point_rate,
                                                             p_oldunitduration   => rating_element_list(rec)
                                                                                    .unit_duration,
                                                             p_oldrevenuecodeid  => rating_element_list(rec)
                                                                                    .revenue_code_id,
                                                             p_oldustcodeid      => rating_element_list(rec)
                                                                                    .ust_code_id,
                                                             p_oldustcategoryid  => rating_element_list(rec)
                                                                                    .ust_category_id,
                                                             p_oldtaxoverrideid  => rating_element_list(rec)
                                                                                    .tax_override_id,
                                                             p_oldunitname       => rating_element_list(rec)
                                                                                    .unit_name,
                                                             p_olddropeventboo   => rating_element_list(rec)
                                                                                    .drop_event_boo,
                                                             p_newstartdat       => g_sales_start_date,
                                                             p_newenddat         => g_sales_end_date,
                                                             p_newfixedchargemny => v_fixed_charge_mny,
                                                             p_newchargingrate   => v_charged_mny,
                                                             p_newmincostmny     => rating_element_list(rec)
                                                                                    .min_cost_mny,
                                                             p_newmaxcostmny     => rating_element_list(rec)
                                                                                    .max_cost_mny,
                                                             p_newfixedpoints    => 5,
                                                             p_newpointrate      => rating_element_list(rec)
                                                                                    .point_rate,
                                                             p_newunitduration   => rating_element_list(rec)
                                                                                    .unit_duration,
                                                             p_newrevenuecodeid  => rating_element_list(rec)
                                                                                    .revenue_code_id,
                                                             p_newustcodeid      => rating_element_list(rec)
                                                                                    .ust_code_id,
                                                             p_newustcategoryid  => rating_element_list(rec)
                                                                                    .ust_category_id,
                                                             p_newtaxoverrideid  => rating_element_list(rec)
                                                                                    .tax_override_id,
                                                             p_newunitname       => rating_element_list(rec)
                                                                                    .unit_name,
                                                             p_newdropeventboo   => rating_element_list(rec)
                                                                                    .drop_event_boo);
      end loop;
    end if;
  end modifyRatingElement;

  Procedure modifyTariffBasis(p_ratingtariffid     number,
                              p_event_class_name   varchar,
                              p_scaleroundingtype  varchar,
                              p_scaleunitsize      number,
                              p_scaleroundingvalue varchar,
                              p_costroundingtype   varchar) as
    subtype costing_rules_type is geneva_admin.costingrules%rowtype;
    type tariff_basis_type is table of geneva_admin.tariffbasis%rowtype;
    tariff_basis_details      tariff_basis_type;
    costing_rules_details     costing_rules_type;
    costing_rules_ref_details costing_rules_type;
    v_unit_value              number;
    type v_rounding_type_list_type is table of varchar2(20) index by pls_integer;
    v_rounding_type_list v_rounding_type_list_type;
    v_scaler_rounding_id number;
    v_cost_rounding_id   number;
    v_costingrulesname   varchar2(60);
    v_costingrulesid     number;
  begin
    dbms_output.put_line('modifyTariffBasis procedure is started');
    v_rounding_type_list(1) := 'RoundDown';
    v_rounding_type_list(2) := 'Nearest';
    v_rounding_type_list(3) := 'RoundUp';
  
    select distinct cr.*
      into costing_rules_details
      from geneva_admin.costingrules cr
     where cr.rating_catalogue_id = g_rating_cat_change_id
       and exists
     (select 1
              from geneva_admin.ratingtariff rt,
                   geneva_admin.tariffbasis  tb,
                   geneva_admin.eventclass   ec
             where rt.rating_tariff_id = p_ratingtariffid
               and rt.rating_catalogue_id = g_rating_cat_change_id
               and tb.rating_tariff_id = rt.rating_tariff_id
               and tb.rating_catalogue_id = rt.rating_catalogue_id
               and tb.end_dat is null
               and ec.event_class_id = tb.event_class_id
               and ec.rating_catalogue_id = tb.rating_catalogue_id
               and ec.rating_tariff_type_id = rt.rating_tariff_type_id
               and ec.event_class_name like p_event_class_name || '%'
               and cr.costing_rules_id = tb.costing_rules_id
               and cr.rating_catalogue_id = tb.rating_catalogue_id
               and cr.rating_tariff_type_id = rt.rating_tariff_type_id
               and cr.end_dat is null);
  
    if (p_scaleroundingtype is null) then
      v_scaler_rounding_id := -1;
    else
      for x in 1 .. v_rounding_type_list.count loop
        if (v_rounding_type_list(x) = p_scaleroundingtype) then
          v_scaler_rounding_id := x - 1;
          exit;
        end if;
      end loop;
    end if;
    for x in 1 .. v_rounding_type_list.count loop
      if (v_rounding_type_list(x) = p_costroundingtype) then
        v_cost_rounding_id := x - 1;
        exit;
      end if;
    end loop;
    if (v_scaler_rounding_id is null or v_cost_rounding_id is null) then
      raise_application_error('-20000',
                              ERR_027 || ' ' || p_scaleroundingtype || ' ' ||
                              p_costroundingtype);
    end if;
  
    if (v_scaler_rounding_id != -1) then
      if (p_scaleroundingvalue = 'KB') then
        v_unit_value := 1024;
      elsif (p_scaleroundingvalue = 'MB') then
        v_unit_value := 1024 * 1024;
      elsif (p_scaleroundingvalue = 'GB') then
        v_unit_value := 1024 * 1024 * 1024;
      else
        raise_application_error('-20000', ERR_026);
      end if;
      v_unit_value := v_unit_value * p_scaleunitsize;
    end if;
    if (v_scaler_rounding_id = -1) then
      v_scaler_rounding_id := null;
    end if;
    if (instr(costing_rules_details.costing_rules_name,
              nvl(p_scaleroundingvalue, 'None')) <= 0 or
       v_unit_value != costing_rules_details.scale_unit_size or
       v_scaler_rounding_id != costing_rules_details.scale_rounding_type or
       v_cost_rounding_id != costing_rules_details.cost_rounding_type) then
    
      begin
        select max(cr.costing_rules_id)
          into v_costingrulesid
          from geneva_admin.costingrules cr
         where cr.rating_catalogue_id = g_rating_cat_change_id
           and cr.rating_tariff_type_id =
               costing_rules_details.rating_tariff_type_id
           and cr.scale_rounding_type = v_scaler_rounding_id
           and cr.cost_rounding_type = v_cost_rounding_id
           and cr.scale_unit_size = v_unit_value
           and instr(cr.costing_rules_name,
                     nvl(p_scaleroundingvalue, 'None')) > 0
           and cr.end_dat is null
         group by cr.start_dat,
                  cr.rating_catalogue_id,
                  cr.end_dat,
                  cr.costing_rules_name,
                  cr.costing_rules_desc,
                  cr.event_process_type,
                  cr.scale_unit_size,
                  cr.scale_rounding_type,
                  cr.cost_unit_size,
                  cr.cost_rounding_type,
                  cr.rating_tariff_type_id,
                  cr.auth_retry_count,
                  cr.minimum_scalar;
      exception
        when no_data_found then
          dbms_output.put_line('not found cistingruleid');
          v_costingrulesname := 'Scalar' || ' ' ||
                                nvl(p_scaleroundingtype, 'None') || ' ' ||
                                p_scaleroundingvalue || '-Cost' ||
                                p_costroundingtype;
          v_costingrulesname := replace(v_costingrulesname, 'Round', 'Rnd ');
          if (length(v_costingrulesname) > 40) then
            raise_application_error('-20000',
                                    ERR_028 || p_scaleroundingtype || ' ' ||
                                    p_costroundingtype);
          end if;
          geneva_admin.gnvcostingrules.createcostingrules3nc(p_costingrulesid     => v_costingrulesid,
                                                             p_startdat           => g_sales_start_date,
                                                             p_ratingcatalogueid  => g_rating_cat_change_id,
                                                             p_enddat             => g_sales_end_date,
                                                             p_costingrulesname   => v_costingrulesname,
                                                             p_costingrulesdesc   => v_costingrulesname,
                                                             p_eventprocesstype   => 1,
                                                             p_scaleunitsize      => v_unit_value,
                                                             p_scaleroundingtype  => v_scaler_rounding_id,
                                                             p_costunitsize       => 1,
                                                             p_costroundingtype   => v_cost_rounding_id,
                                                             p_ratingtarifftypeid => costing_rules_details.rating_tariff_type_id,
                                                             p_authretrycount     => 0,
                                                             p_minimumscalar      => null);
          dbms_output.put_line('v_costingrulesid is ' || v_costingrulesid);
      end;
      select tb.*
        bulk collect
        into tariff_basis_details
        from geneva_admin.ratingtariff rt,
             geneva_admin.tariffbasis  tb,
             geneva_admin.eventclass   ec
       where rt.rating_tariff_id = p_ratingtariffid
         and rt.rating_catalogue_id = g_rating_cat_change_id
         and tb.rating_tariff_id = rt.rating_tariff_id
         and tb.rating_catalogue_id = rt.rating_catalogue_id
         and tb.end_dat is null
         and ec.event_class_id = tb.event_class_id
         and ec.rating_tariff_type_id = rt.rating_tariff_type_id
         and ec.rating_catalogue_id = tb.rating_catalogue_id
         and ec.event_class_name like p_event_class_name || '%';
    
      for x in 1 .. tariff_basis_details.count loop
        geneva_admin.gnvtariffbasis.modifytariffbasis1nc(p_ratingtariffid     => p_ratingtariffid,
                                                         p_costbandid         => tariff_basis_details(x)
                                                                                 .COST_BAND_ID,
                                                         p_eventclassid       => tariff_basis_details(x)
                                                                                 .EVENT_CLASS_ID,
                                                         p_onnetboo           => tariff_basis_details(x)
                                                                                 .ON_NET_BOO,
                                                         p_startdat           => tariff_basis_details(x)
                                                                                 .START_DAT,
                                                         p_ratingcatalogueid  => tariff_basis_details(x)
                                                                                 .RATING_CATALOGUE_ID,
                                                         p_oldenddat          => tariff_basis_details(x)
                                                                                 .END_DAT,
                                                         p_oldtimeratediaryid => tariff_basis_details(x)
                                                                                 .TIME_RATE_DIARY_ID,
                                                         p_oldstepgroupid     => tariff_basis_details(x)
                                                                                 .STEP_GROUP_ID,
                                                         p_oldcostingrulesid  => tariff_basis_details(x)
                                                                                 .COSTING_RULES_ID,
                                                         p_newenddat          => g_sales_end_date,
                                                         p_newtimeratediaryid => tariff_basis_details(x)
                                                                                 .TIME_RATE_DIARY_ID,
                                                         p_newstepgroupid     => tariff_basis_details(x)
                                                                                 .STEP_GROUP_ID,
                                                         p_newcostingrulesid  => v_costingrulesid);
      end loop;
    end if;
    dbms_output.put_line('modifyTariffBasis procedure is ended');
  end modifyTariffBasis;

  Procedure createRatePlan(p_rating_tariff_list  rating_tariff_list_type,
                           p_tariffid            number,
                           p_tariffname          varchar,
                           p_discount_list       discount_list_type,
                           rate_plan_output_list out rate_plan_output_list_type)
  
   as
    type event_type_name_type is table of varchar2(10) index by pls_integer;
    v_event_type_name_list event_type_name_type;
    type event_class_type is table of varchar2(40) index by pls_integer;
    v_event_class_list        event_class_type;
    v_rt_event_name_details   rating_tariff_row_type;
    v_rt_event_class_details  rt_details_row_type;
    v_voice_rt_id             number;
    v_GPRS_rt_id              number;
    v_SMS_rt_id               number;
    v_MMS_rt_id               number;
    v_rating_tariff_id        number;
    v_existsboo               boolean;
    v_copy_rating_tariff_id   number;
    v_event_Class             varchar2(100);
    v_event_type_id           number;
    v_rate_plan_output        rate_plan_output_row_type;
    v_charge                  number;
    v_standard_ovg            boolean;
    v_roaming_ovg             boolean;
    v_standard_charge         number;
    v_roaming_charge          number;
    v_std_scale_unit_size     varchar2(40);
    v_roaming_scale_unit_size varchar2(40);
    v_tier_existsboo          boolean;
    v_std_threshold           number;
    v_roam_threshold          number;
  begin
    dbms_output.put_line('createRatePlan procedure is started');
    v_event_type_name_list(1) := 'Voice';
    v_event_type_name_list(2) := 'GPRS';
    v_event_type_name_list(3) := 'SMS';
    v_event_type_name_list(4) := 'Intl Voice';
    v_event_type_name_list(5) := 'Intl SMS';
    v_event_type_name_list(6) := 'Intl GPRS';
  
    if (g_acct_type = 'MVNO') then
      v_event_type_name_list(7) := 'MMS';
    end if;
  
    v_event_class_list(1) := 'Standard';
    v_event_class_list(2) := 'Roaming';
  
    for a in 1 .. v_event_type_name_list.count loop
      v_standard_ovg   := false;
      v_roaming_ovg    := false;
      v_tier_existsboo := false;
      v_std_threshold  := null;
      v_roam_threshold := null;
      select RATING_TARIFF_ID
        into v_copy_rating_tariff_id
        from TMOBILE_CUSTOM.TMO_POB_RATE_PLAN_MAPPING
       where event_type_name = v_event_type_name_list(a);
      v_rating_tariff_id      := createCopyRatingTariff(v_copy_rating_tariff_id,
                                                        p_tariffid,
                                                        derivedNameFromTariff(p_tariffname,
                                                                              v_event_type_name_list(a) ||
                                                                              ' Rts'),
                                                        '9d - ' ||
                                                        p_tariffname || ' ' ||
                                                        v_event_type_name_list(a) ||
                                                        ' Rates');
      v_copy_rating_tariff_id := null;
      dbms_output.put_line('v_event_type_name_list(a) and v_rating_tariff_id ' ||
                           v_event_type_name_list(a) || v_rating_tariff_id);
      if (v_event_type_name_list(a) = 'Voice' or
         v_event_type_name_list(a) = 'GPRS' or
         v_event_type_name_list(a) = 'SMS' or
         v_event_type_name_list(a) = 'MMS') then
        dbms_output.put_line('discount list is ' || p_discount_list.count);
        for i in 1 .. p_discount_list.count loop
          if (p_discount_list(i).event_type_name = v_event_type_name_list(a)) then
            v_tier_existsboo := true;
          end if;
        end loop;
        for b in 1 .. v_event_class_list.count loop
          v_existsboo   := false;
          v_event_Class := v_event_class_list(b);
          dbms_output.put_line('v_event_Class ' || v_event_Class);
          <<event_class_name_label>>
          for c in 1 .. p_rating_tariff_list.count loop
            v_rt_event_name_details := p_rating_tariff_list(c);
            for d in 1 .. v_rt_event_name_details.rt_details.count loop
              v_rt_event_class_details := v_rt_event_name_details.rt_details(d);
              if (v_event_type_name_list(a) =
                 v_rt_event_name_details.event_type_name and
                 v_event_Class = v_rt_event_class_details.event_class and
                 v_rt_event_class_details.charge is not null) then
                v_existsboo := true;
                --dbms_output.put_line('v_existsboo is'||v_existsboo);
              end if;
              exit event_class_name_label when v_existsboo;
            end loop;
          end loop;
          if (v_existsboo) then
            dbms_output.put_line('true ' || v_event_type_name_list(a) ||
                                 v_event_Class);
            if (v_tier_existsboo and v_rt_event_class_details.charge != 0) then
              raise_application_error('-20000', ERR_029);
            end if;
            if (v_event_type_name_list(a) = 'Voice' or
               v_event_type_name_list(a) = 'GPRS') then
              v_charge := v_rt_event_class_details.charge * power(10, 11);
            else
              v_charge := v_rt_event_class_details.charge * power(10, 9);
            end if;
            if (v_rt_event_class_details.MRC_aggregation_type =
               'SubscriberLevel') then
              dbms_output.put_line('v_charge is ' || v_charge);
              modifyRatingElement(v_rating_tariff_id,
                                  v_event_type_name_list(a),
                                  v_event_Class,
                                  'Modify',
                                  v_charge);
              if (v_event_type_name_list(a) = 'GPRS') then
                modifyTariffBasis(v_rating_tariff_id,
                                  v_event_Class,
                                  v_rt_event_class_details.scale_rounding_type,
                                  v_rt_event_class_details.scale_rounding_value,
                                  v_rt_event_class_details.scale_unit_size,
                                  v_rt_event_class_details.cost_rounding_type);
                null;
              
              end if;
            elsif (v_rt_event_class_details.MRC_aggregation_type =
                  'DailyAverageSubCount') then
              dbms_output.put_line('endterd into dailyaveragesubcount');
              if (v_event_Class = 'Standard') then
                v_standard_ovg        := true;
                v_standard_charge     := v_charge / power(10, 5);
                v_std_scale_unit_size := v_rt_event_class_details.overage_unit;
                v_std_threshold       := v_rt_event_class_details.
                                         MRC_included;
              else
                v_roaming_ovg             := true;
                v_roaming_charge          := v_charge / power(10, 5);
                v_roaming_scale_unit_size := v_rt_event_class_details.overage_unit;
                v_roam_threshold          := v_rt_event_class_details.
                                             MRC_included;
              end if;
            else
              raise_application_error('-20000', ERR_025);
            end if;
          else
            dbms_output.put_line('delete ' || v_event_type_name_list(a) ||
                                 v_event_Class);
            if (v_tier_existsboo) then
              modifyRatingElement(v_rating_tariff_id,
                                  v_event_type_name_list(a),
                                  v_event_Class,
                                  'Modify',
                                  0);
            else
              modifyRatingElement(v_rating_tariff_id,
                                  v_event_type_name_list(a),
                                  v_event_Class,
                                  'Delete',
                                  null);
            end if;
          end if;
        end loop;
      end if;
      if (v_standard_ovg and v_roaming_ovg and
         v_std_scale_unit_size != v_roaming_scale_unit_size) then
        raise_application_error(-20000, ERR_042);
      end if;
      if (v_standard_ovg and v_roaming_ovg and
         v_roam_threshold != v_std_threshold) then
        raise_application_error(-20000, ERR_041);
      end if;
    
      if (v_standard_ovg and v_roaming_ovg) then
        dbms_output.put_line('have both std and roam ' ||
                             v_std_scale_unit_size ||
                             v_roaming_scale_unit_size);
        createOvgRatingTariff(v_event_type_name_list(a),
                              p_tariffname,
                              p_tariffid,
                              v_std_threshold,
                              v_std_scale_unit_size,
                              v_standard_ovg,
                              v_standard_charge,
                              v_roaming_ovg,
                              v_roaming_charge);
      elsif (v_standard_ovg) then
        dbms_output.put_line('endterd into standard');
        createOvgRatingTariff(v_event_type_name_list(a),
                              p_tariffname,
                              p_tariffid,
                              v_std_threshold,
                              v_std_scale_unit_size,
                              v_standard_ovg,
                              v_standard_charge,
                              null,
                              null);
      elsif (v_roaming_ovg) then
        createOvgRatingTariff(v_event_type_name_list(a),
                              p_tariffname,
                              p_tariffid,
                              v_roam_threshold,
                              v_roaming_scale_unit_size,
                              null,
                              null,
                              v_roaming_ovg,
                              v_roaming_charge);
      
      end if;
      select rt.rating_tariff_id, rt.tariff_name, teb.event_type_id
        into v_rate_plan_output
        from geneva_admin.ratingtariff rt, geneva_admin.tariffeventbind teb
       where rt.rating_tariff_id = v_rating_tariff_id
         and rt.rating_catalogue_id = g_rating_cat_change_id
         and teb.rating_tariff_type_id = rt.rating_tariff_type_id
         and teb.rating_catalogue_id = rt.rating_catalogue_id;
      rate_plan_output_list(rate_plan_output_list.count + 1) := v_rate_plan_output;
    end loop;
    dbms_output.put_line('createRatePlan procedure is ended');
  end createRatePlan;

  Procedure createTariffElmntAttrDtls(p_productid            number,
                                      p_tariffid             number,
                                      p_productpriceattrid   number,
                                      p_oneoffattrvalue      varchar,
                                      p_recurringattrvalue   varchar,
                                      p_terminationattrvalue varchar,
                                      p_suspattrvalue        varchar) as
  begin
    --Associate PPA's to Tariff - Product---
    geneva_admin.gnvtariffelementattrdetails.createtariffelmntattrdtls1nc(p_productid                => p_productid,
                                                                          p_tariffid                 => p_tariffid,
                                                                          p_cataloguechangeid        => g_cat_change_id,
                                                                          p_productquantitythreshold => 1,
                                                                          p_productpriceattrid       => p_productpriceattrid,
                                                                          p_startdat                 => g_sales_start_date,
                                                                          p_enddat                   => g_sales_end_date,
                                                                          p_oneoffattrvalue          => p_oneoffattrvalue,
                                                                          p_recurringattrvalue       => p_recurringattrvalue,
                                                                          p_terminationattrvalue     => p_terminationattrvalue,
                                                                          p_suspattrvalue            => p_suspattrvalue,
                                                                          p_susprecurattrvalue       => null,
                                                                          p_reactattrvalue           => null,
                                                                          p_earlytermattrvalue       => null);
  
  end createTariffElmntAttrDtls;

  function createTariffDetails(p_tariffname            varchar,
                               p_tariffdesc            varchar,
                               p_parenttariffid        number,
                               p_productfamilyid       number,
                               p_productPricesBoo      boolean,
                               p_productid             number,
                               p_rating_price_plan_boo boolean,
                               p_MRC_charge            number,
                               p_tax_cat_code          varchar,
                               p_category              varchar) return number as
    v_tariffid    number;
    v_PPA_id      number;
    v_MRC_charge  varchar2(20);
    v_prd_charges number;
	v_tax_cat_code varchar2(100);
  begin
    dbms_output.put_line('createTariffDetails procedure is started' ||
                         v_tariffid);
    v_MRC_charge := to_char(p_MRC_charge * 1000000);
    /*  if (g_use_sequence = 'F') then
      v_tariffid := getmaxId('GENEVA_ADMIN.TARIFF',
                             'TARIFF_ID',
                             g_cat_change_id,
                             null);
    end if; */
    --create new tariff---
    geneva_admin.gnvtariff.createtariff1nc(p_tariffid             => v_tariffid,
                                           p_cataloguechangeid    => g_cat_change_id,
                                           p_tariffname           => p_tariffname,
                                           p_parenttariffid       => p_parenttariffid,
                                           p_tariffdesc           => p_tariffdesc,
                                           p_productfamilyid      => p_productfamilyid,
                                           p_salesstartdat        => g_sales_start_date,
                                           p_salesenddat          => g_sales_end_date,
                                           p_tarifftypeid         => C_TARIFF_TYPE_ID,
                                           p_customerref          => null,
                                           p_internalcosttariffid => null,
                                           p_externalcosttariffid => null,
                                           p_contracttermsboo     => C_CONTRACT_TERMS_BOO,
                                           p_contractterm         => null,
                                           p_contracttermunits    => null,
                                           p_taxinclusiveboo      => C_TAX_INCLUSIVE_BOO);
  
    dbms_output.put_line('v_tariffid value is ' || v_tariffid);
    if (p_productPricesBoo) then
      for rec in (select tb.product_id,
                         tb.tariff_id,
                         tb.start_dat,
                         tb.catalogue_change_id,
                         t.end_dat,
                         t.charge_period,
                         t.charge_period_units,
                         t.in_advance_boo,
                         t.pro_rate_boo,
                         t.refundable_boo,
                         t.bonus_scheme_id,
                         t.marginal_boo,
                         t.init_revenue_code_id,
                         t.recur_revenue_code_id,
                         t.term_revenue_code_id,
                         t.early_term_fix_rev_code_id,
                         t.early_term_mult_rev_code_id,
                         t.susp_rev_code_id,
                         t.susp_recur_rev_code_id,
                         t.react_rev_code_id,
                         t.track_changes_boo,
                         t.early_term_pro_rate_boo,
                         t.init_rec_class_id,
                         t.recur_rec_class_id,
                         t.term_rec_class_id,
                         t.non_use_rec_class_id,
                         t.age_dependent_price_id,
                         t.activation_rule,
                         t.suspension_rule,
                         t.reactivation_rule,
                         t.termination_rule,
                         t.init_rev_recog_class_id,
                         t.recur_rev_recog_class_id,
                         t.term_rev_recog_class_id,
                         t.non_use_rev_recog_class_id,
                         tb.one_off_number,
                         tb.one_off_mod_type_id,
                         tb.recurring_number,
                         tb.recurring_mod_type_id,
                         tb.termination_number,
                         tb.termination_mod_type_id,
                         tb.one_off_points,
                         tb.recurring_points,
                         tb.event_point_rate,
                         tb.early_term_fix_mny,
                         tb.early_term_mult_mny,
                         tb.susp_number,
                         tb.susp_mod_type_id,
                         tb.susp_recur_number,
                         tb.susp_recur_mod_type_id,
                         tb.react_number,
                         tb.react_mod_type_id,
                         t.default_prod_lifetime,
                         t.default_prod_lifetime_unit
                    from geneva_admin.tariffelement     t,
                         geneva_admin.tariffelementband tb
                   where t.catalogue_change_id = g_cat_change_id
                     and t.tariff_id = v_tariffid
                     and t.product_id = p_productid
                     and tb.catalogue_change_id = t.catalogue_change_id
                     and tb.tariff_id = t.tariff_id
                     and tb.product_id = t.product_id) loop
      
        geneva_admin.gnvproductprice.deleteproductprice5nc(p_productid                 => rec.product_id,
                                                           p_tariffid                  => rec.tariff_id,
                                                           p_startdat                  => rec.start_dat,
                                                           p_cataloguechangeid         => rec.catalogue_change_id,
                                                           p_enddat                    => rec.END_DAT,
                                                           p_chargeperiod              => rec.CHARGE_PERIOD,
                                                           p_chargeperiodunits         => rec.CHARGE_PERIOD_UNITS,
                                                           p_inadvanceboo              => rec.IN_ADVANCE_BOO,
                                                           p_prorateboo                => rec.PRO_RATE_BOO,
                                                           p_refundableboo             => rec.REFUNDABLE_BOO,
                                                           p_bonusschemeid             => rec.BONUS_SCHEME_ID,
                                                           p_marginalboo               => rec.MARGINAL_BOO,
                                                           p_initrevenuecodeid         => rec.INIT_REVENUE_CODE_ID,
                                                           p_periodicrevenuecodeid     => rec.RECUR_REVENUE_CODE_ID,
                                                           p_termrevenuecodeid         => rec.TERM_REVENUE_CODE_ID,
                                                           p_earlytermfixrevcodeid     => rec.EARLY_TERM_FIX_REV_CODE_ID,
                                                           p_earlytermmultrevcodeid    => rec.EARLY_TERM_MULT_REV_CODE_ID,
                                                           p_susprevcodeid             => rec.SUSP_REV_CODE_ID,
                                                           p_susprecurrevcodeid        => rec.susp_recur_rev_code_id,
                                                           p_reactrevcodeid            => rec.react_rev_code_id,
                                                           p_trackchangesboo           => rec.track_changes_boo,
                                                           p_earlytermprorateboo       => rec.early_term_pro_rate_boo,
                                                           p_initreceivableclassid     => rec.init_rec_class_id,
                                                           p_periodicreceivableclassid => rec.recur_rec_class_id,
                                                           p_termreceivableclassid     => rec.term_rec_class_id,
                                                           p_nonusereceivableclassid   => rec.non_use_rec_class_id,
                                                           p_agedependentpriceid       => rec.age_dependent_price_id,
                                                           p_activationrule            => rec.activation_rule,
                                                           p_suspensionrule            => rec.suspension_rule,
                                                           p_reactivationrule          => rec.reactivation_rule,
                                                           p_terminationrule           => rec.termination_rule,
                                                           p_initrevrecogclassid       => rec.init_rev_recog_class_id,
                                                           p_recurrevrecogclassid      => rec.recur_rev_recog_class_id,
                                                           p_termrevrecogclassid       => rec.term_rev_recog_class_id,
                                                           p_nonuserevrecogclassid     => rec.non_use_rev_recog_class_id,
                                                           p_initiationnumber          => rec.one_off_number,
                                                           p_initiationmodtypeid       => rec.one_off_mod_type_id,
                                                           p_periodicnumber            => rec.recurring_number,
                                                           p_periodicmodtypeid         => rec.recurring_mod_type_id,
                                                           p_terminationnumber         => rec.termination_number,
                                                           p_terminationmodtypeid      => rec.termination_mod_type_id,
                                                           p_initiationpoints          => rec.one_off_points,
                                                           p_periodicpoints            => rec.recurring_points,
                                                           p_eventpointrate            => rec.event_point_rate,
                                                           p_earlytermfixmny           => rec.early_term_fix_mny,
                                                           p_earlytermmultmny          => rec.early_term_mult_mny,
                                                           p_suspnumber                => rec.susp_number,
                                                           p_suspmodtypeid             => rec.susp_mod_type_id,
                                                           p_susprecurnumber           => rec.susp_recur_number,
                                                           p_susprecurmodtypeid        => rec.susp_recur_mod_type_id,
                                                           p_reactnumber               => rec.react_number,
                                                           p_reactmodtypeid            => rec.react_mod_type_id,
                                                           p_defaultprodlifetime       => rec.default_prod_lifetime,
                                                           p_defaultprodlifetimeunit   => rec.default_prod_lifetime_unit);
      end loop;
      if (g_acct_type = 'M2M') then
        v_prd_charges := C_M2M_GENESIS_PRODUCT_CHARGES;
      else
        v_prd_charges := C_MVNO_GENESIS_PRODUCT_CHARGES;
      end if;
      ---Configure tariff product prices----
      geneva_admin.gnvproductprice.createproductprice5nc(p_productid                 => p_productid,
                                                         p_tariffid                  => v_tariffid,
                                                         p_startdat                  => g_sales_start_date,
                                                         p_cataloguechangeid         => g_cat_change_id,
                                                         p_enddat                    => g_sales_end_date,
                                                         p_chargeperiod              => C_CHARGE_PERIOD,
                                                         p_chargeperiodunits         => C_CHARGE_PERIOD_UNITS,
                                                         p_inadvanceboo              => C_INADVANCE_BOO,
                                                         p_prorateboo                => C_PRORATE_BOO,
                                                         p_refundableboo             => C_REFUNDABLE_BOo,
                                                         p_bonusschemeid             => null,
                                                         p_marginalboo               => C_MARGINAL_BOO,
                                                         p_initrevenuecodeid         => v_prd_charges,
                                                         p_periodicrevenuecodeid     => v_prd_charges,
                                                         p_termrevenuecodeid         => v_prd_charges,
                                                         p_earlytermfixrevcodeid     => null,
                                                         p_earlytermmultrevcodeid    => null,
                                                         p_susprevcodeid             => C_UNDEFINED,
                                                         p_susprecurrevcodeid        => C_UNDEFINED,
                                                         p_reactrevcodeid            => C_UNDEFINED,
                                                         p_trackchangesboo           => C_TRACK_CHANGES_BOO,
                                                         p_earlytermprorateboo       => C_EARLY_TERMPRORATE_BOO,
                                                         p_initreceivableclassid     => null,
                                                         p_periodicreceivableclassid => null,
                                                         p_termreceivableclassid     => null,
                                                         p_nonusereceivableclassid   => null,
                                                         p_agedependentpriceid       => null,
                                                         p_activationrule            => C_AT_MIDNIGHT_ON_THAT_DAY,
                                                         p_suspensionrule            => C_AT_MIDNIGHT_ON_THE_FOLLW_DAY,
                                                         p_reactivationrule          => C_AT_MIDNIGHT_ON_THE_FOLLW_DAY,
                                                         p_terminationrule           => C_AT_MIDNIGHT_ON_THE_FOLLW_DAY,
                                                         p_initrevrecogclassid       => null,
                                                         p_recurrevrecogclassid      => null,
                                                         p_termrevrecogclassid       => null,
                                                         p_nonuserevrecogclassid     => null,
                                                         p_initiationnumber          => null,
                                                         p_initiationmodtypeid       => C_MODTYPE_NO_CHARGE,
                                                         p_periodicnumber            => null,
                                                         p_periodicmodtypeid         => C_MODTYPE_NO_CHARGE,
                                                         p_terminationnumber         => null,
                                                         p_terminationmodtypeid      => C_MODTYPE_NO_CHARGE,
                                                         p_initiationpoints          => null,
                                                         p_periodicpoints            => null,
                                                         p_eventpointrate            => null,
                                                         p_earlytermfixmny           => null,
                                                         p_earlytermmultmny          => null,
                                                         p_suspnumber                => null,
                                                         p_suspmodtypeid             => C_MODTYPE_NO_CHARGE,
                                                         p_susprecurnumber           => null,
                                                         p_susprecurmodtypeid        => C_MODTYPE_NO_CHARGE,
                                                         p_reactnumber               => null,
                                                         p_reactmodtypeid            => C_MODTYPE_NO_CHARGE,
                                                         p_defaultprodlifetime       => null,
                                                         p_defaultprodlifetimeunit   => null);
    
      --Configure marketsegment for tariff - product---
      if (g_mktsegment_id is null) then
        begin
          dbms_output.put_line('g_shortname ' || g_shortname);
          select market_segment_id
            into g_mktsegment_id
            from geneva_admin.marketsegment
           where market_segment_name = g_shortname;
        exception
          when NO_DATA_FOUND then
            raise_application_error(-20000,
                                    'Cannot find marketsegment with the given shortName' ||
                                    g_shortname);
        end;
      end if;
      createtariffelementmarketseg(p_productid,
                                   v_tariffid,
                                   g_mktsegment_id);
	if(p_tax_cat_code is not null) then
	/* SELECT trim(Substr(p_tax_cat_code, 1, Instr(p_tax_cat_code, ' - ') - 1)) 
	into v_tax_cat_code 
    FROM   dual; */
	select uc.ust_category_id||'|'||u.ust_code_id 
	into v_tax_cat_code
	from ustcategory uc, ustcode u, ustcategorycodevalid ucv
	where uc.ust_category_id = ucv.ust_category_id
	and u.ust_code_id = ucv.ust_code_id
	and uc.external_category_id || '|' || u.external_code_id || '  -  ' ||
	uc.external_category_name || '|' || u.external_code_name=p_tax_cat_code ;
	end if;
      if (p_rating_price_plan_boo) then
        --Associate to m2m demo marketsegment---
        /* createtariffelementmarketseg(p_productid,
        v_tariffid,
        C_M2MDEMO_MKTSEGMNT_ID); */
        createTariffElmntAttrDtls(p_productid,
                                  v_tariffid,
                                  C_STD_REC_PPA_ID,
                                  v_MRC_charge,
                                  p_category,
                                  v_tax_cat_code,
                                  null);
      elsif (p_MRC_charge is not null and p_tax_cat_code is not null) then
        createTariffElmntAttrDtls(p_productid,
                                  v_tariffid,
                                  C_SUSPEND_REC_PPA_ID,
                                  v_MRC_charge,
                                  p_category,
                                  v_tax_cat_code,
                                  null);
      
      end if;
    
    end if;
    dbms_output.put_line('createTariffDetails procedure is ended' ||
                         v_tariffid);
    return v_tariffid;
  exception
    when TOO_MANY_ROWS then
      raise_application_error('-20000',
                              'Found multiple marketsegment for same partnerName');
    when others then
      raise;
  end createTariffDetails;

  Procedure createPricePlan(p_price_plan_details  price_plan_row_type,
                            price_plan_output_row out price_plan_output_row_type) as
    v_dummy_PP_id           integer;
    v_rating_PP_id          integer;
    v_product_family_id     number;
    v_product_id            number;
    v_rate_plan_output_list rate_plan_output_list_type;
    v_sim_bank_tariff_id    number;
    v_mktsegment_id         number;
    v_cnt                   number;
  begin
    dbms_output.put_line('createPricePlan procedure is started');
    if (g_acct_type = 'MVNO') then
      v_product_family_id := C_MVNO_PRODUCT_FAMILY_ID;
      v_product_id        := C_MVNO_PRODUCT_ID;
    else
      v_product_family_id := C_M2M_PRODUCT_FAMILY_ID;
      v_product_id        := C_M2M_PRODUCT_ID;
    end if;
  
    --create rating account price plan---
    v_rating_PP_id := createTariffDetails(p_price_plan_details.price_plan_name,
                                          p_price_plan_details.price_plan_name,
                                          g_dummy_PP_id,
                                          v_product_family_id,
                                          true,
                                          v_product_id,
                                          true,
                                          p_price_plan_details.MRC_charge,
                                          p_price_plan_details.TaxCat_Code,
                                          p_price_plan_details.MRC_category);
    createRatePlan(p_price_plan_details.rating_tariff_list,
                   v_rating_PP_id,
                   p_price_plan_details.price_plan_name,
                   p_price_plan_details.discount_list,
                   v_rate_plan_output_list);
    if (p_price_plan_details.pricing_tier_boo and
       p_price_plan_details.discount_list.count != 0) then
    
      createTiredDiscounts(p_price_plan_details.discount_list,
                           p_price_plan_details.price_plan_name,
                           v_rating_PP_id);
    end if;
  
    for i in 1 .. p_price_plan_details.sim_bank_tlo_id.count loop
      v_sim_bank_tariff_id := null;
      begin
        /* select t.tariff_id
         into v_sim_bank_tariff_id
         From geneva_admin.tariff t, geneva_admin.tariffelement te
        where t.product_family_id in (51, 52)
          and t.catalogue_change_id = g_cat_change_id
          and t.sales_end_dat is null
          and t.tariff_desc in
              (select distinct replace(object_name, '-', ' ')
                 from tmobile_custom.toms_offernamemapping
                where object_id = p_price_plan_details.sim_bank_tlo_id(i))
          and te.catalogue_change_id = t.catalogue_change_id
          and te.tariff_id = t.tariff_id
          and te.end_dat is null
          and te.product_id = v_product_id; */
        select input_3_value
          into v_sim_bank_tariff_id
          from geneva_admin.eventmappingsetvalue
         where event_mapping_set_id = 13
           and input_1_value = p_price_plan_details.sim_bank_tlo_id(i)
           and input_6_value = v_product_id
           and end_dtm is null;
        dbms_output.put_line('v_sim_bank_tariff_id and g_mktsegment_id is ' ||
                             v_sim_bank_tariff_id || ' ' ||
                             g_mktsegment_id);
        createtariffelementmarketseg(v_product_id,
                                     v_sim_bank_tariff_id,
                                     g_mktsegment_id);
        dbms_output.put_line('g_mktsegment_id is asscoiated ' ||
                             g_mktsegment_id);
        for j in 1 .. p_price_plan_details.link_to_demo_partner_id_list.count loop
          begin
            select c.market_segment_id
              into v_mktsegment_id
              from tmobile_custom.tmo_acct_mapping acct,
                   geneva_admin.customer           c
             where c.customer_ref = acct.rating_cust_ref
               and acct.tibco_partner_id =
                   p_price_plan_details.link_to_demo_partner_id_list(j);
            createtariffelementmarketseg(v_product_id,
                                         v_rating_PP_id,
                                         v_mktsegment_id);
          
            createtariffelementmarketseg(v_product_id,
                                         v_sim_bank_tariff_id,
                                         v_mktsegment_id);
          
          exception
            when no_data_found then
              raise_application_error(-20000,
                                      ERR_038 ||
                                      p_price_plan_details.link_to_demo_partner_id_list(j));
          end;
        
        end loop;
      exception
        when no_data_found then
          raise_application_error(-20000,
                                  ERR_037 ||
                                  p_price_plan_details.sim_bank_tlo_id(i));
      end;
    
    end loop;
  
    price_plan_output_row.transaction_id        := p_price_plan_details.transaction_id;
    price_plan_output_row.price_plan_id         := v_rating_PP_id;
    price_plan_output_row.price_plan_name       := p_price_plan_details.price_plan_name;
    price_plan_output_row.product_id            := v_product_id;
    price_plan_output_row.WPS_valid_from        := g_sales_start_date;
    price_plan_output_row.WPS_end_date          := g_sales_end_date;
    price_plan_output_row.rate_plan_output_list := v_rate_plan_output_list;
  
    dbms_output.put_line('createPricePlan procedure is ended ' ||
                         v_rating_PP_id);
  end createPricePlan;

  Procedure createOrModifyRatingElement(p_rating_element_row rating_element_row_type,
                                        p_action             varchar,
                                        p_country_name       varchar,
                                        p_charging_rate      number,
                                        p_fixed_rate         number,
                                        p_cost_band_id       number,
                                        p_tariff_basis_ref   tariff_basis_row_type) as
    tariff_basis_row tariff_basis_row_type;
    v_charging_rate  number;
    v_fixed_rate     number;
  begin
    if (p_action = 'Modify') then
      geneva_admin.gnvratingelement.modifyratingelement5nc(p_ratingtariffid    => p_rating_element_row.rating_tariff_id,
                                                           p_costbandid        => p_rating_element_row
                                                                                 .cost_band_id,
                                                           p_eventclassid      => p_rating_element_row
                                                                                 .event_class_id,
                                                           p_onnetboo          => p_rating_element_row
                                                                                 .on_net_boo,
                                                           p_timerateid        => p_rating_element_row
                                                                                 .time_rate_id,
                                                           p_chargesegmentid   => p_rating_element_row
                                                                                 .charge_segment_id,
                                                           p_ratingcatalogueid => g_rating_cat_change_id,
                                                           p_oldstartdat       => p_rating_element_row
                                                                                 .start_dat,
                                                           p_oldenddat         => p_rating_element_row
                                                                                 .end_dat,
                                                           p_oldfixedchargemny => p_rating_element_row
                                                                                 .fixed_charge_mny,
                                                           p_oldchargingrate   => p_rating_element_row
                                                                                 .charging_rate,
                                                           p_oldmincostmny     => p_rating_element_row
                                                                                 .min_cost_mny,
                                                           p_oldmaxcostmny     => p_rating_element_row
                                                                                 .max_cost_mny,
                                                           p_oldfixedpoints    => p_rating_element_row
                                                                                 .fixed_points,
                                                           p_oldpointrate      => p_rating_element_row
                                                                                 .point_rate,
                                                           p_oldunitduration   => p_rating_element_row
                                                                                 .unit_duration,
                                                           p_oldrevenuecodeid  => p_rating_element_row
                                                                                 .revenue_code_id,
                                                           p_oldustcodeid      => p_rating_element_row
                                                                                 .ust_code_id,
                                                           p_oldustcategoryid  => p_rating_element_row
                                                                                 .ust_category_id,
                                                           p_oldtaxoverrideid  => p_rating_element_row
                                                                                 .tax_override_id,
                                                           p_oldunitname       => p_rating_element_row
                                                                                 .unit_name,
                                                           p_olddropeventboo   => p_rating_element_row
                                                                                 .drop_event_boo,
                                                           p_newstartdat       => g_sales_start_date,
                                                           p_newenddat         => g_sales_end_date,
                                                           p_newfixedchargemny => p_fixed_rate,
                                                           p_newchargingrate   => p_charging_rate,
                                                           p_newmincostmny     => p_rating_element_row
                                                                                 .min_cost_mny,
                                                           p_newmaxcostmny     => p_rating_element_row
                                                                                 .max_cost_mny,
                                                           p_newfixedpoints    => 5,
                                                           p_newpointrate      => p_rating_element_row
                                                                                 .point_rate,
                                                           p_newunitduration   => p_rating_element_row
                                                                                 .unit_duration,
                                                           p_newrevenuecodeid  => p_rating_element_row
                                                                                 .revenue_code_id,
                                                           p_newustcodeid      => p_rating_element_row
                                                                                 .ust_code_id,
                                                           p_newustcategoryid  => p_rating_element_row
                                                                                 .ust_category_id,
                                                           p_newtaxoverrideid  => p_rating_element_row
                                                                                 .tax_override_id,
                                                           p_newunitname       => p_rating_element_row
                                                                                 .unit_name,
                                                           p_newdropeventboo   => p_rating_element_row
                                                                                 .drop_event_boo);
    elsif (p_action = 'Add') then
    
      begin
        select tb.*
          into tariff_basis_row
          from geneva_admin.ratingtariff rt, geneva_admin.tariffbasis tb
         where rt.rating_tariff_id = p_rating_element_row.rating_tariff_id
           and rt.rating_catalogue_id = g_rating_cat_change_id
           and tb.rating_tariff_id = rt.rating_tariff_id
           and tb.rating_catalogue_id = rt.rating_catalogue_id
           and tb.end_dat is null
           and tb.cost_band_id = p_cost_band_id;
      exception
        when no_data_found then
          geneva_admin.gnvtariffbasis.createtariffbasis1nc(p_ratingtariffid    => p_tariff_basis_ref.rating_tariff_id,
                                                           p_costbandid        => p_cost_band_id,
                                                           p_eventclassid      => p_tariff_basis_ref.event_class_id,
                                                           p_onnetboo          => p_tariff_basis_ref.on_net_boo,
                                                           p_startdat          => g_sales_start_date,
                                                           p_ratingcatalogueid => g_rating_cat_change_id,
                                                           p_enddat            => g_sales_end_date,
                                                           p_timeratediaryid   => p_tariff_basis_ref.time_rate_diary_id,
                                                           p_stepgroupid       => p_tariff_basis_ref.step_group_id,
                                                           p_costingrulesid    => p_tariff_basis_ref.costing_rules_id);
      end;
      geneva_admin.gnvratingelement.createratingelement5nc(p_ratingtariffid    => p_rating_element_row.rating_tariff_id,
                                                           p_costbandid        => p_cost_band_id,
                                                           p_eventclassid      => p_rating_element_row
                                                                                 .event_class_id,
                                                           p_onnetboo          => p_rating_element_row
                                                                                 .on_net_boo,
                                                           p_timerateid        => p_rating_element_row
                                                                                 .time_rate_id,
                                                           p_chargesegmentid   => p_rating_element_row
                                                                                 .charge_segment_id,
                                                           p_startdat          => g_sales_start_date,
                                                           p_ratingcatalogueid => g_rating_cat_change_id,
                                                           p_enddat            => g_sales_end_date,
                                                           p_fixedchargemny    => p_fixed_rate,
                                                           p_chargingrate      => p_charging_rate,
                                                           p_mincostmny        => p_rating_element_row
                                                                                 .min_cost_mny,
                                                           p_maxcostmny        => p_rating_element_row
                                                                                 .max_cost_mny,
                                                           p_fixedpoints       => 5,
                                                           p_pointrate         => p_rating_element_row
                                                                                 .point_rate,
                                                           p_unitduration      => p_rating_element_row
                                                                                 .unit_duration,
                                                           p_revenuecodeid     => p_rating_element_row
                                                                                 .revenue_code_id,
                                                           p_ustcodeid         => p_rating_element_row
                                                                                 .ust_code_id,
                                                           p_ustcategoryid     => p_rating_element_row
                                                                                 .ust_category_id,
                                                           p_taxoverrideid     => p_rating_element_row
                                                                                 .tax_override_id,
                                                           p_unitname          => p_rating_element_row
                                                                                 .unit_name,
                                                           p_dropeventboo      => p_rating_element_row
                                                                                 .drop_event_boo);
    end if;
  end createOrModifyRatingElement;

  Procedure publishCatalogue as
    v_rtdchangesexist varchar2(100);
    sqlerrr           varchar2(2000);
  begin
    dbms_output.put_line('publishCatalogue started');
    geneva_admin.gnvrcp.promotetotestnocommit(catid => g_rating_cat_change_id);
    dbms_output.put_line('INFORM------------Rating catalogue id:' ||
                         g_rating_cat_change_id || ' Moved to Test mode');
    /*  begin
      geneva_admin.gnvrcp.validatecatalogue1nc(p_ratingcatalogueid    => g_rating_cat_change_id,
                                               p_clearlogboo          => 'T',
                                               p_partialvalidationboo => 'F');
    exception
      when others then
        sqlerrr := sqlerrm;
        dbms_output.put_line('WARNING-----------rating Catalogue has Valdation error##' ||
                             sqlerrr);
    end; */
    /* if sqlerrr like '%GAPI-66011%' or sqlerrr is null or
         sqlerrr like '%ORA-01403%' then
    
        if sqlerrr like '%GAPI-66011%' then
          dbms_output.put_line('WARNING-----------Proceeding to Publish rating catalogue by igonring Validation error');
        end if;
        if sqlerrr like '%GAPI-01403%' then
          dbms_output.put_line('WARNING-----------Proceeding to Publish rating catalogue by igonring No Data Found error');
        end if;
    end; */
  
    geneva_admin.gnvrcp.publishcatalogue1nc(ratecatid => g_rating_cat_change_id);
    dbms_output.put_line('INFORM------------Rating catalogue id:' ||
                         g_rating_cat_change_id || '  Published to Live');
    geneva_admin.gnvbcp.promotetotestnocommit(catid => g_cat_change_id);
    dbms_output.put_line('INFORM------------Billing catalogue id:' ||
                         g_cat_change_id || ' Moved to Test mode');
    /* begin
      geneva_admin.gnvbcp.validatecatalogue1nc(p_cataloguechangeid    => g_cat_change_id,
                                               p_clearlogboo          => 'T',
                                               p_partialvalidationboo => 'F');
    exception
      when others then
        sqlerrr := sqlerrm;
        dbms_output.put_line('WARNING-----------Billing Catalogue has Valdation error##' ||
                             sqlerrr);
    end; */
    /*  if sqlerrr like '%GAPI-66011%' or sqlerrr is null or
     sqlerrr like '%ORA-01403%' then
    
    if sqlerrr like '%GAPI-66011%' then
      dbms_output.put_line('WARNING-----------Proceeding to Publish Billing catalogue by igonring Validation error');
    end if;
    if sqlerrr like '%GAPI-01403%' then
      dbms_output.put_line('WARNING-----------Proceeding to Publish Billing catalogue by igonring No Data Found error');
    end if; */
  
    geneva_admin.gnvbcp.publishcatalogue1nc(p_cataloguechangeid       => g_cat_change_id,
                                            p_publishrelatedratcatboo => 'T',
                                            p_rtdchangesexist         => v_rtdchangesexist);
    dbms_output.put_line('publishCatalogue ended');
  
  end;

  procedure accountSetUp(p_rating_acct_num varchar) as
    v_billing_cust_ref   varchar2(40);
    v_billing_acct_num   varchar2(40);
    v_product_id         number;
    v_tariff_id          number;
    v_prod_seq           number;
    v_billing_event_src  varchar2(20);
    v_accurals_seq       number;
    v_accurals_cust_ref  varchar2(40) := 'CUST000050';
    v_accruals_event_src varchar2(40);
  begin
    dbms_output.put_line('accountSetUp procedure is started');
    begin
      select billing_cust_ref,
             billing_acct_nbr,
             billing_event_src,
             accruals_event_src
        into v_billing_cust_ref,
             v_billing_acct_num,
             v_billing_event_src,
             v_accruals_event_src
        from tmobile_custom.tmo_acct_mapping
       where rating_acct_nbr = p_rating_acct_num;
    exception
      when no_data_found then
        raise_application_error('-20000', ERR_036);
    end;
    begin
      select te.product_id, t.tariff_id
        into v_product_id, v_tariff_id
        from geneva_admin.customer      c,
             tariffelementhasmktsegment te,
             tariff                     t
       where c.customer_ref = v_billing_cust_ref
         and te.market_segment_id = c.market_segment_id
         and te.catalogue_change_id = g_cat_change_id
         and t.catalogue_change_id = te.catalogue_change_id
         and t.tariff_id = te.tariff_id
         and t.product_family_id not in (51, 52);
      dbms_output.put_line('v_product_id is ' || v_product_id);
      dbms_output.put_line('v_tariff_id is ' || v_tariff_id);
    
      select chp.product_seq
        into v_accurals_seq
        from geneva_admin.custhasproduct           chp,
             geneva_admin.custproducttariffdetails cptd
       where chp.customer_ref = cptd.customer_ref
         and chp.domain_id = cptd.domain_id
         and chp.customer_ref = v_accurals_cust_ref
         and chp.product_seq = cptd.product_seq
         and cptd.end_dat is null;
      dbms_output.put_line('v_accurals_seq is ' || v_accurals_seq);
      dbms_output.put_line('g_sales_start_date is ' || g_sales_start_date);
    
      GENEVA_ADMIN.GNVCUSTPRODUCT.CREATECUSTPRODUCT7NC(P_CUSTOMERREF            => v_billing_cust_ref,
                                                       P_PRODUCTID              => v_product_id,
                                                       P_STARTDTM               => g_sales_start_date,
                                                       P_TERMDTM                => NULL,
                                                       P_PARENTPRODUCTSEQ       => NULL,
                                                       P_PACKAGESEQ             => NULL,
                                                       P_PRODUCTPACKAGEINSTANCE => NULL,
                                                       P_ACCOUNTNUM             => v_billing_acct_num,
                                                       P_BUDGETCENTRESEQ        => NULL,
                                                       P_TARIFFID               => v_tariff_id,
                                                       P_COMPETITORTARIFFID     => NULL,
                                                       P_PRODUCTLABEL           => NULL,
                                                       P_PRODUCTQUANTITY        => 1,
                                                       P_CUSTORDERNUM           => NULL,
                                                       P_SUPPLIERORDERNUM       => NULL,
                                                       P_CUSTPRODUCTCONTACTSEQ  => NULL,
                                                       P_CONTRACTEDPOS          => 1,
                                                       P_CPSTAXEXEMPTREF        => NULL,
                                                       P_CPSTAXEXEMPTTXT        => NULL,
                                                       P_CONTRACTSEQ            => NULL,
                                                       P_ADDITIONS_QUANTITY     => 1,
                                                       P_TERMINATIONS_QUANTITY  => NULL,
                                                       P_PRODUCTSTATUS          => 'OK',
                                                       P_STATUSREASONTXT        => '',
                                                       P_SUBSCRIPTION_REF       => NULL,
                                                       P_PRODUCTOPTIONALBOO     => 'F',
                                                       P_PRODUCTSEQ             => v_prod_seq);
      dbms_output.put_line('INFORM------------Billing Account, Product and Priceplan Added ' ||
                           TO_CHAR(CURRENT_DATE, 'YYYY/MM/DD HH24:MI:SS') ||
                           '------------');
      dbms_output.put_line('creted cust product');
      for i in (select thrt.rating_tariff_id,
                       teb.event_type_id,
                       thrt.tariff_id,
                       t.tariff_name,
                       rt.sales_start_dat,
                       rt.sales_end_dat,
                       rt.tax_inclusive_boo,
                       teb.start_dat,
                       teb.end_dat
                  from geneva_admin.TARIFFHASRATINGTARIFF thrt,
                       geneva_admin.RATINGTARIFF          rt,
                       geneva_admin.TARIFFEVENTBIND       teb,
                       geneva_admin.tariff                t,
                       geneva_admin.eventtype             e,
                       geneva_admin.producthaseventtype   php
                 where thrt.tariff_id = v_tariff_id
                   and t.tariff_id = thrt.tariff_id
                   and thrt.catalogue_change_id = t.catalogue_change_id
                   and thrt.catalogue_change_id = g_cat_change_id
                   and rt.rating_tariff_id = thrt.rating_tariff_id
                   and rt.rating_catalogue_id = g_rating_cat_change_id
                   and teb.rating_tariff_type_id = rt.rating_tariff_type_id
                   and teb.event_type_id >= 33
                   and teb.event_type_id = php.event_type_id
                   and php.product_id = v_product_id
                   and e.event_type_id = teb.event_type_id
                   and teb.rating_catalogue_id = rt.rating_catalogue_id
                   and rt.automatic_boo = 'F'
                 order by 2 asc) loop
        dbms_output.put_line('i.rating_tariff_id is ' ||
                             i.rating_tariff_id);
        GENEVA_ADMIN.GNVEVENTSRC.CREATEEVENTSOURCE5NC(P_CUSTOMERREF                  => v_billing_cust_ref,
                                                      P_PRODUCTSEQ                   => v_prod_seq,
                                                      P_EVENTSOURCE                  => v_billing_event_src,
                                                      P_EVENTTYPEID                  => i.event_type_id,
                                                      P_STARTDTM                     => g_sales_start_date,
                                                      P_ENDDTM                       => null,
                                                      P_EVENTSOURCELABEL             => v_billing_event_src,
                                                      P_EVENTSOURCETEXT              => '',
                                                      P_CREDITLIMIT                  => null,
                                                      P_RATINGTARIFFID               => i.rating_tariff_id,
                                                      P_COMPETITORRATINGTARIFFID     => null,
                                                      P_COPYGUIDINGRULES             => 'F',
                                                      P_EVENTDELETIONMODE            => null,
                                                      P_ONBILLMASKINGRULEID          => null,
                                                      P_DATASTOREMASKINGRULEID       => null,
                                                      P_DEFAULTRCHGPAYEVENTCONFIGBOO => 'F');
      
        GENEVA_ADMIN.GNVEVENTSRC.CREATEEVENTSOURCE5NC(P_CUSTOMERREF                  => v_accurals_cust_ref,
                                                      P_PRODUCTSEQ                   => v_accurals_seq,
                                                      P_EVENTSOURCE                  => v_accruals_event_src,
                                                      P_EVENTTYPEID                  => i.event_type_id,
                                                      P_STARTDTM                     => g_sales_start_date,
                                                      P_ENDDTM                       => null,
                                                      P_EVENTSOURCELABEL             => v_accruals_event_src,
                                                      P_EVENTSOURCETEXT              => '',
                                                      P_CREDITLIMIT                  => null,
                                                      P_RATINGTARIFFID               => i.rating_tariff_id,
                                                      P_COMPETITORRATINGTARIFFID     => null,
                                                      P_COPYGUIDINGRULES             => 'F',
                                                      P_EVENTDELETIONMODE            => null,
                                                      P_ONBILLMASKINGRULEID          => null,
                                                      P_DATASTOREMASKINGRULEID       => null,
                                                      P_DEFAULTRCHGPAYEVENTCONFIGBOO => 'F');
      end loop;
      dbms_output.put_line('created cust eventsource');
    exception
      when no_data_found then
        raise_application_error('-20000', ERR_035);
    end;
  
    INSERT ALL INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 78, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 79, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 80, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 81, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 82, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 83, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 84, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 85, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 86, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 87, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 88, 1) INTO GENEVA_ADMIN.ACCHASEVENTSUMMARY
      (ACCOUNT_NUM, EVENT_SUMMARY_ID, AGGREGATION_LEVEL)
    VALUES
      (v_billing_acct_num, 89, 1)
      SELECT * FROM dual;
    dbms_output.put_line('accountSetUp is ended');
  end accountSetUp;

  /* Procedure deleteCatalogue
   as
   v_start_time date;
   v_end_time date;
   v_total number;
   v_time timestamp;
   pragma autonomous_transaction;
   begin
   select systimestamp into v_time from dual;
   dbms_output.put_line('starte deleting catalogue' || g_rating_cat_change_id || ' '||g_cat_change_id || ' '|| v_time );
   v_start_time := sysdate;
           GNVRCP.REJECTCATALOGUE(CATID => g_rating_cat_change_id);
       GNVRCP.DELETECATALOGUE(CATID => g_rating_cat_change_id);
   v_end_time := sysdate;
   v_total := gnvgen.different(v_end_time, v_start_time);
   dbms_output.put_line('total time taken  deleting rating catalogue '|| v_total);
    select systimestamp into v_time from dual;
   dbms_output.put_line('starte deleting catalogue' || g_rating_cat_change_id || ' '||g_cat_change_id || ' '|| v_time );
   v_start_time := sysdate;
       GNVBCP.REJECTCATALOGUE(CATID => g_cat_change_id);
       GNVBCP.DELETECATALOGUE(CATID => g_cat_change_id);
    v_end_time := sysdate;
  select systimestamp into v_time from dual;
   dbms_output.put_line('starte deleting catalogue' || g_rating_cat_change_id || ' '||g_cat_change_id || ' '|| v_time );
    v_total := gnvgen.different(v_end_time, v_start_time);
  
   dbms_output.put_line('total time taken  deleting billing catalogue '|| v_total);
   dbms_output.put_line('ended deleting catalogue');
   end; */

  Procedure updateIntlRoamingRates(p_transaction_id  varchar,
                                   p_rating_acct_num varchar) as
    type intl_roaming_list_type is table of TMOBILE_CUSTOM.TMO_INTL_ROAMING_CHARGES%rowtype index by pls_integer;
    intl_roaming_list intl_roaming_list_type;
    v_cost_band_id    number;
    v_cost_band_name  varchar2(500);
    type rating_element_list_type is table of geneva_admin.ratingelement%rowtype index by pls_integer;
    rating_element_list    rating_element_list_type;
    rating_element_row     rating_element_row_type;
    rating_element_ref_row rating_element_row_type;
    type event_type_cost_band_row_type is record(
      event_type_id    number,
      cost_band_ref_id number);
    type event_type_cost_band_list_type is table of event_type_cost_band_row_type index by pls_integer;
    event_type_cost_band_list event_type_cost_band_list_type;
    TYPE record_type is record(
      country_name  varchar2(250),
      charging_rate number,
      fixed_rate    number);
    type country_charge_list_type is table of record_type index by pls_integer;
    country_charge_list country_charge_list_type;
    v_rate_plan_id      number;
    v_costing_rules_id  number;
    v_output_2_value    varchar2(500);
	v_output_3_value    varchar2(500);
    --v_customer_name     varchar2(500);
    subtype tariff_basis_row_type is geneva_admin.tariffbasis%rowtype;
    tariff_basis_ref_row tariff_basis_row_type;
    v_cnt                number;
    v_consider_boo       varchar2(100);
  begin
    logErrorMessages(p_transaction_id,
                     p_rating_acct_num,
                     'updateIntlRoamingRates',
                     'Started');
    dbms_output.put_line('updateIntlRoamingRates procedure is started');
    /*  select distinct CATALOGUE_CHANGE_ID,
                      RATING_CATALOGUE_ID,
                      WPS_VALID_FROM,
                      WPS_END_DATE
        into g_cat_change_id,
             g_rating_cat_change_id,
             g_sales_start_date,
             g_sales_end_date
        from TMOBILE_CUSTOM.TMO_POB_RATE_PLAN_DETAILS
       where TRANSACTION_ID = p_transaction_id
         and RATING_ACCT_NUM = p_rating_acct_num;
    exception
      when no_data_found then
        raise_application_error(-20000, ERR_030);
    end; */
  
    /* begin
      select customer_name
        into v_customer_name
        from tmobile_custom.tmo_acct_mapping acct
       where acct.rating_acct_nbr = p_rating_acct_num;
    exception
      when no_data_found then
        raise_application_error(-20000, ERR_007);
    end; */
  
    select *
      bulk collect
      into intl_roaming_list
      from TMOBILE_CUSTOM.TMO_INTL_ROAMING_CHARGES
     where TRANSACTION_ID = p_transaction_id
       and RATING_ACCT_NUM = p_rating_acct_num;
  
    if (intl_roaming_list.count = 0) then
      dbms_output.put_line('No intl data found');
      ---get all rate plans and modify
      for x in (select rate_plan_id
                  from TMOBILE_CUSTOM.TMO_POB_RATE_PLAN_DETAILS
                 where TRANSACTION_ID = p_transaction_id
                   and RATING_ACCT_NUM = p_rating_acct_num
                   and event_type_id in (20, 21, 28)
                   and catalogue_change_id = g_cat_change_id) loop
        dbms_output.put_line('deleting rate plan ' || x.rate_plan_id);
        modifyRatingElement(x.rate_plan_id, null, 'Standard', 'Delete', 0);
      end loop;
      dbms_output.put_line('deleted all Intl rating elements');
    else
      dbms_output.put_line('found intl data ');
      event_type_cost_band_list(1).event_type_id := 20;
      event_type_cost_band_list(1).cost_band_ref_id := 1116;
      event_type_cost_band_list(2).event_type_id := 21;
      event_type_cost_band_list(2).cost_band_ref_id := 887;
      event_type_cost_band_list(3).event_type_id := 28;
      event_type_cost_band_list(3).cost_band_ref_id := 2229;
    
      for rec in (select price_plan_id
                    from TMOBILE_CUSTOM.TMO_POB_RATE_PLAN_DETAILS
                   where TRANSACTION_ID = p_transaction_id
                     and RATING_ACCT_NUM = p_rating_acct_num
                     and catalogue_change_id = g_cat_change_id) loop
        for a in 1 .. event_type_cost_band_list.count loop
          v_rate_plan_id         := null;
          rating_element_ref_row := null;
          dbms_output.put_line('Prcoessing event ' || event_type_cost_band_list(a)
                               .event_type_id);
          select rate_plan_id
            into v_rate_plan_id
            from TMOBILE_CUSTOM.TMO_POB_RATE_PLAN_DETAILS
           where TRANSACTION_ID = p_transaction_id
             and RATING_ACCT_NUM = p_rating_acct_num
             and price_plan_id = rec.price_plan_id
             and catalogue_change_id = g_cat_change_id
             and event_type_id = event_type_cost_band_list(a).event_type_id;
        
          if (event_type_cost_band_list(a).event_type_id = 20) then
            select country_name, voice_charge * power(10, 11), null
              bulk collect
              into country_charge_list
              from TMO_INTL_ROAMING_CHARGES
             where TRANSACTION_ID = p_transaction_id
               and RATING_ACCT_NUM = p_rating_acct_num
               and voice_charge is not null;
          elsif (event_type_cost_band_list(a).event_type_id = 28) then
            select country_name, null, sms_charge * power(10, 9)
              bulk collect
              into country_charge_list
              from TMO_INTL_ROAMING_CHARGES
             where TRANSACTION_ID = p_transaction_id
               and RATING_ACCT_NUM = p_rating_acct_num
               and sms_charge is not null;
          elsif (event_type_cost_band_list(a).event_type_id = 21) then
            select country_name, gprs_charge * power(10, 11), null
              bulk collect
              into country_charge_list
              from TMO_INTL_ROAMING_CHARGES
             where TRANSACTION_ID = p_transaction_id
               and RATING_ACCT_NUM = p_rating_acct_num
               and gprs_charge is not null;
          end if;
        
          begin
            select re.*
              into rating_element_ref_row
              from geneva_admin.ratingelement re, geneva_admin.costband c
             where re.rating_tariff_id = v_rate_plan_id
               and re.rating_catalogue_id = g_rating_cat_change_id
               and re.end_dat is null
               and c.rating_catalogue_id = re.rating_catalogue_id
               and c.cost_band_id = re.cost_band_id
               and c.cost_band_id = event_type_cost_band_list(a)
                  .cost_band_ref_id;
          exception
            when no_data_found then
              raise_application_error(-20000,
                                      ERR_046 || event_type_cost_band_list(a)
                                      .cost_band_ref_id);
          end;
        
          begin
            select tb.*
              into tariff_basis_ref_row
              from geneva_admin.ratingtariff rt,
                   geneva_admin.tariffbasis  tb
             where rt.rating_tariff_id = v_rate_plan_id
               and rt.rating_catalogue_id = g_rating_cat_change_id
               and tb.rating_tariff_id = rt.rating_tariff_id
               and tb.rating_catalogue_id = rt.rating_catalogue_id
               and tb.end_dat is null
               and tb.cost_band_id = event_type_cost_band_list(a)
                  .cost_band_ref_id;
          exception
            when no_data_found then
              raise_application_error(-20000,
                                      ERR_046 || event_type_cost_band_list(a)
                                      .cost_band_ref_id);
          end;
        
          dbms_output.put_line('got cost band ref data ' || event_type_cost_band_list(a)
                               .cost_band_ref_id);
        
          for x in 1 .. country_charge_list.count loop
            dbms_output.put_line('country name ' || country_charge_list(x)
                                 .country_name);
            begin
              select max(c.cost_band_id),
                     emsv.output_1_value,
                     emsv.output_2_value,
					 emsv.output_3_value,
                     upper(emsv.input_2_value)
                into v_cost_band_id,
                     v_cost_band_name,
                     v_output_2_value,
					 v_output_3_value,
                     v_consider_boo
                from geneva_admin.eventmappingsetvalue emsv,
                     geneva_admin.costband             c
               where emsv.event_mapping_set_id = 12
                 and upper(emsv.input_1_value) =
                     upper(country_charge_list(x).country_name)
                 and emsv.end_dtm is null
                 and c.rating_catalogue_id = g_rating_cat_change_id
                 and c.rating_tariff_type_id =
                     decode(event_type_cost_band_list(a).event_type_id,
                            20,
                            16,
                            21,
                            15,
                            28,
                            24)
                 and ((upper(emsv.input_2_value) = 'Y' and
                     upper(substr(c.cost_band_name, 6)) =
                     upper(emsv.output_1_value)) or
                     (upper(emsv.input_2_value) = 'N'))
               group by emsv.output_1_value,
                        emsv.output_2_value,
                        upper(emsv.input_2_value),
						 emsv.output_3_value;
            exception
              when no_data_found then
                raise_application_error(-20000,
                                        ERR_034 || country_charge_list(x)
                                        .country_name);
              when too_many_rows then
                raise_application_error(-20000,
                                        ERR_045 || country_charge_list(x)
                                        .country_name);
            end;
            dbms_output.put_line('v_cost_band_id v_cost_band_name v_output_2_value v_consider_boo' ||
                                 v_cost_band_id || ' ' || v_cost_band_name || ' ' ||
                                 v_output_2_value || ' ' || v_consider_boo);
            if (v_cost_band_id is not null and v_consider_boo = 'Y') then
              begin
                select re.*
                  into rating_element_row
                  from geneva_admin.ratingelement re,
                       geneva_admin.costband      c
                 where re.rating_tariff_id = v_rate_plan_id
                   and re.rating_catalogue_id = g_rating_cat_change_id
                   and re.end_dat is null
                   and c.rating_catalogue_id = re.rating_catalogue_id
                   and c.cost_band_id = re.cost_band_id
                   and c.cost_band_id = v_cost_band_id
                   and c.rating_tariff_type_id =
                       decode(event_type_cost_band_list(a).event_type_id,
                              20,
                              16,
                              21,
                              15,
                              28,
                              24);
              
                createOrModifyRatingElement(rating_element_row,
                                            'Modify',
                                            country_charge_list(x)
                                            .country_name,
                                            country_charge_list(x)
                                            .charging_rate,
                                            country_charge_list(x)
                                            .fixed_rate,
                                            v_cost_band_id,
                                            null);
              exception
                when no_data_found then
                  createOrModifyRatingElement(rating_element_ref_row,
                                              'Add',
                                              country_charge_list   (x)
                                              .country_name,
                                              country_charge_list   (x)
                                              .charging_rate,
                                              country_charge_list   (x)
                                              .fixed_rate,
                                              v_cost_band_id,
                                              tariff_basis_ref_row);
                when too_many_rows then
                  raise_application_error(-20000,
                                          ERR_045 || v_cost_band_id || ' ' ||
                                          g_rating_cat_change_id || ' ' ||
                                          v_rate_plan_id);
              end;
            
              select count(1)
                into v_cnt
                from geneva_admin.eventmappingsetvalue
               where event_mapping_set_id = 7
                 and start_dtm = g_sales_start_date
                 and version_added = 1
                 and input_1_value = v_output_2_value
                 and input_2_value = p_rating_acct_num
                 and output_1_value = v_output_3_value
                 and output_2_value = g_partner_name
                 and output_3_value =
                     'PartnerOnBoardingWizard-' || g_partner_name
                 and output_4_value = 'POB_WIZARD';
            
              if (v_cnt = 0) then
              
                insert into geneva_admin.eventmappingsetvalue
                  (event_mapping_set_id,
                   start_dtm,
                   version_added,
                   input_1_value,
                   input_2_value,
                   output_1_value,
                   output_2_value,
                   output_3_value,
                   output_4_value)
                values
                  (7,
                   g_sales_start_date,
                   1,
                   v_output_2_value,
                   p_rating_acct_num,
                   v_output_3_value,
                   g_partner_name,
                   'PartnerOnBoardingWizard-' || g_partner_name,
                   'POB_WIZARD');
              
              end if;
            
            end if;
          
          end loop;
        
          --delete countries which are not required
          select *
            bulk collect
            into rating_element_list
            from geneva_admin.ratingelement
           where rating_tariff_id = v_rate_plan_id
             and rating_catalogue_id = g_rating_cat_change_id
             and end_dat is null
             and start_dat != g_sales_start_date;
        
          for rec in 1 .. rating_element_list.count loop
            geneva_admin.gnvratingelement.deleteratingelement5nc(p_ratingtariffid    => rating_element_list(rec)
                                                                                        .rating_tariff_id,
                                                                 p_costbandid        => rating_element_list(rec)
                                                                                        .cost_band_id,
                                                                 p_eventclassid      => rating_element_list(rec)
                                                                                        .event_class_id,
                                                                 p_onnetboo          => rating_element_list(rec)
                                                                                        .on_net_boo,
                                                                 p_timerateid        => rating_element_list(rec)
                                                                                        .time_rate_id,
                                                                 p_chargesegmentid   => rating_element_list(rec)
                                                                                        .charge_segment_id,
                                                                 p_startdat          => rating_element_list(rec)
                                                                                        .start_dat,
                                                                 p_ratingcatalogueid => g_rating_cat_change_id,
                                                                 p_enddat            => rating_element_list(rec)
                                                                                        .end_dat,
                                                                 p_fixedchargemny    => rating_element_list(rec)
                                                                                        .fixed_charge_mny,
                                                                 p_chargingrate      => rating_element_list(rec)
                                                                                        .charging_rate,
                                                                 p_mincostmny        => rating_element_list(rec)
                                                                                        .min_cost_mny,
                                                                 p_maxcostmny        => rating_element_list(rec)
                                                                                        .max_cost_mny,
                                                                 p_fixedpoints       => rating_element_list(rec)
                                                                                        .fixed_points,
                                                                 p_pointrate         => rating_element_list(rec)
                                                                                        .point_rate,
                                                                 p_unitduration      => rating_element_list(rec)
                                                                                        .unit_duration,
                                                                 p_revenuecodeid     => rating_element_list(rec)
                                                                                        .revenue_code_id,
                                                                 p_ustcodeid         => rating_element_list(rec)
                                                                                        .ust_code_id,
                                                                 p_ustcategoryid     => rating_element_list(rec)
                                                                                        .ust_category_id,
                                                                 p_taxoverrideid     => rating_element_list(rec)
                                                                                        .tax_override_id,
                                                                 p_unitname          => rating_element_list(rec)
                                                                                        .unit_name,
                                                                 p_dropeventboo      => rating_element_list(rec)
                                                                                        .drop_event_boo);
          end loop;
        
          if (event_type_cost_band_list(a).event_type_id = 21) then
          
            for rec in (select tb.*,
                               rt.rating_tariff_type_id,
                               intl.gprs_rounding_value
                          from tmobile_custom.tmo_intl_roaming_charges intl,
                               geneva_admin.costband                   c,
                               geneva_admin.tariffbasis                tb,
                               geneva_admin.ratingtariff               rt,
                               geneva_admin.costingrules               cr
                         where intl.TRANSACTION_ID = p_transaction_id
                           and intl.RATING_ACCT_NUM = p_rating_acct_num
                           and intl.gprs_charge is not null
                           and c.rating_catalogue_id =
                               g_rating_cat_change_id
                           and upper(substr(c.cost_band_name, 6)) =
                               upper(intl.country_name)
                           and tb.cost_band_id = c.cost_band_id
                           and tb.rating_catalogue_id =
                               c.rating_catalogue_id
                           and tb.rating_tariff_id = v_rate_plan_id
                           and tb.end_dat is null
                           and rt.rating_tariff_id = tb.rating_tariff_id
                           and rt.rating_catalogue_id =
                               tb.rating_catalogue_id
                           and cr.costing_rules_id = tb.costing_rules_id
                           and cr.rating_catalogue_id =
                               tb.rating_catalogue_id
                           and cr.scale_unit_size !=
                               intl.gprs_rounding_value * 1024) loop
              dbms_output.put_line(rec.cost_band_id);
              v_costing_rules_id := null;
              begin
                select costing_rules_id
                  into v_costing_rules_id
                  from geneva_admin.costingrules
                 where rating_catalogue_id = g_rating_cat_change_id
                   and scale_unit_size = rec.gprs_rounding_value * 1024
                   and scale_rounding_type = 2
                   and cost_rounding_type = 1
                   and rating_tariff_type_id = rec.rating_tariff_type_id
                   and end_dat is null;
              exception
                when no_data_found then
                  geneva_admin.gnvcostingrules.createcostingrules3nc(p_costingrulesid     => v_costing_rules_id,
                                                                     p_startdat           => g_sales_start_date,
                                                                     p_ratingcatalogueid  => g_rating_cat_change_id,
                                                                     p_enddat             => g_sales_end_date,
                                                                     p_costingrulesname   => 'Scalar Rnd Up ' ||
                                                                                             rec.gprs_rounding_value ||
                                                                                             'KB-Cost Rnd Nearest',
                                                                     p_costingrulesdesc   => 'Scalar Rnd Up KB-Cost Rnd Nearest',
                                                                     p_eventprocesstype   => 1,
                                                                     p_scaleunitsize      => rec.gprs_rounding_value * 1024,
                                                                     p_scaleroundingtype  => 2,
                                                                     p_costunitsize       => 1,
                                                                     p_costroundingtype   => 1,
                                                                     p_ratingtarifftypeid => rec.rating_tariff_type_id,
                                                                     p_authretrycount     => 0,
                                                                     p_minimumscalar      => null);
                
              end;
              geneva_admin.gnvtariffbasis.modifytariffbasis1nc(p_ratingtariffid     => v_rate_plan_id,
                                                               p_costbandid         => rec.cost_band_id,
                                                               p_eventclassid       => rec.event_class_id,
                                                               p_onnetboo           => rec.on_net_boo,
                                                               p_startdat           => rec.start_dat,
                                                               p_ratingcatalogueid  => g_rating_cat_change_id,
                                                               p_oldenddat          => rec.end_dat,
                                                               p_oldtimeratediaryid => rec.time_rate_diary_id,
                                                               p_oldstepgroupid     => rec.step_group_id,
                                                               p_oldcostingrulesid  => rec.costing_rules_id,
                                                               p_newenddat          => g_sales_end_date,
                                                               p_newtimeratediaryid => rec.time_rate_diary_id,
                                                               p_newstepgroupid     => rec.step_group_id,
                                                               p_newcostingrulesid  => v_costing_rules_id);
            
            end loop;
          
          end if;
        end loop;
      end loop;
    end if;
  
    dbms_output.put_line('Processed Intl data');
    publishCatalogue;
    accountSetUp(p_rating_acct_num);
    logErrorMessages(p_transaction_id,
                     p_rating_acct_num,
                     'updateIntlRoamingRates',
                     'Success');
  end updateIntlRoamingRates;

  Procedure validatePricePlanDetails(p_price_plan_details price_plan_row_type) as
    v_rating_tariff_details rating_tariff_row_type;
    v_discount_data         discount_row_type;
    v_discount_details      discount_details_row_type;
    v_rt_in_details         rt_details_row_type;
  begin
    dbms_output.put_line('validatePricePlanDetails procedure is started ');
    if (p_price_plan_details.transaction_id is null or
       p_price_plan_details.price_plan_name is null or
       p_price_plan_details.tlo_object_id_list.count = 0 or
       p_price_plan_details.pricing_tier_boo is null or
       p_price_plan_details.MRC_aggregation_type is null or
       p_price_plan_details.TaxCat_Code is null or
       p_price_plan_details.MRC_charge is null) then
      raise_application_error(-20002, ERR_012);
    end if;
  
    if (p_price_plan_details.rating_tariff_list.count = 0) then
      raise_application_error(-20002, ERR_015);
    end if;
  
    for x in 1 .. p_price_plan_details.rating_tariff_list.count loop
      v_rating_tariff_details := p_price_plan_details.rating_tariff_list(x);
      for y in 1 .. v_rating_tariff_details.rt_details.count loop
        v_rt_in_details := v_rating_tariff_details.rt_details(y);
        if (v_rating_tariff_details.event_type_name is null or
           v_rt_in_details.event_class is null or
           v_rt_in_details.UOM is null or
           v_rt_in_details.MRC_aggregation_type is null or
           (v_rt_in_details.MRC_aggregation_type = 'DailyAverageSubCount' and
           (v_rt_in_details.MRC_included is null or
           v_rt_in_details.charge is null or
           v_rt_in_details.overage_unit is null)) or
           (v_rating_tariff_details.event_type_name = 'GPRS' and
           (v_rt_in_details.scale_rounding_type is not null and
           (v_rt_in_details.scale_unit_size is null or
           v_rt_in_details.scale_rounding_value is null)) or
           v_rt_in_details.cost_rounding_type is null)) then
          raise_application_error(-20002, ERR_018);
        end if;
      end loop;
    end loop;
  
    if (p_price_plan_details.pricing_tier_boo and
       p_price_plan_details.discount_list.count = 0) then
      raise_application_error(-20002, ERR_016);
    end if;
  
    if (p_price_plan_details.pricing_tier_boo) then
      for x in 1 .. p_price_plan_details.discount_list.count loop
        v_discount_data := p_price_plan_details.discount_list(x);
        if (v_discount_data.event_type_name is null or
           v_discount_data.UOM is null or
           v_discount_data.charge_applied_attr is null or
           v_discount_data.threshold_value_attr is null) then
          raise_application_error(-20002, ERR_017);
        end if;
        for y in 1 .. v_discount_data.discount_Details.count loop
          v_discount_details := v_discount_data.discount_Details(y);
          if (v_discount_details.pricing_tier is null or
             v_discount_details.discount_amount is null or
             v_discount_details.threshold_start_range is null) then
            raise_application_error(-20002, ERR_017);
          end if;
        end loop;
      end loop;
    end if;
    dbms_output.put_line('validatePricePlanDetails procedure is ended ');
  end validatePricePlanDetails;

  Procedure createCatalogue(p_transaction_id        varchar,
                            p_rating_account_number varchar,
                            suspend_MRC_flag        boolean,
                            Suspend_Charge          number,
                            suspend_category        varchar,
                            TaxCat_Code             varchar,
                            p_price_plan_list       price_plan_list_type,
                            price_plan_output_list  out price_plan_output_list_type) as
    v_acct_type                 TMOBILE_CUSTOM.TMO_ACCT_MAPPING.UF_FORMAT%type;
    v_billing_PP_name           varchar2(40);
    v_billing_PP_desc           varchar2(255);
    v_parent_billing_PP_id      number;
    v_parent_price_plan_id      number;
    v_product_family_id         number;
    v_price_plan_output         price_plan_output_row_type;
    v_ovg_rating_tariff_id_list ovg_rating_tariff_id_list_type;
    rate_plan_output            rate_plan_output_row_type;
    v_accurals_tariff_id        number := 20;
    v_event_type                varchar2(50);
    v_threshold                 number;
    v_threshold_type            varchar2(50);
    v_event_class_regexp        varchar2(100);
	v_Max_Seq                   number;
	v_cnt number;
    pragma autonomous_transaction;
  begin
    logErrorMessages(p_transaction_id,
                     p_rating_account_number,
                     'createCatalogue',
                     'Started');
    dbms_output.put_line('createCatalogue procedure started');
    g_partner_name         := null;
    g_sales_start_date     := null;
    g_sales_end_date       := null;
    g_acct_type            := null;
    g_rating_cat_change_id := null;
    g_cat_change_id        := null;
    g_product_family_id    := null;
    g_product_id           := null;
    g_dummy_PP_id          := null;
    g_billing_PP_id        := null;
    g_shortname            := null;
    g_mktsegment_id        := null;
    if (p_rating_account_number is null) then
      raise_application_error(-20000, ERR_004);
    end if;
  
    if (suspend_MRC_flag is null) then
      raise_application_error(-20002, ERR_019);
    end if;
  
    if (suspend_MRC_flag and
       (Suspend_Charge is null or TaxCat_Code is null)) then
      raise_application_error(-20002, ERR_022);
    end if;
  
    if (p_price_plan_list.count = 0) then
      raise_application_error(-20002, ERR_011);
    end if;
  
    for x in 1 .. p_price_plan_list.count loop
      validatePricePlanDetails(p_price_plan_list(x));
      null;
    end loop;
  
    if (p_price_plan_list(1).TaxCat_Code is null) then
      raise_application_error(-20002, ERR_005);
    end if;
  
    /*  g_use_sequence := gnvgen.getgparamString(gparam_POBUseSequence);
    if (g_use_sequence is null) then
      raise_application_error(-20002, ERR_023);
    end if; */
    begin
      select customer_name, uf_format, trunc(effective_dtm), shortname
        into g_partner_name, v_acct_type, g_sales_start_date, g_shortname
        from tmobile_custom.tmo_acct_mapping acct,
             geneva_admin.accountstatus      accs
       where acct.rating_acct_nbr = p_rating_account_number
         and accs.account_num = acct.rating_acct_nbr
         and accs.account_status = 'OK';
    exception
      when NO_DATA_FOUND THEN
        raise_application_error(-20003, ERR_007);
    end;
    createCatalogueChange;
    -- create product Family for MVNO types
    if (INSTR(v_acct_type, 'Wholesale') > 0) then
      g_acct_type := 'MVNO';
      createProductInfo('5|20');
      v_billing_PP_name      := g_shortname || ' ' || C_MVNO_BILLING_TARIFF;
      v_parent_price_plan_id := C_MVNO_PRICE_PLAN_ID;
      v_product_family_id    := C_MVNO_PRODUCT_FAMILY_ID;
      v_billing_PP_desc      := g_partner_name || ' ' ||
                                C_MVNO_BILLING_TARIFF;
    else
      g_acct_type            := 'M2M';
      v_billing_PP_name      := C_VAR_BILLING_TARIFF || ' ' || g_shortname;
      v_parent_billing_PP_id := 6;
      v_parent_price_plan_id := C_M2M_PRICE_PLAN_ID;
      v_product_family_id    := C_M2M_PRODUCT_FAMILY_ID;
      g_product_family_id    := 6;
      g_product_id           := 184;
      v_billing_PP_desc      := C_VAR_BILLING_TARIFF || ' ' ||
                                g_partner_name;
    end if;
  
    --create dummy rate price plan with partner Name---
    g_dummy_PP_id := createTariffDetails(g_shortname,
                                         g_partner_name,
                                         v_parent_price_plan_id,
                                         v_product_family_id,
                                         false,
                                         null,
                                         false,
                                         null,
                                         null,
                                         null);
    dbms_output.put_line('g_dummy_PP_id value is ' || g_dummy_PP_id);
    --create billing account price plan--
    g_billing_PP_id := createTariffDetails(v_billing_PP_name,
                                           v_billing_PP_name,
                                           v_parent_billing_PP_id,
                                           g_product_family_id,
                                           true,
                                           g_product_id,
                                           false,
                                           Suspend_Charge,
                                           TaxCat_Code,
                                           suspend_category);
    dbms_output.put_line('g_billing_PP_id value is ' || g_billing_PP_id);
  
    for x in 1 .. p_price_plan_list.count loop
      createPricePlan(p_price_plan_list(x), v_price_plan_output);
      for z in 1 .. v_price_plan_output.rate_plan_output_list.count loop
        rate_plan_output := v_price_plan_output.rate_plan_output_list(z);
        insert into TMOBILE_CUSTOM.TMO_POB_RATE_PLAN_DETAILS
          (TRANSACTION_ID,
           RATING_ACCT_NUM,
           CATALOGUE_CHANGE_ID,
           PRICE_PLAN_ID,
           PRICE_PLAN_NAME,
           PRODUCT_ID,
           WPS_VALID_FROM,
           WPS_END_DATE,
           RATING_CATALOGUE_ID,
           RATE_PLAN_ID,
           RATE_PLAN_NAME,
           EVENT_TYPE_ID)
        values
          (p_transaction_id,
           p_rating_account_number,
           g_cat_change_id,
           v_price_plan_output.price_plan_id,
           v_price_plan_output.price_plan_name,
           v_price_plan_output.product_id,
           v_price_plan_output.WPS_valid_from,
           v_price_plan_output.WPS_end_date,
           g_rating_cat_change_id,
           rate_plan_output.rate_plan_id,
           rate_plan_output.rate_plan_name,
           rate_plan_output.event_type_id);
        update geneva_admin.tariffbasis
           set start_dat = g_sales_start_date
         where rating_tariff_id = rate_plan_output.rate_plan_id
           and rating_catalogue_id = g_rating_cat_change_id
           and end_dat is null;
      end loop;
      price_plan_output_list(x) := v_price_plan_output;
      for y in 1 .. p_price_plan_list(x).tlo_object_id_list.count loop
	  if(y=1) then 
	  select max(to_number(seq))+1 
	  into v_Max_Seq
	  from tmobile_custom.tmo_offerplanid_80;
	  else 
	  v_Max_Seq := v_Max_Seq +1;
	  end if;
	 DBMS_OUTPUT.PUT_LINE('v_Max_Seq IS:' || v_Max_Seq  || ' ' || y);
	 DBMS_OUTPUT.PUT_LINE('p_price_plan_list(x).tlo_object_id_list(y) IS:' || p_price_plan_list(x).tlo_object_id_list(y));
        insert into tmobile_custom.tmo_offerplanid_80
          (RATING_ACCT_NBR, TOMS_OBJECT_ID, TARIFF_ID, SEQ, CREATED_DTM)
        values
          (p_rating_account_number,
           p_price_plan_list(x).tlo_object_id_list(y),
           v_price_plan_output.price_plan_id,
           to_char(v_Max_Seq, '0000'),
           sysdate);
        for z in 1 .. g_ovg_rating_tariff_id_list.count loop
		DBMS_OUTPUT.PUT_LINE('v_price_plan_output.price_plan_id VALUES IS:' || v_price_plan_output.price_plan_id);
		DBMS_OUTPUT.PUT_LINE('g_ovg_rating_tariff_id_list(z).rate_PP_id VALUES IS:' || g_ovg_rating_tariff_id_list(z).rate_PP_id);
          if (g_ovg_rating_tariff_id_list(z)
             .rate_PP_id = v_price_plan_output.price_plan_id) then
            v_event_class_regexp := g_ovg_rating_tariff_id_list(z)
                                    .event_class;
            if (g_ovg_rating_tariff_id_list(z)
               .ovg_rating_tariff_type_id = 40) then
              v_event_type     := 'summ_voice';
              v_threshold      := g_ovg_rating_tariff_id_list(z)
                                  .threshold * 60;
              v_threshold_type := 'seconds';
            elsif (g_ovg_rating_tariff_id_list(z)
                  .ovg_rating_tariff_type_id = 41) then
              v_event_type     := 'summ_sms';
              v_threshold      := g_ovg_rating_tariff_id_list(z).threshold;
              v_threshold_type := 'count';
            elsif (g_ovg_rating_tariff_id_list(z)
                  .ovg_rating_tariff_type_id = 42) then
              v_event_type     := 'summ_gprs';
              v_threshold      := g_ovg_rating_tariff_id_list(z)
                                  .threshold * (1024 * 1024);
              v_threshold_type := 'bytes';
            elsif (g_ovg_rating_tariff_id_list(z)
                  .ovg_rating_tariff_type_id = 44) then
              v_event_type     := 'summ_gprs';
              v_threshold      := g_ovg_rating_tariff_id_list(z)
                                  .threshold * (1024 * 1024 * 1024);
              v_threshold_type := 'bytes';
            end if;
			DBMS_OUTPUT.PUT_LINE('v_threshold VALUES IS:' || v_threshold);
			select count(1) into v_cnt
			from tmobile_custom.tmo_overage_thresholds_80
			where ACCOUNT_NUM = p_rating_account_number
			and EVENT_TYPE = v_event_type and TOMS_TLO_ID = p_price_plan_list(x).tlo_object_id_list(y)
			and BILLING_TARIFF_ID = v_price_plan_output.price_plan_id;
            if(v_cnt=0) then 			
            insert into tmobile_custom.tmo_overage_thresholds_80
              (ACCOUNT_NUM,
               EVENT_TYPE,
               TOMS_TLO_ID,
               BILLING_TARIFF_ID,
               THRESHOLD,
               THRESHOLD_TYPE,
               START_DAT,
               END_DAT,
               TIER,
               MAP_EVENT_TYPE,
               MAP_FACTOR,
               OVERAGE_POP_METHOD,
               EVENT_BOO,
               EVENT_CLASS_REGEX,
               COST_BAND_REGEX,
               BILLING_TARIFF_NAME_REGEX)
            values
              (p_rating_account_number,
               v_event_type,
               p_price_plan_list(x).tlo_object_id_list(y),
               v_price_plan_output.price_plan_id,
               v_threshold,
               v_threshold_type,
               g_sales_start_date,
               null,
               null,
               null,
               null,
               '_createOverage',
               null,
               v_event_class_regexp,
               '.*',
               '.*');
            end if;
          end if;
        end loop;
      
      end loop;
    end loop;
    for rec in (select sum_rating_tariff_id
                  from TMO_POB_RATE_SUM_MAPPING
                 where acct_type = g_acct_type) loop
      createtariffhasratingtariff(g_billing_PP_id,
                                  rec.sum_rating_tariff_id,
                                  g_cat_change_id);
    end loop;
    for x in 1 .. g_ovg_rating_tariff_id_list.count loop
      createtariffhasratingtariff(g_billing_PP_id,
                                  g_ovg_rating_tariff_id_list(x)
                                  .ovg_rating_tariff_id,
                                  g_cat_change_id);
      createtariffhasratingtariff(v_accurals_tariff_id,
                                  g_ovg_rating_tariff_id_list(x)
                                  .ovg_rating_tariff_id,
                                  g_cat_change_id);
    end loop;
	--commit;
    updateIntlRoamingRates(p_transaction_id, p_rating_account_number);
	commit;
    logErrorMessages(p_transaction_id,
                     p_rating_account_number,
                     'createCatalogue',
                     'Success');
    dbms_output.put_line('createCatalogue procedure ended');
  exception
    when others then
      dbms_output.put_line('Error code ' || SQLERRM);
      dbms_output.put_line(systimestamp);
      rollback;
      dbms_output.put_line(systimestamp);
      logErrorMessages(p_transaction_id,
                       p_rating_account_number,
                       'createCatalogue',
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || 'message ' ||
                       sqlerrm);
      raise;
  end createCatalogue;

  FUNCTION get_Jcode_Map(v_state_code varchar,
                         v_tax_auth   number,
                         v_jcode      varchar) RETURN tax_jcode_type AS
    tax_jcode_list tax_jcode_type;
    v_aux_tax_auth GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_TAX_AUTHORITY%type := v_tax_auth;
    v_aux_jcode    varchar2(20) := v_jcode;
  BEGIN
    dbms_output.put_line('get_Jcode_Map started');
    if (v_aux_tax_auth = 5 or v_aux_tax_auth = 7) then
      v_aux_tax_auth := 3;
    elsif (v_aux_tax_auth = 6 or v_aux_tax_auth = 8) then
      v_aux_tax_auth := 4;
    end if;
    if v_aux_jcode is not null then
      if v_aux_tax_auth = 2 then
        v_aux_jcode := substr(v_jcode, 0, 2) || '0000000';
      elsif v_aux_tax_auth = 3 then
        v_aux_jcode := substr(v_jcode, 0, 5) || '0000';
      end if;
      select jcode, county_name, city_name
        bulk collect
        into tax_jcode_list
        from tmobile_custom.tmo_tax_jcodes_view
       where tax_auth = v_aux_tax_auth
         and state_code = v_state_code
         and jcode = v_aux_jcode;
    else
      select jcode, county_name, city_name
        bulk collect
        into tax_jcode_list
        from tmobile_custom.tmo_tax_jcodes_view
       where tax_auth = v_aux_tax_auth
         and state_code = v_state_code;
    end if;
    dbms_output.put_line('get_Jcode_Map ended');
    return tax_jcode_list;
  END get_Jcode_Map;

  -- check tax auth condition --
  FUNCTION check_Tax_Auth_Condition(p_tax_auth_list tax_auth_type)
    RETURN varchar AS
    v_incallsubauth varchar2(1);
  BEGIN
    if 2 member of p_tax_auth_list and 3 member of p_tax_auth_list and 4
     member of p_tax_auth_list and 7 member of p_tax_auth_list and 8
     member of p_tax_auth_list then
      v_incallsubauth := 'T';
    else
      v_incallsubauth := 'F';
    end if;
    return v_incallsubauth;
  end check_Tax_Auth_Condition;

  -- get tax auth values---
  PROCEDURE get_Tax_Auth_Map(p_exemption_type  varchar,
                             p_state_code      varchar,
                             p_tax_type        varchar,
                             p_tax_auth_list   out tax_auth_type,
                             p_incall_sub_auth out varchar) AS
  BEGIN
    dbms_output.put_line('get_Tax_Auth_Map started');
    select distinct tax_auth
      bulk collect
      into p_tax_auth_list
      from tmobile_custom.tmo_tax_exemption
     where exemption_type = p_exemption_type
       and decode(tax_auth, 1, 'US', state_code) = p_state_code
       and tax_type = p_tax_type;
    p_incall_sub_auth := check_Tax_Auth_Condition(p_tax_auth_list);
    if p_incall_sub_auth = 'T' then
      for y in 1 .. p_tax_auth_list.count loop
        if (p_tax_auth_list(y) > 2) then
          p_tax_auth_list.delete(y);
        end if;
      end loop;
    end if;
    dbms_output.put_line('get_Tax_Auth_Map ended');
  end get_Tax_Auth_Map;

  -- getexemptionMap returns combination of state code and tax type ---
  function get_Exemption_Map(p_exemption_type varchar)
    return state_taxtype_type as
    v_state_taxType_list state_taxtype_type;
  begin
    dbms_output.put_line('get_Exemption_Map starting');
    select distinct decode(te.tax_auth, 1, 'US', te.state_code) state_code,
                    te.tax_type
      bulk collect
      into v_state_taxType_list
      from tmobile_custom.tmo_tax_exemption te
     where te.exemption_type = p_exemption_type;
    dbms_output.put_line('get_Exemption_Map ended');
    return v_state_taxType_list;
  end get_Exemption_Map;

  -- update exemption type value in accountattributes table for given account num --
  Function update_acct_tax_type(p_exemption_type varchar,
                                p_account_num    varchar) return varchar as
    affectedRecords  number(1);
    p_updated_status varchar2(10);
  begin
    dbms_output.put_line('update_acct_tax_type starting');
    update geneva_admin.accountattributes
       set exemption_type = p_exemption_type
     where account_num = p_account_num;
    affectedRecords := SQL%ROWCOUNT;
    if affectedRecords = 1 then
      p_updated_status := 'Success';
    else
      p_updated_status := 'Fail';
    end if;
    dbms_output.put_line('update_acct_tax_type ended');
    return p_updated_status;
  END update_acct_tax_type;

  Procedure addTaxExemptionsOnAccount(p_transaction_id   varchar,
                                      p_billing_acct_num varchar,
                                      status             out varchar,
                                      description        out varchar) as
    v_state_code         GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.STATE_CODE%type;
    v_tax_type           GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXTERNAL_TAX_TYPE_ID%type;
    v_tax_auth           GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_TAX_AUTHORITY%type;
    v_incall_sub_auth    VARCHAR2(1);
    v_tax_auth_list      tax_auth_type;
    v_tax_jcode_list     tax_jcode_type;
    v_jcode              GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_JCODE%type;
    v_county_name        GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.COUNTY_NAME%type;
    v_city_name          GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.CITY_NAME%type;
    v_updated_status     varchar2(20);
    v_acct_jcode         varchar2(20);
    v_exemptionSeq       INTEGER;
    v_cnt                number;
    v_state_taxType_list state_taxtype_type;
    v_start_date         date;
    v_end_date           date;
    v_exemption_type     varchar2(50);
    pragma autonomous_transaction;
  begin
    logErrorMessages(p_transaction_id,
                     p_billing_acct_num,
                     'addTaxExemptionsOnAccount',
                     'Started');
    dbms_output.put_line('add_tax_exemption started');
    status := 'Error';
    begin
      select distinct trunc(effective_dtm), tax.tax_exemption_type
        into v_start_date, v_exemption_type
        from tmobile_custom.tmo_acct_mapping      acct,
             geneva_admin.accountstatus           accs,
             tmobile_custom.tmo_pob_tax_exemption tax
       where acct.billing_acct_nbr = p_billing_acct_num
         and accs.account_num = acct.billing_acct_nbr
         and accs.account_status = 'OK'
         and tax.billing_acct_num = acct.billing_acct_nbr
         and tax.transaction_id = p_transaction_id;
    exception
      when no_data_found then
        raise_application_error(-20000,
                                ERR_039 || p_billing_acct_num || ' ' ||
                                p_transaction_id);
    end;
    select count(1)
      into v_cnt
      from geneva_admin.ustaccounthasexemption
     where account_num = p_billing_acct_num
       and end_dat is null;
  
    if (v_cnt > 0) then
      raise_application_error(-20000, ERR_040 || p_billing_acct_num);
    end if;
    dbms_output.put_line(' before merge');
  
    begin
      merge into tmobile_custom.tmo_tax_exemption tax
      using (select tax_exemption_type,
                    state_code,
                    tax_type_id,
                    rbm_tax_authority
               from tmobile_custom.tmo_pob_tax_exemption
              where transaction_id = p_transaction_id
                and billing_acct_num = p_billing_acct_num) pob_tax
      on (tax.exemption_type = pob_tax.tax_exemption_type and tax.state_code = pob_tax.state_code and tax.tax_type = pob_tax.tax_type_id and tax.tax_auth = pob_tax.rbm_tax_authority)
      when not matched then
        insert
          (exemption_type, state_code, tax_type, tax_auth)
        values
          (pob_tax.tax_exemption_type,
           pob_tax.state_code,
           pob_tax.tax_type_id,
           pob_tax.rbm_tax_authority);
    exception
      when dup_val_on_index then
        null;
    end;
  
    v_state_taxType_list := get_Exemption_Map(v_exemption_type);
  
    for x in 1 .. v_state_taxType_list.count loop
      v_state_code := v_state_taxType_list(x).state_code;
      v_tax_type   := v_state_taxType_list(x).tax_type;
      get_Tax_Auth_Map(v_exemption_type,
                       v_state_code,
                       v_tax_type,
                       v_tax_auth_list,
                       v_incall_sub_auth);
      for y in 1 .. v_tax_auth_list.count loop
        v_tax_auth := v_tax_auth_list(y);
        if v_tax_auth = 1 then
          v_state_code      := null;
          v_jcode           := null;
          v_county_name     := null;
          v_city_name       := null;
          v_incall_sub_auth := 'F';
          -- call procedure gnvtax.addAccountUSTexemption1NC
          geneva_admin.gnvtax.addAccountUSTexemption1NC(p_billing_acct_num,
                                                        --to_date(v_start_date,'MM/DD/YYYY'),
                                                        v_start_date,
                                                        --to_date(v_end_date,'MM/DD/YYYY'),
                                                        v_end_date,
                                                        null,
                                                        1,
                                                        v_tax_type,
                                                        v_tax_auth,
                                                        v_incall_sub_auth,
                                                        v_state_code,
                                                        v_county_name,
                                                        v_city_name,
                                                        v_jcode,
                                                        v_exemptionSeq);
        else
          v_tax_jcode_list := get_Jcode_Map(v_state_code,
                                            v_tax_auth,
                                            v_acct_jcode);
          for z in 1 .. v_tax_jcode_list.count loop
            v_jcode       := v_tax_jcode_list(z).JCODE;
            v_county_name := v_tax_jcode_list(z).COUNTY_NAME;
            v_city_name   := v_tax_jcode_list(z).CITY_NAME;
            -- call procedure gnvtax.addAccountUSTexemption1NC
            geneva_admin.gnvtax.addAccountUSTexemption1NC(p_billing_acct_num,
                                                          --to_date(v_start_date,'MM/DD/YYYY'),
                                                          v_start_date,
                                                          --to_date(v_end_date,'MM/DD/YYYY'),
                                                          v_end_date,
                                                          null,
                                                          1,
                                                          v_tax_type,
                                                          v_tax_auth,
                                                          v_incall_sub_auth,
                                                          v_state_code,
                                                          v_county_name,
                                                          v_city_name,
                                                          v_jcode,
                                                          v_exemptionSeq);
          end loop;
        end if;
      end loop;
    end loop;
    v_updated_status := update_acct_tax_type(v_exemption_type,
                                             p_billing_acct_num);
    if v_updated_status = 'Success' then
      status      := 'Completed';
      description := 'Successfully processed';
    end if;
    commit;
    logErrorMessages(p_transaction_id,
                     p_billing_acct_num,
                     'addTaxExemptionsOnAccount',
                     status);
    dbms_output.put_line('add_tax_exemption ended');
  EXCEPTION
    when others then
      description := sqlerrm;
      dbms_output.put_line('error ' || sqlerrm);
      rollback;
      logErrorMessages(p_transaction_id,
                       p_billing_acct_num,
                       'addTaxExemptionsOnAccount',
                       DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || 'message ' ||
                       sqlerrm);
      raise;
  end addTaxExemptionsOnAccount;

END TMO_PARTNER_ONBOARDING_PKG;
/
grant execute on TMOBILE_CUSTOM.TMO_PARTNER_ONBOARDING_PKG to genevabatchuser,geneva_admin, unif_admin;
grant all on TMOBILE_CUSTOM.TMO_PARTNER_ONBOARDING_PKG to genevabatchuser,geneva_admin, unif_admin;
