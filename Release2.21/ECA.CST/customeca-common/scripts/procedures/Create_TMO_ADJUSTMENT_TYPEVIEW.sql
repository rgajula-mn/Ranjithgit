
CREATE OR REPLACE  VIEW TMOBILE_CUSTOM.TMO_ADJUSTMENT_TYPEVIEW
(
   CUSTOMER_REF,
   ACCOUNT_NUM,
   CUST_TYPE,
   ADJUSTMENT_TYPE_ID , 
   ADJUSTMENT_TYPE_NAME , 
   ADJUSTMENT_TYPE_DESC 
)
AS
WITH cust_market_segment
                 AS (SELECT tam.rating_acct_nbr,
                            tam.customer_name,
                            tam.cust_type,
                            tam.acct_type,
                            c.customer_ref,
                            c.market_segment_id
                       FROM tmobile_custom.tmo_acct_mapping tam,
                            GENEVA_ADMIN.customer c
                      WHERE tam.refactored_flag = 'T'
                      and c.customer_ref = tam.rating_cust_ref),
    cust_tariff AS (
                 SELECT distinct cms.rating_acct_nbr,
                            cms.customer_name,
                            cms.customer_ref,
                            tehm.tariff_id,
                            tf.tariff_name,
                            tf.tariff_desc,
                            cms.cust_type,
                            cms.acct_type,
                            cms.market_segment_id,
                            tehm.catalogue_change_id
                  FROM cust_market_segment cms,
                            geneva_admin.tariffelementhasmktsegment tehm,
                            geneva_admin.tariff tf
                  WHERE tehm.market_segment_id = cms.market_segment_id
                   and tehm.catalogue_change_id =
                                   (select catalogue_change_id
                                      from geneva_admin.cataloguechange
                                     where catalogue_status = 3)
                          and tf.catalogue_change_id = tehm.catalogue_change_id
                          and tf.tariff_id=tehm.tariff_id
                          and tf.sales_end_dat is null),
        imsi_tariff as (
        select 
             ct.customer_ref,
             ct.rating_acct_nbr,
             ct.cust_type,
             ct.acct_type
          from 
               cust_tariff        ct 
           where  exists (select 1 from  geneva_admin.tariffelementattrdetails   tead
           where tead.product_price_attr_id in (37,38,39,40,51,52,53)
           and tead.catalogue_change_id = ct.catalogue_change_id
           and tead.tariff_id = ct.tariff_id
           and tead.end_dat is null))
SELECT  CT.CUSTOMER_REF, CT.RATING_ACCT_NBR ACCOUNT_NUM, CT.CUST_TYPE,  --CASE2 
    ADJ.ADJUSTMENT_TYPE_ID || '~' || CT.TARIFF_ID || '~' || gpn.tomsobjid  ADJUSTMENT_TYPE_ID , ADJ.ADJUSTMENT_TYPE_NAME || '-' || GPN.PLAN_NAME ADJUSTMENT_TYPE_NAME , ADJ.ADJUSTMENT_TYPE_DESC  
FROM  tmobile_custom.genplannamemapview gpn, cust_tariff CT  
JOIN GENEVA_ADMIN.PVADJUSTMENTTYPE4 ADJ
    ON ADJ.ADJUSTMENT_TYPE_NAME LIKE 
  CASE WHEN CT.CUST_TYPE = 'Var' or CT.CUST_TYPE = 'billing' THEN '%M2M%' 
      when CT.ACCT_TYPE ='MVNO' THEN '%Wholesale'
        WHEN CT.ACCT_TYPE ='MVNO IOT' THEN '%Wholesale%I%'
          WHEN CT.ACCT_TYPE ='POS IOT' THEN '%POS IOT' END
