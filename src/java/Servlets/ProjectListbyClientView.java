/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.GeneralOrganizationProfileM;
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
import org.json.simple.JSONArray;

/**
 *
 * @author HP
 */
@WebServlet(name = "ProjectListbyClientView", urlPatterns = {"/ProjectListbyClientView"})
public class ProjectListbyClientView extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("________Project List by Client View_______________");

        String id = request.getParameter("id");
        System.out.println("Project GOP id  :" + id);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();

        try {
            List<GeneralOrganizationProfileM> pm = new ArrayList<>();

            List<Projects> list = sess.createQuery("From Projects Where general_organization_profile_id='" + id + "'").list();

            String content = "";

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());

                for (Projects per : list) {

                    GeneralOrganizationProfileM pem = new GeneralOrganizationProfileM();

                    pem.setProName(per.getName());
                    pem.setProStatus(per.getStatus().getName());

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
