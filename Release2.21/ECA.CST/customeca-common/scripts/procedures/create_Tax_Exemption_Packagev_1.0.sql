---- "TMOBILE_CUSTOM"."TMO_TAX_EXEMPTION_PKG" ---
-- @author Hanmanth Reddy ----

CREATE OR REPLACE EDITIONABLE PACKAGE "TMOBILE_CUSTOM"."TMO_TAX_EXEMPTION_PKG" 
AS
  Procedure load_tax_exemption(p_customer_ref   varchar,
                               p_exemption_type varchar,
                               p_start_date     varchar,
                               p_end_date       varchar,
							   p_createdByUser varchar,
							   p_status out varchar,
							   p_description out varchar);
  Procedure delete_tax_exemption(p_customer_ref   varchar,
                               p_exemption_type varchar,
							   p_status out varchar,
							   p_description out varchar);
  
END TMO_TAX_EXEMPTION_PKG;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "TMOBILE_CUSTOM"."TMO_TAX_EXEMPTION_PKG" AS
v_account_num GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.ACCOUNT_NUM%type;
v_start_date  varchar2(20);
v_end_date    varchar2(20);
TYPE record_type is record(
   state_code GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.STATE_CODE%type,
   tax_type   GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXTERNAL_TAX_TYPE_ID%type);
TYPE jcode_type is record(
   JCODE       GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_JCODE%type,
   COUNTY_NAME GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.COUNTY_NAME%type,
   CITY_NAME   GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.CITY_NAME%type);
TYPE state_taxType_type IS TABLE OF record_type;
TYPE tax_auth_type IS TABLE OF GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_TAX_AUTHORITY%type;
TYPE tax_jcode_type IS TABLE OF jcode_type;
v_state_taxType_list state_taxType_type;
    
  --- jcode map---
FUNCTION get_Jcode_Map( v_state_code varchar,
                        v_tax_auth number,
                        v_jcode varchar) 
RETURN tax_jcode_type AS
  tax_jcode_list tax_jcode_type;
  v_aux_tax_auth GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_TAX_AUTHORITY%type := v_tax_auth;
  v_aux_jcode varchar2(20) := v_jcode;
BEGIN 
  if (v_aux_tax_auth = 5 or v_aux_tax_auth = 7) then
    v_aux_tax_auth := 3;
  elsif (v_aux_tax_auth = 6 or v_aux_tax_auth = 8) then
    v_aux_tax_auth := 4;
  end if;
  if v_aux_jcode is not null then
    if v_aux_tax_auth = 2 then
      v_aux_jcode := substr(v_jcode, 0, 2) || '0000000';
    elsif v_aux_tax_auth = 3 then
      v_aux_jcode := substr(v_jcode, 0, 5) || '0000';
    end if;
    select jcode, county_name, city_name bulk collect
      into tax_jcode_list
      from tmobile_custom.tmo_tax_jcodes_view
     where tax_auth = v_aux_tax_auth
       and state_code = v_state_code
       and jcode = v_aux_jcode;
  else
    select jcode, county_name, city_name bulk collect
      into tax_jcode_list
      from tmobile_custom.tmo_tax_jcodes_view
     where tax_auth = v_aux_tax_auth
       and state_code = v_state_code;
  end if;
  return tax_jcode_list;
END get_Jcode_Map;

-- check tax auth condition --
FUNCTION check_Tax_Auth_Condition(v_tax_auth_list tax_auth_type)
  RETURN varchar
  AS
  v_incallsubauth varchar2(1);
BEGIN
  if 2 member of v_tax_auth_list and 3 member of v_tax_auth_list and 4
   member of v_tax_auth_list and 7 member of v_tax_auth_list and 8 member of
   v_tax_auth_list then
    v_incallsubauth := 'T';
  else
    v_incallsubauth := 'F';
  end if;
  return v_incallsubauth;
end check_Tax_Auth_Condition;

