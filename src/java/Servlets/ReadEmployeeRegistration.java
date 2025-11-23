///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package Servlets;
//
//import Model.Connection.NewHibernateUtil;
//import Model.EmployeetIdGenerator;
//import Model.Mapping.Designation;
//import Model.Mapping.Employee;
//import Model.Mapping.GeneralOrganizationProfile;
//import Model.Mapping.GeneralUserProfile;
//import com.google.gson.Gson;
//import java.io.IOException;
//import java.io.PrintWriter;
//import java.text.ParseException;
//import java.text.SimpleDateFormat;
//import java.util.Calendar;
//import java.util.Date;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import org.hibernate.Criteria;
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.hibernate.Transaction;
//import org.hibernate.criterion.Restrictions;
//
///**
// *
// * @author kbnc
// */
//public class ReadEmployeeRegistration extends HttpServlet {
//
//
//
//    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
//        String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(Calendar.getInstance().getTime());
//    SessionFactory sessionFactory;
//            Session s;
//            Employee employee;
//                    
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        
//         try {
//             
//               sessionFactory=NewHibernateUtil.getSessionFactory();
//             s=sessionFactory.openSession();
//            
//            Criteria c=s.createCriteria(Employee.class);
//            String reg_date=req.getParameter("reg_date");
//            String organization_by=req.getParameter("organization_by");
//            String designation=req.getParameter("designation");
//            String epf_no=req.getParameter("epf_no");
//            String nic=req.getParameter("nic");
//            
//             System.out.println("epf_no");
//             System.out.println(epf_no);
//             System.out.println("reg_date");
//             System.out.println(reg_date);
//             System.out.println("organization_by");
//             System.out.println(organization_by);
//             System.out.println("designation");
//             System.out.println(designation);
//             
////             resp.getWriter().write(EmployeetIdGenerator.IdGenerator(c.list()));
//             
//             
//              GeneralUserProfile gup = (GeneralUserProfile) s.createQuery("From GeneralUserProfile Where nic='" + nic + "'").setMaxResults(1).uniqueResult();
//              
//              
//              
//              
//              
//              
//              if(gup!=null){
//                  
//                  
//                  
//                  Model.GeneralUserProfile newObj=new Model.GeneralUserProfile();
//                  newObj.setEmpid(EmployeetIdGenerator.IdGenerator(c.list()));
//                  
//              newObj.setId(gup.getId());
//              newObj.setNic(gup.getNic());
//              newObj.setFirstName(gup.getFirstName());
//              newObj.setLastName(gup.getLastName());
//              newObj.setAddress1(gup.getAddress1());
//              newObj.setAddress2(gup.getAddress2());
//              newObj.setAddress3(gup.getAddress3());
//              newObj.setMobileNo(gup.getMobileNo());
//              newObj.setHomeNo(gup.getHomeNo());
//              newObj.setEmail(gup.getEmail());
//              
//              
//                  
//                  
//                  
//                   
//                   
////            List<GeneralUserProfile> list = s.createQuery("From GeneralUserProfile").list();
//          
//            String jsonString = new Gson().toJson(newObj);
//            
//            
//            
//            
//            
//
//            
//            
//            
//                  resp.getWriter().print(jsonString);
//                  Transaction t = s.beginTransaction();
//                  
//                  Criteria c2=s.createCriteria(GeneralOrganizationProfile.class);
//                        c2.add(Restrictions.eq("name", organization_by));
//                        GeneralOrganizationProfile oa=(GeneralOrganizationProfile) c2.uniqueResult();
//                  
//                  
//                  Criteria c1=s.createCriteria(Designation.class);
//                        c1.add(Restrictions.eq("name", designation));
//                        Designation da=(Designation) c1.uniqueResult();
//                        employee=new Employee();
//                        
//                        employee.setRegisteredDate(convertStringToDate(timeStamp));
//                        
//                        employee.setEpfNo(epf_no);
//                        employee.setGeneralUserProfile(gup);
//                        employee.setGeneralOrganizationProfile(oa);
//                        employee.setDesignation(da);
//                         s.save(employee);
//                         
//                         
//                         t.commit();
//                         System.out.println("employee_save _ok");
//                  
//                  
////                  System.out.println("jsonString_gup_new");
////                  System.out.println(jsonString);
//            
//                  
//                  
//              
//              }
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//             
//            
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//             
//             
//             
//             
//             
//        
//        
//    }
//    
//    
//      public static Date convertStringToDate(String date) {
//    if (date != null) {
//        try {
//            return FORMATTER.parse(date);
//        } catch (ParseException e) {
//            // nothing we can do if the input is invalid
//            throw new RuntimeException(e);
//        }
//    }
//    return null;
//}
//     
//    
//    
//    
// 
//    
//}
