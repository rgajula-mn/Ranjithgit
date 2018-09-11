package com.convergys.custom.geneva.j2ee.util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.jdbc.core.support.JdbcDaoSupport;

import com.convergys.custom.geneva.j2ee.billingProfile.EnumDateNullCond;
import com.convergys.custom.geneva.j2ee.billingProfile.FilterArrayElements;
import com.convergys.custom.geneva.j2ee.billingProfile.Pagination;
import com.convergys.custom.geneva.j2ee.billingProfile.SortingArrayElements;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.HashMapPlus;
import com.convergys.custom.geneva.j2ee.util.IrbClientParam;
import com.convergys.geneva.j2ee.productInstance.ProductInstanceService;
import com.convergys.logging.TraceLog;
import com.convergys.custom.geneva.j2ee.util.ServiceLocator;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.billingProfile.ColumnDetails;
import com.convergys.geneva.j2ee.customer.CustomerService;

public class Util extends JdbcDaoSupport {

	private static TraceLog traceLog = new TraceLog(Util.class);
	ProductInstanceService productInstanceService = null;
	CustomerService customerService = null;

	public String getHostName() {
		InetAddress ip;
		String hostname = null;
		;
		try {
			ip = InetAddress.getLocalHost();
			hostname = ip.getHostName();
			traceLog.traceFinest("Your current IP address : " + ip);
			traceLog.traceFinest("Your current Hostname : " + hostname);

		} catch (UnknownHostException e) {

			e.printStackTrace();
		}
		return hostname;
	}

	public boolean validateInvoice(String invoiceNumber) {

		traceLog.traceFinest("Inside getResults method invoiceNumber:" + invoiceNumber);
		Pattern pattern = Pattern.compile("^[a-zA-Z0-9]+(\\s)?(-)(\\s)?[0-9]+$");
		Matcher matcher = pattern.matcher(invoiceNumber.trim());

		traceLog.traceFinest("ended validateInvoice method");
		return matcher.matches();

	}

