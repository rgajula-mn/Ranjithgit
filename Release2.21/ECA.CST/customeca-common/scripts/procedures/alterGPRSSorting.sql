update tmobile_custom.tmo_invoice_desc_ordering
set order_num = 570
where event_summary_id = 89 and event_Class_name = 'Standard%';
update tmobile_custom.tmo_invoice_desc_ordering
set order_num = 580
where event_summary_id = 89 and event_Class_name = 'Roaming%';
COMMIT;