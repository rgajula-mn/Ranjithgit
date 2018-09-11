update tmobile_custom.tmo_invoice_desc_ordering
set order_num = 320
where event_summary_id = 79 and event_Class_name = 'Roaming';
update tmobile_custom.tmo_invoice_desc_ordering
set order_num = 400
where event_summary_id = 81;
COMMIT;