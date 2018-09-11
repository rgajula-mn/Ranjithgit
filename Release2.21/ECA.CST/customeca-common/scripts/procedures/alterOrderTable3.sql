set feedback off
set define off
insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (89, 'GPRS', 'Premium1', 570, 'GPRS', '%GPRS');
insert into tmobile_custom.tmo_invoice_desc_ordering (EVENT_SUMMARY_ID, COST_BAND_DESC, EVENT_CLASS_NAME, ORDER_NUM, DESCRIPTION, LINE_ITEM_TEXT)
values (89, 'GPRS', 'Premium2', 570, 'GPRS', '%GPRS');

commit;