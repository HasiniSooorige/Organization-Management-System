/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectTasks;
import Model.ProjectTaskM;
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

/**
 *
 * @author HP
 */
@WebServlet(name = "TaskStatusCountDashbard", urlPatterns = {"/TaskStatusCountDashbard"})
public class TaskStatusCountDashbard extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("________Task Status Count Dashbard_______________");

        String year = request.getParameter("year");
        System.out.println("Year  :" + year);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();

        try {
            List<ProjectTaskM> pm = new ArrayList<>();

            List<ProjectTasks> list = sess.createQuery("From ProjectTasks Where YEAR(completed_date)='" + year + "'").list();

            if (!list.isEmpty()) {

                System.out.println("list-size : " + list.size());

                for (ProjectTasks per : list) {

                    ProjectTaskM pem = new ProjectTaskM();
                    
                    pem.setCompletedDate(per.getCompletedDate());

                    pm.add(pem);

                }
            }

            String jsonString = new Gson().toJson(pm);
            System.out.println(jsonString);
            response.getWriter().print(jsonString);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sess.close();
        }

    }

}
