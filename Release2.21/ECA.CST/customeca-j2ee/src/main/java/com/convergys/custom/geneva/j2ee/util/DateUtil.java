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
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.MissingResourceException;
import java.util.ResourceBundle;
import java.util.TimeZone;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.springframework.context.i18n.LocaleContextHolder;

import com.convergys.logging.TraceLog;

/**
 * Date Utility Class used to convert Strings to Dates and Timestamps
 * 
 * @author <a href="mailto:matt@raibledesigns.com">Matt Raible</a> Modified by <a
 *         href="mailto:dan@getrolling.com">Dan Kibler </a> to correct time pattern. Minutes should
 *         be mm not MM (MM is month).
 */
public final class DateUtil {
    private static TraceLog traceLog = new TraceLog(DateUtil.class);
    private static final String TIME_PATTERN = "HH:mm";
    private static final String DATE_MASK = "yyyyMMdd";
    private static final String DATETIME_MASK = "yyyyMMdd HHmmss";

    /**
     * Checkstyle rule: utility classes should not have public constructor
     */
    private DateUtil() {
    }

    /**
     * Return default datePattern (MM/dd/yyyy)
     *
     * @return a string representing the date pattern on the UI
     */
    public static String getDatePattern() {
        Locale locale = LocaleContextHolder.getLocale();
        String defaultDatePattern;
        try {
            defaultDatePattern = "MM/dd/yyyy";
        } catch (MissingResourceException mse) {
            defaultDatePattern = "MM/dd/yyyy";
        }

        return defaultDatePattern;
    }

    public static String getDateTimePattern() {
        Locale locale = LocaleContextHolder.getLocale();
        String defaultDateTimePattern;
        try {
            defaultDateTimePattern = "MM/dd/yyyy hh:mm:ss.S";
        } catch (MissingResourceException mse) {
            defaultDateTimePattern = "MM/dd/yyyy hh:mm:ss.S";
        }
        return defaultDateTimePattern;
    }

    /**
     * This method attempts to convert an Oracle-formatted date in the form dd-MMM-yyyy to
     * mm/dd/yyyy.
     *
     * @param aDate
     *            date from database as a string
     * @return formatted string for the ui
     */
    public static String getDate(final Date aDate) {
        SimpleDateFormat df;
        String returnValue = "";

        if (aDate != null) {
            df = new SimpleDateFormat(getDatePattern());
            returnValue = df.format(aDate);
        }

        return returnValue;
    }

    /**
     * This method generates a string representation of a date/time in the format you specify on
     * input
     *
     * @param aMask
     *            the date pattern the string is in
     * @param strDate
     *            a string representation of a date
     * @return a converted Date object
     * @see java.text.SimpleDateFormat
     * @throws ParseException
     *             when String doesn't match the expected format
     */
    public static Date convertStringToDate(final String aMask, final String strDate) throws ParseException {
        TimeZone.setDefault(TimeZone.getDefault()); // TimeZone("GMT-8"));
        SimpleDateFormat df;
        Date date;
        df = new SimpleDateFormat(aMask);

        try {
            df.setLenient(false);
            date = df.parse(strDate);
        } catch (ParseException pe) {
            // LOG.error("ParseException: " + pe);
            throw new ParseException(pe.getMessage(), pe.getErrorOffset());
        }

        return date;
    }

    /**
     * This method returns the current date time in the format: MM/dd/yyyy HH:MM a
     *
     * @param theTime
     *            the current time
     * @return the current date/time
     */
    public static String getTimeNow(final Date theTime) {
        return getDateTime(TIME_PATTERN, theTime);
    }

    /**
     * This method returns the current date in the format: MM/dd/yyyy
     *
     * @return the current date
     * @throws ParseException
     *             when String doesn't match the expected format
     */
    public static Calendar getToday() throws ParseException {
        Date today = new Date();
        SimpleDateFormat df = new SimpleDateFormat(getDatePattern());

        // This seems like quite a hack (date -> string -> date),
        // but it works ;-)
        String todayAsString = df.format(today);
        Calendar cal = new GregorianCalendar();
        cal.setTime(convertStringToDate(todayAsString));

        return cal;
    }

