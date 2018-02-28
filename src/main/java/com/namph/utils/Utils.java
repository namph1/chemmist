/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 *
 * @author namph
 */
public class Utils {

    public static java.sql.Timestamp createTimestamp() {
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        return new java.sql.Timestamp((calendar.getTime()).getTime());
    }

    public static java.sql.Timestamp createDateTimestamp(java.util.Date date) {
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(date);
        return new java.sql.Timestamp((calendar.getTime()).getTime());
    }

    public static java.sql.Timestamp String2Timestamp(String strInputDate) {
        String strDate = strInputDate;
        int i, nYear, nMonth, nDay;
        String strSub = null;
        i = strDate.indexOf("/");
        if (i < 0) {
            return createTimestamp();
        }
        strSub = strDate.substring(0, i);
        nDay = (new Integer(strSub.trim())).intValue();
        strDate = strDate.substring(i + 1);
        i = strDate.indexOf("/");
        if (i < 0) {
            return createTimestamp();
        }
        strSub = strDate.substring(0, i);
        nMonth = (new Integer(strSub.trim())).intValue() - 1; // Month begin from 0 value
        strDate = strDate.substring(i + 1);
        if (strDate.length() < 4) {
            if (strDate.substring(0, 1).equals("9")) {
                strDate = "19" + strDate.trim();
            } else {
                strDate = "20" + strDate.trim();
            }
        }
        nYear = (new Integer(strDate)).intValue();
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.set(nYear, nMonth, nDay);
        return new java.sql.Timestamp((calendar.getTime()).getTime());
    }

