package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import com.convergys.core.util.StringUtil;
import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class QueryCDRDataDao {

	private static TraceLog traceLog = new TraceLog(QueryCDRDataDao.class);
	private Util util;

	private int totalCount = 0;

	public QueryCDRDataDao() {
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

	public QueryCDROutputs queryCDRData(IntegratorContext integratorContext, String accountNum, String eventSource,
			int eventTypeID, int appliedBill, String optionalInputString, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, CDRDetailsKey cdrDetailsKey, Pagination pagination)
			throws ApplicationException {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		DataSource das = null;

		traceLog.traceFinest("start of queryCDRData stratTime " + startTime);

		QueryCDRDataInput queryCDRDataInput = new QueryCDRDataInput();
		QueryCDRDataOutput queryCDRDataOutput = new QueryCDRDataOutput();

		QueryCDROutputs queryCDROutputs = new QueryCDROutputs();
		try {
			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_CDR_DATA_API_NAME);
			}
			if (accountNum == null || accountNum.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_11000, Constants.QUERY_CDR_DATA_API_NAME);
			}
			if (eventSource == null || eventSource.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_11003, Constants.QUERY_CDR_DATA_API_NAME);
			}
			if (eventTypeID == 0) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_11005, Constants.QUERY_CDR_DATA_API_NAME);
			}
			/*
			 * if(cdrDetailsKey.getEventSeq() == null ||
			 * cdrDetailsKey.getEventSeq().trim().equals("") ) { throw new
			 * NullParameterException(ErrorCodes.ERR_RBM_11006,
			 * Constants.QUERY_CDR_DATA_API_NAME); }
			 * if(cdrDetailsKey.getEventCost() == null ||
			 * cdrDetailsKey.getEventCost().trim().equals("") ) { throw new
			 * NullParameterException(ErrorCodes.ERR_RBM_11007,
			 * Constants.QUERY_CDR_DATA_API_NAME); } if (cdrDetailsKey == null
			 * || cdrDetailsKey.equals("")) { throw new
			 * NullParameterException(ErrorCodes.ERR_RBM_11004,
			 * Constants.QUERY_CDR_DATA_API_NAME); }
			 */

			if (pagination == null || pagination.equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_11001, Constants.QUERY_CDR_DATA_API_NAME);
			}

			queryCDRDataInput.setIntegratorContext(integratorContext);
			queryCDRDataInput.setAccountNum(accountNum);
			queryCDRDataInput.setAppliedBillNbl(appliedBill);
			queryCDRDataInput.setCDRDetailsKey(cdrDetailsKey);
			queryCDRDataInput.setEventSource(eventSource);
			queryCDRDataInput.setEventTypeID(eventTypeID);
			queryCDRDataInput.setFilterArray(filterArray);
			queryCDRDataInput.setOptionalInputString(optionalInputString);
			queryCDRDataInput.setPagination(pagination);

			queryCDROutputs = queryCDRDataoutput(integratorContext, accountNum, eventSource, eventTypeID, appliedBill,
					optionalInputString, filterArray, sortArray, cdrDetailsKey, pagination);
			queryCDRDataOutput.setQueryCDROutputs(queryCDROutputs);

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after queryCDRData.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of queryCDRData is " + diff + "........." + diffStr);

			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, queryCDRDataInput,
					queryCDRDataOutput, responseStatus, Constants.QUERY_CDR_DATA, das, diffStr, node);

		} catch (Exception ex) {
			traceLog.traceFinest("Exception from  queryCDRData API : " + ex.getMessage());
			responseStatus = ex.getMessage();
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null, queryCDRDataInput,
					queryCDRDataOutput, responseStatus, Constants.QUERY_CDR_DATA, das, diffStr, node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_11002 + ex.getMessage().toString());
		}

		return queryCDROutputs;
	}

    private QueryCDROutputs queryCDRDataoutput(IntegratorContext integratorContext, String accountNum,
			String eventSource, int eventTypeID, int appliedBill, String optionalInputString,
			FilterArrayElements[] filterArray,SortingArrayElements[] sortArray,CDRDetailsKey cdrDetailsKey,Pagination pagination)  {
		
		

        if (traceLog.isFinestEnabled())
            traceLog.traceFinest("Inside queryCDRDataoutput");
        Connection conn = null;
        PreparedStatement pstmt = null;
        PreparedStatement pstmt1 = null;
        ResultSet resultSet = null;
        ResultSet resultSet1 = null;
        int seqNum=0;
        int seqNum1=0;
        PreparedStatement tblpstmt = null;
        ResultSet tblresultSet = null;
        CallableStatement pkgpstmt = null;
        CallableStatement pkgpstmt1 = null; 
        CallableStatement pkgpstmt2 = null;   
        QueryCDROutputs queryCDROutputs = new QueryCDROutputs();
       
        try {
            conn = util.getDataSource().getConnection();
            
            /*
             * Using the event_type_id and account_num from the input. pick the relevent duf table
             */
            traceLog.traceFinest("EventType id:"+eventTypeID);
            StringBuilder tblQuery = new StringBuilder(
				"SELECT TABLE_NAME FROM TMOBILE_CUSTOM.CDR_TMO_ACCT_MAPPING where MAPPING_ID=DECODE( " + eventTypeID 
				+ ",3,1,4,1,21,1,0) and CDR_FORMAT = DECODE((SELECT DISTINCT UF_FORMAT from TMO_ACCT_MAPPING  where BILLING_ACCT_NBR=" +"'" +accountNum+"'" +"),'Var','M2M','MVNO')");
        
            tblpstmt = conn.prepareStatement(tblQuery.toString());
            
            traceLog.traceFinest("Table Query " + tblQuery.toString());
            tblresultSet = tblpstmt.executeQuery();
            traceLog.traceFinest("After tblpstmt.executeQuery()");
            String tableName="";
            while (tblresultSet.next()) {
                
                tableName = tblresultSet.getString("TABLE_NAME");
                
            }

            traceLog.traceFinest("Table Name: " + tableName);
            pstmt = conn.prepareStatement(SQLStatements.QUERY_VIEW);
            pstmt.setString(1, tableName);
            
            traceLog.traceFinest("QUERY_VIEW " + pstmt.toString());
            resultSet = pstmt.executeQuery();

            Column[] colArr = null;
            ResultSetArray[] resultArr = null;
            List<String> resultList = new ArrayList<String>();
            List<Column> resultColumnList = new ArrayList<Column>();

            Column col = null;

            while (resultSet.next()) {

                col = new Column();
                col.setName(resultSet.getString("COLUMN_NAME"));
                col.setType(resultSet.getString("DATA_TYPE"));
                col.setSizeNbl(Integer.parseInt(resultSet.getString("DATA_LENGTH")));
                resultColumnList.add(col);
            }


            colArr = (Column[]) resultColumnList.toArray(new Column[resultColumnList.size()]);
            queryCDROutputs.setColumnArray(colArr);
            traceLog.traceFinest("queryOutput " + queryCDROutputs.getColumnArray());
          //handle the CDR DD from Subscriber usage when the cdrDetailsKey is not passed
            traceLog.traceFinest("cdrDetailsKey :"+cdrDetailsKey);
            
            if(!StringUtil.validNumber(eventSource)) {
            	queryCDROutputs.setResultSetArray(new ResultSetArray[0]);
            	queryCDROutputs.setTotalRowsCount("0");
         	   return queryCDROutputs;
            }
            
            //Issue fix - TMOGENESIS-38842
            String eventSeqStr = null;
            if(appliedBill == 2)
            {
            	
            	pstmt1 = conn.prepareStatement(SQLStatements.CREATE_DUF_CDR_OUTPUT_UN_BILLED);
            	pstmt1.setString(1, accountNum);
            	resultSet1 = pstmt1.executeQuery();
    			if (resultSet1.next()) {

    				seqNum = resultSet1.getInt(1);
	    		}

            }
            else
            {

            	pstmt1 = conn.prepareStatement(SQLStatements.CREATE_DUF_CDR_OUTPUT_BILLED);
            	pstmt1.setString(1, accountNum);
            	resultSet1 = pstmt1.executeQuery();
    			if (resultSet1.next()) {

    				seqNum = resultSet1.getInt(1);
    				if(resultSet1.next()) {
    					
    				
    				seqNum1 = resultSet1.getInt(1);
    				}
    				 traceLog.traceFinest("The seqNum inside queryCDRDataoutput:"+seqNum);
    				 traceLog.traceFinest("The seqNum1 inside queryCDRDataoutput:"+seqNum1);
    				 
    				
    			}
    			//Issue fix - TMOGENESIS-38842
    			eventSeqStr = seqNum+","+seqNum1;
            }
            
            traceLog.traceFinest("The seqNum passed inside queryCDRDataoutput:"+seqNum);
          //Load the data to the duf tables 
        	String sql = SQLStatements.CREATE_DUF_CDR_OUTPUT;
			traceLog.traceFinest("queryCDRDataoutput - The SP used to insert data into DUF: " + sql);
			String eventTypeIdStr = null;
		if (cdrDetailsKey != null) {
			pkgpstmt = conn.prepareCall(sql);
			pkgpstmt.setString(1, accountNum);
			if (cdrDetailsKey.getEventSeq() != null || !cdrDetailsKey.getEventSeq().trim().equals("")) {
				pkgpstmt.setInt(2, Integer.parseInt(cdrDetailsKey.getEventSeq()));
				traceLog.traceFinest("seqNum passed when cdrDetailsKey != null :" + cdrDetailsKey.getEventSeq());
				pkgpstmt.setInt(3, eventTypeID);
				pkgpstmt.setString(4, eventSource);
				pkgpstmt.executeQuery();
			}
			
				
			
		}// handle usage Types and set the parameters for the CDR Response
		else if (eventTypeID == 1 && cdrDetailsKey == null) {
			pkgpstmt1 = conn.prepareCall(sql);
			pkgpstmt1.setString(1, accountNum);
			pkgpstmt1.setInt(2, seqNum);
			pkgpstmt1.setInt(3, 20);
			pkgpstmt1.setString(4, eventSource);
			pkgpstmt1.executeQuery();
			
			pkgpstmt2 = conn.prepareCall(sql);
            pkgpstmt2.setString(1, accountNum);
            pkgpstmt2.setInt(2, seqNum);
            pkgpstmt2.setInt(3, 1);
            pkgpstmt2.setString(4, eventSource);
            pkgpstmt2.executeQuery();
            eventTypeIdStr = "1,20";
            
          //Issue fix - TMOGENESIS-38842
    
            if (seqNum1 != 0) {
				pkgpstmt1 = conn.prepareCall(sql);
				pkgpstmt1.setString(1, accountNum);
				pkgpstmt1.setInt(2, seqNum1);
				pkgpstmt1.setInt(3, 20);
				pkgpstmt1.setString(4, eventSource);
				pkgpstmt1.executeQuery();
				
				pkgpstmt2 = conn.prepareCall(sql);
                pkgpstmt2.setString(1, accountNum);
                pkgpstmt2.setInt(2, seqNum1);
                pkgpstmt2.setInt(3, 1);
                pkgpstmt2.setString(4, eventSource);
                pkgpstmt2.executeQuery();

			}
            
            
		}

		else if (eventTypeID == 2 && cdrDetailsKey == null) {
			pkgpstmt = conn.prepareCall(sql);
			pkgpstmt.setString(1, accountNum);
			pkgpstmt.setInt(2, seqNum);
			pkgpstmt.setInt(3, 28);
			pkgpstmt.setString(4, eventSource);
			pkgpstmt.executeQuery();
			
			pkgpstmt = conn.prepareCall(sql);
            pkgpstmt.setString(1, accountNum);
            pkgpstmt.setInt(2, seqNum);
            pkgpstmt.setInt(3, 2);
            pkgpstmt.setString(4, eventSource);
            pkgpstmt.executeQuery();
            eventTypeIdStr = "2,28";
         
          //Issue fix - TMOGENESIS-38842
    
            if (seqNum1 != 0){
                pkgpstmt = conn.prepareCall(sql);
				pkgpstmt.setString(1, accountNum);
				pkgpstmt.setInt(2, seqNum1);
				pkgpstmt.setInt(3, 28);
				pkgpstmt.setString(4, eventSource);
				pkgpstmt.executeQuery();
				
				pkgpstmt = conn.prepareCall(sql);
                pkgpstmt.setString(1, accountNum);
                pkgpstmt.setInt(2, seqNum1);
                pkgpstmt.setInt(3, 2);
                pkgpstmt.setString(4, eventSource);
                pkgpstmt.executeQuery();

            }
            
		}

		else if (eventTypeID == 3 && cdrDetailsKey == null) {
			pkgpstmt = conn.prepareCall(sql);
			pkgpstmt.setString(1, accountNum);
			pkgpstmt.setInt(2, seqNum);
			pkgpstmt.setInt(3, 21);
			pkgpstmt.setString(4, eventSource);
			pkgpstmt.executeQuery();
			
			pkgpstmt = conn.prepareCall(sql);
            pkgpstmt.setString(1, accountNum);
            pkgpstmt.setInt(2, seqNum);
            pkgpstmt.setInt(3, 3);
            pkgpstmt.setString(4, eventSource);
            pkgpstmt.executeQuery();
            eventTypeIdStr = "3,21";
          
          //Issue fix - TMOGENESIS-38842

            if (seqNum1 != 0){
            	pkgpstmt = conn.prepareCall(sql);
				pkgpstmt.setString(1, accountNum);
				pkgpstmt.setInt(2, seqNum1);
				pkgpstmt.setInt(3, 21);
				pkgpstmt.setString(4, eventSource);
				pkgpstmt.executeQuery();
				
				pkgpstmt = conn.prepareCall(sql);
                pkgpstmt.setString(1, accountNum);
                pkgpstmt.setInt(2, seqNum1);
                pkgpstmt.setInt(3, 3);
                pkgpstmt.setString(4, eventSource);
                pkgpstmt.executeQuery();
    
            }
                         
		}

		else
		{
			pkgpstmt = conn.prepareCall(sql);
			pkgpstmt.setString(1, accountNum);
			pkgpstmt.setInt(2, seqNum);
			pkgpstmt.setInt(3, eventTypeID);
			pkgpstmt.setString(4, eventSource);
			pkgpstmt.executeQuery();
			//Issue fix - TMOGENESIS-38842

			if (seqNum1 != 0){
				pkgpstmt = conn.prepareCall(sql);
				pkgpstmt.setString(1, accountNum);
				pkgpstmt.setInt(2, seqNum1);
				pkgpstmt.setInt(3, eventTypeID);
				pkgpstmt.setString(4, eventSource);
				pkgpstmt.executeQuery();
	
			}
			
		} 
		traceLog.traceFinest("totalCount after CREATE_DUF_CDR_OUTPUT executeQuery :" + totalCount);
        
            resultList = getCDRDataResult(conn, resultColumnList, integratorContext,accountNum,
    				eventSource, eventTypeID, appliedBill, optionalInputString,
    				filterArray,sortArray,cdrDetailsKey,seqNum,eventSeqStr,tableName,pagination,eventTypeIdStr);

            queryCDROutputs.setTotalRowsCount(String.valueOf(totalCount));
            resultArr = new ResultSetArray[resultList.size()];
            for (int k = 0; k < resultList.size(); k++) {
                resultArr[k] = new ResultSetArray();
                resultArr[k].setResult(resultList.get(k));
            }
            queryCDROutputs.setResultSetArray(resultArr);
            

        } catch (Exception e) {
            if (traceLog.isFinestEnabled())
                traceLog.traceFinest("Exception inside queryCDRDataoutput:: "
                        + e.getMessage());
            e.printStackTrace();
            //throw new ApplicationException(e.getMessage());
        } finally {
            util.closeResources(resultSet, conn, pstmt, null);
            util.closeResources(resultSet1, conn, pstmt1, null);
        }
        return queryCDROutputs;

	}

	private List<String> getCDRDataResult(Connection conn, List<Column> resultColumnList,
			IntegratorContext integratorContext, String accountNum, String eventSource, int eventTypeID,
			int appliedBill, String optionalInputString, FilterArrayElements[] filterArray,
			SortingArrayElements[] sortArray, CDRDetailsKey cdrdetailsKey, int seqNum, String eventSeqStr,
			String tableName, Pagination pagination, String eventTypeIdStr) {

		String resultStr = null;
		String resultStr1 = null;

		PreparedStatement pstmt2 = null;
		ResultSet resultSet1 = null;
		List<String> resultList = new ArrayList<String>();
		String queryCDRDataSql = null;
		try {
			StringBuilder tblName = new StringBuilder("GENEVABATCHUSER.");
			tblName.append(tableName);
			traceLog.traceFinest("The Table Name in getCDRDataResult is:" + tblName);
			queryCDRDataSql = buildCDRDataOutputQuery(integratorContext, tblName, accountNum, eventSource, eventTypeID,
					appliedBill, optionalInputString, filterArray, sortArray, cdrdetailsKey, seqNum, eventSeqStr,
					pagination, eventTypeIdStr);

			traceLog.traceFinest("The Query executing getCDRDataResult is: " + queryCDRDataSql);
			pstmt2 = conn.prepareStatement(queryCDRDataSql);

			resultSet1 = pstmt2.executeQuery();

			while (resultSet1.next()) {

				for (int i = 0; i < resultColumnList.size(); i++) {

					resultStr = resultSet1.getString(resultColumnList.get(i).getName());
					if (resultStr == null || resultStr == "") {
						resultStr = "''";
					}

					if (resultStr1 != null) {

						if (i < resultColumnList.size() - 1) {

							resultStr1 = resultStr1 + resultStr + "|";
						} else {
							resultStr1 = resultStr1 + resultStr;
						}

					} else {

						resultStr1 = resultStr + "|";

					}
				}
				resultList.add(resultStr1);
				resultStr1 = null;
			}
		} catch (Exception ex) {
			traceLog.traceFinest("Exception from  getCDRDataResult: " + ex.getMessage());
			ex.printStackTrace();
		} finally {
			util.closeResources(resultSet1, conn, pstmt2, null);
		}
		traceLog.traceFinest(" Result list before return " + resultList.toString());
		return resultList;

	}	
    private String buildCDRDataOutputQuery(IntegratorContext integratorContext,StringBuilder tblName, String accountNum, String eventSource,
			int eventTypeID, int appliedBill, String optionalInputString, FilterArrayElements[] filterArray,SortingArrayElements[] sortArray,CDRDetailsKey cdrdetailsKey,int seqNum,String eventSeqStr,Pagination pagination,String eventTypeIdStr) {
		traceLog.traceFinest("Entering into buildCDRDataOutputQuery : ");
		StringBuilder query = new StringBuilder();
		query.append("SELECT * FROM ");
        query.append(tblName.toString()); 
		query.append(" WHERE ACCOUNT_NUMBER =  ");
		query.append("'" + accountNum + "'");
		query.append(" AND MSISDN =  ");
		query.append("'" + eventSource + "'");
		query.append(" AND RECORD_TYPE in (");
		if (eventTypeIdStr != null) {
		    traceLog.traceFinest(" eventTypeIdStr "+ eventTypeIdStr);
		query.append(eventTypeIdStr +")");
		} else {
		    traceLog.traceFinest(" eventTypeID "+ eventTypeID);
		    query.append(eventTypeID +")");
		}
		query.append(" AND SEQUENCE_NUMBER IN (");
		if(cdrdetailsKey!=null)
		{ 
			
			traceLog.traceFinest("Inside cdrdetailsKey!=null");
			if (cdrdetailsKey.getEventSeq() != null || !("").equals(cdrdetailsKey.getEventSeq()))
			{
			  query.append(cdrdetailsKey.getEventSeq()+")");
			}
			
			traceLog.traceFinest("before Romerflag!=null");
			if(cdrdetailsKey.getRomerflag() !=null && !("").equals(cdrdetailsKey.getRomerflag().trim()) && cdrdetailsKey.getEventTypeID() !=0)
			{
				if(cdrdetailsKey.getEventTypeID() == 1 && cdrdetailsKey.getRomerflag().trim().equals("0") )
				{
					query.append(" AND AIR_CHARGE_CODE = 1");
					
				}
				else if(cdrdetailsKey.getEventTypeID() == 1 && cdrdetailsKey.getRomerflag().trim().equals("1") )
				{
					query.append(" AND AIR_CHARGE_CODE = 2");
					
				}
				else if(cdrdetailsKey.getEventTypeID() == 20 )
				{
					query.append(" AND AIR_CHARGE_CODE = 3");
					
				}
				else if(cdrdetailsKey.getEventTypeID() == 2 && cdrdetailsKey.getRomerflag().trim().equals("0") )
				{
					query.append(" AND AIR_CHARGE_CODE = 4");
					
				}
				else if(cdrdetailsKey.getEventTypeID() == 2 && cdrdetailsKey.getRomerflag().trim().equals("1") )
				{
					query.append(" AND AIR_CHARGE_CODE = 5");
					
				}
				else if(cdrdetailsKey.getEventTypeID() == 28)
				{
					query.append(" AND AIR_CHARGE_CODE = 6");
					
				}
				
			}
			
			if(cdrdetailsKey.getCostBand() !=null && !("").equals(cdrdetailsKey.getCostBand().trim()))
			{
				
					query.append(" AND COST_BAND = ");
					query.append("'" + cdrdetailsKey.getCostBand() + "'");	
				
			}
			if(cdrdetailsKey.getEventClass() !=null && !("").equals(cdrdetailsKey.getEventClass().trim()))
			{
				
					query.append(" AND TRIM(EVENT_CLASS) = ");
					query.append("'" + cdrdetailsKey.getEventClass().trim() + "'");	
				
			}
			if(cdrdetailsKey.getEventTypeID() == 3)
			{
				if(cdrdetailsKey.getDiscountName() != null &&!("").equals(cdrdetailsKey.getDiscountName().trim())) {
					
					query.append(" AND TRIM(DISCOUNT_NAME) = ");
					query.append("'" + cdrdetailsKey.getDiscountName().trim() + "'");	
					
				}
				else 
				{
					query.append(" AND DISCOUNT_NAME IS NULL ");
					
				}
					
				
			}
			
			query.append(" AND CHARGING_RATE = ");
			query.append(cdrdetailsKey.getChargingRate());
			
			if(cdrdetailsKey.getTechType() !=null && !("").equals(cdrdetailsKey.getTechType().trim()))
			{
				
					query.append(" AND TECH_TYPE = ");
					query.append("'" + cdrdetailsKey.getTechType() + "'");
				
			}
			else {
				query.append(" AND TECH_TYPE IS NULL ");
			}
			if(cdrdetailsKey.getTLOObjectID() !=null && !("").equals(cdrdetailsKey.getTLOObjectID()))
			{
				
					query.append(" AND TOMS_TLO_ID = ");
					query.append("'" + cdrdetailsKey.getTLOObjectID() + "'");
				
			}
			if(cdrdetailsKey.getBillingTariffName() !=null && !("").equals(cdrdetailsKey.getBillingTariffName()))
			{
				
					query.append(" AND BILLING_TARIFF_NAME = ");
					query.append("'" + cdrdetailsKey.getBillingTariffName() + "'");
				
			}
		
		}
		else
		{	//Issue fix - TMOGENESIS-38842
			if (eventSeqStr != null) {
			query.append(eventSeqStr +")");
			}
			else
			{
				query.append(seqNum+")");
			}
			
		}
		
		traceLog.traceFinest("query executed with in buildCDRDataOutputQuery: " + query.toString());
		//Apply the Filter parameters
		query = util.buildFilterQuery(filterArray, query);

		totalCount = util.getTotalRowCount(query.toString());
		query= util.buildSortingQuery(sortArray, query);
		query = util.buildPaginationQuery(pagination, query);
		traceLog.traceFinest("End of the buildCDRDataOutputQuery : " + query.toString());

		return query.toString();
	}
}
