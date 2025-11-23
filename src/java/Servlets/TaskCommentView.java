/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommentManagerM;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.CommentsManager;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONArray;

/**
 *
 * @author HP
 */
@WebServlet(name = "TaskCommentView", urlPatterns = {"/TaskCommentView"})
public class TaskCommentView extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("____Task  Comment  View____");

        String taskId = request.getParameter("taskId");
        String projectId = request.getParameter("projectId");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();

        try {
            List<CommentManagerM> pm = new ArrayList<>();

            List<CommentsManager> list = sess.createQuery("From CommentsManager Where projects_id='" + projectId + "' and project_tasks_id='" + taskId + "'").list();

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());

                for (CommentsManager per : list) {

                    CommentManagerM pem = new CommentManagerM();

                    pem.setGupFirstName(per.getGeneralUserProfile().getFirstName());
                    pem.setGupLastName(per.getGeneralUserProfile().getLastName());
                    pem.setAddedDate(per.getAddedDate());
                    pem.setComment(per.getComment());
                    pem.setGupFirstNameEMP(per.getProjectEmployees().getEmployee().getGeneralUserProfile().getFirstName());
                    pem.setGupLastNameEMP(per.getProjectEmployees().getEmployee().getGeneralUserProfile().getLastName());

                    pm.add(pem);

                }
            }

            String jsonString = new Gson().toJson(pm);
            System.out.println("jsonString");
            System.out.println(jsonString);
            response.getWriter().print(jsonString);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sess.close();
        }
    }

}