    public static java.sql.Timestamp StringMMDDYYYYHHMMSS2Timestamp(String strInputDate) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "dd/MM/yyyy kk:mm:ss");
            Timestamp date = new Timestamp(dateFormat.parse(strInputDate).
                    getTime());
            return date;
        } catch (Exception ex) {
            System.out.println("Error: " + ex.toString());
            return null;
        }
    }

    public static Date stringDDMMYYY2Date(String strInputDate) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "dd/MM/yyyy");
            Date date = new Date(dateFormat.parse(strInputDate).
                    getTime());
            return date;
        } catch (Exception ex) {
            return null;
        }
    }

    public static Date stringDDMMYYYHHMMSS2Date(String strInputDate) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "dd/MM/yyyy kk:mm:ss");
            Date date = new Date(dateFormat.parse(strInputDate).
                    getTime());
            return date;
        } catch (Exception ex) {
            return null;
        }
    }

    /*return date with format: dd/mm/yyyy hh:mm:ss*/
    public static String getDateTimeString(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        }
        return Timestamp2DDMMYYYY(ts) + " " + Timestamp2HHMMSS(ts, 1);
    }

    /*return date with format: dd/mm/yyyy */
    public static String getDateString(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        }
        return Timestamp2DDMMYYYY(ts);
    }

    public static String getTimeString(java.sql.Timestamp ts) {
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        return calendar.get(calendar.HOUR_OF_DAY) + ":"
                + calendar.get(calendar.MINUTE) + ":"
                + calendar.get(calendar.SECOND);
    }

    /*return date with format: dd/mm/yyyy */
    public static String Timestamp2DDMMYYYY(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));

            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            if (calendar.get(calendar.DAY_OF_MONTH) < 10) {
                strTemp = "0" + strTemp;
            }
            if (calendar.get(calendar.MONTH) + 1 < 10) {
                return strTemp + "/0" + (calendar.get(calendar.MONTH) + 1)
                        + "/" + calendar.get(calendar.YEAR);
            } else {
                return strTemp + "/" + (calendar.get(calendar.MONTH) + 1) + "/"
                        + calendar.get(calendar.YEAR);
            }
        }
    }


    /*return date with format: dd/mm hh:mm */
    public static String Timestamp2DDMMHHMM(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));

            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            String strTempM = calendar.get(calendar.MINUTE) + "";
            String strTempH = calendar.get(calendar.HOUR_OF_DAY) + "";
            if (calendar.get(calendar.DAY_OF_MONTH) < 10) {
                strTemp = "0" + strTemp;
            }
            if (calendar.get(calendar.MINUTE) < 10) {
                strTempM = "0" + strTempM;
            }
            if (calendar.get(calendar.HOUR_OF_DAY) < 10) {
                strTempH = "0" + strTempH;
            }

            if (calendar.get(calendar.MONTH) + 1 < 10) {
                return strTemp + "/0" + (calendar.get(calendar.MONTH) + 1)
                        + " " + strTempH + "h" + strTempM;
            } else {
                return strTemp + "/" + (calendar.get(calendar.MONTH) + 1) + " "
                        + strTempH + "h" + strTempM;
            }
        }

    }


    /*return date with format: mm/dd/yyyy */
    public static String Timestamp2MMDDYYYY(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));

            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            if (calendar.get(calendar.DAY_OF_MONTH) < 10) {
                strTemp = "0" + strTemp;
            }
            if (calendar.get(calendar.MONTH) + 1 < 10) {
                return "0" + (calendar.get(calendar.MONTH) + 1) + "/" + strTemp
                        + "/" + calendar.get(calendar.YEAR);
            } else {
                return (calendar.get(calendar.MONTH) + 1) + "/" + strTemp + "/"
                        + +calendar.get(calendar.YEAR);
            }
        }
    }

    /*return date with format: dd/mm/yy */
    public static String Timestamp2DDMMYY(java.sql.Timestamp ts) {
        int endYear;
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));

            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            endYear = calendar.get(calendar.YEAR) % 100;
            if (calendar.get(calendar.DAY_OF_MONTH) < 10) {
                strTemp = "0" + strTemp;
            }
            if (calendar.get(calendar.MONTH) + 1 < 10) {
                if (endYear < 10) {
                    return strTemp + "/0" + (calendar.get(calendar.MONTH) + 1)
                            + "/0" + endYear;
                } else {
                    return strTemp + "/0" + (calendar.get(calendar.MONTH) + 1)
                            + "/" + endYear;
                }
            } else {
                if (endYear < 10) {
                    return strTemp + "/" + (calendar.get(calendar.MONTH) + 1)
                            + "/0" + endYear;
                } else {
                    return strTemp + "/" + (calendar.get(calendar.MONTH) + 1)
                            + "/" + endYear;
                }
            }
        }
    }

    /*return date with format: d/m/yy */
    public static String Timestamp2DMYY(java.sql.Timestamp ts) {
        int endYear = 0;
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));
            endYear = calendar.get(calendar.YEAR) % 100;
            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            if (endYear < 10) {
                return strTemp + "/" + (calendar.get(calendar.MONTH) + 1)
                        + "/0" + endYear;
            } else {
                return strTemp + "/" + (calendar.get(calendar.MONTH) + 1) + "/"
                        + endYear;
            }
        }
    }

    /*return date with format: d/m/yyyy */
    public static String Timestamp2DMYYYY(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));

            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            return strTemp + "/" + (calendar.get(calendar.MONTH) + 1) + "/"
                    + calendar.get(calendar.YEAR);
        }
    }

    /*return date with format: YYYY/MM/DD to sort*/
    public static String Timestamp2YYYYMMDD(java.sql.Timestamp ts) {
        int endYear;
        if (ts == null) {
            return "";
        } else {
            java.util.Calendar calendar = java.util.Calendar.getInstance();
            calendar.setTime(new java.util.Date(ts.getTime()));

            String strTemp = Integer.toString(calendar.get(calendar.DAY_OF_MONTH));
            endYear = calendar.get(calendar.YEAR);
            if (calendar.get(calendar.DAY_OF_MONTH) < 10) {
                strTemp = "0" + strTemp;
            }
            if (calendar.get(calendar.MONTH) + 1 < 10) {
                return endYear + "/0" + (calendar.get(calendar.MONTH) + 1)
                        + "/" + strTemp;
            } else {
                return endYear + "/" + (calendar.get(calendar.MONTH) + 1) + "/"
                        + strTemp;
            }
        }
    }

    /**
     * Author: toantt
     *
     * @param ts Timestapm to convert
     * @param iStyle 0: 24h, otherwise 12h clock
     * @return
     */
    public static String Timestamp2HHMMSS(java.sql.Timestamp ts, int iStyle) {
        if (ts == null) {
            return "";
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));

        String strTemp;
        if (iStyle == 0) {
            strTemp = Integer.toString(calendar.get(calendar.HOUR_OF_DAY));
        } else {
            strTemp = Integer.toString(calendar.get(calendar.HOUR_OF_DAY));
        }

        if (strTemp.length() < 2) {
            strTemp = "0" + strTemp;
        }
        if (calendar.get(calendar.MINUTE) < 10) {
            strTemp += ":0" + calendar.get(calendar.MINUTE);
        } else {
            strTemp += ":" + calendar.get(calendar.MINUTE);
        }
        if (calendar.get(calendar.SECOND) < 10) {
            strTemp += ":0" + calendar.get(calendar.SECOND);
        } else {
            strTemp += ":" + calendar.get(calendar.SECOND);
        }

        if (iStyle != 0) {
            if (calendar.get(calendar.AM_PM) == calendar.AM) {
                strTemp += " AM";
            } else {
                strTemp += " PM";
            }
        }
        return strTemp;
    }

    /**
     * return date time used for 24 hour clock
     */
    public static String getDateTime24hString(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        }
        return Timestamp2DDMMYYYY(ts) + " " + Timestamp2HHMMSS(ts, 0);
    }

    /**
     * return date time used for 12 hour clock
     */
    public static String getDateTime12hString(java.sql.Timestamp ts) {
        if (ts == null) {
            return "";
        }
        return Timestamp2DDMMYYYY(ts) + " " + Timestamp2HHMMSS(ts, 1);
    }

    /**
     * return string dd/mm/yyyy from a Timestamp + a addtional day
     *
     * @param ts
     * @param iDayPlus number of day to add
     * @return
     */
    public static String TimestampPlusDay2DDMMYYYY(java.sql.Timestamp ts,
            int iDayPlus) {
        if (ts == null) {
            return "";
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iDay = calendar.get(calendar.DAY_OF_MONTH);
        calendar.set(calendar.DAY_OF_MONTH, iDay + iDayPlus);

        java.sql.Timestamp tsNew = new java.sql.Timestamp((calendar.getTime()).
                getTime());
        return Timestamp2DDMMYYYY(tsNew);
    }

    public static Timestamp getPreviousDate(Timestamp ts) {
        if (ts == null) {
            return null;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iDay = calendar.get(calendar.DAY_OF_MONTH);
        calendar.set(calendar.DAY_OF_MONTH, iDay - 1);

        java.sql.Timestamp tsNew = new java.sql.Timestamp((calendar.getTime()).
                getTime());
        return tsNew;
    }

    public static Timestamp getNextDate(Timestamp ts) {
        if (ts == null) {
            return null;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iDay = calendar.get(calendar.DAY_OF_MONTH);
        calendar.set(calendar.DAY_OF_MONTH, iDay + 1);

        java.sql.Timestamp tsNew = new java.sql.Timestamp((calendar.getTime()).
                getTime());
        return tsNew;
    }

    public static int getDayOfWeek(Timestamp ts) {
        if (ts == null) {
            return -1;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iDay = calendar.get(calendar.DAY_OF_WEEK);
        return iDay;
    }

    public static int getDay(Timestamp ts) {
        if (ts == null) {
            return -1;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iDay = calendar.get(calendar.DAY_OF_MONTH);
        return iDay;
    }

    public static int getMonth(Timestamp ts) {
        if (ts == null) {
            return -1;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iMonth = calendar.get(calendar.MONTH);
        return iMonth + 1;
    }

    public static int getYear(Timestamp ts) {
        if (ts == null) {
            return -1;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iYear = calendar.get(calendar.YEAR);
        return iYear;
    }

    public static int getHour(Timestamp ts) {
        if (ts == null) {
            return -1;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iHour = calendar.get(calendar.HOUR);
        return iHour;
    }

    public static int getMinute(Timestamp ts) {
        if (ts == null) {
            return -1;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iMinute = calendar.get(calendar.MINUTE);
        return iMinute;
    }

    public static Timestamp getTimeInDate(String dateStr) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "dd/MM/yyyy HH:mm");
            Timestamp date = new Timestamp(dateFormat.parse(dateStr,
                    new ParsePosition(0)).getTime());
            return date;
        } catch (Exception ex) {
            return null;
        }
    }

    public static boolean compareDate(java.sql.Timestamp timeComp) {
        if (timeComp == null) {
            return false;
        }
        System.out.println("time stamp: " + timeComp);
        boolean result = true;
        java.util.Calendar cal = java.util.Calendar.getInstance();
        java.util.Calendar cal1 = java.util.Calendar.getInstance();
        cal1.setTime(new java.util.Date(timeComp.getTime()));

        int currDay = cal.get(cal.DAY_OF_MONTH);
        int currMonth = cal.get(cal.MONTH) + 1;
        int currYear = cal.get(cal.YEAR);
        int currHour = cal.get(cal.HOUR_OF_DAY);
        int currMinute = cal.get(cal.MINUTE);

        int creDay = cal1.get(cal1.DAY_OF_MONTH);
        int creMonth = cal1.get(cal1.MONTH) + 1;
        int creYear = cal1.get(cal1.YEAR);
        int creHour = cal1.get(cal1.HOUR_OF_DAY);
        int creMinute = cal1.get(cal1.MINUTE);

        if (creYear < currYear) {
            result = false;
        } else if (creYear == currYear && creMonth < currMonth) {
            result = false;
        } else if (creYear == currYear && creMonth == currMonth
                && creDay < currDay) {
            result = false;
        } else if (creYear == currYear && creMonth == currMonth
                && creDay == currDay && creHour < currHour) {
            result = false;
        } else if (creYear == currYear && creMonth == currMonth
                && creDay == currDay && creHour == currHour
                && creMinute < currMinute) {
            result = false;
        } else {
            result = true;
        }
        return result;
    }

    /**
     * return the dd/mm/yyyy of current month eg: 05/2002 --> 31/05/2002
     *
     * @param strMonthYear : input string mm/yyyy
     * @return
     */
    public static String getLastestDateOfMonth(String strMonthYear) {
        String strDate = strMonthYear;
        int i, nYear, nMonth, nDay;
        String strSub = null;

        i = strDate.indexOf("/");
        if (i < 0) {
            return "";
        }
        strSub = strDate.substring(0, i);
        nMonth = (new Integer(strSub)).intValue(); // Month begin from 0 value
        strDate = strDate.substring(i + 1);
        nYear = (new Integer(strDate)).intValue();

        boolean leapyear = false;
        if (nYear % 100 == 0) {
            if (nYear % 400 == 0) {
                leapyear = true;
            }
        } else if ((nYear % 4) == 0) {
            leapyear = true;
        }

        if (nMonth == 2) {
            if (leapyear) {
                return "29/" + strDate;
            } else {
                return "28/" + strDate;
            }
        } else {
            if ((nMonth == 1) || (nMonth == 3) || (nMonth == 5) || (nMonth == 7)
                    || (nMonth == 8) || (nMonth == 10) || (nMonth == 12)) {
                return "31/" + strDate;
            } else if ((nMonth == 4) || (nMonth == 6) || (nMonth == 9)
                    || (nMonth == 11)) {
                return "30/" + strDate;
            }
        }
        return "";
    }

    public static Timestamp getFriday(Timestamp ts) {
        if (ts == null) {
            return null;
        }

        java.util.Calendar calendar = java.util.Calendar.getInstance();
        int iDoW = getDayOfWeek(ts);
        if (iDoW == calendar.SUNDAY) {
            iDoW = 8;
        }
        int k = calendar.FRIDAY - iDoW;
        calendar.setTime(new java.util.Date(ts.getTime()));
        int iDay = calendar.get(calendar.DAY_OF_MONTH);
        calendar.set(calendar.DAY_OF_MONTH, iDay + k);
        java.sql.Timestamp tsNew = new java.sql.Timestamp((calendar.getTime()).
                getTime());
        return tsNew;
    }

    public static boolean isFriday(Timestamp ts) {
        if (ts == null) {
            return false;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        if (getDayOfWeek(ts) == calendar.FRIDAY) {
            return true;
        }
        return false;
    }

    public static Timestamp getTimestamp(String dateStr) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat(
                    "dd/MM/yyyy kk:mm:ss");
            Timestamp date = new Timestamp(dateFormat.parse(dateStr).getTime());
            return date;
        } catch (Exception ex) {
            System.out.println("Error: " + ex.toString());
            return null;
        }
    }

    public static Timestamp getNextDateN(Timestamp ts, int n) {
        if (ts == null) {
            return null;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        calendar.add(calendar.DAY_OF_MONTH, n);
        java.sql.Timestamp tsNew = new java.sql.Timestamp((calendar.getTime()).
                getTime());
        return tsNew;
    }

    public static Timestamp getNextMonthN(Timestamp ts, int n) {
        if (ts == null) {
            return null;
        }
        java.util.Calendar calendar = java.util.Calendar.getInstance();
        calendar.setTime(new java.util.Date(ts.getTime()));
        calendar.add(calendar.MONTH, n);
        java.sql.Timestamp tsNew = new java.sql.Timestamp((calendar.getTime()).
                getTime());
        return tsNew;
    }

    public static String getDayInWeek(Timestamp ts) {
        String dayInWeek = "";
        String[] nameArr = new String[]{"Sunday", "Monday", "Tuesday",
            "Wednesday", "Thursday", "Friday", "Saturday"};
        int iDay = getDayOfWeek(ts);
        dayInWeek = nameArr[iDay - 1];
        return dayInWeek;
    }

    public static String getFullDay(Timestamp ts) {
        String fullDay = "";
        String dayInWeek = getDayInWeek(ts);
        String day = getDateTime24hString(ts);
        fullDay = dayInWeek + ", " + day;
        return fullDay;
    }

    public static String createPartition(String date) {
        Timestamp ts = String2Timestamp(date);
        return getPartition(ts);
    }

    public static String getPartition(Timestamp ts) {
        int month = Utils.getMonth(ts);
        int year = Utils.getYear(ts);
        String ret = "" + month;
        if (month < 10) {
            ret = "0" + ret;
        }
        ret = year + ret;
        return ret;
    }

    public static String getFirstDay(java.util.Date d) throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        java.util.Date dddd = calendar.getTime();
        SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
        return sdf1.format(dddd);
    }

    public static String getLastDay(java.util.Date d) throws Exception {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(d);
        calendar.set(Calendar.DAY_OF_MONTH,
                calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        java.util.Date dddd = calendar.getTime();
        SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
        return sdf1.format(dddd);
    }

    public static String getPartition_Prev(Timestamp ts) {
        int month = Utils.getMonth(ts);
        int year = Utils.getYear(ts);

        if (month == 1) {
            year = year - 1;
            month = 12;
        } else {
            month = month - 1;
        }

        String ret = "" + month + year;
        if (month < 10) {
            ret = "0" + ret;
        }
        return ret;
    }

    public static String Date2DDMMYYYYH24MI(java.sql.Date date) {
        if (date == null) {
            return "";
        }
        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat(
                "dd/MM/yyyy HH:mm:ss");
        return sf.format(date);
    }

    public static String Date2DDMMYYYYH24MI(java.util.Date date) {
        if (date == null) {
            return "";
        }
        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat(
                "dd/MM/yyyy HH:mm:ss");
        return sf.format(date);
    }

    public static String Date2DDMMYYY(java.util.Date date) {
        if (date == null) {
            return "";
        }
        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat(
                "dd/MM/yyyy");
        return sf.format(date);
    }

    /*return date with format: dd/mm/yyyy */
    public static String Date2DDMMYYYYH24MI(java.sql.Timestamp date) {
        if (date == null) {
            return "";
        }
        java.text.SimpleDateFormat sf = new java.text.SimpleDateFormat(
                "dd/MM/yyyy HH:mm:ss");
        return sf.format(date);

    }

    public static Date getFirstDayOfPreviousMonth() {
        Calendar aCalendar = Calendar.getInstance();
        aCalendar.add(Calendar.MONTH, -1);
        aCalendar.set(Calendar.DATE, 1);
        aCalendar.set(Calendar.HOUR_OF_DAY, 0);
        aCalendar.set(Calendar.MINUTE, 0);
        aCalendar.set(Calendar.SECOND, 0);
        Date firstDateOfPreviousMonth = aCalendar.getTime();
        return firstDateOfPreviousMonth;
    }

    public static Date getLastDayOfPreviousMonth() {
        Calendar aCalendar = Calendar.getInstance();
        aCalendar.add(Calendar.MONTH, -1);
        aCalendar.set(Calendar.DATE, aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        aCalendar.set(Calendar.HOUR_OF_DAY, 23);
        aCalendar.set(Calendar.MINUTE, 59);
        aCalendar.set(Calendar.SECOND, 59);
        Date lastDateOfPreviousMonth = aCalendar.getTime();
        return lastDateOfPreviousMonth;
    }

    public static Date getFirstDayOfCurrentMonth(boolean setStartTime) {
        Calendar aCalendar = Calendar.getInstance();
        aCalendar.add(Calendar.MONTH, 0);
        aCalendar.set(Calendar.DATE, 1);
        if (setStartTime) {
            aCalendar.set(Calendar.HOUR_OF_DAY, 0);
            aCalendar.set(Calendar.MINUTE, 0);
            aCalendar.set(Calendar.SECOND, 0);
        }
        Date firstDateOfCurrMonth = aCalendar.getTime();
        return firstDateOfCurrMonth;
    }

    public static Date getLastDayOfCurrentMonth() {
        Calendar aCalendar = Calendar.getInstance();
        aCalendar.add(Calendar.MONTH, 0);
        aCalendar.set(Calendar.DATE, aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        aCalendar.set(Calendar.HOUR_OF_DAY, 23);
        aCalendar.set(Calendar.MINUTE, 59);
        aCalendar.set(Calendar.SECOND, 59);
        Date lastDateOfCurrMonth = aCalendar.getTime();
        return lastDateOfCurrMonth;
    }

    public static Date getLastDayOfCurrentMonth(boolean setStartTime) {
        Calendar aCalendar = Calendar.getInstance();
        aCalendar.add(Calendar.MONTH, 0);
        aCalendar.set(Calendar.DATE, aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        if (setStartTime) {
            aCalendar.set(Calendar.HOUR_OF_DAY, 23);
            aCalendar.set(Calendar.MINUTE, 59);
            aCalendar.set(Calendar.SECOND, 59);
        }
        Date lastDateOfCurrMonth = aCalendar.getTime();
        return lastDateOfCurrMonth;
    }
    
    public static Date getTimeVN() throws ParseException {
        Date now = new Date();
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        df.setTimeZone(TimeZone.getTimeZone("Asia/Saigon"));
        return convertToDate(df.format(now), "dd/MM/yyyy HH:mm:ss");
    }

    public static Date getTimeVNNoFull() throws ParseException {
        Date now = new Date();
        DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        df.setTimeZone(TimeZone.getTimeZone("Asia/Saigon"));
        return convertToDate(df.format(now), "dd/MM/yyyy");
    }
    
    public static Date convertToDate(String input, String strFormat) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(strFormat);
        Date date = sdf.parse(input);
        return date;
    }

    public static int getPreviousMonth() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getFirstDayOfPreviousMonth());
        int month = cal.get(Calendar.MONTH) + 1;
        return month;
    }

    public static int getYearWithPreviousMonth() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(getFirstDayOfPreviousMonth());
        int year = cal.get(Calendar.YEAR);
        return year;
    }

    public static String convertNumberToString(Number input) {

        return "";
    }

    /**
     * convert number to string from zero to night 0 - 9
     *
     * @param input
     * @return
     * @throws UnsupportedEncodingException
     */
    private static String convertNoToNight(Integer input) throws UnsupportedEncodingException {
        String result = "";
        switch (input) {
            case 0:
                result = "không";
                break;
            case 1:
                result = "một";
                break;
            case 2:
                result = "hai";
                break;
            case 3:
                result = "ba";
                break;
            case 4:
                result = "bốn";
                break;
            case 5:
                result = "năm";
                break;
            case 6:
                result = "sáu";
                break;
            case 7:
                result = "bảy";
                break;
            case 8:
                result = "tám";
                break;
            case 9:
                result = "chín";
                break;
        }

        return new String(result.getBytes(Charset.forName("UTF-8")), "UTF-8");
    }

    private static String analy3Num(boolean addZero, Integer input)
            throws UnsupportedEncodingException {
        String result = "";
        if (addZero) {
            if (input == 0) {
            } else if (input <= 9) {
                result = "không trăm lẻ " + convertNoToNight(input);
            } else if (input <= 99) {
                result = "không trăm " + (input / 10 != 1 ? convertNoToNight(input / 10) + " mươi " : " mười ") + (input % 10 == 0 ? "" : convertNoToNight(input % 10));
            } else {
                if (input % 100 == 0) {
                    result = convertNoToNight(input / 100) + " trăm ";
                } else {
                    String phangiua = ((input % 100) / 10 != 1 ? convertNoToNight((input % 100) / 10) + " mươi " : " mười ");
                    if ((input % 100) / 10 == 0) {
                        phangiua = " lẻ ";
                    }
                    result = convertNoToNight(input / 100) + " trăm " + phangiua + ((input % 100) % 10 == 0 ? "" : convertNoToNight((input % 100) % 10));
                }
            }
        } else {
            if (input == 0) {
            } else if (input <= 9) {
                result = convertNoToNight(input);
            } else if (input <= 99) {
                result = (input / 10 != 1 ? convertNoToNight(input / 10) + " mươi " : " mười ") + (input % 10 == 0 ? "" : convertNoToNight(input % 10));
            } else {
                if (input % 100 == 0) {
                    result = convertNoToNight(input / 100) + " trăm ";
                } else {
                    result = convertNoToNight(input / 100) + " trăm " + ((input % 100) / 10 != 1 ? convertNoToNight((input % 100) / 10) + " mươi " : " mười ") + ((input % 100) % 10 == 0 ? "" : convertNoToNight((input % 100) % 10));
                }
            }
        }
        return result;
    }

    public static String n2s(Integer input) throws UnsupportedEncodingException {
        String result = "";
        if (input.intValue() >= 1000000000) {
            result = convertNoToNight(input.intValue() / 1000000000) + " tỷ";
        } else if (input.intValue() >= 1000000) {
            result = analy3Num(false, input.intValue() / 1000000) + " triệu ";
            if (input.intValue() % 1000000 >= 1000) {
                result += analy3Num(true, (input.intValue() % 1000000) / 1000) + " ngàn ";
                result += analy3Num(true, (input.intValue() % 1000000) % 1000);
            } else {
                result += analy3Num(true, (input.intValue() % 1000000));
            }

        } else if (input.intValue() >= 1000) {
            result = analy3Num(false, input.intValue() / 1000) + " ngàn ";
            if (input.intValue() % 1000 != 0) {
                result += analy3Num(true, input.intValue() % 1000);
            }
        }
        return new String(result.getBytes("UTF-8"), "UTF-8");
    }

    public static String _replaceSpecialCharacter(String param) {
        return param.replaceAll("%", "\\\\%").replaceAll("_", "\\\\_");
    }

    private static String encodeFileToBase64Binary(File file) {
        String encodedfile = null;
        try {
            FileInputStream fileInputStreamReader = new FileInputStream(file);
            byte[] bytes = new byte[(int) file.length()];
            fileInputStreamReader.read(bytes);
            encodedfile = new String(org.apache.commons.codec.binary.Base64.encodeBase64(bytes), "UTF-8");
            fileInputStreamReader.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return encodedfile;
    }

    public static String convertFileImageToBase64Url(String pathname) {
        if (pathname == null || pathname.trim().equals("")) {
            return "";
        }
//        pathname = "c://images//" + pathname;
        File file = new File(pathname);
        String result = encodeFileToBase64Binary(file);
        if (pathname.toLowerCase().endsWith("jpg")) {
            result = "data:image/jpg;base64," + result;
        } else if (pathname.toLowerCase().endsWith("png")) {
            result = "data:image/png;base64," + result;
        }
        return result;
    }

    public static void main(String[] args) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(getFirstDayOfPreviousMonth());
            int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH) + 1;
            int day = cal.get(Calendar.DAY_OF_MONTH);
            System.out.println(month);
        } catch (Exception e) {
        }
    }
}
