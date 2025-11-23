/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.ProjectTasks;
import Model.Mapping.TaskAssignEmployees;
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
@WebServlet(name = "TaskStatusCountEmpDashboard", urlPatterns = {"/TaskStatusCountEmpDashboard"})
public class TaskStatusCountEmpDashboard extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String year = request.getParameter("year");
        System.out.println("Year  :" + year);

        String projectEmployeeId = request.getParameter("projectEmployee");
        Integer employeeeId = Integer.parseInt(projectEmployeeId);
        System.out.println("projectEmployee  :" + projectEmployeeId);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        try {
            List<ProjectTaskM> pm = new ArrayList<>();

            List<ProjectEmployees> list = sess.createQuery("From ProjectEmployees Where employee_id='" + employeeeId + "'").list();

            if (!list.isEmpty()) {
                System.out.println("Project List Size SERVLET : " + list.size());

                for (ProjectEmployees pe : list) {

                    Integer projectEmployee = pe.getId();

                    List<TaskAssignEmployees> listTask = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmployee + "'").list();

                    if (!listTask.isEmpty()) {
                        System.out.println("Task Emp list Size SERVLET : " + listTask.size());

                        for (TaskAssignEmployees tae : listTask) {
                            if (tae.getIsActive() == Boolean.TRUE) {

                                if (tae.getProjectTasks().getStatus().getId() == 3) {

                                    Integer projectTaskId = tae.getProjectTasks().getId();

                                    List<ProjectTasks> listTaskYear = sess.createQuery("From ProjectTasks Where id='" + projectTaskId + "' and YEAR(completed_date)='" + year + "'").list();

                                    if (!listTaskYear.isEmpty()) {

                                        System.out.println("list-size : " + listTaskYear.size());

                                        for (ProjectTasks per : listTaskYear) {

                                            ProjectTaskM pem = new ProjectTaskM();
                                            pem.setCompletedDate(per.getCompletedDate());
                                            pm.add(pem);

                                        }
                                    }

                                }
                            }
                        }
                    }
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
