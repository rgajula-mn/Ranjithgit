create or replace package tmobile_custom.TMOREFDATA
AUTHID CURRENT_USER 
IS

  -- Author  : HKIM
  -- Created : 4/27/2016 4:48:59 PM
  -- Purpose : 

  -- Public type declarations
  --type <TypeName> is <Datatype>;
  type T_ccpcRec  IS RECORD
  (
    CCPC_CODE        VARCHAR2(10),
    COMPANY_CODE     VARCHAR2(4),
    CCPC_DESCRIPTION VARCHAR2(100)
  );
  
  type T_ccpcTab is table of T_ccpcRec;
 
  TYPE T_glAccountRec IS RECORD
  (
	GL_ACCOUNT             VARCHAR2(20),
    GL_ACCOUNT_DESCRIPTION VARCHAR2(255),
    LINE_ITEM_TEXT         VARCHAR2(60)
  );

  type T_glAccountTab is table of T_glAccountRec;   

  TYPE T_productDiscountTypeRec IS RECORD
  (
    ID	    NUMBER(9),     
    NAME	VARCHAR2(40),
    DESCR	VARCHAR2(255),
    TYPE	VARCHAR2(8)
  );

  type T_productDiscountTypeTab is table of T_productDiscountTypeRec;

   TYPE T_SkfCategoryMapRec IS RECORD
  (
     GL_ACCOUNT	            VARCHAR2(20),
     GL_ACCOUNT_DESCRIPTION	VARCHAR2(255),
     LINE_ITEM_TEXT	        VARCHAR2(60)
  );

  type T_SkfCategoryMapTab is table of T_SkfCategoryMapRec;

  TYPE T_ProductDiscountMapRec IS RECORD
  (
    GL_ACCOUNT	           VARCHAR2(20),
    GL_ACCOUNT_DESCRIPTION VARCHAR2(255),
    LINE_ITEM_TEXT         VARCHAR2(60),
    REVENUE_CODE_NAME      VARCHAR2(40),
    ID                     NUMBER(9),
    DESCR                  VARCHAR2(255),
    CREDIT                 VARCHAR2(1),
    TYPE                   VARCHAR2(8)
  );

  type T_ProductDiscountMapTab is table of T_ProductDiscountMapRec;

  TYPE T_AdjustmentTypeRec IS RECORD
  (
     ADJUSTMENT_TYPE_ID   NUMBER(9),
     ADJUSTMENT_TYPE_NAME VARCHAR2(40),
     ADJUSTMENT_TYPE_DESC VARCHAR2(255)
  );

  type T_AdjustmentTypeTab is table of T_AdjustmentTypeRec;
  
  TYPE T_AdjustmentTypeMapRec IS RECORD
  (
    GL_ACCOUNT	            VARCHAR2(20),
    GL_ACCOUNT_DESCRIPTION	VARCHAR2(255),
    LINE_ITEM_TEXT	        VARCHAR2(60),
    ADJUSTMENT_TYPE_ID     	NUMBER(9),
    ADJUSTMENT_TYPE_NAME	  VARCHAR2(40),
    ADJUSTMENT_TYPE_DESC	  VARCHAR2(255)
  );


  type T_AdjustmentTypeMapTab is table of T_AdjustmentTypeMapRec;     

  TYPE T_TaxTypeMapRec IS RECORD
  (
    GL_ACCOUNT	            VARCHAR2(20),
    GL_ACCOUNT_DESCRIPTION	VARCHAR2(255),
    LINE_ITEM_TEXT	        VARCHAR2(60),
    TAX_TYPE_ID     	    NUMBER(9),
    CHARGE_GROUP_ID	        NUMBER(9),
    TAX_AUTHORITY	        NUMBER(1),
    TAX_TYPE_NAME	        VARCHAR2(40)
  );

  type T_TaxTypeMapTab is table of T_TaxTypeMapRec;

  TYPE T_CustomTaxTypeRec IS RECORD
  (
    TAX_TYPE_ID     NUMBER(9),                 
    CHARGE_GROUP_ID NUMBER(9),                  
    TAX_AUTHORITY   NUMBER(1),                        
    TAX_TYPE_NAME   VARCHAR2(40)
  );

  type T_CustomTaxTypeTab is table of T_CustomTaxTypeRec;

  TYPE T_glTaxTypeRec IS RECORD
  (
    TAX_TYPE_ID     NUMBER(9),                        
    CHARGE_GROUP_ID NUMBER(9),                             
    TAX_AUTHORITY   NUMBER(1),                             
    TAX_TYPE_NAME   VARCHAR2(40) 
  );

  type T_glTaxTypeTab is table of T_glTaxTypeRec;

  TYPE T_GLLineItemTextMapRec IS RECORD
  (
    LINE_ITEM_TEXT         VARCHAR2(50), 
    GL_ACCOUNT             VARCHAR2(20),
    CATEGORY_IND           VARCHAR2(20),
    REPORTING_IND          VARCHAR2(20),
    GL_ACCOUNT_DESCRIPTION VARCHAR2(255)  
  );

  type T_GLLineItemTextMapTab is table of T_GLLineItemTextMapRec;

  TYPE T_GLRevenueCodeMapRec IS RECORD
  (  
    REVENUE_CODE_NAME VARCHAR2(40),
    LINE_ITEM_TEXT    VARCHAR2(50), 
    CREDIT            VARCHAR2(1)
  );

  type T_GLRevenueCodeMapTab is table of T_GLRevenueCodeMapRec;
  
  -- Public constant declarations

  --<VariableName> <Datatype>;
 
  -- Public function and procedure declarations
 
   function readAllCCPCs                       return T_ccpcTab;  

  /*=======================================================================*/
  /*  GL Account                                                           */
  /*=======================================================================*/
       
   function readAllGLAccounts                  return T_glAccountTab; 

   function createGLAccount(p_GLAccount   in varchar2,
                            p_description in varchar2 ) return varchar2;

   function createGLAccount(p_GLAccount   in varchar2,
                            p_description in varchar2,
                            p_identifier  in varchar2 ) return varchar2;
			 
   function createGLAccountMapping(p_GLAccount in varchar2, 
						p_Typename in varchar2 , p_GLAccountDesc in varchar2 ) return varchar2;

   function readGLAccount(p_GLAccount   in varchar2) return T_glAccountTab;

   function readUnMappedAdjustmentTypes return T_AdjustmentTypeMapTab;

   function readUnMappedProductDiscountMap return T_ProductDiscountMapTab;

   function readUnMappedTaxTypeMap return T_TaxTypeMapTab;
  
   function updateGLAccount(p_GLAccount    in varchar2,
                            p_description  in varchar2,
                            p_oldGLAccount in varchar2 ) return number;
 
	function updateGLAccountMapping( p_typeName		in varchar2, 
									p_NewGlAccount	in varchar2,
									P_oldGlAccount	in varchar2,
									p_description	in varchar2 ) return number ;
  
   function updateAllGLAccount(p_GLAccount    in varchar2,
                               p_description  in varchar2,
                               p_oldGLAccount in varchar2 ) return number; 
 
   function removeGLAccount(p_GLAccountId in varchar2)  return number;  

   function removeGLAccountMapping(p_GLAccount in varchar2, 
						      p_Typename in varchar2 ) return number;

   function removeAllGLAccount(p_GLAccount in varchar2)  return number; 
   
   function getGLAccountDescription ( p_typeName in varchar2 ,
						      p_GLAccount    in varchar2 ) return varchar2;

  /*=======================================================================*/
  /*  Product Discount Mapping                                             */
  /*=======================================================================*/

   function readAllProductDiscountTypes        return T_productDiscountTypeTab;
   
   function readAllProductDiscountMap          return T_ProductDiscountMapTab; 


  function createProductDiscountMapping(p_GlAccountId         in varchar2,
                                        p_ProductDiscountType in varchar2,
                                        p_CreditDebit         in varchar2) return varchar2;

  function updateProductDiscountMapping(p_ProductDiscountType    in varchar2,
                                        p_GlAccountId            in varchar2,
                                        p_CreditDebit            in varchar2,
                                        p_oldProductDiscountType in varchar2,
                                        p_oldGlAccountId         in varchar2) return number; 
 
 
  function removeProductDiscountMapping(p_ProductDiscountType in varchar2,
                                        p_GlAccountId         in varchar2) return number;

  /*=======================================================================*/
  /*  Adjustment Type Mapping                                             */
  /*=======================================================================*/

   function readAllAdjustmentTypes(p_custType in varchar2) return T_AdjustmentTypeTab;
   
   function readAllAdjustmentTypeMap         return T_AdjustmentTypeMapTab;
   
   function createAdjustmentTypeMapping(p_GlAccountId        in varchar2,
                                        p_AdjustmentTypeName in varchar2) return varchar2;

   function  updateAdjustmentTypeMapping(p_AdjustmentTypeName    in varchar2,
                                         p_GlAccountId           in varchar2,
                                         p_oldAdjustmentTypeName in varchar2,
                                         p_oldGlAccountId        in varchar2) return number; 

   function removeAdjustmentTypeMapping(p_AdjustmentTypeName in varchar2,
                                        p_GlAccountId       in varchar2) return number;

  /*=======================================================================*/
  /*  Tax Type Mapping                                                     */
  /*=======================================================================*/

   function readAllCustomTaxTypes                    return T_CustomTaxTypeTab;

   function readAllTaxTypeMap                        return T_TaxTypeMapTab;    

   function createTaxTypeMapping(p_TaxTypeDescription in varchar2,
                                 p_GlAccountId        in varchar2) return varchar2;

   function updateTaxTypeMapping(p_TaxTypeDescription in varchar2,
                                 p_GlAccountId        in varchar2,
                                 p_oldTaxTypeDescription in varchar2,
                                 p_oldGlAccountId        in varchar2) return number;
 
   function removeTaxTypeMapping(p_TaxTypeDescription in varchar2,
                                 p_GlAccountId        in varchar2) return number;

  /*=======================================================================*/
  /*  SkfCategory                                                          */
  /*=======================================================================*/
  
   function readAllSkfCategoryMap     return T_SkfCategoryMapTab;    
   
   function createSkfCategory(p_SkfAccount          in varchar2,
                              p_SkfDescription      in varchar2,
                              p_UsageSubscriberSkf  in varchar2 ) return varchar2;
 
   function updateSkfCategory(p_newSkfAccount		in varchar2,
                              p_SkfDescription      in varchar2,
                              p_UsageSubscriberSkf  in varchar2 ) return number;
							      
   function removeSkfCategory(p_UsageSubscriberSkf  in varchar2) return number; 
   
   	function handleUpdateSkfCategory(p_newSkfAccount in varchar2,
                              p_SkfDescription      in varchar2,
                              p_UsageSubscriberSkf  in varchar2 ) return number;

  /*=======================================================================*/
  /*   Others                                                              */
  /*=======================================================================*/
 
   function getAllGLTaxTypes                   return T_glTaxTypeTab;  
   function getAllGLLineItemTextMap            return T_glLineItemTextMapTab;  
   function getAllGLRevenueCodeMap             return T_glRevenueCodeMapTab;

  /*=======================================================================*/
  /*                                                                       */
  /*=======================================================================*/
   
   function  getVersion                        return varchar2;
   procedure printRefCursor(p_cursor IN OUT SYS_REFCURSOR);
   
