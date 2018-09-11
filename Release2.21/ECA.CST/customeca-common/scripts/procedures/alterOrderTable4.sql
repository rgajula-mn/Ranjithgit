delete  tmobile_custom.tmo_invoice_desc_ordering where event_summary_id = 87 and cost_band_desc = 'Standard ChargeBack ILD' and event_class_name = 'Standard'
and description = 'Airtime ILD - Chargeback' and line_item_text = '%Airtime' ;
commit;