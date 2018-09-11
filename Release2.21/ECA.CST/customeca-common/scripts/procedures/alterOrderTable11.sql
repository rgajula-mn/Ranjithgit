update tmobile_custom.tmo_invoice_desc_ordering
set description = 'Airtime - Intl Roaming - Sao Tome'
where event_summary_id = 82 and cost_band_desc = 'International - Sao Tome';
commit;