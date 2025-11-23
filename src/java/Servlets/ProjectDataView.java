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
import Model.ProjectM;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import org.json.simple.JSONObject;

/**
 *
 * @author Developer
 */
@WebServlet(name = "ProjectDataView", urlPatterns = {"/ProjectDataView"})
public class ProjectDataView extends HttpServlet {

    JSONObject objSend = new JSONObject();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("____________Project Data View___________");
        String id = request.getParameter("id");
        System.out.println("id  :" + id);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();

        Projects pro = (Projects) sess.createQuery("From Projects Where id='" + id + "'").setMaxResults(1).uniqueResult();

        ProjectM pm = new ProjectM();

        if (pro == null) {
            System.out.println("Project View Id Not Ok");
        } else {

            System.out.println("Project View Id Ok");

            pm.setId(pro.getId());
            pm.setName(pro.getName());
            pm.setStartedDate(pro.getStartedDate());
            pm.setCompletedDate(pro.getCompletedDate());
            pm.setGeneralOrganizationProfileName(pro.getGeneralOrganizationProfile().getName());
            pm.setAddress1(pro.getGeneralOrganizationProfile().getAddress1());
            pm.setAddress2(pro.getGeneralOrganizationProfile().getAddress2());
            pm.setAddress3(pro.getGeneralOrganizationProfile().getAddress3());
            pm.setEmail(pro.getGeneralOrganizationProfile().getEmail());
            pm.setContactNo(pro.getGeneralOrganizationProfile().getContactNo());
            pm.setFaxNo(pro.getGeneralOrganizationProfile().getFaxNo());
            pm.setCountryName(pro.getGeneralOrganizationProfile().getCountry().getName());
            pm.setDescription(pro.getDescription());
            pm.setStatusId(pro.getStatus().getId());
            pm.setStatusName(pro.getStatus().getName());
            pm.setStartedDate(pro.getStartedDate());
            pm.setCompletedDate(pro.getCompletedDate());
            pm.setProjectDocuments(pro.getProjectsDocument());
            pm.setLogoUrl(pro.getLogoUrl());

            System.out.println("view_project");

            ObjectMapper mapper = new ObjectMapper();
            mapper.writeValueAsString(pm);
            System.out.println(mapper.writeValueAsString(pm));
            response.getWriter().print(mapper.writeValueAsString(pm));

        }

        try {

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            sess.close();
        }

    }

}
