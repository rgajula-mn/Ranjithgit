--Checks tmobile_custom user present in genevauser table---
declare
v_cnt number;
C_TMOBILE_CUSTOM_USER     CONSTANT VARCHAR2(20) := 'TMOBILE_CUSTOM';
C_LANGUAGE_ID             CONSTANT NUMBER := 7;
C_ENCRYPT_PASSWORD_BOO    CONSTANT VARCHAR2(1) := 'F';
begin
select count(1)
  into v_cnt
  from geneva_admin.genevauser
 where upper(geneva_user_ora) = C_TMOBILE_CUSTOM_USER;
if (v_cnt = 0) then
 
  geneva_admin.gnvuser.createuser2nc(usernameora        => C_TMOBILE_CUSTOM_USER,
                                     languageid         => C_LANGUAGE_ID,
                                     encryptpasswordboo => C_ENCRYPT_PASSWORD_BOO,
                                     invoicingcoid      => null);
end if;
commit;
end;