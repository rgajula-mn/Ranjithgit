--------------------------------------------------------
--  File created - Monday-February-13-2017   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package TMO_INVDRILLDOWN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "TMOBILE_CUSTOM"."TMO_INVDRILLDOWN" 
AS
  PROCEDURE load_duf (
      p_account_num   VARCHAR,
      p_event_seq     NUMBER,
      p_event_type_id NUMBER,
      p_event_source  VARCHAR ) ;
  PROCEDURE load_mvno_voice (
      p_account_num      VARCHAR,
      p_event_seq        NUMBER,
      p_event_type_id    NUMBER,
      p_billing_acct_nbr VARCHAR,
      p_event_source     VARCHAR ) ;
  PROCEDURE load_mvno_data (
      p_account_num      VARCHAR,
      p_event_seq        NUMBER,
      p_event_type_id    NUMBER,
      p_billing_acct_nbr VARCHAR,
      p_event_source     VARCHAR ) ;
  PROCEDURE load_m2m_voice (
      p_account_num      VARCHAR,
      p_event_seq        NUMBER,
      p_event_type_id    NUMBER,
      p_billing_acct_nbr VARCHAR,
      p_event_source     VARCHAR ) ;
  PROCEDURE load_m2m_data (
      p_account_num      VARCHAR,
      p_event_seq        NUMBER,
      p_event_type_id    NUMBER,
      p_billing_acct_nbr VARCHAR,
      p_event_source     VARCHAR ) ;
END tmo_invdrilldown;
/

--------------------------------------------------------
--  DDL for Package Body TMO_INVDRILLDOWN
--------------------------------------------------------

CREATE OR REPLACE EDITIONABLE PACKAGE BODY "TMOBILE_CUSTOM"."TMO_INVDRILLDOWN" 
AS
PROCEDURE load_duf(
    p_account_num   VARCHAR,
    p_event_seq     NUMBER,
    p_event_type_id NUMBER,
    p_event_source  VARCHAR )
AS
BEGIN

  FOR V_ACC IN (SELECT UF_FORMAT,RATING_ACCT_NBR FROM TMO_ACCT_MAPPING WHERE BILLING_ACCT_NBR=P_ACCOUNT_NUM) LOOP
    CASE
      WHEN v_acc.uf_format!='Var' AND p_event_type_id IN ( 1,2,20,28 ) THEN
        load_mvno_voice ( v_acc.rating_acct_nbr,p_event_seq,p_event_type_id,p_account_num,p_event_source ) ;
      WHEN v_acc.uf_format!='Var' AND p_event_type_id IN ( 3,4,21 ) THEN
        load_mvno_data ( v_acc.rating_acct_nbr,p_event_seq,p_event_type_id,p_account_num,p_event_source ) ;
      WHEN v_acc.uf_format='Var' AND p_event_type_id IN ( 1,2,20,28 ) THEN
        load_m2m_voice ( v_acc.rating_acct_nbr,p_event_seq,p_event_type_id,p_account_num,p_event_source ) ;
      WHEN v_acc.uf_format='Var' AND p_event_type_id IN ( 3,4,21 ) THEN
        load_m2m_data ( v_acc.rating_acct_nbr,p_event_seq,p_event_type_id,p_account_num,p_event_source ) ;
    END CASE;
  END LOOP;
END load_duf;

PROCEDURE load_mvno_voice(
    p_account_num  VARCHAR,
    p_event_seq    NUMBER,
    p_event_type_id NUMBER,
    p_billing_acct_nbr VARCHAR,
    p_event_source VARCHAR )
