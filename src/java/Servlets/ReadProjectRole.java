/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Country;
import Model.Mapping.ProjectEmployeeRole;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.simple.JSONArray;

/**
 *
 * @author HP
 */
public class ReadProjectRole extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONArray js = new JSONArray();
        Map m = new HashMap();
        try {

            Session s = NewHibernateUtil.getSessionFactory().openSession();
            Criteria c = s.createCriteria(ProjectEmployeeRole.class);
            List<ProjectEmployeeRole> cat_list = c.list();
            List<String> list = new ArrayList<String>();
            for (ProjectEmployeeRole per : cat_list) {
                list.add(per.getName());

            }
            response.getWriter().write(js.toJSONString(list));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
