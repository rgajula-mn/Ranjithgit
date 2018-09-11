CREATE OR REPLACE PACKAGE BODY TMO_BILLINGPROFILE AS
  Procedure getPrdSeqForModify(custProdAttrValue IN VARCHAR2,
                               customerRef       IN VARCHAR2,
                               eventSource       IN VARCHAR2,
                               productSeq        OUT NUMBER,
                               returnedStatus    OUT NUMBER,
                               returnMessage     OUT VARCHAR2) is

    --declare

    productSeq_temp     custproductattrdetails.product_seq%type;
    returnedStatus_temp NUMBER;
    returnMessage_temp  VARCHAR2(200);

  BEGIN

    if custProdAttrValue is null or customerRef is null or
       eventSource is null then
      returnedStatus_temp := -1;
      returnMessage_temp  := 'Mandatory parameters not set';
      return;
    end if;
    if custProdAttrValue is not null and customerRef is not null and
       eventSource is not null then
      declARE
        CURSOR c1 IS
        --if eventTypeId != 0 then
          select cpad.product_seq
            from custproductattrdetails cpad
           where cpad.attribute_value = custProdAttrValue
             and cpad.product_seq in
                 (select chp.product_seq --,chp.customer_ref ,Level
                    from custhasproduct chp
                   start with (chp.customer_ref, chp.product_seq) =
                              (select customer_ref, product_seq
                                 from custeventsource ces
                                where ces.customer_ref = customerRef
                                  and ces.event_source = eventSource
                                  and ces.end_dtm is null and rownum <2
                               --and ces.event_type_id = eventTypeId
                               )
                  CONNECT BY PRIOR chp.customer_ref = chp.customer_ref
                         and PRIOR chp.product_seq = chp.parent_product_seq)
             and cpad.customer_ref = customerRef;
        --end if;

      BEGIN
        -- productSeq := 0;
        OPEN c1;
        LOOP
          FETCH c1
            INTO productSeq_temp;
          productSeq := productSeq_temp;
          EXIT WHEN c1%NOTFOUND; -- c1%NOTFOUND is TRUE
          -- when no more data found

        END LOOP;
        CLOSE c1;

      END;
      -- end if;
    end if;
  end getPrdSeqForModify;
  
    
  Procedure getPrdSeqForModify_1(custProdAttrValue IN VARCHAR2, 
                                 compProdAttrValue IN VARCHAR2,           
                                 customerRef       IN VARCHAR2,
                                 eventSource       IN VARCHAR2,
                                 productSeq        OUT NUMBER,
                                 returnedStatus    OUT NUMBER,
                                 returnMessage     OUT VARCHAR2) is
  
    --declare
  
    productSeq_temp     custproductattrdetails.product_seq%type;
    returnedStatus_temp NUMBER;
    returnMessage_temp  VARCHAR2(200);
  
  BEGIN
  
    if custProdAttrValue is null or customerRef is null or
       eventSource is null then
      returnedStatus_temp := -1;
      returnMessage_temp  := 'Mandatory parameters not set';
      return;
    end if;
    if custProdAttrValue is not null and customerRef is not null and
       eventSource is not null then
      declARE
        CURSOR c1 IS
        --if eventTypeId != 0 then
     select cpad2.product_seq from custproductattrdetails cpad2  where cpad2.product_seq in 
     (
          select cpad.product_seq
            from custproductattrdetails cpad
           where cpad.attribute_value = custProdAttrValue
             and cpad.product_seq in
                 (select chp.product_seq --,chp.customer_ref ,Level
                    from custhasproduct chp
                   start with (chp.customer_ref, chp.product_seq) =
                              (select customer_ref, product_seq
                                 from custeventsource ces
                                where ces.customer_ref = customerRef
                                  and ces.event_source = eventSource
                                  and ces.end_dtm is null and rownum <2
                               --and ces.event_type_id = eventTypeId
                               )
                  CONNECT BY PRIOR chp.customer_ref = chp.customer_ref
                         and PRIOR chp.product_seq = chp.parent_product_seq)
             and cpad.customer_ref = customerRef )  and cpad2.customer_ref =  customerRef and  cpad2.attribute_value = compProdAttrValue;
        --end if;
      
      BEGIN
        -- productSeq := 0;
        OPEN c1;
        LOOP
          FETCH c1
            INTO productSeq_temp;
          productSeq := productSeq_temp;
          EXIT WHEN c1%NOTFOUND; -- c1%NOTFOUND is TRUE
          -- when no more data found
        
        END LOOP;
        CLOSE c1;
      
      END;
      -- end if;
    end if;
  end getPrdSeqForModify_1;  

  Procedure getPrdSeqForModifyWithEvtType(custProdAttrValue IN VARCHAR2,
                                          customerRef       IN VARCHAR2,
                                          eventSource       IN VARCHAR2,
                                          eventTypeId       IN NUMBER,
                                          productSeq        OUT NUMBER,
                                          returnedStatus    OUT NUMBER,
                                          returnMessage     OUT VARCHAR2) is

    --declare

    productSeq_temp     custproductattrdetails.product_seq%type;
    returnedStatus_temp NUMBER;
    returnMessage_temp  VARCHAR2(200);

  BEGIN

    if custProdAttrValue is null or customerRef is null or
       eventSource is null then
      returnedStatus_temp := -1;
      returnMessage_temp  := 'Mandatory parameters not set';
      return;
    end if;
    if custProdAttrValue is not null and customerRef is not null and
       eventSource is not null and eventTypeId != 0 then
      declARE
        CURSOR c1 IS
        --if eventTypeId != 0 then
          select cpad.product_seq
            from custproductattrdetails cpad
           where cpad.attribute_value = custProdAttrValue
             and cpad.product_seq in
                 (select chp.product_seq --,chp.customer_ref ,Level
                    from custhasproduct chp
                   start with (chp.customer_ref, chp.product_seq) =
                              (select customer_ref, product_seq
                                 from custeventsource ces
                                where ces.customer_ref = customerRef
                                  and ces.event_source = eventSource
                                  and ces.end_dtm is null
                                  and ces.event_type_id = eventTypeId)
                  CONNECT BY PRIOR chp.customer_ref = chp.customer_ref
                         and PRIOR chp.product_seq = chp.parent_product_seq)
             and cpad.customer_ref = customerRef;
        --end if;

      BEGIN
        -- productSeq := 0;
        OPEN c1;
        LOOP
          FETCH c1
            INTO productSeq_temp;
          productSeq := productSeq_temp;
          EXIT WHEN c1%NOTFOUND; -- c1%NOTFOUND is TRUE
          -- when no more data found

        END LOOP;
        CLOSE c1;

      END;
      -- end if;
    end if;
  end getPrdSeqForModifyWithEvtType;

  procedure getLastRatedUsage(i_msisdn     in varchar2,
                              i_account_no in varchar2,
                              o_recordset  OUT SYS_REFCURSOR,
                              o_recordset2 OUT SYS_REFCURSOR) as
    v_cust_ref  varchar2(32);
    v_prd_seq   varchar2(32);
    v_cust_ref2 varchar2(32);
    v_prd_seq2  varchar2(32);
    vBlock      varchar2(100);

    v_event_source            varchar2(32);
    v_qry_active_usage        varchar2(2000);
    v_qry_recent_active_sc2   varchar2(2000);
    v_qry_active_usage_sc6_4  varchar2(2000);
    v_qry_terminated_sc6      varchar2(2000);
    v_qry_recent_inactive_sc6 varchar2(2000);
    v_qry_active_gen_active   varchar2(2000);
    v_qry_active_gen_inactive varchar2(2000);
    v_qry_active_usage_sc3    varchar2(2000);
    v_errCode                 varchar2(100);
    v_errMsg                  varchar2(100);
    v_msisdn2_sc4             varchar2(32);

    TYPE rectype_usage IS RECORD(
      ru_ACCOUNT_NUM       varchar2(32),
      ru_MSISDN            varchar2(32),
      ru_LASTRATEUSAGEDATE varchar2(32),
      ru_EVENT_TYPE_ID     varchar2(32));

    rec_rectype_usage rectype_usage;

    TYPE rectype_subsc IS RECORD(
      rs_CUSTOMER_REF CUSTEVENTSOURCE.CUSTOMER_REF%type,
      rs_PRODUCT_SEQ  CUSTEVENTSOURCE.PRODUCT_SEQ%type,
      rs_event_source CUSTEVENTSOURCE.event_source%type);

    rec_rectype_subsc_a   rectype_subsc;
    rec_rectype_subsc_ina rectype_subsc;

  begin
    /*Generic query block start */

    /*scenario 1 query start*/
    /* active  Subscriber */
    v_qry_active_gen_active := q'(

  select rel.CUSTOMER_REF CUSTOMER_REF ,rel.PRODUCT_SEQ PRODUCT_SEQ ,rel.event_source  event_source
  from
  (SELECT ces.CUSTOMER_REF  CUSTOMER_REF , ces.PRODUCT_SEQ  PRODUCT_SEQ , ces.event_source  event_source ,
  row_number() over (partition by ces.CUSTOMER_REF , ces.PRODUCT_SEQ  , ces.event_source  order by  ces.start_dtm desc  ) rec
     FROM CUSTEVENTSOURCE ces
     WHERE ces.EVENT_SOURCE =:EVENT_SOURCE
      AND ces.end_dtm is null and ces.event_type_id=1  ) rel
      where rel.rec=1  )';

    v_qry_active_gen_inactive := q'(
      select  rel1.CUSTOMER_REF ,rel1.PRODUCT_SEQ  , rel1.event_source
  from
  (
  SELECT ces.CUSTOMER_REF ,ces.PRODUCT_SEQ  , ces.event_source ,  row_number() over (partition  by
   ces.event_source order by   ces.end_dtm desc ) rec
     FROM CUSTEVENTSOURCE ces
     WHERE
     ces.event_source =:EVENT_SOURCE
     and  ces.end_dtm IS NOT NULL  and ces.event_type_id=1
     ) rel1  where  rel1.rec=1 )';

    /*scenario query end*/

    /*scenario 2 query start  */

    /*System will look for current active subscriber instance on MSISDN 2 and finds Subscriber Instance  scenario 2*/

    v_qry_recent_active_sc2 := q'(select  event_source from
  (
  select
  ces.CUSTOMER_REF ,
  ces.PRODUCT_SEQ  ,
  ces.event_source ,
  row_number() over (partition by ces.CUSTOMER_REF , ces.PRODUCT_SEQ  order by  ces.end_dtm desc  ) rec
     FROM CUSTEVENTSOURCE ces
       WHERE ces.CUSTOMER_REF=:CUSTOMER_REF
       and ces.PRODUCT_SEQ=:PRODUCT_SEQ
       and ces.EVENT_SOURCE!=:EVENT_SOURCE
     AND ces.end_dtm IS NOT NULL
     )  rel1 where rel1.rec=1)';

    /*scenario 2 query  end */

    /*System will look for the MOST RECENT active subscriber instance on MSISDN-1 and find Subscriber Instance 1 for scenario 6*/

    v_qry_terminated_sc6 := q'(

      select  rel.CUSTOMER_REF,rel.PRODUCT_SEQ,rel.event_source from
      (

      SELECT ces.CUSTOMER_REF  CUSTOMER_REF , ces.PRODUCT_SEQ PRODUCT_SEQ  , ces.event_source event_source ,
      row_number() over(partition by ces.event_source  order by ces.start_dtm desc  ) rec  from  CUSTEVENTSOURCE ces  where
     ces.event_source=:event_source
    and ces.end_dtm  is  not  null  and  ces.event_type_id=1
  and  exists
  (select 1 from  CUSTEVENTSOURCE ces2
  where ces2.event_source=ces.event_source
  and   ces2.customer_ref!=ces.customer_ref
  and   ces2.product_seq!=ces.product_seq
  and   ces2.event_source_txt ='RSM'
  and  not exists (

  select
      1
      from account ac
      inner  join
      TMOBILE_CUSTOM.TMO_SUB_LASTRATEDUSAGEV8_0 tmc
      on  ac.account_num=tmc.account_num
      and ac.customer_ref=ces2.customer_ref
      and tmc.product_seq=ces2.product_seq
      and tmc.MSISDN =ces2.event_source   and rownum=1   )
  and rownum=1 )    /*Usage does  not exist */
  ) rel where rel.rec=1)';

    /*System will also query the MOST RECENT INACTIVE Subscriber instance for MSISDN 1
    and find Subscriber Instance 1 (the previous instance of this subscriber before termination*/

    v_qry_recent_inactive_sc6 := q'(select  CUSTOMER_REF,PRODUCT_SEQ
  from
  (
  SELECT ces.CUSTOMER_REF , ces.PRODUCT_SEQ  , ces.event_source
     FROM CUSTEVENTSOURCE ces
       WHERE ces.CUSTOMER_REF<>:CUSTOMER_REF
       and ces.PRODUCT_SEQ<>:PRODUCT_SEQ
       and  ces.event_source =:event_source
     AND (ces.end_dtm IS NOT NULL ) order by  ces.end_dtm desc  )
     where  rownum = 1 )';

    /*usage  Subscriber Instance  for scenario-6*/

    v_qry_active_usage_sc6_4 := q'(select   ACCOUNT_NUM , MSISDN , LASTRATEUSAGEDATE ,EVENT_TYPE_ID  from
  (

  select  ACCOUNT_NUM ,  MSISDN ,EVENT_TYPE_ID , LASTRATEUSAGEDATE ,row_number() over  (partition by ACCOUNT_NUM ,EVENT_TYPE_ID  order by  LASTRATEUSAGEDATE desc ) rec
   from
   (
  select
        tmc.ACCOUNT_NUM ACCOUNT_NUM ,
        tmc.MSISDN MSISDN ,
        tmc.LASTRATEUSAGEDATE LASTRATEUSAGEDATE,
        tmc.EVENT_TYPE_ID EVENT_TYPE_ID

      from account ac
      inner  join
      TMOBILE_CUSTOM.TMO_SUB_LASTRATEDUSAGEV8_0 tmc
      on  ac.account_num=tmc.account_num
      and ac.customer_ref in (:v_cust_ref,:v_cust_ref2)
      and tmc.product_seq in (:v_prd_seq,:v_prd_seq2)
      and tmc.MSISDN in (:i_msisdn1,:i_msisdn2)
      )  ) where rec=1)';

    /*usage  Subscriber Instance  */
    v_qry_active_usage := q'(select
        tmc.ACCOUNT_NUM,
        tmc.MSISDN,
        tmc.LASTRATEUSAGEDATE,
        tmc.EVENT_TYPE_ID
      from account ac
      inner  join
      TMOBILE_CUSTOM.TMO_SUB_LASTRATEDUSAGEV8_0 tmc
      on  ac.account_num=tmc.account_num
      and ac.customer_ref=:v_cust_ref
      and tmc.product_seq=:v_prd_seq
      and tmc.MSISDN =:i_msisdn
      and nvl(:i_account_no,tmc.account_num) =tmc.account_num )';

    v_qry_active_usage_sc3 := q'(select ACCOUNT_NUM, MSISDN, LASTRATEUSAGEDATE, EVENT_TYPE_ID FROM 
