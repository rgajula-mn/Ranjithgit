#!/bin/ksh
# Shell script to run ECA sql files from command line.
# Pre-Req: sqlplus client shall be installed already.
# Run the command(eg: infinys.env) to set the environment variables used below
######################################################################
# Set Oracle variables
######################################################################
export ORACLE_HOME=$ORACLE_HOME
export ORACLE_SID=$ORACLE_SID
export PATH=$ORACLE_HOME/bin:$PATH
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
###########################################################
# Variables Section (DB Details)
###########################################################
export DB_HostName=$DB_HOST
export DB_Port=$DB_PORT
export DB_SID=$ORACLE_SID

##########################################################
# All Script Sqls Run Here
##########################################################
echo "`date`";
 
echo "Enter GENEVA_ADMIN UserName: "
read   username
echo "Enter GENEVA_ADMIN pwd: "
stty -echo
 read   pwd
 stty echo
echo

sqlplus $username/$pwd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=${DB_HostName})(PORT=${DB_Port})))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=${DB_SID}))) << EOF >> ECAsql.log
set echo off feed on
whenever oserror exit 3 rollback
@geneva_admin_grants_tables.sql
@alterGenevaAdminAccountPayAttr.sql
@grants_for_TMO_ADJUSTMENT_VIEW.sql
@grants_for_TMO_ADJUSTMENT_TYPEVIEW.sql
@grants_for_TMO_BILLINGHISTORY_VIEW.sql
@grants_for_TMO_EVENTTYPES_VIEW.sql
@grants_for_TMO_GLADJUSTTYPEMAPPING_VIEW.sql
@grants_for_TMO_PAYMENT_VIEW.sql
@grants_for_TMO_PROMOTIONDISCOUNT_VIEW.sql
@grants_for_TMO_TAXEXEMPTION_VIEW.sql
commit;
quit;
EOF

echo "Enter genevabatchuser UserName: "
read   username
echo "Enter genevabatchuser pwd: "
stty -echo
 read   pwd
 stty echo
sqlplus $username/$pwd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=${DB_HostName})(PORT=${DB_Port})))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=${DB_SID}))) << EOF >> ECAsql.log
set echo off feed on
whenever oserror exit 3 rollback
@create_duf_tables.sql
commit;
quit;
EOF

echo "Enter TMOBILE_CUSTOM UserName: "
read   username
echo "Enter TMOBILE_CUSTOM pwd: "
stty -echo
 read   pwd
 stty echo
sqlplus $username/$pwd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=${DB_HostName})(PORT=${DB_Port})))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=${DB_SID}))) << EOF >> ECAsql.log
set echo off feed on
whenever oserror exit 3 rollback
@bulkRequestTableAlter.sql 
@createBulkRequest.sql
@bulkRequestGrants.sql 
@TMO_INVOICE_DESC_ORDERING.sql
@InvoiceSectionDetails.sql
@Create_Line_item_tables.sql
@tmoCustomEventType.sql
@queryLineItemDetails1.sql
@queryLineItemDetails2.sql
@queryLineItemDetails3.sql
@CDRDetailsData.sql
@TOMS_OFFERNAMEMAPPING_LAST.sql
@create_TMO_INVdrilldown_pkg.sql
@TMO_TRANSACTIONDETAILS_Table.sql
@BILLING_HISTORY_VIEW.sql
@alterTmoTrasactionLog.sql
@insertToErrorLog.sql
@TMO_BILLINGPROFILE.pls
@TMO_BILLINGPROFILE.plb
@Create_TMO_BILLINGHISTORY_VIEW.sql
@Create_TMO_CCPC_VIEW.sql
@Create_TMO_GLACCOUNT_VIEW.sql
@Create_TMO_SKFCATEGORY_VIEW.sql
@Create_TMO_ADJUSTMENT_TYPEVIEW.sql
@Create_TMO_ADJUSTMENT_VIEW.sql
@Create_TMO_EVENTTYPES_VIEW.sql
@Create_TMO_PAYMENT_VIEW.sql
@Create_TMO_PROMOTIONDISCOUNT_VIEW.sql
@Create_TMO_TAXEXEMPTION_VIEW.sql
@Create_TMO_GLADJUSTMENTTYPEMAPPING_VIEW.sql
@update_tmo_dispadj_eventmapping_V80.sql
@GL_ACCOUNT_Migration_One_Time_Script.sql
@TMO_gllineitemtextmap_table_inserts.sql
@TMO_glrevenuecodemap_table_inserts.sql
@CSS_1974_create_tmobile_custom_tmorefdata_pkg.sql
commit;
quit;
EOF

echo "Enter GENEVA_ADMIN UserName: "
read username
echo "Enter GENEVA_ADMIN pwd: "
stty -echo
 read   pwd
 stty echo
sqlplus $username/$pwd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=${DB_HostName})(PORT=${DB_Port})))(CONNECT_DATA=(SERVER=DEDICATED)(SERVICE_NAME=${DB_SID}))) << EOF >> ECAsql.log
set echo off feed on
whenever oserror exit 3 rollback
@grantsCdrDetailsAPI.sql
@TMO_Gparams_TMOGENESIS26748.sql
@TMO_Gparams_TMOGENESIS28010.sql
commit;
quit;
EOF

echo "`date`";
