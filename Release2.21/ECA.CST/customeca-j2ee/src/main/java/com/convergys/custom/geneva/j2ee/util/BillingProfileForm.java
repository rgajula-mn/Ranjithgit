package com.convergys.custom.geneva.j2ee.util;

import java.io.Serializable;
import java.util.Date;


/*******************************************************************************

/**
 * 
 * 
 * @author tkon2950
 */

public class BillingProfileForm  implements Serializable{

	private static final long serialVersionUID = 2115232376303060742L;

	private String wholesaleTransId;
	private String serviceName;
	private String accountNum;
	private String eventsource;
	private int status;
	private Date completedDtm;
	private Date createdDtm;
	private String requestDetails;
	private String responseDetails;
	private String customerRef;
	
	private String node;
	private String duration;
	

    public String getWholesaleTransId() {
		return wholesaleTransId;
	}
	public void setWholesaleTransId(String wholesaleTransId) {
		this.wholesaleTransId = wholesaleTransId;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getAccountNum() {
		return accountNum;
	}
	public void setAccountNum(String accountNum) {
		this.accountNum = accountNum;
	}
	public String getEventsource() {
		return eventsource;
	}
	public void setEventsource(String eventsource) {
		this.eventsource = eventsource;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCompletedDtm() {
		return completedDtm;
	}
	public void setCompletedDtm(Date completedDtm) {
		this.completedDtm = completedDtm;
	}
	public Date getCreatedDtm() {
		return createdDtm;
	}
	public void setCreatedDtm(Date createdDtm) {
		this.createdDtm = createdDtm;
	}
	public String getResponseDetails() {
		return responseDetails;
	}
	public void setResponseDetails(String responseDetails) {
		this.responseDetails = responseDetails;
	}
	public String getRequestDetails() {
		return requestDetails;
	}
	public void setRequestDetails(String requestDetails) {
		this.requestDetails = requestDetails;
	}
    public String getCustomerRef() {
        return customerRef;
    }
    public void setCustomerRef(String customerRef) {
        this.customerRef = customerRef;
    }
    
    public String getNode() {
        return node;
    }
    public void setNode(String node) {
        this.node = node;
    }

    public String getDuration() {
        return duration;
    }
    public void setDuration(String duration) {
        this.duration = duration;
    }
}