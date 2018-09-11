delete from  tmo_invoice_desc_ordering where event_summary_id in (88,89);
insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (88, 'NULL', 'Roaming', 340, 'SMS - Roaming', '%SMS Roaming');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (88, 'SMS%', 'Roaming', 340, 'SMS - Roaming', '%SMS Roaming');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (88, 'NULL', 'Standard', 340, 'SMS', '%SMS');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (88, 'SMS%', 'Standard', 340, 'SMS', '%SMS');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (88, 'NULL', 'Standard ILD', 340, 'SMS - ILD', '%SMS');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (88, 'SMS%', 'Standard ILD', 340, 'SMS - ILD', '%SMS');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (89, 'GPRS', 'Standard%', 570, 'GPRS', '%GPRS');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (89, 'GPRS', 'Roaming', 580, 'GPRS - Roaming', '%Data Roaming');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (89, 'GPRS', 'Roaming Tier L', 590, 'GPRS - Roaming Tier L', '%Data Roaming');

insert into tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (89, 'GPRS', 'Roaming Tier H', 590, 'GPRS - Roaming Tier H', '%Data Roaming');

COMMIT;