AS
BEGIN
-- merge the data from costedevent0 table into duf_mvno_voice table if records not existed-----
MERGE into genevabatchuser.duf_mvno_voice mvno_voice
using
(
WITH cet0 AS
          (
            SELECT  ce0.*
              ,10000*NVL(power(10, loyalty_points),NVL(to_number( SUBSTR( regexp_substr( event_attr_43,'\|\s*(\d*)\s*$' ),2 ) ),1 )) factor
			  
              ,CASE
                  WHEN event_type_id IN( 3 )
                    AND lower( event_attr_26 ) LIKE '%standard%'
                  THEN 'Y'
                  WHEN event_type_id IN( 1 )
                    AND event_attr_13 IN( '0','4' )
                  THEN 'Y'
                  WHEN event_type_id IN( 2 )
                    AND event_attr_20  = 0
                  THEN 'Y'
                  ELSE 'N'
                END on_network_flag
              FROM costedevent0 ce0
              WHERE account_num   =p_account_num
                AND event_seq      =p_event_seq
                AND event_type_id =p_event_type_id
                AND event_source   =p_event_source
          )
        ,tam AS
          (
            SELECT  billing_acct_nbr
              ,rating_acct_nbr account_num
              ,uf_format
              FROM tmo_acct_mapping
			  WHERE rating_acct_nbr = p_account_num
          )
        ,acct AS
          (
            SELECT  billing_acct_nbr
              ,account_num
              ,event_seq
              ,bill_dtm
              ,uf_format
              FROM
                (
                  SELECT  billing_acct_nbr
                    ,tam.account_num
                    ,bs.event_seq
                    ,TO_CHAR( bs.bill_dtm,'YYYYMMDD' ) bill_dtm
                    ,tam.uf_format
                    FROM billsummary bs
                    , tam 
                    WHERE bs.account_num = tam.billing_acct_nbr
                    AND bs.bill_status in (1,7,8)
                  UNION
                  SELECT  billing_acct_nbr
                    ,account_num
                    ,bill_event_seq
                    ,TO_CHAR( next_bill_dtm,'YYYYMMDD' )
                    ,tam.uf_format
                    FROM ACCOUNT A
                    JOIN tam USING( account_num )
                )
              ORDER BY 1,2
          )
        ,toms AS
          (
            SELECT  object_id event_attr_45
              ,object_name
              FROM tmobile_custom.toms_offernamemapping_last
          )
        ,pkg AS
          (
            select tomsobjid event_attr_45, tariff_name event_attr_44,plan_name package_name from tmobile_custom.GenPlanNameMapView
          
          )
            SELECT  EVENT_TYPE_ID RECORD_TYPE
          , BILLING_ACCT_NBR ACCOUNT_NUMBER
          , cet0.EVENT_SEQ SEQUENCE_NUMBER
          , EVENT_ATTR_1 IMSI
          , EVENT_ATTR_12 MSISDN
          ,CASE 
			  WHEN EVENT_ATTR_41 is null
			  THEN EVENT_DTM 
			  ELSE
			   to_date(EVENT_ATTR_41, 'MM/DD/YYYY HH12:MI:SS')
			END CHANNEL_SEIZURE_DT
          , EVENT_ATTR_6 SWITCH_ID
          , EVENT_ATTR_2 IMEI
          , EVENT_ATTR_14 HOME_SID
          , EVENT_ATTR_15 SERVE_SID
          , CASE
              WHEN event_type_id IN( 1,20 )
              THEN EVENT_ATTR_36
              WHEN event_type_id IN( 2,28 )
              THEN EVENT_ATTR_29
            END CELL_IDENTITY
          ,(
            CASE
              WHEN( event_type_id IN( 1,20 )
                AND event_attr_9!   ='0' )
                OR( event_type_id  IN( 2,28 )
                AND event_attr_9!   ='MO' )
              THEN event_attr_11
              ELSE event_attr_10
            END ) CALL_TO_TN
          , CASE
              WHEN event_type_id IN( 1,2)
              THEN regexp_replace( event_attr_33,'(.*)\,.*','\1' )
            END CALL_TO_PLACE
          , CASE
              WHEN event_type_id IN( 1,2)
              THEN regexp_replace( event_attr_33,'.*\,(.*)','\1' )
            END CALL_TO_REGION
          , EVENT_ATTR_8 OUTGOING_CELL_TRUNK_ID
          , EVENT_ATTR_7 INCOMING_TRUNK_ID
          , CASE
              WHEN event_type_id IN( 1,20 )
              THEN EVENT_ATTR_35  /60
              WHEN event_type_id IN( 2,28 )
              THEN decode(instr(event_attr_4,':'),0,to_number(event_attr_4), to_number( TO_CHAR( to_date( event_attr_4,'hh24:mi:ss' ),'sssss' ) )) 
            END ANSWER_TIME_DUR_ROUND_MIN
          , CASE
          WHEN event_attr_4 like '%:%' THEN to_number( TO_CHAR( to_date( event_attr_4,'hh24:mi:ss' ),'sssss' ) )
        ELSE to_number(event_attr_4)
      END ANSWER_TIME_CALL_DUR_SEC
          ,(
            CASE
              WHEN event_type_id IN( 3,21 )
              THEN event_attr_27  /(FACTOR*100)
              WHEN event_type_id IN( 2,28 )
              THEN event_attr_26  /factor
              WHEN event_type_id IN( 1,20 )
              THEN event_attr_34  /(FACTOR*100)
              ELSE event_attr_24  /factor
            END ) AIR_RATE
          , CASE
              WHEN event_type_id IN( 1,20 )
              THEN EVENT_ATTR_27  /FACTOR
              WHEN event_type_id IN( 2,28 )
              THEN EVENT_COST_MNY /FACTOR
            END AIR_CHARGE_AMOUNT
          ,(
            CASE
              WHEN event_type_id              =3
                AND to_number( event_attr_20 )>=8
              THEN to_number( event_attr_20 )
              WHEN event_type_id IN( 1,3 )
              THEN DECODE( on_network_flag,'Y',1,2 )
              WHEN event_type_id = 21
                AND event_attr_20 ='3'
                AND cet0.account_num   ='ACC000140'
              THEN 7
              WHEN event_type_id IN( 20,21 )
              THEN 3
              WHEN event_type_id =2
              THEN DECODE( event_attr_20,'0',4,'1',5,'2',6,4 )
              WHEN event_type_id =4
              THEN DECODE( lower( event_attr_15 ),'h',4,'d',5,'i',6,4 )
			  WHEN event_type_id =28
			  THEN 6
              ELSE 0
            END ) AIR_CHARGE_CODE
          ,(
            CASE
              WHEN event_attr_35/60<=0
              THEN NULL
              WHEN lower( event_attr_30 ) LIKE '%directory assistance%'
              THEN event_attr_24 /factor
              WHEN event_attr_24 /factor>0
              THEN( event_attr_24/factor )/( event_attr_35/60 )
              ELSE 0
            END ) TOLL_RATE
          , NVL((EVENT_ATTR_24/FACTOR),0) TOLL_CHARGE_AMOUNT
          ,(
            CASE
              WHEN NVL( event_attr_24,'0' )='0'
              THEN NULL -- this MUST be first condition
              WHEN lower( event_attr_30 ) LIKE '%long distance%'
              THEN DECODE( ON_NETWORK_FLAG,'Y',1,2 )
              WHEN lower( event_attr_30 ) LIKE '%directory assistance%'
              THEN DECODE( ON_NETWORK_FLAG,'Y',5,6 )
              WHEN lower( event_attr_30 ) LIKE '%international%'
              THEN DECODE( ON_NETWORK_FLAG,'Y',4,3 )
              ELSE -1
            END ) TOLL_CHARGE_CODE
          , ON_NETWORK_FLAG ON_NETWORK_FLAG
          ,(
            CASE
              WHEN( event_type_id IN( 1,20 )
                AND event_attr_9!   ='0' )
                OR( event_type_id  IN( 2,28 )
                AND event_attr_9!   ='MO' )
              THEN 1
              ELSE 0
            END ) CALL_DIRECTION
          , EVENT_ATTR_16 TRANSLATED_NUMBER
          ,pkg.package_name
          , to_date(BILL_DTM,'YYYYMMDD') BILL_DATE
          , CASE
              WHEN event_type_id IN( 20 )
              THEN EVENT_ATTR_19
              WHEN event_type_id IN( 28 )
              THEN EVENT_ATTR_18
            END PLMN_CODE
          , CASE
              WHEN event_type_id IN( 20,28 )
              THEN regexp_replace(
                CASE
                  WHEN event_type_id IN( 3,21 )
                    AND event_attr_28 LIKE 'Int%'
                  THEN event_attr_28
                  WHEN event_type_id IN( 1,20 )
                    AND event_attr_30 LIKE 'Int%'
                  THEN event_attr_30
                  WHEN event_type_id IN( 2,28 )
                    AND event_attr_27 LIKE 'Int%'
                  THEN event_attr_27
                END,'Int.*\-\s*(.*)','\1' )
            END COUNTRY_NAME
          , DECODE(cet0.event_type_id,4,cet0.event_attr_14,DECODE(cet0.event_attr_22, 'UNKNOWN','',cet0.event_attr_22)) TECHNOLOGY_USED
          , SUBSTR(EVENT_ATTR_38, 1, 1) ||
		 decode(SUBSTR(EVENT_ATTR_38, 2, 2),
				'0A',
				'10',
				'0B',
				'11',
				'0C',
				'12',
				'0D',
				'13',
				'0E',
				'14',
		SUBSTR(EVENT_ATTR_38, 2, 2)) ||':'|| SUBSTR(EVENT_ATTR_38, 4, 2) UTC_OFFSET
          ,DECODE( cet0.event_type_id, 1, cet0.event_attr_34/(FACTOR*100), 20, cet0.event_attr_34/(FACTOR*100), 2, cet0.event_attr_26/(FACTOR), 3, cet0.event_attr_27/(FACTOR*100), 21, cet0.event_attr_27/(FACTOR*100), 4, cet0.event_attr_24/(FACTOR), 28, cet0.event_attr_26/(FACTOR)) CHARGING_RATE
      ,NVL(CASE
      WHEN cet0.account_num ='ACC000132'
      AND cet0.event_type_id=4
      THEN DECODE(cet0.event_attr_13,'Tran',cet0.event_attr_26
        ||' - Transit', cet0.event_attr_26
        ||' - '
        ||cet0.event_attr_25)
      ELSE DECODE( cet0.event_type_id, 1, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 20, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 4, cet0.event_attr_26 )
      END,
      DECODE( cet0.event_type_id, 3, cet0.event_attr_28, 21, cet0.event_attr_28, 28, cet0.event_attr_27, 4, cet0.event_attr_10, 2, NVL(cet0.event_attr_27, 'SMS') )) COST_BAND
      ,DECODE( cet0.event_type_id, 1, decode(cet0.ACCOUNT_NUM||'|'||EVENT_ATTR_31||'|'||EVENT_ATTR_39, 'ACC000134|Standard MT-LM2LM|F','Standard', EVENT_ATTR_31), 20, cet0.event_attr_31, 2, cet0.event_attr_28, 3, cet0.event_attr_26, 21, cet0.event_attr_26, 28, cet0.event_attr_28, 'NULL' ) EVENT_CLASS
      ,CASE
      WHEN cet0.event_type_id = 3
      THEN cet0.event_attr_30
      ELSE NULL
      END DISCOUNT_NAME
      ,DECODE(cet0.event_type_id,4,cet0.event_attr_14,DECODE(cet0.event_attr_22, 'UNKNOWN','',cet0.event_attr_22)) TECH_TYPE
      ,event_attr_44 BILLING_TARIFF_NAME
      ,event_attr_45 TOMS_TLO_ID
	  ,NVL(event_attr_46,'None') SUBSCRIBER_TYPE
      ,EVENT_REF
      ,CREATED_DTM
      ,(SELECT duf.duf_filename
        FROM TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS duf
        WHERE duf.first_event_created_dtm <= cet0.CREATED_DTM
        AND duf.last_event_created_dtm     >= cet0.CREATED_DTM
         AND duf.account_num = cet0.account_num 
         AND duf.event_seq = cet0.event_seq 
         AND event_type = 'VOICE' 
         AND rownum<2) DUF_FILENAME
          FROM cet0
           join acct on  ( cet0.account_num = acct.account_num 
          and cet0.event_seq = acct.event_seq )
          LEFT OUTER JOIN pkg USING( event_attr_44,event_attr_45 )) CET
