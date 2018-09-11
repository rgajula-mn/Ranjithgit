create or replace package TMO_BILLINGPROFILE is

  Procedure getPrdSeqForModify(custProdAttrValue IN VARCHAR2,
                               customerRef       IN VARCHAR2,
                               eventSource       IN VARCHAR2,
                               productSeq        OUT NUMBER,
                               returnedStatus    OUT NUMBER,
                               returnMessage     OUT VARCHAR2);
							   
  Procedure getPrdSeqForModify_1(custProdAttrValue IN VARCHAR2, 
                                 compProdAttrValue IN VARCHAR2,           
                                 customerRef       IN VARCHAR2,
                                 eventSource       IN VARCHAR2,
                                 productSeq        OUT NUMBER,
                                 returnedStatus    OUT NUMBER,
                                 returnMessage     OUT VARCHAR2);  

  Procedure getPrdSeqForModifyWithEvtType(custProdAttrValue IN VARCHAR2,
                                          customerRef       IN VARCHAR2,
                                          eventSource       IN VARCHAR2,
                                          eventTypeId       IN NUMBER,
                                          productSeq        OUT NUMBER,
                                          returnedStatus    OUT NUMBER,
                                          returnMessage     OUT VARCHAR2);
  procedure getLastRatedUsage(i_msisdn     in varchar2,
                              i_account_no in varchar2,
                              o_recordset  OUT SYS_REFCURSOR,
                              o_recordset2 OUT SYS_REFCURSOR);
end TMO_BILLINGPROFILE;
/