/*******************************************************************************
 *
 * This file contains proprietary information of Convergys, Inc.
 * Copying or reproduction without prior written approval is prohibited.
 * Copyright (C) 2009  Convergys, Inc.  All rights reserved.
 *
 *******************************************************************************/
package com.convergys.custom.geneva.j2ee.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.convergys.logging.TraceLog;

/**
 * Similar to <tt>java.util.HashMap</tt> but with additional functionality.
 * 
 * @author danny.feng
 */
@SuppressWarnings("unchecked")
public class HashMapPlus extends HashMap {

    private static final long serialVersionUID = 8206730824077353459L;
    private static TraceLog LOG = new TraceLog(HashMapPlus.class);

    // constants --------------------------------------------------------------
    private static final Set TRUE_VALUES;
    private static final Set FALSE_VALUES;
    static {
        TRUE_VALUES = new HashSet();
        TRUE_VALUES.add("TRUE");
        TRUE_VALUES.add("YES");
        TRUE_VALUES.add("T");

        FALSE_VALUES = new HashSet();
        FALSE_VALUES.add("FALSE");
        FALSE_VALUES.add("NO");
        FALSE_VALUES.add("F");
    }

    // constructors -----------------------------------------------------------

    /**
     * Constructs a new <tt>HashMapPlus</tt> for the specified initial capacity.
     * 
     * @param initialCapacity
     *            the initial capacity to size the map for
     */
    public HashMapPlus(final int initialCapacity) {
        super(initialCapacity);
    }

    /**
     * Constructs a new <tt>HashMapPlus</tt>.
     */
    public HashMapPlus() {
    }

    /**
     * Constructs a new <tt>HashMapPlus</tt> with the contents of the specified map.
     * 
     * @param t
     *            a map whose contents to copy into the new <tt>HashMapPlus</tt>
     */
    public HashMapPlus(final Map t) {
        super(t);
    }

    // methods ----------------------------------------------------------------

    public Integer getInt(final Object key) {
        Object v = get(key);
        return pGetInteger(v);
    }

    public Integer getInteger(final Object key) {
        Object v = get(key);
        return pGetInteger(v);
    }

    public Long getLong(final Object key) {
        Object v = get(key);
        return pGetLong(v);
    }

    public Double getDouble(final Object key) {
        Object v = get(key);
        return pGetDouble(v);
    }

    public String getString(final Object key) {
        Object v = get(key);
        return pGetString(v);
    }

    public java.util.Date getDate(final Object key) {
        Object v = get(key);
        return pGetDate(v);
    }

    public java.sql.Date getSqlDate(final Object key) {
        Object v = get(key);
        return pGetSqlDate(v);
    }

    public boolean getBoolean(final Object key) {
        Object v = get(key);
        return pGetBoolean(v);
    }

    //======================================================
    // utility methods
    //======================================================
    protected static Integer pGetInteger(final Object value) {
        Integer result = null;

        if (value != null) {
            if (value instanceof Number) {
                result = Integer.valueOf(((Number) value).intValue());
            } else {
                result = new Integer(value.toString().trim());
            }
        }
        return result;
    }

    protected static Long pGetLong(final Object value) {
        Long result = null;

        if (value != null) {
            if (value instanceof Number) {
                result = new Long(((Number) value).longValue());
            } else {
                result = new Long(value.toString().trim());
            }
        }
        return result;
    }

    protected static Double pGetDouble(final Object value) {
        Double result = null;

        if (value != null) {
            if (value instanceof Number) {
                result = new Double(((Number) value).doubleValue());
            } else {
                result = new Double(value.toString().trim());
            }
        }
        return result;
    }

    protected static Boolean pGetBoolean(final Object value) {
        Boolean result = Boolean.FALSE;

        if (value != null) {
            if (value instanceof Boolean) {
                result = ((Boolean) value);
            } else if (value instanceof Number) {
                result = ((Number) value).longValue() != 0L;
            } else {
                String valueString = value.toString().trim().toUpperCase();
                if (TRUE_VALUES.contains(valueString)) {
                    result = Boolean.TRUE;
                } else if (FALSE_VALUES.contains(valueString)) {
                    result = Boolean.FALSE;
                }
            }
        }
        return result;
    }

    protected static String pGetString(final Object value) {
        String result = (value != null) ? value.toString() : null;
        return result;
    }

    protected static java.sql.Date pGetSqlDate(final Object value) {
        java.sql.Date result = null;

        if (value != null) {
            if (value instanceof java.sql.Date) {
                result = (java.sql.Date) value;
            } else {
                java.util.Date d = pGetDate(value);
                result = new java.sql.Date(d.getTime());
            }
        }

        return result;
    }

    protected static java.util.Date pGetDate(final Object value) {
        java.util.Date result = null;

        if (value != null) {
            if (value instanceof java.util.Date) {
                result = (java.util.Date) value;
            } else if (value instanceof java.sql.Date) {
                java.sql.Date d = (java.sql.Date) value;
                result = new java.util.Date(d.getTime());
            } else if (value instanceof Number) {
                result = new java.util.Date(((Number) value).longValue());
            } else {
                // last attempt, treat it as a date in String format
                try {
                    String stringValue = value.toString();
                    DateFormat format = new SimpleDateFormat();
                    result = format.parse(stringValue);
                } catch (ParseException e) {
                    // if this failed we cannot convert the object into a Date object
                    // and should return null
                    LOG.traceFinest(e);
                }
            }
        }
        return result;
    }

}