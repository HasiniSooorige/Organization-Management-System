/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.UserCredentials;
import Model.UserCredentialsM;
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

/**
 *
 * @author Jalana
 */
@WebServlet(name = "ReadCredentialAll", urlPatterns = {"/ReadCredentialAll"})

public class ReadCredentialAll extends HttpServlet {

    Employee gupp;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("load_cred_all_servlet_call");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        try {
            List<UserCredentialsM> uds = new ArrayList<>();
            List<UserCredentials> list = sess.createQuery("From UserCredentials").list();
            if (!list.isEmpty()) {

                System.out.println("list-size");
                System.out.println(list.size());
                for (UserCredentials gup : list) {
//                    gupp=gup;
                    UserCredentialsM ud = new UserCredentialsM();

                    ud.setId(gup.getId());
                    ud.setProject(gup.getProjects().getName());
                    ud.setUsername(gup.getUsername());
                    ud.setType(gup.getUserCredentialType().getName());
                    ud.setCategory(gup.getUserCredentialCategory().getName());
                    Boolean st = gup.getIsActive();
                    if (st == false) {
                        ud.setStatus("Inactive");
                    } else {
                        ud.setStatus("Active");
                    }

                    uds.add(ud);
                }
            }
            String jsonString = new Gson().toJson(uds);
            System.out.println("jsonString");
            System.out.println(jsonString);
            resp.getWriter().print(jsonString);

        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            sess.close();
        }

    }

}