-- get tax auth values---
PROCEDURE get_Tax_Auth_Map(v_exemption_type varchar,
                           p_state_code varchar,
                           p_tax_type varchar,
                           p_tax_auth_list out tax_auth_type,
                           p_incall_sub_auth out varchar) AS
BEGIN
  select distinct tax_auth bulk collect
    into p_tax_auth_list
    from tmobile_custom.tmo_tax_exemption
   where exemption_type = v_exemption_type
     and decode(tax_auth, 1, 'US', state_code) = p_state_code
     and tax_type = p_tax_type;
  p_incall_sub_auth := check_Tax_Auth_Condition(p_tax_auth_list);
  if p_incall_sub_auth = 'T' then
    for y in 1 .. p_tax_auth_list.count loop
      if (p_tax_auth_list(y) > 2) then
        p_tax_auth_list.delete(y);
      end if;
    end loop;
  end if;
end get_Tax_Auth_Map;

-- getexemptionMap returns combination of state code and tax type ---
FUNCTION get_Exemption_Map( v_exemption_type varchar,  v_state_code VARCHAR)
  RETURN state_taxType_type AS
BEGIN
dbms_output.put_line('get_Exemption_Map starting');
  if v_state_code is not null then
	   with statecode_taxtype as (
          select distinct te.state_code ,te.tax_type 
          from tmobile_custom.tmo_tax_exemption te
          where te.exemption_type = v_exemption_type
          and te.state_code = v_state_code
		  and te.tax_auth != 1
           union 
          select distinct decode(te.tax_auth, 1, 'US', te.state_code) state_code ,te.tax_type 
          from tmobile_custom.tmo_tax_exemption te
          where te.exemption_type = v_exemption_type
		  and te.tax_auth = 1
          )
	  select state_code, tax_type bulk collect
      into v_state_taxType_list
	  from statecode_taxtype;
  else
    select distinct decode(te.tax_auth, 1, 'US', te.state_code) state_code,
                    te.tax_type bulk collect
      into v_state_taxType_list
      from tmobile_custom.tmo_tax_exemption te
     where te.exemption_type = v_exemption_type;
  end if;
  dbms_output.put_line('get_Exemption_Map ended');
  return v_state_taxType_list;
end get_Exemption_Map;

-- update exemption type value in accountattributes table for given account num --
Procedure update_acct_tax_type(p_exemption_type varchar, p_updated_status out varchar)
AS
affectedRecords number(1);
BEGIN
 dbms_output.put_line('update_acct_tax_type starting');
update geneva_admin.accountattributes set exemption_type= p_exemption_type 
where account_num= v_account_num;
affectedRecords := SQL%ROWCOUNT;
commit;
if affectedRecords = 1 then 
p_updated_status := 'Success';
else
p_updated_status := 'Fail'; 
end if;
dbms_output.put_line('update_acct_tax_type ended');
END update_acct_tax_type;

-- Function add tax exemption ----
Procedure add_tax_exemption( p_exemption_type varchar,  p_status in out varchar, p_description in out varchar ) AS
  v_state_code      GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.STATE_CODE%type;
  v_tax_type        GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXTERNAL_TAX_TYPE_ID%type;
  v_tax_auth        GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_TAX_AUTHORITY%type;
  v_incall_sub_auth VARCHAR2(1);
  v_tax_auth_list   tax_auth_type;
  v_tax_jcode_list  tax_jcode_type;
  v_jcode           GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_JCODE%type;
  v_county_name     GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.COUNTY_NAME%type;
  v_city_name       GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.CITY_NAME%type;
  v_updated_status varchar2(20);
  v_acct_jcode varchar2(20);
  v_exemptionSeq INTEGER;
