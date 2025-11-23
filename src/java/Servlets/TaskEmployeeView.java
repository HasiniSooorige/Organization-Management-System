/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectTaskAttachments;
import Model.Mapping.TaskAssignEmployees;
import Model.ProjectEmpRoleM;
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
@WebServlet(name = "TaskEmployeeView", urlPatterns = {"/TaskEmployeeView"})
public class TaskEmployeeView extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("_____Task  Employee  View_____");

        String id = request.getParameter("id");
        System.out.println("Task id  :" + id);
        Byte isActive = 1;

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();

        try {
            List<ProjectEmpRoleM> pm = new ArrayList<>();

            List<TaskAssignEmployees> list = sess.createQuery("From TaskAssignEmployees Where project_tasks_id='" + id + "' and is_active='" + isActive + "' ").list();

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());
                System.out.println(list);
                for (TaskAssignEmployees per : list) {

                    ProjectEmpRoleM pem = new ProjectEmpRoleM();

                    pem.setEmpId(per.getProjectEmployees().getId());
                    pem.setFirstName(per.getProjectEmployees().getEmployee().getGeneralUserProfile().getFirstName());
                    pem.setLastName(per.getProjectEmployees().getEmployee().getGeneralUserProfile().getLastName());
                    pem.setDesignation(per.getProjectEmployees().getEmployee().getDesignation().getName());
                    pem.setProEmpRoleId(per.getProjectEmployees().getProjectEmployeeRole().getId());
                    pem.setProjectEmpRole(per.getProjectEmployees().getProjectEmployeeRole().getName());
                    pem.setStartDate(per.getStartDate());
                    pem.setEndDate(per.getEndDate());
                    pem.setIsActive(per.getIsActive());

                    pm.add(pem);
                    
                    System.out.println(per.getStartDate() + "______ " + per.getEndDate());

                }
            }

            String jsonString = new Gson().toJson(pm);
            System.out.println("jsonString taskEmp");
            System.out.println(jsonString);
            response.getWriter().print(jsonString);

        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            sess.close();
        }

    }

}
