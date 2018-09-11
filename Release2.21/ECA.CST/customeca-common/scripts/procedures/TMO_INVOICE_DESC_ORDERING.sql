BEGIN
  execute immediate 'DROP TABLE TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING';
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

CREATE TABLE TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING 
  (
  EVENT_SUMMARY_ID     NUMBER(9) not null,
  COST_BAND_DESC       VARCHAR2(255),
  EVENT_CLASS_NAME     VARCHAR2(40),
  ORDER_NUM            NUMBER(9) not null,
  DESCRIPTION          VARCHAR(255)
  ) TABLESPACE "USERS";
REM INSERTING into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING
SET DEFINE OFF;  
insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Airtime%', 'Standard', 100, 'Airtime');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Long Distance%', 'Standard', 100, 'Airtime');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Airtime%', 'Standard ILD', 110, 'Airtime ILD');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Long Distance%', 'Standard HR-ILD', 135, 'Airtime - International Long Distance');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Airtime%', 'Standard HR-ILD', 135, 'Airtime - International Long Distance');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Airtime%', 'Standard MT-LM2LM', 145, 'Airtime - LM+ to LM+ MT MOU');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Long Distance%', 'Standard MT-LM2LM', 145, 'Airtime - LM+ to LM+ MT MOU');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Airtime%', 'Roaming', 150, 'Airtime - Roaming');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Long Distance%', 'Roaming', 150, 'Airtime - Roaming');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (78, 'Directory Assistance', 'Standard', 190, 'Directory Assistance');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bosnia Herzegovina', 'Standard', 200, 'Airtime - Intl Roaming - Bosnia Herzegovina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Romania', 'Standard', 200, 'Airtime - Intl Roaming - Romania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Czech Republic', 'Standard', 200, 'Airtime - Intl Roaming - Czech Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Estonia', 'Standard', 200, 'Airtime - Intl Roaming - Estonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Portugal', 'Standard', 200, 'Airtime - Intl Roaming - Portugal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Iceland', 'Standard', 200, 'Airtime - Intl Roaming - Iceland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Georgia', 'Standard', 200, 'Airtime - Intl Roaming - Georgia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Turkey', 'Standard', 200, 'Airtime - Intl Roaming - Turkey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Caribbean', 'Standard', 200, 'Airtime - Intl Roaming - Caribbean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cayman', 'Standard', 200, 'Airtime - Intl Roaming - Cayman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bermuda', 'Standard', 200, 'Airtime - Intl Roaming - Bermuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - St. Lucia', 'Standard', 200, 'Airtime - Intl Roaming - St. Lucia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Haiti', 'Standard', 200, 'Airtime - Intl Roaming - Haiti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Azerbaijan', 'Standard', 200, 'Airtime - Intl Roaming - Azerbaijan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Iraq', 'Standard', 200, 'Airtime - Intl Roaming - Iraq');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Korea', 'Standard', 200, 'Airtime - Intl Roaming - Korea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bangladesh', 'Standard', 200, 'Airtime - Intl Roaming - Bangladesh');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Egypt', 'Standard', 200, 'Airtime - Intl Roaming - Egypt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Tunisia', 'Standard', 200, 'Airtime - Intl Roaming - Tunisia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mauritel', 'Standard', 200, 'Airtime - Intl Roaming - Mauritel');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mali', 'Standard', 200, 'Airtime - Intl Roaming - Mali');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Togo', 'Standard', 200, 'Airtime - Intl Roaming - Togo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Liberia', 'Standard', 200, 'Airtime - Intl Roaming - Liberia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Seychelles', 'Standard', 200, 'Airtime - Intl Roaming - Seychelles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guatemala', 'Standard', 200, 'Airtime - Intl Roaming - Guatemala');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Argentina', 'Standard', 200, 'Airtime - Intl Roaming - Argentina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Colombia', 'Standard', 200, 'Airtime - Intl Roaming - Colombia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Paraguay', 'Standard', 200, 'Airtime - Intl Roaming - Paraguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Norway (MCP)', 'Standard', 200, 'Airtime - Intl Roaming - Norway (MCP)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cayman Islands', 'Standard', 200, 'Airtime - Intl Roaming - Cayman Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - US Virgin Islands', 'Standard', 200, 'Airtime - Intl Roaming - US Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Afghanistan', 'Standard', 200, 'Airtime - Intl Roaming - Afghanistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-American Samoa', 'Standard', 200, 'Airtime - Intl Roaming - American Samoa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Azerbaijan', 'Standard', 200, 'Airtime - Intl Roaming - Azerbaijan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cayman Islands', 'Standard', 200, 'Airtime - Intl Roaming - Cayman Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Croatia', 'Standard', 200, 'Airtime - Intl Roaming - Croatia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-East Timor', 'Standard', 200, 'Airtime - Intl Roaming - East Timor');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ecuador', 'Standard', 200, 'Airtime - Intl Roaming - Ecuador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-El Salvador', 'Standard', 200, 'Airtime - Intl Roaming - El Salvador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Equatorial Guinea', 'Standard', 200, 'Airtime - Intl Roaming - Equatorial Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Finland', 'Standard', 200, 'Airtime - Intl Roaming - Finland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Germany', 'Standard', 200, 'Airtime - Intl Roaming - Germany');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Global Mobile Sat Systems ', 'Standard', 200, 'Airtime - Intl Roaming - Global Mobile Sat Systems (gmss)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guadeloupe', 'Standard', 200, 'Airtime - Intl Roaming - Guadeloupe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Hungary', 'Standard', 200, 'Airtime - Intl Roaming - Hungary');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Inmarsat', 'Standard', 200, 'Airtime - Intl Roaming - Inmarsat');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Kyrgyz Republic', 'Standard', 200, 'Airtime - Intl Roaming - Kyrgyz Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mauritania', 'Standard', 200, 'Airtime - Intl Roaming - Mauritania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mauritius', 'Standard', 200, 'Airtime - Intl Roaming - Mauritius');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Myanmar', 'Standard', 200, 'Airtime - Intl Roaming - Myanmar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Poland', 'Standard', 200, 'Airtime - Intl Roaming - Poland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Russia', 'Standard', 200, 'Airtime - Intl Roaming - Russia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Rwanda', 'Standard', 200, 'Airtime - Intl Roaming - Rwanda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-South Africa', 'Standard', 200, 'Airtime - Intl Roaming - South Africa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Suriname', 'Standard', 200, 'Airtime - Intl Roaming - Suriname');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tonga', 'Standard', 200, 'Airtime - Intl Roaming - Tonga');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tunisia', 'Standard', 200, 'Airtime - Intl Roaming - Tunisia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Turkey', 'Standard', 200, 'Airtime - Intl Roaming - Turkey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Turkmenistan', 'Standard', 200, 'Airtime - Intl Roaming - Turkmenistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-United Kingdom', 'Standard', 200, 'Airtime - Intl Roaming - United Kingdom');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Uzbekistan', 'Standard', 200, 'Airtime - Intl Roaming - Uzbekistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Scotland', 'Standard', 200, 'Airtime - Intl Roaming - Scotland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'Inernational-St. Barthelemy', 'Standard', 200, 'Airtime - Inl Roaming - St. Barthelemy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - United Kingdom', 'Standard', 200, 'Airtime - Intl Roaming - United Kingdom');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Finland', 'Standard', 200, 'Airtime - Intl Roaming - Finland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Lithuania', 'Standard', 200, 'Airtime - Intl Roaming - Lithuania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Belarus', 'Standard', 200, 'Airtime - Intl Roaming - Belarus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Moldavia', 'Standard', 200, 'Airtime - Intl Roaming - Moldavia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Albania', 'Standard', 200, 'Airtime - Intl Roaming - Albania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Greenland', 'Standard', 200, 'Airtime - Intl Roaming - Greenland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Liechtenstein', 'Standard', 200, 'Airtime - Intl Roaming - Liechtenstein');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - French West Indies', 'Standard', 200, 'Airtime - Intl Roaming - French West Indies');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Monseratt', 'Standard', 200, 'Airtime - Intl Roaming - Monseratt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Aruba', 'Standard', 200, 'Airtime - Intl Roaming - Aruba');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Kazakhstan', 'Standard', 200, 'Airtime - Intl Roaming - Kazakhstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bhutan', 'Standard', 200, 'Airtime - Intl Roaming - Bhutan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - India', 'Standard', 200, 'Airtime - Intl Roaming - India');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Sri Lanka', 'Standard', 200, 'Airtime - Intl Roaming - Sri Lanka');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Jordan', 'Standard', 200, 'Airtime - Intl Roaming - Jordan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Yemen', 'Standard', 200, 'Airtime - Intl Roaming - Yemen');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - United Arab Emirates', 'Standard', 200, 'Airtime - Intl Roaming - United Arab Emirates');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Israel', 'Standard', 200, 'Airtime - Intl Roaming - Israel');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Turkmenistan', 'Standard', 200, 'Airtime - Intl Roaming - Turkmenistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Laos', 'Standard', 200, 'Airtime - Intl Roaming - Laos');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - French Polynesia', 'Standard', 200, 'Airtime - Intl Roaming - French Polynesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Algeria', 'Standard', 200, 'Airtime - Intl Roaming - Algeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Morocco', 'Standard', 200, 'Airtime - Intl Roaming - Morocco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Burkina Faso', 'Standard', 200, 'Airtime - Intl Roaming - Burkina Faso');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Sierra Leone', 'Standard', 200, 'Airtime - Intl Roaming - Sierra Leone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Angola', 'Standard', 200, 'Airtime - Intl Roaming - Angola');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Zimbabwe', 'Standard', 200, 'Airtime - Intl Roaming - Zimbabwe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bolivia', 'Standard', 200, 'Airtime - Intl Roaming - Bolivia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Uruguay', 'Standard', 200, 'Airtime - Intl Roaming - Uruguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cd Juarez', 'Standard', 200, 'Airtime - Intl Roaming - Cd Juarez');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Papua New Guinea', 'Standard', 200, 'Airtime - Intl Roaming - Papua New Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Saipan', 'Standard', 200, 'Airtime - Intl Roaming - Saipan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Barbados', 'Standard', 200, 'Airtime - Intl Roaming - Barbados');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Jersey', 'Standard', 200, 'Airtime - Intl Roaming - Jersey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ascension Island', 'Standard', 200, 'Airtime - Intl Roaming - Ascension Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Australia', 'Standard', 200, 'Airtime - Intl Roaming - Australia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bosnia Herzegovina', 'Standard', 200, 'Airtime - Intl Roaming - Bosnia Herzegovina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cameroon', 'Standard', 200, 'Airtime - Intl Roaming - Cameroon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-China', 'Standard', 200, 'Airtime - Intl Roaming - China');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Diego Garcia', 'Standard', 200, 'Airtime - Intl Roaming - Diego Garcia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Djibouti', 'Standard', 200, 'Airtime - Intl Roaming - Djibouti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ethiopia', 'Standard', 200, 'Airtime - Intl Roaming - Ethiopia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-French Guiana', 'Standard', 200, 'Airtime - Intl Roaming - French Guiana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Haiti', 'Standard', 200, 'Airtime - Intl Roaming - Haiti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Intl Ntwk', 'Standard', 200, 'Airtime - Intl Roaming - Intl Ntwk');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Jamaica', 'Standard', 200, 'Airtime - Intl Roaming - Jamaica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Lebanon', 'Standard', 200, 'Airtime - Intl Roaming - Lebanon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Lithuania', 'Standard', 200, 'Airtime - Intl Roaming - Lithuania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Madagascar', 'Standard', 200, 'Airtime - Intl Roaming - Madagascar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Moldova', 'Standard', 200, 'Airtime - Intl Roaming - Moldova');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Namibia', 'Standard', 200, 'Airtime - Intl Roaming - Namibia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Nepal', 'Standard', 200, 'Airtime - Intl Roaming - Nepal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Niue', 'Standard', 200, 'Airtime - Intl Roaming - Niue');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Pacific Ocean', 'Standard', 200, 'Airtime - Intl Roaming - Pacific Ocean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Reunion Island', 'Standard', 200, 'Airtime - Intl Roaming - Reunion Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Slovenia', 'Standard', 200, 'Airtime - Intl Roaming - Slovenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Solomon Island', 'Standard', 200, 'Airtime - Intl Roaming - Solomon Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Spain', 'Standard', 200, 'Airtime - Intl Roaming - Spain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-St. Pierre and Miquelon', 'Standard', 200, 'Airtime - Intl Roaming - St. Pierre and Miquelon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sudan', 'Standard', 200, 'Airtime - Intl Roaming - Sudan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Thailand', 'Standard', 200, 'Airtime - Intl Roaming - Thailand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Trinidad and Tobago', 'Standard', 200, 'Airtime - Intl Roaming - Trinidad and Tobago');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Belgium', 'Standard', 200, 'Airtime - Intl Roaming - Belgium');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Christmas Island', 'Standard', 200, 'Airtime - Intl Roaming - Christmas Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-England', 'Standard', 200, 'Airtime - Intl Roaming - England');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Spain', 'Standard', 200, 'Airtime - Intl Roaming - Spain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Montenegro', 'Standard', 200, 'Airtime - Intl Roaming - Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - St. Pierre and Miquelon', 'Standard', 200, 'Airtime - Intl Roaming - St. Pierre and Miquelon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Dutch Antille', 'Standard', 200, 'Airtime - Intl Roaming - Dutch Antille');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Antilles', 'Standard', 200, 'Airtime - Intl Roaming - Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Anguilla', 'Standard', 200, 'Airtime - Intl Roaming - Anguilla');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Saudi Arabia', 'Standard', 200, 'Airtime - Intl Roaming - Saudi Arabia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Hong Kong', 'Standard', 200, 'Airtime - Intl Roaming - Hong Kong');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Taiwan', 'Standard', 200, 'Airtime - Intl Roaming - Taiwan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - New Caledonia', 'Standard', 200, 'Airtime - Intl Roaming - New Caledonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Benin', 'Standard', 200, 'Airtime - Intl Roaming - Benin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ghana', 'Standard', 200, 'Airtime - Intl Roaming - Ghana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Nigeria', 'Standard', 200, 'Airtime - Intl Roaming - Nigeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Congo DR', 'Standard', 200, 'Airtime - Intl Roaming - Congo DR');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Rwanda', 'Standard', 200, 'Airtime - Intl Roaming - Rwanda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Reunion', 'Standard', 200, 'Airtime - Intl Roaming - Reunion');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Namibia', 'Standard', 200, 'Airtime - Intl Roaming - Namibia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Malawi', 'Standard', 200, 'Airtime - Intl Roaming - Malawi');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Lesotho', 'Standard', 200, 'Airtime - Intl Roaming - Lesotho');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Honduras', 'Standard', 200, 'Airtime - Intl Roaming - Honduras');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Nicaragua', 'Standard', 200, 'Airtime - Intl Roaming - Nicaragua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Peru', 'Standard', 200, 'Airtime - Intl Roaming - Peru');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Italy Maritime', 'Standard', 200, 'Airtime - Intl Roaming - Italy Maritime');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mauritania', 'Standard', 200, 'Airtime - Intl Roaming - Mauritania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Northern Mariana Islands', 'Standard', 200, 'Airtime - Intl Roaming - Northern Mariana Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bosnia-herzegovina', 'Standard', 200, 'Airtime - Intl Roaming - Bosnia-herzegovina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Tonga', 'Standard', 200, 'Airtime - Intl Roaming - Tonga');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Slovakia', 'Standard', 200, 'Airtime - Intl Roaming - Slovakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Moldova', 'Standard', 200, 'Airtime - Intl Roaming - Moldova');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Russian Federation', 'Standard', 200, 'Airtime - Intl Roaming - Russian Federation');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - UK Maritime Svc', 'Standard', 200, 'Airtime - Intl Roaming - UK Maritime Svc');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Algeria', 'Standard', 200, 'Airtime - Intl Roaming - Algeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Andorra', 'Standard', 200, 'Airtime - Intl Roaming - Andorra');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Antarctica', 'Standard', 200, 'Airtime - Intl Roaming - Antarctica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bangladesh', 'Standard', 200, 'Airtime - Intl Roaming - Bangladesh');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Belarus', 'Standard', 200, 'Airtime - Intl Roaming - Belarus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-British Virgin Islands', 'Standard', 200, 'Airtime - Intl Roaming - British Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Chile', 'Standard', 200, 'Airtime - Intl Roaming - Chile');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Colombia', 'Standard', 200, 'Airtime - Intl Roaming - Colombia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Congo', 'Standard', 200, 'Airtime - Intl Roaming - Congo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cuba', 'Standard', 200, 'Airtime - Intl Roaming - Cuba');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cuba-not Guantanamo', 'Standard', 200, 'Airtime - Intl Roaming - Cuba-not Guantanamo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cyprus', 'Standard', 200, 'Airtime - Intl Roaming - Cyprus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Congo DR', 'Standard', 200, 'Airtime - Intl Roaming - Congo DR');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Eritrea', 'Standard', 200, 'Airtime - Intl Roaming - Eritrea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Estonia', 'Standard', 200, 'Airtime - Intl Roaming - Estonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Fr Guiana', 'Standard', 200, 'Airtime - Intl Roaming - Fr Guiana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Georgia', 'Standard', 200, 'Airtime - Intl Roaming - Georgia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Gibraltar', 'Standard', 200, 'Airtime - Intl Roaming - Gibraltar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Grenada', 'Standard', 200, 'Airtime - Intl Roaming - Grenada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guinea Bissau', 'Standard', 200, 'Airtime - Intl Roaming - Guinea Bissau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Iceland', 'Standard', 200, 'Airtime - Intl Roaming - Iceland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Japan', 'Standard', 200, 'Airtime - Intl Roaming - Japan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Jordan', 'Standard', 200, 'Airtime - Intl Roaming - Jordan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Kenya', 'Standard', 200, 'Airtime - Intl Roaming - Kenya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Kiribati Republic', 'Standard', 200, 'Airtime - Intl Roaming - Kiribati Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Macedonia', 'Standard', 200, 'Airtime - Intl Roaming - Macedonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mongolia', 'Standard', 200, 'Airtime - Intl Roaming - Mongolia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Morocco', 'Standard', 200, 'Airtime - Intl Roaming - Morocco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Netherlands', 'Standard', 200, 'Airtime - Intl Roaming - Netherlands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-New Zealand', 'Standard', 200, 'Airtime - Intl Roaming - New Zealand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Vatican City', 'Standard', 200, 'Airtime - Intl Roaming - Vatican City');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Panama', 'Standard', 200, 'Airtime - Intl Roaming - Panama');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Papua New Guinea', 'Standard', 200, 'Airtime - Intl Roaming - Papua New Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Puerto Rico', 'Standard', 200, 'Airtime - Intl Roaming - Puerto Rico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sao Tome & Principe', 'Standard', 200, 'Airtime - Intl Roaming - Sao Tome & Principe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Senegal', 'Standard', 200, 'Airtime - Intl Roaming - Senegal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Switzerland', 'Standard', 200, 'Airtime - Intl Roaming - Switzerland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Togo', 'Standard', 200, 'Airtime - Intl Roaming - Togo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Easter Island', 'Standard', 200, 'Airtime - Intl Roaming - Easter Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-St. Martin', 'Standard', 200, 'Airtime - Intl Roaming - St. Martin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Serbia and Montenegro', 'Standard', 200, 'Airtime - Intl Roaming - Serbia and Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Austria', 'Standard', 200, 'Airtime - Intl Roaming - Austria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Denmark', 'Standard', 200, 'Airtime - Intl Roaming - Denmark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Norway', 'Standard', 200, 'Airtime - Intl Roaming - Norway');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Dna Finland Ltd.', 'Standard', 200, 'Airtime - Intl Roaming - Dna Finland Ltd.');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Macedonia', 'Standard', 200, 'Airtime - Intl Roaming - Macedonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Uk', 'Standard', 200, 'Airtime - Intl Roaming - Uk');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Jamaica', 'Standard', 200, 'Airtime - Intl Roaming - Jamaica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Grenada', 'Standard', 200, 'Airtime - Intl Roaming - Grenada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - St. Kitts and Nevis', 'Standard', 200, 'Airtime - Intl Roaming - St. Kitts and Nevis');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Afghanistan', 'Standard', 200, 'Airtime - Intl Roaming - Afghanistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Kuwait', 'Standard', 200, 'Airtime - Intl Roaming - Kuwait');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Oman', 'Standard', 200, 'Airtime - Intl Roaming - Oman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Nepal', 'Standard', 200, 'Airtime - Intl Roaming - Nepal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Kyrgyzstan', 'Standard', 200, 'Airtime - Intl Roaming - Kyrgyzstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - China', 'Standard', 200, 'Airtime - Intl Roaming - China');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Philippines', 'Standard', 200, 'Airtime - Intl Roaming - Philippines');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Thailand', 'Standard', 200, 'Airtime - Intl Roaming - Thailand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Gambia', 'Standard', 200, 'Airtime - Intl Roaming - Gambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ivory Coast', 'Standard', 200, 'Airtime - Intl Roaming - Ivory Coast');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mauritius', 'Standard', 200, 'Airtime - Intl Roaming - Mauritius');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Chad', 'Standard', 200, 'Airtime - Intl Roaming - Chad');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Uganda', 'Standard', 200, 'Airtime - Intl Roaming - Uganda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Botswana', 'Standard', 200, 'Airtime - Intl Roaming - Botswana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - South Africa', 'Standard', 200, 'Airtime - Intl Roaming - South Africa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Alands Islands', 'Standard', 200, 'Airtime - Intl Roaming - Alands Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ascension Island', 'Standard', 200, 'Airtime - Intl Roaming - Ascension Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Central African Republic', 'Standard', 200, 'Airtime - Intl Roaming - Central African Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Serbia', 'Standard', 200, 'Airtime - Intl Roaming - Serbia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guernsey', 'Standard', 200, 'Airtime - Intl Roaming - Guernsey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Isle of Man', 'Standard', 200, 'Airtime - Intl Roaming - Isle of Man');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - French Guiana', 'Standard', 200, 'Airtime - Intl Roaming - French Guiana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - United States', 'Standard', 200, 'Airtime - Intl Roaming - United States');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'Airtime', 'Standard', 200, 'Airtime - Airtime');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Anguilla', 'Standard', 200, 'Airtime - Intl Roaming - Anguilla');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Barbados', 'Standard', 200, 'Airtime - Intl Roaming - Barbados');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Botswana', 'Standard', 200, 'Airtime - Intl Roaming - Botswana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Burundi', 'Standard', 200, 'Airtime - Intl Roaming - Burundi');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cape Verde', 'Standard', 200, 'Airtime - Intl Roaming - Cape Verde');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Central African Republic', 'Standard', 200, 'Airtime - Intl Roaming - Central African Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Comoros', 'Standard', 200, 'Airtime - Intl Roaming - Comoros');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Czech Republic', 'Standard', 200, 'Airtime - Intl Roaming - Czech Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-East Atlantic Ocean', 'Standard', 200, 'Airtime - Intl Roaming - East Atlantic Ocean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Falkland Island', 'Standard', 200, 'Airtime - Intl Roaming - Falkland Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Gambia', 'Standard', 200, 'Airtime - Intl Roaming - Gambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guatemala', 'Standard', 200, 'Airtime - Intl Roaming - Guatemala');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-India', 'Standard', 200, 'Airtime - Intl Roaming - India');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-International Neworks Shar', 'Standard', 200, 'Airtime - Intl Roaming - International Neworks Shared Code');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Latvia', 'Standard', 200, 'Airtime - Intl Roaming - Latvia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Lesotho', 'Standard', 200, 'Airtime - Intl Roaming - Lesotho');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Macao', 'Standard', 200, 'Airtime - Intl Roaming - Macao');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Malawi', 'Standard', 200, 'Airtime - Intl Roaming - Malawi');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mali', 'Standard', 200, 'Airtime - Intl Roaming - Mali');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-New Caledonia', 'Standard', 200, 'Airtime - Intl Roaming - New Caledonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tuvalu', 'Standard', 200, 'Airtime - Intl Roaming - Tuvalu');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Qatar', 'Standard', 200, 'Airtime - Intl Roaming - Qatar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sierra Leone', 'Standard', 200, 'Airtime - Intl Roaming - Sierra Leone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Slovak Republic', 'Standard', 200, 'Airtime - Intl Roaming - Slovak Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Somali Dem Republic', 'Standard', 200, 'Airtime - Intl Roaming - Somali Dem Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Somali Republic', 'Standard', 200, 'Airtime - Intl Roaming - Somali Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Swaziland', 'Standard', 200, 'Airtime - Intl Roaming - Swaziland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Taiwan', 'Standard', 200, 'Airtime - Intl Roaming - Taiwan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tajikistan', 'Standard', 200, 'Airtime - Intl Roaming - Tajikistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Telecom Svc (up1)', 'Standard', 200, 'Airtime - Intl Roaming - Telecom Svc (up1)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Uruguay', 'Standard', 200, 'Airtime - Intl Roaming - Uruguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Wales', 'Standard', 200, 'Airtime - Intl Roaming - Wales');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - France', 'Standard', 200, 'Airtime - Intl Roaming - France');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Croatia', 'Standard', 200, 'Airtime - Intl Roaming - Croatia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Sweden', 'Standard', 200, 'Airtime - Intl Roaming - Sweden');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Latvia', 'Standard', 200, 'Airtime - Intl Roaming - Latvia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guam', 'Standard', 200, 'Airtime - Intl Roaming - Guam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mexico', 'Standard', 200, 'Airtime - Intl Roaming - Mexico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guadeloupe', 'Standard', 200, 'Airtime - Intl Roaming - Guadeloupe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Antigua and Barbuda', 'Standard', 200, 'Airtime - Intl Roaming - Antigua and Barbuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Qatar', 'Standard', 200, 'Airtime - Intl Roaming - Qatar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Uzbekistan', 'Standard', 200, 'Airtime - Intl Roaming - Uzbekistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Tajikstan', 'Standard', 200, 'Airtime - Intl Roaming - Tajikstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Malaysia', 'Standard', 200, 'Airtime - Intl Roaming - Malaysia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Singapore', 'Standard', 200, 'Airtime - Intl Roaming - Singapore');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cook Islands', 'Standard', 200, 'Airtime - Intl Roaming - Cook Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Senegal', 'Standard', 200, 'Airtime - Intl Roaming - Senegal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Dem Rep Of Congo', 'Standard', 200, 'Airtime - Intl Roaming - Dem Rep Of Congo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Madagascar', 'Standard', 200, 'Airtime - Intl Roaming - Madagascar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ecuador', 'Standard', 200, 'Airtime - Intl Roaming - Ecuador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Suriname', 'Standard', 200, 'Airtime - Intl Roaming - Suriname');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cape Verde', 'Standard', 200, 'Airtime - Intl Roaming - Cape Verde');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guinea', 'Standard', 200, 'Airtime - Intl Roaming - Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Libya', 'Standard', 200, 'Airtime - Intl Roaming - Libya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bonaire', 'Standard', 200, 'Airtime - Intl Roaming - Bonaire');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Broadpoint', 'Standard', 200, 'Airtime - Intl Roaming - Broadpoint');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guinea Bissau', 'Standard', 200, 'Airtime - Intl Roaming - Guinea Bissau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Dutch St. Maarten', 'Standard', 200, 'Airtime - Intl Roaming - Dutch St. Maarten');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Antigua', 'Standard', 200, 'Airtime - Intl Roaming - Antigua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Argentina', 'Standard', 200, 'Airtime - Intl Roaming - Argentina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Aruba', 'Standard', 200, 'Airtime - Intl Roaming - Aruba');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Belgium', 'Standard', 200, 'Airtime - Intl Roaming - Belgium');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Belize', 'Standard', 200, 'Airtime - Intl Roaming - Belize');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bermuda', 'Standard', 200, 'Airtime - Intl Roaming - Bermuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Brazil', 'Standard', 200, 'Airtime - Intl Roaming - Brazil');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Burkina Faso', 'Standard', 200, 'Airtime - Intl Roaming - Burkina Faso');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Egypt', 'Standard', 200, 'Airtime - Intl Roaming - Egypt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Faroe Islands', 'Standard', 200, 'Airtime - Intl Roaming - Faroe Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-France', 'Standard', 200, 'Airtime - Intl Roaming - France');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-French Polynesia', 'Standard', 200, 'Airtime - Intl Roaming - French Polynesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Gabon', 'Standard', 200, 'Airtime - Intl Roaming - Gabon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Great Britain', 'Standard', 200, 'Airtime - Intl Roaming - Great Britain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Greenland', 'Standard', 200, 'Airtime - Intl Roaming - Greenland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guam', 'Standard', 200, 'Airtime - Intl Roaming - Guam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Honduras', 'Standard', 200, 'Airtime - Intl Roaming - Honduras');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Iran', 'Standard', 200, 'Airtime - Intl Roaming - Iran');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ivory Coast', 'Standard', 200, 'Airtime - Intl Roaming - Ivory Coast');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Kuwait', 'Standard', 200, 'Airtime - Intl Roaming - Kuwait');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Kyrgyzstan', 'Standard', 200, 'Airtime - Intl Roaming - Kyrgyzstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Liechtenstein', 'Standard', 200, 'Airtime - Intl Roaming - Liechtenstein');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Maldives', 'Standard', 200, 'Airtime - Intl Roaming - Maldives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mozambique', 'Standard', 200, 'Airtime - Intl Roaming - Mozambique');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Niger', 'Standard', 200, 'Airtime - Intl Roaming - Niger');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Niue Island', 'Standard', 200, 'Airtime - Intl Roaming - Niue Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-North Korea', 'Standard', 200, 'Airtime - Intl Roaming - North Korea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Nrflk/antarctica/aet', 'Standard', 200, 'Airtime - Intl Roaming - Nrflk/antarctica/aet');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Palau', 'Standard', 200, 'Airtime - Intl Roaming - Palau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Palestine', 'Standard', 200, 'Airtime - Intl Roaming - Palestine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Paraguay', 'Standard', 200, 'Airtime - Intl Roaming - Paraguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Reunion', 'Standard', 200, 'Airtime - Intl Roaming - Reunion');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Saudi Arabia', 'Standard', 200, 'Airtime - Intl Roaming - Saudi Arabia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-St. Kitts and Nevis', 'Standard', 200, 'Airtime - Intl Roaming - St. Kitts and Nevis');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tahiti', 'Standard', 200, 'Airtime - Intl Roaming - Tahiti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tanzania', 'Standard', 200, 'Airtime - Intl Roaming - Tanzania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Uganda', 'Standard', 200, 'Airtime - Intl Roaming - Uganda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ukraine', 'Standard', 200, 'Airtime - Intl Roaming - Ukraine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-US Virgin Islands', 'Standard', 200, 'Airtime - Intl Roaming - US Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Wallis & Futuna Islands', 'Standard', 200, 'Airtime - Intl Roaming - Wallis & Futuna Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Western Samoa', 'Standard', 200, 'Airtime - Intl Roaming - Western Samoa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Zimbabwe', 'Standard', 200, 'Airtime - Intl Roaming - Zimbabwe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Svalbard', 'Standard', 200, 'Airtime - Intl Roaming - Svalbard');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ukraine', 'Standard', 200, 'Airtime - Intl Roaming - Ukraine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Luxembourg', 'Standard', 200, 'Airtime - Intl Roaming - Luxembourg');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bulgaria', 'Standard', 200, 'Airtime - Intl Roaming - Bulgaria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Slovenia', 'Standard', 200, 'Airtime - Intl Roaming - Slovenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - St. Vincent and Grenadin', 'Standard', 200, 'Airtime - Intl Roaming - St. Vincent and Grenadin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bahamas', 'Standard', 200, 'Airtime - Intl Roaming - Bahamas');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Dominican Republic', 'Standard', 200, 'Airtime - Intl Roaming - Dominican Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Turks and Caicos Islands', 'Standard', 200, 'Airtime - Intl Roaming - Turks and Caicos Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bahrain', 'Standard', 200, 'Airtime - Intl Roaming - Bahrain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mongolia', 'Standard', 200, 'Airtime - Intl Roaming - Mongolia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Vietnam', 'Standard', 200, 'Airtime - Intl Roaming - Vietnam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Maldives', 'Standard', 200, 'Airtime - Intl Roaming - Maldives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Australia', 'Standard', 200, 'Airtime - Intl Roaming - Australia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Indonesia', 'Standard', 200, 'Airtime - Intl Roaming - Indonesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Brunei', 'Standard', 200, 'Airtime - Intl Roaming - Brunei');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - New Zealand', 'Standard', 200, 'Airtime - Intl Roaming - New Zealand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Fiji', 'Standard', 200, 'Airtime - Intl Roaming - Fiji');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cote D''Ivoire', 'Standard', 200, 'Airtime - Intl Roaming - Cote D''Ivoire');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cameroon', 'Standard', 200, 'Airtime - Intl Roaming - Cameroon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Gabon', 'Standard', 200, 'Airtime - Intl Roaming - Gabon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Kenya', 'Standard', 200, 'Airtime - Intl Roaming - Kenya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Mozambique', 'Standard', 200, 'Airtime - Intl Roaming - Mozambique');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - El Salvador', 'Standard', 200, 'Airtime - Intl Roaming - El Salvador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Costa Rica', 'Standard', 200, 'Airtime - Intl Roaming - Costa Rica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Chile', 'Standard', 200, 'Airtime - Intl Roaming - Chile');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Venezuela', 'Standard', 200, 'Airtime - Intl Roaming - Venezuela');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Guyana', 'Standard', 200, 'Airtime - Intl Roaming - Guyana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - JAMDC', 'Standard', 200, 'Airtime - Intl Roaming - JAMDC');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Vanuatu', 'Standard', 200, 'Airtime - Intl Roaming - Vanuatu');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Libyan Arab Jamahiriya', 'Standard', 200, 'Airtime - Intl Roaming - Libyan Arab Jamahiriya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Curacao', 'Standard', 200, 'Airtime - Intl Roaming - Curacao');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Great Britain', 'Standard', 200, 'Airtime - Intl Roaming - Great Britain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Monaco', 'Standard', 200, 'Airtime - Intl Roaming - Monaco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Default Country', 'Standard', 200, 'Airtime - Intl Roaming - Default Country');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Micronesia', 'Standard', 200, 'Airtime - Intl Roaming - Micronesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bhutan', 'Standard', 200, 'Airtime - Intl Roaming - Bhutan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bulgaria', 'Standard', 200, 'Airtime - Intl Roaming - Bulgaria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Chad', 'Standard', 200, 'Airtime - Intl Roaming - Chad');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Curacao', 'Standard', 200, 'Airtime - Intl Roaming - Curacao');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Dominica', 'Standard', 200, 'Airtime - Intl Roaming - Dominica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-French Antille', 'Standard', 200, 'Airtime - Intl Roaming - French Antille');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Hong Kong', 'Standard', 200, 'Airtime - Intl Roaming - Hong Kong');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Indonesia', 'Standard', 200, 'Airtime - Intl Roaming - Indonesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Italy', 'Standard', 200, 'Airtime - Intl Roaming - Italy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Korea South', 'Standard', 200, 'Airtime - Intl Roaming - Korea South');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Luxembourg', 'Standard', 200, 'Airtime - Intl Roaming - Luxembourg');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Nigeria', 'Standard', 200, 'Airtime - Intl Roaming - Nigeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Maritime Mobile Service', 'Standard', 200, 'Airtime - Intl Roaming - Maritime Mobile Service');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mexico Mobile', 'Standard', 200, 'Airtime - Intl Roaming - Mexico Mobile');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Mexico', 'Standard', 200, 'Airtime - Intl Roaming - Mexico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Micronesia', 'Standard', 200, 'Airtime - Intl Roaming - Micronesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Nauru', 'Standard', 200, 'Airtime - Intl Roaming - Nauru');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Romania', 'Standard', 200, 'Airtime - Intl Roaming - Romania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sao Tome', 'Standard', 200, 'Airtime - Intl Roaming - Sao Tome');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Satellite Call', 'Standard', 200, 'Airtime - Intl Roaming - Satellite Call');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Serbia', 'Standard', 200, 'Airtime - Intl Roaming - Serbia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Slovakia', 'Standard', 200, 'Airtime - Intl Roaming - Slovakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sri Lanka', 'Standard', 200, 'Airtime - Intl Roaming - Sri Lanka');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Turks and Caicos Islands', 'Standard', 200, 'Airtime - Intl Roaming - Turks and Caicos Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-United Arab Emirates', 'Standard', 200, 'Airtime - Intl Roaming - United Arab Emirates');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Zambia', 'Standard', 200, 'Airtime - Intl Roaming - Zambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Greece', 'Standard', 200, 'Airtime - Intl Roaming - Greece');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Netherlands', 'Standard', 200, 'Airtime - Intl Roaming - Netherlands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Andorra', 'Standard', 200, 'Airtime - Intl Roaming - Andorra');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Hungary', 'Standard', 200, 'Airtime - Intl Roaming - Hungary');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Italy', 'Standard', 200, 'Airtime - Intl Roaming - Italy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Slovak Republic', 'Standard', 200, 'Airtime - Intl Roaming - Slovak Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Poland', 'Standard', 200, 'Airtime - Intl Roaming - Poland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ireland', 'Standard', 200, 'Airtime - Intl Roaming - Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cyprus', 'Standard', 200, 'Airtime - Intl Roaming - Cyprus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Faroe Islands', 'Standard', 200, 'Airtime - Intl Roaming - Faroe Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Antigua', 'Standard', 200, 'Airtime - Intl Roaming - Antigua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Dominica', 'Standard', 200, 'Airtime - Intl Roaming - Dominica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Pakistan', 'Standard', 200, 'Airtime - Intl Roaming - Pakistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Lebanon', 'Standard', 200, 'Airtime - Intl Roaming - Lebanon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Palestine', 'Standard', 200, 'Airtime - Intl Roaming - Palestine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Japan', 'Standard', 200, 'Airtime - Intl Roaming - Japan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Macau', 'Standard', 200, 'Airtime - Intl Roaming - Macau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cambodia', 'Standard', 200, 'Airtime - Intl Roaming - Cambodia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Niger', 'Standard', 200, 'Airtime - Intl Roaming - Niger');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Equatorial Guinea', 'Standard', 200, 'Airtime - Intl Roaming - Equatorial Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Ethiopia', 'Standard', 200, 'Airtime - Intl Roaming - Ethiopia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Djibouti', 'Standard', 200, 'Airtime - Intl Roaming - Djibouti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Belize', 'Standard', 200, 'Airtime - Intl Roaming - Belize');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Panama', 'Standard', 200, 'Airtime - Intl Roaming - Panama');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Samoa', 'Standard', 200, 'Airtime - Intl Roaming - Samoa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - MaIdives', 'Standard', 200, 'Airtime - Intl Roaming - MaIdives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Solavakia', 'Standard', 200, 'Airtime - Intl Roaming - Solavakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Puerto Rico', 'Standard', 200, 'Airtime - Intl Roaming - Puerto Rico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Albania', 'Standard', 200, 'Airtime - Intl Roaming - Albania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bahamas', 'Standard', 200, 'Airtime - Intl Roaming - Bahamas');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bahrain', 'Standard', 200, 'Airtime - Intl Roaming - Bahrain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Benin', 'Standard', 200, 'Airtime - Intl Roaming - Benin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Bolivia', 'Standard', 200, 'Airtime - Intl Roaming - Bolivia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Brunei Darussalam', 'Standard', 200, 'Airtime - Intl Roaming - Brunei Darussalam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cambodia', 'Standard', 200, 'Airtime - Intl Roaming - Cambodia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Cook Islands', 'Standard', 200, 'Airtime - Intl Roaming - Cook Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Denmark', 'Standard', 200, 'Airtime - Intl Roaming - Denmark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Fr Antilles/martinique', 'Standard', 200, 'Airtime - Intl Roaming - Fr Antilles/martinique');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ghana', 'Standard', 200, 'Airtime - Intl Roaming - Ghana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Greece', 'Standard', 200, 'Airtime - Intl Roaming - Greece');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guinea Republic', 'Standard', 200, 'Airtime - Intl Roaming - Guinea Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guyana', 'Standard', 200, 'Airtime - Intl Roaming - Guyana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Indian Ocean', 'Standard', 200, 'Airtime - Intl Roaming - Indian Ocean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Iraq', 'Standard', 200, 'Airtime - Intl Roaming - Iraq');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Ireland', 'Standard', 200, 'Airtime - Intl Roaming - Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Libya', 'Standard', 200, 'Airtime - Intl Roaming - Libya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Montserrat', 'Standard', 200, 'Airtime - Intl Roaming - Montserrat');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Pakistan', 'Standard', 200, 'Airtime - Intl Roaming - Pakistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Peru', 'Standard', 200, 'Airtime - Intl Roaming - Peru');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Norway', 'Standard', 200, 'Airtime - Intl Roaming - Norway');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Seychelles', 'Standard', 200, 'Airtime - Intl Roaming - Seychelles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-St. Helena', 'Standard', 200, 'Airtime - Intl Roaming - St. Helena');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-St. Lucia', 'Standard', 200, 'Airtime - Intl Roaming - St. Lucia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sweden', 'Standard', 200, 'Airtime - Intl Roaming - Sweden');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Tokelau', 'Standard', 200, 'Airtime - Intl Roaming - Tokelau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Vietnam', 'Standard', 200, 'Airtime - Intl Roaming - Vietnam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Yemen', 'Standard', 200, 'Airtime - Intl Roaming - Yemen');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Northern Ireland', 'Standard', 200, 'Airtime - Intl Roaming - Northern Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Canary Islands', 'Standard', 200, 'Airtime - Intl Roaming - Canary Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Switzerland', 'Standard', 200, 'Airtime - Intl Roaming - Switzerland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Russia', 'Standard', 200, 'Airtime - Intl Roaming - Russia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Germany', 'Standard', 200, 'Airtime - Intl Roaming - Germany');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Gibraltar', 'Standard', 200, 'Airtime - Intl Roaming - Gibraltar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Malta', 'Standard', 200, 'Airtime - Intl Roaming - Malta');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Armenia', 'Standard', 200, 'Airtime - Intl Roaming - Armenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - British Virgin Islands', 'Standard', 200, 'Airtime - Intl Roaming - British Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - British V.I.', 'Standard', 200, 'Airtime - Intl Roaming - British V.I.');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Netherlands Antilles', 'Standard', 200, 'Airtime - Intl Roaming - Netherlands Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Trinidad and Tobago', 'Standard', 200, 'Airtime - Intl Roaming - Trinidad and Tobago');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Korea South', 'Standard', 200, 'Airtime - Intl Roaming - Korea South');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Congo', 'Standard', 200, 'Airtime - Intl Roaming - Congo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Tanzania', 'Standard', 200, 'Airtime - Intl Roaming - Tanzania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Zambia', 'Standard', 200, 'Airtime - Intl Roaming - Zambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Brazil', 'Standard', 200, 'Airtime - Intl Roaming - Brazil');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Canada', 'Standard', 200, 'Airtime - Intl Roaming - Canada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Bermuda (AT&T Crusie Shi', 'Standard', 200, 'Airtime - Intl Roaming - Bermuda (AT&T Crusie Ship)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Iceland (Oceancell Marit', 'Standard', 200, 'Airtime - Intl Roaming - Iceland (Oceancell Maritime)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International - Cruise Ships', 'Standard', 200, 'Airtime - Intl Roaming - Cruise Ships');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Angola', 'Standard', 200, 'Airtime - Intl Roaming - Angola');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Antigua and Barbuda', 'Standard', 200, 'Airtime - Intl Roaming - Antigua and Barbuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Armenia', 'Standard', 200, 'Airtime - Intl Roaming - Armenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Austria', 'Standard', 200, 'Airtime - Intl Roaming - Austria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Canada', 'Standard', 200, 'Airtime - Intl Roaming - Canada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Costa Rica', 'Standard', 200, 'Airtime - Intl Roaming - Costa Rica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Dominican Republic', 'Standard', 200, 'Airtime - Intl Roaming - Dominican Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Fiji', 'Standard', 200, 'Airtime - Intl Roaming - Fiji');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Former Yugoslavia', 'Standard', 200, 'Airtime - Intl Roaming - Former Yugoslavia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guantanamo Bay', 'Standard', 200, 'Airtime - Intl Roaming - Guantanamo Bay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Guinea', 'Standard', 200, 'Airtime - Intl Roaming - Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Israel', 'Standard', 200, 'Airtime - Intl Roaming - Israel');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Kiribati', 'Standard', 200, 'Airtime - Intl Roaming - Kiribati');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Laos', 'Standard', 200, 'Airtime - Intl Roaming - Laos');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Liberia', 'Standard', 200, 'Airtime - Intl Roaming - Liberia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Malaysia', 'Standard', 200, 'Airtime - Intl Roaming - Malaysia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Marshall Island', 'Standard', 200, 'Airtime - Intl Roaming - Marshall Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Monaco', 'Standard', 200, 'Airtime - Intl Roaming - Monaco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Montenegro', 'Standard', 200, 'Airtime - Intl Roaming - Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Myanmar / Burma', 'Standard', 200, 'Airtime - Intl Roaming - Myanmar / Burma');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Nicaragua', 'Standard', 200, 'Airtime - Intl Roaming - Nicaragua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Northern Mariana Islands', 'Standard', 200, 'Airtime - Intl Roaming - Northern Mariana Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Oman', 'Standard', 200, 'Airtime - Intl Roaming - Oman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Philippines', 'Standard', 200, 'Airtime - Intl Roaming - Philippines');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Portugal', 'Standard', 200, 'Airtime - Intl Roaming - Portugal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-San Marino', 'Standard', 200, 'Airtime - Intl Roaming - San Marino');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Singapore', 'Standard', 200, 'Airtime - Intl Roaming - Singapore');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Solomon Islands', 'Standard', 200, 'Airtime - Intl Roaming - Solomon Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Syrian', 'Standard', 200, 'Airtime - Intl Roaming - Syrian');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Vanuatu', 'Standard', 200, 'Airtime - Intl Roaming - Vanuatu');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Venezuela', 'Standard', 200, 'Airtime - Intl Roaming - Venezuela');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-West Atlantic Ocean', 'Standard', 200, 'Airtime - Intl Roaming - West Atlantic Ocean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Netherlands Antilles', 'Standard', 200, 'Airtime - Intl Roaming - Netherlands Antilles	');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Sark', 'Standard', 200, 'Airtime - Intl Roaming - Sark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-St. Maarten', 'Standard', 200, 'Airtime - Intl Roaming - St. Maarten');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (82, 'International-Malta', 'Standard', 200, 'Airtime - Intl Roaming - Malta');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (79, 'NULL', 'Roaming', 305, 'SMS - Roaming');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (79, '	SMS%', 'Roaming', 305, 'SMS - Roaming');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (79, 'NULL', 'Standard', 310, 'SMS - Standard');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (79, 'SMS%', 'Standard', 310, 'SMS');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (79, 'NULL', 'Standard ILD', 315, 'SMS - ILD');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (79, 'SMS%', 'Standard ILD', 315, 'SMS - ILD');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (81, 'MMS', 'NULL', 350, 'MMS');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (81, 'MMS - MO', 'NULL', 355, 'MMS - MO');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (81, 'MMS - MT', 'NULL', 360, 'MMS - MT');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Liechtenstein', 'Standard', 375, 'SMS - International-Liechtenstein');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Madagascar', 'Standard', 375, 'SMS - International-Madagascar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Netherlands', 'Standard', 375, 'SMS - International-Netherlands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Paraguay', 'Standard', 375, 'SMS - International-Paraguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Philippines', 'Standard', 375, 'SMS - International-Philippines');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-South Africa', 'Standard', 375, 'SMS - International-South Africa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Korea South', 'Standard', 375, 'SMS - International-Korea South');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ukraine', 'Standard', 375, 'SMS - International-Ukraine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-United Kingdom', 'Standard', 375, 'SMS - International-United Kingdom');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Uruguay', 'Standard', 375, 'SMS - International-Uruguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Antilles', 'Standard', 375, 'SMS - International-Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guinea', 'Standard', 375, 'SMS - International-Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cayman Islands', 'Standard', 375, 'SMS - International-Cayman Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Curacao', 'Standard', 375, 'SMS - International-Curacao');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International - Default Country', 'Standard', 375, 'SMS - International-Default Country');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Easter Island', 'Standard', 375, 'SMS - International-Easter Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Netherlands Antilles', 'Standard', 375, 'SMS - International-Netherlands Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-St. Maarten', 'Standard', 375, 'SMS - International-St. Maarten');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Albania', 'Standard', 375, 'SMS - International-Albania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Benin', 'Standard', 375, 'SMS - International-Benin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bermuda', 'Standard', 375, 'SMS - International-Bermuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Canada', 'Standard', 375, 'SMS - International-Canada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Congo DR', 'Standard', 375, 'SMS - International-Congo DR');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cote D''lvoire', 'Standard', 375, 'SMS - International-Cote D''lvoire');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ecuador', 'Standard', 375, 'SMS - International-Ecuador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Georgia', 'Standard', 375, 'SMS - International-Georgia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Greenland', 'Standard', 375, 'SMS - International-Greenland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guam', 'Standard', 375, 'SMS - International-Guam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Hong Kong', 'Standard', 375, 'SMS - International-Hong Kong');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Israel', 'Standard', 375, 'SMS - International-Israel');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Jordan', 'Standard', 375, 'SMS - International-Jordan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Korea', 'Standard', 375, 'SMS - International-Korea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Latvia', 'Standard', 375, 'SMS - International-Latvia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Lebanon', 'Standard', 375, 'SMS - International-Lebanon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Malawi', 'Standard', 375, 'SMS - International-Malawi');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Malta', 'Standard', 375, 'SMS - International-Malta');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Montenegro', 'Standard', 375, 'SMS - International-Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Romania', 'Standard', 375, 'SMS - International-Romania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Sri Lanka', 'Standard', 375, 'SMS - International-Sri Lanka');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Taiwan', 'Standard', 375, 'SMS - International-Taiwan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Turkmenistan', 'Standard', 375, 'SMS - International-Turkmenistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-UK', 'Standard', 375, 'SMS - International-UK');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Zambia', 'Standard', 375, 'SMS - International-Zambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Northern Mariana Islands', 'Standard', 375, 'SMS - International-Northern Mariana Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Burkina Faso', 'Standard', 375, 'SMS - International-Burkina Faso');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cape Verde', 'Standard', 375, 'SMS - International-Cape Verde');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cook Islands', 'Standard', 375, 'SMS - International-Cook Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Lesotho', 'Standard', 375, 'SMS - International-Lesotho');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mali', 'Standard', 375, 'SMS - International-Mali');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Serbia', 'Standard', 375, 'SMS - International-Serbia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-St. Pierre and Miquelon', 'Standard', 375, 'SMS - International-St. Pierre and Miquelon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-MaIdives', 'Standard', 375, 'SMS - International-MaIdives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Solavakia', 'Standard', 375, 'SMS - International-Solavakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Congo / Kinshasa ', 'Standard', 375, 'SMS - International-Congo / Kinshasa ');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guinea Bissau', 'Standard', 375, 'SMS - International-Guinea Bissau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-United States', 'Standard', 375, 'SMS - International-United States');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Monaco', 'Standard', 375, 'SMS - International-Monaco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mauritania', 'Standard', 375, 'SMS - International-Mauritania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Northern Mariana Islands ', 'Standard', 375, 'SMS - International-Northern Mariana Islands ');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Montserrat', 'Standard', 375, 'SMS - International-Montserrat');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Jersey', 'Standard', 375, 'SMS - International-Jersey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Canary Islands', 'Standard', 375, 'SMS - International-Canary Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Djibouti', 'Standard', 375, 'SMS - International-Djibouti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-New Caledonia', 'Standard', 375, 'SMS - International-New Caledonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-French Guiana', 'Standard', 375, 'SMS - International-French Guiana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Libya', 'Standard', 375, 'SMS - International-Libya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Moldova', 'Standard', 375, 'SMS - International-Moldova');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Svalbard', 'Standard', 375, 'SMS - International-Svalbard');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Andorra', 'Standard', 375, 'SMS - International-Andorra');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Belarus', 'Standard', 375, 'SMS - International-Belarus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Brunei', 'Standard', 375, 'SMS - International-Brunei');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bulgaria', 'Standard', 375, 'SMS - International-Bulgaria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cameroon', 'Standard', 375, 'SMS - International-Cameroon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-China', 'Standard', 375, 'SMS - International-China');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-DNA Finland Ltd.', 'Standard', 375, 'SMS - International-DNA Finland Ltd.');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guadeloupe', 'Standard', 375, 'SMS - International-Guadeloupe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Honduras', 'Standard', 375, 'SMS - International-Honduras');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mozambique', 'Standard', 375, 'SMS - International-Mozambique');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Niger', 'Standard', 375, 'SMS - International-Niger');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Poland', 'Standard', 375, 'SMS - International-Poland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Russia', 'Standard', 375, 'SMS - International-Russia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Senegal', 'Standard', 375, 'SMS - International-Senegal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Slovenia', 'Standard', 375, 'SMS - International-Slovenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-St. Lucia', 'Standard', 375, 'SMS - International-St. Lucia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-St. Vincent and Grenadines', 'Standard', 375, 'SMS - International-St. Vincent and Grenadines');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Trinidad and Tobago', 'Standard', 375, 'SMS - International-Trinidad and Tobago');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Alands Islands', 'Standard', 375, 'SMS - International-Alands Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Vanuatu', 'Standard', 375, 'SMS - International-Vanuatu');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Gibraltar', 'Standard', 375, 'SMS - International-Gibraltar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Libyan Arab Jamahiriya', 'Standard', 375, 'SMS - International-Libyan Arab Jamahiriya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bosnia Herzegovina', 'Standard', 375, 'SMS - International-Bosnia Herzegovina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Tonga', 'Standard', 375, 'SMS - International-Tonga');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-US Virgin Islands', 'Standard', 375, 'SMS - International-US Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cruise Ships', 'Standard', 375, 'SMS - International-Cruise Ships');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-San Marino', 'Standard', 375, 'SMS - International-San Marino');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-St. Martin', 'Standard', 375, 'SMS - International-St. Martin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Algeria', 'Standard', 375, 'SMS - International-Algeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Angola', 'Standard', 375, 'SMS - International-Angola');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Anguilla', 'Standard', 375, 'SMS - International-Anguilla');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Aruba', 'Standard', 375, 'SMS - International-Aruba');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bahrain', 'Standard', 375, 'SMS - International-Bahrain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bosnia', 'Standard', 375, 'SMS - International-Bosnia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Faroe Islands', 'Standard', 375, 'SMS - International-Faroe Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Finland', 'Standard', 375, 'SMS - International-Finland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Luxembourg', 'Standard', 375, 'SMS - International-Luxembourg');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Malaysia', 'Standard', 375, 'SMS - International-Malaysia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mongolia', 'Standard', 375, 'SMS - International-Mongolia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Nicaragua', 'Standard', 375, 'SMS - International-Nicaragua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Norway', 'Standard', 375, 'SMS - International-Norway');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Panama', 'Standard', 375, 'SMS - International-Panama');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Vietnam', 'Standard', 375, 'SMS - International-Vietnam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Congo', 'Standard', 375, 'SMS - International-Congo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Zimbabwe', 'Standard', 375, 'SMS - International-Zimbabwe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Saipan', 'Standard', 375, 'SMS - International-Saipan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-UK Maritime Svc', 'Standard', 375, 'SMS - International-UK Maritime Svc');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Lithuania', 'Standard', 375, 'SMS - International-Lithuania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Northern Ireland', 'Standard', 375, 'SMS - International-Northern Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Antigua and Barbuda', 'Standard', 375, 'SMS - International-Antigua and Barbuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Antigua', 'Standard', 375, 'SMS - International-Antigua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-British V.I.', 'Standard', 375, 'SMS - International-British V.I.');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-British Virgin Islands', 'Standard', 375, 'SMS - International-British Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-El Salvador', 'Standard', 375, 'SMS - International-El Salvador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Fiji', 'Standard', 375, 'SMS - International-Fiji');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ireland', 'Standard', 375, 'SMS - International-Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ivory Coast', 'Standard', 375, 'SMS - International-Ivory Coast');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Kazakhstan', 'Standard', 375, 'SMS - International-Kazakhstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Belgium', 'Standard', 375, 'SMS - International-Belgium');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Caribbean', 'Standard', 375, 'SMS - International-Caribbean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Chad', 'Standard', 375, 'SMS - International-Chad');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Chile', 'Standard', 375, 'SMS - International-Chile');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Congo Brazz', 'Standard', 375, 'SMS - International-Congo Brazz');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Costa Rica', 'Standard', 375, 'SMS - International-Costa Rica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ghana', 'Standard', 375, 'SMS - International-Ghana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Hungary', 'Standard', 375, 'SMS - International-Hungary');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Iceland', 'Standard', 375, 'SMS - International-Iceland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Jamaica', 'Standard', 375, 'SMS - International-Jamaica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Macau', 'Standard', 375, 'SMS - International-Macau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Maldives', 'Standard', 375, 'SMS - International-Maldives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Portugal', 'Standard', 375, 'SMS - International-Portugal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Serbia and Montenegro', 'Standard', 375, 'SMS - International-Serbia and Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Singapore', 'Standard', 375, 'SMS - International-Singapore');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-St. Kitts and Nevis', 'Standard', 375, 'SMS - International-St. Kitts and Nevis');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Tanzania', 'Standard', 375, 'SMS - International-Tanzania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-United Arab Emirates', 'Standard', 375, 'SMS - International-United Arab Emirates');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Uzbekistan', 'Standard', 375, 'SMS - International-Uzbekistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Papua New Guinea', 'Standard', 375, 'SMS - International-Papua New Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-JAMDC', 'Standard', 375, 'SMS - International-JAMDC');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bhutan', 'Standard', 375, 'SMS - International-Bhutan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Seychelles', 'Standard', 375, 'SMS - International-Seychelles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Sierra Leone', 'Standard', 375, 'SMS - International-Sierra Leone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Czech Republic', 'Standard', 375, 'SMS - International-Czech Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guade loupe', 'Standard', 375, 'SMS - International-Guade loupe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Great Britain', 'Standard', 375, 'SMS - International-Great Britain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Slovakia', 'Standard', 375, 'SMS - International-Slovakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Sark', 'Standard', 375, 'SMS - International-Sark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Scotland', 'Standard', 375, 'SMS - International-Scotland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'Inernational-St. Barthelemy', 'Standard', 375, 'SMS - International-St. Barthelemy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Armenia', 'Standard', 375, 'SMS - International-Armenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Austria', 'Standard', 375, 'SMS - International-Austria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bolivia', 'Standard', 375, 'SMS - International-Bolivia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Brazil', 'Standard', 375, 'SMS - International-Brazil');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Croatia', 'Standard', 375, 'SMS - International-Croatia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cyprus', 'Standard', 375, 'SMS - International-Cyprus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Dominica', 'Standard', 375, 'SMS - International-Dominica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Dominican Republic', 'Standard', 375, 'SMS - International-Dominican Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Estonia', 'Standard', 375, 'SMS - International-Estonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ethiopia', 'Standard', 375, 'SMS - International-Ethiopia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Gabon', 'Standard', 375, 'SMS - International-Gabon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Germany', 'Standard', 375, 'SMS - International-Germany');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Greece', 'Standard', 375, 'SMS - International-Greece');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guyana', 'Standard', 375, 'SMS - International-Guyana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Indonesia', 'Standard', 375, 'SMS - International-Indonesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Italy', 'Standard', 375, 'SMS - International-Italy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Kenya', 'Standard', 375, 'SMS - International-Kenya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Liberia', 'Standard', 375, 'SMS - International-Liberia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Macedonia', 'Standard', 375, 'SMS - International-Macedonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mexico', 'Standard', 375, 'SMS - International-Mexico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Moldavia', 'Standard', 375, 'SMS - International-Moldavia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Monseratt', 'Standard', 375, 'SMS - International-Monseratt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Nepal', 'Standard', 375, 'SMS - International-Nepal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Nigeria', 'Standard', 375, 'SMS - International-Nigeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Qatar', 'Standard', 375, 'SMS - International-Qatar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Saudi Arabia', 'Standard', 375, 'SMS - International-Saudi Arabia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Spain', 'Standard', 375, 'SMS - International-Spain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Togo', 'Standard', 375, 'SMS - International-Togo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Tunisia', 'Standard', 375, 'SMS - International-Tunisia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Turkey', 'Standard', 375, 'SMS - International-Turkey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Turks and Caicos Islands', 'Standard', 375, 'SMS - International-Turks and Caicos Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Venezuela', 'Standard', 375, 'SMS - International-Venezuela');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Central African Republic', 'Standard', 375, 'SMS - International-Central African Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Australia', 'Standard', 375, 'SMS - International-Australia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bahamas', 'Standard', 375, 'SMS - International-Bahamas');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bangladesh', 'Standard', 375, 'SMS - International-Bangladesh');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Belize', 'Standard', 375, 'SMS - International-Belize');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Botswana', 'Standard', 375, 'SMS - International-Botswana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cayman', 'Standard', 375, 'SMS - International-Cayman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Egypt', 'Standard', 375, 'SMS - International-Egypt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-France', 'Standard', 375, 'SMS - International-France');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-French Polynesia', 'Standard', 375, 'SMS - International-French Polynesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Grenada', 'Standard', 375, 'SMS - International-Grenada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-India', 'Standard', 375, 'SMS - International-India');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Iraq', 'Standard', 375, 'SMS - International-Iraq');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Japan', 'Standard', 375, 'SMS - International-Japan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Netherland Antilles', 'Standard', 375, 'SMS - International-Netherland Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Oman', 'Standard', 375, 'SMS - International-Oman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Tajikistan', 'Standard', 375, 'SMS - International-Tajikistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Thailand', 'Standard', 375, 'SMS - International-Thailand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Uganda', 'Standard', 375, 'SMS - International-Uganda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Kyrgyzstan', 'Standard', 375, 'SMS - International-Kyrgyzstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Yemen', 'Standard', 375, 'SMS - International-Yemen');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Samoa', 'Standard', 375, 'SMS - International-Samoa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Barbados', 'Standard', 375, 'SMS - International-Barbados');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Bonaire', 'Standard', 375, 'SMS - International-Bonaire');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Puerto Rico', 'Standard', 375, 'SMS - International-Puerto Rico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Dutch St. Maarten', 'Standard', 375, 'SMS - International-Dutch St. Maarten');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Vatican City', 'Standard', 375, 'SMS - International-Vatican City');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Wales', 'Standard', 375, 'SMS - International-Wales');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Afghanistan', 'Standard', 375, 'SMS - International-Afghanistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Argentina', 'Standard', 375, 'SMS - International-Argentina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Cambodia', 'Standard', 375, 'SMS - International-Cambodia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Colombia', 'Standard', 375, 'SMS - International-Colombia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Denmark', 'Standard', 375, 'SMS - International-Denmark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Dutch Antille', 'Standard', 375, 'SMS - International-Dutch Antille');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-French West Indies', 'Standard', 375, 'SMS - International-French West Indies');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guatemala', 'Standard', 375, 'SMS - International-Guatemala');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Haiti', 'Standard', 375, 'SMS - International-Haiti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Kuwait', 'Standard', 375, 'SMS - International-Kuwait');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Laos', 'Standard', 375, 'SMS - International-Laos');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mauritius', 'Standard', 375, 'SMS - International-Mauritius');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Morocco', 'Standard', 375, 'SMS - International-Morocco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Namibia', 'Standard', 375, 'SMS - International-Namibia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-New Zealand', 'Standard', 375, 'SMS - International-New Zealand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Pakistan', 'Standard', 375, 'SMS - International-Pakistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Palestine', 'Standard', 375, 'SMS - International-Palestine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Peru', 'Standard', 375, 'SMS - International-Peru');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Rwanda', 'Standard', 375, 'SMS - International-Rwanda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Slovak Republic', 'Standard', 375, 'SMS - International-Slovak Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Suriname', 'Standard', 375, 'SMS - International-Suriname');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Sweden', 'Standard', 375, 'SMS - International-Sweden');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Switzerland', 'Standard', 375, 'SMS - International-Switzerland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Ascension Island', 'Standard', 375, 'SMS - International-Ascension Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Equatorial Guinea', 'Standard', 375, 'SMS - International-Equatorial Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Gambia', 'Standard', 375, 'SMS - International-Gambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Mauretania', 'Standard', 375, 'SMS - International-Mauretania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Guernsey', 'Standard', 375, 'SMS - International-Guernsey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Isle of Man', 'Standard', 375, 'SMS - International-Isle of Man');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International - Micronesia', 'Standard', 375, 'SMS - International-Micronesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Christmas Island', 'Standard', 375, 'SMS - International-Christmas Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-England', 'Standard', 375, 'SMS - International-England');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (83, 'International-Azerbaijan', 'Standard', 375, 'SMS - International-Azerbaijan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (80, 'GPRS', 'Standard%', 500, 'GPRS');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (80, 'GPRS', 'Roaming%', 550, 'GPRS - Roaming');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (89, 'GPRS', 'Standard%', 700, 'GPRS');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guinea', 'Standard', 600, 'GPRS - Intl Roaming - Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cruise Ships', 'Standard', 600, 'GPRS - Intl Roaming - Cruise Ships');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Easter Island', 'Standard', 600, 'GPRS - Intl Roaming - Easter Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Netherlands Antilles', 'Standard', 600, 'GPRS - Intl Roaming - Netherlands Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-San Marino', 'Standard', 600, 'GPRS - Intl Roaming - San Marino');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Inernational-St. Barthelemy', 'Standard', 600, 'GPRS - Inl Roaming - St. Barthelemy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Canary Islands', 'Standard', 600, 'GPRS - Intl Roaming - Canary Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Afghanistan', 'Standard', 600, 'GPRS - Intl Roaming - Afghanistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - United Arab Emirates', 'Standard', 600, 'GPRS - Intl Roaming - United Arab Emirates');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Belize', 'Standard', 600, 'GPRS - Intl Roaming - Belize');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Brazil', 'Standard', 600, 'GPRS - Intl Roaming - Brazil');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Chile', 'Standard', 600, 'GPRS - Intl Roaming - Chile');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cameroon', 'Standard', 600, 'GPRS - Intl Roaming - Cameroon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cook Islands', 'Standard', 600, 'GPRS - Intl Roaming - Cook Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Costa Rica', 'Standard', 600, 'GPRS - Intl Roaming - Costa Rica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cyprus', 'Standard', 600, 'GPRS - Intl Roaming - Cyprus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Djibouti', 'Standard', 600, 'GPRS - Intl Roaming - Djibouti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Spain', 'Standard', 600, 'GPRS - Intl Roaming - Spain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Estonia', 'Standard', 600, 'GPRS - Intl Roaming - Estonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - France', 'Standard', 600, 'GPRS - Intl Roaming - France');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Equatorial Guinea', 'Standard', 600, 'GPRS - Intl Roaming - Equatorial Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Grenada', 'Standard', 600, 'GPRS - Intl Roaming - Grenada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guatemala', 'Standard', 600, 'GPRS - Intl Roaming - Guatemala');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guyana', 'Standard', 600, 'GPRS - Intl Roaming - Guyana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Hungary', 'Standard', 600, 'GPRS - Intl Roaming - Hungary');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Sri Lanka', 'Standard', 600, 'GPRS - Intl Roaming - Sri Lanka');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Monaco', 'Standard', 600, 'GPRS - Intl Roaming - Monaco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Madagascar', 'Standard', 600, 'GPRS - Intl Roaming - Madagascar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Singapore', 'Standard', 600, 'GPRS - Intl Roaming - Singapore');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Tunisia', 'Standard', 600, 'GPRS - Intl Roaming - Tunisia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Tanzania', 'Standard', 600, 'GPRS - Intl Roaming - Tanzania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ukraine', 'Standard', 600, 'GPRS - Intl Roaming - Ukraine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cincinnati Bell Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Cincinnati Bell Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cellularone', 'Standard', 600, 'GPRS - Intl Roaming - Cellularone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Chariton Valley 1900', 'Standard', 600, 'GPRS - Intl Roaming - Chariton Valley 1900');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Convey Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Convey Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Zimbabwe', 'Standard', 600, 'GPRS - Intl Roaming - Zimbabwe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Iceland(Oceancell Mariti', 'Standard', 600, 'GPRS - Intl Roaming - Iceland(Oceancell Maritime)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Iceland', 'Standard', 600, 'GPRS - Intl Roaming - Iceland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Japan', 'Standard', 600, 'GPRS - Intl Roaming - Japan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'GPRS%', 'Roaming', 600, 'GPRS - Roaming');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Angola', 'Standard', 600, 'GPRS - Intl Roaming - Angola');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Congo', 'Standard', 600, 'GPRS - Intl Roaming - Congo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Gambia', 'Standard', 600, 'GPRS - Intl Roaming - Gambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Haiti', 'Standard', 600, 'GPRS - Intl Roaming - Haiti');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Iraq', 'Standard', 600, 'GPRS - Intl Roaming - Iraq');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Iceland', 'Standard', 600, 'GPRS - Intl Roaming - Iceland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Israel', 'Standard', 600, 'GPRS - Intl Roaming - Israel');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Kenya', 'Standard', 600, 'GPRS - Intl Roaming - Kenya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Kyrgyzstan', 'Standard', 600, 'GPRS - Intl Roaming - Kyrgyzstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mali', 'Standard', 600, 'GPRS - Intl Roaming - Mali');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Malta', 'Standard', 600, 'GPRS - Intl Roaming - Malta');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Malawi', 'Standard', 600, 'GPRS - Intl Roaming - Malawi');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - New Caledonia', 'Standard', 600, 'GPRS - Intl Roaming - New Caledonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Palestine', 'Standard', 600, 'GPRS - Intl Roaming - Palestine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Sierra Leone', 'Standard', 600, 'GPRS - Intl Roaming - Sierra Leone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Seychelles', 'Standard', 600, 'GPRS - Intl Roaming - Seychelles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Uruguay', 'Standard', 600, 'GPRS - Intl Roaming - Uruguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Caprock Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Caprock Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Westlink', 'Standard', 600, 'GPRS - Intl Roaming - Westlink');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Chariton Valley 850', 'Standard', 600, 'GPRS - Intl Roaming - Chariton Valley 850');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Rural Cellular Corp', 'Standard', 600, 'GPRS - Intl Roaming - Rural Cellular Corp');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - West Central Wireless', 'Standard', 600, 'GPRS - Intl Roaming - West Central Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Venezuela', 'Standard', 600, 'GPRS - Intl Roaming - Venezuela');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - British Virgin Islands', 'Standard', 600, 'GPRS - Intl Roaming - British Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Vietnam', 'Standard', 600, 'GPRS - Intl Roaming - Vietnam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Kazakhstan', 'Standard', 600, 'GPRS - Intl Roaming - Kazakhstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Cambodia', 'Standard', 600, 'GPRS - Intl Roaming - Cambodia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-St. Lucia', 'Standard', 600, 'GPRS - Intl Roaming - St. Lucia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Macao', 'Standard', 600, 'GPRS - Intl Roaming - Macao');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Mozambique', 'Standard', 600, 'GPRS - Intl Roaming - Mozambique');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Peru', 'Standard', 600, 'GPRS - Intl Roaming - Peru');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Russia', 'Standard', 600, 'GPRS - Intl Roaming - Russia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Singapore', 'Standard', 600, 'GPRS - Intl Roaming - Singapore');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Turks&caicos', 'Standard', 600, 'GPRS - Intl Roaming - Turks&caicos');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Cellular Properties', 'Standard', 600, 'GPRS - Intl - Cellular Properties');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - St. Vincent', 'Standard', 600, 'GPRS - Intl Roaming - St. Vincent');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guernsey', 'Standard', 600, 'GPRS - Intl Roaming - Guernsey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Libyan Arab Jamahiriya', 'Standard', 600, 'GPRS - Intl Roaming - Libyan Arab Jamahiriya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bonaire', 'Standard', 600, 'GPRS - Intl Roaming - Bonaire');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cayman Islands', 'Standard', 600, 'GPRS - Intl Roaming - Cayman Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guade loupe', 'Standard', 600, 'GPRS - Intl Roaming - Guade loupe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Moldova', 'Standard', 600, 'GPRS - Intl Roaming - Moldova');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Northern Mariana Islands', 'Standard', 600, 'GPRS - Intl Roaming - Northern Mariana Islands ');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Philippines', 'Standard', 600, 'GPRS - Intl Roaming - Philippines');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Rwanda', 'Standard', 600, 'GPRS - Intl Roaming - Rwanda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Slovak Republic', 'Standard', 600, 'GPRS - Intl Roaming - Slovak Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Trinidad and Tobago', 'Standard', 600, 'GPRS - Intl Roaming - Trinidad and Tobago');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Taiwan', 'Standard', 600, 'GPRS - Intl Roaming - Taiwan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Uganda', 'Standard', 600, 'GPRS - Intl Roaming - Uganda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Immix Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Immix Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Epic Touch', 'Standard', 600, 'GPRS - Intl Roaming - Epic Touch');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - C1 Ne Pa', 'Standard', 600, 'GPRS - Intl Roaming - C1 Ne Pa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Union', 'Standard', 600, 'GPRS - Intl Roaming - Union');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Serbia and Montenegro', 'Standard', 600, 'GPRS - Intl Roaming - Serbia and Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Laos', 'Standard', 600, 'GPRS - Intl Roaming - Laos');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Suriname', 'Standard', 600, 'GPRS - Intl Roaming - Suriname');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Jamaica', 'Standard', 600, 'GPRS - Intl Roaming - Jamaica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Jordan', 'Standard', 600, 'GPRS - Intl Roaming - Jordan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Kenya', 'Standard', 600, 'GPRS - Intl Roaming - Kenya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Latvia', 'Standard', 600, 'GPRS - Intl Roaming - Latvia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Mauritania', 'Standard', 600, 'GPRS - Intl Roaming - Mauritania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Philippines', 'Standard', 600, 'GPRS - Intl Roaming - Philippines');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Paraguay', 'Standard', 600, 'GPRS - Intl Roaming - Paraguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Gibraltar', 'Standard', 600, 'GPRS - Intl Roaming - Gibraltar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ireland', 'Standard', 600, 'GPRS - Intl Roaming - Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Japan', 'Standard', 600, 'GPRS - Intl Roaming - Japan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Lebanon', 'Standard', 600, 'GPRS - Intl Roaming - Lebanon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mozambique', 'Standard', 600, 'GPRS - Intl Roaming - Mozambique');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mauritania', 'Standard', 600, 'GPRS - Intl Roaming - Mauritania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Nicaragua', 'Standard', 600, 'GPRS - Intl Roaming - Nicaragua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Oman', 'Standard', 600, 'GPRS - Intl Roaming - Oman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - El Salvador', 'Standard', 600, 'GPRS - Intl Roaming - El Salvador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - St. Pierre and Miquelon', 'Standard', 600, 'GPRS - Intl Roaming - St. Pierre and Miquelon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Advantage Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Advantage Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Indigo Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Indigo Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Pine Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Pine Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Petroco', 'Standard', 600, 'GPRS - Intl Roaming - Petroco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cross Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Cross Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Uzbekistan', 'Standard', 600, 'GPRS - Intl Roaming - Uzbekistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - British V.i.', 'Standard', 600, 'GPRS - Intl Roaming - British V.i.');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Lesotho', 'Standard', 600, 'GPRS - Intl Roaming - Lesotho');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Mali', 'Standard', 600, 'GPRS - Intl Roaming - Mali');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Malawi', 'Standard', 600, 'GPRS - Intl Roaming - Malawi');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Norway', 'Standard', 600, 'GPRS - Intl Roaming - Norway');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Poland', 'Standard', 600, 'GPRS - Intl Roaming - Poland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Qatar', 'Standard', 600, 'GPRS - Intl Roaming - Qatar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Romania', 'Standard', 600, 'GPRS - Intl Roaming - Romania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Suriname', 'Standard', 600, 'GPRS - Intl Roaming - Suriname');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Iceland(Ocncell Maritm)', 'Standard', 600, 'GPRS - Intl Roaming - Iceland(Ocncell Maritm)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guinea Bissau', 'Standard', 600, 'GPRS - Intl Roaming - Guinea Bissau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mauretania', 'Standard', 600, 'GPRS - Intl Roaming - Mauretania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Broadpoint', 'Standard', 600, 'GPRS - Intl Roaming - Broadpoint');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Montserrat', 'Standard', 600, 'GPRS - Intl Roaming - Montserrat');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Brunei', 'Standard', 600, 'GPRS - Intl Roaming - Brunei');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Ship', 'Standard', 600, 'GPRS - Intl Roaming - Ship');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Default Country', 'Standard', 600, 'GPRS - Intl Roaming - Default Country');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-St. Martin', 'Standard', 600, 'GPRS - Intl Roaming - St. Martin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Anguilla', 'Standard', 600, 'GPRS - Intl Roaming - Anguilla');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Albania', 'Standard', 600, 'GPRS - Intl Roaming - Albania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Azerbaijan', 'Standard', 600, 'GPRS - Intl Roaming - Azerbaijan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Belgium', 'Standard', 600, 'GPRS - Intl Roaming - Belgium');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Congo Brazz', 'Standard', 600, 'GPRS - Intl Roaming - Congo Brazz');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cayman', 'Standard', 600, 'GPRS - Intl Roaming - Cayman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dominica', 'Standard', 600, 'GPRS - Intl Roaming - Dominica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Egypt', 'Standard', 600, 'GPRS - Intl Roaming - Egypt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Finland', 'Standard', 600, 'GPRS - Intl Roaming - Finland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Fiji', 'Standard', 600, 'GPRS - Intl Roaming - Fiji');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Uk', 'Standard', 600, 'GPRS - Intl Roaming - Uk');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Israel', 'Standard', 600, 'GPRS - Intl Roaming - Israel');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Liechtenstein', 'Standard', 600, 'GPRS - Intl Roaming - Liechtenstein');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Mauritius', 'Standard', 600, 'GPRS - Intl Roaming - Mauritius');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Namibia', 'Standard', 600, 'GPRS - Intl Roaming - Namibia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Rwanda', 'Standard', 600, 'GPRS - Intl Roaming - Rwanda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Arctic Slope Telephone', 'Standard', 600, 'GPRS - Intl - Arctic Slope Telephone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Cincinnati Bell Wireless', 'Standard', 600, 'GPRS - Intl - Cincinnati Bell Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Chariton Valley 1900', 'Standard', 600, 'GPRS - Intl - Chariton Valley 1900');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Norway (MCP)', 'Standard', 600, 'GPRS - Intl Roaming - Norway (MCP)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - JAMDC', 'Standard', 600, 'GPRS - Intl Roaming - JAMDC');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bosnia Herzegovina', 'Standard', 600, 'GPRS - Intl Roaming - Bosnia Herzegovina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - United States', 'Standard', 600, 'GPRS - Intl Roaming - United States');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - US Virgin Islands', 'Standard', 600, 'GPRS - Intl Roaming - US Virgin Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Northern Mariana Islands', 'Standard', 600, 'GPRS - Intl Roaming - Northern Mariana Islands ');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Samoa', 'Standard', 600, 'GPRS - Intl Roaming - Samoa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dutch St. Maarten', 'Standard', 600, 'GPRS - Intl Roaming - Dutch St. Maarten');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Unknown Country', 'Standard', 600, 'GPRS - Intl Roaming - Unknown Country');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dutch Antille', 'Standard', 600, 'GPRS - Intl Roaming - Dutch Antille');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Netherlands Antilles', 'Standard', 600, 'GPRS - Intl Roaming - Netherlands Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Kyrgyzstan', 'Standard', 600, 'GPRS - Intl Roaming - Kyrgyzstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-St. Kitts and Nevis', 'Standard', 600, 'GPRS - Intl Roaming - St. Kitts and Nevis');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Korea South', 'Standard', 600, 'GPRS - Intl Roaming - Korea South');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Lebanon', 'Standard', 600, 'GPRS - Intl Roaming - Lebanon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Sri Lanka', 'Standard', 600, 'GPRS - Intl Roaming - Sri Lanka');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Morocco', 'Standard', 600, 'GPRS - Intl Roaming - Morocco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Mexico', 'Standard', 600, 'GPRS - Intl Roaming - Mexico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Mongolia', 'Standard', 600, 'GPRS - Intl Roaming - Mongolia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-New Caledonia', 'Standard', 600, 'GPRS - Intl Roaming - New Caledonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Niger', 'Standard', 600, 'GPRS - Intl Roaming - Niger');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Nigeria', 'Standard', 600, 'GPRS - Intl Roaming - Nigeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Portugal', 'Standard', 600, 'GPRS - Intl Roaming - Portugal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Palestine', 'Standard', 600, 'GPRS - Intl Roaming - Palestine');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Chariton Valley 850', 'Standard', 600, 'GPRS - Intl - Chariton Valley 850');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Petrocom', 'Standard', 600, 'GPRS - Intl Roaming - Petrocom');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ascension Island', 'Standard', 600, 'GPRS - Intl Roaming - Ascension Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Northern Mariana Islands', 'Standard', 600, 'GPRS - Intl Roaming - Northern Mariana Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Slovakia', 'Standard', 600, 'GPRS - Intl Roaming - Slovakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Russian Federation', 'Standard', 600, 'GPRS - Intl Roaming - Russian Federation');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Papua New Guinea', 'Standard', 600, 'GPRS - Intl Roaming - Papua New Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Scotland', 'Standard', 600, 'GPRS - Intl Roaming - Scotland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Svalbard', 'Standard', 600, 'GPRS - Intl Roaming - Svalbard');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Andorra', 'Standard', 600, 'GPRS - Intl Roaming - Andorra');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Antigua', 'Standard', 600, 'GPRS - Intl Roaming - Antigua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Austria', 'Standard', 600, 'GPRS - Intl Roaming - Austria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bahamas', 'Standard', 600, 'GPRS - Intl Roaming - Bahamas');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bosnia', 'Standard', 600, 'GPRS - Intl Roaming - Bosnia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bolivia', 'Standard', 600, 'GPRS - Intl Roaming - Bolivia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Canada', 'Standard', 600, 'GPRS - Intl Roaming - Canada');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Congo DR', 'Standard', 600, 'GPRS - Intl Roaming - Congo DR');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Denmark', 'Standard', 600, 'GPRS - Intl Roaming - Denmark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dominican Republic', 'Standard', 600, 'GPRS - Intl Roaming - Dominican Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Faroe Islands', 'Standard', 600, 'GPRS - Intl Roaming - Faroe Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Gabon', 'Standard', 600, 'GPRS - Intl Roaming - Gabon');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - United Kingdom', 'Standard', 600, 'GPRS - Intl Roaming - United Kingdom');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guadeloupe', 'Standard', 600, 'GPRS - Intl Roaming - Guadeloupe');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Greece', 'Standard', 600, 'GPRS - Intl Roaming - Greece');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Jasper Systems', 'Standard', 600, 'GPRS - Intl Roaming - Jasper Systems');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Italy', 'Standard', 600, 'GPRS - Intl Roaming - Italy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Jordan', 'Standard', 600, 'GPRS - Intl Roaming - Jordan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Kuwait', 'Standard', 600, 'GPRS - Intl Roaming - Kuwait');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Luxembourg', 'Standard', 600, 'GPRS - Intl Roaming - Luxembourg');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Monseratt', 'Standard', 600, 'GPRS - Intl Roaming - Monseratt');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Peru', 'Standard', 600, 'GPRS - Intl Roaming - Peru');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - French Guiana', 'Standard', 600, 'GPRS - Intl Roaming - French Guiana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Tonga', 'Standard', 600, 'GPRS - Intl Roaming - Tonga');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Central African Republic', 'Standard', 600, 'GPRS - Intl Roaming - Central African Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Jersey', 'Standard', 600, 'GPRS - Intl Roaming - Jersey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-St. Maarten', 'Standard', 600, 'GPRS - Intl Roaming - St. Maarten');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-England', 'Standard', 600, 'GPRS - Intl Roaming - England');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Antilles', 'Standard', 600, 'GPRS - Intl Roaming - Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bermuda', 'Standard', 600, 'GPRS - Intl Roaming - Bermuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bhutan', 'Standard', 600, 'GPRS - Intl Roaming - Bhutan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Botswana', 'Standard', 600, 'GPRS - Intl Roaming - Botswana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - China', 'Standard', 600, 'GPRS - Intl Roaming - China');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ecuador', 'Standard', 600, 'GPRS - Intl Roaming - Ecuador');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dna Finland Ltd.', 'Standard', 600, 'GPRS - Intl Roaming - Dna Finland Ltd.');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - French West Indies', 'Standard', 600, 'GPRS - Intl Roaming - French West Indies');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Guam', 'Standard', 600, 'GPRS - Intl Roaming - Guam');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Croatia', 'Standard', 600, 'GPRS - Intl Roaming - Croatia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Indonesia', 'Standard', 600, 'GPRS - Intl Roaming - Indonesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Kazakhstan', 'Standard', 600, 'GPRS - Intl Roaming - Kazakhstan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Korea South', 'Standard', 600, 'GPRS - Intl Roaming - Korea South');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Lithuania', 'Standard', 600, 'GPRS - Intl Roaming - Lithuania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Simmetry Communications', 'Standard', 600, 'GPRS - Intl - Simmetry Communications');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Cellular One Amarillo', 'Standard', 600, 'GPRS - Intl - Cellular One Amarillo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Long Lines Wireless', 'Standard', 600, 'GPRS - Intl - Long Lines Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Rural Cellular Corp', 'Standard', 600, 'GPRS - Intl - Rural Cellular Corp');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - West Central Wireless', 'Standard', 600, 'GPRS - Intl - West Central Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cape Verde', 'Standard', 600, 'GPRS - Intl Roaming - Cape Verde');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Alands Islands', 'Standard', 600, 'GPRS - Intl Roaming - Alands Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Isle of Man', 'Standard', 600, 'GPRS - Intl Roaming - Isle of Man');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Italy Maritime', 'Standard', 600, 'GPRS - Intl Roaming - Italy Maritime');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Vanuatu', 'Standard', 600, 'GPRS - Intl Roaming - Vanuatu');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - MaIdives', 'Standard', 600, 'GPRS - Intl Roaming - MaIdives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Curacao', 'Standard', 600, 'GPRS - Intl Roaming - Curacao');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Micronesia', 'Standard', 600, 'GPRS - Intl Roaming - Micronesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Northern Ireland', 'Standard', 600, 'GPRS - Intl Roaming - Northern Ireland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Sark', 'Standard', 600, 'GPRS - Intl Roaming - Sark');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Aruba', 'Standard', 600, 'GPRS - Intl Roaming - Aruba');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Armenia', 'Standard', 600, 'GPRS - Intl Roaming - Armenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bulgaria', 'Standard', 600, 'GPRS - Intl Roaming - Bulgaria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bahrain', 'Standard', 600, 'GPRS - Intl Roaming - Bahrain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Czech Republic', 'Standard', 600, 'GPRS - Intl Roaming - Czech Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Germany', 'Standard', 600, 'GPRS - Intl Roaming - Germany');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Reunion', 'Standard', 600, 'GPRS - Intl Roaming - Reunion');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ghana', 'Standard', 600, 'GPRS - Intl Roaming - Ghana');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Greenland', 'Standard', 600, 'GPRS - Intl Roaming - Greenland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - India', 'Standard', 600, 'GPRS - Intl Roaming - India');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - St. Kitts and Nevis', 'Standard', 600, 'GPRS - Intl Roaming - St. Kitts and Nevis ');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - St. Lucia', 'Standard', 600, 'GPRS - Intl Roaming - St. Lucia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Lesotho', 'Standard', 600, 'GPRS - Intl Roaming - Lesotho');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Namibia', 'Standard', 600, 'GPRS - Intl Roaming - Namibia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Qatar', 'Standard', 600, 'GPRS - Intl Roaming - Qatar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Russia', 'Standard', 600, 'GPRS - Intl Roaming - Russia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Saudi Arabia', 'Standard', 600, 'GPRS - Intl Roaming - Saudi Arabia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Sweden', 'Standard', 600, 'GPRS - Intl Roaming - Sweden');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Chad', 'Standard', 600, 'GPRS - Intl Roaming - Chad');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Simmetry Communications', 'Standard', 600, 'GPRS - Intl Roaming - Simmetry Communications');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Arctic Slope Telephone', 'Standard', 600, 'GPRS - Intl Roaming - Arctic Slope Telephone');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cellular Properties', 'Standard', 600, 'GPRS - Intl Roaming - Cellular Properties');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Kaplan', 'Standard', 600, 'GPRS - Intl Roaming - Kaplan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Smith Bagley', 'Standard', 600, 'GPRS - Intl Roaming - Smith Bagley');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Long Lines Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Long Lines Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Zambia', 'Standard', 600, 'GPRS - Intl Roaming - Zambia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - UK Maritime Svc', 'Standard', 600, 'GPRS - Intl Roaming - UK Maritime Svc');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Netherland Antilles', 'Standard', 600, 'GPRS - Intl Roaming - Netherland Antilles');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Uae', 'Standard', 600, 'GPRS - Intl Roaming - Uae');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Algeria', 'Standard', 600, 'GPRS - Intl Roaming - Algeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Great Britain', 'Standard', 600, 'GPRS - Intl Roaming - Great Britain');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Georgia', 'Standard', 600, 'GPRS - Intl Roaming - Georgia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Hong Kong', 'Standard', 600, 'GPRS - Intl Roaming - Hong Kong');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Honduras', 'Standard', 600, 'GPRS - Intl Roaming - Honduras');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Jamaica', 'Standard', 600, 'GPRS - Intl Roaming - Jamaica');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Liberia', 'Standard', 600, 'GPRS - Intl Roaming - Liberia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Libya', 'Standard', 600, 'GPRS - Intl Roaming - Libya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Liechtenstein', 'Standard', 600, 'GPRS - Intl Roaming - Liechtenstein');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Latvia', 'Standard', 600, 'GPRS - Intl Roaming - Latvia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Norway', 'Standard', 600, 'GPRS - Intl Roaming - Norway');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Portugal', 'Standard', 600, 'GPRS - Intl Roaming - Portugal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Paraguay', 'Standard', 600, 'GPRS - Intl Roaming - Paraguay');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Slovenia', 'Standard', 600, 'GPRS - Intl Roaming - Slovenia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Turkmenistan', 'Standard', 600, 'GPRS - Intl Roaming - Turkmenistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Airadigm', 'Standard', 600, 'GPRS - Intl Roaming - Airadigm');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Viaero Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Viaero Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mid-tex Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Mid-tex Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Xit Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Xit Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Algeria (ATM Mobilis)', 'Standard', 600, 'GPRS - Intl Roaming - Algeria (ATM Mobilis)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Australia', 'Standard', 600, 'GPRS - Intl Roaming - Australia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Benin', 'Standard', 600, 'GPRS - Intl Roaming - Benin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Belarus', 'Standard', 600, 'GPRS - Intl Roaming - Belarus');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Caribbean', 'Standard', 600, 'GPRS - Intl Roaming - Caribbean');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Brunei', 'Standard', 600, 'GPRS - Intl Roaming - Brunei');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ivory Coast', 'Standard', 600, 'GPRS - Intl Roaming - Ivory Coast');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cote D''Ivoire', 'Standard', 600, 'GPRS - Intl Roaming - Cote D''Ivoire');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ethiopia', 'Standard', 600, 'GPRS - Intl Roaming - Ethiopia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - French Polynesia', 'Standard', 600, 'GPRS - Intl Roaming - French Polynesia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cambodia', 'Standard', 600, 'GPRS - Intl Roaming - Cambodia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Korea', 'Standard', 600, 'GPRS - Intl Roaming - Korea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Macau', 'Standard', 600, 'GPRS - Intl Roaming - Macau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Moldavia', 'Standard', 600, 'GPRS - Intl Roaming - Moldavia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Maldives', 'Standard', 600, 'GPRS - Intl Roaming - Maldives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Macedonia', 'Standard', 600, 'GPRS - Intl Roaming - Macedonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Niger', 'Standard', 600, 'GPRS - Intl Roaming - Niger');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Nepal', 'Standard', 600, 'GPRS - Intl Roaming - Nepal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - New Zealand', 'Standard', 600, 'GPRS - Intl Roaming - New Zealand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Poland', 'Standard', 600, 'GPRS - Intl Roaming - Poland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Puerto Rico', 'Standard', 600, 'GPRS - Intl Roaming - Puerto Rico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Romania', 'Standard', 600, 'GPRS - Intl Roaming - Romania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Turks and Caicos Islands', 'Standard', 600, 'GPRS - Intl Roaming - Turks and Caicos Islands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Togo', 'Standard', 600, 'GPRS - Intl Roaming - Togo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Thailand', 'Standard', 600, 'GPRS - Intl Roaming - Thailand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Tajikistan', 'Standard', 600, 'GPRS - Intl Roaming - Tajikistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Edge Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Edge Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Farmers Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Farmers Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Cellular One Amarillo', 'Standard', 600, 'GPRS - Intl Roaming - Cellular One Amarillo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - I Wireless', 'Standard', 600, 'GPRS - Intl Roaming - I Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Choice / Quantum', 'Standard', 600, 'GPRS - Intl Roaming - Choice / Quantum');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - C1 San Luis Obispo', 'Standard', 600, 'GPRS - Intl Roaming - C1 San Luis Obispo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - C1 East Texas', 'Standard', 600, 'GPRS - Intl Roaming - C1 East Texas');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - St. Vincent and Grenadin', 'Standard', 600, 'GPRS - Intl Roaming - St. Vincent and Grenadin');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Montenegro', 'Standard', 600, 'GPRS - Intl Roaming - Montenegro');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Monaco', 'Standard', 600, 'GPRS - Intl Roaming - Monaco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Malta', 'Standard', 600, 'GPRS - Intl Roaming - Malta');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Montserrat', 'Standard', 600, 'GPRS - Intl Roaming - Montserrat');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Panama', 'Standard', 600, 'GPRS - Intl Roaming - Panama');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Saudi Arabia', 'Standard', 600, 'GPRS - Intl Roaming - Saudi Arabia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Senegal', 'Standard', 600, 'GPRS - Intl Roaming - Senegal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Easterbrooke Cellular', 'Standard', 600, 'GPRS - Intl - Easterbrooke Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Serbia', 'Standard', 600, 'GPRS - Intl Roaming - Serbia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Samoa', 'Standard', 600, 'GPRS - Intl Roaming - Samoa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Barbados', 'Standard', 600, 'GPRS - Intl Roaming - Barbados');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dem Rep Of Congo', 'Standard', 600, 'GPRS - Intl Roaming - Dem Rep Of Congo');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Italy', 'Standard', 600, 'GPRS - Intl Roaming - Italy');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Liberia', 'Standard', 600, 'GPRS - Intl Roaming - Liberia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Luxembourg', 'Standard', 600, 'GPRS - Intl Roaming - Luxembourg');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Moldova', 'Standard', 600, 'GPRS - Intl Roaming - Moldova');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Maldives', 'Standard', 600, 'GPRS - Intl Roaming - Maldives');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Macedonia', 'Standard', 600, 'GPRS - Intl Roaming - Macedonia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Malaysia', 'Standard', 600, 'GPRS - Intl Roaming - Malaysia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-New Zealand', 'Standard', 600, 'GPRS - Intl Roaming - New Zealand');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Oman', 'Standard', 600, 'GPRS - Intl Roaming - Oman');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Pakistan', 'Standard', 600, 'GPRS - Intl Roaming - Pakistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Puerto Rico', 'Standard', 600, 'GPRS - Intl Roaming - Puerto Rico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Advantage Cellular', 'Standard', 600, 'GPRS - Intl - Advantage Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'Intl - Pinpoint Wireless', 'Standard', 600, 'GPRS - Intl - Pinpoint Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Papua New Guinea', 'Standard', 600, 'GPRS - Intl Roaming - Papua New Guinea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Central African Republic', 'Standard', 600, 'GPRS - Intl Roaming - Central African Republic');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bermuda (AT&T Crusie Shi', 'Standard', 600, 'GPRS - Intl Roaming - Bermuda (AT&T Crusie Ship)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Ship', 'Standard', 600, 'GPRS - Intl Roaming - Ship');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Vanuatu', 'Standard', 600, 'GPRS - Intl Roaming - Vanuatu');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Wales', 'Standard', 600, 'GPRS - Intl Roaming - Wales');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Morocco', 'Standard', 600, 'GPRS - Intl Roaming - Morocco');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mexico', 'Standard', 600, 'GPRS - Intl Roaming - Mexico');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mongolia', 'Standard', 600, 'GPRS - Intl Roaming - Mongolia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Mauritius', 'Standard', 600, 'GPRS - Intl Roaming - Mauritius');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Malaysia', 'Standard', 600, 'GPRS - Intl Roaming - Malaysia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Nigeria', 'Standard', 600, 'GPRS - Intl Roaming - Nigeria');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Netherlands', 'Standard', 600, 'GPRS - Intl Roaming - Netherlands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Pakistan', 'Standard', 600, 'GPRS - Intl Roaming - Pakistan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Panama', 'Standard', 600, 'GPRS - Intl Roaming - Panama');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Senegal', 'Standard', 600, 'GPRS - Intl Roaming - Senegal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Turkey', 'Standard', 600, 'GPRS - Intl Roaming - Turkey');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Dobson Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Dobson Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - At&t Mobility', 'Standard', 600, 'GPRS - Intl Roaming - At&t Mobility');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Alaska Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Alaska Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Centennial', 'Standard', 600, 'GPRS - Intl Roaming - Centennial');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Easterbrooke Cellular', 'Standard', 600, 'GPRS - Intl Roaming - Easterbrooke Cellular');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Plateau', 'Standard', 600, 'GPRS - Intl Roaming - Plateau');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Pinpoint Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Pinpoint Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Corr Wireless', 'Standard', 600, 'GPRS - Intl Roaming - Corr Wireless');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Yemen', 'Standard', 600, 'GPRS - Intl Roaming - Yemen');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - South Africa', 'Standard', 600, 'GPRS - Intl Roaming - South Africa');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Congo Dr', 'Standard', 600, 'GPRS - Intl Roaming - Congo Dr');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Korea', 'Standard', 600, 'GPRS - Intl Roaming - Korea');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Kuwait', 'Standard', 600, 'GPRS - Intl Roaming - Kuwait');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Libya', 'Standard', 600, 'GPRS - Intl Roaming - Libya');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Lithuania', 'Standard', 600, 'GPRS - Intl Roaming - Lithuania');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Madagascar', 'Standard', 600, 'GPRS - Intl Roaming - Madagascar');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Nicaragua', 'Standard', 600, 'GPRS - Intl Roaming - Nicaragua');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Netherlands', 'Standard', 600, 'GPRS - Intl Roaming - Netherlands');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Nepal', 'Standard', 600, 'GPRS - Intl Roaming - Nepal');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - At\&\t Mobility', 'Standard', 600, 'GPRS - Intl Roaming - At\&\t Mobility');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - UK (Maritm Svc)', 'Standard', 600, 'GPRS - Intl Roaming - UK (Maritm Svc)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Italy (TIM Maritime Vssl', 'Standard', 600, 'GPRS - Intl Roaming - Italy (TIM Maritime Vssl)');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Saipan', 'Standard', 600, 'GPRS - Intl Roaming - Saipan');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Solavakia', 'Standard', 600, 'GPRS - Intl Roaming - Solavakia');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International- Ascension Island', 'Standard', 600, 'GPRS - Intl Roaming - Ascension Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Christmas Island', 'Standard', 600, 'GPRS - Intl Roaming - Christmas Island');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International-Vatican City', 'Standard', 600, 'GPRS - Intl Roaming - Vatican City');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Argentina', 'Standard', 600, 'GPRS - Intl Roaming - Argentina');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Antigua and Barbuda', 'Standard', 600, 'GPRS - Intl Roaming - Antigua and Barbuda');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Burkina Faso', 'Standard', 600, 'GPRS - Intl Roaming - Burkina Faso');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Bangladesh', 'Standard', 600, 'GPRS - Intl Roaming - Bangladesh');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Switzerland', 'Standard', 600, 'GPRS - Intl Roaming - Switzerland');

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION)
values (84, 'International - Colombia', 'Standard', 600, 'GPRS - Intl Roaming - Colombia');
COMMIT;