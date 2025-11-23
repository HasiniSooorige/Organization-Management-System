/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.ProjectGopAgreement;
import Model.ProjectEmpRoleM;
import Model.ProjectGopAgreementM;
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
@WebServlet(name = "ProjectAgreementHistoryView", urlPatterns = {"/ProjectAgreementHistoryView"})
public class ProjectAgreementHistoryView extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("________Project  Agreement  History  View_______________");

        String id = request.getParameter("id");
        System.out.println("Emp Role id  :" + id);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();

        try {
            List<ProjectGopAgreementM> pm = new ArrayList<>();

            List<ProjectGopAgreement> list = sess.createQuery("From ProjectGopAgreement Where projects_id='" + id + "'").list();

            String content = "";

            if (!list.isEmpty()) {

                System.out.println("list-size" + list.size());

                for (ProjectGopAgreement per : list) {

                    ProjectGopAgreementM pem = new ProjectGopAgreementM();

                    pem.setId(per.getId());
                    pem.setGeneralOrganizationProfile(per.getGeneralOrganizationProfile().getId());
                    pem.setProjects(per.getProjects().getId());
                    pem.setDocument(per.getDocument());
                    pem.setUploadedDate(per.getUploadedDate());

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
