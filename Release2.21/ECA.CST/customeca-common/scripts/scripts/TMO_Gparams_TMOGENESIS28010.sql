---------------------------------------------------------------------------------------------------------------------
--        Description      : Insert script for email pl scriptpath Prtal to RB.
--                         : 
--        Author           : Sumanta
--        Version Date     : 10-Mar-2017
--        VERSION          : 0.1
--        Copyright (c) NC 2013.
---------------------------------------------------------------------------------------------------------------------
Delete from GPARAMS where Name = 'EMAIL_PERL_SCRIPT_PATH';
Delete from GPARAMS where Name = 'EMAIL_FILE_PATH';

INSERT INTO GPARAMS VALUES('EMAIL_FILE_PATH','STRING',SYSDATE,'',0); 
commit;
