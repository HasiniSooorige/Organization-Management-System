/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectTasks;
import Model.Mapping.Projects;
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

/**
 *
 * @author HP
 */
@WebServlet(name = "UpdateProjectStatus", urlPatterns = {"/UpdateProjectStatus"})
public class UpdateProjectStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("___________Update  Project  Status________________");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";

        String activestatus = request.getParameter("status");
        String id = request.getParameter("id");

        System.out.println("status :  " + activestatus + "   ,   Id :  " + id);

        Boolean uaction_check;

        if (activestatus.equals("true")) {

            uaction_check = false;
            System.out.println("0");

        } else {
            uaction_check = true;
            System.out.println("1");
        }

        Projects pro = (Projects) sess.createQuery("From Projects Where id='" + id + "'").setMaxResults(1).uniqueResult();

        if (pro == null) {

            status = 404; // Not Found
            message = "Project not found";
            System.out.println("Project not found");

        } else {

            pro.setIsActive(uaction_check);
            sess.update(pro);

            List<ProjectTasks> list = sess.createQuery("From ProjectTasks Where projects_id='" + id + "'").list();

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());

                for (ProjectTasks per : list) {

                    per.setIsActive(uaction_check);
                    sess.update(per);

                }
            }

            if (uaction_check == false) {
                status = 200;
                message = "Project Deactivated Successfully.";
                System.out.println("Project Deactivate");
                objSend.put("status", status);
                objSend.put("message", message);
                response.getWriter().write(objSend.toString());
            } else {
                status = 300;
                message = "Project Activated Successfully.";
                System.out.println("Project Activated");
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
