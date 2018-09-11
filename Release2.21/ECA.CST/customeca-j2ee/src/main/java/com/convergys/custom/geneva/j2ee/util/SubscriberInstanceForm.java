package com.convergys.custom.geneva.j2ee.util;

import java.io.Serializable;
import java.sql.Date;



/**
 * This Class holds the values for the queryLastRatedUsageDtmByType
 * 
 * @author sgad2315(Sreekanth Gade
 */

public class SubscriberInstanceForm  implements Serializable{

	
    private static final long serialVersionUID = 8135131069014063432L;
    
    private String msisdnInput;
    private String msisdnChange;
    private String customerRefActive ;
    private int productSeqActive ;
    private String customerRefMostRecentActive ;
    private int productSeqMostRecentActive ;
    private boolean activeSubscriberMostRecent;
    private boolean msisdnChanged;
    private boolean activeSubscriber;
    
    
    public String getMsisdnInput() {
        return msisdnInput;
    }
    public void setMsisdnInput(String msisdnInput) {
        this.msisdnInput = msisdnInput;
    }
    public String getMsisdnChange() {
        return msisdnChange;
    }
    public void setMsisdnChange(String msisdnChange) {
        this.msisdnChange = msisdnChange;
    }
    public String getCustomerRefActive() {
        return customerRefActive;
    }
    public void setCustomerRefActive(String customerRefActive) {
        this.customerRefActive = customerRefActive;
    }
    public int getProductSeqActive() {
        return productSeqActive;
    }
    public void setProductSeqActive(int productSeqActive) {
        this.productSeqActive = productSeqActive;
    }
    public boolean isMsisdnChanged() {
        return msisdnChanged;
    }
    public void setMsisdnChanged(boolean msisdnChanged) {
        this.msisdnChanged = msisdnChanged;
    }
    public boolean isActiveSubscriber() {
        return activeSubscriber;
    }
    public void setActiveSubscriber(boolean activeSubscriber) {
        this.activeSubscriber = activeSubscriber;
    }
    
    public String getCustomerRefMostRecentActive() {
        return customerRefMostRecentActive;
    }
    public void setCustomerRefMostRecentActive(String customerRefMostRecentActive) {
        this.customerRefMostRecentActive = customerRefMostRecentActive;
    }
    public int getProductSeqMostRecentActive() {
        return productSeqMostRecentActive;
    }
    public void setProductSeqMostRecentActive(int productSeqMostRecentActive) {
        this.productSeqMostRecentActive = productSeqMostRecentActive;
    }
    public boolean isActiveSubscriberMostRecent() {
        return activeSubscriberMostRecent;
    }
    public void setActiveSubscriberMostRecent(boolean activeSubscriberMostRecent) {
        this.activeSubscriberMostRecent = activeSubscriberMostRecent;
    }
    

}