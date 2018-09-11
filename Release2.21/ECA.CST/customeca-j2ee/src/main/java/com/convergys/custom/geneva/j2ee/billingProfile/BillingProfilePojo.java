package com.convergys.custom.geneva.j2ee.billingProfile;

import java.rmi.RemoteException;

import com.convergys.geneva.j2ee.adjustment.AdjustmentPK;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.iml.commonIML.ParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;


/**
 * @author tkon2950
 * @author sgad2315 (Sreekanth Gade)
 */

public class BillingProfilePojo implements BillingProfileLocalService {

	private QueryInvoiceSummaryDataDao queryInvoiceSummaryDataDao;
	private QueryInvoiceSectionDetailsDao queryInvoiceSectionDetailsDao;
	private QueryLineItemDetailsDao queryLineItemDetailsDao;
	private QueryCDRDataDao queryCDRDataDao;
	private QueryCDRDetailsDao queryCDRDetailsDao;
	private UpdateBillingProfileDao updateBillingProfileDao;
	private CreateBillingProfileDao createBillingProfileDao;
	private QueryLastRatedUsageDtmByTypeDao queryLastRatedUsageDtmByTypeDao;
	private CreateBulkRequestDao createBulkRequestDao;
	private QueryDUFFileNameDao queryDUFFileNameDao;
	private QueryPatnerBillingandFinanceDataDao queryPatnerBillingandFinanceDataDao;
	private GetBulkReqDao getBulkReqDao;
	private SendInvoiceByEmailDao sendInvoiceByEmailDao;
	private CancelPaymentsDao cancelPaymentsDao;
	private CreateAccountPaymentsDao createAccountPaymentsDao;
	private CreateAdjustmentDao createAdjustmentDao;
	private CancelAdjustmentDao cancelAdjustmentDao;
	private QueryPartnerContactDetailsDao queryPartnerContactDetailsDao;	
	private DeletePartnerUSTaxExemptionDao deletePartnerUSTaxExemptionDao;
	private PaymentsDao paymentsDao;
	private AddPartnerUSTaxExemptionDao addPartnerUSTaxExemptionDao;
	private CreateCustomerAndAccountDao createCustomerAndAccountDao;
	
	

	private static TraceLog traceLog = new TraceLog(BillingProfilePojo.class);

