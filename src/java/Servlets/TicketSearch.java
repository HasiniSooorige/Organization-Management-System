package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.HelpTicket;
import static Servlets.UserTicketSearch.convertAndFormatToDefaultDateType;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;

@WebServlet(name = "TicketSearch", urlPatterns = {"/TicketSearch"})
public class TicketSearch extends HttpServlet {

    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(Calendar.getInstance().getTime());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
//        System.out.println("ABS");
        // Retrieve parameters from the URL
        String fromDate = req.getParameter("datefrom");
        String toDate = req.getParameter("dateto");
        String requestBy = req.getParameter("requestby");
        String requestStatus = req.getParameter("status");

//        if (requestStatus.equals("")) {
//            requestStatus = null;
//        }
//        if (requestBy.equals("")) {
//            requestBy = null;
//        }

        // You can print or use the parameters as needed
        System.out.println("fromDate: " + fromDate);
        System.out.println("toDate: " + toDate);
        System.out.println("requestBy: " + requestBy);
        System.out.println("requestStatus: " + requestStatus);

        Date convertedDateF = null;
        Date convertedDateT = null;
        if (!fromDate.equals("")) {
            convertedDateF = convertAndFormatToDefaultDateType(fromDate);

        }
        if (!toDate.equals("")) {
            convertedDateT = convertAndFormatToDefaultDateType(toDate);
        }
        
        System.out.println("convertedDateT: "+convertedDateT);

        String formattedDateFrom = "";
        String formattedDateTo = "";

        SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

        if (convertedDateF != null) {
            formattedDateFrom = outputDateFormat.format(convertedDateF);
        } 
        if (convertedDateT != null) {
            formattedDateTo = outputDateFormat.format(convertedDateT);
        }
        
        System.out.println("formattedDateTo: " +formattedDateTo);

        StringBuffer sb = new StringBuffer("From HelpTicket AS HelpTicket");
        boolean conditionsAdded = false;

        sb.append(" WHERE ");

        if (!fromDate.equals("")) {
            sb.append("enteredDate > '").append(formattedDateFrom).append("'");
            conditionsAdded = true;
        }

        if (!toDate.equals("")) {
            if (conditionsAdded) {
                sb.append(" AND ");
            }
            sb.append("enteredDate < '").append(formattedDateTo).append("'");
            conditionsAdded = true;
        }

        if (!requestBy.equals("")) {
            if (conditionsAdded) {
                sb.append(" AND ");
            }
            sb.append("requestedBy = '").append(requestBy).append("'");
            conditionsAdded = true;
        }
        if (!requestStatus.equals("")) {
            if (conditionsAdded) {
                sb.append(" AND ");
            }
            sb.append("helpTicketStatus = '").append(requestStatus).append("'");
            conditionsAdded = true;
        }

        if (!conditionsAdded) {
            sb.delete(sb.length() - " WHERE ".length(), sb.length());
        }

        String sqlQuery = sb.toString();
        System.out.println("query: " + sqlQuery);

        // Create a JSON array to hold the JSON objects for each HelpTicket
        JsonArray helpTicketsJsonArray = new JsonArray();

        try {
            List<HelpTicket> helpTickets = sess.createQuery(sqlQuery).list();

            for (HelpTicket ticket : helpTickets) {
                JsonObject helpTicketJson = new JsonObject();
                helpTicketJson.addProperty("id", ticket.getTicketId());
                helpTicketJson.addProperty("enteredDate", ticket.getEnteredDate().toString());
                //            Comment Hasini
//                helpTicketJson.addProperty("requestBy", ticket.getRequestedBy());
                helpTicketJson.addProperty("category", ticket.getHelpTicketCategory().getName());
                helpTicketJson.addProperty("status", ticket.getHelpTicketStatus().getName());

                // Add the JSON object for this HelpTicket to the JSON array
                helpTicketsJsonArray.add(helpTicketJson);
            }

            // Convert the JSON array to a string
            String jsonResponse = helpTicketsJsonArray.toString();
            System.out.println("Json: " + jsonResponse);

            // Set the JSON response and appropriate headers
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static Date convertStringToDate(String date) {
        if (date != null) {
            try {
                return FORMATTER.parse(date);
            } catch (ParseException e) {
                // nothing we can do if the input is invalid
                throw new RuntimeException(e);
            }
        }
        return null;
    }

    public static Date convertAndFormatToDefaultDateType(String dateStr) {
        if (dateStr == null) {
            return null;
        }

        try {
            // Parse the input string to a Date object
            SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = inputDateFormat.parse(dateStr);

            return date;

        } catch (ParseException e) {
            System.err.println("Error parsing the input date string: " + e.getMessage());
        }
        return null;
    }
}