WHERE  ADJ.ADJUSTMENT_TYPE_ID IN (69,23,86,128)
    AND  CT.CUST_TYPE IN ('Var', 'billing' , 'Wholesale','Retail')
     AND GPN.RBTARIFFID = CT.TARIFF_ID
    AND GPN.TARIFF_NAME = CT.TARIFF_NAME  
    AND GPN.TARIFF_DESC = CT.TARIFF_DESC
UNION All
SELECT ACCT.RATING_CUST_REF, ACCT.RATING_ACCT_NBR ACCOUNT_NUM, ACCT.CUST_TYPE, 
    to_char(ADJ.ADJUSTMENT_TYPE_ID) , ADJ.ADJUSTMENT_TYPE_NAME, ADJ.ADJUSTMENT_TYPE_DESC  --CASE1 
FROM GENEVA_ADMIN.PVADJUSTMENTTYPE4 ADJ
JOIN TMOBILE_CUSTOM.TMO_ACCT_MAPPING ACCT
    ON ADJ.ADJUSTMENT_TYPE_NAME LIKE 
  CASE WHEN ACCT.CUST_TYPE = 'Var' or ACCT.CUST_TYPE = 'billing' THEN '%M2M%' 
      when ACCT.ACCT_TYPE ='MVNO' THEN '%Wholesale'
        WHEN ACCT.ACCT_TYPE ='MVNO IOT' THEN '%Wholesale%I%'
         WHEN ACCT.ACCT_TYPE ='POS IOT' THEN '%POS IOT' END   
WHERE NOT EXISTS ( SELECT 1 
                 FROM   TMOBILE_CUSTOM.TMO_DISPADJ_EVENTMAPPING DISPADJ
                 WHERE  DISPADJ.NEW_ADJ_TYPE_ID=ADJ.ADJUSTMENT_TYPE_ID  
                    -- AND DISPADJ.NEW_EVENT_TYPE_ID IS NOT NULL
                )
    AND ADJ.ADJUSTMENT_TYPE_ID NOT IN  (69,23,86,128,100,101,102,103,104,105,125,126,127)
    AND  ACCT.CUST_TYPE IN ('Var', 'billing' , 'Wholesale','Retail')
UNION ALL
 SELECT  CT.CUSTOMER_REF, --CASE3
                CT.RATING_ACCT_NBR ACCOUNT_NUM,
                CT.CUST_TYPE, 
                to_char(ADJ.ADJUSTMENT_TYPE_ID),
                ADJ.ADJUSTMENT_TYPE_NAME,
                ADJ.ADJUSTMENT_TYPE_DESC
  FROM imsi_tariff CT
  JOIN GENEVA_ADMIN.PVADJUSTMENTTYPE4 ADJ
    ON ADJ.ADJUSTMENT_TYPE_NAME LIKE CASE
         WHEN CT.CUST_TYPE = 'Var' or CT.CUST_TYPE = 'billing' THEN
          '%M2M%'
         when CT.ACCT_TYPE = 'MVNO' THEN
          '%Wholesale'
         WHEN CT.ACCT_TYPE = 'MVNO IOT' THEN
          '%Wholesale%I%'
      WHEN CT.ACCT_TYPE ='POS IOT' THEN '%POS IOT' 
       END
 WHERE  ADJ.ADJUSTMENT_TYPE_ID IN (100,101,102,103,104,105,125,126,127)
   AND CT.CUST_TYPE IN ('Var', 'billing', 'Wholesale','Retail')
WITH READ ONLY;
CREATE OR REPLACE PUBLIC SYNONYM TMO_ADJUSTMENT_TYPEVIEW FOR TMOBILE_CUSTOM.TMO_ADJUSTMENT_TYPEVIEW;
CREATE OR REPLACE SYNONYM UNIF_ADMIN.TMO_ADJUSTMENT_TYPEVIEW FOR TMOBILE_CUSTOM.TMO_ADJUSTMENT_TYPEVIEW;
GRANT SELECT ON TMOBILE_CUSTOM.TMO_ADJUSTMENT_TYPEVIEW TO UNIF_ADMIN;