	public com.convergys.custom.geneva.j2ee.billingProfile.ParentChildProductInstanceData[] createBillingProfile(
			IntegratorContext integratorContext, String accountNum,
			NewProductInstancesData[] newSuperProductInstanceData) throws ApplicationException {

		traceLog.traceFinest("Entered into createBillingProfile API");
		ParentChildProductInstanceData parentChildProductInstanceData[];
		try {
			
			parentChildProductInstanceData = createBillingProfileDao.createBillingProfile(integratorContext, accountNum,
					newSuperProductInstanceData);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		return parentChildProductInstanceData;

	}

	public java.lang.String updateBillingProfile(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String customerRef, java.lang.String msisdn,
			com.convergys.custom.geneva.j2ee.billingProfile.ModifyEventSourceData[] modifyEventSourceData,
			com.convergys.custom.geneva.j2ee.billingProfile.ModifyProductInstanceData[] modifyProductInstanceData)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.iml.commonIML.ParameterException,
			com.convergys.platform.ApplicationException {
		String status = null;
		try {			
			status = updateBillingProfileDao.updateBillingProfile(integratorContext, customerRef, msisdn,
					modifyEventSourceData, modifyProductInstanceData);
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return status;

	}

	public com.convergys.custom.geneva.j2ee.billingProfile.QueryLastRatedUsageDtmByTypeResult[] queryLastRatedUsageDtmByType(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String msisdn, java.lang.String accountNum)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.platform.ApplicationException,
			com.convergys.iml.commonIML.ParameterException {		
		try {
			return queryLastRatedUsageDtmByTypeDao.queryLastRatedUsageDtmByType(integratorContext, msisdn, accountNum);			
		} catch (RemoteException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;

	}

	/**
	 * The service shall create the Account Payment in RB. This will update the
	 * payment details in RB key tables i.e. AccountPayment and PysicalPayment
	 * tables. The user and additional transaction related details will be
	 * logged into ecaaudittrail table
	 * 
	 * @author sgad2315
	 */
	public com.convergys.custom.geneva.j2ee.billingProfile.AccountPaymentResult createAccountPayments(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String accountNum, java.lang.String userName,
			com.convergys.custom.geneva.j2ee.billingProfile.NewAccountPaymentData newAccountPaymentData)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.platform.ApplicationException,
			com.convergys.iml.commonIML.ParameterException {
		traceLog.traceFinest("Entered into BillingProfilePojo createAccountPayments API");
		AccountPaymentResult accountPaymentResult = null;
		try {
			accountPaymentResult = createAccountPaymentsDao.createAccountPayments(integratorContext, accountNum,
					userName, newAccountPaymentData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		traceLog.traceFinest("End BillingProfilePojo createAccountPayments API");
		return accountPaymentResult;

	}

	/**
	 * The service shall cancel the physical payments in RB for a customer.
	 * Authorized user can cancel list of physical payments belongs to a
	 * customer
	 * 
	 * @author sgad2315
	 */
	public java.lang.String cancelPayments(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String userName, java.lang.String cancelledText,
			com.convergys.custom.geneva.j2ee.billingProfile.PaymentCancelData[] paymentCancelData)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.iml.commonIML.ParameterException,
			com.convergys.platform.ApplicationException {
		traceLog.traceFinest("Entered into BillingProfilePojo CancelPayments API");
		String status = null;
		try {			
			status = cancelPaymentsDao.cancelPayments(integratorContext, userName, cancelledText, paymentCancelData);

		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo CancelPayments API status : " + status);
		return status;
	}

	public void cancelAdjustment(com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			AdjustmentPK adjustmentPK) throws NullParameterException, ParameterException, ApplicationException {
		
		cancelAdjustmentDao.cancelAdjustment(integratorContext, adjustmentPK);

	}

	public AdjustmentResult createAdjustment(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			com.convergys.geneva.j2ee.account.AccountPK accountPK, long adjustmentDate,
			java.lang.String adjustmentTypeId, java.lang.String adjustmentText, long adjustmentMny,
			int budgetCentreSeqNblNbl, java.lang.Boolean requestCreditNote, long createdDtm,
			int contractedPointOfSupplyId, java.lang.String createdByUser)
			throws NullParameterException, ParameterException, ApplicationException {

		@SuppressWarnings("unused")
		AdjustmentResult adjustmentResult = new AdjustmentResult();

		try {
			adjustmentResult = createAdjustmentDao.createAdjustment(integratorContext, accountPK, adjustmentDate,
					adjustmentTypeId, adjustmentText, adjustmentMny, budgetCentreSeqNblNbl, requestCreditNote,
					createdDtm, contractedPointOfSupplyId, createdByUser);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}

		return adjustmentResult;
	}

	@Override
	public QueryPartnerBillingAndFinanceOutPutElements queryPatnerBillingandFinanceData(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			com.convergys.custom.geneva.j2ee.billingProfile.QueryPartnerBillingAndFinanceInputElements queryPartnerBillingAndFinanceInput)
			throws NullParameterException, ApplicationException, ParameterException {
		
		QueryPartnerBillingAndFinanceOutPutElements results = queryPatnerBillingandFinanceDataDao
				.queryPatnerBillingandFinanceData(integratorContext, queryPartnerBillingAndFinanceInput);

		return results;
	}

	public CreateBulkRequestOutputElements createBulkRequest(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String partnerID, java.lang.String portalUserID, java.lang.String requestFile,
			long createdDateTime) throws NullParameterException, ParameterException, ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo createBulkRequest method");
		CreateBulkRequestOutputElements bulkRequestOutput = new CreateBulkRequestOutputElements();

		try {			
			bulkRequestOutput = createBulkRequestDao.createBulkRequest(integratorContext, partnerID, portalUserID,
					requestFile, createdDateTime);
		} catch (Exception e) {
			traceLog.traceFinest("Exception occurs in pojo catch");
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo createBulkRequest method");
		return bulkRequestOutput;
	}

	public com.convergys.custom.geneva.j2ee.billingProfile.GetBulkRequestOutputElements getBulkRequests(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String partnerID, java.lang.String portalUserID)
			throws com.convergys.iml.commonIML.NullParameterException, com.convergys.iml.commonIML.ParameterException,
			com.convergys.platform.ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo getBulkRequests method");
		GetBulkRequestOutputElements getBulkRequestOutputElements = new GetBulkRequestOutputElements();
		try {
			getBulkRequestOutputElements = getBulkReqDao.getBulkRequests(integratorContext, partnerID, portalUserID);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo getBulkRequests method");
		return getBulkRequestOutputElements;
	}

	public QueryInvoiceSummaryOutPut queryInvoiceSummaryData(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String invoiceNumber) throws NullParameterException, ParameterException, ApplicationException {
		traceLog.traceFinest("Entered into queryInvoiceSummaryData API");
		QueryInvoiceSummaryOutPut queryInvoiceSummaryOutPut;
		try {
			queryInvoiceSummaryOutPut = queryInvoiceSummaryDataDao.queryInvoiceSummaryData(integratorContext,
					invoiceNumber);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End queryInvoiceSummaryData API");
		return queryInvoiceSummaryOutPut;
	}

	public QueryDUFFileNameResult queryDUFFileName(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String accountNum, java.lang.String eventSeq, int eventTypeIDNbl, long ratedDtmNbl)
			throws NullParameterException, ParameterException, ApplicationException {
		traceLog.traceFinest("Start queryDUFFileName method");
		QueryDUFFileNameResult queryDUFFileNameResult = null;
		try {
			queryDUFFileNameResult = queryDUFFileNameDao.getQueryDUFFileName(integratorContext, accountNum, eventSeq,
					eventTypeIDNbl, ratedDtmNbl);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		return queryDUFFileNameResult;
	}

	public QueryInvoiceDetailsOutPutElements queryInvoiceSectionDetails(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String invoiceNumber, com.convergys.custom.geneva.j2ee.billingProfile.Pagination pagination,
			com.convergys.custom.geneva.j2ee.billingProfile.InvoiceSummaryKey invoiceSummaryKey)
			throws NullParameterException, ParameterException, ApplicationException {

		traceLog.traceFinest("Start BillingProfilePojo queryInvoiceSectionDetails method");
		QueryInvoiceDetailsOutPutElements queryInvoiceDetailsOutPutElements = null;
		try {
			queryInvoiceDetailsOutPutElements = queryInvoiceSectionDetailsDao
					.queryInvoiceSectionDetails(integratorContext, invoiceNumber, pagination, invoiceSummaryKey);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo queryInvoiceSectionDetails method");
		return queryInvoiceDetailsOutPutElements;

	}

	public QueryCDROutputs queryCDRData(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String accountNum, java.lang.String eventSource, int eventTypeID, int appliedBill,
			java.lang.String optionalInputString,
			com.convergys.custom.geneva.j2ee.billingProfile.FilterArrayElements[] filterArray,
			com.convergys.custom.geneva.j2ee.billingProfile.SortingArrayElements[] sortArray,
			com.convergys.custom.geneva.j2ee.billingProfile.CDRDetailsKey cdrDetailsKey,
			com.convergys.custom.geneva.j2ee.billingProfile.Pagination pagination)
			throws NullParameterException, ParameterException, ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo queryCDRData method");
		QueryCDROutputs results = new QueryCDROutputs();
		try {
			results = queryCDRDataDao.queryCDRData(integratorContext, accountNum, eventSource, eventTypeID, appliedBill,
					optionalInputString, filterArray, sortArray, cdrDetailsKey, pagination);

		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		return results;

	}

	public QueryLineItemDetailsResult queryLineItemDetails(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String invoiceNumber,
			com.convergys.custom.geneva.j2ee.billingProfile.FilterArrayElements[] filterArray,
			com.convergys.custom.geneva.j2ee.billingProfile.SortingArrayElements[] sortArray,
			com.convergys.custom.geneva.j2ee.billingProfile.InvoiceLineItemDetailsKey invoiceLineItemDetailsKey,
			com.convergys.custom.geneva.j2ee.billingProfile.Pagination pagination)
			throws NullParameterException, ParameterException, ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo queryLineItemDetails method");
		QueryLineItemDetailsResult QueryLineItemDetailsResult = new QueryLineItemDetailsResult();
		try {
			QueryLineItemDetailsResult = queryLineItemDetailsDao.queryLineItemDetails(integratorContext, invoiceNumber,
					filterArray, sortArray, invoiceLineItemDetailsKey, pagination);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo queryLineItemDetails method");
		return QueryLineItemDetailsResult;
	}

	public String sendInvoiceByEmail(
			com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
			java.lang.String emailAddress, java.lang.String invoiceNumber)
			throws NullParameterException, ParameterException, ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo sendInvoiceByEmail method");
		String emailStatus = null;
		try {
			emailStatus = sendInvoiceByEmailDao.sendInvoiceByMail(integratorContext, invoiceNumber, emailAddress);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo sendInvoiceByEmail method");
		return emailStatus;
	}
	
	public CDRDetailsResult[] queryCDRDetails(
            com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
            java.lang.String customerReference, java.lang.String eventSource,
            java.lang.String eventType, long startDtm, long endDtmNbl)
            throws com.convergys.iml.commonIML.NullParameterException,
            com.convergys.iml.commonIML.ParameterException,
            com.convergys.platform.ApplicationException {
        traceLog.traceFinest("Entered into BillingProfilePojo queryCDRDetails API");

        CDRDetailsResult cdrDetailsResult[];
        try {
            cdrDetailsResult = queryCDRDetailsDao.queryCDRDetails(integratorContext,
                    customerReference, eventSource, eventType, startDtm, endDtmNbl);
        } catch (Exception e) {
            throw new ApplicationException(e.getMessage());
        }
        traceLog.traceFinest("End BillingProfilePojo queryCDRDetails API");
        return cdrDetailsResult;
    }
	
	public com.convergys.custom.geneva.j2ee.billingProfile.ContactResultElements
	  queryPartnerContactDetails
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    java.lang.String customerRef,
	    long whenDtmNbl
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo queryPartnerContactDetails method");
		ContactResultElements contactResult = null;
		try {
			contactResult = queryPartnerContactDetailsDao.getPartnerContactDetails(integratorContext, customerRef, whenDtmNbl);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo queryPartnerContactDetails method");
		return contactResult;
	}	
	public java.lang.String
	  deletePartnerUSTaxExemption
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    java.lang.String customerRef,
	    java.lang.String exemptionType
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException {
		traceLog.traceFinest("Start BillingProfilePojo deletePartnerUSTaxExemption method");
		String status = null;
		try {
			status = deletePartnerUSTaxExemptionDao.deletePartnerUSTaxExemption(integratorContext, customerRef, exemptionType);
			
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo deletePartnerUSTaxExemption method");
		return status;
		
		
	}
	public java.lang.String
	  createPaymentChannel
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    int paymentChannelId,
	    java.lang.String paymentChannelName,
	    int invoicingCoId
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException
	    {
		traceLog.traceFinest("Start BillingProfilePojo createPaymentChannel method"+paymentsDao);
		traceLog.traceFinest("Start BillingProfilePojo createPaymentChannel method");
		String status = null;
		try {
			if(paymentsDao!=null)
				traceLog.traceFinest("Start BillingProfilePojo createPaymentChannel method"+paymentsDao);	
			status = paymentsDao.createPaymentChannel(integratorContext,paymentChannelId,paymentChannelName,invoicingCoId);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo createPaymentChannel method");
		return status;
	    }
	
	public java.lang.String
	  modifyPaymentChannel
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    int paymentChannelId,
	    java.lang.String paymentChannelName
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException
	    {
		traceLog.traceFinest("Start BillingProfilePojo modifyPaymentChannel method");
		String status = null;
		try {
			status = paymentsDao.modifyPaymentChannel(integratorContext, paymentChannelId, paymentChannelName);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo modifyPaymentChannel method");
		return status;
	    }
		
	 public com.convergys.custom.geneva.j2ee.billingProfile.AdjustmentResult_2
	  createAdjustment_2
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    com.convergys.geneva.j2ee.account.AccountPK accountPK,
	    long adjustmentDateNbl,
	    java.lang.String adjustmentTypeId,
	    java.lang.String adjustmentText,
	    long adjustmentMny,
	    int budgetCentreSeqNblNbl,
	    java.lang.Boolean requestCreditNote,
	    long createdDtmNbl,
	    int contractedPointOfSupplyId,
	    java.lang.String createdByUser,
	    java.lang.String wpsInfo
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException{
		traceLog.traceFinest("Start BillingProfilePojo createAdjustment_2 method");
		AdjustmentResult_2 adjustmentResult = new AdjustmentResult_2();

		try {
			adjustmentResult = createAdjustmentDao.createAdjustment_2(integratorContext, accountPK, adjustmentDateNbl,
					adjustmentTypeId, adjustmentText, adjustmentMny, budgetCentreSeqNblNbl, requestCreditNote,
					createdDtmNbl, contractedPointOfSupplyId, createdByUser, wpsInfo);
		} catch (Exception e) {
			throw new ApplicationException(e.getMessage());
		}
		traceLog.traceFinest("End BillingProfilePojo createAdjustment_2 method");
		return adjustmentResult;
	}	
	 public com.convergys.custom.geneva.j2ee.billingProfile.AddTaxExemptionOutputElements
	  addPartnerUSTaxExemption
	  (
	    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
	    java.lang.String customerRef,
	    long startDate,
	    long endDateNbl,
	    java.lang.String exemptionType,
	    java.lang.String createdByUser
	  )
	  throws     com.convergys.iml.commonIML.NullParameterException,
	    com.convergys.iml.commonIML.ParameterException,
	    com.convergys.platform.ApplicationException
	    {
		 traceLog.traceFinest("Start BillingProfilePojo addPartnerUSTaxExemption method");
		 AddTaxExemptionOutputElements addTaxExemptionResult = null;
			try {
				addTaxExemptionResult = addPartnerUSTaxExemptionDao.addPartnerUSTaxExemption(integratorContext, customerRef, startDate,endDateNbl,exemptionType,createdByUser);
			}
		 	catch (Exception e) {
				throw new ApplicationException(e.getMessage());
			}
			traceLog.traceFinest("End BillingProfilePojo addPartnerUSTaxExemption method");
			
			return addTaxExemptionResult;
		 
	    }
	 
	 public com.convergys.custom.geneva.j2ee.billingProfile.CreateCustomerAndAccountOutputElements
  createCustomerAndAccount
  (
    com.convergys.custom.geneva.j2ee.billingProfile.IntegratorContext integratorContext,
    com.convergys.custom.geneva.j2ee.billingProfile.NewCustomerAndAccountData newCustomerAndAccountData,
    com.convergys.custom.geneva.j2ee.billingProfile.NewAddress newAddress,
    com.convergys.custom.geneva.j2ee.billingProfile.AccountAttributes accountAttributes,
    com.convergys.custom.geneva.j2ee.billingProfile.NewCustomData [] newCustomDataArray
  )
  throws     com.convergys.iml.commonIML.NullParameterException,
    com.convergys.iml.commonIML.ParameterException,
    com.convergys.platform.ApplicationException {
		 
		 traceLog.traceFinest("Start BillingProfilePojo CreateCustomerAndAccountOutputElements method");
		 CreateCustomerAndAccountOutputElements createCustomerAndAccountResult= null;
			try {
				
				createCustomerAndAccountResult = createCustomerAndAccountDao.createCustomerAndAccount(integratorContext, newCustomerAndAccountData, newAddress,accountAttributes,newCustomDataArray);
				
			}
		 	catch (Exception e) {
		 		traceLog.traceFinest("errored BillingProfilePojo CreateCustomerAndAccountOutputElements method" + e.getMessage());
				throw new ApplicationException(e.getMessage());
			}
			traceLog.traceFinest("End BillingProfilePojo CreateCustomerAndAccountOutputElements method");
			
			return createCustomerAndAccountResult;
		 
	 }
	 
	
	
	public QueryInvoiceSummaryDataDao getQueryInvoiceSummaryDataDao() {
		return queryInvoiceSummaryDataDao;
	}

	public void setQueryInvoiceSummaryDataDao(QueryInvoiceSummaryDataDao queryInvoiceSummaryDataDao) {
		this.queryInvoiceSummaryDataDao = queryInvoiceSummaryDataDao;
	}

	public QueryInvoiceSectionDetailsDao getQueryInvoiceSectionDetailsDao() {
		return queryInvoiceSectionDetailsDao;
	}

	public void setQueryInvoiceSectionDetailsDao(QueryInvoiceSectionDetailsDao queryInvoiceSectionDetailsDao) {
		this.queryInvoiceSectionDetailsDao = queryInvoiceSectionDetailsDao;
	}

	public QueryLineItemDetailsDao getQueryLineItemDetailsDao() {
		return queryLineItemDetailsDao;
	}

	public void setQueryLineItemDetailsDao(QueryLineItemDetailsDao queryLineItemDetailsDao) {
		this.queryLineItemDetailsDao = queryLineItemDetailsDao;
	}

	public QueryCDRDataDao getQueryCDRDataDao() {
		return queryCDRDataDao;
	}

	public void setQueryCDRDataDao(QueryCDRDataDao queryCDRDataDao) {
		this.queryCDRDataDao = queryCDRDataDao;
	}

	public QueryPatnerBillingandFinanceDataDao getQueryPatnerBillingandFinanceDataDao() {
		return queryPatnerBillingandFinanceDataDao;
	}

	public void setQueryPatnerBillingandFinanceDataDao(
			QueryPatnerBillingandFinanceDataDao queryPatnerBillingandFinanceDataDao) {
		this.queryPatnerBillingandFinanceDataDao = queryPatnerBillingandFinanceDataDao;
	}

	public QueryLastRatedUsageDtmByTypeDao getQueryLastRatedUsageDtmByTypeDao() {
		return queryLastRatedUsageDtmByTypeDao;
	}

	public void setQueryLastRatedUsageDtmByTypeDao(QueryLastRatedUsageDtmByTypeDao queryLastRatedUsageDtmByTypeDao) {
		this.queryLastRatedUsageDtmByTypeDao = queryLastRatedUsageDtmByTypeDao;
	}

	public QueryDUFFileNameDao getQueryDUFFileNameDao() {
		return queryDUFFileNameDao;
	}

	public void setQueryDUFFileNameDao(QueryDUFFileNameDao queryDUFFileNameDao) {
		this.queryDUFFileNameDao = queryDUFFileNameDao;
	}

	public UpdateBillingProfileDao getUpdateBillingProfileDao() {
		return updateBillingProfileDao;
	}

	public void setUpdateBillingProfileDao(UpdateBillingProfileDao updateBillingProfileDao) {
		this.updateBillingProfileDao = updateBillingProfileDao;
	}

	public CreateBillingProfileDao getCreateBillingProfileDao() {
		return createBillingProfileDao;
	}

	public void setCreateBillingProfileDao(CreateBillingProfileDao createBillingProfileDao) {
		this.createBillingProfileDao = createBillingProfileDao;
	}

	public CreateBulkRequestDao getCreateBulkRequestDao() {
		return createBulkRequestDao;
	}

	public void setCreateBulkRequestDao(CreateBulkRequestDao createBulkRequestDao) {
		this.createBulkRequestDao = createBulkRequestDao;
	}
	public GetBulkReqDao getGetBulkReqDao() {
		return getBulkReqDao;
	}

	public void setGetBulkReqDao(GetBulkReqDao getBulkReqDao) {
		this.getBulkReqDao = getBulkReqDao;
	}

	public CancelAdjustmentDao getCancelAdjustmentDao() {
		return cancelAdjustmentDao;
	}

	public void setCancelAdjustmentDao(CancelAdjustmentDao cancelAdjustmentDao) {
		this.cancelAdjustmentDao = cancelAdjustmentDao;
	}

	public SendInvoiceByEmailDao getSendInvoiceByEmailDao() {
		return sendInvoiceByEmailDao;
	}

	public void setSendInvoiceByEmailDao(SendInvoiceByEmailDao sendInvoiceByEmailDao) {
		this.sendInvoiceByEmailDao = sendInvoiceByEmailDao;
	}

	public CancelPaymentsDao getCancelPaymentsDao() {
		return cancelPaymentsDao;
	}

	public void setCancelPaymentsDao(CancelPaymentsDao cancelPaymentsDao) {
		this.cancelPaymentsDao = cancelPaymentsDao;
	}

	public CreateAccountPaymentsDao getCreateAccountPaymentsDao() {
		return createAccountPaymentsDao;
	}

	public void setCreateAccountPaymentsDao(CreateAccountPaymentsDao createAccountPaymentsDao) {
		this.createAccountPaymentsDao = createAccountPaymentsDao;
	}

	public CreateAdjustmentDao getCreateAdjustmentDao() {
		return createAdjustmentDao;
	}

	public void setCreateAdjustmentDao(CreateAdjustmentDao createAdjustmentDao) {
		this.createAdjustmentDao = createAdjustmentDao;
	}
	public QueryCDRDetailsDao getQueryCDRDetailsDao() {
		return queryCDRDetailsDao;
	}

	public void setQueryCDRDetailsDao(QueryCDRDetailsDao queryCDRDetailsDao) {
		this.queryCDRDetailsDao = queryCDRDetailsDao;
	}
	
	public QueryPartnerContactDetailsDao getQueryPartnerContactDetailsDao() {
		return queryPartnerContactDetailsDao;
	}

	public void setQueryPartnerContactDetailsDao(QueryPartnerContactDetailsDao queryPartnerContactDetailsDao) {
		this.queryPartnerContactDetailsDao = queryPartnerContactDetailsDao;
	}

   public PaymentsDao getPaymentsDao() {
        return paymentsDao;
    }
    public void setPaymentsDao(PaymentsDao paymentsDao) {
        this.paymentsDao = paymentsDao;
    }

    public DeletePartnerUSTaxExemptionDao deletePartnerUSTaxExemptionDao() {
        return deletePartnerUSTaxExemptionDao;
    }
    public void setDeletePartnerUSTaxExemptionDao(DeletePartnerUSTaxExemptionDao deletePartnerUSTaxExemptionDao) {
        this.deletePartnerUSTaxExemptionDao = deletePartnerUSTaxExemptionDao;
    }    
	public AddPartnerUSTaxExemptionDao getAddPartnerUSTaxExemptionDao() {
		return addPartnerUSTaxExemptionDao;
	}
	public void setAddPartnerUSTaxExemptionDao(AddPartnerUSTaxExemptionDao addPartnerUSTaxExemptionDao) {
		this.addPartnerUSTaxExemptionDao = addPartnerUSTaxExemptionDao;
	}
	public CreateCustomerAndAccountDao getCreateCustomerAndAccountDao() {
		return createCustomerAndAccountDao;
	}
	public void setCreateCustomerAndAccountDao(CreateCustomerAndAccountDao createCustomerAndAccountDao) {
		this.createCustomerAndAccountDao = createCustomerAndAccountDao;
	}


}
