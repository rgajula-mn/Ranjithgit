		   declare
			 cursor installParms_c (c_component_id in varchar2) is
			   select context, value
			   from
			   (select SYS_CONNECT_BY_PATH(name, '/') context,
					   value
				FROM   systemregistryentry
				START WITH name='Infinys'
				CONNECT BY nocycle prior id = parent_id
				)
			   where  context like
				 '/Infinys/Installer/Installed/'||
				 c_component_id||'/InstallParameters/%';
			 l_component_id varchar2(30) := '%';

			 l_oldvalue   clob;
			 l_newversion number;
			 l_context    varchar2(4000);
		   begin
			 l_component_id := '%';

			 for c in installParms_c (l_component_id)
			 loop
			   l_context := replace(c.context,'/Infinys/Installer/Installed',
										   '/Infinys/Installer/Staged');
			   sysreg.WRITEVALUE_1('${INF_USER}',l_context,
								c.value,null,l_oldvalue,l_newversion);
			   dbms_output.put_line('Writing ...'||l_context);
			 end loop;
		   commit;
		   end;
