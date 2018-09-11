CREATE OR REPLACE VIEW TMOBILE_CUSTOM.TMO_TAX_JCODES_VIEW AS
select 1 TAX_AUTH,
       '000000000' JCODE,
       'US' STATE_CODE,
       null COUNTY_NAME,
       null CITY_NAME
  from dual
union all
select 2 TAX_AUTH,
       to_char(LOCGEOSTATE, 'FM00') || '0000000',
       LOCABBREVSTATE,
       null,
       null
  from GENEVA_ADMIN.locstate
union all
select 3 TAX_AUTH,
       to_char(LOCGEOSTATE, 'FM00') || to_char(LOCGEOCOUNTY, 'FM000') ||
       '0000',
       LOCABBREVSTATE,
       LOCNAMECOUNTY,
       null
  from GENEVA_ADMIN.locstate
  join GENEVA_ADMIN.loccounty
 using (locgeostate)
union all
select 4 TAX_AUTH,
       to_char(LOCGEOSTATE, 'FM00') || to_char(LOCGEOCOUNTY, 'FM000') ||
       to_char(LOCGEOCITY, 'FM0000'),
       LOCABBREVSTATE,
       LOCNAMECOUNTY,
       locnamecity
  from GENEVA_ADMIN.locstate
  join GENEVA_ADMIN.loccounty
 using (locgeostate)
  join (select locgeostate,
               locgeocounty,
               locgeocity,
               max(locnamecity) locnamecity
          from GENEVA_ADMIN.loccity
         where loccitynametype in (3, 5)
         group by locgeostate, locgeocounty, locgeocity) loccity
 using (locgeostate, locgeocounty);
CREATE OR REPLACE PUBLIC SYNONYM TMO_TAX_JCODES_VIEW FOR TMOBILE_CUSTOM.TMO_TAX_JCODES_VIEW;
GRANT SELECT ON TMOBILE_CUSTOM.TMO_TAX_JCODES_VIEW TO PUBLIC;
 