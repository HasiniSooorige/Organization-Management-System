/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.EmployeetIdGenerator;
import Model.Mapping.Employee;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author kbnc
 */
@WebServlet(name = "SelectEpfNo", urlPatterns = {"/SelectEpfNo"})
public class SelectEpfNo extends HttpServlet {

    int status = 200;
    String message = "";
    boolean success = false;
//        JSONArray js = new JSONArray();
//        Map m = new HashMap();
    JSONObject objSend = new JSONObject();

    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd");
    String timeStamp = new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
    SessionFactory sessionFactory;
    Session s;
    Employee employee;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("iam_doget");

        sessionFactory = NewHibernateUtil.getSessionFactory();
        s = sessionFactory.openSession();

        Criteria c = s.createCriteria(Employee.class);
        int id = EmployeetIdGenerator.IdGenerator(c.list());

        objSend.put("success", success);
        objSend.put("epfno", id);
        objSend.put("current_date", "" + convertStringToDate(timeStamp));
        objSend.put("link", "");

        out.print(objSend);
        response.getWriter().print(objSend);

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

}
