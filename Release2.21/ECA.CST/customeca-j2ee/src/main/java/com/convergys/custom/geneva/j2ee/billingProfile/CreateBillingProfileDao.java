package com.convergys.custom.geneva.j2ee.billingProfile;

import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.geneva.j2ee.account.AccountPK;
import com.convergys.geneva.j2ee.billingTariff.BillingTariffPK;
import com.convergys.geneva.j2ee.eventSource.ModifyEventSourceData_6;
import com.convergys.geneva.j2ee.product.ProductAttrPK;
import com.convergys.geneva.j2ee.product.ProductPK;
import com.convergys.geneva.j2ee.productInstance.CreateSuperProductSubscriptionAndPackageInstanceResult_1;
import com.convergys.geneva.j2ee.productInstance.NewProductInstanceData_6;
import com.convergys.geneva.j2ee.productInstance.NewProductInstanceEventTypeData_6;
import com.convergys.geneva.j2ee.productInstance.NewSuperProductInstanceData_1;
import com.convergys.geneva.j2ee.productInstance.NewSuperProductSubscriptionAndPackageInstanceData_1;
import com.convergys.geneva.j2ee.productInstance.r5_1.NewProductInstanceAttrData;
import com.convergys.geneva.j2ee.ratingTariff.RatingTariffPK;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.iml.commonIML.ParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class CreateBillingProfileDao {

	private static TraceLog traceLog = new TraceLog(CreateBillingProfileDao.class);
	private Util util;

	/* ProductInstanceService productInstanceService = null; */

	/**
	 * This API will create the subscriber profile in RB as follows: 1.� Create
	 * base product instance 2.� Assign the price plan while creating the base
	 * product instance 3.� Create product attributes for the base product
	 * instance 4.� Create event sources for all usage types under the base
	 * product using rate plans 5.� Create the new child products instances for
	 * Voice/Messaging/Data 6.� Create the product attribute for child product
	 * 7.� Create grandchild product under child voice, messaging, data products
	 * 8.� Create the product attributes for the grandchild products
	 * 
	 ******************************************* @param integratorContext
	 * @param accountNum
	 * @param newSuperProductInstanceData
	 * @return CreateSuperProductSubscriptionAndPackageInstanceResult_1
	 * @throws java.rmi.RemoteException
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * @throws SQLException
	 */
	@SuppressWarnings("deprecation")
	public com.convergys.custom.geneva.j2ee.billingProfile.ParentChildProductInstanceData[] createBillingProfile(
			IntegratorContext integratorContext, String accountNum,
			NewProductInstancesData[] newSuperProductInstanceData) throws Exception {

		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();

		if (traceLog.isFinerEnabled()) {
			traceLog.traceFiner("Entered into createBillingProfile API...startTime.. " + startTime);
		}

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("Entered into createBillingProfile API");
		}

		// Check Validation for Mandatory Params and throw Exception
		if (integratorContext == null || integratorContext.equals("")) {

			throw new NullParameterException(ErrorCodes.ERR_RBM_1001, Constants.CREATE_API_NAME);
		}
		///////////////////////////////////////////
		if (integratorContext.getExternalAPICallId() != null && !integratorContext.getExternalAPICallId().isEmpty()) {
			traceLog.traceFinest(
					"integratorContext.getExternalAPICallId() " + integratorContext.getExternalAPICallId());
			integratorContext.setExternalAPICallId(null);
			traceLog.traceFinest(
					"integratorContext.getExternalAPICallId() " + integratorContext.getExternalAPICallId());
		}
		////////////////////////////////////////////
		if (integratorContext.getExternalBusinessTransactionId() == null
				|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.CREATE_API_NAME);
		}
		if (newSuperProductInstanceData == null || newSuperProductInstanceData.length <= 0) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1003, Constants.CREATE_API_NAME);
		}
		if (accountNum == null || accountNum.trim().equals("")) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1005, Constants.CREATE_API_NAME);
		}

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("In createBillingProfile API after validating the input params");
		}

		// Customer Ref for logging
		String customerRef = null;
		String eventSource = null;
		// accountPk
		AccountPK accountPK = new AccountPK();
		accountPK.setAccountNum(accountNum);
		DataSource das = null;
		CreateBillingProfileInput createBillingProfileInput = new CreateBillingProfileInput();
		CreateBillingProfileOutput createBillingProfileOutput = new CreateBillingProfileOutput();
		createBillingProfileInput.setIntegratorContext(integratorContext);
		createBillingProfileInput.setAccountNum(accountPK.getAccountNum());

		if (newSuperProductInstanceData != null && newSuperProductInstanceData.length > 0) {
			createBillingProfileInput.setNewProductInstancesData(newSuperProductInstanceData);
		}

		// the core ECA requires array of
		// NewSuperProductSubscriptionAndPackageInstanceData_1
		NewSuperProductSubscriptionAndPackageInstanceData_1[] newSuperProductSubscriptionAndPackageInstanceData = new NewSuperProductSubscriptionAndPackageInstanceData_1[1];
		NewSuperProductSubscriptionAndPackageInstanceData_1 nSPSP = new NewSuperProductSubscriptionAndPackageInstanceData_1();

		// Result
		CreateSuperProductSubscriptionAndPackageInstanceResult_1 result = new CreateSuperProductSubscriptionAndPackageInstanceResult_1();
		ArrayList<ParentChildProductInstanceData> productsResultList = new ArrayList<ParentChildProductInstanceData>();
		ParentChildProductInstanceData parentChildProductInstanceResult = new ParentChildProductInstanceData();
		com.convergys.custom.geneva.j2ee.billingProfile.ParentChildProductInstanceData[] productsResultArray = null;
		// Setting to Core IntegratorContext_1
		IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
		integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
		integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
		integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
		integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());

		String responseStatus = null;
		try {
			das = util.getDataSource();

			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest(" In createBillingProfile newSuperProductInstanceData length :"
						+ newSuperProductInstanceData.length);
			}
			NewSuperProductInstanceData_1[] newSuperProductInstanceDataArray = new NewSuperProductInstanceData_1[1];
			if (newSuperProductInstanceData != null && newSuperProductInstanceData.length > 0) {
				int baseProductId = 0;
				int childCounter = 0;
				int childProductId = 0;
				int childArrayCounter = 0;

				for (NewProductInstancesData newProductInstanceData : newSuperProductInstanceData) {

					if (newProductInstanceData.getParentProductId() == newProductInstanceData.getProductId()) {
						baseProductId = newProductInstanceData.getProductId();
					}
					if (!(newProductInstanceData.getParentProductId() == newProductInstanceData.getProductId())) {
						if (newProductInstanceData.getParentProductId() == baseProductId) {
							childProductId = newProductInstanceData.getProductId();
							childArrayCounter++;
						}
					}
				}

				NewSuperProductInstanceData_1 hierarchyProductInstanceData = new NewSuperProductInstanceData_1();
				NewSuperProductInstanceData_1[] childProductInstanceArray = new NewSuperProductInstanceData_1[childArrayCounter];
				NewProductInstanceData_6 newChildProductInstanceData_6 = null;
				NewSuperProductInstanceData_1 childProductInstanceData = null;
				NewProductInstanceData_6 newProductInstanceData_6 = null;

				for (NewProductInstancesData newProductInstanceData : newSuperProductInstanceData) {

					if (newProductInstanceData.getParentProductId() == newProductInstanceData.getProductId()) {
						newProductInstanceData_6 = new NewProductInstanceData_6();
						newProductInstanceData_6 = getBaseProductData(newProductInstanceData, newProductInstanceData_6);

						// baseProductId =
						// newProductInstanceData.getProductId();
						// Base Product Attributes
						NewProductInstanceAttrData[] baseProductAttributeArray = getBaseProductInstanceAttributesData(
								newProductInstanceData);
						newProductInstanceData_6.setProductInstanceAttrs(baseProductAttributeArray);
						// Base Product Event Source
						ModifyEventSourceData_6[] eventSourceDataArray = getBaseProductEventSourceDataArray(
								newProductInstanceData);
						// Event Source for logging
						NewProductInstanceEventTypeData_6[] newProductInstanceEventTypeData_6 = getProductInstanceEventTypeData(
								newProductInstanceData);
						if (eventSourceDataArray != null && eventSourceDataArray.length > 0) {
							eventSource = eventSourceDataArray[0].getEventSourceText();
						}
						newProductInstanceData_6.setNewEventSources(eventSourceDataArray);
						newProductInstanceData_6.setNewEventTypes(newProductInstanceEventTypeData_6);
					}
					// Child Product
					if (!(newProductInstanceData.getParentProductId() == newProductInstanceData.getProductId())) {
						if (newProductInstanceData.getParentProductId() == baseProductId) {
							childProductId = newProductInstanceData.getProductId();
							newChildProductInstanceData_6 = new NewProductInstanceData_6();
							newChildProductInstanceData_6 = getchildProductData(newProductInstanceData,
									newChildProductInstanceData_6);
							childCounter++;
							traceLog.traceFinest("--In Child Structure--ParentProductId: "
									+ newProductInstanceData.getParentProductId() + " childProductId:" + childProductId
									+ " baseProductId:" + baseProductId);
							// Child Product Attributes
							NewProductInstanceAttrData[] childProductAttributeArray = getChildProductInstanceAttributesData(
									newProductInstanceData);
							childProductInstanceData = new NewSuperProductInstanceData_1();
							newChildProductInstanceData_6.setProductInstanceAttrs(childProductAttributeArray);
							childProductInstanceData.setNewProductInstanceData(newChildProductInstanceData_6);
							childProductInstanceArray[childCounter - 1] = childProductInstanceData;
						}
					}

				}

				hierarchyProductInstanceData.setNewChildProductInstanceDataArray(childProductInstanceArray);
				hierarchyProductInstanceData.setNewProductInstanceData(newProductInstanceData_6);
				newSuperProductInstanceDataArray[0] = hierarchyProductInstanceData;
			}
			nSPSP.setNewSuperProductInstanceDataArray(newSuperProductInstanceDataArray);
			newSuperProductSubscriptionAndPackageInstanceData[0] = nSPSP;

			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest(
						"In createBillingProfile calling core ECA createSuperProductSubscriptionAndPackageInstance_1");
			}
			// call the core ECA to create and activate the new product instance
			result = util.getProductInstanceService().createSuperProductSubscriptionAndPackageInstance_1(
					integratorContext_1, accountPK, newSuperProductSubscriptionAndPackageInstanceData);
			responseStatus = Constants.TRANSACTION_SUCCESS;
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest(
						"In createBillingProfile after calling core ECA createSuperProductSubscriptionAndPackageInstance_1");
			}

			for (int i = 0; i < result.getParentChildProductInstancePKData().length; i++) {
				// --for logging purpose--
				if (customerRef == null) {
					customerRef = result.getParentChildProductInstancePKData()[i].getParentProductInstancePK()
							.getCustomerRef();
				}
				// --end of logging purpose--
				parentChildProductInstanceResult.setParentProductInstancePK(
						result.getParentChildProductInstancePKData()[i].getParentProductInstancePK());
				parentChildProductInstanceResult.setChildProductInstancePKData(
						result.getParentChildProductInstancePKData()[i].getChildProductInstancePKData());
				productsResultList.add(parentChildProductInstanceResult);
				/*
				 * logger.debug("ProductSeq seq is " +
				 * result.getParentChildProductInstancePKData()[i]
				 * .getParentProductInstancePK().getProductSeq());
				 */
			}
			productsResultArray = new ParentChildProductInstanceData[productsResultList.size()];
			productsResultArray = (ParentChildProductInstanceData[]) productsResultList.toArray(productsResultArray);

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after createBillingProfile.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of createBillingProfile is " + diff + "........." + diffStr);

		} catch (Exception ae) {
			ae.printStackTrace();
			responseStatus = ae.getMessage();

			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, customerRef, eventSource,
					createBillingProfileInput, createBillingProfileOutput, responseStatus, Constants.CREATE_API_NAME,
					das, diffStr, node);
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest("Error calling CORE ECA createSuperProductSubscriptionAndPackageInstance_1:" + ae);
			}
			throw new ApplicationException(ae.getMessage());
		}
		if (Constants.TRANSACTION_SUCCESS.equals(responseStatus)) {
			createBillingProfileOutput.setParentChildProductInstanceData(productsResultArray);
		}
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, customerRef, eventSource,
				createBillingProfileInput, createBillingProfileOutput, responseStatus, Constants.CREATE_API_NAME, das,
				diffStr, node);
		return productsResultArray;
	}

	private NewProductInstanceData_6 getBaseProductData(NewProductInstancesData newProductInstanceData,
			NewProductInstanceData_6 newProductInstanceData_6) {
		ProductPK productPK = new ProductPK();
		productPK.setProductId(newProductInstanceData.getProductId());
		BillingTariffPK billingTariffPK = new BillingTariffPK();
		billingTariffPK.setBillingTariffId(newProductInstanceData.getBillingTariffId());
		newProductInstanceData_6.setProductQuantity(1);
		newProductInstanceData_6.setProductStatus(0);
		newProductInstanceData_6.setContractedPointOfSupplyId(1);
		newProductInstanceData_6.setBillingTariffPK(billingTariffPK);
		newProductInstanceData_6.setProductPK(productPK);
		newProductInstanceData_6.setStartDtm(newProductInstanceData.getProductStartDtm());
		newProductInstanceData_6.setEndDtmNbl(newProductInstanceData.getProductEndDtmNbl());
		return newProductInstanceData_6;

	}

	private ModifyEventSourceData_6[] getBaseProductEventSourceDataArray(
			NewProductInstancesData newProductInstanceData) {
		EventSource[] eventSourceArr = newProductInstanceData.getEventSourceArray();
		ArrayList<ModifyEventSourceData_6> eventSourceList = new ArrayList<ModifyEventSourceData_6>();
		ModifyEventSourceData_6[] eventSourceDataArray = null;
		if (eventSourceArr != null && eventSourceArr.length > 0) {
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest("In Base inside EventSourceDataArray");
			}
			for (EventSource newBaseProducteventSourceArrData : eventSourceArr) {
				RatingTariffPK ratingTariffPK = new RatingTariffPK();
				ratingTariffPK.setRatingTariffId(newBaseProducteventSourceArrData.getRatingTariffID());
				ModifyEventSourceData_6 modifyEventSourceData = new ModifyEventSourceData_6();
				modifyEventSourceData.setEventSource(newBaseProducteventSourceArrData.getEventSourceName());
				modifyEventSourceData.setEventTypeId(newBaseProducteventSourceArrData.getEventTypeID());
				modifyEventSourceData.setRatingTariffPK(ratingTariffPK);
				modifyEventSourceData.setEventSourceText(newBaseProducteventSourceArrData.getEventSourceText());

				modifyEventSourceData.setStartDtm(newBaseProducteventSourceArrData.getStartDtm());
				modifyEventSourceData.setEndDtmNbl(newBaseProducteventSourceArrData.getEndDtmNbl());
				modifyEventSourceData.setEventSourceLabel(newBaseProducteventSourceArrData.getEventSourceName());
				modifyEventSourceData.setCopyGuidingRules(false);
				eventSourceList.add(modifyEventSourceData);
			}
			if (eventSourceList != null && eventSourceList.size() > 0) {
				eventSourceDataArray = eventSourceList.toArray(new ModifyEventSourceData_6[eventSourceList.size()]);

			}
		}
		return eventSourceDataArray;
	}

	private NewProductInstanceAttrData[] getBaseProductInstanceAttributesData(
			NewProductInstancesData newProductInstanceData) throws Exception {

		NewProductInstanceAttributesData[] newProductInstanceAttributesData = newProductInstanceData
				.getNewProductInstanceAttributesArray();
		NewProductInstanceAttrData[] productAttributeArray = null;
		ArrayList<NewProductInstanceAttrData> newProductInstanceAttrList = new ArrayList<NewProductInstanceAttrData>();
		boolean tomsKeyBoo = false;
		if (newProductInstanceAttributesData == null || newProductInstanceAttributesData.length <= 0) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1013, Constants.CREATE_API_NAME);
		}
		if (newProductInstanceAttributesData != null && newProductInstanceAttributesData.length > 0) {
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest("In Base inside newProductInstanceAttributesData");
			}
			for (NewProductInstanceAttributesData newBaseProductInstanceAttributesData : newProductInstanceAttributesData) {
				traceLog.traceFinest("In Base inside newProductInstanceAttributesData getProductAttributeName:"
						+ newBaseProductInstanceAttributesData.getProductAttributeName());
				if (newBaseProductInstanceAttributesData.getProductAttributeName() == null
						|| newBaseProductInstanceAttributesData.getProductAttributeName().equals("")) {
					throw new ApplicationException(ErrorCodes.ERR_RBM_1009);
				}

				if (Constants.TomsKey.equals(newBaseProductInstanceAttributesData.getProductAttributeName())) {
					tomsKeyBoo = true;
					traceLog.traceFinest("tomsKeyBoo:" + tomsKeyBoo);

				}
			}
			if (!tomsKeyBoo) {
				throw new ApplicationException(ErrorCodes.ERR_RBM_1004);
			}

			for (NewProductInstanceAttributesData newBaseProductInstanceAttributesData : newProductInstanceAttributesData) {
				
				/*if((newBaseProductInstanceAttributesData.getAttributeValue().trim().equalsIgnoreCase("NONE") ||  newBaseProductInstanceAttributesData.getAttributeValue().trim().isEmpty() )
						&& newBaseProductInstanceAttributesData.getProductAttributeName().equalsIgnoreCase("SUBSCRIBER_TYPE")){
				}else{*/
					ProductAttrPK productAttrPK = new ProductAttrPK();
					NewProductInstanceAttrData productAttributeData = new NewProductInstanceAttrData();
	
					productAttrPK.setProductId(newProductInstanceData.getProductId());
	
					int productAttrSubId = util.getProductAttrSubId(newProductInstanceData.getProductId(),
							newBaseProductInstanceAttributesData.getProductAttributeName());
	
					productAttrPK.setProductAttrSubId(productAttrSubId);
					if(newBaseProductInstanceAttributesData.getAttributeValue().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE_VALUE) && newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE)){
						productAttributeData.setAttributeValue(null);
				    } else if (newBaseProductInstanceAttributesData.getAttributeValue().trim().startsWith(Constants.LAST_TERM_RENEWAL_DATE_VALUE) && newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE)){
				    	productAttributeData.setAttributeValue(null);
				    } else if (newBaseProductInstanceAttributesData.getAttributeValue().trim().startsWith(Constants.LAST_RENEWAL_DATE_VALUE) && newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE)){
				    	productAttributeData.setAttributeValue(null);
				    }else if (newBaseProductInstanceAttributesData.getAttributeValue().trim().startsWith(Constants.TERM_EXPIRATION_DATE_VALUE) && newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE)){
				    	productAttributeData.setAttributeValue(null);
				    }else if (newBaseProductInstanceAttributesData.getAttributeValue().trim().equalsIgnoreCase(Constants.PLAN_NAME_VALUE) && newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.PLAN_NAME)){
				    	productAttributeData.setAttributeValue(null);
				    }else if (newBaseProductInstanceAttributesData.getAttributeValue().trim().equalsIgnoreCase(Constants.TERM_LENGTH_VALUE) && newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_LENGTH)){
				    	productAttributeData.setAttributeValue(null);
				    }
				    else
				    {  
				    if(newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE) || newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE)
						 || newBaseProductInstanceAttributesData.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE)) {
						 
						 productAttributeData.setAttributeValue(util.checkUTCOffSetValue(newBaseProductInstanceAttributesData.getAttributeValue()));
					 } else {
						  productAttributeData.setAttributeValue(newBaseProductInstanceAttributesData.getAttributeValue());
						 
					 }
					
				    }
					if(newBaseProductInstanceAttributesData.getProductAttributeName().equalsIgnoreCase("TOMS_TLO_OBJECT_ID")){
						traceLog.traceFinest("***INSIDE TLOS OBJECT ID *****CreateBillingProfile*********");
						productAttributeData.setStartDat(getCurrentDay(newProductInstanceData.getProductStartDtm()));
					}else{
						productAttributeData.setStartDat(newProductInstanceData.getProductStartDtm());
					}
					productAttributeData.setProductAttrPK(productAttrPK);
					newProductInstanceAttrList.add(productAttributeData);
				//}
			}
			if (newProductInstanceAttrList != null && newProductInstanceAttrList.size() > 0) {
				productAttributeArray = newProductInstanceAttrList
						.toArray(new NewProductInstanceAttrData[newProductInstanceAttrList.size()]);
			}
		}

		return productAttributeArray;
	}

	private NewProductInstanceEventTypeData_6[] getProductInstanceEventTypeData(
			NewProductInstancesData newProductInstanceData) {
		NewProductInstanceEventTypeData_6[] newProductInstanceEventTypeDataArray = null;
		EventSource[] eventSourceArr = newProductInstanceData.getEventSourceArray();
		ArrayList<NewProductInstanceEventTypeData_6> newProductInstanceEventTypeDataList = new ArrayList<NewProductInstanceEventTypeData_6>();
		if (eventSourceArr != null && eventSourceArr.length > 0) {
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest("In Base inside EventSourceDataArray");
			}
			for (EventSource newBaseProducteventSourceArrData : eventSourceArr) {
				RatingTariffPK ratingTariffPK = new RatingTariffPK();
				ratingTariffPK.setRatingTariffId(newBaseProducteventSourceArrData.getRatingTariffID());
				NewProductInstanceEventTypeData_6 newProductInstanceEventTypeData = new NewProductInstanceEventTypeData_6();
				newProductInstanceEventTypeData.setDefaultCmpRatingTariffPK(ratingTariffPK);
				newProductInstanceEventTypeData.setDefaultRatingTariffPK(ratingTariffPK);
				newProductInstanceEventTypeData.setEndDatNbl(newBaseProducteventSourceArrData.getEndDtmNbl());
				newProductInstanceEventTypeData.setEventTypeId(newBaseProducteventSourceArrData.getEventTypeID());
				newProductInstanceEventTypeData.setStartDat(newBaseProducteventSourceArrData.getStartDtm());
				newProductInstanceEventTypeDataList.add(newProductInstanceEventTypeData);
			}
			if (newProductInstanceEventTypeDataList != null && newProductInstanceEventTypeDataList.size() > 0) {
				newProductInstanceEventTypeDataArray = (NewProductInstanceEventTypeData_6[]) newProductInstanceEventTypeDataList
						.toArray(new NewProductInstanceEventTypeData_6[newProductInstanceEventTypeDataList.size()]);

			}
		}
		return newProductInstanceEventTypeDataArray;
	}

	private NewProductInstanceData_6 getchildProductData(NewProductInstancesData newProductInstanceData,
			NewProductInstanceData_6 newChildProductInstanceData_6) {
		BillingTariffPK billingTariffChildfPK = new BillingTariffPK();
		ProductPK productChildPK = new ProductPK();
		productChildPK.setProductId(newProductInstanceData.getProductId());
		billingTariffChildfPK.setBillingTariffId(newProductInstanceData.getBillingTariffId());
		newChildProductInstanceData_6.setBillingTariffPK(billingTariffChildfPK);
		newChildProductInstanceData_6.setProductQuantity(1);
		newChildProductInstanceData_6.setProductStatus(0);
		newChildProductInstanceData_6.setContractedPointOfSupplyId(1);
		newChildProductInstanceData_6.setProductPK(productChildPK);
		newChildProductInstanceData_6.setStartDtm(newProductInstanceData.getProductStartDtm());
		newChildProductInstanceData_6.setEndDtmNbl(newProductInstanceData.getProductEndDtmNbl());
		return newChildProductInstanceData_6;
	}

	private NewProductInstanceAttrData[] getChildProductInstanceAttributesData(
			NewProductInstancesData newProductInstanceData) throws Exception {
		NewProductInstanceAttributesData[] newChildProductInstanceAttributesData = newProductInstanceData
				.getNewProductInstanceAttributesArray();
		NewProductInstanceAttrData[] productChildAttributeArray = null;
		ArrayList<NewProductInstanceAttrData> newChildProductInstanceAttrList = new ArrayList<NewProductInstanceAttrData>();
		boolean checkMandAttr1 = false;
		boolean checkMandAttr2 = false;
		if (newChildProductInstanceAttributesData == null || newChildProductInstanceAttributesData.length <= 0) {
			throw new NullParameterException(ErrorCodes.ERR_RBM_1013, Constants.CREATE_API_NAME);
		}
		if (newChildProductInstanceAttributesData != null && newChildProductInstanceAttributesData.length > 0) {

			for (NewProductInstanceAttributesData newChildProdAttrData : newChildProductInstanceAttributesData) {
				if ("TOMS_SVC_INSTANCE_ID".equals(newChildProdAttrData.getProductAttributeName()))

				{
					checkMandAttr1 = true;
				}

				if ("TOMS_SVC_COMP_INST_ID".equals(newChildProdAttrData.getProductAttributeName()))

				{
					checkMandAttr2 = true;
				}

			}
			if (!(checkMandAttr1 && checkMandAttr2)) {
				throw new ParameterException(ErrorCodes.ERR_RBM_1012, Constants.CREATE_API_NAME);
			}
			for (NewProductInstanceAttributesData newChildProdAttrData : newChildProductInstanceAttributesData) {
				NewProductInstanceAttrData productAttributeData = new NewProductInstanceAttrData();
				ProductAttrPK productAttrPK = new ProductAttrPK();
				productAttrPK.setProductId(newProductInstanceData.getProductId());
				if (newChildProdAttrData.getProductAttributeName() == null
						|| newChildProdAttrData.getProductAttributeName().equals("")) {
					throw new ApplicationException(ErrorCodes.ERR_RBM_1009);
				}
				int productAttrSubId = util.getProductAttrSubId(newProductInstanceData.getProductId(),
						newChildProdAttrData.getProductAttributeName());
				productAttrPK.setProductAttrSubId(productAttrSubId);
				
				 if(newChildProdAttrData.getAttributeValue().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE_VALUE) && newChildProdAttrData.getProductAttributeName().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE)){
					 productAttributeData.setAttributeValue(null);
				 } else if (newChildProdAttrData.getAttributeValue().trim().startsWith(Constants.LAST_TERM_RENEWAL_DATE_VALUE) && newChildProdAttrData.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE)){
					 productAttributeData.setAttributeValue(null);
				 } else if (newChildProdAttrData.getAttributeValue().trim().startsWith(Constants.LAST_RENEWAL_DATE_VALUE) && newChildProdAttrData.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE)){
					 productAttributeData.setAttributeValue(null);
				 }else if (newChildProdAttrData.getAttributeValue().trim().startsWith(Constants.TERM_EXPIRATION_DATE_VALUE) && newChildProdAttrData.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE)){
					 productAttributeData.setAttributeValue(null);
				 }else if (newChildProdAttrData.getAttributeValue().trim().equalsIgnoreCase(Constants.PLAN_NAME_VALUE) && newChildProdAttrData.getProductAttributeName().trim().equalsIgnoreCase(Constants.PLAN_NAME)){
					 productAttributeData.setAttributeValue(null);
				 }else if (newChildProdAttrData.getAttributeValue().trim().equalsIgnoreCase(Constants.TERM_LENGTH_VALUE) && newChildProdAttrData.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_LENGTH)){
					 productAttributeData.setAttributeValue(null);
				 }
				 else
				 {
					 productAttributeData.setAttributeValue(newChildProdAttrData.getAttributeValue());
				 }
				productAttributeData.setStartDat(newProductInstanceData.getProductStartDtm());
				productAttributeData.setProductAttrPK(productAttrPK);
				newChildProductInstanceAttrList.add(productAttributeData);

			}
			if (newChildProductInstanceAttrList != null && newChildProductInstanceAttrList.size() > 0) {
				productChildAttributeArray = newChildProductInstanceAttrList
						.toArray(new NewProductInstanceAttrData[newChildProductInstanceAttrList.size()]);
			}
		}

		return productChildAttributeArray;
	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}
	
	private long getCurrentDay(long startDtm) {
	       // long millisInDay = 60 * 60 * 24 * 1000;
	        long theDay = Null.LONG;
	        DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	        Date today = new Date(startDtm);

	        try {
	            Date todayWithZeroTime = formatter.parse(formatter.format(today));
	            theDay = todayWithZeroTime.getTime() ;

	            traceLog.traceFinest(" end date:" + new Date(theDay));

	        } catch (Exception e) {
	            traceLog.traceFinest(e.getMessage());
	        }
	        return theDay;
	    }
}