BEGIN
dbms_output.put_line('add_tax_exemption started');
p_status := 'Error';
  if (p_exemption_type = 'RI') then
    select address_4, ust_jcode
      into v_state_code, v_acct_jcode
      from tmobile_custom.tmo_acct_mapping tam, geneva_admin.address a
     where tam.billing_acct_nbr = v_account_num
       and a.customer_ref = tam.billing_cust_ref
       and a.address_seq =
           (select max(address_seq)
              from geneva_admin.address x
             where x.customer_ref = tam.billing_cust_ref);
     v_state_taxType_list := get_Exemption_Map(p_exemption_type, v_state_code);
  else
    v_state_taxType_list := get_Exemption_Map(p_exemption_type,null);
  end if;
  for x in 1 .. v_state_taxType_list.count loop
    v_state_code := v_state_taxType_list(x).state_code;
    v_tax_type   := v_state_taxType_list(x).tax_type;
    get_Tax_Auth_Map(p_exemption_type,
                     v_state_code,
                     v_tax_type,
                     v_tax_auth_list,
                     v_incall_sub_auth);
    for y in 1 .. v_tax_auth_list.count loop
      v_tax_auth := v_tax_auth_list(y);
      if v_tax_auth = 1 then
	    v_state_code  := null;
        v_jcode       := null;
        v_county_name := null;
        v_city_name   := null;
		v_incall_sub_auth := 'F';
        -- call procedure gnvtax.addAccountUSTexemption1NC
        geneva_admin.gnvtax.addAccountUSTexemption1NC(
		   v_account_num,
           to_date(v_start_date,'MM/DD/YYYY'),
           to_date(v_end_date,'MM/DD/YYYY'),
           null,
           1,
           v_tax_type,
           v_tax_auth,
           v_incall_sub_auth,
           v_state_code,
           v_county_name,
           v_city_name,
           v_jcode,
		   v_exemptionSeq); 
      else
        v_tax_jcode_list := get_Jcode_Map(v_state_code, v_tax_auth, v_acct_jcode);
        for z in 1 .. v_tax_jcode_list.count loop
          v_jcode       := v_tax_jcode_list(z).JCODE;
          v_county_name := v_tax_jcode_list(z).COUNTY_NAME;
          v_city_name   := v_tax_jcode_list(z).CITY_NAME;
      -- call procedure gnvtax.addAccountUSTexemption1NC
          geneva_admin.gnvtax.addAccountUSTexemption1NC(
		     v_account_num,
             to_date(v_start_date,'MM/DD/YYYY'),
             to_date(v_end_date,'MM/DD/YYYY'),
             null,
             1,
             v_tax_type,
             v_tax_auth,
             v_incall_sub_auth,
             v_state_code,
             v_county_name,
             v_city_name,
             v_jcode,
			 v_exemptionSeq);
        end loop;
      end if;
    end loop;
  end loop;
   commit;
  update_acct_tax_type(p_exemption_type,v_updated_status);
  if v_updated_status = 'Success' then
  p_status := 'Completed';
  end if;
  dbms_output.put_line('add_tax_exemption ended');
EXCEPTION
  when others then
    p_status := 'Error';
	p_description := sqlerrm;
	dbms_output.put_line('in add error' || sqlerrm);
END add_tax_exemption;

--- modify acct tax exemption --
Procedure modify_tax_exemption(p_exemption_type  varchar,
                               p_exist_exem_type_boolean  boolean,
                               p_status     in   out varchar,
							   p_description in out varchar)
AS
v_limit constant  number := 10000;
type exist_exem_list_type is table of geneva_admin.ustaccounthasexemption%rowtype
 index by pls_integer;
v_modify_exem_list exist_exem_list_type;
cursor acc_exem_cur(v_acc_num varchar, v_date date) is 
select * from geneva_admin.ustaccounthasexemption
where account_num = v_acc_num and (end_dat is null or end_dat > v_date);

