BEGIN
insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (84, 'International - Monseratt', 'Standard', 600, 'GPRS - Intl Roaming - Monseratt', '%Data Roaming');
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN
insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (84, 'International - Montserrat', 'Standard', 600, 'GPRS - Intl Roaming - Montserrat', '%Data Roaming');
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN
insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (82, 'International - Montserrat', 'Standard', 200, 'Airtime - Intl Roaming - Montserrat', '%Voice Roaming');
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN

insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (83, 'International-Montserrat', 'Standard', 375, 'SMS - International-Montserrat', '%SMS Roaming');
COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN

insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (84, 'International - Sao Tome & Principe', 'Standard', 600, 'GPRS - Intl Roaming - Sao Tome & Principe', '%Data Roaming'); 
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN

insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (83, 'International-Sao Tome', 'Standard', 375, 'SMS - International-Sao Tome', '%SMS Roaming');
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN
insert into TMOBILE_CUSTOM.TMO_INVOICE_DESC_ORDERING (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (84, 'International - Monserrat', 'Standard', 600, 'GPRS - Intl Roaming - Monserrat', '%Data Roaming');
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN
insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (82, 'International - Monserrat', 'Standard', 200, 'Airtime - Intl Roaming - Monserrat', '%Voice Roaming');
  COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/

BEGIN

insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (83, 'International-Monserrat', 'Standard', 375, 'SMS - International-Monserrat', '%SMS Roaming');
COMMIT;
  
 EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/