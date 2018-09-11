CREATE OR REPLACE PROCEDURE createBulkRequest (
       --p_request_id   IN NUMBER ,                            
       p_customer_ref IN VARCHAR2  ,                          
       p_created_dtm IN DATE  ,                                                            
       p_wcsm_user_id IN VARCHAR2  ,                         
       p_status IN NUMBER     ,                          
	  -- p_completed_dtm IN DATE                                 
       p_request_file IN VARCHAR2     ,                       
       --p_result_file IN VARCHAR2                          
       --p_error_file IN VARCHAR2                          
       --p_parse_file IN VARCHAR2                        
       --p_number_requests IN NUMBER                               
       --p_returned_file_count IN NUMBER
	   p_portal_user_id IN VARCHAR2,
       p_tibco_partner_id IN NUMBER,
       p_request_id IN NUMBER) AS
  PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
INSERT INTO TMOBILE_CUSTOM.BULKREQUEST(REQUEST_ID,CUSTOMER_REF,CREATED_DTM,WCSM_USER_ID,STATUS,COMPLETED_DTM,REQUEST_FILE,RESULT_FILE,ERROR_FILE,PARSE_FILE,NUMBER_REQUESTS,RETURNED_FILE_COUNT,TIBCO_PARTNER_ID,PORTAL_USER_ID)
       VALUES(p_request_id,p_customer_ref,p_created_dtm,p_wcsm_user_id,p_status,null,p_request_file,null,null,null,1,1,p_tibco_partner_id,p_portal_user_id);
  COMMIT;
  
--select max(REQUEST_ID) into p_request_id_out from TMOBILE_CUSTOM.BULKREQUEST;

END;
/



