/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.TaskAssignEmployees;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "TaskTeamStatusUpdate", urlPatterns = {"/TaskTeamStatusUpdate"})
public class TaskTeamStatusUpdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("_______Task  Team  Status  Update______");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";
        Boolean status_active;

        try {
            String taskId = request.getParameter("taskId");
            String empId = request.getParameter("empId");
            String projectRoleId = request.getParameter("projectRoleId");
            String isActive = request.getParameter("isActive");

            System.out.println(taskId + " - " + empId + " - " + projectRoleId + " - " + isActive);

            if ("true".equals(isActive)) {
                status_active = false;
            } else {
                status_active = true;
            }

            ProjectEmployees pe = (ProjectEmployees) sess.createQuery("From ProjectEmployees Where id='" + empId + "'").setMaxResults(1).uniqueResult();

            Employee emp = (Employee) sess.createQuery("From Employee Where id='" + pe.getEmployee().getId() + "'").setMaxResults(1).uniqueResult();

            if (emp.getResignationDate() == null) {
                System.out.println("Not Resign");

                if (emp.getIsActive() == true) {
                    System.out.println("Active Employee");

                    if (pe.getIsActive() == true) {
                        System.out.println("Active Project Employee");

                        TaskAssignEmployees pm = (TaskAssignEmployees) sess.createQuery("From TaskAssignEmployees Where project_tasks_id='" + taskId + "' and project_employees_id='" + empId + "'").setMaxResults(1).uniqueResult();

                        if (pm == null) {
                            System.out.println("null");
                        } else {
                            System.out.println("not null");
                            pm.setIsActive(status_active);

                            sess.update(pm);
                        }

                        if ("true".equals(isActive)) {
                            status = 200;
                            message = "Employee Remove Successful";
                        } else {
                            status = 200;
                            message = "Employee Add Successful";
                        }

                    } else {
                        status = 400;
                        message = "The employee has been diactivated from the project!";
                    }

                } else {
                    status = 400;
                    message = "Deactivated Employee Account.";
                }

            } else {
                status = 400;
                message = "The Employee Resigned.";
            }

            t.commit();

        } catch (Exception e) {
            status = 400;
            message = "Data Not Saved";
            e.printStackTrace();
        } finally {
            sess.close();
        }
        objSend.put("status", status);
        objSend.put("message", message);
        response.getWriter().print(objSend);
        System.out.println(objSend);
    }

}
