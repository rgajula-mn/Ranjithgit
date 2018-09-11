CREATE OR REPLACE PROCEDURE insertToErrorLog (
       p_created_dtm IN DATE,
       p_wholesale_transId IN VARCHAR2,
       p_service_name IN VARCHAR2,
       p_customer_ref IN VARCHAR2,
       p_status IN NUMBER,
       p_event_source IN VARCHAR2,
       p_request_details IN CLOB,
       p_response_details IN CLOB,
       p_duration IN VARCHAR2,
       p_node IN VARCHAR2
      ) AS
  PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN
INSERT INTO TMOBILE_CUSTOM.TMO_TRANSACTIONDETAILS(CREATED_DTM,WHOLESALE_TRANSACTION_ID,SERVICE_NAME,CUSTOMER_REF,STATUS,EVENTSOURCE,REQUEST_DETAIL,RESPONSE_DETAIL,DURATION,NODE)
   VALUES(p_created_dtm,p_wholesale_transId,p_service_name,p_customer_ref,p_status,p_event_source,p_request_details,p_response_details,p_duration,p_node);
 /* INSERT INTO TMOBILE_CUSTOM.TMO_TRANSACTIONDETAILS(CREATED_DTM,WHOLESALE_TRANSACTION_ID,SERVICE_NAME,CUSTOMER_REF,STATUS,EVENTSOURCE,REQUEST_DETAIL,RESPONSE_DETAIL)
       VALUES(p_created_dtm,p_wholesale_transId,p_service_name,p_customer_ref,p_status,p_event_source,p_request_details,p_response_details);
*/
  
  COMMIT;
END;
/
