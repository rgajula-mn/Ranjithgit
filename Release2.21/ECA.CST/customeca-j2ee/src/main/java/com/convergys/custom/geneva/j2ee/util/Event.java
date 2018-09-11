/*******************************************************************************
 *
 * This file contains proprietary information of Convergys, Inc.
 * Copying or reproduction without prior written approval is prohibited.
 * Copyright (C) 2009  Convergys, Inc.  All rights reserved.
 *
 *******************************************************************************/
package com.convergys.custom.geneva.j2ee.util;

import java.text.ParseException;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.convergys.logging.TraceLog;
//import com.convergys.wpf.util.StringUtil;

/**
 * Event class
 * 
 * @author danny.feng
 */
@SuppressWarnings("rawtypes")
public class Event extends BaseObject implements Map {
    private static TraceLog log = new TraceLog(HashMapPlus.class);
    
    private static final long serialVersionUID = 4032179396422814434L;

    private static final String DATETIME_PATTERN = "yyyyMMddHHmmss";
    private static final String DATETIME_MASK = "MM/dd/yyyy HH:mm:ss";
    private static final String PLMN_PREFIX = "International";
    private static final String VOICE = "VOICE";
    private static final String SMS = "SMS";
    private static final String MMS = "MMS";
    private static final String GPRS = "GPRS";
    private static final String NO = "N";
    private static final String YES = "Y";
    private static final String NOT_APPLICABLE = "";
    private static final String INTERNATIONAL = "international";
    private static final String DIRECTORY_ASSISTANCE = "directory assistance";
    private static final String LONG_DISTANCE = "long distance";
    private static final String STANDARD = "STANDARD";
    private static final String MVNO = "Wholesale";
    private static final String VAR_ACCOUNT = "VAR";
    private static final String MOBILE_TERMINATING = "1";
    private static final String MOBILE_ORIGINATING = "0";
    private static final double MILLION_FACTOR = 1000000;
    private static final double PRECISION = 0.000001;
    private static final String VODAFONE = "ACC000140";

    private boolean marked;
    private Integer id;
    private String name;
    private String source;
    private Integer currencyFactor;
    private Map<String, Object> attributes;

    /**
     * Default constructor - creates a new instance with no values set.
     */
    public Event(final int currencyFactor) {
        this.currencyFactor = currencyFactor;
    }

