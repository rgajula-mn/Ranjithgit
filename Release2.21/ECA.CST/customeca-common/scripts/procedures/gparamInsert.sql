set feedback off
set define off
insert into geneva_admin.gparams (NAME, TYPE, START_DTM, STRING_VALUE, INTEGER_VALUE)
values ('PartnerOnBoardingTestAccount', 'STRING', to_date('01/01/2018','MM/DD/YYYY'), 'T', null);
insert into geneva_admin.gparams (NAME, TYPE, START_DTM, STRING_VALUE, INTEGER_VALUE)
values ('POBcustomerRefPrefix', 'STRING', to_date('01/01/2018','MM/DD/YYYY'), 'CUSTT', null);
insert into geneva_admin.gparams (NAME, TYPE, START_DTM, STRING_VALUE, INTEGER_VALUE)
values ('POBAccountNumPrefix', 'STRING', to_date('01/01/2018','MM/DD/YYYY'), 'ACCT', null);
insert into geneva_admin.gparams (NAME, TYPE, START_DTM, STRING_VALUE, INTEGER_VALUE)
values ('POBCatalogueChangeStatusType', 'INTEGER', to_date('01/01/2018','MM/DD/YYYY'), null, 3);
insert into geneva_admin.gparams (NAME, TYPE, START_DTM, STRING_VALUE, INTEGER_VALUE)
values ('POBUseSequence', 'STRING', to_date('01/01/2018','MM/DD/YYYY'), 'F', null);
commit;

