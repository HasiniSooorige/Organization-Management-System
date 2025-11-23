/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.EmployeeM;
import Model.Mapping.Employee;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.Projects;
import Model.ProjectEmpRoleM;
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

import org.json.JSONObject;
import org.json.simple.JSONArray;

/**
 *
 * @author HP
 */
@WebServlet(name = "ProjectEmpRoleListView", urlPatterns = {"/ProjectEmpRoleListView"})
public class ProjectEmpRoleListView extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("________Project  Emp  Role  List  View_______________");

        String id = request.getParameter("id");
        System.out.println("Emp Role id  :" + id);
        
        Byte isActive=1;

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();
        try {
            List<ProjectEmpRoleM> pm = new ArrayList<>();

            List<ProjectEmployees> list = sess.createQuery("From ProjectEmployees Where projects_id='" + id + "' and is_active='" + isActive + "' ").list();

            String content = "";

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());

                for (ProjectEmployees per : list) {

                    ProjectEmpRoleM pem = new ProjectEmpRoleM();

                    content += "<tr>" + per.getEmployee().getId() + "</tr>";

                    pem.setEmpId(per.getEmployee().getId());
                    pem.setFirstName(per.getEmployee().getGeneralUserProfile().getFirstName());
                    pem.setLastName(per.getEmployee().getGeneralUserProfile().getLastName());
                    pem.setDesignation(per.getEmployee().getDesignation().getName());
                    pem.setProEmpRoleId(per.getProjectEmployeeRole().getId());
                    pem.setProjectEmpRole(per.getProjectEmployeeRole().getName());

                    pm.add(pem);

                    System.out.println("emp _____" + per.getEmployee().getGeneralUserProfile().getFirstName());

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