on (mvno_voice.account_number = cet.account_number and mvno_voice.sequence_number = cet.sequence_number
and mvno_voice.record_type = cet.record_type and mvno_voice.msisdn = cet.msisdn and mvno_voice.EVENT_REF = cet.EVENT_REF)
when not matched then 
  INSERT
  (
     PARTNER_TYPE    
    ,RECORD_TYPE
    ,ACCOUNT_NUMBER
    ,SEQUENCE_NUMBER
    ,IMSI
    ,MSISDN
    ,CHANNEL_SEIZURE_DT
    ,SWITCH_ID
    ,IMEI
    ,HOME_SID
    ,SERVE_SID
    ,CELL_IDENTITY
    ,CALL_TO_TN
    ,CALL_TO_PLACE
    ,CALL_TO_REGION
    ,OUTGOING_CELL_TRUNK_ID
    ,INCOMING_TRUNK_ID
    ,ANSWER_TIME_DUR_ROUND_MIN
    ,ANSWER_TIME_CALL_DUR_SEC
    ,AIR_RATE
    ,AIR_CHARGE_AMOUNT
    ,AIR_CHARGE_CODE
    ,TOLL_RATE
    ,TOLL_CHARGE_AMOUNT
    ,TOLL_CHARGE_CODE
    ,ON_NETWORK_FLAG
    ,CALL_DIRECTION
    ,TRANSLATED_NUMBER
    ,PACKAGE_NAME
    ,BILL_DATE
    ,PLMN_CODE
    ,COUNTRY_NAME
    ,TECHNOLOGY_USED
    ,UTC_OFFSET
    ,CHARGING_RATE
    ,COST_BAND
    ,EVENT_CLASS
    ,DISCOUNT_NAME
    ,TECH_TYPE
    ,BILLING_TARIFF_NAME
    ,TOMS_TLO_ID
	,SUBSCRIBER_TYPE
    ,EVENT_REF
    ,CREATED_DTM
    ,DUF_FILENAME)
 values
 (
  'MVNO',
     CET.RECORD_TYPE
    ,CET.ACCOUNT_NUMBER
    ,CET.SEQUENCE_NUMBER
    ,CET.IMSI
    ,CET.MSISDN
    ,CET.CHANNEL_SEIZURE_DT
    ,CET.SWITCH_ID
    ,CET.IMEI
    ,CET.HOME_SID
    ,CET.SERVE_SID
    ,CET.CELL_IDENTITY
    ,CET.CALL_TO_TN
    ,CET.CALL_TO_PLACE
    ,CET.CALL_TO_REGION
    ,CET.OUTGOING_CELL_TRUNK_ID
    ,CET.INCOMING_TRUNK_ID
    ,CET.ANSWER_TIME_DUR_ROUND_MIN
    ,CET.ANSWER_TIME_CALL_DUR_SEC
    ,CET.AIR_RATE
    ,CET.AIR_CHARGE_AMOUNT
    ,CET.AIR_CHARGE_CODE
    ,CET.TOLL_RATE
    ,CET.TOLL_CHARGE_AMOUNT
    ,CET.TOLL_CHARGE_CODE
    ,CET.ON_NETWORK_FLAG
    ,CET.CALL_DIRECTION
    ,CET.TRANSLATED_NUMBER
    ,CET.PACKAGE_NAME
    ,CET.BILL_DATE
    ,CET.PLMN_CODE
    ,CET.COUNTRY_NAME
    ,CET.TECHNOLOGY_USED
    ,CET.UTC_OFFSET
    ,CET.CHARGING_RATE
    ,CET.COST_BAND
    ,CET.EVENT_CLASS
    ,CET.DISCOUNT_NAME
    ,CET.TECH_TYPE
    ,CET.BILLING_TARIFF_NAME
    ,CET.TOMS_TLO_ID
	,CET.SUBSCRIBER_TYPE
    ,CET.EVENT_REF
    ,CET.CREATED_DTM
    ,CET.DUF_FILENAME);
      commit;
END load_mvno_voice;

PROCEDURE load_mvno_data(
    p_account_num  VARCHAR,
    p_event_seq    NUMBER,
    p_event_type_id NUMBER,
    p_billing_acct_nbr VARCHAR,
    p_event_source VARCHAR )
