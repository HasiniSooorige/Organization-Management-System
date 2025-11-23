/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectTasks;
import java.io.IOException;
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
@WebServlet(name = "UpdateTaskStatus", urlPatterns = {"/UpdateTaskStatus"})
public class UpdateTaskStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("__________Update  Task  Status__________");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";

        String statusId = request.getParameter("status");
        String taskid = request.getParameter("taskid");
        String projectId = request.getParameter("projectId");

        Boolean uaction_check;

        if (statusId.equals("true")) {

            uaction_check = false;
            System.out.println("0");

        } else {
            uaction_check = true;
            System.out.println("1");
        }

        ProjectTasks pro = (ProjectTasks) sess.createQuery("From ProjectTasks Where id='" + taskid + "'").setMaxResults(1).uniqueResult();

        if (pro == null) {
            status = 404; // Not Found
            message = "Task not Found";
            System.out.println("Task not found");
        } else {
            pro.setIsActive(uaction_check);
            sess.update(pro);
            if (uaction_check == false) {
                status = 200;
                message = "Project Task Deactivated Successfully.";
                System.out.println("Task Deactivate");
                objSend.put("status", status);
                objSend.put("message", message);
                response.getWriter().write(objSend.toString());

            } else if (uaction_check == true) {
                status = 300;
                message = "Project Task Activated Successfully.";
                System.out.println("Task Activated");
                objSend.put("status", status);
                objSend.put("message", message);
                response.getWriter().write(objSend.toString());

            }
            t.commit();
        }
        sess.flush();
        sess.clear();
    }

}
