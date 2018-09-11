 --------------------------------------------------------
--  DDL for Table DUF_M2M_DATA
--------------------------------------------------------
BEGIN
  execute immediate 'DROP TABLE DUF_M2M_DATA';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
create table genevabatchuser.DUF_M2M_DATA
(
  RECORD_TYPE         NUMBER(9),
  ACCOUNT_NUMBER      VARCHAR2(20),
  SEQUENCE_NUMBER     NUMBER(9),
  IMSI                VARCHAR2(40),
  MSISDN              VARCHAR2(40),
  RECORD_START_TIME   DATE,
  ACCESS_POINT_NAME   VARCHAR2(40),
  IMEI                VARCHAR2(40),
  HOME_SID            VARCHAR2(40),
  SERVE_SID           VARCHAR2(40),
  SERVED_PDP_ADDRESS  VARCHAR2(40),
  CELL_IDENTITY       VARCHAR2(40),
  LOCATION_AREA_CODE  VARCHAR2(40),
  TOTAL_VOLUME        VARCHAR2(40),
  DURATION            VARCHAR2(40),
  DATA_DESCRIPTION    VARCHAR2(40),
  DATA_CHARGE_CODE    NUMBER(2),
  DATA_RATE           NUMBER(10,6),
  DATA_CHARGE_AMOUNT  NUMBER(10,6),
  ON_NETWORK_FLAG     VARCHAR2(1),
  MMS_TYPE_INDICATOR  VARCHAR2(40),
  CALLED_NUMBER_URL   VARCHAR2(40),
  UPLINK_VOLUME       VARCHAR2(40),
  DOWNLINK_VOLUME     VARCHAR2(40),
  PLMN_CODE           VARCHAR2(40),
  COUNTRY_NAME        VARCHAR2(40),
  GGSN_ADDRESS        VARCHAR2(40),
  CHARGING_ID         VARCHAR2(40),
  CAUSE_FOR_CLOSE     VARCHAR2(40),
  RECORDING_ENTITY    VARCHAR2(40),
  CHARGING_RATE       NUMBER,
  COST_BAND           VARCHAR2(100),
  EVENT_CLASS         VARCHAR2(40),
  DISCOUNT_NAME       VARCHAR2(40),
  TECH_TYPE           VARCHAR2(40),
  BILLING_TARIFF_NAME VARCHAR2(40),
  TOMS_TLO_ID         VARCHAR2(40),
  PARTNER_TYPE        VARCHAR2(20),
  EVENT_REF           VARCHAR2(16),
  CREATED_DTM         DATE,
  CONSTRAINT  duf_m2m_data_pk PRIMARY KEY (account_number,sequence_number,msisdn,record_type,event_ref)
) TABLESPACE "USERS";
  
  --------------------------------------------------------
--  DDL for Table DUF_M2M_VOICE
--------------------------------------------------------

BEGIN
  execute immediate 'DROP TABLE DUF_M2M_VOICE';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/  


create table genevabatchuser.DUF_M2M_VOICE
(
  RECORD_TYPE               NUMBER(9),
  ACCOUNT_NUMBER            VARCHAR2(20),
  SEQUENCE_NUMBER           NUMBER(9),
  IMSI                      VARCHAR2(40),
  MSISDN                    VARCHAR2(40),
  CHANNEL_SEIZURE_DT        DATE,
  SWITCH_ID                 VARCHAR2(40),
  IMEI                      VARCHAR2(40),
  HOME_SID                  VARCHAR2(40),
  SERVE_SID                 VARCHAR2(40),
  CELL_IDENTITY             VARCHAR2(40),
  CALL_TO_TN                VARCHAR2(40),
  CALL_TO_PLACE             VARCHAR2(40),
  CALL_TO_REGION            VARCHAR2(40),
  OUTGOING_CELL_TRUNK_ID    VARCHAR2(40),
  INCOMING_TRUNK_ID         VARCHAR2(40),
  ANSWER_TIME_DUR_ROUND_MIN VARCHAR2(40),
  ANSWER_TIME_CALL_DUR_SEC  VARCHAR2(40),
  AIR_RATE                  NUMBER(10,6),
  AIR_CHARGE_AMOUNT         NUMBER(10,6),
  AIR_CHARGE_CODE           NUMBER(2),
  TOLL_RATE                 NUMBER(10,6),
  TOLL_CHARGE_AMOUNT        NUMBER(10,6),
  TOLL_CHARGE_CODE          NUMBER(2),
  ON_NETWORK_FLAG           VARCHAR2(1),
  CALL_DIRECTION            NUMBER(2),
  TRANSLATED_NUMBER         VARCHAR2(40),
  PLMN_CODE                 VARCHAR2(40),
  COUNTRY_NAME              VARCHAR2(40),
  CHARGING_RATE             NUMBER,
  COST_BAND                 VARCHAR2(100),
  EVENT_CLASS               VARCHAR2(40),
  DISCOUNT_NAME             VARCHAR2(40),
  TECH_TYPE                 VARCHAR2(40),
  BILLING_TARIFF_NAME       VARCHAR2(40),
  TOMS_TLO_ID               VARCHAR2(40),
  PARTNER_TYPE              VARCHAR2(20),
  EVENT_REF                 VARCHAR2(16),
  CREATED_DTM               DATE,
  CONSTRAINT  duf_m2m_voice_pk PRIMARY KEY (account_number,sequence_number,msisdn,record_type,event_ref)
)  TABLESPACE "USERS";