AS
BEGIN
-- merge the data from costedevent0 table into duf_mvno_data table if records not matched-----
MERGE INTO genevabatchuser.duf_mvno_data mvno_data
using 
(
WITH cet0 AS
          (
            SELECT  ce0.*
              ,10000*NVL(power(10, loyalty_points),NVL(to_number( SUBSTR( regexp_substr( event_attr_43,'\|\s*(\d*)\s*$' ),2 ) ),1 )) factor
              ,CASE
                  WHEN event_type_id IN( 3 )
                    AND lower( event_attr_26 ) LIKE '%standard%'
                  THEN 'Y'
                  WHEN event_type_id IN( 1 )
                    AND event_attr_13 IN( '0','4' )
                  THEN 'Y'
                  WHEN event_type_id IN( 2 )
                    AND event_attr_20  = 0
                  THEN 'Y'
                  ELSE 'N'
                END on_network_flag
              FROM costedevent0 ce0
              WHERE account_num   =p_account_num
                AND event_seq      =p_event_seq
                AND event_type_id =p_event_type_id
                AND event_source   =p_event_source

          )
        ,tam AS
          (
            SELECT  billing_acct_nbr
              ,rating_acct_nbr account_num
              ,uf_format
              FROM tmo_acct_mapping
			  WHERE rating_acct_nbr = p_account_num
          )
        ,acct AS
          (
            SELECT  billing_acct_nbr
              ,account_num
              ,event_seq
              ,bill_dtm
              ,uf_format
              FROM
                (
                  SELECT  billing_acct_nbr
                    ,tam.account_num
                    ,bs.event_seq
                    ,TO_CHAR( bs.bill_dtm,'YYYYMMDD' ) bill_dtm
                    ,tam.uf_format
                    FROM billsummary bs
                    , tam 
                    WHERE bs.account_num = tam.billing_acct_nbr
                    AND bs.bill_status in (1,7,8)
                  UNION
                  SELECT  billing_acct_nbr
                    ,account_num
                    ,bill_event_seq
                    ,TO_CHAR( next_bill_dtm,'YYYYMMDD' )
                    ,tam.uf_format
                    FROM ACCOUNT A
                    JOIN tam USING( account_num )
                )
              ORDER BY 1,2
          )
        ,toms AS
          (
            SELECT  object_id event_attr_45
              ,object_name
              FROM tmobile_custom.toms_offernamemapping_last
          )
        ,pkg AS
          (
            select tomsobjid event_attr_45, tariff_name event_attr_44,plan_name package_name from tmobile_custom.GenPlanNameMapView
          )
        SELECT  EVENT_TYPE_ID RECORD_TYPE
          , BILLING_ACCT_NBR ACCOUNT_NUMBER
          , cet0.EVENT_SEQ SEQUENCE_NUMBER
          , EVENT_ATTR_1 IMSI
          , EVENT_ATTR_12 MSISDN
          , CASE 
			  WHEN EVENT_ATTR_41 is null
			  THEN EVENT_DTM 
			  ELSE
			   to_date(EVENT_ATTR_41, 'MM/DD/YYYY HH12:MI:SS')
			END RECORD_START_TIME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_9
            END ACCESS_POINT_NAME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_2
            END IMEI
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_13
            END HOME_SID
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_14
            END SERVE_SID
          , EVENT_ATTR_39 SERVED_PDP_ADDRESS
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_15
            END CELL_IDENTITY
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_16
            END LOCATION_AREA_CODE
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN(
                CASE
                  WHEN event_type_id NOT IN( 3,21 )
                  THEN 0
                  WHEN acct.uf_format ='Var'
                  THEN to_number( event_attr_6 )
                  ELSE ROUND((event_attr_6 /( 1024*1024 )),3)
                END )
              WHEN event_type_id IN( 4 )
              THEN to_number( EVENT_ATTR_3 )
            END TOTAL_VOLUME
          ,decode(instr(event_attr_4,':'),0,to_number(event_attr_4), to_number( TO_CHAR( to_date( event_attr_4,'hh24:mi:ss' ),'sssss' ) )) DURATION
          , '' DATA_DESCRIPTION
          ,(
            CASE
              WHEN event_type_id              =3
                AND to_number( event_attr_20 )>=8
              THEN to_number( event_attr_20 )
              WHEN event_type_id IN( 1,3 )
              THEN DECODE( on_network_flag,'Y',1,2 )
              WHEN event_type_id = 21
                AND event_attr_20 ='3'
                AND cet0.account_num   ='ACC000140'
              THEN 7
              WHEN event_type_id IN( 20,21 )
              THEN 3
              WHEN event_type_id =2
              THEN DECODE( event_attr_20,'0',4,'1',5,'2',6,4 )
              WHEN event_type_id =4
              THEN DECODE( lower( event_attr_15 ),'h',4,'d',5,'i',6,4 )
              ELSE 0
            END ) DATA_CHARGE_CODE
          ,(
            CASE
              WHEN event_type_id IN( 3,21 )
              THEN event_attr_27  / (factor *100)
              WHEN event_type_id IN( 2,28 )
              THEN event_attr_26  /factor
              WHEN event_type_id IN( 1,20 )
              THEN event_attr_34  /(factor *100)
              ELSE event_attr_24  /factor
            END ) DATA_RATE
          , EVENT_COST_MNY/FACTOR DATA_CHARGE_AMOUNT
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN ON_NETWORK_FLAG
            END ON_NETWORK_FLAG
          , CASE
              WHEN event_type_id IN( 4 )
              THEN EVENT_ATTR_25
            END MMS_TYPE_INDICATOR
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_8
              WHEN event_type_id IN( 4 )
              THEN EVENT_ATTR_6
            END CALLED_NUMBER_URL
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_3
            END UPLINK_VOLUME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_5
            END DOWNLINK_VOLUME
           ,pkg.PACKAGE_NAME
          , to_date(BILL_DTM,'YYYYMMDD')  BILL_DATE
          , CASE
              WHEN event_type_id IN( 21 )
              THEN EVENT_ATTR_18
            END PLMN_CODE
          , CASE
              WHEN event_type_id IN( 21 )
              THEN regexp_replace(
                CASE
                  WHEN event_type_id IN( 3,21 )
                    AND event_attr_28 LIKE 'Int%'
                  THEN event_attr_28
                  WHEN event_type_id IN( 1,20 )
                    AND event_attr_30 LIKE 'Int%'
                  THEN event_attr_30
                  WHEN event_type_id IN( 2,28 )
                    AND event_attr_27 LIKE 'Int%'
                  THEN event_attr_27
                END,'Int.*\-\s*(.*)','\1' )
            END COUNTRY_NAME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_10
            END RECORDING_ENTITY
          , DECODE(cet0.event_type_id,4,cet0.event_attr_14,DECODE(cet0.event_attr_22, 'UNKNOWN','',cet0.event_attr_22)) TECHNOLOGY_USED
          , SUBSTR(EVENT_ATTR_38, 1, 1) ||
			decode(SUBSTR(EVENT_ATTR_38, 2, 2),
              '0A',
              '10',
              '0B',
              '11',
              '0C',
              '12',
              '0D',
              '13',
              '0E',
              '14',
              SUBSTR(EVENT_ATTR_38, 2, 2)) ||':'|| SUBSTR(EVENT_ATTR_38, 4, 2) UTC_OFFSET
          ,DECODE( cet0.event_type_id, 1, cet0.event_attr_34/(FACTOR*100), 20, cet0.event_attr_34/(FACTOR*100), 2, cet0.event_attr_26/(FACTOR), 3, cet0.event_attr_27/(FACTOR*100), 21, cet0.event_attr_27/(FACTOR*100), 4, cet0.event_attr_24/(FACTOR), 28, cet0.event_attr_26/(FACTOR)) CHARGING_RATE
      ,NVL(CASE
      WHEN cet0.account_num ='ACC000132'
      AND cet0.event_type_id=4
      THEN DECODE(cet0.event_attr_13,'Tran',cet0.event_attr_26
        ||' - Transit', cet0.event_attr_26
        ||' - '
        ||cet0.event_attr_25)
      ELSE DECODE( cet0.event_type_id, 1, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 20, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 4, cet0.event_attr_26 )
      END,
      DECODE( cet0.event_type_id, 3, cet0.event_attr_28, 21, cet0.event_attr_28, 28, cet0.event_attr_27, 4, cet0.event_attr_10, 2, NVL(cet0.event_attr_27,'SMS') )) COST_BAND
      ,DECODE( cet0.event_type_id, 1, decode(cet0.ACCOUNT_NUM||'|'||EVENT_ATTR_31||'|'||EVENT_ATTR_39, 'ACC000134|Standard MT-LM2LM|F','Standard', EVENT_ATTR_31), 20, cet0.event_attr_31, 2, cet0.event_attr_28, 3, cet0.event_attr_26, 21, cet0.event_attr_26, 28, cet0.event_attr_28, 'NULL' ) EVENT_CLASS
      ,CASE
      WHEN cet0.event_type_id = 3
      THEN cet0.event_attr_30
      ELSE NULL
      END DISCOUNT_NAME
      ,DECODE(cet0.event_type_id,4,cet0.event_attr_14,DECODE(cet0.event_attr_22, 'UNKNOWN','',cet0.event_attr_22)) TECH_TYPE
      ,event_attr_44 BILLING_TARIFF_NAME
      ,event_attr_45 TOMS_TLO_ID
	  ,NVL(event_attr_46,'None') SUBSCRIBER_TYPE
      ,EVENT_REF
      ,CREATED_DTM      
      ,(SELECT duf.duf_filename
        FROM TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS duf
        WHERE duf.first_event_created_dtm <= cet0.CREATED_DTM
        AND duf.last_event_created_dtm     >= cet0.CREATED_DTM
         AND duf.account_num = cet0.account_num 
         AND duf.event_seq = cet0.event_seq 
         AND event_type = 'DATA' 
         AND rownum<2) DUF_FILENAME
          FROM cet0
           join acct on  ( cet0.account_num = acct.account_num 
          and cet0.event_seq = acct.event_seq )
          LEFT OUTER JOIN pkg USING( event_attr_44,event_attr_45 )) CET
on (mvno_data.account_number = cet.account_number and mvno_data.sequence_number = cet.sequence_number
and mvno_data.record_type = cet.record_type and mvno_data.msisdn = cet.msisdn and mvno_data.EVENT_REF = cet.EVENT_REF)
WHEN NOT MATCHED THEN 
INSERT (
     PARTNER_TYPE 
    ,RECORD_TYPE
    ,ACCOUNT_NUMBER
    ,SEQUENCE_NUMBER
    ,IMSI
    ,MSISDN
    ,RECORD_START_TIME
    ,ACCESS_POINT_NAME
    ,IMEI
    ,HOME_SID
    ,SERVE_SID
    ,SERVED_PDP_ADDRESS
    ,CELL_IDENTITY
    ,LOCATION_AREA_CODE
    ,TOTAL_VOLUME
    ,DURATION
    ,DATA_DESCRIPTION
    ,DATA_CHARGE_CODE
    ,DATA_RATE
    ,DATA_CHARGE_AMOUNT
    ,ON_NETWORK_FLAG
    ,MMS_TYPE_INDICATOR
    ,CALLED_NUMBER_URL
    ,UPLINK_VOLUME
    ,DOWNLINK_VOLUME
    ,PACKAGE_NAME
    ,BILL_DATE
    ,PLMN_CODE
    ,COUNTRY_NAME
    ,RECORDING_ENTITY
    ,TECHNOLOGY_USED
    ,UTC_OFFSET
    ,CHARGING_RATE
    ,COST_BAND
    ,EVENT_CLASS
    ,DISCOUNT_NAME
    ,TECH_TYPE
    ,BILLING_TARIFF_NAME
    ,TOMS_TLO_ID
	,SUBSCRIBER_TYPE
    ,EVENT_REF
    ,CREATED_DTM
    ,DUF_FILENAME)
  VALUES
  (
    'MVNO'
    ,CET.RECORD_TYPE
    ,CET.ACCOUNT_NUMBER
    ,CET.SEQUENCE_NUMBER
    ,CET.IMSI
    ,CET.MSISDN
    ,CET.RECORD_START_TIME
    ,CET.ACCESS_POINT_NAME
    ,CET.IMEI
    ,CET.HOME_SID
    ,CET.SERVE_SID
    ,CET.SERVED_PDP_ADDRESS
    ,CET.CELL_IDENTITY
    ,CET.LOCATION_AREA_CODE
    ,CET.TOTAL_VOLUME
    ,CET.DURATION
    ,CET.DATA_DESCRIPTION
    ,CET.DATA_CHARGE_CODE
    ,CET.DATA_RATE
    ,CET.DATA_CHARGE_AMOUNT
    ,CET.ON_NETWORK_FLAG
    ,CET.MMS_TYPE_INDICATOR
    ,CET.CALLED_NUMBER_URL
    ,CET.UPLINK_VOLUME
    ,CET.DOWNLINK_VOLUME
    ,CET.PACKAGE_NAME
    ,CET.BILL_DATE
    ,CET.PLMN_CODE
    ,CET.COUNTRY_NAME
    ,CET.RECORDING_ENTITY
    ,CET.TECHNOLOGY_USED
    ,CET.UTC_OFFSET
    ,CET.CHARGING_RATE
    ,CET.COST_BAND
    ,CET.EVENT_CLASS
    ,CET.DISCOUNT_NAME
    ,CET.TECH_TYPE
    ,CET.BILLING_TARIFF_NAME
    ,CET.TOMS_TLO_ID
	,CET.SUBSCRIBER_TYPE
    ,CET.EVENT_REF
    ,CET.CREATED_DTM
    ,CET.DUF_FILENAME);
      commit;
