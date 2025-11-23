/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectGopAgreement;
import Model.Mapping.ProjectTaskAttachments;
import Model.ProjectGopAgreementM;
import Model.ProjectTaskM;
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
import org.hibernate.Transaction;
import org.json.simple.JSONArray;

/**
 *
 * @author HP
 */
@WebServlet(name = "TaskDocumentView", urlPatterns = {"/TaskDocumentView"})
public class TaskDocumentView extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("_____Task  Document  View____");

        String id = request.getParameter("id");
        System.out.println("Task id  :" + id);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();

        try {
            List<ProjectTaskM> pm = new ArrayList<>();

            List<ProjectTaskAttachments> list = sess.createQuery("From ProjectTaskAttachments Where project_tasks_id='" + id + "'").list();

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());

                for (ProjectTaskAttachments per : list) {

                    ProjectTaskM pem = new ProjectTaskM();


                    pem.setUrl(per.getUrl());

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
