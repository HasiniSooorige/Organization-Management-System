/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.TaskAssignEmployees;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONObject;

/**
 *
 * @author user
 */
@WebServlet(name = "SaveResignation", urlPatterns = {"/SaveResignation"})
public class SaveResignation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("_______________Save  Resignation__________________");
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        int status = 200;
        String message = "";
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String jsonString = sb.toString();
        JSONObject resDetails = new JSONObject(jsonString);
        String resDate = resDetails.getString("res");
        String id = resDetails.getString("id");

        JSONObject responseJson = new JSONObject();

        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction tr = session.beginTransaction();

        Employee emp = (Employee) session.createQuery("From Employee Where id='" + id + "'").setMaxResults(1).uniqueResult();
        Integer empGupId = emp.getGeneralUserProfile().getId();

        try {
            if (resDate == null) {
                status = 400;
                message = "Resignation Date Can`t Emplty !!!";
            } else {
                String hql = "UPDATE Employee SET resignation_date ='" + resDate + "', is_active='0' WHERE id ='" + id + "'";
                Query query = session.createQuery(hql);
                int rowsUpdated = query.executeUpdate();

                String hql2 = "UPDATE UserLogin SET is_active ='0' WHERE general_user_profile_id ='" + empGupId + "'";
                Query query2 = session.createQuery(hql2);
                int rowsUpdated2 = query2.executeUpdate();

                List<ProjectEmployees> list = session.createQuery("From ProjectEmployees Where employee_id='" + emp.getId() + "'").list();

                if (!list.isEmpty()) {

                    for (ProjectEmployees per : list) {

                        per.setIsActive(Boolean.FALSE);
                        session.update(per);

                        List<TaskAssignEmployees> taskList = session.createQuery("From TaskAssignEmployees Where project_employees_id='" + per.getId() + "'").list();

                        if (!taskList.isEmpty()) {

                            for (TaskAssignEmployees task : taskList) {

                                task.setIsActive(Boolean.FALSE);
                                session.update(task);
                            }
                        }
                    }
                }

                tr.commit();
                status = 200;
                message = "Resignation Successfully Saved !";
            }
        } catch (Exception e) {
            status = 500;
            message = "Resignation Not Saved !!!";
            e.printStackTrace();
        } finally {
            session.close();
        }

        responseJson.put("status", status);
        responseJson.put("message", message);
        resp.getWriter().print(responseJson);
        System.out.println(responseJson);
//        responseJson.put("status", "Resignation Successfully completed");
//        resp.getWriter().write(responseJson.toString());

    }

}
