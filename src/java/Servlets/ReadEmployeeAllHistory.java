/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.EmployeeHistoryM;
import Model.EmployeeM;
import Model.Mapping.Employee;
import Model.Mapping.WorkHistory;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;

/**
 *
 * @author kbnc
 */
public class ReadEmployeeAllHistory extends HttpServlet {
Employee gupp;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        System.out.println("loadusers_all_servlet_call");
        
         Session sess = NewHibernateUtil.getSessionFactory().openSession();
        try {
            List<EmployeeHistoryM> uds = new ArrayList<>();
            List<WorkHistory> list = sess.createQuery("From WorkHistory").list();
            if (!list.isEmpty()) {
                
                System.out.println("list-size");
                System.out.println(list.size());
                for (WorkHistory gup : list) {
//                    gupp=gup;
                    EmployeeHistoryM ud = new EmployeeHistoryM();
                    
                    
                    ud.setEpfno(gup.getEmployee().getEpfNo());
                    ud.setDeignation(gup.getDesignationByDesignationFrom().getName());
                    ud.setNic(gup.getEmployee().getGeneralUserProfile().getNic());
                    ud.setMobileno(gup.getEmployee().getGeneralUserProfile().getMobileNo());
                    ud.setDatefrom(String.valueOf(gup.getDateFrom()));
                    ud.setDateto(String.valueOf(gup.getDateTo()));

                
                    ud.setDesignationfrom(gup.getDesignationByDesignationFrom().getName());
                    ud.setDesignationto(gup.getDesignationByDesignationTo().getName());
                    
//                    gupp=gup;
                    uds.add(ud);
                }
            }
            String jsonString = new Gson().toJson(uds);
            System.out.println("jsonString_employee_history");
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