--------------------------------------------------------
--  DDL for Table DUF_MVNO_DATA
--------------------------------------------------------

BEGIN
  execute immediate 'DROP TABLE DUF_MVNO_DATA';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
 create table genevabatchuser.DUF_MVNO_DATA
(
  RECORD_TYPE         NUMBER(9),
  ACCOUNT_NUMBER      VARCHAR2(20),
  SEQUENCE_NUMBER     NUMBER(9),
  IMSI                VARCHAR2(40),
  MSISDN              VARCHAR2(40),
  RECORD_START_TIME   DATE,
  ACCESS_POINT_NAME   VARCHAR2(40),
  IMEI                VARCHAR2(40),
  HOME_SID            VARCHAR2(40),
  SERVE_SID           VARCHAR2(40),
  SERVED_PDP_ADDRESS  VARCHAR2(40),
  CELL_IDENTITY       VARCHAR2(40),
  LOCATION_AREA_CODE  VARCHAR2(40),
  TOTAL_VOLUME        VARCHAR2(40),
  DURATION            VARCHAR2(40),
  DATA_DESCRIPTION    VARCHAR2(40),
  DATA_CHARGE_CODE    NUMBER(2),
  DATA_RATE           NUMBER(10,6),
  DATA_CHARGE_AMOUNT  NUMBER(10,6),
  ON_NETWORK_FLAG     VARCHAR2(1),
  MMS_TYPE_INDICATOR  VARCHAR2(40),
  CALLED_NUMBER_URL   VARCHAR2(40),
  UPLINK_VOLUME       VARCHAR2(40),
  DOWNLINK_VOLUME     VARCHAR2(40),
  PACKAGE_NAME        VARCHAR2(100),
  BILL_DATE           DATE,
  PLMN_CODE           VARCHAR2(40),
  COUNTRY_NAME        VARCHAR2(40),
  RECORDING_ENTITY    VARCHAR2(40),
  TECHNOLOGY_USED     VARCHAR2(40),
  UTC_OFFSET          VARCHAR2(40),
  CHARGING_RATE       NUMBER,
  COST_BAND           VARCHAR2(100),
  EVENT_CLASS         VARCHAR2(40),
  DISCOUNT_NAME       VARCHAR2(40),
  TECH_TYPE           VARCHAR2(40),
  BILLING_TARIFF_NAME VARCHAR2(40),
  TOMS_TLO_ID         VARCHAR2(40),
  PARTNER_TYPE        VARCHAR2(20),
  EVENT_REF           VARCHAR2(16),
  CREATED_DTM         DATE,
  CONSTRAINT duf_mvno_data_pk PRIMARY KEY (account_number,sequence_number,msisdn,record_type,event_ref)
) TABLESPACE "USERS";
   
   --------------------------------------------------------
--  DDL for Table DUF_MVNO_VOICE
--------------------------------------------------------

BEGIN
  execute immediate 'DROP TABLE DUF_MVNO_VOICE';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
 create table genevabatchuser.DUF_MVNO_VOICE
