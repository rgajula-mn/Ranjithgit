package com.convergys.custom.geneva.j2ee.billingProfile;

import java.rmi.RemoteException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Arrays;

import javax.sql.DataSource;

import com.convergys.custom.geneva.j2ee.util.BillingProfileErrorLog;
import com.convergys.custom.geneva.j2ee.util.Constants;
import com.convergys.custom.geneva.j2ee.util.ErrorCodes;
import com.convergys.custom.geneva.j2ee.util.SQLStatements;
import com.convergys.custom.geneva.j2ee.util.ServiceLocator;
import com.convergys.custom.geneva.j2ee.util.Util;
import com.convergys.geneva.j2ee.Null;
import com.convergys.geneva.j2ee.billingTariff.BillingTariffPK;
import com.convergys.geneva.j2ee.eventSource.EventSourceService;
import com.convergys.geneva.j2ee.eventSource.HistoriedEventSourceData_6;
import com.convergys.geneva.j2ee.eventSource.ModifyEventSourceDataPair_6;
import com.convergys.geneva.j2ee.eventSource.ModifyEventSourceData_6;
import com.convergys.geneva.j2ee.eventSource.QueryEventSourceResultElement_6;
import com.convergys.geneva.j2ee.eventSource.QueryEventSourceResult_6;
import com.convergys.geneva.j2ee.product.ProductAttrPK;
import com.convergys.geneva.j2ee.product.ProductPK;
import com.convergys.geneva.j2ee.productInstance.EnumProductStatus;
import com.convergys.geneva.j2ee.productInstance.ModifyHistoriedProductInstanceStatusPair_6;
import com.convergys.geneva.j2ee.productInstance.ModifyHistoriedProductInstanceStatus_6;
import com.convergys.geneva.j2ee.productInstance.NewProductInstanceData_9;
import com.convergys.geneva.j2ee.productInstance.ProductInstancePK;
import com.convergys.geneva.j2ee.productInstance.ProductInstanceService;
import com.convergys.geneva.j2ee.productInstance.r5_1.HistoriedProductInstanceAttrData;
import com.convergys.geneva.j2ee.productInstance.r5_1.HistoriedProductInstanceTariffData;
import com.convergys.geneva.j2ee.productInstance.r5_1.ModifyHistoriedProductInstanceAttrData;
import com.convergys.geneva.j2ee.productInstance.r5_1.NewProductInstanceAttrData;
import com.convergys.geneva.j2ee.productInstance.r5_1.ReadProductInstanceBillingTariffResult;
import com.convergys.geneva.j2ee.ratingTariff.RatingTariffPK;
import com.convergys.iml.commonIML.IntegratorContext_1;
import com.convergys.iml.commonIML.NullParameterException;
import com.convergys.iml.commonIML.ParameterException;
import com.convergys.logging.TraceLog;
import com.convergys.platform.ApplicationException;

public class UpdateBillingProfileDao {

	private static TraceLog traceLog = new TraceLog(UpdateBillingProfileDao.class);
	private Util util;
	private long gnvdate;

	

	/**
	 * updateBillingProfile will enable to Add,Modify,Terminate product
	 * instance,event source,attributes, price plan etc..
	 * 
	 * @param integratorContext
	 * @param customerRef
	 * @param msisdn
	 * @param modifyEventSourceData
	 * @param modifyProductInstanceData
	 * @return
	 * @throws java.rmi.RemoteException
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @throws com.convergys.platform.ApplicationException
	 */

	public java.lang.String updateBillingProfile(IntegratorContext integratorContext, java.lang.String customerRef,
			java.lang.String msisdn, ModifyEventSourceData[] modifyEventSourceData,
			ModifyProductInstanceData[] modifyProductInstanceData)
			throws java.rmi.RemoteException, com.convergys.iml.commonIML.NullParameterException,
			com.convergys.iml.commonIML.ParameterException, com.convergys.platform.ApplicationException {
		
		gnvdate=util.getGnvSystemDate().getTime();
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("GNVDATE_TIMESTAMP...."+gnvdate);
			traceLog.traceFinest("GNVDATE_DATE...."+util.getGnvSystemDate());
			
		}
		
