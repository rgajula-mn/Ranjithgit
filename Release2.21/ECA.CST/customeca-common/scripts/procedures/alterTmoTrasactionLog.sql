 ALTER TABLE tmo_transactiondetails  ADD DURATION varchar2(50);
 ALTER TABLE tmo_transactiondetails  ADD NODE varchar2(100);
 ALTER TABLE tmo_transactiondetails MODIFY service_name varchar2(50); 
 ALTER TABLE tmo_transactiondetails MODIFY wholesale_transaction_id varchar2(50);