(
  RECORD_TYPE               NUMBER(9),
  ACCOUNT_NUMBER            VARCHAR2(20),
  SEQUENCE_NUMBER           NUMBER(9),
  IMSI                      VARCHAR2(40),
  MSISDN                    VARCHAR2(40),
  CHANNEL_SEIZURE_DT        DATE,
  SWITCH_ID                 VARCHAR2(40),
  IMEI                      VARCHAR2(40),
  HOME_SID                  VARCHAR2(40),
  SERVE_SID                 VARCHAR2(40),
  CELL_IDENTITY             VARCHAR2(40),
  CALL_TO_TN                VARCHAR2(40),
  CALL_TO_PLACE             VARCHAR2(200),
  CALL_TO_REGION            VARCHAR2(200),
  OUTGOING_CELL_TRUNK_ID    VARCHAR2(40),
  INCOMING_TRUNK_ID         VARCHAR2(40),
  ANSWER_TIME_DUR_ROUND_MIN VARCHAR2(40),
  ANSWER_TIME_CALL_DUR_SEC  VARCHAR2(40),
  AIR_RATE                  NUMBER(10,6),
  AIR_CHARGE_AMOUNT         NUMBER(10,6),
  AIR_CHARGE_CODE           NUMBER(2),
  TOLL_RATE                 NUMBER(10,6),
  TOLL_CHARGE_AMOUNT        NUMBER(10,6),
  TOLL_CHARGE_CODE          NUMBER(2),
  ON_NETWORK_FLAG           VARCHAR2(1),
  CALL_DIRECTION            NUMBER(2),
  TRANSLATED_NUMBER         VARCHAR2(40),
  PACKAGE_NAME              VARCHAR2(100),
  BILL_DATE                 DATE,
  PLMN_CODE                 VARCHAR2(40),
  COUNTRY_NAME              VARCHAR2(200),
  TECHNOLOGY_USED           VARCHAR2(40),
  UTC_OFFSET                VARCHAR2(40),
  CHARGING_RATE             NUMBER,
  COST_BAND                 VARCHAR2(100),
  EVENT_CLASS               VARCHAR2(40),
  DISCOUNT_NAME             VARCHAR2(40),
  TECH_TYPE                 VARCHAR2(40),
  BILLING_TARIFF_NAME       VARCHAR2(40),
  TOMS_TLO_ID               VARCHAR2(40),
  PARTNER_TYPE              VARCHAR2(20),
  EVENT_REF                 VARCHAR2(16),
  CREATED_DTM               DATE,
  CONSTRAINT  duf_mvno_voice_pk PRIMARY KEY (account_number,sequence_number,msisdn,record_type,event_ref) 
) TABLESPACE "USERS";


grant all on genevabatchuser.duf_mvno_voice to TMOBILE_CUSTOM;
grant all on genevabatchuser.duf_mvno_voice to UNIF_ADMIN;
grant all on genevabatchuser.duf_mvno_voice to GENEVA_ADMIN;

grant all on genevabatchuser.duf_m2m_data to TMOBILE_CUSTOM;
grant all on genevabatchuser.duf_m2m_data to UNIF_ADMIN;
grant all on genevabatchuser.duf_m2m_data to GENEVA_ADMIN;

grant all on genevabatchuser.duf_m2m_voice to TMOBILE_CUSTOM;
grant all on genevabatchuser.duf_m2m_voice to UNIF_ADMIN;
grant all on genevabatchuser.duf_m2m_voice to GENEVA_ADMIN;

grant all on genevabatchuser.duf_mvno_data to TMOBILE_CUSTOM;
grant all on genevabatchuser.duf_mvno_data to UNIF_ADMIN;
grant all on genevabatchuser.duf_mvno_data to GENEVA_ADMIN;


--------------------------------------------------------
--  DDL for Index DUF_M2M_DATA_IND
--------------------------------------------------------
	CREATE INDEX GENEVABATCHUSER.DUF_MVNO_VOICE_IND ON GENEVABATCHUSER.DUF_MVNO_VOICE (RECORD_TYPE, ACCOUNT_NUMBER, SEQUENCE_NUMBER, MSISDN);
	CREATE INDEX GENEVABATCHUSER.DUF_MVNO_DATA_IND ON GENEVABATCHUSER.DUF_MVNO_DATA (RECORD_TYPE, ACCOUNT_NUMBER, SEQUENCE_NUMBER, MSISDN);


	CREATE INDEX GENEVABATCHUSER.DUF_M2M_VOICE_IND ON GENEVABATCHUSER.DUF_M2M_VOICE (RECORD_TYPE, ACCOUNT_NUMBER, SEQUENCE_NUMBER, MSISDN);
	CREATE INDEX GENEVABATCHUSER.DUF_M2M_DATA_IND ON GENEVABATCHUSER.DUF_M2M_DATA (RECORD_TYPE, ACCOUNT_NUMBER, SEQUENCE_NUMBER, MSISDN);
