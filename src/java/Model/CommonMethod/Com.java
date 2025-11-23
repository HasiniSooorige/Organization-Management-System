/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.CommonMethod;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;
import org.joda.time.DateTime;
import org.joda.time.DateTimeConstants;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

/**
 *
 * @author sameera
 */
public class Com {

    public static Date getFormattedDate(String date) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date FormattedDate = null;
        try {
            FormattedDate = formatter.parse(date);
        } catch (Exception e) {
        }

        return FormattedDate;
    }

    public static int GetHoursFromTwoTimes(Date dateObj1, Date dateObj2) {

        long diff = dateObj2.getTime() - dateObj1.getTime();

        Double diffInHours = diff / ((double) 1000 * 60 * 60);

        int a = diffInHours.intValue();

        return a;
    }

    public static Date getFormattedDateOld(String date) {

        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
        Date FormattedDate = null;
        try {
            FormattedDate = formatter.parse(date);
        } catch (Exception e) {
        }

        return FormattedDate;
    }

    public static String getDate(Date date) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        return formatter.format(date);
    }

    public static String getFullDateTime(Date date) {

        SimpleDateFormat formatter = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss");

        return formatter.format(date);
    }

    public static String getDateInMonthName(Date date) {

        String[] suffixes
                = //    0     1     2     3     4     5     6     7     8     9
                {"th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th",
                    //    10    11    12    13    14    15    16    17    18    19
                    "th", "th", "th", "th", "th", "th", "th", "th", "th", "th",
                    //    20    21    22    23    24    25    26    27    28    29
                    "th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th",
                    //    30    31
                    "th", "st"};

        String[] monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

        SimpleDateFormat formatDayOfDate = new SimpleDateFormat("d");
        int day = Integer.parseInt(formatDayOfDate.format(date));
        String dayStr = day + suffixes[day];

        SimpleDateFormat formatmonthOfDate = new SimpleDateFormat("MM");
        System.out.println("uu " + Integer.parseInt(formatmonthOfDate.format(date)));
        String month_name = monthNames[Integer.parseInt(formatmonthOfDate.format(date)) - 1];

        SimpleDateFormat formatYearOfDate = new SimpleDateFormat("yyyy");
        String year = formatYearOfDate.format(date);
        return dayStr + " of " + month_name + " " + year;

    }

    public static String getDateFromSelectedDate(Date date, int days) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);

        calendar.add(Calendar.DATE, days);

        return formatter.format(calendar.getTime());
    }

    public static String getFirstDayofWeekFromSelectedDate(Date date) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c = Calendar.getInstance();
        c.setTime(date);
        // Set the calendar to monday of the current week
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

        System.out.println();
        // Print dates of the current week starting on Monday

        return formatter.format(c.getTime());
    }

    public static List<Date> getAllMondaysFromDateRange(Date dateFrom, Date dateTo) {

        List<Date> ar = new ArrayList();
        LocalDate startDate = new LocalDate(dateFrom);
        LocalDate endDate = new LocalDate(dateTo);

        LocalDate thisMonday = startDate.withDayOfWeek(DateTimeConstants.MONDAY);

        if (startDate.isAfter(thisMonday)) {
            startDate = thisMonday.plusWeeks(1); // start on next monday
        } else {
            startDate = thisMonday; // start on this monday
        }

        while (startDate.isBefore(endDate)) {
            System.out.println(startDate);
            ar.add(startDate.toDate());
            startDate = startDate.plusWeeks(1);
        }
        return ar;
    }

    public static String getLastDayofWeekFromSelectedDate(Date date) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c = Calendar.getInstance();
        c.setTime(date);
        // Set the calendar to monday of the current week
        c.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

        System.out.println();
        // Print dates of the current week starting on Monday
        for (int i = 0; i < 6; i++) {
            c.add(Calendar.DATE, 1);
        }

        return formatter.format(c.getTime());
    }

    public static String getDateOld(Date date) {

        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");

        return formatter.format(date);
    }

    public static String getTime(Date time) {

        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");

        return formatter.format(time);
    }

    public static String getTimeHourAndMinuitOnly(Date time) {

        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm aa");

        return formatter.format(time);
    }

    public static String getHour(Date time) {

        SimpleDateFormat formatter = new SimpleDateFormat("HH");

        return formatter.format(time);
    }

    public static String getFullDate(Date time) {

        DateFormat formatter = DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, Locale.US);

        return formatter.format(time);
    }

    public static int getDayCountOfMonth(int year, int month) {

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year);
        calendar.set(Calendar.MONTH, month);
        int numDays = calendar.getActualMaximum(Calendar.DATE);
        return numDays;
    }

    public static long getDayCount(String start, String end) {
        long diff = -1;
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date dateStart = simpleDateFormat.parse(start);
            Date dateEnd = simpleDateFormat.parse(end);

            //time is always 00:00:00 so rounding should help to ignore the missing hour when going from winter to summer time as well as the extra hour in the other direction
            diff = Math.round((dateEnd.getTime() - dateStart.getTime()) / (double) 86400000);
        } catch (Exception e) {
            //handle the exception according to your own situation
        }
        return diff;
    }

    public static String numformat(double number) {
        String pattern = "###,###,#00.00";
        DecimalFormat myFormatter = new DecimalFormat(pattern);
        return myFormatter.format(number);
    }

    public static String formatedQty(double number) {
        String pattern = "###,###,#00";
        DecimalFormat myFormatter = new DecimalFormat(pattern);
        return myFormatter.format(number);
    }

    public static int GetCurrentYear() {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(new Date());

        return Integer.valueOf(cal1.getTime().toString().split(" ")[5]);
    }

    public static int GetCurrentAcademicYear() {
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(new Date());
        int year = Integer.valueOf(cal1.getTime().toString().split(" ")[5]);
        if (GetCurrentMonth() < 7) {
            year = year - 1;
        }
        return year;
    }

    public static int GetCurrentMonth() {
        SimpleDateFormat mm = new SimpleDateFormat("MM");
        Calendar cal1 = Calendar.getInstance();
        cal1.setTime(new Date());

        return Integer.valueOf(mm.format(cal1.getTime()));
    }

    public static String getFormattedDateString(String date) {

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat formatter2 = new SimpleDateFormat("MM/dd/yyyy");
        Date FormattedDate = null;
        try {
            FormattedDate = formatter2.parse(date);
        } catch (Exception e) {
        }

        return formatter.format(FormattedDate);
    }

    public static int daysBetween(Date d1, Date d2) {
        return (int) ((d2.getTime() - d1.getTime()) / (1000 * 60 * 60 * 24));
    }

    public static Date getFormattedTime(String time) {

        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        Calendar startCalendar = new GregorianCalendar();

        try {
            startCalendar.setTime(sdf.parse(time));
        } catch (Exception ex) {
        }

        return startCalendar.getTime();

    }

    public static Date getFormattedTime12H(String time) {

        SimpleDateFormat sdf = new SimpleDateFormat("h:mm a");
        Calendar startCalendar = new GregorianCalendar();

        try {
            startCalendar.setTime(sdf.parse(time));
        } catch (Exception ex) {
        }

        return startCalendar.getTime();

    }

    public static String getTime12H(Date time) {

        SimpleDateFormat sdf = new SimpleDateFormat("h:mm a");

        return sdf.format(time);

    }

    public static String getFoematedStringDate(Date date) {

        String formated_date = null;

        try {

            LocalDate ldate = LocalDate.fromDateFields(date);
            DateTimeFormatter fmt = DateTimeFormat.forPattern("d MMM, yyyy");
            formated_date = ldate.toString(fmt);

        } catch (Exception e) {
            e.printStackTrace();

        }
        return formated_date;
    }

    public static String getFormatedStringDateMonth(Date date) {

        String formated_date = null;

        try {

            LocalDate ldate = LocalDate.fromDateFields(date);
            DateTimeFormatter fmt = DateTimeFormat.forPattern("MMM, dd");
            formated_date = ldate.toString(fmt);

        } catch (Exception e) {
            e.printStackTrace();

        }
        return formated_date;
    }

    public static int getGrade(double amount) {

        int formated_date = 0;

        try {

            if (amount >= 75) {
                formated_date = 4;
            } else if (amount <= 74 && amount >= 66) {
                formated_date = 3;
            } else if (amount <= 65 && amount >= 60) {
                formated_date = 2;
            } else if (amount <= 59 && amount >= 50) {
                formated_date = 1;
            } else if (amount < 50) {
                formated_date = 0;
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
        return formated_date;
    }

    public static String getCredit(double amount) {

        String formated_date = "";

        amount = Math.round(amount);

        try {

            if (amount >= 75) {
                formated_date = "A";
            } else if (amount <= 74 && amount >= 66) {
                formated_date = "B";
            } else if (amount <= 65 && amount >= 60) {
                formated_date = "C";
            } else if (amount <= 59 && amount >= 50) {
                formated_date = "D";
            } else if (amount < 50) {
                formated_date = "E";
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
        return formated_date;
    }

    public static double getPercentOfNumber(double n1, double n2) {

        double result = 0;

        double d1 = n1 / n2;
        System.out.print("D1 : " + d1);
        result = d1 * 100;

        System.out.print("result : " + result);

        return result;
    }

    public static double getAvg(double n1, double n2) {

        double result = n1 / n2;

        return result;
    }

    public static String[] getEmployeeKPIStatus(double value) {
        String status = null;
        String color = null;
        if (value >= 80) {
            status = "Excellent";
//            color
        } else if (value >= 60) {
            status = "Good";
//            color
        } else if (value >= 40) {
            status = "Satisfactory";
//            color
        } else {
            status = "Weak";
//            color
        }
        return new String[]{status, color};
    }

    public static double roundoff(double xVal) {
        return Math.round(xVal * 100.0) / 100.0;
    }

    public static String ConvertedTimeZoneDate(Date date, String zone) throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String actualTime = sdf.format(date);
        //Changed timezone
        TimeZone tzIn = TimeZone.getTimeZone(zone);
        sdf.setTimeZone(tzIn);

        String convertedTime = sdf.format(date);

        return convertedTime;

    }

    public static Date getDate(String date, String time) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.parse(date + " " + time);
    }

    public static String getDateTime(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(date);
    }

    public static String CapitalWord(String givenString) {
        StringBuffer sb = new StringBuffer("");
        if (!givenString.equals("")) {
            givenString = givenString.replace("  ", " ");
            String[] arr = givenString.trim().split(" ");

            for (int i = 0; i < arr.length; i++) {
                sb.append(Character.toUpperCase(arr[i].charAt(0)))
                        .append(arr[i].substring(1)).append(" ");
            }
        }
        return sb.toString().trim();
    }

    public static Date getFirstDaYOfMonthFromDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.DATE, 1);
        Date firstDateOfMonth = cal.getTime();
        return firstDateOfMonth;
    }

    public static Date getFirstDaYOfMonthFromMonth(int year, int month) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DATE, 1);
        Date firstDateOfMonth = cal.getTime();
        return firstDateOfMonth;
    }

    public static Date getLastDaYOfMonthFromMonth(int year, int month) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DATE, 1);

        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE)); // changed calendar to cal

        Date lastDateOfMonth = cal.getTime();

        return lastDateOfMonth;
    }

    public static Date getLastDaYOfMonthFromDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.DATE, 1);

        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE)); // changed calendar to cal

        Date lastDateOfMonth = cal.getTime();

        return lastDateOfMonth;
    }

    public static String getDayFromDate(Date date) {

        String d = date.toString();

        return d.substring(0, 3);

    }

    public static String getDayNameFromDate(Date date) {

        SimpleDateFormat simpleDateformat = new SimpleDateFormat("E"); // the day of the week abbreviated

// 
        simpleDateformat = new SimpleDateFormat("EEEE"); // the day of the week spelled out completely

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);

        return simpleDateformat.format(date);

    }

    public static Date getYesterdayFromDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, -1);
        //  System.out.println("Yesterday's date = " + cal.getTime());
        return cal.getTime();
    }

    public static int getYearFromDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int year = cal.get(Calendar.YEAR);
        //  System.out.println("Yesterday's date = " + cal.getTime());
        return year;
    }

    public static int getMonthFromDate(Date date) {

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int month = cal.get(Calendar.MONTH);

        return month + 1;
    }

    public static String getMonthNameFromDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);

        String month_name = new SimpleDateFormat("MMM").format(cal.getTime()) + "-" + cal.get(Calendar.YEAR);

        return month_name;
    }

    public static Date getPreviousMonthFirstDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, -1);
        cal.set(Calendar.DATE, 1);
        return cal.getTime();
    }

    public static Date getPreviousMonthLastDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, -1);
        cal.set(Calendar.DATE, 1);

        cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE)); // changed calendar to cal

        Date lastDateOfPreviousMonth = cal.getTime();

        return lastDateOfPreviousMonth;
    }

    public static Date getBeforeDateFromGivenDays(Date date, int days) {
        DateTime d1 = DateTime.parse(Com.getDate(date));
        DateTime d2 = d1.minusDays(days);
        Date from = new Date(d2.getMillis());
        return from;
    }

    public static Date getAfterDateFromGivenDays(Date date, int days) {
        DateTime d1 = DateTime.parse(Com.getDate(date));
        DateTime d2 = d1.plusDays(days);
        Date from = new Date(d2.getMillis());
        return from;
    }

    public static List<Date> getMonthsBetweenTwoDates(Date d1, Date d2) {
        List<Date> ret = new ArrayList<Date>();
        Calendar c = Calendar.getInstance();
        c.setTime(d1);
        while (c.getTimeInMillis() <= d2.getTime()) {

            ret.add(c.getTime());
            c.add(Calendar.MONTH, 1);
        }
        return ret;
    }

    public static int getDaysCountBetweenTwoDays(Date d1, Date d2) {
        int daysdiff = 0;
        long diff = d2.getTime() - d1.getTime();
        long diffDays = diff / (24 * 60 * 60 * 1000) + 1;
        daysdiff = (int) diffDays;
        return daysdiff;
    }

    public static int getMonthCountBetweenTwoDays(Date d1, Date d2) {
        Calendar startCalendar = new GregorianCalendar();
        startCalendar.setTime(d1);
        Calendar endCalendar = new GregorianCalendar();
        endCalendar.setTime(d2);
        int diffYear = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);
        int diffMonth = diffYear * 12 + endCalendar.get(Calendar.MONTH) - startCalendar.get(Calendar.MONTH);
        return diffMonth + 1;
    }

    public static int getYearCountBetweenTwoDays(Date d1, Date d2) {
        Calendar a = Calendar.getInstance(Locale.US);
        a.setTime(d1);
        Calendar b = Calendar.getInstance(Locale.US);
        b.setTime(d2);

        int diff = b.get(Calendar.YEAR) - a.get(Calendar.YEAR);

        if (a.get(Calendar.MONTH) > b.get(Calendar.MONTH)
                || (a.get(Calendar.MONTH) == b.get(Calendar.MONTH) && a.get(Calendar.DAY_OF_MONTH) > b.get(Calendar.DAY_OF_MONTH))) {
            diff--;
        }
        return diff;

    }

    public static List<Date> getDaysBetweenDates(Date startdate, Date enddate) {
        List<Date> dates = new ArrayList<Date>();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(startdate);

        while (calendar.getTime().before(enddate)) {
            Date result = calendar.getTime();
            dates.add(result);
            calendar.add(Calendar.DATE, 1);
        }
        dates.add(enddate);
        return dates;
    }

    public static String getUrlName(String input) {
        String[] parts = input.split("-");

        StringBuilder output = new StringBuilder();
        for (int i = 1; i < parts.length; i++) {
            output.append(parts[i]);

            if (i < parts.length - 1) {
                output.append("-");
            }
        }
        return output.toString();
    }
    
    

}