    /**
     * This method returns the current date in the format: yyyyMMdd HHmmss
     *
     * @return the current date
     * @throws ParseException
     *             when String doesn't match the expected format
     */
    public static Calendar getTodayTimestamp() throws ParseException {
        Date today = new Date();
        SimpleDateFormat df = new SimpleDateFormat(DATETIME_MASK);

        String todayAsString = df.format(today);
        Calendar cal = new GregorianCalendar();
        cal.setTime(convertStringToDate(DATETIME_MASK, todayAsString));

        return cal;
    }

    /**
     * This method generates a string representation of a date's date/time in the format you specify
     * on input
     *
     * @param aMask
     *            the date pattern the string is in
     * @param aDate
     *            a date object
     * @return a formatted string representation of the date
     * @see java.text.SimpleDateFormat
     */
    public static String getDateTime(final String aMask, final Date aDate) {
        SimpleDateFormat df = null;
        String returnValue = "";

        if (aDate == null) {
        	traceLog.traceFinest("aDate is null!");
        } else {
            df = new SimpleDateFormat(aMask);
            df.setLenient(false);
            returnValue = df.format(aDate);
        }

        return returnValue;
    }

    /**
     * This method generates a string representation of a date based on the System Property
     * 'dateFormat' in the format you specify on input
     *
     * @param aDate
     *            A date to convert
     * @return a string representation of the date
     */
    public static String convertDateToString(final Date aDate) {
        return getDateTime(getDatePattern(), aDate);
    }

    /**
     * This method generates a string representation of a date based on the System Property
     * 'dateFormat' in the format you specify on input
     *
     * @param aDate
     *            A date to convert
     * @return a string representation of the date
     */
    public static String convertDateTimeToString(final Date aDate) {
        return getDateTime(DATETIME_MASK, aDate);
    }

    /**
     * This method converts a String without timezone to a date using the datePattern
     *
     * @param strDate
     *            the date to convert (in format MM/dd/yyyy)
     * @return a date object
     * @throws ParseException
     *             when String doesn't match the expected format
     */
    public static Date convertStringToDateWithoutTimezone(String tibcoDatePatternNoTimezone, String strDate)
            throws ParseException {
        Date aDate = null;

        try {
            TimeZone timezone = TimeZone.getTimeZone("GMT-8");
            Calendar calendar = Calendar.getInstance(timezone);
            SimpleDateFormat df = new SimpleDateFormat(tibcoDatePatternNoTimezone);

            traceLog.traceFinest("converting '" + strDate + "' to date with mask '" + tibcoDatePatternNoTimezone + "'");

            df.setLenient(false);
            df.setTimeZone(timezone);

            aDate = df.parse(strDate);
            calendar.setTime(aDate);

            if (timezone.inDaylightTime(aDate)) {
                df.setTimeZone(TimeZone.getTimeZone("GMT-7"));
                aDate = df.parse(strDate);
            }
        } catch (ParseException pe) {
        	traceLog.traceFinest("Could not convert '" + strDate + "' to a date, throwing exception");
            throw new ParseException(pe.getMessage(), pe.getErrorOffset());
        }

        return aDate;
    }

    /**
     * This method converts a String to a date using the datePattern
     *
     * @param strDate
     *            the date to convert (in format MM/dd/yyyy)
     * @return a date object
     * @throws ParseException
     *             when String doesn't match the expected format
     */
    public static Date convertStringToDate(final String strDate) throws ParseException {
        Date aDate = null;

        try {
        	traceLog.traceFinest("converting date with pattern: " + getDatePattern());

            aDate = convertStringToDate(getDatePattern(), strDate);
        } catch (ParseException pe) {
        	traceLog.traceFinest("Could not convert '" + strDate + "' to a date, throwing exception");
            throw new ParseException(pe.getMessage(), pe.getErrorOffset());
        }

        return aDate;
    }

    /**
     * This method returns a string containing current date on pattern yyyyMMyy
     *
     * @return current date
     */
    public static String getTodayAsString() {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_MASK);
        Calendar cal = Calendar.getInstance();

