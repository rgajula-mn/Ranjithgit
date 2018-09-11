-- Create table
create table TMO_TRANSACTIONDETAILS
(
  CREATED_DTM              DATE not null,
  WHOLESALE_TRANSACTION_ID VARCHAR2(20) not null,
  SERVICE_NAME             VARCHAR2(20) not null,
  CUSTOMER_REF             VARCHAR2(20),
  STATUS                   NUMBER(1) not null,
  EVENTSOURCE              VARCHAR2(20),
  REQUEST_DETAIL           CLOB,
  RESPONSE_DETAIL          CLOB
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table TMO_TRANSACTIONDETAILS
  add constraint TMO_TRANSACTIONDETAILS_PK primary key (CREATED_DTM, WHOLESALE_TRANSACTION_ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
grant select, insert, update, delete, references, alter, index on TMO_TRANSACTIONDETAILS to UNIF_ADMIN;