END load_mvno_data;

PROCEDURE load_m2m_voice(
    p_account_num  VARCHAR,
    p_event_seq    NUMBER,
    p_event_type_id NUMBER,
    p_billing_acct_nbr VARCHAR,
    p_event_source VARCHAR )
AS
BEGIN
-- merge the data from costedevent0 table into duf_m2m_voice table if records not matched-----
merge into genevabatchuser.duf_m2m_voice m2m_voice
using
(
 WITH cet0 AS
          (
            SELECT  ce0.*
              ,10000*NVL(power(10, loyalty_points),NVL(to_number( SUBSTR( regexp_substr( event_attr_43,'\|\s*(\d*)\s*$' ),2 ) ),1 )) factor
              ,CASE
                  WHEN event_type_id IN( 3 )
                    AND lower( event_attr_26 ) LIKE '%standard%'
                  THEN 'Y'
                  WHEN event_type_id IN( 1 )
                    AND event_attr_13 IN( '0','4' )
                  THEN 'Y'
                  WHEN event_type_id IN( 2 )
                    AND event_attr_20  = 0
                  THEN 'Y'
                  ELSE 'N'
                END on_network_flag
              FROM costedevent0 ce0
              WHERE account_num   =p_account_num
                AND event_seq      =p_event_seq
                AND event_type_id =p_event_type_id
                AND event_source   =p_event_source
          )
        ,tam AS
          (
            SELECT  billing_acct_nbr
              ,rating_acct_nbr account_num
              ,uf_format
              FROM tmo_acct_mapping
			  WHERE rating_acct_nbr = p_account_num
          )
        ,acct AS
          (
            SELECT  billing_acct_nbr
              ,account_num
              ,event_seq
              ,bill_dtm
              ,uf_format
              FROM
                (
                  SELECT  billing_acct_nbr
                    ,tam.account_num
                    ,bs.event_seq
                    ,TO_CHAR( bs.bill_dtm,'YYYYMMDD' ) bill_dtm
                    ,tam.uf_format
                    FROM billsummary bs
                    , tam 
                    WHERE bs.account_num = tam.billing_acct_nbr
                    AND bs.bill_status in (1,7,8)
                  UNION
                  SELECT  billing_acct_nbr
                    ,account_num
                    ,bill_event_seq
                    ,TO_CHAR( next_bill_dtm,'YYYYMMDD' )
                    ,tam.uf_format
                    FROM ACCOUNT A
                    JOIN tam USING( account_num )
                )
              ORDER BY 1,2
          )
        ,toms AS
          (
            SELECT  object_id event_attr_45
              ,object_name
              FROM tmobile_custom.toms_offernamemapping_last
          )
        ,pkg AS
          (
          select tomsobjid event_attr_45, tariff_name event_attr_44,plan_name package_name from tmobile_custom.GenPlanNameMapView
          )
        SELECT  EVENT_TYPE_ID RECORD_TYPE
          , BILLING_ACCT_NBR ACCOUNT_NUMBER
          , cet0.EVENT_SEQ SEQUENCE_NUMBER
          , EVENT_ATTR_1 IMSI
          , EVENT_ATTR_12 MSISDN
          , CASE 
			  WHEN EVENT_ATTR_41 is null
			  THEN EVENT_DTM 
			  ELSE
			   to_date(EVENT_ATTR_41, 'MM/DD/YYYY HH12:MI:SS')
			END CHANNEL_SEIZURE_DT
          , EVENT_ATTR_6 SWITCH_ID
          , EVENT_ATTR_2 IMEI
          , EVENT_ATTR_14 HOME_SID
          , EVENT_ATTR_15 SERVE_SID
          , CASE
              WHEN event_type_id IN( 1,20 )
              THEN EVENT_ATTR_36
              WHEN event_type_id IN( 2,28 )
              THEN EVENT_ATTR_29
            END CELL_IDENTITY
          ,(
            CASE
              WHEN( event_type_id IN( 1,20 )
                AND event_attr_9!   ='0' )
                OR( event_type_id  IN( 2,28 )
                AND event_attr_9!   ='MO' )
              THEN event_attr_11
              ELSE event_attr_10
            END ) CALL_TO_TN
          , CASE
              WHEN event_type_id IN( 1,2)
              THEN regexp_replace( event_attr_33,'(.*)\,.*','\1' )
            END CALL_TO_PLACE
          , CASE
              WHEN event_type_id IN( 1,2)
              THEN regexp_replace( event_attr_33,'.*\,(.*)','\1' )
            END CALL_TO_REGION
          , EVENT_ATTR_8 OUTGOING_CELL_TRUNK_ID
          , EVENT_ATTR_7 INCOMING_TRUNK_ID
          , CASE
              WHEN event_type_id IN( 1,20 )
              THEN EVENT_ATTR_35  /60
              WHEN event_type_id IN( 2,28 )
              THEN decode(instr(event_attr_4,':'),0,to_number(event_attr_4), to_number( TO_CHAR( to_date( event_attr_4,'hh24:mi:ss' ),'sssss' ) )) 
            END ANSWER_TIME_DUR_ROUND_MIN
          , CASE
          WHEN event_attr_4 like '%:%' THEN to_number( TO_CHAR( to_date( event_attr_4,'hh24:mi:ss' ),'sssss' ) )
        ELSE to_number(event_attr_4)
      END ANSWER_TIME_CALL_DUR_SEC
          ,(
            CASE
              WHEN event_type_id IN( 3,21 )
              THEN event_attr_27  /(FACTOR*100)
              WHEN event_type_id IN( 2,28 )
              THEN event_attr_26  /factor
              WHEN event_type_id IN( 1,20 )
              THEN event_attr_34  /(FACTOR*100)
              ELSE event_attr_24  /factor
            END ) AIR_RATE
          , CASE
              WHEN event_type_id IN( 1,20 )
              THEN EVENT_ATTR_27  /FACTOR
              WHEN event_type_id IN( 2,28 )
              THEN EVENT_COST_MNY /FACTOR
            END AIR_CHARGE_AMOUNT
          ,(
            CASE
              WHEN event_type_id              =3
                AND to_number( event_attr_20 )>=8
              THEN to_number( event_attr_20 )
              WHEN event_type_id IN( 1,3 )
              THEN DECODE( on_network_flag,'Y',1,2 )
              WHEN event_type_id = 21
                AND event_attr_20 ='3'
                AND cet0.account_num   ='ACC000140'
              THEN 7
              WHEN event_type_id IN( 20,21 )
              THEN 3
              WHEN event_type_id =2
              THEN DECODE( event_attr_20,'0',4,'1',5,'2',6,4 )
              WHEN event_type_id =4
              THEN DECODE( lower( event_attr_15 ),'h',4,'d',5,'i',6,4 )
        WHEN event_type_id =28
        THEN 6
              ELSE 0
            END ) AIR_CHARGE_CODE
          ,(
            CASE
              WHEN event_attr_35/60<=0
              THEN NULL
              WHEN lower( event_attr_30 ) LIKE '%directory assistance%'
              THEN event_attr_24 /factor
              WHEN event_attr_24 /factor>0
              THEN( event_attr_24/factor )/( event_attr_35/60 )
              ELSE 0
            END ) TOLL_RATE
          , NVL((EVENT_ATTR_24/FACTOR),0) TOLL_CHARGE_AMOUNT
          ,(
            CASE
              WHEN NVL( event_attr_24,'0' )='0'
              THEN NULL -- this MUST be first condition
              WHEN lower( event_attr_30 ) LIKE '%long distance%'
              THEN DECODE( ON_NETWORK_FLAG,'Y',1,2 )
              WHEN lower( event_attr_30 ) LIKE '%directory assistance%'
              THEN DECODE( ON_NETWORK_FLAG,'Y',5,6 )
              WHEN lower( event_attr_30 ) LIKE '%international%'
              THEN DECODE( ON_NETWORK_FLAG,'Y',4,3 )
              ELSE -1
            END ) TOLL_CHARGE_CODE
          , ON_NETWORK_FLAG ON_NETWORK_FLAG
          ,(
            CASE
              WHEN( event_type_id IN( 1,20 )
                AND event_attr_9!   ='0' )
                OR( event_type_id  IN( 2,28 )
                AND event_attr_9!   ='MO' )
              THEN 1
              ELSE 0
            END ) CALL_DIRECTION
          , EVENT_ATTR_16 TRANSLATED_NUMBER
          , CASE
              WHEN event_type_id IN( 20 )
              THEN EVENT_ATTR_19
              WHEN event_type_id IN( 28 )
              THEN EVENT_ATTR_18
            END PLMN_CODE
          , CASE
              WHEN event_type_id IN( 20,28 )
              THEN regexp_replace(
                CASE
                  WHEN event_type_id IN( 3,21 )
                    AND event_attr_28 LIKE 'Int%'
                  THEN event_attr_28
                  WHEN event_type_id IN( 1,20 )
                    AND event_attr_30 LIKE 'Int%'
                  THEN event_attr_30
                  WHEN event_type_id IN( 2,28 )
                    AND event_attr_27 LIKE 'Int%'
                  THEN event_attr_27
                END,'Int.*\-\s*(.*)','\1' )
            END COUNTRY_NAME
			, SUBSTR(EVENT_ATTR_38, 1, 1) ||
			decode(SUBSTR(EVENT_ATTR_38, 2, 2),
              '0A',
              '10',
              '0B',
              '11',
              '0C',
              '12',
              '0D',
              '13',
              '0E',
              '14',
              SUBSTR(EVENT_ATTR_38, 2, 2)) ||':'|| SUBSTR(EVENT_ATTR_38, 4, 2) UTC_OFFSET
            ,DECODE( cet0.event_type_id, 1, cet0.event_attr_34/(FACTOR*100), 20, cet0.event_attr_34/(FACTOR*100), 2, cet0.event_attr_26/(FACTOR), 3, cet0.event_attr_27/(FACTOR*100), 21, cet0.event_attr_27/(FACTOR*100), 4, cet0.event_attr_24/(FACTOR), 28, cet0.event_attr_26/(FACTOR)) CHARGING_RATE
      ,NVL(CASE
      WHEN cet0.account_num ='ACC000132'
      AND cet0.event_type_id=4
      THEN DECODE(cet0.event_attr_13,'Tran',cet0.event_attr_26
        ||' - Transit', cet0.event_attr_26
        ||' - '
        ||cet0.event_attr_25)
      ELSE DECODE( cet0.event_type_id, 1, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 20, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 4, cet0.event_attr_26 )
      END,
      DECODE( cet0.event_type_id, 3, cet0.event_attr_28, 21, cet0.event_attr_28, 28, cet0.event_attr_27, 4, cet0.event_attr_10, 2, NVL(cet0.event_attr_27,'SMS') )) COST_BAND
      ,DECODE( cet0.event_type_id, 1, decode(cet0.ACCOUNT_NUM||'|'||EVENT_ATTR_31||'|'||EVENT_ATTR_39, 'ACC000134|Standard MT-LM2LM|F','Standard', EVENT_ATTR_31), 20, cet0.event_attr_31, 2, cet0.event_attr_28, 3, cet0.event_attr_26, 21, cet0.event_attr_26, 28, cet0.event_attr_28, 'NULL' ) EVENT_CLASS
      ,CASE
      WHEN cet0.event_type_id = 3
      THEN cet0.event_attr_30
      ELSE NULL
      END DISCOUNT_NAME
      ,DECODE(cet0.event_type_id,4,cet0.event_attr_14,DECODE(cet0.event_attr_22, 'UNKNOWN','',cet0.event_attr_22)) TECH_TYPE
      ,event_attr_44 BILLING_TARIFF_NAME
      ,event_attr_45 TOMS_TLO_ID
    ,NVL(event_attr_46,'None') SUBSCRIBER_TYPE
      ,EVENT_REF
    ,CREATED_DTM
   ,(SELECT duf.duf_filename
        FROM TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS duf
        WHERE duf.first_event_created_dtm <= cet0.CREATED_DTM
        AND duf.last_event_created_dtm     >= cet0.CREATED_DTM
         AND duf.account_num = cet0.account_num 
         AND duf.event_seq = cet0.event_seq 
         AND event_type = 'VOICE' 
         AND rownum<2) DUF_FILENAME
          FROM cet0
          join acct on  ( cet0.account_num = acct.account_num 
          and cet0.event_seq = acct.event_seq )
          LEFT OUTER JOIN pkg USING( event_attr_44,event_attr_45 )) CET
