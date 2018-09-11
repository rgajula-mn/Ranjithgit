  delete from tmobile_custom.tmo_invoice_desc_ordering where description = 'Airtime ILD - Chargeback' and event_summary_id = 87 
  and line_item_text = '%Airtime' and order_num = 197 and event_class_name = 'Standard' and cost_band_desc = 'Standard ChargeBack ILD';

 delete from tmobile_custom.tmo_invoice_desc_ordering 
where EVENT_SUMMARY_ID = 78 and COST_BAND_DESC = 'International%' and EVENT_CLASS_NAME = 'Roaming WiFi ILD' and ORDER_NUM = 197 and DESCRIPTION = 'Airtime - Roaming WiFi ILD' and LINE_ITEM_TEXT = '%Airtime';
  commit;