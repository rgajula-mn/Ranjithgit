package com.convergys.custom.geneva.j2ee.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.convergys.logging.TraceLog;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * This class holds several Maps that are related Each map is identified by an unique key The map
 * relates a Pair interval with a value
 * 
 * @author Lidio Junior
 */
public class IntervalMapping extends BaseObject {

    private static final long serialVersionUID = 2081217296755265574L;
    private static TraceLog traceLog = new TraceLog(IntervalMapping.class);

    private Map<String, Map<Pair, String>> maps = new HashMap<String, Map<Pair, String>>();
    private static Map<String, Map<String, String>> eventTypeMap;

    /**
     * Default constructor - creates a new instance with no values set.
     */

    static {
        eventTypeMap = new HashMap<String, Map<String, String>>();
        parseRulesPerEvent(Constants.grps_mapping, Constants.GPRS);
        parseRulesPerEvent(Constants.intl_roam_grps_mapping, Constants.INTL_ROAM_GPRS);
        parseRulesPerEvent(Constants.mms_mapping, Constants.MMS);
        parseRulesPerEvent(Constants.voice_mapping, Constants.VOICE);
        parseRulesPerEvent(Constants.intl_roam_voice_mapping, Constants.INTL_ROAM_VOICE);
        parseRulesPerEvent(Constants.intl_roam_sms_mapping, Constants.INTL_ROAM_SMS);
        parseRulesPerEvent(Constants.sms_mapping, Constants.SMS);
    }
    
    private static void parseRulesPerEvent(final String eventTypeDesc, final String eventTypeId) {
        
        String[] rules = eventTypeDesc.split("[|]");
        Map<String, String> mapping = new HashMap<String, String>();
        for (String rule : rules) {
            String[] fields = rule.split(",");
            if (fields.length == 2) {
                mapping.put(fields[0].toUpperCase(), fields[1].toUpperCase());
            } else {
                mapping.put(fields[0].toUpperCase(), "");
            }
        }
        eventTypeMap.put(eventTypeId, mapping);
    }

    public IntervalMapping() {
    }
    public Map<String, Map<String, String>> callMethod(){
        
        return eventTypeMap;
    }

    /**
     * Create a map to assign a Pair interval with a value and relates this map using key identifier
     * 
     * @param key
     *            map id
     * @param firstEventCreateDtm
     *            lower bound interval
     * @param lastEventCreateDtm
     *            upper bound interval
     * @param dufFileName
     *            map value filename
     */
    public void put(String key, Date firstEventCreateDtm, Date lastEventCreateDtm, String dufFileName) {
        Pair pair = new Pair(firstEventCreateDtm, lastEventCreateDtm);
        Map<Pair, String> map = maps.get(key);

        if (map == null) {
            map = new HashMap<Pair, String>();
        }
        map.put(pair, dufFileName);
        maps.put(key, map);
    }

    /**
     * Get the value from element matching the Pair
     * 
     * @param key
     *            map identifier
     * @param pair
     *            searching range
     * @return map element for searching criteria
     */
    public String get(String key, Pair pair) {
        Map<Pair, String> map = maps.get(key);
        return (map != null) ? map.get(pair) : null;
    }

    /**
     * @author ljunior
     */
    public class Pair {
        /**
         * @param key1
         *            key1
         * @param key2
         *            key2
         */
        public Pair(final Date key1, final Date key2) {
            super();
            this.key1 = key1;
            this.key2 = key2;
        }

        private Date key1;
        private Date key2;

        /**
         * @return key1
         */
        public Date getKey1() {
            return key1;
        }

        /**
         * @param key1
         *            key1
         */
        public void setKey1(Date key1) {
            this.key1 = key1;
        }

        /**
         * @return key2
         */
        public Date getKey2() {
            return key2;
        }

        /**
         * @param key2
         */
        public void setKey2(Date key2) {
            this.key2 = key2;
        }

        /**
         * @param value
         *            date
         * @return true/false
         */
        public boolean contains(Date value) {
            return key1.compareTo(value) <= 0 && value.compareTo(key2) <= 0;
        }

        /**
         * @param pair
         *            pair
         * @return true/false
         */
        public boolean equals(Pair pair) {

            if (this == pair || this.hashCode() == pair.hashCode()) {
                return true;
            }
            return false;
        }

        @Override
        public String toString() {
            return "Pair(" + key1 + "," + key2 + ")";
        }

        @Override
        public int hashCode() {
            return key1 == null ? 0 : key1.hashCode() + (key2 == null ? 0 : key2.hashCode());
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (!(obj instanceof Pair)) {
                return false;
            }

            final Pair pair = (Pair) obj;

            return ((key1 == null && pair.getKey1() == null)
                    || (key1 != null && pair.getKey1() != null && key1.compareTo(pair.getKey1()) == 0
                            && key2 == null && pair.getKey2() == null) || (key2 != null && pair.getKey2() != null && key2
                    .compareTo(pair.getKey2()) == 0));
        }
    }

    /**
     * Find a pair containing the date
     * 
     * @param key
     *            map id
     * @param eventDate
     *            date to be used on search
     * @return pair
     */
    public Pair find(String key, Date eventDate) {
        Map<Pair, String> map = maps.get(key);
        if (map != null) {
            for (Map.Entry<Pair, String> entry : map.entrySet()) {
                traceLog.traceFinest("------- printing entry object: " + entry.getKey() + " value: " + entry.getValue());

                if (entry.getKey().contains(eventDate)) {
                    return entry.getKey();
                }
            }
        }
        return null;
    }

    /**
     * @return hashmap
     */
    public Map<String, Map<Pair, String>> getMaps() {
        return maps;
    }

    /**
     * @param map
     *            map
     */
    public void setMaps(Map<String, Map<Pair, String>> maps) {
        this.maps = maps;
    }

    @Override
    public int hashCode() {
        return maps.hashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof IntervalMapping)) {
            return false;
        }

        final IntervalMapping map = (IntervalMapping) obj;
        return map.getMaps().equals(this.maps);
    }

    @Override
    public String toString() {
        ToStringBuilder sb = new ToStringBuilder(this, ToStringStyle.DEFAULT_STYLE);

        for (Map.Entry<String, Map<Pair, String>> mapEntry : maps.entrySet()) {
            sb.append("IntervalMapping<" + mapEntry.getKey() + ">[");
            for (Map.Entry<Pair, String> entry : mapEntry.getValue().entrySet()) {
                sb.append(entry.getKey() + "=" + entry.getValue() + " ");
            }
            sb.append("]");
        }
        return sb.toString();
    }
}