begin
  p_status := 'Error';
    open acc_exem_cur(V_account_num,to_date(v_start_date,'MM/DD/YYYY')-1);
	if p_exist_exem_type_boolean then 
	loop
      fetch acc_exem_cur bulk collect
        into v_modify_exem_list limit v_limit;
      for x in 1 .. v_modify_exem_list.count loop
        geneva_admin.gnvtax.modifyAccountUSTexemption1NC(
                V_account_num,
                v_modify_exem_list(x).EXEMPTION_SEQ,
                v_modify_exem_list(x).START_DAT,
                --v_modify_exem_list(x).END_DAT,
				to_date(v_end_date,'MM/DD/YYYY'),-- new end date. Remaining all old values are same
                v_modify_exem_list(x).EXEMPTION_REF,
                v_modify_exem_list(x).UST_CHARGE_GROUP_ID,
                v_modify_exem_list(x).EXTERNAL_TAX_TYPE_ID,
                v_modify_exem_list(x).EXEMPTION_TAX_AUTHORITY,
                v_modify_exem_list(x).ALL_SUBORDINATE_AUTHS_BOO,
                v_modify_exem_list(x).STATE_CODE,
                v_modify_exem_list(x).COUNTY_NAME,
                v_modify_exem_list(x).CITY_NAME,
                v_modify_exem_list(x).EXEMPTION_JCODE,
                v_modify_exem_list(x).START_DAT,
                v_modify_exem_list(x).END_DAT,
                v_modify_exem_list(x).EXEMPTION_REF,
                v_modify_exem_list(x).UST_CHARGE_GROUP_ID,
                v_modify_exem_list(x).EXTERNAL_TAX_TYPE_ID,
                v_modify_exem_list(x).EXEMPTION_TAX_AUTHORITY,
                v_modify_exem_list(x).ALL_SUBORDINATE_AUTHS_BOO,
                v_modify_exem_list(x).STATE_CODE,
                v_modify_exem_list(x).COUNTY_NAME,
                v_modify_exem_list(x).CITY_NAME,
                v_modify_exem_list(x).EXEMPTION_JCODE);
      end loop;
      exit when v_modify_exem_list.count < v_limit;
    end loop;
    commit;
    close acc_exem_cur;
	p_status := 'Completed';
	else 
    loop
      fetch acc_exem_cur bulk collect
        into v_modify_exem_list limit v_limit;
      for x in 1 .. v_modify_exem_list.count loop
        geneva_admin.gnvtax.modifyAccountUSTexemption1NC(
                V_account_num,
                v_modify_exem_list(x).EXEMPTION_SEQ,
                v_modify_exem_list(x).START_DAT,
                --v_modify_exem_list(x).END_DAT,
				to_date(v_start_date,'MM/DD/YYYY')-1,-- new end date. Remaining all old values are same
                v_modify_exem_list(x).EXEMPTION_REF,
                v_modify_exem_list(x).UST_CHARGE_GROUP_ID,
                v_modify_exem_list(x).EXTERNAL_TAX_TYPE_ID,
                v_modify_exem_list(x).EXEMPTION_TAX_AUTHORITY,
                v_modify_exem_list(x).ALL_SUBORDINATE_AUTHS_BOO,
                v_modify_exem_list(x).STATE_CODE,
                v_modify_exem_list(x).COUNTY_NAME,
                v_modify_exem_list(x).CITY_NAME,
                v_modify_exem_list(x).EXEMPTION_JCODE,
                v_modify_exem_list(x).START_DAT,
                v_modify_exem_list(x).END_DAT,
                v_modify_exem_list(x).EXEMPTION_REF,
                v_modify_exem_list(x).UST_CHARGE_GROUP_ID,
                v_modify_exem_list(x).EXTERNAL_TAX_TYPE_ID,
                v_modify_exem_list(x).EXEMPTION_TAX_AUTHORITY,
                v_modify_exem_list(x).ALL_SUBORDINATE_AUTHS_BOO,
                v_modify_exem_list(x).STATE_CODE,
                v_modify_exem_list(x).COUNTY_NAME,
                v_modify_exem_list(x).CITY_NAME,
                v_modify_exem_list(x).EXEMPTION_JCODE);
      end loop;
      exit when v_modify_exem_list.count < v_limit;
    end loop;
    commit;
    close acc_exem_cur;
  add_tax_exemption( p_exemption_type ,  p_status, p_description);
  end if;