    /**
     * Check if this object is equal to another Event object
     * 
     * @param obj
     *            object
     * @return true/false
     */
    public boolean equals(final Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof Event)) {
            return false;
        }

        final Event attr = (Event) obj;

        if (id == null || attr.getId() == null) {
            return false;
        }
        return id.equals(attr.getId());
    }

    /**
     * Return a hash code for this object
     * 
     * @return hash code
     */
    public int hashCode() {
        return (id != null ? id.hashCode() : 0);
    }

    /**
     * Return a formatted string for this object
     * 
     * @return string
     */
    public String toString() {
        ToStringBuilder sb = new ToStringBuilder(this, ToStringStyle.DEFAULT_STYLE).append("id", this.id)
                .append("name", this.name).append("source", NOT_APPLICABLE);

        return sb.toString();
    }

    /**
     * Get identifier
     * 
     * @return identifier
     */
    public Integer getId() {
        return id;
    }

    /**
     * Set identifier
     * 
     * @param id
     *            identifier
     */
    public void setId(final Integer id) {
        this.id = id;
    }

    /**
     * Return if is marked or not
     * 
     * @return true/false
     */
    public boolean isMarked() {
        return marked;
    }

    /**
     * @param marked
     */
    public void setMarked(boolean marked) {
        this.marked = marked;
    }

    /**
     * Get name
     * 
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * Set name
     * 
     * @param name
     *            name
     */
    public void setName(final String name) {
        this.name = name;
    }

    /**
     * Get source
     * 
     * @return source
     */
    public String getSource() {
        return source;
    }

    /**
     * Set source
     * 
     * @param source
     *            event source
     */
    /*public void setSource(final String source) {
        // assume all event sources are MDNs
        this.source = StringUtil.formatMdn(source);
    }*/

    /**
     * Get currency factor
     * 
     * @return
     */
    public Integer getCurrencyFactor() {
        return currencyFactor;
    }

    /**
     * Return attributes
     * 
     * @return attributes Map
     */
    public Map<String, Object> getAttributes() {
        if (attributes == null) {
            attributes = new HashMap<String, Object>();
        }
        return attributes;
    }

    /**
     * Set attributes
     * 
     * @param attributes
     *            attributes Map
     */
    public void setAttributes(final Map<String, Object> attributes) {
        this.attributes = attributes;
    }

    /**
     * Return an attribute identfied by name
     * 
     * @param name
     *            name
     * @return attribute
     */
    public Object getAttributeByName(final String name) {
        Object value = getAttributes().get(name.toUpperCase());
        if (value == null) {
            value = NOT_APPLICABLE;
        }
        return value;
    }

    /**
     * Parse a string to double
     * 
     * @param valueObj
     *            value
     * @return double value
     */
    public Double getDouble(final Object valueObj) {
        Double value = new Double(0);
        try {
            if (valueObj instanceof String) {
                value = Double.parseDouble((String) valueObj);
            } else if (valueObj instanceof Number) {
                value = ((Number) valueObj).doubleValue();
            } else {
                log.traceFinest("Cannot convert string '" + valueObj + "' to a number.");
            }
        } catch (NumberFormatException nfe) {
            if (valueObj.toString().length() > 0) {
                log.traceFinest("Cannot convert string '" + valueObj + "' to a number.");
            }
        }
        return value;
    }

    /**
     * Parse a string to long
     * 
     * @param valueObj
     *            value
     * @return long value
     */
    public Long getLong(final Object valueObj) {
        Long value = new Long(0);
        try {
            if (valueObj instanceof String) {
                value = Long.parseLong((String) valueObj);
            } else if (valueObj instanceof Number) {
                value = ((Number) valueObj).longValue();
            } else {
                log.traceFinest("Cannot convert string '" + valueObj + "' to a number.");
            }
        } catch (NumberFormatException nfe) {
            log.traceFinest("Cannot convert string '" + valueObj + "' to a number.");
        }
        return value;
    }

    /**
     * create a new attribute defined by name
     * 
     * @param name
     *            name
     * @param value
     *            value
     */
    public void setAttributeByName(final String name, final Object value) {
        getAttributes().put(name.toUpperCase(), value);
    }

    /**
     * Call proper method to calculate field values based on event type
     * 
     * @return void
     */
    public void calculateFields() {
        if (name.contains(VOICE)) {
            calculateVoiceFields();
        } else if (name.contains(SMS)) {
            calculateSmsFields();
        } else if (name.contains(MMS)) {
            calculateMmsFields();
        } else if (name.contains(GPRS)) {
            calculateGprsFields();
        }
    }

    /**
     * Business logic for Voice events
     * 
     * @return void
     */
    public void calculateVoiceFields() {
        // answerTimeDurRoundMin rules
        Long sec = null;
        sec = getLong(getAttributeByName("answerTimeDurRoundMin").toString());
        sec = sec / 60;

        // answerTimeCallDurSec rules
        String[] timeTokens = ((String) getAttributeByName("answerTimeCallDurSec")).split("[:]");
        Long time = new Long(0);
        if (timeTokens.length == 3) {
            time = 3600 * getLong(timeTokens[0]) + 60 * getLong(timeTokens[1]) + getLong(timeTokens[2]);
        }
        setAttributeByName("answerTimeCallDurSec", time);
        setAttributeByName("answerTimeDurRoundMin", sec);
        setAttributeByName("source", getAttributeByName("event_attr_11"));
        setAttributeByName("target", getAttributeByName("event_attr_10"));
        setAttributeByName("billDate", formattedDateTime(getAttributeByName("billDate").toString()));
        setAttributeByName("time", formattedDateTime(getAttributeByName("channelSeizureDt").toString()));
        setAttributeByName("createtime", formattedDateTime(getAttributeByName("createtime").toString()));
        setAttributeByName("volume", getAttributeByName("answerTimeCallDurSec"));
        // callToTn rules
        if (getAttributeByName("event_attr_9").equals("0")) {
            setAttributeByName("callToTn", getAttributeByName("event_attr_10"));
        } else {
            setAttributeByName("callToTn", getAttributeByName("event_attr_11"));
        }

        Double value = getDouble(getAttributeByName("airTime")) / MILLION_FACTOR;

        //vodafone rule
        value = getAttributeByName("accountNumber").toString().equalsIgnoreCase(VODAFONE)
                && getLong(getAttributeByName("onNet").toString()) == 0 ? 0 : value;

        setAttributeByName("airTime", formattedDouble(value));

        value = getDouble(getAttributeByName("airChargeAmount")) / currencyFactor;
        setAttributeByName("airChargeAmount", formattedDouble(value));
        value = getDouble(getAttributeByName("event_attr_24")) / currencyFactor;
        setAttributeByName("tollChargeAmount", formattedDouble(value));

        String tollChargeCode = "0";
        String attr = "";
        if (value != 0) {
            attr = getAttributeByName("event_attr_30").toString().toLowerCase();
            if (getAttributeByName("onNet").toString().compareTo("0") == 0
                    || getAttributeByName("onNet").toString().compareTo("4") == 0) {
                if (attr.contains(LONG_DISTANCE)) {
                    tollChargeCode = "1";
                } else if (attr.contains(DIRECTORY_ASSISTANCE)) {
                    tollChargeCode = "5";
                } else if (attr.contains(INTERNATIONAL)) {
                    tollChargeCode = "4";
                }
            } else {
                if (attr.contains(LONG_DISTANCE)) {
                    tollChargeCode = "2";
                } else if (attr.contains(DIRECTORY_ASSISTANCE)) {
                    tollChargeCode = "6";
                } else if (attr.contains(INTERNATIONAL)) {
                    tollChargeCode = "3";
                }
            }
        }
        setAttributeByName("tollChargeCode", tollChargeCode);

        if (getAttributeByName("onNet").toString().compareTo("0") == 0
                || getAttributeByName("onNet").toString().compareTo("4") == 0) {
            setAttributeByName("onNetworkFlag", YES);
        } else {
            setAttributeByName("onNetworkFlag", NO);
        }

        if (name.toLowerCase().contains(INTERNATIONAL)) {
            if (getAttributeByName("customerType").equals(VAR_ACCOUNT)
                    && getAttributeByName("countryName").toString().length() > 0) {
                setAttributeByName("countryName", getAttributeByName("countryName").toString()
                        .replaceAll(PLMN_PREFIX, NOT_APPLICABLE).replaceAll("[-]", NOT_APPLICABLE));
            }
            setAttributeByName("callToPlace", NOT_APPLICABLE);
            setAttributeByName("callToRegion", NOT_APPLICABLE);
            setAttributeByName("airChargeCode", "3");
        } else {
            setAttributeByName("countryName", "");
            // airChargeCode rules
            if (getAttributeByName("onNet").toString().compareTo("0") == 0
                    || getAttributeByName("onNet").toString().compareTo("4") == 0) {
                setAttributeByName("airChargeCode", "1");
            } else {
                setAttributeByName("airChargeCode", "2");
            }
        }

        // tollChargeCode rules
        if (getAttributeByName("onNet").toString().length() == 0) {
            setAttributeByName("tollChargeCode", "0");
        }

        // tollRate rules
        if (getAttributeByName("tollChargeCode").equals("5") || getAttributeByName("tollChargeCode").equals("6")) {
            value = getDouble(getAttributeByName("event_attr_24")) / currencyFactor;
            setAttributeByName("tollRate", formattedDouble(value));
        } else {
            Double factor = getDouble(getAttributeByName("event_attr_35"));
            if (factor > 0) {
                value = getDouble(getAttributeByName("event_attr_24"));
                value = (value / factor) / currencyFactor;
                setAttributeByName("tollRate", String.format("%.5f", value));
            }
        }
    }

    /**
     * Business logic for SMS events
     * 
     * @return void
     */
    public void calculateSmsFields() {
        setAttributeByName("source", getAttributeByName("event_attr_11"));
        setAttributeByName("target", getAttributeByName("event_attr_10"));
        setAttributeByName("time", formattedDateTime(getAttributeByName("channelSeizureDt").toString()));
        setAttributeByName("createtime", formattedDateTime(getAttributeByName("createtime").toString()));
        setAttributeByName("volume", Long.valueOf(1));
        // callToTn rules
        if (getAttributeByName("event_attr_9").toString().equalsIgnoreCase("MO")) {
            setAttributeByName("callToTn", getAttributeByName("event_attr_10"));
        } else {
            setAttributeByName("callToTn", getAttributeByName("event_attr_11"));
        }
        // airChargeCode rules
        if (name.toLowerCase().contains(INTERNATIONAL)) {
            if (getAttributeByName("countryName").toString().length() > 0) {
                setAttributeByName("countryName", getAttributeByName("countryName").toString()
                        .replaceAll(PLMN_PREFIX, NOT_APPLICABLE).replaceAll("[-]", NOT_APPLICABLE));
            }
            setAttributeByName("callToPlace", NOT_APPLICABLE);
            setAttributeByName("callToRegion", NOT_APPLICABLE);
            setAttributeByName("airChargeCode", "6");
            setAttributeByName("onNetworkFlag", NO);
        } else {
            setAttributeByName("countryName", "");
            String attr = getAttributeByName("romerFlag").toString();
            if (attr.compareTo("0") == 0) {
                setAttributeByName("airChargeCode", "4");
                setAttributeByName("onNetworkFlag", YES);
            } else {
                if (attr.compareTo("1") == 0) {
                    setAttributeByName("airChargeCode", "5");
                } else if (attr.compareTo("2") == 0) {
                    setAttributeByName("airChargeCode", "6");
                }
                setAttributeByName("onNetworkFlag", NO);
            }
        }
        Double value = getDouble(getAttributeByName("airChargeAmount")) / currencyFactor;
        setAttributeByName("airChargeAmount", formattedDouble(value));
        setAttributeByName("tollChargeAmount", "0");
        setAttributeByName("tollRate", "0");
        setAttributeByName("tollChargeCode", "0");
        setAttributeByName("answerTimeDurRoundMin", "1");
        setAttributeByName("answerTimeCallDurSec", "1");
        setAttributeByName("billDate", formattedDateTime(getAttributeByName("billDate").toString()));

        value = getDouble(getAttributeByName("airTime")) / currencyFactor;

        //vodafone rule
        value = getAttributeByName("accountNumber").toString().equalsIgnoreCase(VODAFONE)
                && getLong(getAttributeByName("romerFlag").toString()) == 4 ? 0 : value;

        setAttributeByName("airTime", formattedDouble(value));

        // callDirection rules
        if (getAttributeByName("event_attr_9").toString().equalsIgnoreCase("MO")) {
            setAttributeByName("callDirection", MOBILE_ORIGINATING);
        } else {
            setAttributeByName("callDirection", MOBILE_TERMINATING);
        }
    }

    /**
     * Business logic for MMS events
     * 
     * @return void
     */
    public void calculateMmsFields() {
        setAttributeByName("source", getAttributeByName("msisdn"));
        setAttributeByName("target", getAttributeByName("accessPointName"));
        setAttributeByName("time", formattedDateTime(getAttributeByName("recordStartTime").toString()));
        setAttributeByName("createtime", formattedDateTime(getAttributeByName("createtime").toString()));
        setAttributeByName("volume", getLong(getAttributeByName("totalVolume").toString()));
        setAttributeByName("onNetworkFlag", NOT_APPLICABLE);
        Double value = getDouble(getAttributeByName("event_cost_mny")) / currencyFactor;
        setAttributeByName("dataChargeAmount", formattedDouble(value));
        value = getDouble(getAttributeByName("airChargeAmount")) / currencyFactor;
        setAttributeByName("airChargeAmount", formattedDouble(value));
        // duration rules
        String[] timeTokens = getAttributeByName("duration").toString().split("[:]");
        Long time = new Long(0);
        if (timeTokens.length == 3) {
            time = 3600 * getLong(timeTokens[0]) + 60 * getLong(timeTokens[1]) + getLong(timeTokens[2]);
        }
        setAttributeByName("duration", time);
        value = getDouble(getAttributeByName("dataRate")) / currencyFactor;

        //vodafone rule
        value = getAttributeByName("accountNumber").toString().equalsIgnoreCase(VODAFONE) ? 0 : value;

        setAttributeByName("billDate", formattedDateTime(getAttributeByName("billDate").toString()));
        setAttributeByName("dataRate", formattedDouble(value));

        int chargeCode = 4;
        String roamingIndicator = getAttributeByName("roamingIndicator").toString();
        if (roamingIndicator.compareToIgnoreCase("h") == 0) {
            chargeCode = 4;
        } else if (roamingIndicator.compareToIgnoreCase("d") == 0) {
            chargeCode = 5;
        } else if (roamingIndicator.compareToIgnoreCase("i") == 0) {
            chargeCode = 6;
        }
        setAttributeByName("dataChargeCode", chargeCode);
    }

    /**
     * Business logic for GPRS events
     * 
     * @return void
     */
    public void calculateGprsFields() {
        Long number = getLong(getAttributeByName("uplinkVolume").toString());
        setAttributeByName("uplinkVolume", number);
        number = getLong(getAttributeByName("downlinkVolume").toString());
        setAttributeByName("downlinkVolume", number);

        Double value = getDouble(getAttributeByName("event_cost_mny")) / currencyFactor;

        //vodafone rule
        value = getAttributeByName("accountNumber").toString().equalsIgnoreCase(VODAFONE)
                && getAttributeByName("eventClass").toString().indexOf("standard") != -1 ? 0 : value;

        setAttributeByName("dataChargeAmount", formattedDouble(value));
        value = getDouble(getAttributeByName("dataRate")) / MILLION_FACTOR;

        //vodafone rule
        value = getAttributeByName("accountNumber").toString().equalsIgnoreCase(VODAFONE)
                && getAttributeByName("eventClass").toString().indexOf("standard") != -1 ? 0 : value;

        setAttributeByName("dataRate", formattedDouble(value));

        value = getDouble(getAttributeByName("event_attr_29"));
        if (getAttributeByName("customerType").equals(MVNO)) {
            value = value / 1024 / 1024;
        }

        setAttributeByName("recordingEntity", getAttributeByName("recordingEntity"));
        setAttributeByName("totalVolume", formattedDouble(value));
        setAttributeByName("source", getAttributeByName("msisdn"));
        setAttributeByName("target", getAttributeByName("accessPointName"));
        setAttributeByName("time", formattedDateTime(getAttributeByName("recordStartTime").toString()));
        setAttributeByName("createtime", formattedDateTime(getAttributeByName("createtime").toString()));
        setAttributeByName("volume", getLong(getAttributeByName("totalVolume").toString()));

        // dataChargeCode rules
        if (getAttributeByName("event_attr_26").toString().toUpperCase().contains(STANDARD)) {
            setAttributeByName("dataChargeCode", "1");
            setAttributeByName("onNetworkFlag", YES);
        } else {
            setAttributeByName("dataChargeCode", "2");
            setAttributeByName("onNetworkFlag", NO);
        }

        if (name.toLowerCase().contains(INTERNATIONAL)) {
            setAttributeByName("callToPlace", NOT_APPLICABLE);
            setAttributeByName("callToRegion", NOT_APPLICABLE);
            if (getAttributeByName("accountNumber").toString().equalsIgnoreCase(VODAFONE)
                    && getLong(getAttributeByName("romerFlag").toString()) == 3) {
                setAttributeByName("dataChargeCode", "7");
            } else {
                setAttributeByName("dataChargeCode", "3");
            }
            if (getAttributeByName("customerType").equals(VAR_ACCOUNT)
                    && getAttributeByName("countryName").toString().length() > 0) {
                setAttributeByName("countryName", getAttributeByName("countryName").toString()
                        .replaceAll(PLMN_PREFIX, NOT_APPLICABLE).replaceAll("[-]", NOT_APPLICABLE));
            }
        }
        String[] timeTokens = getAttributeByName("duration").toString().split("[:]");
        Long time = Long.valueOf(0);
        if (timeTokens.length == 3) {
            time = 3600 * getLong(timeTokens[0]) + 60 * getLong(timeTokens[1]) + getLong(timeTokens[2]);
        }
        setAttributeByName("duration", time);
        setAttributeByName("billDate", formattedDateTime(getAttributeByName("billDate").toString()));
    }

    /**
     * Format double field to remove right zero
     * 
     * @param value
     * @return formatted value
     */
    private String formattedDouble(final double value) {
        String formatted = Math.abs(value) > PRECISION
                ? String.format("%.6f", value).replaceAll("[.,]*(0*)$", NOT_APPLICABLE) : "0";
        return formatted;
    }

    /**
     * Format datetime field to date pattern used
     * 
     * @param attributeByName
     * @return formatted datetime
     */
    private String formattedDateTime(final String attr) {
        Date date = null;
        try {
            if (attr == null || attr.length() == 0) {
                return "";
            }
            date = DateUtil.convertStringToDate(DATETIME_PATTERN, attr);
            return DateUtil.getDateTime(DATETIME_MASK, date);
        } catch (ParseException e) {
            log.traceFinest("formattedDateTime failed for " + attr);
        }
        return NOT_APPLICABLE;
    }

    /*
     * the interface Map is implemented to allow the View to have a single
     * interface to retrieve information of attributes avoiding to create
     * getter/setter methods for each possible attribute that a subscriber can
     * have
     */

    /**
     * Implementation for clear method
     * 
     * @see java.util.Map#clear()
     */
    public void clear() {
        getAttributes().clear();
    }

    /**
     * Implementation for containsKey method
     * 
     * @param key
     *            key
     * @see java.util.Map#containsKey(java.lang.Object)
     * @return boolean
     */
    public boolean containsKey(final Object key) {
        return getAttributes().containsKey(key);
    }

    /**
     * Implementation for containsValue method
     * 
     * @param value
     *            value
     * @see java.util.Map#containsValue(java.lang.Object)
     * @return boolean
     */
    public boolean containsValue(final Object value) {
        return getAttributes().containsValue(value);
    }

    /**
     * Implementation for entrySet method
     * 
     * @see java.util.Map#entrySet()
     * @return entry
     */
    public Set entrySet() {
        return getAttributes().entrySet();
    }

    /**
     * Implementation for get method
     * 
     * @param key
     *            key
     * @see java.util.Map#get(java.lang.Object)
     * @return object
     */
    public Object get(final Object key) {
        if (((String) key).compareTo("marked") == 0) {
            return marked;
        }
        return getAttributeByName((String) key);
    }

    /**
     * Implementation for isEmpty method
     * 
     * @see java.util.Map#isEmpty()
     * @return boolean
     */
    public boolean isEmpty() {
        return getAttributes().isEmpty();
    }

    /**
     * Implementation for keySet method
     * 
     * @see java.util.Map#keySet()
     * @return keys
     */
    public Set keySet() {
        return getAttributes().keySet();
    }

    /**
     * Implementation for put method
     * 
     * @param key
     *            key
     * @param value
     *            value
     * @see java.util.Map#put(java.lang.Object, java.lang.Object)
     * @return object
     */
    public Object put(final Object key, final Object value) {
        if (((String) key).compareTo("marked") == 0) {
            setMarked((Boolean) value);
            return isMarked();
        }
        return getAttributes().put((String) key, (String) value);
    }

    /**
     * Implementation for putAll method
     * 
     * @param map
     *            map
     * @see java.util.Map#putAll(java.util.Map)
     */
    @SuppressWarnings("unchecked")
    public void putAll(final Map map) {
        getAttributes().putAll(map);
    }

    /**
     * Implementation for remove method
     * 
     * @param key
     *            key
     * @see java.util.Map#remove(java.lang.Object)
     * @return object
     */
    public Object remove(final Object key) {
        return getAttributes().remove(key);
    }

    /**
     * Implementation for size method
     * 
     * @see java.util.Map#size()
     * @return size
     */
    public int size() {
        return getAttributes().size();
    }

    /**
     * Implementation for values method
     * 
     * @see java.util.Map#values()
     * @return collection
     */
    public Collection values() {
        return getAttributes().values();
    }

}
