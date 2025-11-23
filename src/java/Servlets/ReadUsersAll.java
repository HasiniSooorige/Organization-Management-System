/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Mapping.GeneralUserProfile;
import Model.Connection.NewHibernateUtil;
import Model.EmployeeM;
import Model.Mapping.Employee;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author kbnc
 */
public class ReadUsersAll extends HttpServlet {

    Employee gupp;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("loadusers_all_servlet_call");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        try {
            List<EmployeeM> uds = new ArrayList<>();
            List<Employee> list = sess.createQuery("From Employee").list();
            if (!list.isEmpty()) {

                System.out.println("list-size");
                System.out.println(list.size());
                for (Employee gup : list) {
//                    gupp=gup;
                    EmployeeM ud = new EmployeeM();

                    ud.setNic(gup.getGeneralUserProfile().getNic());
                    ud.setEpfno(gup.getEpfNo());
                    ud.setId(gup.getId());
                    ud.setRegistereddate(gup.getRegisteredDate());
                    ud.setFirstname(gup.getGeneralUserProfile().getFirstName());
                    ud.setLastname(gup.getGeneralUserProfile().getLastName());
                    ud.setAddress1(gup.getGeneralUserProfile().getAddress1());
                    ud.setAddress2(gup.getGeneralUserProfile().getAddress2());
                    ud.setAddress3(gup.getGeneralUserProfile().getAddress3());
                    ud.setMobileno(gup.getGeneralUserProfile().getMobileNo());
                    ud.setHomeno(gup.getGeneralUserProfile().getHomeNo());
                    ud.setEmail(gup.getGeneralUserProfile().getEmail());
                    ud.setProfile_created_date(gup.getGeneralUserProfile().getProfileCreatedDate());

//                    gupp=gup;
                    uds.add(ud);
                }
            }
            String jsonString = new Gson().toJson(uds);
            System.out.println("jsonString");
            System.out.println(jsonString);
            resp.getWriter().print(jsonString);

        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            sess.close();
        }

//           try {
//            
//
//            SessionFactory sessionFactory=NewHibernateUtil.getSessionFactory();
//            Session s=sessionFactory.openSession();
//            Criteria c=s.createCriteria(GeneralUserProfile.class);
//      
//            
//            int i= c.list().size();
//            
//            ServletContext context=req.getServletContext();
//            context.setAttribute("all_users", i);
//
////            List<UserDetails> uds = new ArrayList<>();
//           List<GeneralUserProfile>order_list=c.list();
//            if(order_list.isEmpty()){
//            
//            
//            }else{
//            
////                RequestDispatcher dispatcher=req.getRequestDispatcher("DPA-alluser-table.jsp");
////                req.setAttribute("user_list_all", order_list);
////                dispatcher.forward(req, resp);
//
//
//
////            String jsonString = new Gson().toJson(order_list);
////            resp.getWriter().print(jsonString);
//            
//                System.out.println("jsonString");
//                System.out.println(order_list.toArray());
//                
//            }
//            s.close();
//            
//        } catch (Exception e) {
//        e.printStackTrace();
//        }
    }

}
