///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Servlets;
//
//import Model.Connection.NewHibernateUtil;
//import Model.EmployeetIdGenerator;
//import Model.Mapping.Employee;
//import Model.Mapping.GeneralUserProfile;
//import java.io.IOException;
//import java.io.PrintWriter;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import org.hibernate.Criteria;
//import org.hibernate.Session;
//import org.hibernate.Transaction;
//
///**
// *
// * @author kbnc
// */
//public class SelectEmployeeId extends HttpServlet {
//    
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        
//        
//        
//        Session sess = NewHibernateUtil.getSessionFactory().openSession();
//        Criteria c=sess.createCriteria(Employee.class);
//        Transaction t = sess.beginTransaction();
//        
//        String nic="200392399v";
//        System.out.println("select_employeeId_new_m");
//        System.out.println(nic);
//        
//          GeneralUserProfile gup = (GeneralUserProfile) sess.createQuery("From GeneralUserProfile Where nic='" + nic + "'").setMaxResults(1).uniqueResult();
//          
//              if(gup!=null){
//                  resp.getWriter().print(EmployeetIdGenerator.IdGenerator(c.list()));
//              
//              }
//    }
//
//  
//}