        return dateFormat.format(cal.getTime());
    }

    /**
     * Temporary solution to convert timezones
     * 
     * @param date
     *            date to be converted
     * @return date on system timezone
     */
    public static Date convertToSystemTimezone(final Date date) {
        Date convertedDate = null;
        String systemTimezone = "PST";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd-HH:mm:ss");

        try {
            // switch timezone
            sdf.setTimeZone(TimeZone.getTimeZone(systemTimezone));
            String dateOnSystemTimezone = sdf.format(date);
            sdf.setTimeZone(TimeZone.getDefault());
            convertedDate = sdf.parse(dateOnSystemTimezone);
        } catch (ParseException pe) {
        	traceLog.traceFinest("Could not convert '" + date + "' to a date, throwing exception");
            convertedDate = null;
        }
        return convertedDate;
    }

    /**
     * Calculate a new date based on current date
     *
     * @param numberOfDays
     *            number of days to add to date
     * @return calculated date
     */
    public static Date getDateFromToday(final int numberOfDays) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, numberOfDays);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    /**
     * Return a gregorian calendar date
     * 
     * @param date
     *            date
     * @return Gregorian Calendar date
     */
    public static XMLGregorianCalendar getGregorianCalendar(final Date date) {
        XMLGregorianCalendar xmlDate = null;
        try {
            GregorianCalendar cal = new GregorianCalendar();
            cal.setTime(date);
            xmlDate = DatatypeFactory.newInstance().newXMLGregorianCalendar(cal);
        } catch (DatatypeConfigurationException e) {
        	traceLog.traceFinest("Could not convert '" + date + "' to a XMLGregorianCalendar date, throwing exception");
        }
        return xmlDate;
    }
    
    
    /**
     * @param dateString
     * @param inputMask
     * @param outputMask
     * @return
     * @throws ParseException
     */
    public static String convertStringToDateString(String dateString,String inputMask,String outputMask) throws ParseException {
    	traceLog.traceFinest("start method convertStringToDateString");
    	SimpleDateFormat sdf = new SimpleDateFormat(inputMask);
    	String formattedTime = null;
    	
		try {
			Date date = sdf.parse(dateString);
			traceLog.traceFinest("after parse1" + date);
			formattedTime = getDateTime(outputMask, date);
			traceLog.traceFinest("after parse2" + formattedTime);
		} catch (ParseException pe) {
			traceLog.traceFinest("Could not convert '" + dateString + "' to a dateString, throwing exception");
            throw new ParseException(pe.getMessage(), pe.getErrorOffset());
		}
    	
    	
		return formattedTime;
    }
    //For Ticket- 74321
    @SuppressWarnings("deprecation")
	public static Date convertDayIntoDateFormat(int day,java.sql.Date gnvSystemDate) throws ParseException {
		DateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		Date passedDate=formatter.parse(formatter.format(new Date()));
		
		//To get the next month last day we need date object
		Date nextMonthDate=formatter.parse(formatter.format(new Date()));
		nextMonthDate.setDate(1);
		nextMonthDate.setMonth(passedDate.getMonth()+1);

		//Calendar class is required to get last day of next month
		Calendar instance = Calendar.getInstance();
        instance.setTime(nextMonthDate);
		
        passedDate.setDate(day);
		int month=passedDate.getMonth();
		
		//if(passedDate.compareTo(gnvSystemDate)<0) {
			if(month == 11){
				passedDate.setMonth(0);
				passedDate.setYear(passedDate.getYear()+1);
			}else if(day == 31 && month !=0) {
		        passedDate.setDate(instance.getActualMaximum(Calendar.DAY_OF_MONTH));
		        passedDate.setMonth(passedDate.getMonth()+1);
			}else if(month ==0 && day>=29 && day<=31) {
		        passedDate.setDate(instance.getActualMaximum(Calendar.DAY_OF_MONTH));//Give last day of next month
		        passedDate.setMonth(passedDate.getMonth()+1);
			}else{
				passedDate.setMonth(passedDate.getMonth()+1);
			}
		//}
		   return passedDate;
    }
}
