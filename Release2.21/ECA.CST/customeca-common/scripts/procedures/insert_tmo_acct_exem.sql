--delete existing data from TMO_ACCT_EXEMPTION---
delete  from TMOBILE_CUSTOM.TMO_ACCT_EXEMPTION;
--- insert data into tmo_acct_exemption---
insert into tmo_acct_exemption
with custref_exemtype as 
(
select acc.billing_cust_ref, aa.account_num, aa.exemption_type from 
tmobile_custom.tmo_acct_mapping acc,
geneva_admin.accountattributes aa
where acc.refactored_flag = 'T'
and aa.account_num = acc.billing_acct_nbr
and aa.exemption_type is not null
),
acc_exem_details as (
select min(start_dat) as start_dat, ce.exemption_type, ce.billing_cust_ref from custref_exemtype ce, geneva_admin.ustaccounthasexemption ue 
where ue.account_num = ce.account_num and ue.end_dat is null
group by ce.exemption_type, ce.billing_cust_ref
)
select billing_cust_ref, exemption_type, start_dat, null,'Completed', sysdate, 'RB' from 
acc_exem_details;
commit;