package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.Types;
import java.util.List;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.HashMapPlus;
import com.convergys.custom.geneva.j2ee.util.IrbClientParam;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.ApplicationException;
import com.convergys.geneva.j2ee.Null;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.logging.TraceLog;

public class QueryPartnerContactDetailsDao {
	
	private static TraceLog traceLog = new TraceLog(QueryPartnerContactDetailsDao.class);

	private Util util;
	
	public QueryPartnerContactDetailsDao() {
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}

	public ContactResultElements getPartnerContactDetails(IntegratorContext integratorContext, String customerRef,
			long whenDtmNbl) throws Exception {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = util.getHostName();
		String diffStr = null;
		DataSource das = null;
		startTime = System.currentTimeMillis();
		String responseStatus = null;
		traceLog.traceFinest("getPartnerContactDetails method started ...startTime " + startTime);
		ContactResultElements contactResultElements = new ContactResultElements();
		QueryPartnerContactDetailsInput queryPartnerContactDetailsInput = new QueryPartnerContactDetailsInput();
		QueryPartnerContactDetailsOutput queryPartnerContactDetailsOutput = new QueryPartnerContactDetailsOutput();

		try {

			if (integratorContext == null || integratorContext.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.QUERY_PARTNER_CONTACT_DETAILS_API);
			}

			if (customerRef == null || customerRef.equals("")) {

				throw new NullParameterException(ErrorCodes.ERR_RBM_1005, Constants.QUERY_PARTNER_CONTACT_DETAILS_API);
			}

			queryPartnerContactDetailsInput.setIntegratorContext(integratorContext);
			queryPartnerContactDetailsInput.setCustomerRef(customerRef);
			queryPartnerContactDetailsInput.setWhenDtmNbl(whenDtmNbl);
			String query = SQLStatements.GET_PARTNER_CONTACT_DETAILS;
			IrbClientParam[] params = new IrbClientParam[1];
			params[0] = new IrbClientParam(1, customerRef.toUpperCase(), Types.VARCHAR);
			List<HashMapPlus> results = util.executeQueryForList(query, params, null);
			
			if (results != null && results.size() > 1) {

				throw new ApplicationException(ErrorCodes.ERR_RBM_14000);

			}

			if (results != null && results.size() == 1) {
				contactResultElements.setContactName(results.get(0).getString("CONTACT_NAME"));
				contactResultElements.setContactSurname(results.get(0).getString("CONTACT_SURNAME"));
				contactResultElements.setContactEmail(results.get(0).getString("CONTACT_EMAIL"));
				contactResultElements.setContactPhone(results.get(0).getString("CONTACT_PHONE"));
				contactResultElements.setContactPosition(results.get(0).getString("CONTACT_POSITION"));

			}

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after getPartnerContactDetails.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of getPartnerContactDetails is " + diff + "........." + diffStr);
			das = util.getDataSource();
			responseStatus = Constants.TRANSACTION_SUCCESS;
		} catch (Exception ex) {
			traceLog.traceFinest("Exception occured   in method InvoiceSectionDetails " + ex.getMessage());
			responseStatus = ex.getMessage();
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
					queryPartnerContactDetailsInput, queryPartnerContactDetailsOutput, responseStatus,
					Constants.QUERY_INVOICE_SECTIONDETAILS, das, diffStr, node);
			throw new ApplicationException(ErrorCodes.ERR_RBM_14001 + ex.getMessage().toString());
		}
		queryPartnerContactDetailsOutput.setContactResult(contactResultElements);
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, null, null,
				queryPartnerContactDetailsInput, queryPartnerContactDetailsOutput, responseStatus,
				Constants.QUERY_INVOICE_SECTIONDETAILS, das, diffStr, node);
		traceLog.traceFinest("getPartnerContactDetails method ended ");
		return contactResultElements;

	}

}