EXCEPTION
  when others then
    p_status := 'Error';
	p_description := sqlerrm;
	dbms_output.put_line('in modify error' || sqlerrm);
END modify_tax_exemption;

-- update_acct_status --
Procedure update_acct_status(p_customer_ref   varchar,
                             p_exemption_type  varchar,
							 p_new_status varchar,
							 p_createdByUser varchar,
							 p_status out varchar,
							 p_description in out varchar)
AS
affectedRecords number(1);
v_customer_ref varchar2(20);
v_exem_type GENEVA_ADMIN.ACCOUNTATTRIBUTES.EXEMPTION_TYPE%type;
v_status varchar2(20);
v_updated_boolean boolean := false;
BEGIN
select customer_ref, exemption_type, status
    into v_customer_ref, v_exem_type, v_status
    from tmobile_custom.tmo_acct_exemption
   where customer_ref = p_customer_ref;
 if p_new_status = 'Processing' then
  if v_status = 'Processing' then
    p_status := 'Fail';
	p_description := 'Previous request for this customer is still processsing. Please try after few seconds';
  else 
  v_updated_boolean := true;
  end if;
  else 
  v_updated_boolean := true;
  end if;
  if v_updated_boolean then 
    update tmobile_custom.tmo_acct_exemption A
       set A.exemption_type = p_exemption_type,
           A.status         = p_new_status,
           A.Createdbyuser  = p_createdByUser,
		   A.last_modified_date = sysdate,
		   A.exemption_start_date = nvl(to_date(v_start_date, 'MM/DD/YYYY'),to_date(to_char(sysdate,'MM/DD/YYYY'),'MM/DD/YYYY')),
		   A.exemption_end_date = to_date(v_end_date,'MM/DD/YYYY')
     where A.customer_ref = v_customer_ref;
    affectedRecords := SQL%ROWCOUNT;
    commit;
    if affectedRecords = 1 then
      p_status := 'Success';
    else
      p_status := 'Fail';
	  p_description := 'Unable to update account exemption table';
    end if;
  end if;
  dbms_output.put_line('status is : ' || p_status);
exception
  when no_data_found then
    begin
      insert into tmobile_custom.tmo_acct_exemption
        (customer_ref,
         exemption_type,
         exemption_start_date,
         exemption_end_date,
         status,
         last_modified_date,
         createdbyuser)
      values
        (p_customer_ref,
         p_exemption_type,
         nvl(to_date(v_start_date, 'MM/DD/YYYY'),to_date(to_char(sysdate,'MM/DD/YYYY'),'MM/DD/YYYY')),
         to_date(v_end_date,'MM/DD/YYYY'),
         p_new_status,
         sysdate,
         p_createdByUser);
      affectedRecords := SQL%ROWCOUNT;
      commit;
      if affectedRecords = 1 then
        p_status := 'Success';
      else
        p_status := 'Fail';
		p_description := 'Unable to insert record into account exemption table';
      end if;
      --dbms_output.put_line('status is : ' || p_status);
    exception
      when others then
        p_status := 'Fail';
		p_description := sqlerrm;
    end;
    dbms_output.put_line('status is : ' || p_status);
END update_acct_status;

---- add/modify exemptions ---
PROCEDURE load_tax_exemption(p_customer_ref   varchar,
                             p_exemption_type varchar,
                             p_start_date     varchar,
                             p_end_date       varchar,
                             p_createdByUser  varchar,
                             p_status         out varchar,
                             p_description    out varchar) AS

  v_exist_exem_type    GENEVA_ADMIN.ACCOUNTATTRIBUTES.EXEMPTION_TYPE%type;
  v_updated_status     varchar2(20);
  v_correct_start_date varchar2(20);
  v_new_exem_count number;
  v_exist_exem_type_boolean boolean := false;