on (m2m_voice.account_number = cet.account_number and m2m_voice.sequence_number = cet.sequence_number
and m2m_voice.record_type = cet.record_type and m2m_voice.msisdn = cet.msisdn and m2m_voice.EVENT_REF = cet.EVENT_REF)
WHEN NOT MATCHED THEN
INSERT 
(
     PARTNER_TYPE
    ,RECORD_TYPE
    ,ACCOUNT_NUMBER
    ,SEQUENCE_NUMBER
    ,IMSI
    ,MSISDN
    ,CHANNEL_SEIZURE_DT
    ,SWITCH_ID
    ,IMEI
    ,HOME_SID
    ,SERVE_SID
    ,CELL_IDENTITY
    ,CALL_TO_TN
    ,CALL_TO_PLACE
    ,CALL_TO_REGION
    ,OUTGOING_CELL_TRUNK_ID
    ,INCOMING_TRUNK_ID
    ,ANSWER_TIME_DUR_ROUND_MIN
    ,ANSWER_TIME_CALL_DUR_SEC
    ,AIR_RATE
    ,AIR_CHARGE_AMOUNT
    ,AIR_CHARGE_CODE
    ,TOLL_RATE
    ,TOLL_CHARGE_AMOUNT
    ,TOLL_CHARGE_CODE
    ,ON_NETWORK_FLAG
    ,CALL_DIRECTION
    ,TRANSLATED_NUMBER
    ,PLMN_CODE
    ,COUNTRY_NAME
	,UTC_OFFSET
    ,CHARGING_RATE
    ,COST_BAND
    ,EVENT_CLASS
    ,DISCOUNT_NAME
    ,TECH_TYPE
    ,BILLING_TARIFF_NAME
    ,TOMS_TLO_ID
  ,SUBSCRIBER_TYPE
    ,EVENT_REF
    ,CREATED_DTM
    ,DUF_FILENAME)
 VALUES
 (
     'M2M' 
    ,CET.RECORD_TYPE
    ,CET.ACCOUNT_NUMBER
    ,CET.SEQUENCE_NUMBER
    ,CET.IMSI
    ,CET.MSISDN
    ,CET.CHANNEL_SEIZURE_DT
    ,CET.SWITCH_ID
    ,CET.IMEI
    ,CET.HOME_SID
    ,CET.SERVE_SID
    ,CET.CELL_IDENTITY
    ,CET.CALL_TO_TN
    ,CET.CALL_TO_PLACE
    ,CET.CALL_TO_REGION
    ,CET.OUTGOING_CELL_TRUNK_ID
    ,CET.INCOMING_TRUNK_ID
    ,CET.ANSWER_TIME_DUR_ROUND_MIN
    ,CET.ANSWER_TIME_CALL_DUR_SEC
    ,CET.AIR_RATE
    ,CET.AIR_CHARGE_AMOUNT
    ,CET.AIR_CHARGE_CODE
    ,CET.TOLL_RATE
    ,CET.TOLL_CHARGE_AMOUNT
    ,CET.TOLL_CHARGE_CODE
    ,CET.ON_NETWORK_FLAG
    ,CET.CALL_DIRECTION
    ,CET.TRANSLATED_NUMBER
    ,CET.PLMN_CODE
    ,CET.COUNTRY_NAME
	,CET.UTC_OFFSET
    ,CET.CHARGING_RATE
    ,CET.COST_BAND
    ,CET.EVENT_CLASS
    ,CET.DISCOUNT_NAME
    ,CET.TECH_TYPE
    ,CET.BILLING_TARIFF_NAME
    ,CET.TOMS_TLO_ID
    ,CET.SUBSCRIBER_TYPE
    ,CET.EVENT_REF
    ,CET.CREATED_DTM
    ,CET.DUF_FILENAME) ;
      commit;