(select
        tmc.ACCOUNT_NUM ACCOUNT_NUM,
        tmc.MSISDN MSISDN,
        tmc.LASTRATEUSAGEDATE LASTRATEUSAGEDATE,
        tmc.EVENT_TYPE_ID EVENT_TYPE_ID,
		row_number() over(partition by EVENT_TYPE_ID order by LASTRATEUSAGEDATE desc) row_number_count
      from account ac
      inner  join
      TMOBILE_CUSTOM.TMO_SUB_LASTRATEDUSAGEV8_0 tmc
      on  ac.account_num=tmc.account_num
      and ac.customer_ref=:v_cust_ref
      and tmc.product_seq=:v_prd_seq
      and tmc.MSISDN in (:i_msisdn,:v_msisdn2_sc4)
      and  not exists
  (select 1 from  CUSTEVENTSOURCE ces2
  where ces2.event_source=tmc.MSISDN
  and   ces2.customer_ref!=ac.customer_ref
  and   ces2.product_seq!=tmc.product_seq
  and   ces2.event_source_txt ='RSM' and rownum=1)

      and not exists
      (
      select
       1
      from account ac2
      inner  join
      TMOBILE_CUSTOM.TMO_SUB_LASTRATEDUSAGEV8_0  tmc2
      on  ac2.account_num=tmc2.account_num
      and ac2.customer_ref=ac.customer_ref
      and tmc2.product_seq=tmc.product_seq
      and tmc2.MSISDN =:v_event_source and rownum=1
      ) ) TEST
 where row_number_count = 1)';

    /*Generic query block end */

    begin

      /*Scenario 1 start */
      /*finding the active  Subscriber */
      EXECUTE IMMEDIATE v_qry_active_gen_active
        into rec_rectype_subsc_a
        using i_msisdn;
      v_cust_ref     := rec_rectype_subsc_a.rs_CUSTOMER_REF;
      v_prd_seq      := rec_rectype_subsc_a.rs_product_seq;
      v_event_source := rec_rectype_subsc_a.rs_event_source;

      /*usage on  Subscriber Instance 1 */
      if (v_cust_ref is not null and v_prd_seq is not null) then
        begin
          vBlock := 'Results for scenario 1';
          open o_recordset for v_qry_active_usage
            using v_cust_ref, v_prd_seq, i_msisdn, i_account_no;

        end;

        /*checking for usage data for MSISDN1 */
        fetch o_recordset
          into rec_rectype_usage;
        /*Scenario 2 start */
        if rec_rectype_usage.ru_ACCOUNT_NUM is not null then
          close o_recordset;
          open o_recordset for v_qry_active_usage
            using v_cust_ref, v_prd_seq, i_msisdn, i_account_no;
          dbms_output.put_line(vBlock);
          --return;
        else
          /*current active subscriber instance on MSISDN 2 and finds Subscriber Instance 1 */
          vBlock := 'Scenario 2:current active subscriber instance on MSISDN 2 and finds Subscriber Instance 1';
          begin

            EXECUTE IMMEDIATE v_qry_recent_active_sc2
              into v_event_source
              using v_cust_ref, v_prd_seq, i_msisdn;
          exception
            when others then
              v_errCode := SQLCODE;
              v_errMsg  := SQLERRM;
              dbms_output.put_line(vBlock || v_errCode || ' - ' ||
                                   v_errMsg);
          end;
          /* usage for  MSISDN2 */
          if (v_cust_ref is not null and v_prd_seq is not null and
             v_event_source is not null) then
            begin
              vBlock := 'Results for scenario 2';
              open o_recordset for v_qry_active_usage
                using v_cust_ref, v_prd_seq, v_event_source, i_account_no;
              dbms_output.put_line(vBlock);
              return;

            end;
            /*Scenario 2  end */
          end if;
        end if;
      end if;

    exception
      when no_data_found then
        /*scenario 3 start*/

        /*System will look for the current active subscriber instance on MSISDN 1 and find none*/

        begin
          EXECUTE IMMEDIATE v_qry_active_gen_inactive
            into rec_rectype_subsc_ina
            using i_msisdn;
          v_cust_ref := rec_rectype_subsc_ina.rs_CUSTOMER_REF;
          v_prd_seq  := rec_rectype_subsc_ina.rs_product_seq;

          EXECUTE IMMEDIATE v_qry_recent_active_sc2
            into v_event_source
            using v_cust_ref, v_prd_seq, i_msisdn;

        exception
          when others then
            v_errCode := SQLCODE;
            v_errMsg  := SQLERRM;
            dbms_output.put_line(vBlock || v_errCode || ':' || v_errMsg);
        end;
        /*usage results for MSISDN */
        if (v_cust_ref is not null and v_prd_seq is not null) then
          vBlock := 'Results for scenario 3';
		  
          /*TMOGENESIS 21980 QueryLastRatedUsageDTMByType API issue in SOL8*/
          begin
          select event_source
          into v_msisdn2_sc4
          from CUSTEVENTSOURCE ces,TMOBILE_CUSTOM.TMO_SUB_LASTRATEDUSAGEV8_0  tmc,account acc
         where ces.event_source = tmc.MSISDN
           and ces.customer_ref = acc.customer_ref
           and acc.account_num=tmc.account_num
           and ces.event_source != i_msisdn
           and ces.customer_ref = v_cust_ref
           and ces.product_seq = v_prd_seq
           and ces.end_dtm is null
           and rownum = 1;
         exception 
           when others then
              v_msisdn2_sc4 := NULL;
         end;  
         
          dbms_output.put_line('v_msisdn2_sc4 '||v_msisdn2_sc4);                
          open o_recordset for v_qry_active_usage_sc3
            using v_cust_ref, v_prd_seq, i_msisdn,v_msisdn2_sc4, v_event_source;

          fetch o_recordset
            into rec_rectype_usage;

          if rec_rectype_usage.ru_ACCOUNT_NUM is not null then
            close o_recordset;
            open o_recordset for v_qry_active_usage_sc3
              using v_cust_ref, v_prd_seq, i_msisdn,v_msisdn2_sc4, v_event_source;
            dbms_output.put_line(vBlock);
            return;
          else
            if (v_event_source is not null) then
              vBlock := 'Results for scenario 4';

              open o_recordset for v_qry_active_usage_sc6_4
                using v_cust_ref, v_cust_ref, v_prd_seq, v_prd_seq, i_msisdn, v_event_source;
              dbms_output.put_line(vBlock);

              return; /*result for sc4*/
            end if;

          end if;

          /*scenario 4 end*/

        end if;
        /*scenario 3 end*/

      /*scenario 5 ends*/
    end;

    /*Scenario-6* starts */
    vBlock := 'Results for scenario 6';

    begin
      EXECUTE IMMEDIATE v_qry_terminated_sc6
        into v_cust_ref, v_prd_seq, v_event_source
        using i_msisdn;

    Exception
      when no_data_found then
        v_errCode := SQLCODE;
        v_errMsg  := SQLERRM;
        dbms_output.put_line(vBlock || v_errCode || ' : ' || v_errMsg);

    end;

    if v_cust_ref is not null and v_prd_seq is not null then

      begin
        EXECUTE IMMEDIATE v_qry_recent_inactive_sc6
          into v_cust_ref2, v_prd_seq2 /*System will also query the MOST RECENT INACTIVE Subscriber instance for MSISDN 1*/
          using v_cust_ref, v_prd_seq, i_msisdn;

      Exception
        when no_data_found then
          v_errCode := SQLCODE;
          v_errMsg  := SQLERRM;
          dbms_output.put_line(vBlock || v_errCode || ' : ' || v_errMsg);

      end;

      if v_cust_ref2 is not null and v_prd_seq2 is not null then
        vBlock := 'Results for scenario 6';

        open o_recordset2 for v_qry_active_usage_sc6_4
          using v_cust_ref, v_cust_ref2, v_prd_seq, v_prd_seq2, i_msisdn, 'XXXX';
        fetch o_recordset2
          into rec_rectype_usage;
        if rec_rectype_usage.ru_account_num is not null then

          open o_recordset2 for v_qry_active_usage_sc6_4
            using v_cust_ref, v_cust_ref2, v_prd_seq, v_prd_seq2, i_msisdn, 'XXXX';
          dbms_output.put_line(vBlock);
          if o_recordset%isopen then
            close o_recordset;
          end if;
          return;
        else
          begin
            EXECUTE IMMEDIATE v_qry_active_gen_inactive
              into rec_rectype_subsc_ina
              using i_msisdn;
            v_cust_ref     := rec_rectype_subsc_ina.rs_CUSTOMER_REF;
            v_prd_seq      := rec_rectype_subsc_ina.rs_product_seq;
            v_event_source := rec_rectype_subsc_ina.rs_event_source;

            if v_cust_ref is not null and v_prd_seq is not null then
              vBlock := 'Results for scenario 5';

              open o_recordset2 for v_qry_active_usage
                using v_cust_ref, v_prd_seq, i_msisdn, i_account_no;
              dbms_output.put_line(vBlock);

            end if;

          Exception
            when no_data_found then
              v_errCode := SQLCODE;
              v_errMsg  := SQLERRM;
              dbms_output.put_line(vBlock || v_errCode || ' : ' ||
                                   v_errMsg);
          end;
        end if;
      end if;

    end if;

    /*Scenario-6* Ends */

  end getLastRatedUsage;

end TMO_BILLINGPROFILE;
/