end TMOREFDATA;
/
create or replace package body tmobile_custom.TMOREFDATA is
 
  -- Private type declarations

  -- Private constant declarations

  c_myVersion CONSTANT VARCHAR2(256) := 'tmoRefData.bdy-0.9.2:sqlbdy'; 

  -- Value defined in TMO_ACCT_MAPPING.CUST_TYPE for M2M customers.
  C_M2M_CUST_TYPE     constant VARCHAR2(10) := 'Var';
  C_BILLING_CUST_TYPE constant VARCHAR2(10) := 'billing';
  C_MVNO_CUST_TYPE    constant VARCHAR2(10) := 'Wholesale';
  --C_MVNE_CUST_TYPE    constant VARCHAR2(10) := 'mvne';

  -- Adjustment type pattern for customers
  C_M2M_ADJ_TYPE_PATTERN  constant VARCHAR2(11) := '%M2M%';
  C_MVNO_ADJ_TYPE_PATTERN constant VARCHAR2(11) := '%Wholesale%';

  c_AllCCPCs_sql constant clob 
    := q'[SELECT DISTINCT CCPC_CODE, COMPANY_CODE, CCPC_DESCRIPTION
            FROM TMOBILE_CUSTOM.TMO_CCPC
        ORDER BY CCPC_CODE]';

   c_AllGLAccounts_sql constant clob 
    := q'[SELECT DISTINCT GL_ACCOUNT, GL_ACCOUNT_DESCRIPTION,LINE_ITEM_TEXT
            FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP map
           WHERE CATEGORY_IND='REVENUE' 
             AND LENGTH(GL_ACCOUNT)=8
             AND LINE_ITEM_TEXT = ( SELECT MAX(LINE_ITEM_TEXT)
                                      FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
                                     WHERE GL_ACCOUNT=MAP.GL_ACCOUNT) 
          ORDER BY GL_ACCOUNT]'; 
       
  c_AllProductDiscountTypes_sql constant clob 
    := q'[SELECT EVENT_DISCOUNT_ID as ID,
                 DISCOUNT_NAME as NAME,
                 DISCOUNT_DESC as DESCR,
                 'DISCOUNT' as TYPE 
            FROM GENEVA_ADMIN.EVENTDISCOUNT ED 
            JOIN GENEVA_ADMIN.CATALOGUECHANGE CC
              ON ED.CATALOGUE_CHANGE_ID=CC.CATALOGUE_CHANGE_ID 
             AND CATALOGUE_STATUS=3
           UNION ALL 
          SELECT EVENT_TYPE_ID as ID,
                 EVENT_TYPE_NAME as NAME,
                 EVENT_TYPE_NAME as DESCR,
                 'CHARGE' as TYPE 
            FROM GENEVA_ADMIN.EVENTTYPE ET 
           WHERE EVENT_TYPE_ID>0
           ORDER BY NAME]';
         
    c_AllSkfCtgryMap_sql constant clob 
    := q'[SELECT DISTINCT GL_ACCOUNT, GL_ACCOUNT_DESCRIPTION,LINE_ITEM_TEXT
            FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP map 
           WHERE LENGTH(GL_ACCOUNT)=3
        ORDER BY GL_ACCOUNT]';
         
    c_AdjustmentTypeMap_sql constant clob 
    := q'[SELECT DISTINCT TMO_GLLINEITEMTEXTMAP.GL_ACCOUNT,
                 TMO_GLLINEITEMTEXTMAP.GL_ACCOUNT_DESCRIPTION,
                 TMO_GLLINEITEMTEXTMAP.LINE_ITEM_TEXT,
                 ADJ.ADJUSTMENT_TYPE_ID, 
                 ADJ.ADJUSTMENT_TYPE_NAME,
                 ADJ.ADJUSTMENT_TYPE_DESC 
            FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
            JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP 
              ON TMO_GLLINEITEMTEXTMAP.LINE_ITEM_TEXT=TMO_GLREVENUECODEMAP.LINE_ITEM_TEXT
            JOIN GENEVA_ADMIN.ADJUSTMENTTYPE ADJ 
              ON TMO_GLREVENUECODEMAP.LINE_ITEM_TEXT=ADJ.ADJUSTMENT_TYPE_NAME]';
                  
     c_AllTaxTypeMap_sql constant clob 
    := q'[SELECT GL.GL_ACCOUNT,
                 GL.GL_ACCOUNT_DESCRIPTION,
                 GL.LINE_ITEM_TEXT,
                 TAX.TAX_TYPE_ID, 
                 TAX.CHARGE_GROUP_ID, 
                 TAX.TAX_AUTHORITY, 
                 TAX.TAX_TYPE_NAME
            FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL
            JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP MAP
              ON GL.LINE_ITEM_TEXT = MAP.LINE_ITEM_TEXT
            JOIN TMOBILE_CUSTOM.TMO_GLTAXTYPES TAX
              ON MAP.LINE_ITEM_TEXT=TAX.TAX_TYPE_NAME
           ORDER BY 2]';
                         
   c_AllProductDiscountMap_sql constant clob 
    := q'[SELECT GL.GL_ACCOUNT, 
                 GL.GL_ACCOUNT_DESCRIPTION,
                 GL.LINE_ITEM_TEXT,
                 REV.REVENUE_CODE_NAME,
                 ID,
                 DESCR,
                 CREDIT,
                 TYPE
            FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL 
            JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP REV 
              ON GL.LINE_ITEM_TEXT=REV.LINE_ITEM_TEXT
            JOIN (SELECT EVENT_DISCOUNT_ID as ID,
                         DISCOUNT_NAME     as NAME,
                         DISCOUNT_DESC     as DESCR,
                         'DISCOUNT'        as TYPE
                    FROM GENEVA_ADMIN.EVENTDISCOUNT ED 
                    JOIN GENEVA_ADMIN.CATALOGUECHANGE CC
                      ON ED.CATALOGUE_CHANGE_ID = CC.CATALOGUE_CHANGE_ID 
                     AND CATALOGUE_STATUS=3
                  UNION ALL 
                  SELECT EVENT_TYPE_ID   as ID, 
                         EVENT_TYPE_NAME as NAME,
                         EVENT_TYPE_NAME as DESCR,
                         'CHARGE'        as TYPE 
                    FROM GENEVA_ADMIN.EVENTTYPE ET
                   WHERE EVENT_TYPE_ID>0) TEST
            ON REV.LINE_ITEM_TEXT = NAME]';
    
   c_AllGLTaxTypes_sql constant clob 
    := q'[select * 
            from TMOBILE_CUSTOM.TMO_GLTAXTYPES]';

  c_AllCustomTaxTypes_sql constant clob
    := q'[SELECT TAX_TYPE_ID, CHARGE_GROUP_ID, TAX_AUTHORITY, TAX_TYPE_NAME
            FROM TMOBILE_CUSTOM.TMO_GLTAXTYPES ORDER BY TAX_TYPE_ID]';

  c_AllGLLineItemTextMap_sql constant clob  
    := q'[select * from TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP]';
    
  c_AllGLRevenueCodeMap_sql constant clob 
    := q'[select * from TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP]';


  c_AllAdjustmentTypes_sql constant clob 
  := q'[SELECT ADJUSTMENT_TYPE_ID, ADJUSTMENT_TYPE_NAME, ADJUSTMENT_TYPE_DESC
        FROM GENEVA_ADMIN.PVADJUSTMENTTYPE4 WHERE ADJUSTMENT_TYPE_NAME LIKE :P_Adj_Type_Pattern
        AND NOT EXISTS ( SELECT 1 
                       FROM   TMOBILE_CUSTOM.TMO_DISPADJ_EVENTMAPPING
                         WHERE  NEW_ADJ_TYPE_ID=ADJUSTMENT_TYPE_ID )
        ##OR_ADJUSTMENT_TYPE_NAME##
      ORDER BY ADJUSTMENT_TYPE_ID]';

   c_UnAllAdjustmentType_sql constant clob 
  := q'[SELECT  GLITEMMAP.GL_ACCOUNT  GL_ACCOUNT,
        GLITEMMAP.GL_ACCOUNT_DESCRIPTION GL_ACCOUNT_DESCRIPTION ,
        TEST.ADJUSTMENT_TYPE_NAME  LINE_ITEM_TEXT, 
        TEST.ADJUSTMENT_TYPE_ID ADJUSTMENT_TYPE_ID,  
        TEST.ADJUSTMENT_TYPE_NAME ADJUSTMENT_TYPE_ID,  
        TEST.ADJUSTMENT_TYPE_DESC   ADJUSTMENT_TYPE_DESC             
		FROM (     
			SELECT ED.REVENUE_CODE_ID as ID,
			ADJUSTMENT_TYPE_NAME as ADJUSTMENT_TYPE_NAME,
			ADJUSTMENT_TYPE_DESC as ADJUSTMENT_TYPE_DESC,
			ADJUSTMENT_TYPE_ID   as ADJUSTMENT_TYPE_ID , 
			revenue_code_name as REVENUE_CODE_NAME
			FROM GENEVA_ADMIN.ADJUSTMENTTYPE ED
			LEFT JOIN GENEVA_ADMIN.REVENUECODE REV
			ON ED.REVENUE_CODE_ID = REV.REVENUE_CODE_ID
		) 
      TEST,       
      TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP TGLREV,
      tmo_gllineitemtextmap GLITEMMAP     
		where TGLREV.REVENUE_CODE_NAME = TEST.REVENUE_CODE_NAME
		AND TGLREV.line_item_text = GLITEMMAP.line_item_text(+)
		AND TEST.ADJUSTMENT_TYPE_NAME = TGLREV.line_item_text
		AND TEST.ADJUSTMENT_TYPE_NAME not like 'D-%' 
		AND GLITEMMAP.GL_ACCOUNT is NULL ]';

      c_UnMappedProdDist_sql constant clob 		
      := q'[SELECT glitemmap.gl_account,
				glitemmap.gl_account_description,
				TEST.NAME  LINE_ITEM_TEXT,
				TEST.REVENUE_CODE_NAME,
				TEST.ID,
				TEST.DESCR,
				NULL       CREDIT,
				TEST.TYPE
			FROM (SELECT EVENT_DISCOUNT_ID as ID,
				DISCOUNT_NAME as NAME,
				DISCOUNT_DESC as DESCR,
				'DISCOUNT' as TYPE,
				revenue_code_name as REVENUE_CODE_NAME
			FROM GENEVA_ADMIN.EVENTDISCOUNT ED
			LEFT JOIN GENEVA_ADMIN.REVENUECODE REV
			ON ED.REVENUE_CODE_ID = REV.REVENUE_CODE_ID
			JOIN GENEVA_ADMIN.CATALOGUECHANGE CC
			ON ED.CATALOGUE_CHANGE_ID = CC.CATALOGUE_CHANGE_ID
			AND CATALOGUE_STATUS = 3
			AND ED.revenue_code_id is NOT NULL) TEST,
			TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP reve,
			tmo_gllineitemtextmap glitemmap
		where reve.REVENUE_CODE_NAME = test.REVENUE_CODE_NAME
		and reve.line_item_text = glitemmap.line_item_text(+)
		and test.Name = reve.line_item_text
		AND gl_account is null
		]';

	c_UnAllTaxTypeMap_sql constant clob 
	  := q'[SELECT GL.GL_ACCOUNT, 
		  GL.GL_ACCOUNT_DESCRIPTION,  
		  TAX.TAX_TYPE_NAME LINE_ITEM_TEXT, 
		  TAX.TAX_TYPE_ID,  
		  TAX.CHARGE_GROUP_ID, 
		  TAX.TAX_AUTHORITY,  
		  TAX.TAX_TYPE_NAME 
		FROM TMOBILE_CUSTOM.TMO_GLTAXTYPES TAX
		LEFT OUTER JOIN   TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL
		ON GL.LINE_ITEM_TEXT =TAX.TAX_TYPE_NAME
		WHERE GL.LINE_ITEM_TEXT IS NULL
		UNION
		SELECT GL.GL_ACCOUNT, 
		  GL.GL_ACCOUNT_DESCRIPTION,  
		  TAX.TAX_TYPE_NAME LINE_ITEM_TEXT, 
		  TAX.TAX_TYPE_ID,  
		  TAX.CHARGE_GROUP_ID, 
		  TAX.TAX_AUTHORITY,  
		  TAX.TAX_TYPE_NAME 
		FROM TMOBILE_CUSTOM.TMO_GLTAXTYPES TAX
		LEFT JOIN   TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL
		ON GL.LINE_ITEM_TEXT =TAX.TAX_TYPE_NAME
		LEFT OUTER JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP RV
		ON GL.LINE_ITEM_TEXT = RV.LINE_ITEM_TEXT
		WHERE RV.LINE_ITEM_TEXT IS NULL]';

   
  -- Private variable declarations

 
  -- Function and procedure implementations

  function executeQuery(p_query in clob)  return SYS_REFCURSOR
  is
  l_cursor SYS_REFCURSOR;
  begin
      open l_cursor for p_query;
      return l_cursor;
  end;
  
  --
  -- Create a mapping between a general ledger account and adjustment types
  -- 
  -- @param entityId  entity identifier
  -- @param glAccountId  gl account identifier
  -- @param creditDebit  credit(T)/debit(F)
  -- 
  function createCustomMapping(p_entityId    in varchar2,
                               p_glAccountId in varchar2,
                               p_creditDebit in varchar2)  return varchar2
  is
  v_REVENUE_CODE_NAME VARCHAR2(40);
  begin
       INSERT INTO TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP
       (REVENUE_CODE_NAME,  LINE_ITEM_TEXT,CREDIT) 
       VALUES (p_entityId,p_glAccountId,p_creditDebit)
       returning REVENUE_CODE_NAME into v_REVENUE_CODE_NAME;
       return v_REVENUE_CODE_NAME;  
  end createCustomMapping;

  --
  -- Update a mapping between a general ledger account and adjustment types
  -- 
  -- @param entityId  entity identifier
  -- @param glAccountId  gl account identifier
  -- @param credit       credit(T)/debit(F)
  -- @param oldEntityId  previous entity identifier
  -- @param oldGlAccountId  previous gl account identifier

  -- 
  function updateCustomMapping(p_entityId        in varchar2,
                                p_glAccountId     in varchar2,
                                p_creditDebit     in varchar2,
                                p_old_entityId    in varchar2,
                                p_old_glAccountId in varchar2)  return number
    is 
    begin 
         UPDATE TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP 
            SET REVENUE_CODE_NAME=p_entityId,
                LINE_ITEM_TEXT=p_glAccountId,
                CREDIT=p_creditDebit 
         WHERE REVENUE_CODE_NAME=p_old_entityId 
           AND LINE_ITEM_TEXT=p_old_glAccountId;
         
         return SQL%ROWCOUNT;
                   
    end updateCustomMapping;

    --
    -- Remove a mapping between a general ledger account and adjustment types
    -- 
    -- @param entityId entityId
    -- @param glAccountId  GL Account identifier
    --
    function removeCustomMapping(p_entityId        in varchar2,
                                 p_glAccountId     in varchar2)  return number
    is 
    begin 
        DELETE FROM TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP 
        WHERE REVENUE_CODE_NAME=p_entityId 
          AND LINE_ITEM_TEXT=p_glAccountId;
 
         return SQL%ROWCOUNT;
                   
    end removeCustomMapping;

  /*=======================================================================*/
  /*  CCPC                                                                 */
  /*=======================================================================*/

  function readAllCCPCs                            return T_ccpcTab
  is
  l_cursor     SYS_REFCURSOR;
  l_returnData T_ccpcTab;
  begin
      l_cursor := executeQuery(c_AllCCPCs_sql);
      
      fetch l_cursor bulk collect into l_returnData;    
      
      close l_cursor;
      
      return l_returnData;
      
  end;

  /*=======================================================================*/
  /*  GL Account                                                           */
  /*=======================================================================*/

  function readAllGLAccounts                       return T_glAccountTab 
  is 
    l_cursor     SYS_REFCURSOR;
    l_returnData T_glAccountTab;
  begin
       
      l_cursor := executeQuery(c_AllGLAccounts_sql);
      fetch l_cursor bulk collect into l_returnData;  
      close l_cursor;      

      return l_returnData; 
  end; 

  function readUnMappedAdjustmentTypes	return T_AdjustmentTypeMapTab 
  is 
    l_cursor     SYS_REFCURSOR;
    l_returnData T_AdjustmentTypeMapTab;
  begin
       
      l_cursor := executeQuery(c_UnAllAdjustmentType_sql);
      fetch l_cursor bulk collect into l_returnData;  
      close l_cursor;      

      return l_returnData; 
  end;  

  function readUnMappedTaxTypeMap	return T_TaxTypeMapTab 
  is 
    l_cursor     SYS_REFCURSOR;
    l_returnData T_TaxTypeMapTab;
  begin
       
      l_cursor := executeQuery(c_UnAllTaxTypeMap_sql);
      fetch l_cursor bulk collect into l_returnData;  
      close l_cursor;      

      return l_returnData; 
  end;  

  function readUnMappedProductDiscountMap	return T_ProductDiscountMapTab 
  is 
    l_cursor     SYS_REFCURSOR;
    l_returnData T_ProductDiscountMapTab;
  begin
       
      l_cursor := executeQuery(c_UnMappedProdDist_sql);
      fetch l_cursor bulk collect into l_returnData;  
      close l_cursor;      

      return l_returnData; 
  end;  

  --
  -- Create a new general ledger account
  -- 
  -- @param account            GL Account
  -- @param description        description
  -- @param identifier         identifier
  --
     
   function createGLAccount(p_GLAccount   in varchar2,
                            p_description in varchar2,
                            p_identifier  in varchar2 ) return VARCHAR2
   is
     v_line_item_text VARCHAR2(50);
   begin
      INSERT INTO TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
      (GL_ACCOUNT, LINE_ITEM_TEXT, GL_ACCOUNT_DESCRIPTION, CATEGORY_IND, REPORTING_IND, READONLY_FLAG)
      VALUES (p_GLAccount,p_identifier,p_description,'REVENUE','PROFIT',  'F' )
      returning LINE_ITEM_TEXT into v_line_item_text;
      return v_line_item_text;
   end;
 
   function createGLAccount(p_GLAccount   in varchar2,
                            p_description in varchar2 ) return VARCHAR2
   is
   begin
        return createGLAccount(p_GLAccount,p_description,p_GLAccount);
   end;

   function createGLAccountMapping(p_GLAccount   in varchar2, 
                            p_Typename  in varchar2 , p_GLAccountDesc in varchar2 ) return VARCHAR2
   is
     v_line_item_text VARCHAR2(50);
	 GLAccountDesc varchar2(64) := null;
   begin 
    GLAccountDesc := p_GLAccountDesc;
	-- FIX for issue : TMOGENESIS-24451
	-- if there is no GL ACC Desc from input , then get it from line item text map table with given input.
	-- otherwise use that description while creating the mapping.
	--This check for update GLAccountMapping function input. 
	if 	GLAccountDesc IS NULL THEN	
		GLAccountDesc := getGLAccountDescription( p_Typename , p_GLAccount );
	END IF;
	
    INSERT INTO TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
      ( LINE_ITEM_TEXT, GL_ACCOUNT,  CATEGORY_IND, REPORTING_IND,  READONLY_FLAG , GL_ACCOUNT_DESCRIPTION )
	SELECT LINE_ITEM_TEXT, p_GLAccount , 'REVENUE' CATEGORY_IND , 'PROFIT' REPORTING_IND , 'F' READONLY_FLAG , GLAccountDesc
	FROM TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP  
	WHERE LINE_ITEM_TEXT = p_Typename;

	if SQL%ROWCOUNT = 0 then 
		v_line_item_text := null;
	else 
		v_line_item_text := p_Typename;
	end if;

      return v_line_item_text;
   end;
   
   function readGLAccount(p_GLAccount   in varchar2) return T_glAccountTab
   is
      l_cursor SYS_REFCURSOR;
      c_query clob 
      := q'[SELECT DISTINCT GL_ACCOUNT, GL_ACCOUNT_DESCRIPTION,LINE_ITEM_TEXT
             FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP map
            WHERE CATEGORY_IND='REVENUE' 
              AND LENGTH(GL_ACCOUNT)=8
              AND GL_ACCOUNT = :P_GL_ACCT
              AND LINE_ITEM_TEXT = ( SELECT MAX(LINE_ITEM_TEXT)
                                       FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
                                      WHERE GL_ACCOUNT=MAP.GL_ACCOUNT) ORDER BY GL_ACCOUNT]';
    
       l_returnData T_glAccountTab;
    begin
      open l_cursor for c_query using p_GLAccount;
      fetch l_cursor bulk collect into  l_returnData;
      close l_cursor;
      return l_returnData;
   end; 
  
    --
    -- Update information of a general ledger account the current general ledger account is required
    -- to identify the record to be changed
    -- 
    -- @param account    GL Account            
    -- @param description description            
    -- @param oldAccount  previous description
    --            
    --
 
   function updateGLAccount(p_GLAccount    in varchar2,
                            p_description  in varchar2,
                            p_oldGLAccount in varchar2 ) return number
   is
   begin
         UPDATE TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP 
            SET GL_ACCOUNT             = p_GLAccount,
                GL_ACCOUNT_DESCRIPTION = p_description 
          WHERE GL_ACCOUNT             = p_oldGLAccount;
     
       return SQL%ROWCOUNT;
   end;
  
   --  
   -- Update information of a general ledger account the current general ledger account is required
   --  to identify the record to be changed
   -- 
   -- @param account     GL Account
   -- @param description description
   -- @param oldAccount  previous account
   --
   
   function updateAllGLAccount(p_GLAccount    in varchar2,
                               p_description  in varchar2,
                               p_oldGLAccount in varchar2 ) return number
   is
   begin    
       return updateGLAccount(p_GLAccount, p_description, p_oldGLAccount);
   end;

   -- FIX for issue : TMOGENESIS-24451
   --@param p_typeName line item text
   --@param p_GLAccount GL account
	function getGLAccountDescription ( p_typeName      in varchar2 ,
				p_GLAccount    in varchar2 ) return varchar2
	is 
		GLAccountDesc varchar2(64) := null;
	begin
	
		DBMS_OUTPUT.put_line ( 'line item : ' || p_typeName || ',GLAccount :' || p_GLAccount );
	
	begin 	
	SELECT GL_ACCOUNT_DESCRIPTION INTO GLAccountDesc
	FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
    WHERE GL_ACCOUNT = LINE_ITEM_TEXT
	 AND LINE_ITEM_TEXT = p_GLAccount;
	 
    EXCEPTION 
	when no_data_found then
		dbms_output.put_line( 'No Desc found from lineitem text map ');
		GLAccountDesc := NULL;
	end;

	return GLAccountDesc ;
   end;
   --
   -- Update information of a general ledger account the current general ledger account is required
   -- to identify the record to be changed
   -- 
   -- @param glAccount      GL Account
   -- @param glDescription  description
   -- @param glAccountId    Gl Account identifier
   -- @param oldGlAccountId previous Gl Account identifier
   -- @param p_typeName		LINE_ITEM_TEXT 
   --
   
   function updateGLAccountMapping( p_typeName	in varchar2, 
									p_NewGlAccount	in varchar2,
									P_oldGlAccount	in varchar2,
									p_description	in varchar2 ) return number
   is
	numRowDeleted number := 0;
	GLAccountCreated varchar2(50) := null;
	mappingCreated number :=0;
	GLAccountDesc varchar2(64) := null;
   begin

   -- FIX for issue : TMOGENESIS-24451
   -- 1st get the description from the line item text map table.
   -- some times it may be NULL , if there is no mapping.
   -- so , again we have check in createGLAccountMapping function to get proper value.
   
   --Added extra inputs for fixing the issue : TMOGENESIS-25472
    GLAccountDesc := p_description;
	--If Description is passed as NULL, then get it from existing mapping
	IF GLAccountDesc IS NULL THEN 
		GLAccountDesc := getGLAccountDescription ( p_typeName , p_NewGlAccount );
	END IF;
	
	DELETE 
          FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
         WHERE GL_ACCOUNT = P_oldGlAccount
         AND GL_ACCOUNT <> p_typeName
	 AND READONLY_FLAG = 'F'
	 AND LINE_ITEM_TEXT = p_typeName;

	 numRowDeleted := SQL%ROWCOUNT;
	 
     GLAccountCreated := createGLAccountMapping( p_NewGlAccount , p_typeName , GLAccountDesc );
	 
	 if GLAccountCreated IS NOT NULL then
		mappingCreated := 1;
	 end if ;
	 
	dbms_output.put_line( 'Total Rows Deleted : ' || numRowDeleted || ' Is Maping created : ' || mappingCreated );
	-- Mapping deleted and created SuccessFully
	if numRowDeleted > 0 and mappingCreated > 0 then 	
		return mappingCreated; 
	-- If there is no mapping and now created Successfully
	elsif numRowDeleted = 0 and mappingCreated > 0 then
		return mappingCreated;
	-- Returning -1 and printing err.
	else 
		dbms_output.put_line( 'There is an issue with Mapping Deleteion OR creation.' );
		return -1;
	end if;
	
	return numRowDeleted;

   end;
   
   function handleUpdateSkfCategory(p_newSkfAccount		  in varchar2, 
									p_SkfDescription      in varchar2,
									p_UsageSubscriberSkf  in varchar2 ) return number
   is
   
	numRowUpdated number := 0;
	lineItemText VARCHAR2(50) := null ;
	v_line_item_text VARCHAR2(50) := null ;
	
	
   --1st get the oldone and update the new one. or directly update the oldone.
   BEGIN
   
   lineItemText := p_UsageSubscriberSkf;
   
   if lineItemText IS NULL THEN 
		DBMS_OUTPUT.put_line ( 'p_UsageSubscriberSkf should not be NULL');
		return -1;
	END IF;
	
	if p_newSkfAccount IS NULL THEN 
		DBMS_OUTPUT.put_line ( 'p_newSkfAccount should not be NULL');
		return -1;
	END IF;
	
	v_line_item_text := SUBSTR(lineItemText, 1, 4 );
	
	if v_line_item_text = 'SKF_' then 
      DBMS_OUTPUT.put_line (  'p_UsageSubscriberSkf started with SKF_'  );
   elsif v_line_item_text  = 'skf_'  then 
      DBMS_OUTPUT.put_line (  'p_UsageSubscriberSkf should start with SKF_ '  );
	  return -1;
   else 
      lineItemText := CONCAT ('SKF_' , lineItemText) ;
   end if;
   
   DBMS_OUTPUT.put_line (  'lineItemText Values : ' || lineItemText );
   
	update TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
		set GL_ACCOUNT         = p_newSkfAccount ,
		GL_ACCOUNT_DESCRIPTION = p_SkfDescription
	where LINE_ITEM_TEXT = p_UsageSubscriberSkf
		AND READONLY_FLAG = 'F';
   
   numRowUpdated := SQL%ROWCOUNT;
   
   dbms_output.put_line( 'Total Rows Updated : ' || numRowUpdated );
   
   return numRowUpdated;
   
   end;
   
   --
   -- Remove a general ledger account
   -- 
   -- @param identifier  gl account id
   --
   function removeGLAccount(p_GLAccountId in varchar2)  return number  
   is
     numRowDeleted number := 0;
   begin 
       
     DELETE 
        FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP 
	WHERE LINE_ITEM_TEXT = p_GLAccountId
		AND READONLY_FLAG='F';

        numRowDeleted := numRowDeleted + SQL%ROWCOUNT;

   
        return numRowDeleted;
    end;

   --
   -- Remove all general ledger account
   -- 
   -- @param p_GLAccount GL Account
   -- @param p_Typename Can be adjustment type name, Tax type name or Discount type name

    function removeGLAccountMapping(p_GLAccount in varchar2, 
						      p_Typename in varchar2 ) return number
    is
	 numRowDeleted number := 0;
   begin 
       
         DELETE 
         FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
         WHERE GL_ACCOUNT = p_GLAccount
         AND GL_ACCOUNT <> p_Typename
	 AND READONLY_FLAG = 'F'
	 AND LINE_ITEM_TEXT = p_Typename;

	 numRowDeleted := SQL%ROWCOUNT;

         return numRowDeleted;
    end;

   --
   -- Remove all general ledger account
   -- 
   -- @param account gl account 
   --
   function removeAllGLAccount(p_GLAccount in varchar2)  return number  
   is
     numRowDeleted number := 0;
   begin   
     -- delete adjustment type mappings
     DELETE 
       FROM TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP MAPP
      WHERE (LINE_ITEM_TEXT, REVENUE_CODE_NAME) 
            IN (SELECT GL.LINE_ITEM_TEXT, REVENUE_CODE_NAME
                  FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL
                  JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP MAP 
                    ON GL.LINE_ITEM_TEXT=MAP.LINE_ITEM_TEXT
                  JOIN GENEVA_ADMIN.ADJUSTMENTTYPE ADJ
                    ON MAP.REVENUE_CODE_NAME=ADJ.ADJUSTMENT_TYPE_NAME
                 WHERE GL.GL_ACCOUNT = p_GLAccount
		 AND GL.READONLY_FLAG = 'F');

       numRowDeleted := SQL%ROWCOUNT;
 
      -- delete tax type mappings
     DELETE
       FROM TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP MAPP
      WHERE (LINE_ITEM_TEXT, REVENUE_CODE_NAME) 
            IN (SELECT MAP.LINE_ITEM_TEXT, MAP.REVENUE_CODE_NAME
                  FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL
                  JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP MAP
                    ON GL.LINE_ITEM_TEXT = MAP.LINE_ITEM_TEXT
                  JOIN TMOBILE_CUSTOM.TMO_GLTAXTYPES TAX
                    ON MAP.REVENUE_CODE_NAME=TAX.TAX_TYPE_NAME
                 WHERE GL_ACCOUNT = p_GLAccount
		 AND GL.READONLY_FLAG = 'F');

      numRowDeleted := numRowDeleted + SQL%ROWCOUNT;

      -- delete product charge/discount mappings
      DELETE 
        FROM TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP MAPP
       WHERE (LINE_ITEM_TEXT, REVENUE_CODE_NAME) 
             IN ( 
                 SELECT REV.LINE_ITEM_TEXT, REV.REVENUE_CODE_NAME
                   FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP GL 
                   JOIN TMOBILE_CUSTOM.TMO_GLREVENUECODEMAP REV
                     ON GL.LINE_ITEM_TEXT=REV.LINE_ITEM_TEXT
                   JOIN (SELECT EVENT_DISCOUNT_ID as ID,
                                DISCOUNT_NAME as NAME,
                                DISCOUNT_DESC as DESCR,
                                'DISCOUNT' as TYPE
                           FROM GENEVA_ADMIN.EVENTDISCOUNT ED
                           JOIN GENEVA_ADMIN.CATALOGUECHANGE CC
                             ON ED.CATALOGUE_CHANGE_ID = CC.CATALOGUE_CHANGE_ID
                            AND CATALOGUE_STATUS=3
                         UNION ALL 
                         SELECT EVENT_TYPE_ID as ID,
                                EVENT_TYPE_NAME as NAME,
                                EVENT_TYPE_NAME as DESCR,
                                'CHARGE' as TYPE 
                           FROM GENEVA_ADMIN.EVENTTYPE ET 
                          WHERE EVENT_TYPE_ID>0) TEST
                     ON REVENUE_CODE_NAME = NAME 
                  WHERE GL.GL_ACCOUNT = p_GLAccount
		  AND GL.READONLY_FLAG = 'F');

         numRowDeleted := numRowDeleted + SQL%ROWCOUNT;

        DELETE 
          FROM TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
         WHERE GL_ACCOUNT=p_GLAccount
	 AND READONLY_FLAG = 'F';

       numRowDeleted := numRowDeleted + SQL%ROWCOUNT;
       
     return numRowDeleted;
    end;
    
  /*=======================================================================*/
  /*  Product Discount Mapping                                             */
  /*=======================================================================*/
  
  function readAllProductDiscountTypes             return T_productDiscountTypeTab
  is
    l_cursor     SYS_REFCURSOR;
    l_returnData T_productDiscountTypeTab;
  
  begin
      l_cursor := executeQuery(c_AllProductDiscountTypes_sql);
        
      fetch l_cursor bulk collect into l_returnData;  
      close l_cursor;  

      return l_returnData; 
        
  end;
 
  function readAllProductDiscountMap          return T_ProductDiscountMapTab
  is
    l_cursor     SYS_REFCURSOR;
    l_returnData T_ProductDiscountMapTab;
  begin
    l_cursor := executeQuery(c_AllProductDiscountMap_sql);

    fetch l_cursor bulk collect into l_returnData;  

    close l_cursor;  

    return l_returnData;    
    
  end;

  -- create an Product Discount mapping to a GL account
  -- 
  -- @param adjustmentTypeMap adjustment type mapping
  --             
  
  function createProductDiscountMapping(p_GlAccountId         in varchar2,
                                        p_ProductDiscountType in varchar2,
                                        p_CreditDebit         in varchar2) return varchar2
  is 
  begin  
      return createCustomMapping(p_ProductDiscountType,p_GlAccountId, p_CreditDebit);
  end;

  --
  -- Update an adjustment type mapping to a GL account
  -- 
  -- @param adjustmentTypeMap new adjustment type mapping
  --            
  -- @param oldAdjustmentTypeMap adjustment type mapping
  --            
  --
  
    function updateProductDiscountMapping(p_ProductDiscountType    in varchar2,
                                        p_GlAccountId            in varchar2,
                                        p_CreditDebit            in varchar2,
                                        p_oldProductDiscountType in varchar2,
                                        p_oldGlAccountId         in varchar2) return number
  is
  begin
       return updateCustomMapping(p_ProductDiscountType,
                                  p_GlAccountId,
                                  p_CreditDebit,
                                  p_oldProductDiscountType,
                                  p_oldGlAccountId);
  end; 
  
  --
  -- Remove an adjustment type mapping to a GL account
  -- 
  -- @param adjustmentTypeMap
  --            adjustment type mapping
  --
  
  function removeProductDiscountMapping(p_ProductDiscountType in varchar2,
                                        p_GlAccountId         in varchar2) return number
  is
  begin
       return  removeCustomMapping(p_ProductDiscountType, p_GlAccountId);
  end;


  /*=======================================================================*/
  /*  Adjustment Type Mapping                                             */
  /*=======================================================================*/

  function getAdjTypePattern(p_custType in varchar2) return varchar2
	is
	   v_pattern VARCHAR2(11);
	begin
	   case 
		   when upper(p_custType) in (upper(C_M2M_CUST_TYPE), upper(C_BILLING_CUST_TYPE)) then v_pattern := C_M2M_ADJ_TYPE_PATTERN; 
		   when upper(p_custType) = upper(C_MVNO_CUST_TYPE)                               then v_pattern := C_MVNO_ADJ_TYPE_PATTERN;
       else null; 
    end case;
     return v_pattern;
   end;
           
  function readAllAdjustmentTypes(p_custType in varchar2) return T_AdjustmentTypeTab
  is

    l_cursor SYS_REFCURSOR;
    l_query  clob;

    l_in_values clob := '';
     
    c_or_string varchar2(30)  :='##OR_ADJUSTMENT_TYPE_NAME##';
    l_or_clause varchar2(200);
    
    l_returnData T_AdjustmentTypeTab;
    
  begin
        
    for i in (select STRING_VALUE 
              from (
                  select  STRING_VALUE
                     ,row_number() over ( partition by name order by start_dtm desc) rn 
                  from   GENEVA_ADMIN.GPARAMS
                  where  NAME='TMO_AdjustmentList_wholesale'
                  and    start_dtm <= sysdate
                 )
              where rn=1)
     loop
         l_in_values := i.STRING_VALUE;
     end loop;

     if length(l_in_values) > 0
     then
        l_or_clause := 'OR ADJUSTMENT_TYPE_NAME IN (' || l_in_values  ||  ')';
     else 
        l_or_clause := '--';
     end if;
       
     l_query:= replace(c_AllAdjustmentTypes_sql, c_or_string, l_or_clause);
  
     open l_cursor for l_query using getAdjTypePattern(p_custType);           

     fetch l_cursor bulk collect into l_returnData;  
     close l_cursor;  

     return l_returnData;

  end;

  function readAllAdjustmentTypeMap              return T_AdjustmentTypeMapTab
  is
     l_cursor     SYS_REFCURSOR;
     l_returnData T_AdjustmentTypeMapTab;

  begin
       l_cursor := executeQuery(c_AdjustmentTypeMap_sql);
  
       fetch l_cursor bulk collect into l_returnData;  
       close l_cursor;  

       return l_returnData; 
        
  end;   

  --
  -- create an adjustment type mapping to a GL account
  -- 
  -- @param adjustmentTypeMap adjustment type mapping
  --             
  
  function createAdjustmentTypeMapping(p_GlAccountId          in varchar2,
                                       p_AdjustmentTypeName in varchar2) return varchar2
  is 
  begin  
      return createCustomMapping(p_AdjustmentTypeName,p_GlAccountId, '');
  end;

  --
  -- Update an adjustment type mapping to a GL account
  -- 
  -- @param adjustmentTypeMap new adjustment type mapping
  --            
  -- @param oldAdjustmentTypeMap adjustment type mapping
  --            
  --
  
  function  updateAdjustmentTypeMapping(p_AdjustmentTypeName    in varchar2,
                                        p_GlAccountId           in varchar2,
                                        p_oldAdjustmentTypeName in varchar2,
                                        p_oldGlAccountId        in varchar2) return number
  is
  begin
       return updateCustomMapping(p_AdjustmentTypeName,
                                  p_GlAccountId,
                                  '',
                                  p_oldAdjustmentTypeName,
                                  p_oldGlAccountId);
  end; 
  
  --
  -- Remove an adjustment type mapping to a GL account
  -- 
  -- @param adjustmentTypeMap
  --            adjustment type mapping
  --
  
  function removeAdjustmentTypeMapping(p_AdjustmentTypeName in varchar2,
                                        p_GlAccountId       in varchar2) return number
  is
  begin
       return  removeCustomMapping(p_AdjustmentTypeName, p_GlAccountId);
  end;

  /*=======================================================================*/
  /*  SkfCategory                                                           */
  /*=======================================================================*/

  function readAllSkfCategoryMap           return T_SkfCategoryMapTab
  is
    l_cursor     SYS_REFCURSOR;
    l_returnData T_SkfCategoryMapTab;
  
  begin
      l_cursor := executeQuery(c_AllSkfCtgryMap_sql);
  
      fetch l_cursor bulk collect into l_returnData;
      close l_cursor;  

      return l_returnData;
       
  end;

  --
  --
  -- 
  function createSkfCategory(p_SkfAccount          in varchar2,
                             p_SkfDescription      in varchar2,
                             p_UsageSubscriberSkf  in varchar2 ) return varchar2
  is 
	lineItemText VARCHAR2(50) := null ;
	v_line_item_text VARCHAR2(50) := null ;
	select_line_item_text VARCHAR2(50):= null ;
	
   begin  
	--checking for Pre SKF_ process 
	-- the p_UsageSubscriberSkf should starts with SKF_ , if not append to the p_UsageSubscriberSkf
	lineItemText := p_UsageSubscriberSkf;
	
	if lineItemText IS NULL THEN 
		DBMS_OUTPUT.put_line ( 'p_UsageSubscriberSkf should not be NULL');
		return -1;
	END IF;
	
	v_line_item_text := SUBSTR(lineItemText, 1, 4 );
	
	if v_line_item_text = 'SKF_' then 
      DBMS_OUTPUT.put_line (  'p_UsageSubscriberSkf started with SKF_'  );
   elsif v_line_item_text  = 'skf_'  then 
      DBMS_OUTPUT.put_line (  'p_UsageSubscriberSkf should start with SKF_ '  );
	  return -1;
   else 
      lineItemText := CONCAT ('SKF_' , lineItemText) ;
   end if;
	
	DBMS_OUTPUT.put_line (  'Final p_UsageSubscriberSkf is ' || lineItemText );
	
      INSERT INTO TMOBILE_CUSTOM.TMO_GLLINEITEMTEXTMAP
      (GL_ACCOUNT, LINE_ITEM_TEXT, GL_ACCOUNT_DESCRIPTION, CATEGORY_IND, REPORTING_IND, READONLY_FLAG)
      VALUES (p_SkfAccount, lineItemText , p_SkfDescription , 'REVENUE' , 'PROFIT' , 'F' )
      returning LINE_ITEM_TEXT into select_line_item_text;
	  DBMS_OUTPUT.put_line (  'selected line_item_text is ' || select_line_item_text );
      return select_line_item_text;
	   
  end;

  --
  --
  -- 
  function updateSkfCategory(p_newSkfAccount          in varchar2,
                             p_SkfDescription      in varchar2,
                             p_UsageSubscriberSkf  in varchar2 ) return number
  is
  begin 
	--Added extra inputs for fixing the issue : TMOGENESIS-25472
	return handleUpdateSkfCategory(	p_newSkfAccount,  
                                    p_SkfDescription,     
									p_UsageSubscriberSkf);
                                    
  end; 
  --
  --
  -- 
  function removeSkfCategory(p_UsageSubscriberSkf  in varchar2) return number
  is
  begin 
         return  removeGLAccount(p_UsageSubscriberSkf); 
       --return removeGLAccountById(p_UsageSubscriberSkf); 
  end; 
 
  /*=======================================================================*/
  /*  Tax Type Mapping                                                     */
  /*=======================================================================*/
  
  function readAllCustomTaxTypes                    return T_CustomTaxTypeTab 
  is
    l_cursor     SYS_REFCURSOR;
    l_returnData T_CustomTaxTypeTab;
  begin
    l_cursor := executeQuery(c_AllCustomTaxTypes_sql);
    fetch l_cursor bulk collect into l_returnData;  
    close l_cursor;  

    return l_returnData;
  
  end;

  
  function readAllTaxTypeMap               return T_TaxTypeMapTab  
  is
    l_cursor     SYS_REFCURSOR;
    l_returnData T_TaxTypeMapTab;
  begin  
    l_cursor := executeQuery(c_AllTaxTypeMap_sql);
 
   fetch l_cursor bulk collect into l_returnData;  
    close l_cursor;  
   
    return l_returnData;  
 
  end;


  --
  -- Create a tax mapping to a GL account
  -- 
  --
  
  function createTaxTypeMapping(p_TaxTypeDescription in varchar2,
                                p_GlAccountId        in varchar2) return varchar2
  is
  begin
     return createCustomMapping(p_TaxTypeDescription, p_GlAccountId, '');
  end;

  --
  -- Update a tax mapping to a GL account
  -- 
  --
  
  function updateTaxTypeMapping(p_TaxTypeDescription in varchar2,
                                p_GlAccountId        in varchar2,
                                p_oldTaxTypeDescription in varchar2,
                                p_oldGlAccountId        in varchar2) return number
  is
  begin
     return updateCustomMapping(p_TaxTypeDescription,
                                p_GlAccountId,
                                '',
                                p_oldTaxTypeDescription,
                                p_oldGlAccountId);
  end;
  
  --
  -- Remove a tax mapping to a GL account
  -- 
  -- 
   
  function removeTaxTypeMapping(p_TaxTypeDescription in varchar2,
                                p_GlAccountId        in varchar2) return number
  is
  begin
     return removeCustomMapping(p_TaxTypeDescription, p_GlAccountId);
  end;

  /*=======================================================================*/
  /*                                                                       */
  /*=======================================================================*/
 
  function getAllGLTaxTypes                         return T_glTaxTypeTab 
  is
    l_cursor     SYS_REFCURSOR;
    l_returnData T_glTaxTypeTab;
  
  begin
    l_cursor := executeQuery(c_AllGLTaxTypes_sql);
    
     fetch l_cursor bulk collect into l_returnData;  
     close l_cursor;  

     return l_returnData;
    
  end;

  function getAllGLLineItemTextMap                  return T_glLineItemTextMapTab 
  is
  
     l_cursor     SYS_REFCURSOR;
     l_returnData T_glLineItemTextMapTab;
  
  begin
    l_cursor := executeQuery(c_AllGLLineItemTextMap_sql);
  
    fetch l_cursor bulk collect into l_returnData;  
    close l_cursor;  

  return l_returnData;
  
  end;
  
  function getAllGLRevenueCodeMap                   return T_glRevenueCodeMapTab 
  is
     l_cursor     SYS_REFCURSOR;
     l_returnData T_glRevenueCodeMapTab;  
  begin
    l_cursor := executeQuery(c_AllGLRevenueCodeMap_sql);

    fetch l_cursor bulk collect into l_returnData;  
    close l_cursor;  

    return l_returnData;

  end; 



  -------------------------------------------------------------------------
  -- PUBLIC
  -- FUNCTION : getVersion
  -- PURPOSE  : Return the package version
  -- RETURNS  : version string of this package
  -------------------------------------------------------------------------
 
  function getVersion return varchar2
  is
  begin
    return c_myVersion;
  end getVersion;

  --
  -- function for unit test of realAll fuctions
  -- 
  --

  procedure printRefCursor(p_cursor IN OUT SYS_REFCURSOR)
  is
   l_curid      NUMBER;
   l_col_cnt    INTEGER;
   rec_tab      DBMS_SQL.DESC_TAB;
   l_text       VARCHAR2 (4000);
   l_flag       NUMBER;
   l_varchar2   VARCHAR2 (4000);
   l_number     NUMBER;
   l_date       DATE;

