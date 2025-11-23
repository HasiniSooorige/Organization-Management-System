/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.GeneralOrganizationProfile;
import Model.Mapping.GeneralUserProfile;
import Model.Mapping.GupGopManager;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.UserLogin;
import Model.Mapping.UserRole;
import static Servlets.CreateNewClient.convertStringToDate;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "ProjectTeamStatusUpdate", urlPatterns = {"/ProjectTeamStatusUpdate"})
public class ProjectTeamStatusUpdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("_____________Project Team Status Update_______________");
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";
        Boolean status_active;

        try {
            String projectId = request.getParameter("projectId");
            String empId = request.getParameter("empId");
            String roleId = request.getParameter("roleId");
            String status_is = request.getParameter("status");

            System.out.println(projectId + " - " + empId + " - " + roleId + " - " + status_is);

            if ("true".equals(status_is)) {
                status_active = false;
            } else {
                status_active = true;
            }

            Employee emp = (Employee) sess.createQuery("From Employee Where id='" + empId + "'").setMaxResults(1).uniqueResult();

            if (emp.getResignationDate() == null) {
                System.out.println("Not Resign");

                if (emp.getIsActive() == true) {
                    System.out.println("Active Employee");

                    ProjectEmployees pm = (ProjectEmployees) sess.createQuery("From ProjectEmployees Where projects_id='" + projectId + "' and employee_id='" + empId + "' and project_employee_role_id='" + roleId + "'").setMaxResults(1).uniqueResult();

                    System.out.println(pm.getId());
                    pm.setIsActive(status_active);

                    sess.update(pm);

                    if ("true".equals(status_is)) {
                        status = 200;
                        message = "Employee Remove Successful";
                    } else {
                        status = 200;
                        message = "Employee Add Successful";
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