	/**
	 * This method is used to close the DB Resources
	 * 
	 * @param ResultSet
	 * @param Connection
	 * @param PreparedStatement
	 * @param CallableStatement
	 * @author sgad2315 (Sreekanth Gade)
	 */
	public void closeResources(ResultSet rs, Connection con, PreparedStatement ps, CallableStatement cs) {
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("closeResources method Start");
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception rse) {
				if (traceLog.isFinerEnabled())
					traceLog.traceFiner("Exception while closing the resultset" + rse);
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (Exception cone) {
				if (traceLog.isFinerEnabled())
					traceLog.traceFiner("Exception while closing the connection" + cone);
			}
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception pse) {
				if (traceLog.isFinerEnabled())
					traceLog.traceFiner("Exception while closing the statement" + pse);
			}
		}
		if (cs != null) {
			try {
				cs.close();
			} catch (Exception cse) {
				if (traceLog.isFinerEnabled())
					traceLog.traceFiner("Exception while closing the callable statement" + cse);
			}
		}
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("closeResources method Exit");
	}

	/**
	 * Retrieves list of items using select sql. Also populates column headers.
	 * If not found, empty list will be returned. Value will be keyed by upper
	 * case of column name.
	 * 
	 * @param sql
	 * @param params
	 * @param columnHeaders
	 * @return
	 */
	public List<HashMapPlus> executeQueryForList(final String sql, final IrbClientParam[] params,
			final List<String> columnHeaders) throws Exception {

		traceLog.traceFinest("START executeQueryForList printing the SQL: " + sql);
		if (sql == null || !sql.toUpperCase().startsWith("SELECT")) {
			throw new RuntimeException("SQL is null or not start with SELECT clause :" + sql);
		}

		List<HashMapPlus> list = new ArrayList<HashMapPlus>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			conn = getDataSource().getConnection();
			pstmt = conn.prepareStatement(sql);
			// stmt.setQueryTimeout(60);

			if (params != null) {
				for (int i = 0; i < params.length; ++i) {
					setParam(pstmt, params[i]);
				}
			}

			long processTime = System.currentTimeMillis();
			rs = pstmt.executeQuery();
			processTime = System.currentTimeMillis() - processTime;
			traceLog.traceFinest("In executeQueryForList SQL '" + sql + "'" + " | " + Thread.currentThread().getId()
					+ " | " + processTime + "ms");

			if (columnHeaders != null) {
				columnHeaders.addAll(getColumnHeaders(rs));
			}

			while (rs.next()) {
				HashMapPlus map = getResultMap(rs);
				list.add(map);
			}

		} catch (SQLException sqle) {
			traceLog.traceFinest("SQLException catch block" + sqle.getMessage());
			throw new Exception(sql, sqle);

		} finally {
			closeResources(rs, conn, pstmt, null);
		}
		// traceLog.traceFinest("END executeQueryForList printing the item: " +
		// list);
		return list;
	}

	/**
	 * Sets parameter for the statement. Index starts from 0.
	 * 
	 * @param stmt
	 * @param param
	 * @throws SQLException
	 */
	public void setParam(final PreparedStatement stmt, final IrbClientParam param) throws Exception {
		if (param.isOutputParam()) {
			if (stmt instanceof CallableStatement) {
				if (param.getSqlTypeName() != null) {
					((CallableStatement) stmt).registerOutParameter(param.getIndex(), param.getType(),
							param.getSqlTypeName());
				} else {
					((CallableStatement) stmt).registerOutParameter(param.getIndex(), param.getType());
				}
			} else {
				Exception e = new Exception("Error : passing OUTPUT_PARAM to a non-callable statement.");
				throw new Exception(e.toString(), e);
			}
		} else {
			traceLog.traceFinest(
					"setParam index=" + param.getIndex() + " value=" + param.getValue() + " type=" + param.getType());
			stmt.setObject(param.getIndex(), param.getValue(), param.getType());
		}
	}

	/**
	 * Returns list of column names in upper case.
	 * 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	public List<String> getColumnHeaders(final ResultSet rs) throws SQLException {
		traceLog.traceFinest("ENTER getColumnHeaders ");
		List<String> list = new ArrayList<String>();
		ResultSetMetaData data = rs.getMetaData();

		// data column starts from 1
		for (int i = 1; i <= data.getColumnCount(); ++i) {
			String columnName = data.getColumnName(i).toUpperCase();
			list.add(columnName);
		}
		traceLog.traceFinest("END getColumnHeaders printing list: " + list);
		return list;
	}

	/**
	 * Converts ResultSet to HashMapPlus, keyed by column name in upper case.
	 * 
	 * @param rs
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMapPlus getResultMap(final ResultSet rs) throws SQLException {
		HashMapPlus map = new HashMapPlus(13);
		ResultSetMetaData data = rs.getMetaData();

		// data column starts from 1
		for (int i = 1; i <= data.getColumnCount(); ++i) {
			String columnName = data.getColumnName(i).toUpperCase();
			Object value = null;
			int type = data.getColumnType(i);
			// to get time info, must use getTimestamp().
			// HACK for product_charges_view
			if (type == Types.DATE || type == Types.TIMESTAMP || "DATE_TIME".equals(columnName)) {
				value = rs.getTimestamp(i);
			} else {
				value = rs.getObject(i);
			}
			map.put(columnName, value);
		}
		return map;
	}

	public String getSectionName(String sectionType, String partnerName) {
		switch (sectionType.toUpperCase()) {
		case "USG":
			return partnerName + " " + Constants.SectionName.USG_NAME.getSectionName();
		case "MRC":
			return Constants.SectionName.MRC_NAME.getSectionName();
		case "ADJ":
			return Constants.SectionName.ADJ_NAME.getSectionName();
		case "TAX":
			return Constants.SectionName.TAX_NAME.getSectionName();
		case "OTF":
			return Constants.SectionName.OTF_NAME.getSectionName();
		case "GTF":
			return Constants.SectionName.GTF_NAME.getSectionName();
		default:
			return null;

		}
	}

	/**
	 * This method builds the Pagination Query
	 * 
	 * @param pagination
	 * @param query
	 * @return StringBuilder
	 * 
	 * @author prch0516
	 */
	public StringBuilder buildPaginationQuery(Pagination pagination, StringBuilder query) {

		if (pagination != null && pagination.getOffSetStartNbl() >= 0 && pagination.getOffSetEndNbl() > 0) {
			query.append(" OFFSET " + pagination.getOffSetStartNbl() + " ROWS FETCH NEXT "
					+ pagination.getOffSetEndNbl() + " ROWS ONLY");
		} else {
			int startIndex = 0;
			int endIndex = 50;

			query.append(" OFFSET " + startIndex + " ROWS FETCH NEXT " + endIndex + " ROWS ONLY");
		}
		return query;
	}

	public StringBuilder buildSortingQuery(SortingArrayElements[] sortArray, StringBuilder query) {
		traceLog.traceFinest("Start of the buildSortingQuery method ");
		if (sortArray != null && sortArray.length > 0) {
			int counter = sortArray.length;
			query.append(" ORDER BY ");
			for (int i = 0; i < sortArray.length; i++) {
				if (counter > 1) {
					if (Constants.Order.ASC.getOrder().equalsIgnoreCase(sortArray[i].getOrder())
							|| Constants.Order.DESC.getOrder().equalsIgnoreCase(sortArray[i].getOrder())) {
						query.append(sortArray[i].getColumnName() + " " + sortArray[i].getOrder() + " ,");
					}

				} else {
					if (Constants.Order.ASC.getOrder().equalsIgnoreCase(sortArray[i].getOrder())
							|| Constants.Order.DESC.getOrder().equalsIgnoreCase(sortArray[i].getOrder())) {
						query.append(sortArray[i].getColumnName() + " " + sortArray[i].getOrder() + " ");
					}
				}
				counter--;
			}
		}
		traceLog.traceFinest("End of the buildSortingQuery method: " + query.toString());
		return query;
	}

	public String[] getSearchedEnumType(String values) {
		if (values.contains(Constants.PIPE_OPERATOR)) {
			return values.split("\\" + Constants.PIPE_OPERATOR);
		}
		return null;
	}
	/**
	 * This Method builds the Filter Query
	 * 
	 * @return StringBuilder
	 * 
	 * @author prch0516
	 */

	public StringBuilder buildFilterQuery(FilterArrayElements[] filterArrayElements, StringBuilder query) {

		if (filterArrayElements != null && filterArrayElements.length > 0) {
			for (int i = 0; i < filterArrayElements.length; i++) {
				traceLog.traceFinest("start of buildfilterquery " + query);

				query.append(" AND ");
				if (filterArrayElements[i].getReOperator().equalsIgnoreCase("between")
						|| filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.NA
						|| filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
						|| filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.BOTH) {
					boolean isDateNull = false;
					query.append("(");

					if (filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.NA) {
						isDateNull = true;
					}
					if (isDateNull
							&& (filterArrayElements[i].getValue1() == null
									|| filterArrayElements[i].getValue1().trim().isEmpty())
							&& (filterArrayElements[i].getValue2() == null
									|| filterArrayElements[i].getValue2().isEmpty())) {// NA-1
						query.append(filterArrayElements[i].getColumnName() + " IS NULL ");
					} else if (filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
							&& (filterArrayElements[i].getValue1() == null
									|| filterArrayElements[i].getValue1().trim().isEmpty())
							&& filterArrayElements[i].getValue2() == null) {// withDate-2
						query.append(filterArrayElements[i].getColumnName() + " IS NOT NULL ");
					} else if (isDateNull && filterArrayElements[i].getValue1() != null
							&& filterArrayElements[i].getValue2() == null) {// NA-3.1
						query.append(" (TRUNC( " + filterArrayElements[i].getColumnName() + " ) " + " >= TO_DATE('"
								+ filterArrayElements[i].getValue1() + "' ,'yyyy/mm/dd')) OR "
								+ filterArrayElements[i].getColumnName() + " IS NULL ");
					} else if (isDateNull
							&& (filterArrayElements[i].getValue1() == null
									|| filterArrayElements[i].getValue1().trim().isEmpty())
							&& filterArrayElements[i].getValue2() != null) {// NA-3.2
						query.append(" (TRUNC( " + filterArrayElements[i].getColumnName() + " ) " + " <= TO_DATE('"
								+ filterArrayElements[i].getValue2() + "' ,'yyyy/mm/dd')) OR "
								+ filterArrayElements[i].getColumnName() + " IS NULL ");
					} else if (isDateNull
							&& (filterArrayElements[i].getValue1() != null
									|| !filterArrayElements[i].getValue1().trim().isEmpty())
							&& filterArrayElements[i].getValue2() != null) {// NA-3.3
						query.append(" (TRUNC( " + filterArrayElements[i].getColumnName() + " ) " + " >= TO_DATE('"
								+ filterArrayElements[i].getValue1() + "' ,'yyyy/mm/dd') AND " + " TRUNC( "
								+ filterArrayElements[i].getColumnName() + " ) " + " <= TO_DATE('"
								+ filterArrayElements[i].getValue2() + "' ,'yyyy/mm/dd')) OR "
								+ filterArrayElements[i].getColumnName() + " IS NULL ");
					} else if (filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
							&& filterArrayElements[i].getValue1() != null
							&& filterArrayElements[i].getValue2() == null) {// 4.1
						query.append(" TRUNC( " + filterArrayElements[i].getColumnName() + " ) " + " >= TO_DATE('"
								+ filterArrayElements[i].getValue1() + "' ,'yyyy/mm/dd') ");
					} else if (filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
							&& (filterArrayElements[i].getValue1() == null
									|| filterArrayElements[i].getValue1().trim().isEmpty())
							&& filterArrayElements[i].getValue2() != null) {// 4.2
						query.append(" TRUNC( " + filterArrayElements[i].getColumnName() + " ) " + " <= TO_DATE('"
								+ filterArrayElements[i].getValue2() + "' ,'yyyy/mm/dd') ");
					} else if (filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.WITH_DATE
							&& (filterArrayElements[i].getValue1() != null
									|| !filterArrayElements[i].getValue1().trim().isEmpty())
							&& filterArrayElements[i].getValue2() != null) {// 4.3
						query.append(" (TRUNC( " + filterArrayElements[i].getColumnName() + " ) " + " >= TO_DATE('"
								+ filterArrayElements[i].getValue1() + "' ,'yyyy/mm/dd') AND " + " TRUNC( "
								+ filterArrayElements[i].getColumnName() + " ) " + " <= TO_DATE('"
								+ filterArrayElements[i].getValue2() + "' ,'yyyy/mm/dd')) ");
					} else if (filterArrayElements[i].getDateNullCondNbl() == EnumDateNullCond.BOTH) {
						query.append(" (" + filterArrayElements[i].getColumnName() + " IS NULL OR "
								+ filterArrayElements[i].getColumnName() + " IS NOT NULL)");
					} else if (filterArrayElements[i].getReOperator().equalsIgnoreCase("between")) {
						query.append(filterArrayElements[i].getColumnName() + " "
								+ filterArrayElements[i].getReOperator() + " '" + filterArrayElements[i].getValue1()
								+ "' AND '" + filterArrayElements[i].getValue2() + "' ");
					}
					query.append(")");

				} else if (filterArrayElements[i].getReOperator().equalsIgnoreCase("LIKE")) {
					query.append(" Upper(");
					query.append(filterArrayElements[i].getColumnName() + ") " + filterArrayElements[i].getReOperator()
							+ " ");
					query.append("'%" + filterArrayElements[i].getValue1().toUpperCase() + "%' ");

				} else if (filterArrayElements[i].getReOperator().equalsIgnoreCase("<=")
						|| filterArrayElements[i].getReOperator().equalsIgnoreCase(">=")) {
					query.append(" " + filterArrayElements[i].getColumnName() + filterArrayElements[i].getReOperator()
							+ " ");
					query.append(filterArrayElements[i].getValue1() + " ");

				} else if (filterArrayElements[i].getReOperator().equalsIgnoreCase("IN")) {

					String enumValues[] = getSearchedEnumType(filterArrayElements[i].getValue1());
					if (enumValues != null && enumValues.length > 0) {
						query.append(" Upper(");
						query.append(filterArrayElements[i].getColumnName() + ") ");
						query.append("IN ('");
						boolean flag = false;
						for (String s : enumValues) {
							if (flag) {
								query.append("','");
							}
							query.append(s.toUpperCase());
							flag = true;
						}
						query.append("') ");
					} else {
						query.append(" Upper(");
						query.append(filterArrayElements[i].getColumnName() + ") ");
						query.append("IN ('");
						query.append(filterArrayElements[i].getValue1().toUpperCase());
						query.append("') ");
					}
				} else {

					query.append(filterArrayElements[i].getColumnName() + " " + filterArrayElements[i].getReOperator()
							+ " '" + filterArrayElements[i].getValue1() + "' ");

				}
			}
		}
		traceLog.traceFinest("end of buildfilterquery " + query);
		return query;
	}

	/**
	 * This method returns the Total row count of the view based on the passed
	 * CUSTOMER REF
	 * 
	 * @param viewName
	 * @author sjoshi1
	 * @author sgad2315(Sreekanth Gade
	 * @return
	 */
	public int getTotalRowCount(String viewName) {
		traceLog.traceFinest("getTotalRowCount method started");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;
		StringBuilder query = new StringBuilder();
		query.append("SELECT count(*) FROM ( " + viewName + " )");
		traceLog.traceFinest("Inside resultSet of getTotalRowCount API " + query);

		int rowCount = 0;
		try {
			conn = getDataSource().getConnection();
			pstmt = conn.prepareStatement(query.toString());
			resultSet = pstmt.executeQuery();
			while (resultSet.next()) {

				rowCount = resultSet.getInt(1);
				traceLog.traceFinest("Inside resultSet of getTotalRowCount API " + rowCount);

			}
		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getTotalRowCount:: " + e.getMessage());
			e.printStackTrace();
		} finally {
			closeResources(resultSet, conn, pstmt, null);
		}

		return rowCount;
	}


	public ProductInstanceService getProductInstanceService() {
		if (productInstanceService != null)
			return productInstanceService;
		try {
			productInstanceService = (ProductInstanceService) ServiceLocator.getInstance()
					.getBean("ECA_ProductInstance");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return productInstanceService;
	}

	/**
	 * 
	 * @param productId
	 * @param productName
	 * @author sjoshi1
	 * @return
	 * @throws Exception
	 */
	public int getProductAttrSubId(Integer productId, String productName) throws Exception {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getProductAttrSubId productId:" + productId + " productName:" + productName);
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int product_sub_id = 0;
		try {
			connectionObject = getDataSource().getConnection();
			preparedStatement = connectionObject.prepareStatement(SQLStatements.GET_SUB_ID);
			preparedStatement.setInt(1, productId);
			preparedStatement.setString(2, productName);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {

				product_sub_id = resultSet.getInt(1);
			}
			if (product_sub_id == 0) {
				throw new Exception(ErrorCodes.ERR_RBM_4001 + productId);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getProductAttrSubId:: " + e.getMessage());
			// e.printStackTrace();
		} finally {
			closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Product Attr SubId is : " + product_sub_id);
		return product_sub_id;
	}
	//---
	public java.sql.Date getGnvSystemDate() {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getGnvSystemDate before connection");
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		java.sql.Date systemDate = null;
		try {
			connectionObject = getDataSource().getConnection();
			preparedStatement = connectionObject.prepareStatement(SQLStatements.GNV_DATE);
			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {

				systemDate = resultSet.getDate(1);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getGnvSystemDate:: " + e.getMessage());
			// e.printStackTrace();
		} finally {
			closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest(" getGnvSystemDate is : " + systemDate);
		return systemDate;
	}
	
	/**
	 * Retrieves single item using select sql. Also populates column headers. If
	 * not found, null will be returned. Value will be keyed by upper case of
	 * column name.
	 * 
	 * @param sql
	 * @param params
	 * @param columnHeaders
	 * @return HashMapPlus
	 * 
	 * @throws Exception
	 */
	public HashMapPlus executeQueryForItem(final String sql, final IrbClientParam[] params,
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
			conn = getDataSource().getConnection();
			pstmt = conn.prepareStatement(sql);
			// pstmt.setQueryTimeout(60);

			if (params != null) {
				for (int i = 0; i < params.length; ++i) {
					setParam(pstmt, params[i]);
				}
			}
			rs = pstmt.executeQuery();

			if (columnHeaders != null) {
				columnHeaders.addAll(getColumnHeaders(rs));
			}

			if (rs.next()) {
				item = getResultMap(rs);
			}

		} catch (SQLException e) {
			throw new Exception(sql, e);
		} finally {
			closeResources(rs, conn, pstmt, null);
		}
		// traceLog.traceFinest("END executeQueryForItem printing the item: " +
		// item);
		return item;
	}
	
	public CustomerService getCustomerService() {
		if (customerService != null)
			return customerService;
		try {
			customerService = (CustomerService) ServiceLocator.getInstance()
					.getBean("ECA_Customer");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return customerService;
	}
	
	public void insertQuery(final String tableName, ColumnDetails[] columnDetailsArray) throws Exception {
		traceLog.traceFinest("insertQuery method started");
		traceLog.traceFinest("tableName: " + tableName);
		if (tableName == null || tableName.equals("")) {
			throw new RuntimeException("tableName cannot be null");
		}
		if (columnDetailsArray == null || columnDetailsArray.length == 0) {
			throw new RuntimeException("colundetails array cannot be null");
		}
		
		StringBuilder insert_query = new StringBuilder().append("insert into " + tableName);
		StringBuilder values_query = new StringBuilder().append(" Values ");
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		for(int i=0;i<columnDetailsArray.length;i++) {
			ColumnDetails cd =columnDetailsArray[i];
			if(columnDetailsArray.length ==1 ) {
				insert_query.append(" (" + cd.getColumnName() + ") ");
				values_query.append(" (?)");
			}
			else 
			{
				if(i == 0) {
					insert_query.append(" (" + cd.getColumnName() + ", ");
					values_query.append(" (?,");
				}
				else if (i == (columnDetailsArray.length-1)) {
					insert_query.append(cd.getColumnName() + ") ");
					values_query.append("?) ");
				}
				else {
					insert_query.append(cd.getColumnName() + ", ");
					values_query.append("?,");
				}
			}
			
		}
		String sql = insert_query.append(values_query).toString();
		traceLog.traceFinest("insertQuery "+ sql);
		try
		{
		conn = getDataSource().getConnection();
		pstmt = conn.prepareStatement(sql);
		for(int i=0;i<columnDetailsArray.length;i++) {
			if(Constants.DATE_TYPE.equals(columnDetailsArray[i].getColumnDataType())) {
				pstmt.setDate(i+1, new java.sql.Date(DateUtil.convertStringToDate(columnDetailsArray[i].getColumnValue().trim()).getTime()));
			} else 
			{
				pstmt.setObject(i+1, columnDetailsArray[i].getColumnValue().trim(), CovertToSqlType(columnDetailsArray[i].getColumnDataType()));
			}
		}
		pstmt.executeUpdate();
	} catch (SQLException sqle) {
		traceLog.traceFinest("SQLException catch block" + sqle.getMessage());
		throw new Exception(sql, sqle);

	}
		traceLog.traceFinest("insertQuery method ended");
		
	}
	
	private int CovertToSqlType(String columnDataType) throws Exception {
		if(Constants.VARCHAR2_TYPE.equals(columnDataType)) {
			return Types.VARCHAR;
		}
		else if(Constants.NUMBER_TYPE.equals(columnDataType)) {
			return Types.INTEGER;
		}
		else {
			throw new Exception("columnDataType not found " + columnDataType);
		}
		
	}
	
	public String checkUTCOffSetValue(String attributeValue) {
		
		if(attributeValue != null && (attributeValue.endsWith("-07:00") || attributeValue.endsWith("-08:00"))){
		return attributeValue.substring(0, attributeValue.lastIndexOf("-"));
		} 
		return attributeValue;	


}
}