BEGIN
   l_curid := DBMS_SQL.TO_CURSOR_NUMBER(p_cursor);

    -- define columns
  DBMS_SQL.DESCRIBE_COLUMNS (l_curid, l_col_cnt, rec_tab);
   FOR pos IN 1 .. l_col_cnt
   LOOP
      CASE rec_tab (pos).col_type
         WHEN 1 THEN
            DBMS_SQL.DEFINE_COLUMN (l_curid,pos,l_varchar2,2000);
         WHEN 2 THEN
            DBMS_SQL.DEFINE_COLUMN (l_curid, pos, l_number);
         WHEN 12 THEN
            DBMS_SQL.DEFINE_COLUMN (l_curid, pos, l_date);
         ELSE
            DBMS_SQL.DEFINE_COLUMN (l_curid,pos,l_varchar2,2000);
      END CASE;
   END LOOP;

   -- Print column names of dynamic sql
   FOR pos IN 1 .. l_col_cnt
   LOOP
      l_text := LTRIM (l_text || ',' || LOWER (rec_tab (pos).col_name), ',');
   END LOOP;

   DBMS_OUTPUT.PUT_LINE (l_text);

   -- Print data fetched by query
   LOOP
      l_flag := DBMS_SQL.FETCH_ROWS (l_curid);
      EXIT WHEN l_flag = 0;
      l_text := NULL;

      FOR pos IN 1 .. l_col_cnt
      LOOP
         CASE rec_tab(pos).col_type
            WHEN 1 THEN
               DBMS_SQL.COLUMN_VALUE (l_curid, pos, l_varchar2);
               l_text := LTRIM (l_text || ',"' || l_varchar2 || '"', ',');
            WHEN 2 THEN
               DBMS_SQL.COLUMN_VALUE (l_curid, pos, l_number);
               l_text := LTRIM (l_text || ',' || l_number, ',');
            WHEN 12 THEN
               DBMS_SQL.COLUMN_VALUE (l_curid, pos, l_date);
               l_text := LTRIM (l_text|| ','|| TO_CHAR (l_date, 'YYYY/MM/DD HH24:MI:SS'),',');
            ELSE
               l_text := LTRIM (l_text || ',"' || l_varchar2 || '"', ',');
         END CASE;
      END LOOP;
      DBMS_OUTPUT.PUT_LINE (l_text);
   END LOOP;

   DBMS_SQL.CLOSE_CURSOR (l_curid);
END;
 
--begin
 
end TMOREFDATA;

/

grant execute on TMOBILE_CUSTOM.TMOREFDATA               to UNIF_ADMIN;