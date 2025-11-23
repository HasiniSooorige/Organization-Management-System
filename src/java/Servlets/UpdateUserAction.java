/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.GeneralUserProfile;
import Model.Mapping.UserLogin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONObject;

/**
 *
 * @author kbnc
 */
public class UpdateUserAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";
        Boolean uaction_check;

        String valuechecked = req.getParameter("valuechecked");
        String nic = req.getParameter("nic");
        System.out.println(valuechecked);
        System.out.println(nic);

        if (valuechecked.equals("true")) {
            uaction_check = false;
        } else {
            uaction_check = true;
        }

        UserLogin ulg = null;
        GeneralUserProfile uaction = (GeneralUserProfile) sess.createQuery("From GeneralUserProfile Where nic='" + nic + "'").setMaxResults(1).uniqueResult();

        Criteria criteria = sess.createCriteria(UserLogin.class);
        criteria.add(Restrictions.eq("generalUserProfile", uaction));
//            criteria.add(Restrictions.eq("username", uaction.getEmail()));

        ulg = (UserLogin) criteria.uniqueResult();

        if (ulg != null) {

            System.out.println("email");
            System.out.println(ulg.getUsername());
            ulg.setIsActive(uaction_check);
            sess.update("isActive", ulg);
            t.commit();
            status = 200;
            message = "Account Activated";

            System.out.println("isActive_active");

            objSend.put("status", status);
            objSend.put("message", message);
            resp.getWriter().print(objSend);

        } else {

        }

    }

}
