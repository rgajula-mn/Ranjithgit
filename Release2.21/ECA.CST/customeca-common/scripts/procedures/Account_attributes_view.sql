CREATE OR REPLACE VIEW TMOBILE_CUSTOM.TMO_ACCOUNT_ATTRIBUTES_VIEW AS
SELECT T1.COLUMN_ID - 3 AS FIELDINDEX, T1.COLUMN_NAME AS FIELDNAME, DATA_LENGTH AS FIELDLENGTH
FROM ALL_TAB_COLUMNS T1
WHERE  T1.TABLE_NAME = 'ACCOUNTATTRIBUTES' AND T1.COLUMN_NAME NOT IN ('ACCOUNT_NUM', 'DOMAIN_ID');
GRANT SELECT ON TMOBILE_CUSTOM.TMO_ACCOUNT_ATTRIBUTES_VIEW TO UNIF_ADMIN;

CREATE OR REPLACE VIEW TMOBILE_CUSTOM.TMO_CUSTOM_TABLE_VIEW AS
SELECT T1.TABLE_NAME, T1.COLUMN_NAME,T1.DATA_TYPE ,T1.DATA_LENGTH 
FROM ALL_TAB_COLUMNS T1
WHERE  T1.TABLE_NAME = 'TMO_ACCT_MAPPING';
GRANT SELECT ON TMOBILE_CUSTOM.TMO_CUSTOM_TABLE_VIEW TO UNIF_ADMIN;

CREATE OR REPLACE VIEW TMOBILE_CUSTOM.TMO_THRESHOLD_ATTRIBUTES
AS 
select e.event_type_id, ee.* --,eta.attr_name
from eventtype e,
(select replace(p.plugin_name, '_EEAWPI', '') event_type_name,
pi.plugin_input_id + 36 Attr_NUM,
pi. plugin_input_name
from geneva_admin.plugin p, geneva_admin.plugininput pi
where plugin_name like 'Genesis%EEAWPI'
and p.plugin_id = pi.plugin_id
and pi.ignore_boo ='F'
and pi.plugin_input_name not like 'Avail%') ee
where e.event_type_name = ee.event_type_name
and e.event_type_id in (43, 44, 45)
union
select et.event_type_id,
et.event_type_name,
eta.event_attr_num Attr_NUM,
eta.attr_name
from eventtype et, eventtypeattribute eta
where et.event_type_id = eta.event_type_id
and et.event_type_id = 45
and eta.attr_name = ('Total Volume')
union
select et. event_type_id,
et.event_type_name,
eta.event_attr_num Attr_NUM,
eta.attr_name
from eventtype et, eventtypeattribute eta
where et.event_type_id = eta.event_type_id
and et.event_type_id = 44
and eta.attr_name = ('Number of Events')
union
select et. event_type_id,
et.event_type_name,
eta.event_attr_num Attr_NUM,
eta.attr_name
from eventtype et, eventtypeattribute eta
where et.event_type_id = eta.event_type_id
and et.event_type_id = 43
and eta.attr_name = ('Duration');