		long startTime = Null.LONG;
		long endTime = Null.LONG;
		long diff = Null.LONG;
		String node = null;
		String diffStr = null;
		node = util.getHostName();
		startTime = System.currentTimeMillis();
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("Entered into updateBillingProfile API..startTime.." + startTime);
		}
		String updateStatus = null;
		EventSourceService eventSourceService = getEventSourceService();
		ProductInstanceService productInstanceService = util.getProductInstanceService();
		DataSource das = null;
		UpdateBillingProfileInput updateBillingProfileInput = null;
		UpdateBillingProfileOutput updateBillingProfileOutput = null;
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("Entered into updateBillingProfile API....");
		}
		String responseStatus = null;
		try {

			das = util.getDataSource();

			if (integratorContext == null || integratorContext.getExternalBusinessTransactionId() == null
					|| integratorContext.getExternalBusinessTransactionId().trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_1002, Constants.UPDATE_API_NAME);
			}

			///////////////////////////////////////////
			if (integratorContext.getExternalAPICallId() != null
					&& !integratorContext.getExternalAPICallId().isEmpty()) {
				traceLog.traceFinest(
						"integratorContext.getExternalAPICallId() " + integratorContext.getExternalAPICallId());
				integratorContext.setExternalAPICallId(null);
				traceLog.traceFinest(
						"integratorContext.getExternalAPICallId() " + integratorContext.getExternalAPICallId());
			}
			////////////////////////////////////////////

			if (customerRef == null || customerRef.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_2002, Constants.UPDATE_API_NAME);
			}

			if (msisdn == null || msisdn.trim().equals("")) {
				throw new NullParameterException(ErrorCodes.ERR_RBM_3001, Constants.UPDATE_API_NAME);
			}

			// Setting to Core IntegratorContext_1
			IntegratorContext_1 integratorContext_1 = getCoreIntegratorContext(integratorContext);

			if ((modifyEventSourceData == null || modifyEventSourceData.length == 0)
					&& (modifyProductInstanceData == null || modifyProductInstanceData.length == 0)) {
				throw new ParameterException(ErrorCodes.ERR_RBM_2001, Constants.UPDATE_API_NAME);

			}

			// **********create input object for logging purpose**************//
			updateBillingProfileInput = new UpdateBillingProfileInput();

			updateBillingProfileInput.setIntegratorContext(integratorContext);
			updateBillingProfileInput.setCustomerRef(customerRef);
			updateBillingProfileInput.setMSISDN(msisdn);
			if (modifyEventSourceData != null && modifyEventSourceData.length > 0) {
				updateBillingProfileInput.setModifyEventSourceData(modifyEventSourceData);
			}
			if (modifyProductInstanceData != null && modifyProductInstanceData.length > 0) {
				updateBillingProfileInput.setModifyProductInstanceData(modifyProductInstanceData);
			}
			// **********create input object for logging purpose**************//

			/*******
			 * modifyProductInstanceData has been supplied in input and
			 * modifyEventSourceData is null
			 ******/
			if ((modifyProductInstanceData != null && modifyProductInstanceData.length != 0)
					&& (modifyEventSourceData.length == 0 || modifyEventSourceData == null)) {

				if (traceLog.isFinestEnabled()) {
					traceLog.traceFinest("modifyProductInstanceData has been provided in updateBillingProfile API");
				}
				// productInstanceService = getProductInstanceService();
				Long startDtm = Null.LONG;

				for (ModifyProductInstanceData modifyProductInstanceData2 : modifyProductInstanceData) {

					if (startDtm == Null.LONG) {
						traceLog.traceFinest("startDtm *****123******* " + startDtm);

						if (modifyProductInstanceData2.getStartDtm() < gnvdate) {
							//startDtm = System.currentTimeMillis();
							startDtm =gnvdate; 
						} else if (modifyProductInstanceData2.getStartDtm() > gnvdate) {
							throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
						}else {
							startDtm = modifyProductInstanceData2.getStartDtm(); 
						}
						traceLog.traceFinest("startDtm ****345******** " + startDtm);
					}
					modifyProductInstanceData2.setStartDtm(startDtm);
					traceLog.traceFinest("startDtm ****567******** " + startDtm);

					String custProdAttrValue = modifyProductInstanceData2.getTOMsServiceInstancekey();
					traceLog.traceFinest("getTOMsServiceInstancekey in updateBillingProfile API: " + custProdAttrValue);
					if (custProdAttrValue == null || custProdAttrValue.equals("")) {
						throw new ParameterException(ErrorCodes.ERR_RBM_1004, Constants.UPDATE_API_NAME);

					}
					String compProdAttrValue = modifyProductInstanceData2.getTOMsServiceCompInstancekey();
					int productId = modifyProductInstanceData2.getProductId();
					int productSeq = 0;
					int baseProdSeq = 0;
					if (compProdAttrValue != null) {
						productSeq = getProductSequence(custProdAttrValue, compProdAttrValue, customerRef, msisdn);
					} /*
						 * else { baseProdSeq =
						 * getBaseProductSequence(customerRef, msisdn,
						 * productId, custProdAttrValue); } if ((baseProdSeq ==
						 * 0) && (productSeq == 0)) { throw new
						 * ParameterException(ErrorCodes.ERR_RBM_1011,
						 * Constants.UPDATE_API_NAME); }
						 */

					if (Constants.ACTION_ADD.equals(modifyProductInstanceData2.getAction()) && productSeq != 0) {
						throw new ParameterException(ErrorCodes.ERR_RBM_1011, Constants.UPDATE_API_NAME);
					}

					if (Constants.ACTION_ADD.equals(modifyProductInstanceData2.getAction()) && productSeq == 0) {

						baseProdSeq = getBaseProductSequenceForCES(customerRef, msisdn);

						if ((baseProdSeq == 0) && (productSeq == 0)) {
							throw new ParameterException(ErrorCodes.ERR_RBM_1011, Constants.UPDATE_API_NAME);
						}

						/*
						 * if (productSeq != baseProdSeq) { throw new
						 * ParameterException(ErrorCodes.ERR_RBM_1011,
						 * Constants.UPDATE_API_NAME); }
						 */
						if (traceLog.isFinestEnabled()) {
							traceLog.traceFinest(
									"modifyProductInstanceData has been provided in updateBillingProfile API");
						}
						// ...........Add new child/grand child product instance
						// ....................//
						// int productId =
						// modifyProductInstanceData2.getProductId();
						ModifyProductInstanceAttrData[] modifyProductInstanceAttrData = modifyProductInstanceData2
								.getModifyProductInstanceAttrData();
						List<NewProductInstanceAttrData> newProductInstanceAttrList = new ArrayList<NewProductInstanceAttrData>();
						if ((modifyProductInstanceAttrData != null && modifyProductInstanceAttrData.length != 0)) {
							boolean checkMandAttr1 = false;
							boolean checkMandAttr2 = false;

							for (ModifyProductInstanceAttrData modifyProductInstanceAttrData2 : modifyProductInstanceAttrData) {
								if (Constants.TomsKey
										.equals(modifyProductInstanceAttrData2.getProductAttributeName())) {
									checkMandAttr1 = true;
								}

								if (Constants.TomsCompKey
										.equals(modifyProductInstanceAttrData2.getProductAttributeName())) {
									checkMandAttr2 = true;
								}

							}
							if (!(checkMandAttr1 && checkMandAttr2)) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1012, Constants.UPDATE_API_NAME);
							}

							for (ModifyProductInstanceAttrData modifyProductInstanceAttrData2 : modifyProductInstanceAttrData) {
								// ............... Get list of product
								// attributes..
								if (traceLog.isFinestEnabled()) {
									traceLog.traceFinest("Inside  ModifyProductInstanceAttrData for loop");
								}
								modifyProductInstanceAttrData2.setStartDateNbl(startDtm);
								NewProductInstanceAttrData newProductInstanceAttrData_3 = getProductInstanceAttrData(
										productId, modifyProductInstanceAttrData2);

								newProductInstanceAttrList.add(newProductInstanceAttrData_3);

							}
						}

						// .............Get the new product instance
						// data.............................

						NewProductInstanceData_9 newProductInstanceData_9 = getNewProductInstanceData(customerRef,
								modifyProductInstanceData2, newProductInstanceAttrList, baseProdSeq);

						// .............Add new product
						// instance.....................................
						if (traceLog.isFinestEnabled()) {
							traceLog.traceFinest(
									"before calling   createProductInstance_8 " + newProductInstanceData_9);
						}
						ProductInstancePK newAddedProductInstnc = productInstanceService
								.createProductInstance_9(integratorContext_1, null, null, newProductInstanceData_9);
						if (newAddedProductInstnc != null) {
							updateStatus = Constants.UPDATE_SUCCESS;
						}
						if (traceLog.isFinestEnabled()) {
							traceLog.traceFinest("after calling   createProductInstance_8 " + newAddedProductInstnc);
						}

					} else if (Constants.ACTION_MODIFY.equals(modifyProductInstanceData2.getAction())) {

						ModifyProductInstanceAttrData[] modifyProductInstanceAttrData = modifyProductInstanceData2
								.getModifyProductInstanceAttrData();

						int billingTariff = modifyProductInstanceData2.getBillingTariffIdNbl();

						String newProdStatus = modifyProductInstanceData2.getProductStatus();

						// *************billingTariff tariff is provided in
						// input, so customer wants change price plan.....****//

						// ......................get the product instance
						ProductInstancePK productInstancePK = null;
						if (productSeq != 0) {
							traceLog.traceFinest(" This modify is for child product instance .. Seq " + productSeq);
							productInstancePK = getProductInstancePK(customerRef, productSeq);
						} else {
							baseProdSeq = getBaseProductSequence(customerRef, msisdn, productId, custProdAttrValue);

							traceLog.traceFinest(" This modify is for base product instance..Seq " + baseProdSeq);
							productInstancePK = getProductInstancePK(customerRef, baseProdSeq);
						}

						if (billingTariff != Null.INT) {

							// ......................Get the old billing tariff
							// details..
							HistoriedProductInstanceTariffData oldBillingTariff = getOldTariffData(productInstancePK,
									productInstanceService);

							// ...............If new billing tariff has been
							// provided ..then change the price
							// plan...........//
							if ((oldBillingTariff != null)
									&& (billingTariff != oldBillingTariff.getBillingTariffPK().getBillingTariffId())) {

								if (baseProdSeq != 0) {
									throw new ParameterException(ErrorCodes.ERR_RBM_2004, Constants.UPDATE_API_NAME);
								}

								// ......................Get the new billing
								// tariff details..
								HistoriedProductInstanceTariffData newTariffData = getNewTariffData(
										modifyProductInstanceData2, oldBillingTariff);

								// .....................Change price plan..
								productInstanceService.changeTariffDetails_6(integratorContext_1, productInstancePK,
										Long.valueOf(modifyProductInstanceData2.getStartDtm()), oldBillingTariff,
										newTariffData, null, null);

								updateStatus = Constants.UPDATE_SUCCESS;
							}
						}

						// *************New Attributes have been provided in
						// input, so customer wants to change
						// Attributes.....****//
						if (modifyProductInstanceAttrData != null && modifyProductInstanceAttrData.length > 0) {

							for (ModifyProductInstanceAttrData modifyProductInstanceAttrData2 : modifyProductInstanceAttrData) {

								// ................Get the new attribute details
								// for modify
								List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();
								ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = getNewProdAttrForModify(
										modifyProductInstanceAttrData2, productId);
								newAttrList.add(modifyHistoriedProductInstanceAttrData);
								ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

								// ..................Get product attribute PK
								// for modify..
								ProductAttrPK productAttrPK = getProdAttrPKForModify(modifyProductInstanceAttrData2,
										productId);

								// ..................Get ProductInstancePK
								/*
								 * ProductInstancePK productInstancePK =
								 * getProductInstancePK( customerRef,
								 * productSeq);
								 */
								if (traceLog.isFinestEnabled()) {
									traceLog.traceFinest("Reading history attribute details of product");
								}

								// ..................Reading history attribute
								// details of product
								HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
										.queryHistoriedProductInstanceAttr_6(integratorContext_1, productInstancePK,
												productAttrPK, gnvdate, Null.LONG);

								// ...................Derive the old product
								// attribute values to be modified from
								// HistoriedProductInstanceAttrData
								String[] oldValues = getOldProductAttrValuesForModify(historiedProdInstncAttributeData,
										modifyProductInstanceData2, modifyProductInstanceAttrData2);

								// ...................Modify attributes for the
								// product instance if new attribute vaues are
								// not null
								if (newAttrList != null && newAttrList.size() > 0) {

									modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
											.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
									if (traceLog.isFinestEnabled()) {
										traceLog.traceFinest(
												"Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
														+ modifyHistoriedProdInstncAttrDataArray);
										traceLog.traceFinest("oldValues: " + oldValues);
									}

									// Call core ECA to modify product instance
									// attribute...
									productInstanceService.modifyProductInstanceAttr_6(integratorContext_1,
											productInstancePK, oldValues, modifyHistoriedProdInstncAttrDataArray);
								}

							}
							//Restore case from SUSPEND to ACTIVE when product_status prod instance attribute is not provided
							if (newProdStatus != null && newProdStatus.equals(Constants.PRODUCT_ACTIVE)) {
							traceLog.traceFinest("coming to status check block ACTIVE");

								ProductAttrPK productAttrPK = new ProductAttrPK();
								productAttrPK.setProductId(productId);
								productAttrPK.setProductAttrSubId(3);
								
							
								ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = new ModifyHistoriedProductInstanceAttrData();

								modifyHistoriedProductInstanceAttrData.setAttributeValue(Constants.PRODUCT_ACTIVE);
								modifyHistoriedProductInstanceAttrData.setProductAttrPK(productAttrPK);
								//long milliSec = 1000;
								modifyHistoriedProductInstanceAttrData.setFromDat(startDtm);


								List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();

								newAttrList.add(modifyHistoriedProductInstanceAttrData);
								ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

								// ..................Reading history attribute
								// details of product
								HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
										.queryHistoriedProductInstanceAttr_6(integratorContext_1, productInstancePK,
												productAttrPK, gnvdate, Null.LONG);
								// ...................Derive the old product
								// attribute values to be modified from
								// HistoriedProductInstanceAttrData
								String[] oldValues = getOldProductAttrValuesForModifyForSuspend(
										historiedProdInstncAttributeData, modifyProductInstanceData2, 3);
								
								 List<String> list = Arrays.asList(oldValues);      
								//List<String> list = new Arrays.oldValues(oldValues);
							        
							        if(list.contains("SUSPEND")){
							            System.out.println("Old attribute is suspend");
							        }

								// ...................Modify attributes for the
								// product instance if new attribute vaues are
								// not null
								if (list.contains("SUSPEND") && newAttrList != null && newAttrList.size() > 0) {

									modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
											.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
									if (traceLog.isFinestEnabled()) {
										traceLog.traceFinest(
												"Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
														+ modifyHistoriedProdInstncAttrDataArray);
										traceLog.traceFinest("oldValues: " + oldValues);
									}
									// Call core ECA to modify product instance
									// attribute...
									productInstanceService.modifyProductInstanceAttr_6(integratorContext_1,
											productInstancePK, oldValues, modifyHistoriedProdInstncAttrDataArray);
								}
								else
								{
									traceLog.traceFinest("Product attribute status and product status are same i.e., ACTIVE");
								}

						}//Restore case end
							
							updateStatus = Constants.UPDATE_SUCCESS;

						}

						if (newProdStatus != null && newProdStatus.equals(Constants.PRODUCT_SUSPEND)) {
							traceLog.traceFinest("coming to status check block");

							productId = modifyProductInstanceData2.getProductId();

							if (productSeq != 0) {
								throw new ParameterException(ErrorCodes.ERR_RBM_11020, Constants.UPDATE_API_NAME);
							} else {
								baseProdSeq = getBaseProductSequence(customerRef, msisdn, productId, custProdAttrValue);
								traceLog.traceFinest(
										" This modify (Suspend) is for base product instance..Seq " + baseProdSeq);
								productInstancePK = getProductInstancePK(customerRef, baseProdSeq);

								ProductAttrPK productAttrPK = new ProductAttrPK();
								productAttrPK.setProductId(productId);
								productAttrPK.setProductAttrSubId(3);

								ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = new ModifyHistoriedProductInstanceAttrData();

								modifyHistoriedProductInstanceAttrData.setAttributeValue(Constants.PRODUCT_SUSPEND);
								modifyHistoriedProductInstanceAttrData.setProductAttrPK(productAttrPK);
								long milliSec = 1000;
								modifyHistoriedProductInstanceAttrData.setFromDat(startDtm + milliSec);

								/*
								 * if (modifyProductInstanceData2.getEndDtmNbl()
								 * != Null.LONG) {
								 * modifyHistoriedProductInstanceAttrData.
								 * setToDatNbl(modifyProductInstanceData2.
								 * getEndDtmNbl()); }
								 */

								List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();

								newAttrList.add(modifyHistoriedProductInstanceAttrData);
								ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

								// ..................Reading history attribute
								// details of product
								HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
										.queryHistoriedProductInstanceAttr_6(integratorContext_1, productInstancePK,
												productAttrPK, gnvdate, Null.LONG);

								// ...................Derive the old product
								// attribute values to be modified from
								// HistoriedProductInstanceAttrData
								String[] oldValues = getOldProductAttrValuesForModifyForSuspend(
										historiedProdInstncAttributeData, modifyProductInstanceData2, 3);

								// ...................Modify attributes for the
								// product instance if new attribute vaues are
								// not null
								if (newAttrList != null && newAttrList.size() > 0) {

									modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
											.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
									if (traceLog.isFinestEnabled()) {
										traceLog.traceFinest(
												"Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
														+ modifyHistoriedProdInstncAttrDataArray);
										traceLog.traceFinest("oldValues: " + oldValues);
									}
									// Call core ECA to modify product instance
									// attribute...
									productInstanceService.modifyProductInstanceAttr_6(integratorContext_1,
											productInstancePK, oldValues, modifyHistoriedProdInstncAttrDataArray);
								}

							}

							updateStatus = Constants.UPDATE_SUCCESS;

						}

					} else if (Constants.ACTION_TERMINATE.equals(modifyProductInstanceData2.getAction())) {
						// ............Terminate the product
						// instance.................
						ModifyHistoriedProductInstanceStatus_6 newStatus = null;
						ModifyHistoriedProductInstanceStatusPair_6 modifyProductStatusArray[] = null;
						String newProdStatus = modifyProductInstanceData2.getProductStatus();

						ProductInstancePK productInstancePK = null;
						if (productSeq != 0) {
							traceLog.traceFinest(
									" This modify (terminate) is for child product instance .. Seq " + productSeq);
							productInstancePK = getProductInstancePK(customerRef, productSeq);
						} else {

							if (newProdStatus == null || !Constants.PRODUCT_DEACTIVE.equals(newProdStatus)) {
								throw new ParameterException(ErrorCodes.ERR_RBM_11021, Constants.UPDATE_API_NAME);
							}
							baseProdSeq = getBaseProductSequence(customerRef, msisdn, productId, custProdAttrValue);
							traceLog.traceFinest(
									" This modify (terminate) is for base product instance..Seq " + baseProdSeq);
							productInstancePK = getProductInstancePK(customerRef, baseProdSeq);

							ProductAttrPK productAttrPK = new ProductAttrPK();
							productAttrPK.setProductId(productId);
							productAttrPK.setProductAttrSubId(3);

							ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = new ModifyHistoriedProductInstanceAttrData();

							modifyHistoriedProductInstanceAttrData.setAttributeValue(Constants.PRODUCT_DEACTIVE);
							modifyHistoriedProductInstanceAttrData.setProductAttrPK(productAttrPK);
							long milliSec = 1000;
							modifyHistoriedProductInstanceAttrData.setFromDat(startDtm + milliSec);

							/*
							 * if (modifyProductInstanceData2.getEndDtmNbl() !=
							 * Null.LONG) {
							 * modifyHistoriedProductInstanceAttrData.
							 * setToDatNbl(modifyProductInstanceData2.
							 * getEndDtmNbl()); }
							 */

							////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();

							newAttrList.add(modifyHistoriedProductInstanceAttrData);
							ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

							// ..................Reading history attribute
							// details of product
							HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
									.queryHistoriedProductInstanceAttr_6(integratorContext_1, productInstancePK,
											productAttrPK, gnvdate, Null.LONG);

							// ...................Derive the old product
							// attribute values to be modified from
							// HistoriedProductInstanceAttrData
							String[] oldValues = getOldProductAttrValuesForModifyForSuspend(
									historiedProdInstncAttributeData, modifyProductInstanceData2, 3);

							// ...................Modify attributes for the
							// product instance if new attribute vaues are not
							// null
							if (newAttrList != null && newAttrList.size() > 0) {

								modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
										.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
								if (traceLog.isFinestEnabled()) {
									traceLog.traceFinest(
											"Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
													+ modifyHistoriedProdInstncAttrDataArray);
									traceLog.traceFinest("oldValues: " + oldValues);
								}

								// Call core ECA to modify product instance
								// attribute...
								productInstanceService.modifyProductInstanceAttr_6(integratorContext_1,
										productInstancePK, oldValues, modifyHistoriedProdInstncAttrDataArray);
							}
						}

						// Thread.sleep(1000);
						long milliSecT = 2000;
						long terminateTime = 0;
						if (modifyProductInstanceData2.getStartDtm() != Null.LONG) {
							terminateTime = modifyProductInstanceData2.getStartDtm() + milliSecT;
						} else {
							//terminateTime = System.currentTimeMillis();
							terminateTime =gnvdate; 
							traceLog.traceFinest("startDtm ****123789******** " + startDtm);
						}
						traceLog.traceFinest("startDtm ****789******** " + startDtm);
						newStatus = new ModifyHistoriedProductInstanceStatus_6(terminateTime, Null.LONG,
								EnumProductStatus.PS_TERMINATED, null);

						modifyProductStatusArray = new ModifyHistoriedProductInstanceStatusPair_6[1];
						modifyProductStatusArray[0] = new ModifyHistoriedProductInstanceStatusPair_6(null, newStatus,
								null, null);
						traceLog.traceFinest(
								"Before calling modifyHistoriedProductInstanceStatus_7, newProductStatusArray: "
										+ modifyProductStatusArray);
						traceLog.traceFinest(
								"before terminate " + productInstancePK + "seq " + productInstancePK.getProductSeq());
						productInstanceService.modifyHistoriedProductInstanceStatus_7(integratorContext_1,
								productInstancePK, modifyProductStatusArray, false);

						updateStatus = Constants.UPDATE_SUCCESS;

					}
				}

			}
			/*************
			 * Below condition is satisfied when there is modify event source
			 ************/
			if ((modifyProductInstanceData.length == 0 || modifyProductInstanceData == null)
					&& (modifyEventSourceData != null && modifyEventSourceData.length != 0)) {

				if (traceLog.isFinestEnabled()) {
					traceLog.traceFinest("modifyEventSourceData has been provided in updateBillingProfile API");
				}
				// productInstanceService = getProductInstanceService();
				int baseProdSeq = getBaseProductSequenceForCES(customerRef, msisdn);
				ProductInstancePK productInstancePK = getProductInstancePK(customerRef, baseProdSeq);
				HistoriedEventSourceData_6[] historiedEventSourceDataArray = readEventSourceArray(Constants.MAX_COUNT,
						productInstancePK, msisdn, eventSourceService);
				String action = null;
				for (ModifyEventSourceData modifyEventSourceData2 : modifyEventSourceData) {

					String custProdAttrValue = modifyEventSourceData2.getTOMsServiceInstancekey();
					if (custProdAttrValue == null) {
						throw new ParameterException(ErrorCodes.ERR_RBM_1004, Constants.UPDATE_API_NAME);

					}

					if (Constants.ACTION_MODIFY.equals(modifyEventSourceData2.getAction())) {

						if (traceLog.isFinestEnabled()) {
							traceLog.traceFinest(
									"modifyEventSourceData and action as 'Modify' has been provided in updateBillingProfile API");
						}
						// ....Modify the Event Source..............//
						// ....Get Old EventSource details.....//
						action = modifyEventSourceData2.getAction();
					}
				}
				if (Constants.ACTION_MODIFY.equals(action)) {
					ModifyEventSourceDataPair_6[] modifyEventSourceDataPair = getModifyEventSourceDataPair(
							historiedEventSourceDataArray, modifyEventSourceData);

					traceLog.traceFinest("modifyEventSourceDataPair is " + modifyEventSourceDataPair
							+ "modifyEventSourceDataPair length::" + modifyEventSourceDataPair.length);

					boolean flag = false;

					if (modifyEventSourceDataPair.length > 0) {
						for (int i = 0; i < modifyEventSourceDataPair.length; i++) {
							if (null != modifyEventSourceDataPair[i]) {
								flag = (null != modifyEventSourceDataPair[i].getOldModifyEventSourceData()) ? true
										: false;
								break;
							}
						}
					}
					traceLog.traceFinest("Flag value:" + flag);
					if (!flag) {
						Long startDtm = Null.LONG;
						for (ModifyEventSourceData modifyEventSourceData2 : modifyEventSourceData) {
							if (startDtm == Null.LONG) {
								traceLog.traceFinest("startDtm ******5555777777****** " + startDtm);

								if (modifyEventSourceData2.getStartDtm() < gnvdate) {
									//startDtm = System.currentTimeMillis();
									startDtm =gnvdate; 
								}else if (modifyEventSourceData2.getStartDtm() > gnvdate) {
									throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
								}else {
									startDtm = modifyEventSourceData2.getStartDtm();
								}
								traceLog.traceFinest("startDtm *****777888888******* " + startDtm);

							}
							modifyEventSourceData2.setStartDtm(startDtm);

							ModifyEventSourceData_6 eventSourceData = new ModifyEventSourceData_6();
							RatingTariffPK ratingTariffPk = new RatingTariffPK();
							ratingTariffPk.setRatingTariffId(modifyEventSourceData2.getRatingTariffId());
							eventSourceData.setEventTypeId(modifyEventSourceData2.getEventTypeId());
							eventSourceData.setCopyGuidingRules(false);
							eventSourceData.setCompetitorRatingTariffPK(null);
							eventSourceData.setCreditLimitMnyNbl(Null.LONG);
							eventSourceData.setEndDtmNbl(Null.LONG);
							eventSourceData.setEventSource(modifyEventSourceData2.getEventSource());
							eventSourceData.setEventSourceLabel(modifyEventSourceData2.getEventSourceLabel());
							eventSourceData.setEventSourceText(modifyEventSourceData2.getEventSourceText());
							eventSourceData.setRatingTariffPK(ratingTariffPk);
							eventSourceData.setStartDtm(modifyEventSourceData2.getStartDtm());
							eventSourceService.addEventSource_7(integratorContext_1, productInstancePK, eventSourceData,
									false);
							if (traceLog.isFinestEnabled()) {
								traceLog.traceFinest("Event Source Modified");
							}
						}

					} else {
						eventSourceService.modifyEventSource_7(integratorContext_1, productInstancePK,
								modifyEventSourceDataPair, false);

						if (traceLog.isFinestEnabled()) {
							traceLog.traceFinest("Event Source Modified");
						}

					}
				}

				updateStatus = Constants.UPDATE_SUCCESS;

			}

			// ************* This condition satisfied for Rate plan change along
			// with price plan***********//*
			if ((modifyProductInstanceData != null && modifyProductInstanceData.length != 0)
					&& (modifyEventSourceData != null && modifyEventSourceData.length != 0)) {
				/*
				 * if (modifyProductInstanceData.length > 1) {
				 * traceLog.traceFinest(
				 * "length of modifyProductInstanceData in rate plan change " +
				 * modifyProductInstanceData.length); throw new
				 * ParameterException(ErrorCodes.ERR_RBM_3000,
				 * Constants.UPDATE_API_NAME); }
				 */

				traceLog.traceFinest("enetered into both modifyProductInstanceData and  modifyEventSourceData ");

				for (ModifyProductInstanceData modifyProductInstanceData2 : modifyProductInstanceData) {

					if (Constants.ACTION_MODIFY.equals(modifyProductInstanceData2.getAction())) {

						traceLog.traceFinest("enetedred action modify ");

						int newBillingTariffId = 0;
						int oldBillingTariffId = 0;
						int productId = 0;
						ProductInstancePK baseProductInstancePK = null;
						HistoriedProductInstanceTariffData oldBillingTariffData = null;
						HistoriedProductInstanceTariffData newBillingTariffData = null;
						String custProdAttrValue = null;
						String action = null;
						Long startDtm = Null.LONG;
						ModifyProductInstanceAttrData[] modifyProductInstanceAttrData = null;
						ModifyProductInstanceData modifyProductInstanceData_2 = null;

						if (startDtm == Null.LONG) {
							traceLog.traceFinest("startDtm ******5555777777****** " + startDtm);

							if (modifyProductInstanceData2.getStartDtm() < gnvdate) {
								//startDtm = System.currentTimeMillis();
								startDtm =gnvdate; 
							}else if (modifyProductInstanceData2.getStartDtm() > gnvdate) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
							}else {
								startDtm = modifyProductInstanceData2.getStartDtm();
							}
							traceLog.traceFinest("startDtm *****777888888******* " + startDtm);

						}
						modifyProductInstanceData2.setStartDtm(startDtm);
						traceLog.traceFinest("startDtm *****777888888***2222222**** " + startDtm);

						custProdAttrValue = modifyProductInstanceData2.getTOMsServiceInstancekey();
						traceLog.traceFinest("enetedred action modify custProdAttrValue" + custProdAttrValue);
						newBillingTariffId = modifyProductInstanceData2.getBillingTariffIdNbl();
						productId = modifyProductInstanceData2.getProductId();
						if (custProdAttrValue == null) {
							throw new ParameterException(ErrorCodes.ERR_RBM_1004, Constants.UPDATE_API_NAME);

						}
						traceLog.traceFinest("newBillingTariffId in rate plan change " + newBillingTariffId);
						if (newBillingTariffId == 0) {
							throw new ParameterException(ErrorCodes.ERR_RBM_3000, Constants.UPDATE_API_NAME);

						}
						int baseProdSeq = getBaseProductSequence(customerRef, msisdn, productId, custProdAttrValue);
						traceLog.traceFinest("enetedred action modify baseProdSeq" + baseProdSeq);
						baseProductInstancePK = getProductInstancePK(customerRef, baseProdSeq);
						// ......................Get the old billing tariff
						// details..
						oldBillingTariffData = getOldTariffData(baseProductInstancePK, productInstanceService);
						oldBillingTariffId = oldBillingTariffData.getBillingTariffPK().getBillingTariffId();
						action = modifyProductInstanceData2.getAction();
						startDtm = modifyProductInstanceData2.getStartDtm();
						newBillingTariffData = getNewTariffData(modifyProductInstanceData2, oldBillingTariffData);
						modifyProductInstanceAttrData = modifyProductInstanceData2.getModifyProductInstanceAttrData();
						modifyProductInstanceData_2 = modifyProductInstanceData2;

						for (ModifyEventSourceData modifyEventSourceData2 : modifyEventSourceData) {

							String custProdAttrValue1 = modifyEventSourceData2.getTOMsServiceInstancekey();
							traceLog.traceFinest("inside ModifyEventSourceData of rate plan change ");
							if (custProdAttrValue1 == null) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1004, Constants.UPDATE_API_NAME);

							}
							if (!custProdAttrValue1.equals(custProdAttrValue)) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1014, Constants.UPDATE_API_NAME);

							}
							traceLog.traceFinest("action in rate plan change of ModifyEventSourceData "
									+ modifyEventSourceData2.getAction());
							if (!action.equals(modifyEventSourceData2.getAction())) {
								throw new ParameterException(ErrorCodes.ERR_RBM_3000, Constants.UPDATE_API_NAME);

							}
						}

						if ((oldBillingTariffData != null) && (newBillingTariffId != oldBillingTariffId)) {
							if (traceLog.isFinestEnabled()) {
								traceLog.traceFinest(
										"modifyEventSourceData and modifyProductInstanceData has been provided in updateBillingProfile API");
							}
							if (modifyProductInstanceAttrData != null && modifyProductInstanceAttrData.length != 0) {
								traceLog.traceFinest(
										"updating the product attribute during pricePlan change of base product");
								updateTLOInPricePlanChange(modifyProductInstanceAttrData, productId,
										baseProductInstancePK, modifyProductInstanceData_2);
							}
							// ....Modify the Event Source..............//
							// ....Get Old EventSource details.....//
							HistoriedEventSourceData_6[] historiedEventSourceDataArray = readEventSourceArray(
									Constants.MAX_COUNT, baseProductInstancePK, msisdn, eventSourceService);

							ModifyEventSourceDataPair_6[] modifyEventSourceDataPair = getModifyEventSourceDataPairPlanChange(
									historiedEventSourceDataArray, modifyEventSourceData);
							// startDtm =
							// modifyEventSourceDataPair[0].getNewModifyEventSourceData().getStartDtm();
							traceLog.traceFinest("Strart DTM in priceplan change " + startDtm);
							productInstanceService.changeTariffDetails_6(new IntegratorContext_1(),
									baseProductInstancePK, startDtm, oldBillingTariffData, newBillingTariffData,
									modifyEventSourceDataPair, null);

							updateStatus = Constants.UPDATE_SUCCESS;
						}
					} else {
						// ADD SOC and Remove SOC operations
						traceLog.traceFinest("add soc/remove SOC condition");
						Long startDtm = Null.LONG;

						if (startDtm == Null.LONG) {
							traceLog.traceFinest("startDtm *****123******* " + startDtm);

							if (modifyProductInstanceData2.getStartDtm() < gnvdate) {
								//startDtm = System.currentTimeMillis();
								startDtm =gnvdate; 
							}else if (modifyProductInstanceData2.getStartDtm() > gnvdate) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
							}else {
								startDtm = modifyProductInstanceData2.getStartDtm();
							}
							traceLog.traceFinest("startDtm ****345******** " + startDtm);
						}
						modifyProductInstanceData2.setStartDtm(startDtm);
						traceLog.traceFinest("startDtm ****567******** " + startDtm);

						String custProdAttrValue = modifyProductInstanceData2.getTOMsServiceInstancekey();
						traceLog.traceFinest(
								"getTOMsServiceInstancekey in updateBillingProfile API: " + custProdAttrValue);
						if (custProdAttrValue == null || custProdAttrValue.equals("")) {
							throw new ParameterException(ErrorCodes.ERR_RBM_1004, Constants.UPDATE_API_NAME);

						}
						String compProdAttrValue = modifyProductInstanceData2.getTOMsServiceCompInstancekey();
						int productId = modifyProductInstanceData2.getProductId();
						int productSeq = 0;
						int baseProdSeq = 0;
						if (compProdAttrValue != null) {
							productSeq = getProductSequence(custProdAttrValue, compProdAttrValue, customerRef, msisdn);
						}

						if (Constants.ACTION_ADD.equals(modifyProductInstanceData2.getAction()) && productSeq != 0) {
							throw new ParameterException(ErrorCodes.ERR_RBM_1011, Constants.UPDATE_API_NAME);
						}

						if (Constants.ACTION_ADD.equals(modifyProductInstanceData2.getAction()) && productSeq == 0) {

							traceLog.traceFinest("Entered into add soc condition");

							baseProdSeq = getBaseProductSequenceForCES(customerRef, msisdn);

							traceLog.traceFinest("add soc condition baseProdSeq" + baseProdSeq);

							if ((baseProdSeq == 0) && (productSeq == 0)) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1011, Constants.UPDATE_API_NAME);
							}

							if (traceLog.isFinestEnabled()) {
								traceLog.traceFinest(
										"modifyProductInstanceData has been provided in updateBillingProfile API");
							}

							ModifyProductInstanceAttrData[] modifyProductInstanceAttrData = modifyProductInstanceData2
									.getModifyProductInstanceAttrData();
							List<NewProductInstanceAttrData> newProductInstanceAttrList = new ArrayList<NewProductInstanceAttrData>();
							if ((modifyProductInstanceAttrData != null && modifyProductInstanceAttrData.length != 0)) {
								boolean checkMandAttr1 = false;
								boolean checkMandAttr2 = false;

								for (ModifyProductInstanceAttrData modifyProductInstanceAttrData2 : modifyProductInstanceAttrData) {
									if (Constants.TomsKey
											.equals(modifyProductInstanceAttrData2.getProductAttributeName())) {
										checkMandAttr1 = true;
									}

									if (Constants.TomsCompKey
											.equals(modifyProductInstanceAttrData2.getProductAttributeName())) {
										checkMandAttr2 = true;
									}

								}
								if (!(checkMandAttr1 && checkMandAttr2)) {
									throw new ParameterException(ErrorCodes.ERR_RBM_1012, Constants.UPDATE_API_NAME);
								}

								for (ModifyProductInstanceAttrData modifyProductInstanceAttrData2 : modifyProductInstanceAttrData) {
									// ............... Get list of product
									// attributes..
									if (traceLog.isFinestEnabled()) {
										traceLog.traceFinest("Inside  ModifyProductInstanceAttrData for loop");
									}
									modifyProductInstanceAttrData2.setStartDateNbl(startDtm);
									NewProductInstanceAttrData newProductInstanceAttrData_3 = getProductInstanceAttrData(
											productId, modifyProductInstanceAttrData2);

									newProductInstanceAttrList.add(newProductInstanceAttrData_3);

								}
							}

							// .............Get the new product instance
							// data.............................

							NewProductInstanceData_9 newProductInstanceData_9 = getNewProductInstanceData(customerRef,
									modifyProductInstanceData2, newProductInstanceAttrList, baseProdSeq);

							// .............Add new product
							// instance.....................................
							if (traceLog.isFinestEnabled()) {
								traceLog.traceFinest(
										"before calling   createProductInstance_8 " + newProductInstanceData_9);
							}
							ProductInstancePK newAddedProductInstnc = productInstanceService
									.createProductInstance_9(integratorContext_1, null, null, newProductInstanceData_9);
							if (newAddedProductInstnc != null) {
								updateStatus = Constants.UPDATE_SUCCESS;
							}
							if (traceLog.isFinestEnabled()) {
								traceLog.traceFinest(
										"after calling   createProductInstance_8 " + newAddedProductInstnc);
							}

						}

						if (Constants.ACTION_TERMINATE.equals(modifyProductInstanceData2.getAction())) {

							traceLog.traceFinest("Entered into remove soc condition");
							// ............Terminate the product
							// instance.................
							ModifyHistoriedProductInstanceStatus_6 newStatus = null;
							ModifyHistoriedProductInstanceStatusPair_6 modifyProductStatusArray[] = null;
							String newProdStatus = modifyProductInstanceData2.getProductStatus();

							ProductInstancePK productInstancePK = null;
							if (productSeq != 0) {
								traceLog.traceFinest(
										" This modify (terminate) is for child product instance .. Seq " + productSeq);
								productInstancePK = getProductInstancePK(customerRef, productSeq);
							} else {

								/*
								 * if (newProdStatus == null ||
								 * !Constants.PRODUCT_DEACTIVE.equals(
								 * newProdStatus)){ throw new
								 * ParameterException(ErrorCodes.ERR_RBM_11021,
								 * Constants.UPDATE_API_NAME ); }
								 */
								baseProdSeq = getBaseProductSequence(customerRef, msisdn, productId, custProdAttrValue);
								traceLog.traceFinest(
										" This modify (terminate) is for base product instance..Seq " + baseProdSeq);
								productInstancePK = getProductInstancePK(customerRef, baseProdSeq);

								ProductAttrPK productAttrPK = new ProductAttrPK();
								productAttrPK.setProductId(productId);
								productAttrPK.setProductAttrSubId(3);

								ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = new ModifyHistoriedProductInstanceAttrData();

								modifyHistoriedProductInstanceAttrData.setAttributeValue(Constants.PRODUCT_DEACTIVE);
								modifyHistoriedProductInstanceAttrData.setProductAttrPK(productAttrPK);
								long milliSec = 1000;
								modifyHistoriedProductInstanceAttrData.setFromDat(startDtm + milliSec);

								////////////////////////////////////////////////////////////////////////////////////////////////////////////////
								List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();

								newAttrList.add(modifyHistoriedProductInstanceAttrData);
								ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

								// ..................Reading history attribute
								// details of product
								HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
										.queryHistoriedProductInstanceAttr_6(integratorContext_1, productInstancePK,
												productAttrPK, gnvdate, Null.LONG);

								// ...................Derive the old product
								// attribute values to be modified from
								// HistoriedProductInstanceAttrData
								String[] oldValues = getOldProductAttrValuesForModifyForSuspend(
										historiedProdInstncAttributeData, modifyProductInstanceData2, 3);

								// ...................Modify attributes for the
								// product instance if new attribute vaues are
								// not null
								if (newAttrList != null && newAttrList.size() > 0) {

									modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
											.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
									if (traceLog.isFinestEnabled()) {
										traceLog.traceFinest(
												"Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
														+ modifyHistoriedProdInstncAttrDataArray);
										traceLog.traceFinest("oldValues: " + oldValues);
									}

									// Call core ECA to modify product instance
									// attribute...
									productInstanceService.modifyProductInstanceAttr_6(integratorContext_1,
											productInstancePK, oldValues, modifyHistoriedProdInstncAttrDataArray);
								}
							}

							// Thread.sleep(1000);
							long milliSecT = 2000;
							long terminateTime = 0;
							if (modifyProductInstanceData2.getStartDtm() != Null.LONG) {
								terminateTime = modifyProductInstanceData2.getStartDtm() + milliSecT;
							} else {
								//terminateTime = System.currentTimeMillis();
								terminateTime =gnvdate; 
								traceLog.traceFinest("startDtm ****123789******** " + startDtm);
							}
							traceLog.traceFinest("startDtm ****789******** " + startDtm);
							newStatus = new ModifyHistoriedProductInstanceStatus_6(terminateTime, Null.LONG,
									EnumProductStatus.PS_TERMINATED, null);

							modifyProductStatusArray = new ModifyHistoriedProductInstanceStatusPair_6[1];
							modifyProductStatusArray[0] = new ModifyHistoriedProductInstanceStatusPair_6(null,
									newStatus, null, null);
							traceLog.traceFinest(
									"Before calling modifyHistoriedProductInstanceStatus_7, newProductStatusArray: "
											+ modifyProductStatusArray);
							traceLog.traceFinest("before terminate " + productInstancePK + "seq "
									+ productInstancePK.getProductSeq());
							productInstanceService.modifyHistoriedProductInstanceStatus_7(integratorContext_1,
									productInstancePK, modifyProductStatusArray, false);

							updateStatus = Constants.UPDATE_SUCCESS;

						}
					}

				}

			}

			endTime = System.currentTimeMillis();

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest("End time after updateBillingProfile.. " + endTime);

			diff = endTime - startTime;
			diffStr = String.valueOf(diff);

			if (traceLog.isFinerEnabled())
				traceLog.traceFinest(
						"Time taken for the execution of updateBillingProfile is " + diff + "........." + diffStr);

		} catch (Exception ex) {
			responseStatus = ex.getMessage();
			// **create response Object for logging********//
			updateBillingProfileOutput = new UpdateBillingProfileOutput();
			updateBillingProfileOutput.setStatus(Constants.UPDATE_FAILURE);
			// **create response Object for logging********//
			BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, customerRef, msisdn,
					updateBillingProfileInput, updateBillingProfileOutput, responseStatus, Constants.UPDATE_API_NAME,
					das, diffStr, node);
			traceLog.traceFinest("Exception from  updateBillingProfile API " + ex.getMessage());
			ex.printStackTrace();
			throw new ApplicationException(ex.toString());
		}
		// **create response Object for logging********//
		traceLog.traceFinest("create logging UpdateBillingProfile..");
		updateBillingProfileOutput = new UpdateBillingProfileOutput();
		updateBillingProfileOutput.setStatus(Constants.UPDATE_SUCCESS);
		// **create response Object for logging********//
		responseStatus = Constants.TRANSACTION_SUCCESS;
		BillingProfileErrorLog.insertAPITransactionDetails(integratorContext, customerRef, msisdn,
				updateBillingProfileInput, updateBillingProfileOutput, responseStatus, Constants.UPDATE_API_NAME, das,
				diffStr, node);
		return updateStatus;

	}

	private EventSourceService getEventSourceService() {

		EventSourceService eventSourceService = null;

		try {
			eventSourceService = (EventSourceService) ServiceLocator.getInstance().getBean("ECA_EventSource");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return eventSourceService;
	}

	/**
	 * @param integratorContext
	 * @return
	 * @author sjoshi1
	 */
	private IntegratorContext_1 getCoreIntegratorContext(IntegratorContext integratorContext) {
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the Core IntegratorContext_1  integratorContext : " + integratorContext);
		}
		IntegratorContext_1 integratorContext_1 = new IntegratorContext_1();
		integratorContext_1.setExternalUserName(integratorContext.getExternalUserName());
		integratorContext_1.setExternalAPICallId(integratorContext.getExternalAPICallId());
		integratorContext_1.setExternalBusinessTransactionId(integratorContext.getExternalBusinessTransactionId());
		integratorContext_1.setExternalTimestamp(integratorContext.getExternalTimestamp());
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest("Get the IntegratorContext in updateBillingProfile API");
		}

		return integratorContext_1;
	}

	/**
	 * 
	 * @param custProdAttrValue
	 * @param compProdAttrValue
	 * @param customerRef
	 * @param msisdn
	 * @return
	 */
	private int getProductSequence(String custProdAttrValue, String compProdAttrValue, String customerRef,
			String msisdn) {

		traceLog.traceFinest("Inside before connection");
		Connection connectionObject = null;
		CallableStatement callableStatement = null;

		int productSeq = 0;
		try {
			connectionObject = util.getDataSource().getConnection();
			// callableStatement =
			// connectionObject.prepareCall(SQLStatements.GET_PROD_SEQ);
			callableStatement = connectionObject.prepareCall(SQLStatements.GET_PROD_SEQ_1);
			callableStatement.setString(1, custProdAttrValue);
			callableStatement.setString(2, compProdAttrValue);
			callableStatement.setString(3, customerRef);
			callableStatement.setString(4, msisdn);
			callableStatement.registerOutParameter(5, java.sql.Types.NUMERIC);
			callableStatement.registerOutParameter(6, java.sql.Types.NUMERIC);
			callableStatement.registerOutParameter(7, java.sql.Types.VARCHAR);
			traceLog.traceFinest("Inside GET_PROD_SEQ try before execute");
			callableStatement.execute();

			productSeq = callableStatement.getInt(5);

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getProductSequence:: " + e.getMessage());
			// e.printStackTrace();
		} finally {
			util.closeResources(null, connectionObject, null, callableStatement);
		}
		traceLog.traceFinest(" ProductSequence is : " + productSeq);
		return productSeq;
	}

	/**
	 * 
	 * @param customerRef
	 * @param msisdn
	 * @return
	 */
	private int getBaseProductSequenceForCES(String customerRef, String msisdn) {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getBaseProductSequenceForCES before connection");
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int productSeq = 0;
		try {
			connectionObject = util.getDataSource().getConnection();
			preparedStatement = connectionObject.prepareStatement(SQLStatements.GET_BASE_PROD_SEQ_MOD_CES);
			preparedStatement.setString(1, customerRef);
			preparedStatement.setString(2, msisdn);

			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {

				productSeq = resultSet.getInt(1);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getBaseProductSequenceForCES:: " + e.getMessage());
			// e.printStackTrace();
		} finally {
			util.closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest(" getBaseProductSequenceForCES is : " + productSeq);
		return productSeq;
	}

	/**
	 * @param modifyProductInstanceAttrData2
	 * @return
	 * @author sjoshi1
	 * @throws Exception
	 */
	private NewProductInstanceAttrData getProductInstanceAttrData(int productId,
			ModifyProductInstanceAttrData modifyProductInstanceAttrData2) throws Exception {
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the  ProductInstanceAttrData ");
		}
		NewProductInstanceAttrData newProductInstanceAttrData_3 = new NewProductInstanceAttrData();
		ProductAttrPK productAttrPK = new ProductAttrPK();
		int productAttrSubId = util.getProductAttrSubId(productId,
				modifyProductInstanceAttrData2.getProductAttributeName());
		productAttrPK.setProductAttrSubId(productAttrSubId);

		if(modifyProductInstanceAttrData2.getAttributeValue().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE_VALUE) && modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE)){
			newProductInstanceAttrData_3.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE) && modifyProductInstanceAttrData2.getAttributeValue().trim().startsWith(Constants.LAST_TERM_RENEWAL_DATE_VALUE)){
	    	newProductInstanceAttrData_3.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE) && modifyProductInstanceAttrData2.getAttributeValue().trim().startsWith(Constants.LAST_RENEWAL_DATE_VALUE)){
	    	newProductInstanceAttrData_3.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE) && modifyProductInstanceAttrData2.getAttributeValue().trim().startsWith(Constants.TERM_EXPIRATION_DATE_VALUE)){
	    	newProductInstanceAttrData_3.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getAttributeValue().trim().equalsIgnoreCase(Constants.PLAN_NAME_VALUE) && modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.PLAN_NAME)){
	    	newProductInstanceAttrData_3.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getAttributeValue().trim().equalsIgnoreCase(Constants.TERM_LENGTH_VALUE) && modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_LENGTH)){
	    	newProductInstanceAttrData_3.setAttributeValue(null);
	    }
	    else
	    {		
	    if(modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE) || modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE)
						 || modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE)) {
						 
						 newProductInstanceAttrData_3.setAttributeValue(util.checkUTCOffSetValue(modifyProductInstanceAttrData2.getAttributeValue()));
		} else {
			 newProductInstanceAttrData_3.setAttributeValue(modifyProductInstanceAttrData2.getAttributeValue());
						 
		}
	    }
		if (modifyProductInstanceAttrData2.getStartDateNbl() != Null.LONG) {
			newProductInstanceAttrData_3.setStartDat(modifyProductInstanceAttrData2.getStartDateNbl());
		}
		newProductInstanceAttrData_3.setProductAttrPK(productAttrPK);		
		return newProductInstanceAttrData_3;
	}

	/**
	 * @param customerRef
	 * @param modifyProductInstanceData2
	 * @param newProductInstanceAttrList
	 * @param baseProdSeq
	 * @param productSeq
	 * @return
	 * @author sjoshi1
	 */
	private NewProductInstanceData_9 getNewProductInstanceData(String customerRef,
			ModifyProductInstanceData modifyProductInstanceData2,
			List<NewProductInstanceAttrData> newProductInstanceAttrList, int baseProdSeq) {

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the New Product Instance Data ");
		}

		NewProductInstanceData_9 newProductInstanceData_9 = new NewProductInstanceData_9();
		traceLog.traceFinest(" newProductInstanceAttrList " + newProductInstanceAttrList);
		if (newProductInstanceAttrList != null && newProductInstanceAttrList.size() > 0) {
			NewProductInstanceAttrData[] productAttributeArray = (NewProductInstanceAttrData[]) newProductInstanceAttrList
					.toArray(new NewProductInstanceAttrData[newProductInstanceAttrList.size()]);
			newProductInstanceData_9.setProductInstanceAttrs(productAttributeArray);
			if (traceLog.isFinestEnabled()) {
				traceLog.traceFinest(" To get the New Product Instance Data 22 " + newProductInstanceData_9);
			}
		}

		BillingTariffPK billingTariffPK = new BillingTariffPK();
		billingTariffPK.setBillingTariffId(modifyProductInstanceData2.getBillingTariffIdNbl());
		newProductInstanceData_9.setBillingTariffPK(billingTariffPK);
		if (modifyProductInstanceData2.getEndDtmNbl() != Null.LONG) {
			newProductInstanceData_9.setEndDtmNbl(modifyProductInstanceData2.getEndDtmNbl());
		}
		traceLog.traceFinest("start Dtm " + modifyProductInstanceData2.getStartDtm());
		newProductInstanceData_9.setStartDtm(modifyProductInstanceData2.getStartDtm());
		ProductPK productPK = new ProductPK();
		productPK.setProductId(modifyProductInstanceData2.getProductId());
		newProductInstanceData_9.setProductPK(productPK);

		/*
		 * if (productSeq == baseProdSeq) { ProductInstancePK
		 * parentProductInstancePK = getProductInstancePK(customerRef,
		 * baseProdSeq); ProductInstancePK parentProductInstancePK =
		 * getProductInstancePK(customerRef, productSeq);
		 * newProductInstanceData_9.setParentProductInstancePK(
		 * parentProductInstancePK); } else {
		 */
		ProductInstancePK parentProductInstancePK = getProductInstancePK(customerRef, baseProdSeq);
		newProductInstanceData_9.setParentProductInstancePK(parentProductInstancePK);
		// }

		newProductInstanceData_9.setProductQuantity(1);
		newProductInstanceData_9.setProductStatus(0);
		newProductInstanceData_9.setContractedPointOfSupplyId(1);

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the New Product Instance Data 33 " + newProductInstanceData_9);
		}

		return newProductInstanceData_9;

	}

	/**
	 * @param customerRef
	 * @param productSeq
	 * @return
	 * @author sjoshi1
	 */
	private ProductInstancePK getProductInstancePK(String customerRef, int productSeq) {

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the productInstance PK " + customerRef + " :productSeq: " + productSeq);
		}
		ProductInstancePK productInstancePK = new ProductInstancePK();
		productInstancePK.setCustomerRef(customerRef);
		productInstancePK.setProductSeq(productSeq);
		return productInstancePK;
	}

	/**
	 * 
	 * @param customerRef
	 * @param msisdn
	 * @param productId
	 * @param custProdAttrValue
	 * @return
	 */

	private int getBaseProductSequence(String customerRef, String msisdn, int productId, String custProdAttrValue) {

		if (traceLog.isFinestEnabled())
			traceLog.traceFinest("Inside getBaseProductSequence before connection");
		Connection connectionObject = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		int productSeq = 0;
		try {
			connectionObject = util.getDataSource().getConnection();
			traceLog.traceFinest("Exception inside customerRef:: " + customerRef);
			traceLog.traceFinest("Exception inside msisdn:: " + msisdn);
			traceLog.traceFinest("Exception inside productId:: " + productId);
			traceLog.traceFinest("Exception inside custProdAttrValue:: " + custProdAttrValue);
			traceLog.traceFinest(
					"Exception inside SQLStatements.GET_BASE_PROD_SEQ:: " + SQLStatements.GET_BASE_PROD_SEQ);
			preparedStatement = connectionObject.prepareStatement(SQLStatements.GET_BASE_PROD_SEQ);
			preparedStatement.setString(1, customerRef);
			preparedStatement.setString(2, msisdn);
			preparedStatement.setInt(3, productId);
			preparedStatement.setString(4, custProdAttrValue);

			resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {

				productSeq = resultSet.getInt(1);
				traceLog.traceFinest("Exception inside productSeq:: " + productSeq);
			}

		} catch (SQLException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception inside getBaseProductSequence:: " + e.getMessage());
			// e.printStackTrace();
		} finally {
			util.closeResources(resultSet, connectionObject, preparedStatement, null);
		}
		if (traceLog.isFinestEnabled())
			traceLog.traceFinest(" BaseProductSequence is : " + productSeq);
		return productSeq;
	}

	/**
	 * @param productInstancePK
	 * @param productInstanceService
	 * @return
	 * @throws java.rmi.RemoteException
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * @author sjoshi1
	 */

	private HistoriedProductInstanceTariffData getOldTariffData(ProductInstancePK productInstancePK,
			ProductInstanceService productInstanceService)

			throws java.rmi.RemoteException, com.convergys.iml.commonIML.NullParameterException,
			com.convergys.iml.commonIML.ParameterException, com.convergys.platform.ApplicationException {
		HistoriedProductInstanceTariffData oldData = null;
		ReadProductInstanceBillingTariffResult[] readProductInstanceBillingTariffResult = null;
		long dt = gnvdate;

		try {
			readProductInstanceBillingTariffResult = (ReadProductInstanceBillingTariffResult[]) productInstanceService
					.readProductInstanceBillingTariff_5_1(productInstancePK, dt, Null.LONG, Null.INT);
		} catch (RemoteException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("RemoteException occurred in getOldTariffData method :" + e.getMessage());
			;

			throw new NullParameterException(
					ErrorCodes.ERR_RBM_1000 + " " + e.toString() + " " + Constants.UPDATE_API_NAME);
		} catch (com.convergys.geneva.j2ee.NullParameterException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("NullParameterException occurred in getOldTariffData method :" + e.getMessage());
			;

			 throw new ApplicationException(ErrorCodes.ERR_RBM_2003 +" "+e.toString() +" "+Constants.UPDATE_API_NAME);
		} catch (com.convergys.geneva.j2ee.NoSuchEntityException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("NoSuchEntityException occurred in getOldTariffData method :" + e.getMessage());
			;

			 throw new ApplicationException(ErrorCodes.ERR_RBM_2003 +" "+e.toString() +" "+Constants.UPDATE_API_NAME);
		}

		catch (com.convergys.geneva.j2ee.ApplicationException e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("ApplicationException occurred in getOldTariffData method :" + e.getMessage());
			 throw new ApplicationException(ErrorCodes.ERR_RBM_2003 +" "+e.toString() +" "+Constants.UPDATE_API_NAME);
		}

		if (readProductInstanceBillingTariffResult != null && readProductInstanceBillingTariffResult.length > 0)
			oldData = readProductInstanceBillingTariffResult[0].getHistoriedProductInstanceTariffData();

		return oldData;
	}

	/**
	 * @param modifyProductInstanceData2
	 * @param oldBillingTariff
	 * @return
	 * @author sjoshi1
	 */

	private HistoriedProductInstanceTariffData getNewTariffData(ModifyProductInstanceData modifyProductInstanceData2,
			HistoriedProductInstanceTariffData oldBillingTariff) {
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the NewTariffData  oldBillingTariff: " + oldBillingTariff);
		}

		HistoriedProductInstanceTariffData newTariffData = new HistoriedProductInstanceTariffData();
		BillingTariffPK newBillingTariffPK = new BillingTariffPK();
		newBillingTariffPK.setBillingTariffId(modifyProductInstanceData2.getBillingTariffIdNbl());
		newTariffData.setBillingTariffData(null);
		newTariffData.setBillingTariffPK(newBillingTariffPK);
		newTariffData.setCompetitorBillingTariffData(null);
		newTariffData.setCompetitorBillingTariffPK(null);
		newTariffData.setStartDat(modifyProductInstanceData2.getStartDtm());
		newTariffData.setEndDatNbl(modifyProductInstanceData2.getEndDtmNbl());
		newTariffData.setAdditionsQuantityNbl(oldBillingTariff.getAdditionsQuantityNbl());
		newTariffData.setProductQuantity(oldBillingTariff.getProductQuantity());
		newTariffData.setTerminationsQuantityNbl(oldBillingTariff.getTerminationsQuantityNbl());

		return newTariffData;
	}

	/**
	 * @param modifyProductInstanceAttrData2
	 * @param productId
	 * @return
	 * @author sjoshi1
	 * @throws Exception
	 */

	private ProductAttrPK getProdAttrPKForModify(ModifyProductInstanceAttrData modifyProductInstanceAttrData2,
			int productId) throws Exception {
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the ProdAttrPK For Modify ");
		}
		ProductAttrPK productAttrPK = new ProductAttrPK();
		productAttrPK.setProductId(productId);
		int productAttrSubId = util.getProductAttrSubId(productId,
				modifyProductInstanceAttrData2.getProductAttributeName());
		productAttrPK.setProductAttrSubId(productAttrSubId);
		return productAttrPK;
	}

	/**
	 * @param modifyProductInstanceAttrData2
	 * @param productId
	 * @return
	 * @author sjoshi1
	 * @throws Exception
	 */
	private ModifyHistoriedProductInstanceAttrData getNewProdAttrForModify(
			ModifyProductInstanceAttrData modifyProductInstanceAttrData2, int productId) throws Exception {
		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the  New ProdAttr For Modify ");
		}
		ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = new ModifyHistoriedProductInstanceAttrData();

		ProductAttrPK productAttrPK = getProdAttrPKForModify(modifyProductInstanceAttrData2, productId);
		if(modifyProductInstanceAttrData2.getAttributeValue().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE_VALUE) && modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.SUBSCRIBER_TYPE)){
			modifyHistoriedProductInstanceAttrData.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE) && modifyProductInstanceAttrData2.getAttributeValue().trim().startsWith(Constants.LAST_TERM_RENEWAL_DATE_VALUE)){
			modifyHistoriedProductInstanceAttrData.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE) && modifyProductInstanceAttrData2.getAttributeValue().trim().startsWith(Constants.LAST_RENEWAL_DATE_VALUE)){
			modifyHistoriedProductInstanceAttrData.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE) && modifyProductInstanceAttrData2.getAttributeValue().trim().startsWith(Constants.TERM_EXPIRATION_DATE_VALUE)){
		 	modifyHistoriedProductInstanceAttrData.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getAttributeValue().trim().equalsIgnoreCase(Constants.PLAN_NAME_VALUE) && modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.PLAN_NAME)){
			modifyHistoriedProductInstanceAttrData.setAttributeValue(null);
	    } else if (modifyProductInstanceAttrData2.getAttributeValue().trim().equalsIgnoreCase(Constants.TERM_LENGTH_VALUE) && modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_LENGTH)){
			modifyHistoriedProductInstanceAttrData.setAttributeValue(null);
	    } else{
			
			
			if(modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_TERM_RENEWAL_DATE) || modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.LAST_RENEWAL_DATE)
						 || modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase(Constants.TERM_EXPIRATION_DATE)) {
						 
						 modifyHistoriedProductInstanceAttrData.setAttributeValue(util.checkUTCOffSetValue(modifyProductInstanceAttrData2.getAttributeValue()));
		} else {
			 modifyHistoriedProductInstanceAttrData.setAttributeValue(modifyProductInstanceAttrData2.getAttributeValue());
						 
		}
	    	
	    }
		modifyHistoriedProductInstanceAttrData.setProductAttrPK(productAttrPK);
		Long startDtm = Null.LONG;
		if (startDtm == Null.LONG) {
			if(modifyProductInstanceAttrData2.getProductAttributeName().trim().equalsIgnoreCase("TOMS_TLO_OBJECT_ID")){
				if (modifyProductInstanceAttrData2.getStartDateNbl() < gnvdate) {
					startDtm = getCurrentDay();
				} else {
					startDtm = getDateWithOutTime(modifyProductInstanceAttrData2.getStartDateNbl());
				}
				traceLog.traceFinest("In Side Toms_Tlo_Object_id* " + startDtm);
			}else{
				traceLog.traceFinest("startDtm *****989999******* " + startDtm);
				if (modifyProductInstanceAttrData2.getStartDateNbl() < gnvdate) {
					startDtm = gnvdate;
				}else if (modifyProductInstanceAttrData2.getStartDateNbl() > gnvdate) {
					throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
				}else {
					startDtm = modifyProductInstanceAttrData2.getStartDateNbl();
				}
			}
			traceLog.traceFinest("startDtm *****788888888******* " + startDtm);
		}
		modifyHistoriedProductInstanceAttrData.setFromDat(startDtm);
		if (modifyProductInstanceAttrData2.getEndDateNbl() != Null.LONG) {
			modifyHistoriedProductInstanceAttrData.setToDatNbl(modifyProductInstanceAttrData2.getEndDateNbl());
		}
		return modifyHistoriedProductInstanceAttrData;
	}

	/**
	 * @param historiedProdInstncAttributeData
	 * @param modifyProductInstanceData2
	 * @param modifyProductInstanceAttrData2
	 * @return
	 * @author sjoshi1
	 * @throws Exception
	 */
	private String[] getOldProductAttrValuesForModify(
			HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData,
			ModifyProductInstanceData modifyProductInstanceData2,
			ModifyProductInstanceAttrData modifyProductInstanceAttrData2) throws Exception {

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the Old Prod Attr Value for Modify ");
		}
		
		int prodAttrSubId = util.getProductAttrSubId(modifyProductInstanceData2.getProductId(),
				modifyProductInstanceAttrData2.getProductAttributeName());
		
		String oldValue = null;
		String[] oldValues = null;
		if (historiedProdInstncAttributeData != null && historiedProdInstncAttributeData.length > 0) {
			for (HistoriedProductInstanceAttrData[] historiedProductInstanceAttrDataArray : historiedProdInstncAttributeData) {
				if (historiedProductInstanceAttrDataArray != null) {
					for (HistoriedProductInstanceAttrData historiedProductInstanceAttrData : historiedProductInstanceAttrDataArray) {
						if (historiedProductInstanceAttrData != null
								&& historiedProductInstanceAttrData.getProductAttrPK() != null
								&& historiedProductInstanceAttrData.getProductAttrPK()
										.getProductId() == modifyProductInstanceData2.getProductId()
								&& historiedProductInstanceAttrData.getProductAttrPK()
										.getProductAttrSubId() == prodAttrSubId) {
							if (historiedProductInstanceAttrData.getAttributeValue() != null)
								oldValue = historiedProductInstanceAttrData.getAttributeValue();
							break;
						}
					}
				}
			}
		}
		oldValues = new String[] { oldValue };
		return oldValues;
	}

	/**
	 * @param historiedProdInstncAttributeData
	 * @param modifyProductInstanceData2
	 * @param modifyProductInstanceAttrData2
	 * @return
	 * @author sjoshi1
	 * @throws Exception
	 */
	private String[] getOldProductAttrValuesForModifyForSuspend(
			HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData,
			ModifyProductInstanceData modifyProductInstanceData2, int prodAttrSubId) throws Exception {

		if (traceLog.isFinestEnabled()) {
			traceLog.traceFinest(" To get the Old Prod Attr Value for Modify ");
		}

		String oldValue = null;
		String[] oldValues = null;
		if (historiedProdInstncAttributeData != null && historiedProdInstncAttributeData.length > 0) {
			for (HistoriedProductInstanceAttrData[] historiedProductInstanceAttrDataArray : historiedProdInstncAttributeData) {
				if (historiedProductInstanceAttrDataArray != null) {
					for (HistoriedProductInstanceAttrData historiedProductInstanceAttrData : historiedProductInstanceAttrDataArray) {
						if (historiedProductInstanceAttrData != null
								&& historiedProductInstanceAttrData.getProductAttrPK() != null
								&& historiedProductInstanceAttrData.getProductAttrPK()
										.getProductId() == modifyProductInstanceData2.getProductId()
								&& historiedProductInstanceAttrData.getProductAttrPK()
										.getProductAttrSubId() == prodAttrSubId) {
							if (historiedProductInstanceAttrData.getAttributeValue() != null)
								oldValue = historiedProductInstanceAttrData.getAttributeValue();
							break;
						}
					}
				}
			}
		}
		oldValues = new String[] { oldValue };
		return oldValues;
	}

	/**
	 * @param maxcount
	 * @param productInstancePK
	 * @param eventSource
	 * @param eventSourceService
	 * @return
	 * @throws RemoteException
	 * @throws ApplicationException
	 * @author sjoshi1
	 */
	private HistoriedEventSourceData_6[] readEventSourceArray(int maxcount, ProductInstancePK productInstancePK,
			String eventSource, EventSourceService eventSourceService) throws RemoteException, ApplicationException {
		if (traceLog.isFinerEnabled())
			traceLog.traceFiner("Entering readEventSourceArray method :");
		QueryEventSourceResult_6 queryEventSourceResult = null;
		HistoriedEventSourceData_6[] historiedEventSourceData = null;
		try {
			queryEventSourceResult = eventSourceService.queryEventSource_6(new IntegratorContext_1(), maxcount,
					productInstancePK, gnvdate, eventSource, 3, Null.INT);
			QueryEventSourceResultElement_6[] queryEventSourceResultElement = queryEventSourceResult.getDataSet();
			if (queryEventSourceResultElement != null && queryEventSourceResultElement.length > 0) {
				historiedEventSourceData = new HistoriedEventSourceData_6[queryEventSourceResultElement.length];
				for (int i = 0; i < queryEventSourceResultElement.length; i++) {
					historiedEventSourceData[i] = queryEventSourceResultElement[i].getHistoriedEventSourceData();
					historiedEventSourceData[i]
							.setEventTypeSummary(queryEventSourceResultElement[i].getEventTypeSummary());
				}
			}

		} catch (RemoteException e) {
			if (traceLog.isFineEnabled())
				traceLog.traceFine("RemoteException in readEventSourceArray method" + e.getMessage());

		} catch (Exception e) {
			if (traceLog.isFineEnabled())
				traceLog.traceFine("ApplicationException in readEventSourceArray method" + e.getMessage());
			throw new ApplicationException(ErrorCodes.ERR_RBM_2003 + e.toString());
		}
		if (traceLog.isFinerEnabled())
			traceLog.traceFiner("Exiting readEventSourceArray method:");
		return historiedEventSourceData;

	}

	/**
	 * @param historiedEventSourceDataArray
	 * @param modifyEventSourceData
	 * @return
	 * @author sjoshi1
	 */
	private ModifyEventSourceDataPair_6[] getModifyEventSourceDataPair(
			HistoriedEventSourceData_6[] historiedEventSourceDataArray, ModifyEventSourceData[] modifyEventSourceData)
					throws com.convergys.iml.commonIML.ParameterException {

		traceLog.traceFinest(" To get the ModifyEventSourceDataPair ");
		traceLog.traceFinest("  historiedEventSourceDataArray  " + historiedEventSourceDataArray.toString());

		ModifyEventSourceDataPair_6[] modifyEventSourceDataPair = null;
		if (historiedEventSourceDataArray != null && historiedEventSourceDataArray.length > 0) {
			modifyEventSourceDataPair = new ModifyEventSourceDataPair_6[historiedEventSourceDataArray.length];
			Long startDtm = Null.LONG;
			for (int j = 0; j < historiedEventSourceDataArray.length; j++) {

				modifyEventSourceDataPair[j] = new ModifyEventSourceDataPair_6();
				int eventTypeID = historiedEventSourceDataArray[j].getEventTypeSummary().getEventTypeId();
				for (int i = 0; i < modifyEventSourceData.length; i++) {

					if (eventTypeID == modifyEventSourceData[i].getEventTypeId()) {

						if (startDtm == Null.LONG) {
							traceLog.traceFinest("startDtm *****989999******* " + startDtm);

							if (modifyEventSourceData[i].getStartDtm() < gnvdate) {
								startDtm = gnvdate;
							}else if (modifyEventSourceData[i].getStartDtm() > gnvdate) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
							}else {
								startDtm = modifyEventSourceData[i].getStartDtm();
							}
							traceLog.traceFinest("startDtm *****788888888******* " + startDtm);
						}
						traceLog.traceFinest("startDtm *****788888888**1233***** " + startDtm);

						traceLog.traceFinest("  eventTypeID  " + eventTypeID);
						traceLog.traceFinest(
								"  historiedEventSourceDataArray [j]  " + historiedEventSourceDataArray[j].toString());
						// if(historiedEventSourceData_6.getEventTypeSummary()
						// != null &&
						// historiedEventSourceData_6.getEventTypeSummary().getEventTypeId()
						// == Integer.valueOf(newEventTypeId).intValue()) {

						// setting old values
						ModifyEventSourceData_6 oldModifyEventSourceData = new ModifyEventSourceData_6();
						oldModifyEventSourceData
								.setEventSourceText(historiedEventSourceDataArray[j].getEventSourceTxt());
						oldModifyEventSourceData
								.setCreditLimitMnyNbl(historiedEventSourceDataArray[j].getCreditLimitMnyNbl());
						oldModifyEventSourceData.setEndDtmNbl(historiedEventSourceDataArray[j].getEndDtmNbl());
						oldModifyEventSourceData
								.setEventSource(historiedEventSourceDataArray[j].getEventSourcePK().getEventSource());
						oldModifyEventSourceData
								.setEventSourceLabel(historiedEventSourceDataArray[j].getEventSourceLabel());
						oldModifyEventSourceData.setStartDtm(historiedEventSourceDataArray[j].getStartDtm());
						if (historiedEventSourceDataArray[j].getEventTypeSummary() != null) {
							oldModifyEventSourceData.setEventTypeId(
									historiedEventSourceDataArray[j].getEventTypeSummary().getEventTypeId());
						}
						if (historiedEventSourceDataArray[j].getRatingTariffPK() != null)
							oldModifyEventSourceData
									.setRatingTariffPK(historiedEventSourceDataArray[j].getRatingTariffPK());

						oldModifyEventSourceData.setCompetitorRatingTariffPK(null);
						oldModifyEventSourceData.setCopyGuidingRules(null);

						// setting new values
						ModifyEventSourceData_6 newModifyEventSourceData = new ModifyEventSourceData_6();
						newModifyEventSourceData.setEventSourceText(modifyEventSourceData[i].getEventSourceText());
						newModifyEventSourceData
								.setCreditLimitMnyNbl(historiedEventSourceDataArray[j].getCreditLimitMnyNbl());
						/*
						 * if (modifyEventSourceData[i].getEndDtmNbl() !=
						 * Null.LONG) { newModifyEventSourceData.setEndDtmNbl(
						 * modifyEventSourceData[i] .getEndDtmNbl()); }
						 */
						newModifyEventSourceData.setEventSource(modifyEventSourceData[i].getEventSource());
						newModifyEventSourceData.setEventSourceLabel(modifyEventSourceData[i].getEventSourceLabel());
						newModifyEventSourceData.setStartDtm(startDtm);
						newModifyEventSourceData.setEventTypeId(modifyEventSourceData[i].getEventTypeId());
						RatingTariffPK newRatingTariff = new RatingTariffPK();
						newRatingTariff.setRatingTariffId(modifyEventSourceData[i].getRatingTariffId());
						newModifyEventSourceData.setRatingTariffPK(newRatingTariff);
						newModifyEventSourceData.setCompetitorRatingTariffPK(null);
						newModifyEventSourceData.setCopyGuidingRules(null);
						traceLog.traceFinest("  newModifyEventSourceData  " + newModifyEventSourceData.toString());
						traceLog.traceFinest("  oldModifyEventSourceData  " + oldModifyEventSourceData.toString());
						modifyEventSourceDataPair[j].setNewModifyEventSourceData(newModifyEventSourceData);
						modifyEventSourceDataPair[j].setOldModifyEventSourceData(oldModifyEventSourceData);
					}

				}
			}
		}
		traceLog.traceFinest("  modifyEventSourceDataPair  " + modifyEventSourceDataPair.toString());
		return modifyEventSourceDataPair;

	}

	/**
	 * updateTLOInPricePlanChange during changePlan of parent subscriber..
	 * 
	 * @param modifyProductInstanceAttrData
	 * @param productId
	 * @param productInstancePK
	 * @param modifyProductInstanceData2
	 * @throws java.rmi.RemoteException
	 * @throws com.convergys.iml.commonIML.NullParameterException
	 * @throws com.convergys.platform.ApplicationException
	 * @throws com.convergys.iml.commonIML.ParameterException
	 * @author sjoshi1
	 * 
	 */
	private void updateTLOInPricePlanChange(ModifyProductInstanceAttrData[] modifyProductInstanceAttrData,
			int productId, ProductInstancePK productInstancePK, ModifyProductInstanceData modifyProductInstanceData2)
			throws java.rmi.RemoteException, com.convergys.iml.commonIML.NullParameterException,
			com.convergys.platform.ApplicationException, com.convergys.iml.commonIML.ParameterException {
		traceLog.traceFinest("enetring inside updateTLOInPricePlanChange.....");
		ProductInstanceService productInstanceService = util.getProductInstanceService();
		try {
			String newProdStatus = modifyProductInstanceData2.getProductStatus();
			for (ModifyProductInstanceAttrData modifyProductInstanceAttrData2 : modifyProductInstanceAttrData) {

				// ................Get the new attribute details for modify
				List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();
				ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = getNewProdAttrForModify(
						modifyProductInstanceAttrData2, productId);
				newAttrList.add(modifyHistoriedProductInstanceAttrData);
				ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

				// ..................Get product attribute PK for modify..
				ProductAttrPK productAttrPK = getProdAttrPKForModify(modifyProductInstanceAttrData2, productId);

				// ..................Get ProductInstancePK
				/*
				 * ProductInstancePK productInstancePK = getProductInstancePK(
				 * customerRef, productSeq);
				 */
				if (traceLog.isFinestEnabled()) {
					traceLog.traceFinest("Reading history attribute details of product");
				}

				// ..................Reading history attribute details of
				// product
				HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
						.queryHistoriedProductInstanceAttr_6(new IntegratorContext_1(), productInstancePK,
								productAttrPK, gnvdate, Null.LONG);

				// ...................Derive the old product attribute values to
				// be modified from HistoriedProductInstanceAttrData
				String[] oldValues = getOldProductAttrValuesForModify(historiedProdInstncAttributeData,
						modifyProductInstanceData2, modifyProductInstanceAttrData2);
				traceLog.traceFinest(" inside updateTLOInPricePlanChange..got old attr value...");
				// ...................Modify attributes for the product instance
				// if new attribute vaues are not null
				if (newAttrList != null && newAttrList.size() > 0) {

					modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
							.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
					if (traceLog.isFinestEnabled()) {
						traceLog.traceFinest(
								"Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
										+ modifyHistoriedProdInstncAttrDataArray);
						traceLog.traceFinest("oldValues: " + oldValues);
					}

					// Call core ECA to modify product instance attribute...
					productInstanceService.modifyProductInstanceAttr_6(new IntegratorContext_1(), productInstancePK,
							oldValues, modifyHistoriedProdInstncAttrDataArray);
				}

			}
			//Restore case from SUSPEND to ACTIVE when product_status prod instance attribute is not provided
			if (newProdStatus != null && newProdStatus.equals(Constants.PRODUCT_ACTIVE)) {
				traceLog.traceFinest("Entered RESTORE case");
				Long startDtm = Null.LONG;
				if (startDtm == Null.LONG) {
					traceLog.traceFinest("Restore case startDtm *****123******* " + startDtm);
					if (modifyProductInstanceData2.getStartDtm() < gnvdate) {
						startDtm = gnvdate;
					}else if (modifyProductInstanceData2.getStartDtm() > gnvdate) {
						throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
					}else {
						startDtm = modifyProductInstanceData2.getStartDtm();
					}
					traceLog.traceFinest("Restore case startDtm ****345******** " + startDtm);
				}
				ProductAttrPK productAttrPK = new ProductAttrPK();
				productAttrPK.setProductId(productId);
				productAttrPK.setProductAttrSubId(3);
				
			
				ModifyHistoriedProductInstanceAttrData modifyHistoriedProductInstanceAttrData = new ModifyHistoriedProductInstanceAttrData();

				modifyHistoriedProductInstanceAttrData.setAttributeValue(Constants.PRODUCT_ACTIVE);
				modifyHistoriedProductInstanceAttrData.setProductAttrPK(productAttrPK);
				//long milliSec = 1000;
				modifyHistoriedProductInstanceAttrData.setFromDat(startDtm);


				List<ModifyHistoriedProductInstanceAttrData> newAttrList = new ArrayList<ModifyHistoriedProductInstanceAttrData>();

				newAttrList.add(modifyHistoriedProductInstanceAttrData);
				ModifyHistoriedProductInstanceAttrData[] modifyHistoriedProdInstncAttrDataArray = null;

				// ..................Reading history attribute
				// details of product
				HistoriedProductInstanceAttrData[][] historiedProdInstncAttributeData = productInstanceService
						.queryHistoriedProductInstanceAttr_6(new IntegratorContext_1(), productInstancePK,
								productAttrPK, gnvdate, Null.LONG);
				// ...................Derive the old product
				// attribute values to be modified from
				// HistoriedProductInstanceAttrData
				String[] oldValues = getOldProductAttrValuesForModifyForSuspend(
						historiedProdInstncAttributeData, modifyProductInstanceData2, 3);
				
				 List<String> list = Arrays.asList(oldValues);      
				//List<String> list = new Arrays.oldValues(oldValues);
			        
			        if(list.contains("SUSPEND")){
			            System.out.println("Old attribute is suspend");
			        }

				// ...................Modify attributes for the
				// product instance if new attribute vaues are
				// not null
				if (list.contains("SUSPEND") && newAttrList != null && newAttrList.size() > 0) {

					modifyHistoriedProdInstncAttrDataArray = (ModifyHistoriedProductInstanceAttrData[]) newAttrList
							.toArray(new ModifyHistoriedProductInstanceAttrData[newAttrList.size()]);
					if (traceLog.isFinestEnabled()) {
						traceLog.traceFinest(
								"Restore case: Before calling modifyProductInstanceAttr_6, modifyHistoriedProdInstncAttrDataArray: "
										+ modifyHistoriedProdInstncAttrDataArray);
						traceLog.traceFinest("oldValues: " + oldValues);
					}
					// Call core ECA to modify product instance
					// attribute...
					productInstanceService.modifyProductInstanceAttr_6(new IntegratorContext_1(),
							productInstancePK, oldValues, modifyHistoriedProdInstncAttrDataArray);
				}
				else
				{
					traceLog.traceFinest("Restore case: Product attribute status and product status are same i.e., ACTIVE");
				}

			}//Restore case end		

		} catch (Exception e) {
			if (traceLog.isFinestEnabled())
				traceLog.traceFinest("Exception occurred in updateTLOInPricePlanChange :" + e.getMessage());
			throw new ApplicationException(
					e.toString() + " in updateTLOInPricePlanChange " + Constants.UPDATE_API_NAME);
		}
	}

	/**
	 * @param historiedEventSourceDataArray
	 * @param modifyEventSourceData
	 * @return
	 * @author sjoshi1
	 */
	private ModifyEventSourceDataPair_6[] getModifyEventSourceDataPairPlanChange(
			HistoriedEventSourceData_6[] historiedEventSourceDataArray, ModifyEventSourceData[] modifyEventSourceData)
					throws com.convergys.iml.commonIML.ParameterException {

		traceLog.traceFinest(" To get the ModifyEventSourceDataPair in getModifyEventSourceDataPairPlanChange ");
		traceLog.traceFinest("  historiedEventSourceDataArray  " + historiedEventSourceDataArray.toString());

		ModifyEventSourceDataPair_6[] modifyEventSourceDataPair = null;
		if (historiedEventSourceDataArray != null && historiedEventSourceDataArray.length > 0) {
			modifyEventSourceDataPair = new ModifyEventSourceDataPair_6[historiedEventSourceDataArray.length];
			Long startDtm = Null.LONG;
			for (int j = 0; j < historiedEventSourceDataArray.length; j++) {

				modifyEventSourceDataPair[j] = new ModifyEventSourceDataPair_6();
				int eventTypeID = historiedEventSourceDataArray[j].getEventTypeSummary().getEventTypeId();
				for (int i = 0; i < modifyEventSourceData.length; i++) {

					if (eventTypeID == modifyEventSourceData[i].getEventTypeId()) {

						if (startDtm == Null.LONG) {
							traceLog.traceFinest("startDtm *****989999******* " + startDtm);

							if (modifyEventSourceData[i].getStartDtm() < gnvdate) {
								startDtm = gnvdate;
							}else if (modifyEventSourceData[i].getStartDtm() > gnvdate) {
								throw new ParameterException(ErrorCodes.ERR_RBM_1015, Constants.UPDATE_API_NAME);
							}else {
								startDtm = modifyEventSourceData[i].getStartDtm();
							}
							traceLog.traceFinest("startDtm *****788888888******* " + startDtm);
						}
						traceLog.traceFinest("startDtm *****788888888**1233***** " + startDtm);

						traceLog.traceFinest("  eventTypeID  " + eventTypeID);
						traceLog.traceFinest(
								"  historiedEventSourceDataArray [j]  " + historiedEventSourceDataArray[j].toString());
						// if(historiedEventSourceData_6.getEventTypeSummary()
						// != null &&
						// historiedEventSourceData_6.getEventTypeSummary().getEventTypeId()
						// == Integer.valueOf(newEventTypeId).intValue()) {

						// setting old values
						ModifyEventSourceData_6 oldModifyEventSourceData = new ModifyEventSourceData_6();
						oldModifyEventSourceData
								.setEventSourceText(historiedEventSourceDataArray[j].getEventSourceTxt());
						oldModifyEventSourceData
								.setCreditLimitMnyNbl(historiedEventSourceDataArray[j].getCreditLimitMnyNbl());
						oldModifyEventSourceData.setEndDtmNbl(historiedEventSourceDataArray[j].getEndDtmNbl());
						oldModifyEventSourceData
								.setEventSource(historiedEventSourceDataArray[j].getEventSourcePK().getEventSource());
						oldModifyEventSourceData
								.setEventSourceLabel(historiedEventSourceDataArray[j].getEventSourceLabel());
						oldModifyEventSourceData.setStartDtm(historiedEventSourceDataArray[j].getStartDtm());
						if (historiedEventSourceDataArray[j].getEventTypeSummary() != null) {
							oldModifyEventSourceData.setEventTypeId(
									historiedEventSourceDataArray[j].getEventTypeSummary().getEventTypeId());
						}
						if (historiedEventSourceDataArray[j].getRatingTariffPK() != null)
							oldModifyEventSourceData
									.setRatingTariffPK(historiedEventSourceDataArray[j].getRatingTariffPK());

						oldModifyEventSourceData.setCompetitorRatingTariffPK(null);
						oldModifyEventSourceData.setCopyGuidingRules(null);

						// setting new values
						ModifyEventSourceData_6 newModifyEventSourceData = new ModifyEventSourceData_6();
						newModifyEventSourceData.setEventSourceText(modifyEventSourceData[i].getEventSourceText());
						newModifyEventSourceData
								.setCreditLimitMnyNbl(historiedEventSourceDataArray[j].getCreditLimitMnyNbl());
						/*
						 * if (modifyEventSourceData[i].getEndDtmNbl() !=
						 * Null.LONG) { newModifyEventSourceData.setEndDtmNbl(
						 * modifyEventSourceData[i] .getEndDtmNbl()); }
						 */
						newModifyEventSourceData.setEventSource(modifyEventSourceData[i].getEventSource());
						newModifyEventSourceData.setEventSourceLabel(modifyEventSourceData[i].getEventSourceLabel());
						newModifyEventSourceData.setStartDtm(historiedEventSourceDataArray[j].getStartDtm());
						// newModifyEventSourceData.setStartDtm(startDtm);
						// newModifyEventSourceData.setStartDtm(modifyEventSourceData[i].getStartDtm());
						newModifyEventSourceData.setEventTypeId(modifyEventSourceData[i].getEventTypeId());
						RatingTariffPK newRatingTariff = new RatingTariffPK();
						newRatingTariff.setRatingTariffId(modifyEventSourceData[i].getRatingTariffId());
						newModifyEventSourceData.setRatingTariffPK(newRatingTariff);
						newModifyEventSourceData.setCompetitorRatingTariffPK(null);
						newModifyEventSourceData.setCopyGuidingRules(null);
						traceLog.traceFinest("  newModifyEventSourceData  " + newModifyEventSourceData.toString());
						traceLog.traceFinest("  oldModifyEventSourceData  " + oldModifyEventSourceData.toString());
						modifyEventSourceDataPair[j].setNewModifyEventSourceData(newModifyEventSourceData);
						modifyEventSourceDataPair[j].setOldModifyEventSourceData(oldModifyEventSourceData);
					}

				}
			}
		}
		traceLog.traceFinest("  modifyEventSourceDataPair  " + modifyEventSourceDataPair.toString());
		return modifyEventSourceDataPair;

	}

	public Util getUtil() {
		return util;
	}

	public void setUtil(Util util) {
		this.util = util;
	}
	
	
	 private long getCurrentDay() {
	       // long millisInDay = 60 * 60 * 24 * 1000;
	        long theDay = Null.LONG;
	        DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
	        Date today = new Date(gnvdate);

	        try {
	            Date todayWithZeroTime = formatter.parse(formatter.format(today));
	            theDay = todayWithZeroTime.getTime() ;

	            traceLog.traceFinest(" end date:" + new Date(theDay));

	        } catch (Exception e) {
	            traceLog.traceFinest(e.getMessage());
	        }
	        return theDay;
	    }
	 
	 private long getDateWithOutTime(long startDtm) {
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