END load_m2m_voice;


PROCEDURE load_m2m_data(
    p_account_num  VARCHAR,
    p_event_seq    NUMBER,
    p_event_type_id NUMBER,
    p_billing_acct_nbr VARCHAR,
    p_event_source VARCHAR )
AS
BEGIN
-- merge the data from costedevent0 table into duf_m2m_data table if records not matched-----
MERGE INTO genevabatchuser.duf_m2m_data m2m_data
 USING
      (
      WITH cet0 AS
          (
            SELECT  ce0.*
              ,10000*NVL(power(10, loyalty_points),NVL(to_number( SUBSTR( regexp_substr( event_attr_43,'\|\s*(\d*)\s*$' ),2 ) ),1 )) factor
              ,CASE
                  WHEN event_type_id IN( 3 )
                    AND lower( event_attr_26 ) LIKE '%standard%'
                  THEN 'Y'
                  WHEN event_type_id IN( 1 )
                    AND event_attr_13 IN( '0','4' )
                  THEN 'Y'
                  WHEN event_type_id IN( 2 )
                    AND event_attr_20  = 0
                  THEN 'Y'
                  ELSE 'N'
                END on_network_flag
              FROM costedevent0 ce0
             WHERE account_num   =p_account_num
                AND event_seq      =p_event_seq
                AND event_type_id =p_event_type_id
                AND event_source   =p_event_source
          )
        ,tam AS
          (
            SELECT  billing_acct_nbr
              ,rating_acct_nbr account_num
              ,uf_format
              FROM tmo_acct_mapping
			  WHERE rating_acct_nbr = p_account_num
          )
        ,acct AS
          (
            SELECT  billing_acct_nbr
              ,account_num
              ,event_seq
              ,bill_dtm
              ,uf_format
              FROM
                (
                  SELECT  billing_acct_nbr
                    ,tam.account_num
                    ,bs.event_seq
                    ,TO_CHAR( bs.bill_dtm,'YYYYMMDD' ) bill_dtm
                    ,tam.uf_format
                    FROM billsummary bs
                    , tam 
                    WHERE bs.account_num = tam.billing_acct_nbr
                    AND bs.bill_status in (1,7,8)
                  UNION
                  SELECT  billing_acct_nbr
                    ,account_num
                    ,bill_event_seq
                    ,TO_CHAR( next_bill_dtm,'YYYYMMDD' )
                    ,tam.uf_format
                    FROM ACCOUNT A
                    JOIN tam USING( account_num )
                )
              ORDER BY 1,2
          )
        ,toms AS
          (
            SELECT  object_id event_attr_45
              ,object_name
              FROM tmobile_custom.toms_offernamemapping_last
          )
        ,pkg AS
          (
          select tomsobjid event_attr_45, tariff_name event_attr_44,plan_name package_name from tmobile_custom.GenPlanNameMapView
          )
        SELECT  EVENT_TYPE_ID RECORD_TYPE
          , BILLING_ACCT_NBR ACCOUNT_NUMBER
          , cet0.EVENT_SEQ SEQUENCE_NUMBER
          , EVENT_ATTR_1 IMSI
          , EVENT_ATTR_12 MSISDN
          , CASE 
			  WHEN EVENT_ATTR_41 is null
			  THEN EVENT_DTM 
			  ELSE
			   to_date(EVENT_ATTR_41, 'MM/DD/YYYY HH12:MI:SS')
			END RECORD_START_TIME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_9
            END ACCESS_POINT_NAME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_2
            END IMEI
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_13
            END HOME_SID
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_14
            END SERVE_SID
          , EVENT_ATTR_39 SERVED_PDP_ADDRESS
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_15
            END CELL_IDENTITY
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_16
            END LOCATION_AREA_CODE
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN(
                CASE
                  WHEN event_type_id NOT IN( 3,21 )
                  THEN 0
                  WHEN acct.uf_format ='Var'
                  THEN to_number( event_attr_6 )
                  ELSE ROUND((event_attr_6 /( 1024*1024 )),3)
                END )
              WHEN event_type_id IN( 4 )
              THEN to_number( EVENT_ATTR_3 )
            END TOTAL_VOLUME
          ,decode(instr(event_attr_4,':'),0,event_attr_4, to_number( TO_CHAR( to_date( event_attr_4,'hh24:mi:ss' ),'sssss' ) )) DURATION
          , '' DATA_DESCRIPTION
          ,(
            CASE
              WHEN event_type_id              =3
                AND to_number( event_attr_20 )>=8
              THEN to_number( event_attr_20 )
              WHEN event_type_id IN( 1,3 )
              THEN DECODE( on_network_flag,'Y',1,2 )
              WHEN event_type_id = 21
                AND event_attr_20 ='3'
                AND cet0.account_num   ='ACC000140'
              THEN 7
              WHEN event_type_id IN( 20,21 )
              THEN 3
              WHEN event_type_id =2
              THEN DECODE( event_attr_20,'0',4,'1',5,'2',6,4 )
              WHEN event_type_id =4
              THEN DECODE( lower( event_attr_15 ),'h',4,'d',5,'i',6,4 )
              ELSE 0
            END ) DATA_CHARGE_CODE
          ,(
            CASE
              WHEN event_type_id IN( 3,21 )
              THEN event_attr_27  /(factor *100)
              WHEN event_type_id IN( 2,28 )
              THEN event_attr_26  /factor
              WHEN event_type_id IN( 1,20 )
              THEN event_attr_34  /(factor *100)
              ELSE event_attr_24  /factor
            END ) DATA_RATE
          , EVENT_COST_MNY/FACTOR DATA_CHARGE_AMOUNT
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN ON_NETWORK_FLAG
            END ON_NETWORK_FLAG
          , CASE
              WHEN event_type_id IN( 4 )
              THEN EVENT_ATTR_25
            END MMS_TYPE_INDICATOR
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_8
              WHEN event_type_id IN( 4 )
              THEN EVENT_ATTR_6
            END CALLED_NUMBER_URL
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_3
            END UPLINK_VOLUME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_5
            END DOWNLINK_VOLUME
          , CASE
              WHEN event_type_id IN( 21 )
              THEN EVENT_ATTR_18
            END PLMN_CODE
          , CASE
              WHEN event_type_id IN( 21 )
              THEN regexp_replace(
                CASE
                  WHEN event_type_id IN( 3,21 )
                    AND event_attr_28 LIKE 'Int%'
                  THEN event_attr_28
                  WHEN event_type_id IN( 1,20 )
                    AND event_attr_30 LIKE 'Int%'
                  THEN event_attr_30
                  WHEN event_type_id IN( 2,28 )
                    AND event_attr_27 LIKE 'Int%'
                  THEN event_attr_27
                END,'Int.*\-\s*(.*)','\1' )
            END COUNTRY_NAME
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_23
            END GGSN_ADDRESS
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_31
            END CHARGING_ID
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_17
            END CAUSE_FOR_CLOSE
          , CASE
              WHEN event_type_id IN( 3,21 )
              THEN EVENT_ATTR_10
              WHEN event_type_id IN( 4 )
              THEN ''
            END RECORDING_ENTITY
			, SUBSTR(EVENT_ATTR_38, 1, 1) ||
			decode(SUBSTR(EVENT_ATTR_38, 2, 2),
              '0A',
              '10',
              '0B',
              '11',
              '0C',
              '12',
              '0D',
              '13',
              '0E',
              '14',
              SUBSTR(EVENT_ATTR_38, 2, 2)) ||':'|| SUBSTR(EVENT_ATTR_38, 4, 2) UTC_OFFSET
            ,DECODE( cet0.event_type_id, 1, cet0.event_attr_34/(FACTOR*100), 20, cet0.event_attr_34/(FACTOR*100), 2, cet0.event_attr_26/(FACTOR), 3, cet0.event_attr_27/(FACTOR*100), 21, cet0.event_attr_27/(FACTOR*100), 4, cet0.event_attr_24/(FACTOR), 28, cet0.event_attr_26/(FACTOR)) CHARGING_RATE
      ,NVL(CASE
      WHEN cet0.account_num ='ACC000132'
      AND cet0.event_type_id=4
      THEN DECODE(cet0.event_attr_13,'Tran',cet0.event_attr_26
        ||' - Transit', cet0.event_attr_26
        ||' - '
        ||cet0.event_attr_25)
      ELSE DECODE( cet0.event_type_id, 1, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 20, DECODE( cet0.event_attr_30, 'Airtime', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), 'Long Distance', cet0.event_attr_30
        || '-'
        || NVL( cet0.event_attr_29,'Intrastate' ), cet0.event_attr_30 ), 4, cet0.event_attr_26 )
      END,
      DECODE( cet0.event_type_id, 3, cet0.event_attr_28, 21, cet0.event_attr_28, 28, cet0.event_attr_27, 4, cet0.event_attr_10, 2, NVL(cet0.event_attr_27,'SMS') )) COST_BAND
      ,DECODE( cet0.event_type_id, 1, decode(cet0.ACCOUNT_NUM||'|'||EVENT_ATTR_31||'|'||EVENT_ATTR_39, 'ACC000134|Standard MT-LM2LM|F','Standard', EVENT_ATTR_31), 20, cet0.event_attr_31, 2, cet0.event_attr_28, 3, cet0.event_attr_26, 21, cet0.event_attr_26, 28, cet0.event_attr_28, 'NULL' ) EVENT_CLASS
      ,CASE
      WHEN cet0.event_type_id = 3
      THEN cet0.event_attr_30
      ELSE NULL
      END DISCOUNT_NAME
      ,DECODE(cet0.event_type_id,4,cet0.event_attr_14,DECODE(cet0.event_attr_22, 'UNKNOWN','',cet0.event_attr_22)) TECH_TYPE
      ,event_attr_44 BILLING_TARIFF_NAME
      ,event_attr_45 TOMS_TLO_ID
    ,NVL(event_attr_46,'None') SUBSCRIBER_TYPE
      ,EVENT_REF
    ,CREATED_DTM
    ,(SELECT duf.duf_filename
        FROM TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS duf
        WHERE duf.first_event_created_dtm <= cet0.CREATED_DTM
        AND duf.last_event_created_dtm     >= cet0.CREATED_DTM
         AND duf.account_num = cet0.account_num 
         AND duf.event_seq = cet0.event_seq 
         AND event_type = 'DATA' 
         AND rownum<2) DUF_FILENAME
          FROM cet0
         join acct on  ( cet0.account_num = acct.account_num 
          and cet0.event_seq = acct.event_seq )
          LEFT OUTER JOIN pkg USING( event_attr_44,event_attr_45 )) CET