BEGIN
  p_status     := 'Error';
  v_start_date := p_start_date;
  v_end_date   := p_end_date;
  select distinct account_num, exemption_type
    into V_account_num, v_exist_exem_type
    from tmobile_custom.tmo_acct_mapping acct,
         geneva_admin.accountattributes  aa
   where acct.billing_cust_ref = p_customer_ref
     and acct.refactored_flag = 'T'
     and aa.account_num = acct.billing_acct_nbr;
  select to_char(NVL(LAST_BILL_DTM + 1, INC_MONTHS(NEXT_BILL_DTM, -1)),
                 'MM/DD/YYYY')
    into v_correct_start_date
    from account
   where account_num = V_account_num;
   select count(*)
      into v_new_exem_count
      from  geneva_admin.ustaccounthasexemption
     where account_num = V_account_num
       and start_dat >= to_date(v_correct_start_date, 'MM/DD/YYYY');
   if (v_exist_exem_type is not null and v_exist_exem_type != p_exemption_type and v_new_exem_count >0) then
    p_description := ' Cannot perform Modify operation because exemptions are active for current/future billcycle rather use delete tax API ';
    p_status      := 'Error';
  elsif (v_correct_start_date != v_start_date) then
    p_description := ' start date should be equal to ' ||
                     v_correct_start_date;
    p_status      := 'Error';
  elsif (to_date(v_end_date, 'MM/DD/YYYY') < to_date(v_start_date, 'MM/DD/YYYY')) then
    p_description := ' end date should be greater than or equal to start date ';
    p_status      := 'Error';
  else
    update_acct_status(p_customer_ref,
                       p_exemption_type,
                       'Processing',
                       p_createdByUser,
                       v_updated_status,
                       p_description);
    if (v_updated_status != 'Success') then
      p_status := 'Error';
    else
      if (v_exist_exem_type is null) then
        add_tax_exemption(p_exemption_type, p_status, p_description);
      else
		if (v_exist_exem_type = p_exemption_type) then 
			v_exist_exem_type_boolean := true;
		end if;
        modify_tax_exemption(p_exemption_type, v_exist_exem_type_boolean, p_status, p_description);
      end if;
    end if;
    update_acct_status(p_customer_ref,
                       p_exemption_type,
                       p_status,
                       p_createdByUser,
                       v_updated_status,
                       p_description);
	if p_status = 'Completed' and v_exist_exem_type_boolean then 
	p_description := 'Modified end date for existing tax exemptions for requested customer';
	elsif  p_status = 'Completed' then
	p_description := 'Successfully added/Modified tax exemptions for requested customer';
	end if;
  end if;
EXCEPTION
  when no_data_found then
    p_status      := 'Error';
    p_description := 'Customer is not found or not refactored';
    dbms_output.put_line('in load error' || sqlerrm);
  when others then
    p_description := sqlerrm;
    p_status      := 'Error';
    dbms_output.put_line('in load error' || sqlerrm);
    update_acct_status(p_customer_ref,
                       p_exemption_type,
                       'Error',
                       p_createdByUser,
                       v_updated_status,
                       p_description);
END load_tax_exemption;

-- delete account  details from tmo_acct_exemption table---

Procedure delete_acct_status(p_customer_ref   varchar,
                             p_exemption_type  varchar,
							 p_status out varchar)
AS
affectedRecords number(1);
BEGIN
delete tmobile_custom.tmo_acct_exemption  where customer_ref = p_customer_ref 
and exemption_type= p_exemption_type;
affectedRecords := SQL%ROWCOUNT;
commit;
if affectedRecords = 1 then 
p_status := 'Success';
else
p_status := 'Fail'; 
end if;
EXCEPTION
  when others then
    p_status := 'Fail';
END delete_acct_status;

