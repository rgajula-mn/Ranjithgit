spool version.lst;
set trimspool on;
set define off;
set term on;
set echo on;
set timing on;
set time on;

@component_version.sql

set time off;
set timing off;
set term off;
set echo off;
set define on;
spool off;