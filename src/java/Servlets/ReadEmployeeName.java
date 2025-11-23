/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.EmployeeM;
import Model.Mapping.Country;
import Model.Mapping.Employee;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.simple.JSONArray;

/**
 *
 * @author HP
 */
public class ReadEmployeeName extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        JSONArray js = new JSONArray();
        Map m = new HashMap();

        try {

            Session s = NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(Employee.class);

            List<Employee> cat_list = c.list();
            List<String> list = new ArrayList<String>();

            for (Employee employee : cat_list) {
                EmployeeM ud = new EmployeeM();
                list.add(employee.getGeneralUserProfile().getId().toString());
                list.add(employee.getGeneralUserProfile().getFirstName());
                list.add(employee.getGeneralUserProfile().getLastName());
                


            }
            String jsonString = new Gson().toJson(list);
            System.out.println("jsonString");
            System.out.println(jsonString);
            response.getWriter().print(jsonString);
        } catch (Exception e) {
            e.printStackTrace();
        }

//        try {
//            List<EmployeeM> uds = new ArrayList<>();
//            List<Employee> list = sess.createQuery("From Employee").list();
//            if (!list.isEmpty()) {
//
//                System.out.println("list-size");
//                System.out.println(list.size());
//                for (Employee gup : list) {
//
//                    EmployeeM ud = new EmployeeM();
//////                    ud.setId(gup.getId());
////                    ud.setFirstname(gup.getGeneralUserProfile().getFirstName());
////                    ud.setLastname(gup.getGeneralUserProfile().getLastName());
//
//                    gup.getId();
//                    gup.getGeneralUserProfile().getFirstName();
//                    gup.getGeneralUserProfile().getLastName();
//
//                    uds.add(ud);
//                }
//            }
//            String jsonString = new Gson().toJson(uds);
//            System.out.println("jsonString");
//            System.out.println(jsonString);
//            response.getWriter().print(jsonString);
//
//        } catch (Exception e) {
//
//            e.printStackTrace();
//        } finally {
//            sess.close();
//        }
    }

}
