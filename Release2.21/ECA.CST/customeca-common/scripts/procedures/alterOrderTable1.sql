
update tmobile_custom.tmo_invoice_desc_ordering
set description = 'Airtime - WiFi'
where event_summary_id = 78 and event_class_name = 'Standard WiFi';

update tmobile_custom.tmo_invoice_desc_ordering
set description = 'Airtime - WiFi ILD'
where event_summary_id = 78 and event_class_name = 'Standard WiFi ILD';



update tmobile_custom.tmo_invoice_desc_ordering
set description = 'SMS - WiFi'
where event_summary_id = 79 and event_class_name = 'Standard WiFi';

update tmobile_custom.tmo_invoice_desc_ordering
set description = 'Airtime - Roaming ILD'
where event_summary_id = 78 and event_class_name = 'Roaming ILD';
commit;