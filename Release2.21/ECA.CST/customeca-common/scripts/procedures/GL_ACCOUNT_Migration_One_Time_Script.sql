
  set serveroutput on;
  DECLARE 
  tmp_gl_acc  tmo_gllineitemtextmap.GL_ACCOUNT%TYPE;
  counter number(4);
  char_CATEGORY_IND           VARCHAR2(20);                      
  char_REPORTING_IND          VARCHAR2(20);                       
  char_GL_ACCOUNT_DESCRIPTION VARCHAR2(255);                        
  char_READONLY_FLAG          VARCHAR2(10);                         
 
  CURSOR gl is select distinct a.gl_account from TMOBILE_CUSTOM.tmo_gllineitemtextmap a where a.LINE_ITEM_TEXT  not in (select distinct gl_account from TMOBILE_CUSTOM.tmo_gllineitemtextmap); 
  begin
       OPEN gl;  
   LOOP
      FETCH gl INTO tmp_gl_acc;
	
      select count(*) into counter from TMOBILE_CUSTOM.tmo_gllineitemtextmap a 
      where a.LINE_ITEM_TEXT = tmp_gl_acc  ;
      if( counter = 0 )
      then
           select a.CATEGORY_IND ,  a.REPORTING_IND  , a.GL_ACCOUNT_DESCRIPTION , a.READONLY_FLAG INTO char_CATEGORY_IND , char_REPORTING_IND , 
   char_GL_ACCOUNT_DESCRIPTION , char_READONLY_FLAG FROM TMOBILE_CUSTOM.tmo_gllineitemtextmap a where a.GL_ACCOUNT = tmp_gl_acc and rownum =1  ;  

     DBMS_OUTPUT.PUT_LINE('GL ACCOUNT is : ' || tmp_gl_acc );
     Insert into TMOBILE_CUSTOM.tmo_gllineitemtextmap
          (line_item_text, gl_account,CATEGORY_IND,REPORTING_IND,GL_ACCOUNT_DESCRIPTION,READONLY_FLAG) values (tmp_gl_acc,tmp_gl_acc, char_CATEGORY_IND,char_REPORTING_IND,char_GL_ACCOUNT_DESCRIPTION,'T');
		COMMIT; 
       end if;
      EXIT WHEN gl%NOTFOUND;
       
   END LOOP;
       CLOSE gl;
   END;

/
