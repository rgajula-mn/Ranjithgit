update tmobile_custom.tmo_invoice_desc_ordering
set description = 'GPRS - Intl Roaming - Afghanistan'
where event_summary_id = 84 and cost_band_desc = 'International - Afghanistan'
and event_class_name = 'Standard' and order_num = 600
commit;