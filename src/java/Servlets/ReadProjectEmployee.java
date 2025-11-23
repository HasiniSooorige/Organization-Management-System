/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.Com;
import Model.Connection.NewHibernateUtil;
import Model.EmployeeM;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.Voucher;
import Model.ProjectEmpRoleM;
import Model.VoucherM;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.joda.time.LocalDate;

/**
 *
 * @author HP
 */
@WebServlet(name = "ReadProjectEmployee", urlPatterns = {"/ReadProjectEmployee"})
public class ReadProjectEmployee extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("___________Read Project Employee__________");
        
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        
        String projectId = request.getParameter("projectId");
        System.out.println(projectId);
        
        try {
            List<ProjectEmpRoleM> uds = new ArrayList<>();
            List<ProjectEmployees> list = sess.createQuery("From ProjectEmployees Where projects_id='" + projectId + "' and is_active= '" + 1 + "'").list();
            
            if (!list.isEmpty()) {
                
                System.out.println("list-size " + list.size());
                
                for (ProjectEmployees gup : list) {
                    
                    ProjectEmpRoleM ud = new ProjectEmpRoleM();
                    
                    ud.setEmpId(gup.getId());
                    ud.setFirstName(gup.getEmployee().getGeneralUserProfile().getFirstName());
                    ud.setLastName(gup.getEmployee().getGeneralUserProfile().getLastName());
                    ud.setProjectEmpRole(gup.getProjectEmployeeRole().getName());
                    
                    uds.add(ud);
                    
                }
            }
            
            String jsonString = new Gson().toJson(uds);
            System.out.println(uds);
            response.getWriter().print(jsonString);
            
        } catch (Exception e) {
            
            e.printStackTrace();
        } finally {
            sess.close();
        }
        
    }
    
}
