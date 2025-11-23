package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.ProjectTasks;
import Model.Mapping.TaskAssignEmployees;
import Model.Mapping.UserLogin;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;

@WebServlet(name = "UpdateActiveStatus", urlPatterns = {"/UpdateActiveStatus"})
public class UpdateActiveStatus extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        System.out.println("---------------Update  Active  Status----------");
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";
        
        String activeStatus = request.getParameter("status");
        String gupId = request.getParameter("gupid");
        
        System.out.println(activeStatus + "," + gupId);
        
        Boolean uaction_check;
        
        if (activeStatus.equals("true")) {
            uaction_check = false;
            System.out.println(uaction_check + "  0");
            
        } else {
            uaction_check = true;
            System.out.println(uaction_check + "  1");
        }
        
        Employee emp = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + gupId + "'").setMaxResults(1).uniqueResult();
        
        if (emp == null) {
            status = 404;
            message = "Employee not found";
            System.out.println("Employee not found");
            
        } else {
            
            UserLogin ul = (UserLogin) sess.createQuery("From UserLogin Where general_user_profile_id='" + gupId + "'").setMaxResults(1).uniqueResult();
            
            if (ul == null) {
                status = 404;
                message = "Login Details not found";
                System.out.println("Login Details not found");
            } else {
                
                emp.setIsActive(uaction_check);
                ul.setIsActive(uaction_check);
                
                sess.update(emp);
                sess.update(ul);
                
                List<ProjectEmployees> list = sess.createQuery("From ProjectEmployees Where employee_id='" + emp.getId() + "'").list();
                
                if (!list.isEmpty()) {
                    
                    for (ProjectEmployees per : list) {
                        
                        per.setIsActive(uaction_check);
                        sess.update(per);
                        
                        List<TaskAssignEmployees> taskList = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + per.getId() + "'").list();
                        
                        if (!taskList.isEmpty()) {
                            
                            for (TaskAssignEmployees task : taskList) {
                                
                                task.setIsActive(uaction_check);
                                sess.update(task);
                            }
                        }
                    }
                }
                
                if (uaction_check == false) {
                    status = 200;
                    message = "Employee Deactivated Successfully.";
                    System.out.println("Employee Deactivate");
                    objSend.put("status", status);
                    objSend.put("message", message);
                    response.getWriter().write(objSend.toString());
                    
                } else if (uaction_check == true) {
                    status = 300;
                    message = "Employee Activated Successfully.";
                    System.out.println("Employee Activated");
                    objSend.put("status", status);
                    objSend.put("message", message);
                    response.getWriter().write(objSend.toString());
                    
                }
                t.commit();
            }
            
        }
        
        sess.flush();
        sess.clear();
    }
    
}
