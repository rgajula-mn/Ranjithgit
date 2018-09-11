package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.DateUtil;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.Event;
import com.convergys.custom.geneva.j2ee.util.HashMapPlus;
import com.convergys.custom.geneva.j2ee.util.IntervalMapping;
import com.convergys.custom.geneva.j2ee.util.IrbClientParam;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.custom.geneva.j2ee.util.IntervalMapping.Pair;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class QueryCDRDetailsDao {
	private static TraceLog traceLog = new TraceLog(QueryCDRDetailsDao.class);
	private Util util;

	
	public QueryCDRDetailsDao() {
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}
	
	/**
	 * @param integratorContext
	 * @param customerReference
	 * @param eventSource
	 * @param eventType
	 * @param startDtm
	 * @param endDtmNbl
	 * @return CRDDetailsResult[]
	 * 
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * 
	 *  @author sgad2315
	 */
	public CDRDetailsResult[] queryCDRDetails(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String customerRef, java.lang.String eventSource,
			java.lang.String eventType, long startDtmInput, long endDtmNblInput)
			throws com.convergys.iml.commonIML.NullParameterException,
			com.convergys.iml.commonIML.ParameterException,
			com.convergys.platform.ApplicationException {
	    
        long startTime = Null.LONG;
        long endTime = Null.LONG;
        long diff = Null.LONG;
        String node = null;
        String diffStr = null;
        node = util.getHostName();
        startTime=System.currentTimeMillis();
        
        if (traceLog.isFinerEnabled()) {
            traceLog.traceFiner("Entered into queryCDRDetails API...startTime.. "+startTime);
        }
	    
	    
		traceLog.traceFinest("Entered into queryCDRDetails API");

        //Array of the CDR records data
        CDRDetailsResult[] cdrDetailsResultArray = null;
        DataSource das = null;
		Date startDate = null;
		Date endDate = null;
		String responseStatus = null;
        String DATE_MASK = "yyyyMMdd";
        String DATETIME_MASK = "yyyyMMddHHmmss";
        
        QueryCDRDetailsOutput queryCDRDetailsOutput = new QueryCDRDetailsOutput();
        QueryCDRDetailsInput queryCDRDetailsInput = new QueryCDRDetailsInput();
        queryCDRDetailsInput.setIntegratorContext(integratorContext);
        queryCDRDetailsInput.setEventSource(eventSource);
        queryCDRDetailsInput.setCustomerReference(customerRef);
        

        try {
            traceLog.traceFinest("Entered into queryCDRDetails API");

            if (integratorContext == null || integratorContext.equals("")) {
                throw new NullParameterException(ErrorCodes.ERR_RBM_1001,
                        Constants.QUERY_CDR_DETAILS_API_NAME);
            }
            if (integratorContext.getExternalBusinessTransactionId() == null
                    || integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
                throw new NullParameterException(ErrorCodes.ERR_RBM_1002,
                        Constants.QUERY_CDR_DETAILS_API_NAME);
            }

            if (customerRef == null || customerRef.trim().equals("")) {
                throw new NullParameterException(ErrorCodes.ERR_RBM_6001,
                        Constants.QUERY_CDR_DETAILS_API_NAME);
            }
            if (eventSource == null || eventSource.trim().equals("")) {
                throw new NullParameterException(ErrorCodes.ERR_RBM_6002,
                        Constants.QUERY_CDR_DETAILS_API_NAME);
            }
			if (startDtmInput < 0) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_6003,
						Constants.QUERY_CDR_DETAILS_API_NAME);
			} else {
				startDate = new Date(startDtmInput);
			}
			if (endDtmNblInput > 0) {
				endDate = new Date(endDtmNblInput);
			}
			
			das = util.getDataSource();

			
			List<CDRDetailsResult> eventList = new LinkedList<CDRDetailsResult>();
			
            if (eventType != null && eventType.length() > 0) {
                traceLog.traceFinest("Executing getEventTypeIds");
                String eventTypeIds = getEventTypeIds(eventType);
                traceLog.traceFinest("Printing the eventTypeIds: "+ eventTypeIds);
                
                String startRange = (startDate != null)
                        ? DateUtil.getDateTime(DATE_MASK, startDate) + "000000"
                        : DateUtil.getDateTime(DATE_MASK, DateUtil.getDateFromToday(0));
                String endRange = (endDate != null) ? DateUtil.getDateTime(DATE_MASK, endDate) + "235959"
                        : DateUtil.getDateTime(DATE_MASK, DateUtil.getDateFromToday(0));
                
                traceLog.traceFinest("Printing the startRange: "+ startRange);
                traceLog.traceFinest("Printing the endRange: "+ endRange);
                
                traceLog.traceFinest("In the IF BLOCK Executing getUsageEventsByEventType");
                    eventList.addAll(getUsageEventsByEventType(customerRef, eventSource,
                            eventTypeIds, startRange, endRange));
            }
            else {
                traceLog.traceFinest("In the ELSE BLOCK Executing getUsageEventsByEventSource");
                    eventList.addAll(getUsageEventsByEventSource(customerRef,
                    		eventSource, DateUtil.getDateTime(DATETIME_MASK, startDate)));
            }
            if (eventList.size() > 0) {
                responseStatus = Constants.TRANSACTION_SUCCESS;
            }else{
                responseStatus = Constants.TRANSACTION_SUCCESS;;
            }
            cdrDetailsResultArray = eventList.toArray(new CDRDetailsResult[eventList.size()]);
            
            endTime = System.currentTimeMillis();
            
            if (traceLog.isFinerEnabled())
                traceLog.traceFinest("End time after queryCDRDetails.. "+endTime);
            
            diff = endTime-startTime;
            diffStr = String.valueOf(diff);
                
            if (traceLog.isFinerEnabled())
                traceLog.traceFinest("Time taken for the execution of queryCDRDetails is "+diff+"........."+diffStr);
            
            
        } catch (Exception ex) {
            responseStatus = ex.getMessage();
            traceLog.traceFinest("Exception from  queryCDRDetails API : " + ex.getMessage());
            BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, eventSource,
                    queryCDRDetailsInput, queryCDRDetailsOutput,
                    responseStatus, Constants.QUERY_CDR_DETAILS_API_NAME, das, diffStr, node);
            throw new ApplicationException(ErrorCodes.ERR_RBM_6004 + ex.toString());
        }
        traceLog.traceFinest("End of queryCDRDetails API");
        traceLog.traceFinest("End BillingProfileDao queryCDRDetails API");
        
        BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, eventSource,
                queryCDRDetailsInput, queryCDRDetailsOutput,
                responseStatus, Constants.QUERY_CDR_DETAILS_API_NAME, das, diffStr, node);
        return cdrDetailsResultArray;

    
	}
	private String getEventTypeIds(String eventType) {
        traceLog.traceFinest("In getEventTypeIds: "+ eventType);
        String ids = "";
    
        //TODO The below is in the WSCP but the ids are getting overriden below so its no use to include in the code
        /*
         if (eventType != null) {
            ids = PropertiesUtil.get("usageLabelEventTypes." + eventType.toUpperCase());
            log.debug("Showing event types:" + ids);
        }*/
        
        // the logic below is used for fallback if there is no label to event
        // type mapping configured
        StringBuilder idsBuffer = new StringBuilder("");
        for (Map.Entry<String, String> entry : getAllEventTypes().entrySet()) {
            if (entry.getValue().contains(eventType)) {
                if (idsBuffer.length() > 0) {
                    idsBuffer.append(",");
                }
                idsBuffer.append(entry.getKey());
            }
        }
        ids = idsBuffer.toString();
        traceLog.traceFinest("In getEventTypeIds retrieved the ids: "+ ids);
        return ids;
    }
	private List<CDRDetailsResult> getUsageEventsByEventType(String customerRef, String eventSource, 
			String eventTypes, String startDate, String endDate) throws Exception {
		
        List<CDRDetailsResult> cdrDetailsResults = null;
		traceLog.traceFinest("Entered getUsageEventsByEventType with customerRef: " + customerRef 
				+ " eventSource: " + eventSource + " eventTypes: "+ 	eventTypes 
				+ " startDate: "+ startDate+ " endDate: "+ endDate);
		
        String sqlacc = "SELECT rating_acct_nbr, cust_type FROM tmobile_custom.tmo_acct_mapping "
                + "WHERE rating_cust_ref = ? ";
        HashMapPlus mapAcc = executeQueryForItem(sqlacc, new IrbClientParam[] { new IrbClientParam(
                1, customerRef, Types.VARCHAR), }, null);
		traceLog.traceFinest("Execuuting sqlacc : " + sqlacc);
		
        String accountNum = "";
        String customerType = "";

        if (mapAcc != null) {
            accountNum = mapAcc.getString("RATING_ACCT_NBR");
            customerType = mapAcc.getString("CUST_TYPE");
        } else {
            throw new RuntimeException("Account not found for the given Customer");
        }

        traceLog.traceFinest("Printing the value of  accountNum : " + accountNum);
        traceLog.traceFinest("Printing the value of  customerType : " + customerType);

		String rdSql = "SELECT aec.ACCOUNT_NUM, EVENT_TYPE_ID, RATING_TARIFF_ID, START_DAT, MINOR_CURRENCY_UNITS "
					+ " FROM tmobile_custom.TMO_ACC_EVENTS_OV_CURRENCY aec JOIN ACCOUNT ac "
					+ " ON aec.ACCOUNT_NUM = ac.ACCOUNT_NUM WHERE CUSTOMER_REF = ? "
					+ " ORDER BY EVENT_TYPE_ID, RATING_TARIFF_ID, START_DAT ";

		traceLog.traceFinest("Execuuting rdSql : " + rdSql);
			
		Map<String, Map<java.util.Date, Double>> currencyConfig = new HashMap<String, Map<java.util.Date, Double>>();
		List<HashMapPlus> currencies = util.executeQueryForList(rdSql, new IrbClientParam[] { new IrbClientParam(1,
	                customerRef, Types.VARCHAR) }, null);
		 
		 Map<java.util.Date, Double> ranges = null;
	        String key = "";
	        for (HashMapPlus map : currencies) {
	            if (key.compareTo(map.getInt("EVENT_TYPE_ID") + "|" + map.getInt("RATING_TARIFF_ID")) != 0) {
	                key = map.getInt("EVENT_TYPE_ID") + "|" + map.getInt("RATING_TARIFF_ID");
	                ranges = new LinkedHashMap<java.util.Date, Double>();
	                currencyConfig.put(key, ranges);
	            }
	            ranges.put(map.getDate("START_DAT"), Math.pow(10, map.getLong("MINOR_CURRENCY_UNITS")));
	        }
	        
			traceLog.traceFinest("Printing the ranges: " + ranges);
			traceLog.traceFinest("Printing the currencyConfig: " + currencyConfig);
			traceLog.traceFinest("Printing the currencies: " + currencies);
			
			/*String sql = "SELECT * "
			        + "FROM (SELECT CE.* "
			        + "FROM geneva_admin.costedevent0 CE "
			         + "WHERE CE.ACCOUNT_NUM = 'ACC000004' "
			           + "AND CE.EVENT_SEQ IN "
			               + "(SELECT DISTINCT EVENT_SEQ "
			                  + "FROM ACCOUNTRATINGSUMMARY "
			                 + "WHERE ACCOUNT_NUM = 'ACC000004' "
			                   + "AND LATEST_RATED_EVENT_DTM >= "
			                       + "TO_DATE('20131003115959', 'yyyymmddHH24MISS') - 15 " 
			                   + "AND LATEST_RATED_EVENT_DTM <= "
			                       + "TO_DATE('20131103115959', 'yyyymmddHH24MISS')) "
			           + "AND EVENT_DTM >= TO_DATE('20131003115959', 'yyyymmddHH24MISS') - 15 "
			           + "AND EVENT_DTM <= TO_DATE('20131103115959', 'yyyymmddHH24MISS') "
			           + "AND CE.EVENT_SOURCE = '4045782855' "
			           + "AND EVENT_TYPE_ID IN (1, 2, 3, 4, 20, 21, 28) "
			         + "ORDER BY EVENT_DTM) "
			 + "WHERE ROWNUM < 1000 ";
			 
			List<HashMapPlus> list = executeQueryForList(sql, null, null);*/
			
			StringBuilder sql = new StringBuilder("SELECT * FROM ( SELECT CE.* "
	                + "FROM geneva_admin.costedevent0 CE WHERE CE.ACCOUNT_NUM = ? "
	                + "AND CE.EVENT_SEQ IN (SELECT DISTINCT EVENT_SEQ FROM ACCOUNTRATINGSUMMARY "
	                + "WHERE ACCOUNT_NUM = ? AND LATEST_RATED_EVENT_DTM >= TO_DATE (?, 'yyyymmddHH24MISS') -15 "
	                + "AND LATEST_RATED_EVENT_DTM <= TO_DATE (?,'yyyymmddHH24MISS') ) "
	                + "AND EVENT_DTM >= TO_DATE(? ,'yyyymmddHH24MISS')-15 "
	                + "AND EVENT_DTM <= TO_DATE(? ,'yyyymmddHH24MISS') "
	                + "AND CE.EVENT_SOURCE = ? AND EVENT_TYPE_ID IN (");

			traceLog.traceFinest("Execuuting the  Sql: "+ sql);
			
			String startRange = (startDate == null) ? DateUtil.getTodayAsString() : startDate;
			traceLog.traceFinest("Printing the value startRange : " + startRange);
			
			String endRange = (endDate == null) ? DateUtil.getTodayAsString() : endDate;
			traceLog.traceFinest("Printing the value endRange : " + endRange);
			
			String[] eventTypeArray = eventTypes.split(",");
			IrbClientParam[] paramArray = new IrbClientParam[eventTypeArray.length + 7];

			paramArray[0] = new IrbClientParam(1, accountNum, Types.VARCHAR);
			paramArray[1] = new IrbClientParam(2, accountNum, Types.VARCHAR);
			paramArray[2] = new IrbClientParam(3, startRange, Types.VARCHAR);
			paramArray[3] = new IrbClientParam(4, endRange, Types.VARCHAR);
			paramArray[4] = new IrbClientParam(5, startRange, Types.VARCHAR);
			paramArray[5] = new IrbClientParam(6, endRange, Types.VARCHAR);
			paramArray[6] = new IrbClientParam(7, eventSource, Types.VARCHAR);

			int i = 0;
			do {
				sql.append("?");
				paramArray[i + 7] = new IrbClientParam(i + 8, eventTypeArray[i], Types.VARCHAR);
				if (i < eventTypeArray.length - 1) {
					sql.append(",");
				}
			} while (++i < eventTypeArray.length);
			sql.append(") ORDER BY EVENT_DTM ) WHERE ROWNUM < 1000");

			//traceLog.traceFinest("sql: " + sql);
			traceLog.traceFinest("Execuuting Second Segment of Sql: "+ sql);
			for (IrbClientParam x : paramArray) {
				traceLog.traceFinest("Printing the param values: " + x.getValue());
			}

			List<HashMapPlus> list = util.executeQueryForList(sql.toString(), paramArray, null);
			List<CDRDetailsResult> crdDetailsResults2 = new ArrayList<CDRDetailsResult>(0);

			if (list.size() == 0) {
				traceLog.traceFinest("NO EVENTS FOUND ");
				return crdDetailsResults2;
			} else {
				traceLog.traceFinest("EVENTS FOUND Hence the FLOW continutes to the next block");
			}

        String sql2 = "SELECT EVENT_TYPE, DUF_FILENAME, EVENT_SEQ, "
                + "       FIRST_EVENT_CREATED_DTM, LAST_EVENT_CREATED_DTM"
                + "  FROM TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS WHERE ACCOUNT_NUM = ? "
                + "    AND LAST_EVENT_CREATED_DTM <= sysdate "
                + " ORDER BY FIRST_EVENT_CREATED_DTM";
        
        List<HashMapPlus> list1 = util.executeQueryForList(sql2, new IrbClientParam[] { new IrbClientParam(1,
                accountNum, Types.VARCHAR) }, null);

        IntervalMapping intervalMappingVoice = new IntervalMapping();
        IntervalMapping intervalMappingData = new IntervalMapping();

        traceLog.traceFinest("Execuuting the  sql2: " + sql2);
        traceLog.traceFinest("Printing the param: " + startDate + " " + endDate);

        for (HashMapPlus dufMap : list1) {
            String eventType = dufMap.getString("EVENT_TYPE");

            traceLog.traceFinest("In getUsageEventsByEventType FILENAME:" + dufMap.getString("DUF_FILENAME") + " type:"
                    + eventType + " seq:" + dufMap.getString("EVENT_SEQ"));

            if (eventType.contains("VOICE")) {
                traceLog.traceFinest("In the IF Block of VOICE");
                intervalMappingVoice.put(dufMap.getString("EVENT_SEQ"), dufMap.getDate("FIRST_EVENT_CREATED_DTM"),
                        dufMap.getDate("LAST_EVENT_CREATED_DTM"), dufMap.getString("DUF_FILENAME"));
            } else {
                traceLog.traceFinest("In the ELSE Block of eventType ");
                intervalMappingData.put(dufMap.getString("EVENT_SEQ"), dufMap.getDate("FIRST_EVENT_CREATED_DTM"),
                        dufMap.getDate("LAST_EVENT_CREATED_DTM"), dufMap.getString("DUF_FILENAME"));
            }
        }
        traceLog.traceFinest("In getUsageEventsByEventType Calling processEvents " );
        List<Event> events = processEvents(list, customerRef, customerType, eventSource, currencyConfig, intervalMappingVoice,
                intervalMappingData);
        
        traceLog.traceFinest("In getUsageEventsByEventSource Calling populateCRDDetails" );
        cdrDetailsResults = populateCDRDetails(events);
        
        return cdrDetailsResults;
	}
    private List<CDRDetailsResult> getUsageEventsByEventSource(String customerRef, String eventSource, String startDate) throws Exception {

        List<CDRDetailsResult> crdDetailsResults = null;
        
        String sql = "SELECT rating_acct_nbr, cust_type FROM tmobile_custom.tmo_acct_mapping "
                + "WHERE rating_cust_ref = ? ";
        HashMapPlus mapAcc = executeQueryForItem(sql, new IrbClientParam[] { new IrbClientParam(1, customerRef,
                Types.VARCHAR), }, null);

        String accountNum = "";
        String customerType = "";

        if (mapAcc != null) {
            accountNum = mapAcc.getString("RATING_ACCT_NBR");
            customerType = mapAcc.getString("CUST_TYPE");
            traceLog.traceFinest("In getUsageEventsByEventSource Printing the accountNum: " + accountNum);
            traceLog.traceFinest("In getUsageEventsByEventSourcePrinting the customerType: " + customerType);
            
        } else {
            throw new RuntimeException("Account not found for the given Customer");
        }

        String rdSql = "SELECT aec.account_num, event_type_id, rating_tariff_id, start_dat, minor_currency_units "
                + " FROM tmobile_custom.tmo_acc_events_ov_currency aec JOIN account ac "
                + " ON aec.account_num = ac.account_num WHERE customer_ref = ? "
                + " ORDER BY event_type_id, rating_tariff_id, start_dat ";

        Map<String, Map<java.util.Date, Double>> currencyConfig = new HashMap<String, Map<java.util.Date, Double>>();

        List<HashMapPlus> currencies = util.executeQueryForList(rdSql, new IrbClientParam[] { new IrbClientParam(1,
                customerRef, Types.VARCHAR) }, null);

        Map<java.util.Date, Double> ranges = null;
        String key = "";
        for (HashMapPlus map : currencies) {
            if (key.compareTo(map.getInt("EVENT_TYPE_ID") + "|" + map.getInt("RATING_TARIFF_ID")) != 0) {
                key = map.getInt("EVENT_TYPE_ID") + "|" + map.getInt("RATING_TARIFF_ID");
                ranges = new LinkedHashMap<java.util.Date, Double>();
                currencyConfig.put(key, ranges);
            }
            ranges.put(map.getDate("START_DAT"), Math.pow(10, map.getLong("MINOR_CURRENCY_UNITS")));
        }

        /*sql = "SELECT * " + "FROM (SELECT CE.* " + "FROM geneva_admin.costedevent0 CE "
        + "WHERE CE.EVENT_SOURCE = '3172219566' " + "AND CE.ACCOUNT_NUM = 'ACC000004' "
        + "AND EVENT_SEQ IN " + "(SELECT DISTINCT EVENT_SEQ "
        + "FROM ACCOUNTRATINGSUMMARY " + "WHERE ACCOUNT_NUM = 'ACC000004' "
        + "AND LATEST_RATED_EVENT_DTM <= "
        + "TO_DATE('20130202123543', 'yyyymmddHH24MISS') + 15 + 7 "
        + "AND LATEST_RATED_EVENT_DTM >= "
        + "TO_DATE('20130202123543', 'yyyymmddHH24MISS')) "
        + "AND EVENT_DTM < TO_DATE('20130106093736', 'yyyymmddHH24MISS') + 15 + 7 "
        + "AND EVENT_DTM >= TO_DATE('20130106093736', 'yyyymmddHH24MISS') "
        + "ORDER BY EVENT_DTM) " + "WHERE ROWNUM < 1000 ";*/
        //List<HashMapPlus> list = executeQueryForList(sql, null, null);
        // + "OFFSET 10 ROWS FETCH NEXT 20 ROWS ONLY";

        sql = "SELECT * FROM ( SELECT CE.* FROM geneva_admin.costedevent0 CE "
                + "WHERE CE.EVENT_SOURCE = ? AND CE.ACCOUNT_NUM = ? "
                + "AND EVENT_SEQ IN ( SELECT DISTINCT EVENT_SEQ "
                + "FROM ACCOUNTRATINGSUMMARY WHERE ACCOUNT_NUM = ? "
                + "AND LATEST_RATED_EVENT_DTM <= TO_DATE(?, 'yyyymmddHH24MISS') + 15 + ? "
                + "AND LATEST_RATED_EVENT_DTM >= TO_DATE(?, 'yyyymmddHH24MISS') )"
                + "AND EVENT_DTM <  TO_DATE(?, 'yyyymmddHH24MISS')+ 15 + ? "
                + "AND EVENT_DTM >= TO_DATE(?, 'yyyymmddHH24MISS') "
                + "ORDER BY EVENT_DTM ) WHERE ROWNUM < 1000";
        
        traceLog.traceFinest("Printing the sql in getUsageEventsByEventSource " + sql);
        traceLog.traceFinest("getUsageEventsByEventSource Printing params " + eventSource + "|"
                + accountNum + "|" + startDate + "|" + 7);

        List<HashMapPlus> list = util.executeQueryForList(sql, new IrbClientParam[] {
                new IrbClientParam(1, eventSource, Types.VARCHAR),
                new IrbClientParam(2, accountNum, Types.VARCHAR),
                new IrbClientParam(3, accountNum, Types.VARCHAR),
                new IrbClientParam(4, startDate, Types.VARCHAR),
                new IrbClientParam(5, 7, Types.DECIMAL),
                new IrbClientParam(6, startDate, Types.VARCHAR),
                new IrbClientParam(7, startDate, Types.VARCHAR),
                new IrbClientParam(8, 7, Types.DECIMAL),
                new IrbClientParam(9, startDate, Types.VARCHAR) }, null);
        
        List<Event> events = new ArrayList<Event>(0);
        List<CDRDetailsResult> crdDetailsResults2 = new ArrayList<CDRDetailsResult>(0);

        if (list.size() == 0) {
            traceLog.traceFinest("NO EVENTS FOUND ");
            return crdDetailsResults2;
        } else {
            traceLog.traceFinest("EVENTS FOUND Hence the FLOW continutes to the next block");
        }

        String sql2 = "SELECT EVENT_TYPE, DUF_FILENAME, EVENT_SEQ, "
                + "       FIRST_EVENT_CREATED_DTM, LAST_EVENT_CREATED_DTM"
                + "  FROM TMOBILE_CUSTOM.TMO_DUF_CDR_DETAILS WHERE ACCOUNT_NUM = ?"
                + "   AND FIRST_EVENT_CREATED_DTM <= sysdate "
                + " ORDER BY FIRST_EVENT_CREATED_DTM";

        traceLog.traceFinest("Printing the sql2: " + sql2);
        traceLog.traceFinest("Printing the param startDate : " + startDate);

        List<HashMapPlus> list1 = util.executeQueryForList(sql2, new IrbClientParam[] { new IrbClientParam(1,
                accountNum, Types.VARCHAR) }, null);

        IntervalMapping intervalMappingVoice = new IntervalMapping();
        IntervalMapping intervalMappingData = new IntervalMapping();

        for (HashMapPlus dufMap : list1) {
            String eventType = dufMap.getString("EVENT_TYPE");

            traceLog.traceFinest("In getUsageEventsByEventType FILENAME:" + dufMap.getString("DUF_FILENAME") + " type:"
                    + eventType + " seq:" + dufMap.getString("EVENT_SEQ"));
            if ("Voice".equalsIgnoreCase(eventType)) {
                
                traceLog.traceFinest("In the IF Block of VOICE");
                intervalMappingVoice.put(dufMap.getString("EVENT_SEQ"), dufMap.getDate("FIRST_EVENT_CREATED_DTM"),
                        dufMap.getDate("LAST_EVENT_CREATED_DTM"), dufMap.getString("DUF_FILENAME"));
            } else if ("DATA".equalsIgnoreCase(eventType)) {
                
                traceLog.traceFinest("In the ELSE Block of DATA");
                intervalMappingData.put(dufMap.getString("EVENT_SEQ"), dufMap.getDate("FIRST_EVENT_CREATED_DTM"),
                        dufMap.getDate("LAST_EVENT_CREATED_DTM"), dufMap.getString("DUF_FILENAME"));
            }
        }
        
        traceLog.traceFinest("In getUsageEventsByEventSource Calling processEvents" );
        events = processEvents(list, customerRef, customerType, eventSource, currencyConfig, intervalMappingVoice,
                intervalMappingData);
        
        traceLog.traceFinest("In getUsageEventsByEventSource Calling populateCRDDetails" );
        crdDetailsResults = populateCDRDetails(events);
        
        return crdDetailsResults;
    }
    private Map<String, String> getAllEventTypes() {
        traceLog.traceFinest("Executing getAllEventTypes");
        Map<String, String> eventTypeMap = new TreeMap<String, String>();
        try {
            eventTypeMap = getAllEventTypesInternal();
        } catch (Exception e) {
            traceLog.traceFinest("getAllEventTypes failed..." + e.toString());
        }
        traceLog.traceFinest("Executed getAllEventTypes");
        return eventTypeMap;
    }
    
    /**
     * Retrieves single item using select sql. Also populates column headers. If not found, null
     * will be returned. Value will be keyed by upper case of column name.
     * 
     * @param sql
     * @param params
     * @param columnHeaders
     * @return HashMapPlus
     * 
     * @throws Exception 
     */
    private HashMapPlus executeQueryForItem(final String sql, final IrbClientParam[] params,
            final List<String> columnHeaders) throws Exception {

        traceLog.traceFinest("START executeQueryForItem printing the SQL: " + sql);
        if (sql == null || !sql.toUpperCase().startsWith("SELECT")) {
            throw new RuntimeException("SQL is null or not start with SELECT clause :" + sql);
        }

        HashMapPlus item = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = util.getDataSource().getConnection();
            pstmt = conn.prepareStatement(sql);
            // pstmt.setQueryTimeout(60);

            if (params != null) {
                for (int i = 0; i < params.length; ++i) {
                    util.setParam(pstmt, params[i]);
                }
            }
            rs = pstmt.executeQuery();

            if (columnHeaders != null) {
                columnHeaders.addAll(util.getColumnHeaders(rs));
            }

            if (rs.next()) {
                item = util.getResultMap(rs);
            }

        } catch (SQLException e) {
            throw new Exception(sql, e);
        } finally {
            util.closeResources(rs, conn, pstmt, null);
        }
        //traceLog.traceFinest("END executeQueryForItem printing the item: " + item);
        return item;
    }

    private List<CDRDetailsResult> populateCDRDetails(List<Event> events) {

        traceLog.traceFinest("In the populateCRDDetails Method");
        
        List<CDRDetailsResult> cdrDetailsResults = new ArrayList<CDRDetailsResult>();
        
        
        for (Event event1 : events) {
            traceLog.traceFinest("Printing the event1 one by one : " + event1);
            
            CDRDetailsResult cdrDetailsResult = new CDRDetailsResult();
            CDRVoiceSMSDetails cdrVoiceSMSDetails = null;
            CDRGPRSMMSdetails  cdrGprsMMSDetails = null;
            
            String _eventType = (String) event1.getAttributeByName("NAME");
            traceLog.traceFinest("EventType NAME : " + _eventType);
            
            String dufFileNameValue = (String) event1.getAttributeByName("DUFFILENAME");
            traceLog.traceFinest("dufFileNameValue : " + dufFileNameValue);
            
            String _recordType = (String) event1.getAttributeByName("RECORDTYPE");
            traceLog.traceFinest("recordType : " + _recordType);
            
            String _accountNum = (String) event1.getAttributeByName("ACCOUNTNUMBER");
            traceLog.traceFinest("ACCOUNTNUMBER : " + _accountNum);
            
            String _sequenceNumber = (String) event1.getAttributeByName("SEQUENCENUMBER");
            traceLog.traceFinest("SEQUENCENUMBER : " + _sequenceNumber);
            
            String _imsi = (String) event1.getAttributeByName("IMSI");
            traceLog.traceFinest("IMSI : " + _imsi);
            
            String _msisdn = (String) event1.getAttributeByName("MSISDN");
            traceLog.traceFinest("MSISDN : " + _msisdn);
            
            String _imei = (String) event1.getAttributeByName("IMEI");
            traceLog.traceFinest("IMEI : " + _imei);
            
            String _homeSID = (String) event1.getAttributeByName("HOMESID");
            traceLog.traceFinest("HOMESID : " + _homeSID);
            
            String _serveSID = (String) event1.getAttributeByName("SERVESID");
            traceLog.traceFinest("SERVESID : " + _serveSID);
            
            String _cellIdentity = (String) event1.getAttributeByName("CELLIDENTITY");
            traceLog.traceFinest("CELLIDENTITY  : " + _cellIdentity);
            
            String _incomingTrunkID = (String) event1.getAttributeByName("INCOMINGTRUNKID");
            traceLog.traceFinest("Incoming Trunk ID INCOMINGTRUNKID : " + _incomingTrunkID);
            
            String _onNetwork = (String) event1.getAttributeByName("ONNETWORKFLAG");
            traceLog.traceFinest("ONNETWORKFLAG : " + _onNetwork);
            
            String _plmnCode = (String) event1.getAttributeByName("PLMNCODE");
            traceLog.traceFinest("PLMNCODE : " + _plmnCode);
           
            String _countryName = (String) event1.getAttributeByName("COUNTRYNAME");
            traceLog.traceFinest("COUNTRYNAME : " + _countryName);
            
            String _technologyUsed = (String) event1.getAttributeByName("TECHNOLOGYUSED");
            traceLog.traceFinest("TECHNOLOGYUSED : " + _technologyUsed);
            
            String _packageName = (String) event1.getAttributeByName("PACKAGENAME");
            traceLog.traceFinest("PACKAGENAME : " + _packageName);
            
            String _billDate = (String) event1.getAttributeByName("BILLDATE");
            traceLog.traceFinest("BILLDATE : " + _billDate);
            
            if (_eventType.contains("VOICE") || _eventType.contains("SMS")) {
                
                traceLog.traceFinest("In the populateCRDDetails VOICE and SMS ");
                
                cdrVoiceSMSDetails = new CDRVoiceSMSDetails();
                cdrVoiceSMSDetails.setEventType(_eventType);
                cdrVoiceSMSDetails.setDUFFile(dufFileNameValue);
                
                if (_recordType != null && _recordType != "") {
                    cdrVoiceSMSDetails.setRecordType(Integer.valueOf(_recordType));
                } else {
                    cdrVoiceSMSDetails.setRecordType(0);
                }
                cdrVoiceSMSDetails.setAccountNum(_accountNum);
                
                if (_sequenceNumber != null && _sequenceNumber != "") {
                    cdrVoiceSMSDetails.setSequenceNumber(Integer.valueOf(_sequenceNumber));;
                } else {
                    cdrVoiceSMSDetails.setSequenceNumber(0);
                }
                
                cdrVoiceSMSDetails.setIMSI(_imsi);
                cdrVoiceSMSDetails.setMSISDN(_msisdn);
                
                
                //String _channelSeizureDateNbl = (String) event1.getAttributeByName("CHANNELSEIZUREDT");
                String _channelSeizureDate = (String) event1.getAttributeByName("TIME");
                traceLog.traceFinest("CHANNELSEIZUREDT : " + _channelSeizureDate);
                if (_channelSeizureDate != null && _channelSeizureDate != "") {
                    cdrVoiceSMSDetails.setChannelSeizureDate(_channelSeizureDate);
                } else {
                    cdrVoiceSMSDetails.setChannelSeizureDate("");
                }
                
                String _switchId = (String) event1.getAttributeByName("SWITCHID");
                traceLog.traceFinest("SWITCHID : " + _switchId);

                cdrVoiceSMSDetails.setSwitchId(_switchId);
                cdrVoiceSMSDetails.setIMEI(_imei);
                cdrVoiceSMSDetails.setHomeSID(_homeSID);
                cdrVoiceSMSDetails.setServeSID(_serveSID);
                cdrVoiceSMSDetails.setCellIdentity(_cellIdentity);
                
                
                String _callToTelephoneNumber = (String) event1.getAttributeByName("CALLTOTN");
                traceLog.traceFinest("Call to telephone number : " + _callToTelephoneNumber);
                cdrVoiceSMSDetails.setCallToTelephoneNumber(_callToTelephoneNumber);
                
                String _callToPlace = (String) event1.getAttributeByName("CALLTOPLACE");
                traceLog.traceFinest("CALLTOPLACE : " + _callToPlace);
                cdrVoiceSMSDetails.setCallToPlace(_callToPlace);
                
                String _callToRegion = (String) event1.getAttributeByName("CALLTOREGION");
                traceLog.traceFinest("CALLTOREGION : " + _callToRegion);
                cdrVoiceSMSDetails.setCallToRegion(_callToRegion);
                
                String _outgoingCellTrunkID = (String) event1.getAttributeByName("OUTGOINGCELLTRUNKID");
                traceLog.traceFinest("Outgoing Cell Trunk ID OUTGOINGCELLTRUNKID : " + _outgoingCellTrunkID);
                cdrVoiceSMSDetails.setOutgoingCellTrunkID(_outgoingCellTrunkID);
                
                cdrVoiceSMSDetails.setIncomingTrunkID(_incomingTrunkID);
                
                Object _answerTimeDurationMin = event1.getAttributeByName("ANSWERTIMEDURROUNDMIN");
                traceLog.traceFinest("Answer Time Duration (rounded to minutes) ANSWERTIMEDURROUNDMIN : "
                        + _answerTimeDurationMin);
                
                if (_answerTimeDurationMin != null && _answerTimeDurationMin != "") {
                    cdrVoiceSMSDetails.setAnswerTimeDurationMin(String.valueOf(_answerTimeDurationMin));
                } else {
                    cdrVoiceSMSDetails.setAnswerTimeDurationMin("");
                }
                
                Object _answerTimeDurationSec =  event1.getAttributeByName("ANSWERTIMECALLDURSEC");
                traceLog.traceFinest("Answer Time Duration (in seconds) ANSWERTIMECALLDURSEC : " + _answerTimeDurationSec);
                
                if (_answerTimeDurationSec != null && _answerTimeDurationSec != "") {
                    cdrVoiceSMSDetails.setAnswerTimeDurationSec(String.valueOf(_answerTimeDurationMin));
                } else {
                    cdrVoiceSMSDetails.setAnswerTimeDurationSec("");
                }
                
                String _airRate = (String) event1.getAttributeByName("AIRTIME");
                traceLog.traceFinest("AIRRATE : " + _airRate);
                cdrVoiceSMSDetails.setAirRate(_airRate);
                
                String _airChargeAmount = (String) event1.getAttributeByName("AIRCHARGEAMOUNT");
                traceLog.traceFinest("AIRCHARGEAMOUNT : " + _airChargeAmount);
                cdrVoiceSMSDetails.setAirChargeAmount(_airChargeAmount);
                
                
                String _airChargeCode = (String) event1.getAttributeByName("AIRCHARGECODE");
                traceLog.traceFinest("AIRCHARGECODE : " + _airChargeCode);
                if (_airChargeCode != null && _airChargeCode != "") {
                    cdrVoiceSMSDetails.setAirChargeCode(Integer.valueOf(_airChargeCode));
                } else {
                    cdrVoiceSMSDetails.setAirChargeCode(0);
                }
                
                String _tollRate = (String) event1.getAttributeByName("TOLLRATE");
                traceLog.traceFinest("TOLLRATE : " + _tollRate);
                cdrVoiceSMSDetails.setTollRate(_tollRate);
                
                String _tollChargeAmount = (String) event1.getAttributeByName("TOLLCHARGEAMOUNT");
                traceLog.traceFinest("TOLLCHARGEAMOUNT : " + _tollChargeAmount);
                cdrVoiceSMSDetails.setTollChargeAmount(_tollChargeAmount);
                                        
                String _tollChargeCodeNbl = (String) event1.getAttributeByName("TOLLCHARGECODE");
                traceLog.traceFinest("TOLLCHARGECODE : " + _tollChargeCodeNbl);
                if (_tollChargeCodeNbl != null && _tollChargeCodeNbl != "") {
                    cdrVoiceSMSDetails.setTollChargeCodeNbl(Integer.valueOf(_tollChargeCodeNbl));
                } else {
                    cdrVoiceSMSDetails.setTollChargeCodeNbl(0);
                }
                
                cdrVoiceSMSDetails.setOnNetwork(_onNetwork);

                String _callDirection = (String) event1.getAttributeByName("CALLDIRECTION");
                traceLog.traceFinest("CALLDIRECTION : " + _callDirection);
                cdrVoiceSMSDetails.setCallDirection(_callDirection);
                
                String _translatedNumber = (String) event1.getAttributeByName("TRANSLATEDNUMBER");
                traceLog.traceFinest("TRANSLATEDNUMBER : " + _translatedNumber);
                cdrVoiceSMSDetails.setTranslatedNumber(_translatedNumber);
                
                cdrVoiceSMSDetails.setPLMNCode(_plmnCode);
                cdrVoiceSMSDetails.setCountryName(_countryName);
                cdrVoiceSMSDetails.setTechnologyUsed(_technologyUsed);
                cdrVoiceSMSDetails.setPackageName(_packageName);
                cdrVoiceSMSDetails.setBillDate(_billDate);
                
            }

            if (_eventType.contains("MMS") || _eventType.contains("GPRS")) {
                
                traceLog.traceFinest("In the populateCRDDetails GPRS and MMS ");
                
                cdrGprsMMSDetails = new CDRGPRSMMSdetails();
                cdrGprsMMSDetails.setEventType(_eventType);
                cdrGprsMMSDetails.setDUFFile(dufFileNameValue);

                if (_recordType != null && _recordType != "") {
                    cdrGprsMMSDetails.setRecordType(Integer.valueOf(_recordType));
                } else {
                    cdrGprsMMSDetails.setRecordType(0);
                }
                
                cdrGprsMMSDetails.setAccountNum(_accountNum);
                
                if (_sequenceNumber != null && _sequenceNumber != "") {
                    cdrGprsMMSDetails.setSequenceNumber(Integer.valueOf(_sequenceNumber));;
                } else {
                    cdrGprsMMSDetails.setSequenceNumber(0);
                }
                
                cdrGprsMMSDetails.setIMSI(_imsi);
                cdrGprsMMSDetails.setMSISDN(_msisdn);
                
                //String _recordStartTimeNbl = (String) event1.getAttributeByName("RECORDSTARTTIME");
                String _recordStartTime = (String) event1.getAttributeByName("TIME");
                traceLog.traceFinest("RECORDSTARTTIME : " + _recordStartTime);
                if (_recordStartTime != null && _recordStartTime != "") {
                    cdrGprsMMSDetails.setRecordStartTime(_recordStartTime);
                } else {
                    cdrGprsMMSDetails.setRecordStartTime("");
                }
                
                String _accessPointName = (String) event1.getAttributeByName("ACCESSPOINTNAME");
                traceLog.traceFinest("ACCESSPOINTNAME : " + _accessPointName);
                cdrGprsMMSDetails.setAccessPointName(_accessPointName);
                
                cdrGprsMMSDetails.setIMEI(_imei);
                cdrGprsMMSDetails.setHomeSID(_homeSID);
                cdrGprsMMSDetails.setServeSID(_serveSID);
                cdrGprsMMSDetails.setCellIdentity(_cellIdentity);

                String _serverPdpAddress = (String) event1.getAttributeByName("SERVERPDPADDRESS");
                traceLog.traceFinest("SERVERPDPADDRESS : " + _serverPdpAddress);
                cdrGprsMMSDetails.setServerPdpAddress(_serverPdpAddress);
                
                String _locationAreaCode = (String) event1.getAttributeByName("LOCATIONAREACODE");
                traceLog.traceFinest("LOCATIONAREACODE : " + _locationAreaCode);
                cdrGprsMMSDetails.setLocationAreaCode(_locationAreaCode);
                
                String _totalVolume = (String) event1.getAttributeByName("TOTALVOLUME");
                traceLog.traceFinest("TOTALVOLUME : " + _totalVolume);
                cdrGprsMMSDetails.setTotalVolume(_totalVolume);
                
                Object _duration = event1.getAttributeByName("DURATION");
                traceLog.traceFinest("DURATION : " + _duration);
                if (_duration != null && _duration != "") {
                    cdrGprsMMSDetails.setDuration(String.valueOf(_duration));
                } else {
                    cdrGprsMMSDetails.setDuration("");
                }
                
                cdrGprsMMSDetails.setIncomingTrunkID(_incomingTrunkID);
                
                Object _dataChargeCode = event1.getAttributeByName("DATACHARGECODE");
                traceLog.traceFinest("DATACHARGECODE : " + _dataChargeCode);
                cdrGprsMMSDetails.setDataChargeCode(String.valueOf(_dataChargeCode));
                
                String _dataRate = (String) event1.getAttributeByName("DATARATE");
                traceLog.traceFinest("DATARATE : " + _dataRate);
                cdrGprsMMSDetails.setDataRate(_dataRate);
                
                String _dataChargeAmount = (String) event1.getAttributeByName("DATACHARGEAMOUNT");
                traceLog.traceFinest("DATACHARGEAMOUNT : " + _dataChargeAmount);
                cdrGprsMMSDetails.setDataChargeAmount(_dataChargeAmount);
                
                cdrGprsMMSDetails.setOnNetwork(_onNetwork);
                
                String _mmsTypeIndicator = (String) event1.getAttributeByName("MMSTYPEINDICATOR");
                traceLog.traceFinest("MMSTYPEINDICATOR : " + _mmsTypeIndicator);
                cdrGprsMMSDetails.setMMSTypeIndicator(_mmsTypeIndicator);
                
                String _sgsnAddress = (String) event1.getAttributeByName("SGSNADDRESS");
                traceLog.traceFinest("SGSNADDRESS : " + _sgsnAddress);
                cdrGprsMMSDetails.setSGSNAddress(_sgsnAddress);
                
                Object _uplinkVolumeNbl =  event1.getAttributeByName("UPLINKVOLUME");
                traceLog.traceFinest("UPLINKVOLUME : " + _uplinkVolumeNbl);
                if (_uplinkVolumeNbl != null && _uplinkVolumeNbl != "") {
                    cdrGprsMMSDetails.setUplinkVolume(String.valueOf(_uplinkVolumeNbl));
                } else {
                    cdrGprsMMSDetails.setUplinkVolume("");
                }
                
                Object _downlinkVolumeNbl = event1.getAttributeByName("DOWNLINKVOLUME");
                traceLog.traceFinest("DOWNLINKVOLUME : " + _downlinkVolumeNbl);
                if (_downlinkVolumeNbl != null && _downlinkVolumeNbl != "") {
                    cdrGprsMMSDetails.setDownlinkVolume(String.valueOf(_downlinkVolumeNbl));
                } else {
                    cdrGprsMMSDetails.setDownlinkVolume("");
                }
                
                cdrGprsMMSDetails.setPLMNCode(_plmnCode);
                cdrGprsMMSDetails.setCountryName(_countryName);
                
                String _recordingEntity = (String) event1.getAttributeByName("RECORDINGENTITY");
                traceLog.traceFinest("RECORDINGENTITY : " + _recordingEntity);
                cdrGprsMMSDetails.setRecordingEntity(_recordingEntity);
                
                cdrGprsMMSDetails.setTechnologyUsed(_technologyUsed);
                cdrGprsMMSDetails.setPackageName(_packageName);
                cdrGprsMMSDetails.setBillDate(_billDate);
                
                String _utcTime = (String) event1.getAttributeByName("UTCTIME");
                traceLog.traceFinest("UTCTIME : " + _utcTime);
                cdrGprsMMSDetails.setUtcTime(_utcTime);
                
                String _createTimeNbl = (String) event1.getAttributeByName("CREATETIME");
                traceLog.traceFinest("CREATETIME : " + _createTimeNbl);
                cdrGprsMMSDetails.setCreateTime(_createTimeNbl);
               
                String _eventTimeNbl = (String) event1.getAttributeByName("TIME");
                traceLog.traceFinest("TIME : " + _eventTimeNbl);
                cdrGprsMMSDetails.setEventTime(_eventTimeNbl);
                
                String _msisdnTarget = (String) event1.getAttributeByName("TARGET");
                traceLog.traceFinest("MSISDN Target : " + _msisdnTarget);
                cdrGprsMMSDetails.setMSISDNTarget(_msisdnTarget);
                
                String _msisdnSource = (String) event1.getAttributeByName("SOURCE");
                traceLog.traceFinest("MSISDN Source : " + _msisdnSource);
                cdrGprsMMSDetails.setMSISDNSource(_msisdnSource);
                
            }            
         
            cdrDetailsResult.setCDRGPRSMMSdetails(cdrGprsMMSDetails);
            cdrDetailsResult.setCDRVoiceSMSDetails(cdrVoiceSMSDetails);
            cdrDetailsResults.add(cdrDetailsResult);
        }

        return cdrDetailsResults;

  }
  
    
    private List<Event> processEvents(List<HashMapPlus> list, final String customerRef, final String customerType,
            final String eventSource, Map<String, Map<java.util.Date, Double>> currencyConfig,
            IntervalMapping intervalMappingVoice, IntervalMapping intervalMappingData) throws Exception {
        List<Event> events = new ArrayList<Event>(0);
        int currencyFactor = getCurrencyScalingFactor();

        traceLog.traceFinest("Processing events :" + list.size() + " for " + eventSource);

        Map<String, String> billConfig = new HashMap<String, String>();
        Map<String, String> packageNames = new HashMap<String, String>();
        
        Map<String, Map<String, String>> eventTypeMap = intervalMappingVoice.callMethod();
        //traceLog.traceFinest("Printing the eventTypeMap AFTER callMethod : " + eventTypeMap);

        if (customerType.compareToIgnoreCase("Wholesale") == 0) {
            billConfig = getBillDates(customerRef);
            packageNames = getPackageNames();
        }

        Pair pair = null;
        String dufFileName = "";
        for (HashMapPlus map : list) {
            Event event = new Event(currencyFactor);
            event.setId(map.getString("EVENT_REF").hashCode());
            event.setName(eventTypeMap.get(map.getString("EVENT_TYPE_ID")).get("NAME"));

            //event.setSource(eventSource);
            event.setAttributeByName("customerType", customerType);

            //Thirupathi start
         //   if (pair == null || !pair.contains(map.getDate("CREATED_DTM"))) {
                if (event.getName().contains("VOICE") || event.getName().contains("SMS")) {
                    pair = intervalMappingVoice.find(map.getString("EVENT_SEQ"), map.getDate("CREATED_DTM"));
                    dufFileName = intervalMappingVoice.get(map.getString("EVENT_SEQ"), pair);
                } else {
                    pair = intervalMappingData.find(map.getString("EVENT_SEQ"), map.getDate("CREATED_DTM"));
                    dufFileName = intervalMappingData.get(map.getString("EVENT_SEQ"), pair);
                }
          //  }

            event.setAttributeByName("dufFileName", dufFileName);
            //Thirupathi end

            for (Map.Entry<String, String> entry : eventTypeMap.get(map.getString("EVENT_TYPE_ID")).entrySet()) {
                String value = null;

                if (entry.getValue().toUpperCase().equals("EVENT_DTM")
                        || entry.getValue().toUpperCase().equals("CREATED_DTM")) {
                    value = DateUtil.getDateTime("yyyyMMddHHmmss", map.getDate(entry.getValue().toUpperCase()));
                } else if (adjustFieldPrecision(map.getInt("EVENT_TYPE_ID"), entry.getValue())) {
                    double conversionFactor = 1;
                    Map<java.util.Date, Double> config = currencyConfig.get(map.get("EVENT_TYPE_ID") + "|"
                            + map.get("TARIFF_ID"));

                    if (config != null) {
                        for (Map.Entry<java.util.Date, Double> range : config.entrySet()) {
                            if (map.getDate("CREATED_DTM").after(range.getKey())) {
                                conversionFactor = range.getValue();
                                break;
                            }
                        }
                    }

                    if (map.getString(entry.getValue()) != null) {
                        Double converted = map.getDouble(entry.getValue()) / conversionFactor;
                        value = converted.toString();
                    }
                } else {
                    if (map.containsKey(entry.getValue().toUpperCase())) {
                        value = map.getString(entry.getValue().toUpperCase());
                    } else {
                        value = entry.getValue();
                    }
                }
                event.setAttributeByName(entry.getKey().toUpperCase(), value);
            }

            if (billConfig.size() > 0) {
                event.setAttributeByName("billDate", billConfig.get(map.getString("EVENT_SEQ")));
                event.setAttributeByName("packageName", packageNames.get(map.getString("TARIFF_ID")));
            }

            event.calculateFields();
            events.add(event);
        }
        return events;
    }
    private Map<String, String> getAllEventTypesInternal() throws Exception {

        traceLog.traceFinest("Executing getAllEventTypesInternal ");
        
        Connection connectionObject = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        StringBuilder sql = new StringBuilder("SELECT * FROM EVENTTYPE ET WHERE EVENT_TYPE_ID in (");
        sql.append(Constants.VOICE).append(",").append(Constants.SMS).append(",")
                .append(Constants.MMS).append(",").append(Constants.GPRS).append(",")
                .append(Constants.INTL_ROAM_VOICE).append(",").append(Constants.INTL_ROAM_SMS)
                .append(",").append(Constants.INTL_ROAM_GPRS).append(")");

        Map<String, String> eventTypes = new HashMap<String, String>();

        try {
            traceLog.traceFinest("Inside getAllEventTypesInternal before connection : "+ sql.toString());
            connectionObject = util.getDataSource().getConnection();
            preparedStatement = connectionObject.prepareStatement(sql.toString());
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                eventTypes.put(resultSet.getString("EVENT_TYPE_ID"), resultSet.getString("EVENT_TYPE_NAME"));
            }

        } catch (SQLException sqlex) {
            traceLog.traceFinest("Exception inside getAllEventTypesInternal:: " + sqlex.getMessage());
            sqlex.printStackTrace();
        } finally {
            util.closeResources(resultSet, connectionObject, preparedStatement, null);
        }
        traceLog.traceFinest("Execuuted getAllEventTypesInternal ");
        return eventTypes;
    }
    private Integer getCurrencyScalingFactor() throws Exception {
        Double factor = Math.pow(10, getMinorDecimalPlaces() + 1);
        return factor.intValue();
    }
    private Map<String, String> getBillDates(final String customerRef) throws Exception {
        String billSql = "SELECT a.account_num, to_char(bs.bill_dtm,'yyyymmddhh24miss') next_bill, bs.event_seq "
                + "FROM account a JOIN tmobile_custom.tmo_acct_mapping tam "
                + " ON tam.rating_acct_nbr = a.account_num     "
                + "JOIN billsummary bs ON a.account_num = bs.account_num "
                + "WHERE bs.bill_status = '12' AND tam.cust_type = 'Wholesale' AND tam.rating_cust_ref = ? "
                + "UNION SELECT account_num, to_char(next_bill_dtm,'yyyymmddhh24miss') next_bill, bill_event_seq event_seq "
                + "FROM account ";

        Map<String, String> billConfig = new HashMap<String, String>();

        List<HashMapPlus> billDates = util.executeQueryForList(billSql, new IrbClientParam[] { new IrbClientParam(1,
                customerRef, Types.VARCHAR) }, null);

        traceLog.traceFinest("billDates :" + billSql);

        for (HashMapPlus map : billDates) {
            billConfig.put(map.getString("EVENT_SEQ"), map.getString("NEXT_BILL"));
        }
        return billConfig;
    }
    
    private Map<String, String> getPackageNames() throws Exception {
        String ratingSql = "SELECT rating_tariff_id, product_name FROM tariffhasratingtariff "
                + "JOIN cataloguechange USING (catalogue_change_id) "
                + "JOIN tariffelement USING(tariff_id,catalogue_change_id) JOIN product USING(product_id) "
                + "WHERE product_id IN (235,236) AND cataloguechange.CATALOGUE_STATUS = 3 "
                + "UNION ALL SELECT rt.rating_tariff_id, pkg.package_name "
                + " FROM ratingcatalogue rc JOIN cataloguechange cc "
                + "ON rc.rating_catalogue_id = cc.rating_catalogue_id JOIN ratingtariff RT "
                + "ON rt.rating_catalogue_id = rc.rating_catalogue_id "
                + "JOIN invoicingcompany ic ON ic.invoicing_co_id = cc.invoicing_co_id "
                + "JOIN package PKG  ON PKG.catalogue_change_id = cc.catalogue_change_id "
                + "JOIN packageproductratetariff pprt ON pprt.catalogue_change_id = cc.catalogue_change_id "
                + "AND pprt.package_id = pkg.package_id AND pprt.rating_tariff_id = rt.rating_tariff_id "
                + "JOIN packagehasmarketsegment phms ON phms.catalogue_change_id = cc.catalogue_change_id "
                + "AND phms.package_id = PKG.package_id "
                + "WHERE rc.catalogue_status = 3 AND cc.catalogue_status = 3 "
                + "AND ic.invoicing_co_name = 'T-Mobile, USA' AND phms.market_segment_id IN "
                + "(SELECT market_segment_id FROM tmobile_custom.tmo_acct_mapping tam JOIN customer c "
                + " ON c.customer_ref = tam.rating_cust_ref "
                + "WHERE cust_type = 'Wholesale' AND tam.tibco_partner_id IS NOT NULL) ";

        Map<String, String> packageNames = new HashMap<String, String>();

        List<HashMapPlus> catalog = util.executeQueryForList(ratingSql, new IrbClientParam[0], null);

        traceLog.traceFinest("Printing the ratingSql " + ratingSql);
        for (HashMapPlus map : catalog) {
            packageNames.put(map.getString("RATING_TARIFF_ID"), map.getString("PRODUCT_NAME"));
        }
        return packageNames;
    }
    private boolean adjustFieldPrecision(int eventType, String field) {
        if (field.equalsIgnoreCase("EVENT_COST_MNY")) {
            return true;
        }
        if (field.equalsIgnoreCase("EVENT_ATTR_24") && (eventType == 1 || eventType == 4 || eventType == 20)) {
            return true;
        }
        if (field.equalsIgnoreCase("EVENT_ATTR_26") && (eventType == 2 || eventType == 28)) {
            return true;
        }
        if (field.equalsIgnoreCase("EVENT_ATTR_27")
                && (eventType == 1 || eventType == 20 || eventType == 3 || eventType == 21)) {
            return true;
        }
        if (field.equalsIgnoreCase("EVENT_ATTR_34") && (eventType == 1 || eventType == 20)) {
            return true;
        }

        return false;
    }
    private int getMinorDecimalPlaces() throws Exception {

        int MINOR_DECIMAL_PLACES = 0;
        String sql = "SELECT minor_decimal_places FROM currency WHERE currency_code='USD'";
        List<HashMapPlus> list = util.executeQueryForList(sql, new IrbClientParam[0], null);
        for (HashMapPlus map : list) {
            MINOR_DECIMAL_PLACES = map.getInt("MINOR_DECIMAL_PLACES");
        }
        return MINOR_DECIMAL_PLACES;
    }

}