on (m2m_data.account_number = cet.account_number and m2m_data.sequence_number = cet.sequence_number
and m2m_data.record_type = cet.record_type and m2m_data.msisdn = cet.msisdn and m2m_data.EVENT_REF = cet.EVENT_REF)
WHEN NOT MATCHED THEN 
INSERT
(
    PARTNER_TYPE 
    ,RECORD_TYPE
    ,ACCOUNT_NUMBER
    ,SEQUENCE_NUMBER
    ,IMSI
    ,MSISDN
    ,RECORD_START_TIME
    ,ACCESS_POINT_NAME
    ,IMEI
    ,HOME_SID
    ,SERVE_SID
    ,SERVED_PDP_ADDRESS
    ,CELL_IDENTITY
    ,LOCATION_AREA_CODE
    ,TOTAL_VOLUME
    ,DURATION
    ,DATA_DESCRIPTION
    ,DATA_CHARGE_CODE
    ,DATA_RATE
    ,DATA_CHARGE_AMOUNT
    ,ON_NETWORK_FLAG
    ,MMS_TYPE_INDICATOR
    ,CALLED_NUMBER_URL
    ,UPLINK_VOLUME
    ,DOWNLINK_VOLUME
    ,PLMN_CODE
    ,COUNTRY_NAME
    ,GGSN_ADDRESS
    ,CHARGING_ID
    ,CAUSE_FOR_CLOSE
    ,RECORDING_ENTITY
	,UTC_OFFSET
    ,CHARGING_RATE
    ,COST_BAND
    ,EVENT_CLASS
    ,DISCOUNT_NAME
    ,TECH_TYPE
    ,BILLING_TARIFF_NAME
    ,TOMS_TLO_ID
  ,SUBSCRIBER_TYPE
    ,EVENT_REF
    ,CREATED_DTM
    ,DUF_FILENAME)
 VALUES
 (
     'M2M'
    ,CET.RECORD_TYPE
    ,CET.ACCOUNT_NUMBER
    ,CET.SEQUENCE_NUMBER
    ,CET.IMSI
    ,CET.MSISDN
    ,CET.RECORD_START_TIME
    ,CET.ACCESS_POINT_NAME
    ,CET.IMEI
    ,CET.HOME_SID
    ,CET.SERVE_SID
    ,CET.SERVED_PDP_ADDRESS
    ,CET.CELL_IDENTITY
    ,CET.LOCATION_AREA_CODE
    ,CET.TOTAL_VOLUME
    ,CET.DURATION
    ,CET.DATA_DESCRIPTION
    ,CET.DATA_CHARGE_CODE
    ,CET.DATA_RATE
    ,CET.DATA_CHARGE_AMOUNT
    ,CET.ON_NETWORK_FLAG
    ,CET.MMS_TYPE_INDICATOR
    ,CET.CALLED_NUMBER_URL
    ,CET.UPLINK_VOLUME
    ,CET.DOWNLINK_VOLUME
    ,CET.PLMN_CODE
    ,CET.COUNTRY_NAME
    ,CET.GGSN_ADDRESS
    ,CET.CHARGING_ID
    ,CET.CAUSE_FOR_CLOSE
    ,CET.RECORDING_ENTITY
	,CET.UTC_OFFSET
    ,CET.CHARGING_RATE
    ,CET.COST_BAND
    ,CET.EVENT_CLASS
    ,CET.DISCOUNT_NAME
    ,CET.TECH_TYPE
    ,CET.BILLING_TARIFF_NAME
    ,CET.TOMS_TLO_ID
    ,CET.SUBSCRIBER_TYPE
    ,CET.EVENT_REF
    ,CET.CREATED_DTM
    ,CET.DUF_FILENAME);
      commit;
END load_m2m_data;


END tmo_invdrilldown;

/

Grant execute on TMOBILE_CUSTOM.TMO_INVDRILLDOWN to geneva_admin,UNIF_ADMIN;