---- delete exemption ----
Procedure delete_tax_exemption(p_customer_ref   VARCHAR,
                               p_exemption_type VARCHAR,
                               p_status         out varchar,
                               p_description    out varchar) AS
  v_updated_status  varchar2(20);
  v_exist_exem_type GENEVA_ADMIN.ACCOUNTATTRIBUTES.EXEMPTION_TYPE%type;
  v_limit           constant number := 10000;
  v_required_date   date;
  v_old_exem_count  number;
  type acc_exemseq_type is record(
    account_num   GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.ACCOUNT_NUM%type,
    exemption_seq GENEVA_ADMIN.USTACCOUNTHASEXEMPTION.EXEMPTION_SEQ%type);
  type exem_list_type is table of acc_exemseq_type index by pls_integer;
  v_exem_list exem_list_type;
  cursor acc_exem_cur(v_acc_num varchar, v_date date) is
    select account_num, exemption_seq
      from geneva_admin.ustaccounthasexemption
     where account_num = v_acc_num
       and start_dat >= v_date;

begin
  p_status := 'Error';
  select distinct account_num, exemption_type
    into v_account_num, v_exist_exem_type
    from tmobile_custom.tmo_acct_mapping acct,
         geneva_admin.accountattributes  aa
   where acct.billing_cust_ref = p_customer_ref
     and acct.refactored_flag = 'T'
     and aa.account_num = acct.billing_acct_nbr;
  if (v_exist_exem_type is null) then
    p_description := 'The requested customer is not associated with any exemption type';
  elsif (v_exist_exem_type != p_exemption_type) then
    p_description := 'The exemption type ' || p_exemption_type ||
                     ' passed in the request is incorrect and correct one is ' ||
                     v_exist_exem_type || ' for requested customer';
  else
    select nvl(last_bill_dtm + 1, inc_months(next_bill_dtm, -1))
      into v_required_date
      from account
     where account_num = V_account_num;
    select count(*)
      into v_old_exem_count
      from  geneva_admin.ustaccounthasexemption
     where account_num = V_account_num
       and start_dat < v_required_date
       and (end_dat is null or end_dat >= v_required_date);
    if v_old_exem_count > 0 then
      p_status      := 'Error';
      p_description := ' Cannot delete tax exemptions which were part of previous bill cycle. ';
    else
      update_acct_status(p_customer_ref,
                         p_exemption_type,
                         'Processing',
                         'PortalUser',
                         v_updated_status,
                         p_description);
      if (v_updated_status != 'Success') then
        p_status := 'Error';
      else
        open acc_exem_cur(V_account_num, v_required_date);
        loop
          fetch acc_exem_cur bulk collect
            into v_exem_list limit v_limit;
          for x in 1 .. v_exem_list.count loop
            GNVTAX.DELETEACCOUNTUSTEXEMPTION1NC(v_exem_list(x).account_num,
                                                v_exem_list(x).exemption_seq);
          end loop;
          exit when v_exem_list.count < v_limit;
        end loop;
        commit;
        close acc_exem_cur;
        update_acct_tax_type(null, v_updated_status);
        if (v_updated_status = 'Success') then
          delete_acct_status(p_customer_ref,
                             p_exemption_type,
                             v_updated_status);
          if (v_updated_status = 'Success') then
            p_status      := 'Completed';
            p_description := 'Successfully deleted all active exemption records';
          end if;
        end if;
      end if;
    end if;
  end if;
EXCEPTION
  when no_data_found then
    p_description := 'customer is not found or not refactored';
    dbms_output.put_line('in delete error' || sqlerrm);
  when others then
    p_description := sqlerrm;
    dbms_output.put_line('in delete error' || sqlerrm);
end delete_tax_exemption;

END TMO_TAX_EXEMPTION_PKG;
/
grant execute on TMOBILE_CUSTOM.TMO_TAX_EXEMPTION_PKG to genevabatchuser,geneva_admin, unif_admin;
