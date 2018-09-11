CREATE OR REPLACE VIEW TMOBILE_CUSTOM.TOMS_OFFERNAMEMAPPING_LAST ("OBJECT_ID", "OBJECT_NAME", "UPDATED_DTM") AS 
  select object_id,object_name,updated_dtm from (
SELECT object_id,object_name,updated_dtm, row_number() over (partition by object_id order by updated_dtm desc) rn        
              FROM tmobile_custom.toms_offernamemapping 
            ) where rn=1
 WITH READ ONLY;			
GRANT SELECT ON TMOBILE_CUSTOM.TOMS_OFFERNAMEMAPPING_LAST TO UNIF_ADMIN;
GRANT SELECT ON TMOBILE_CUSTOM.TOMS_OFFERNAMEMAPPING_LAST TO PUBLIC;
			