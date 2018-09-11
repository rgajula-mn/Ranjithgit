spool {0}.lst;
set trimspool on;
set define off;
set term on;
set echo on;
set timing on;
set time on;

/***
 Scripts {0}.sql Start */


{1}


commit;

/***
 Scripts {0}.sql End */

set time off;
set timing off;
set term off;
set echo off;
set define on;
spool off;