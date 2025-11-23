/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.GeneralUserProfile;
import java.io.IOException;
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
 * @author HP
 */
@WebServlet(name = "UpdateProfileData", urlPatterns = {"/UpdateProfileData"})
public class UpdateProfileData extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("_____Edit Task Details_____");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";

        try {
            String gupid = request.getParameter("gupid");
            Integer gupIdInt = Integer.parseInt(gupid);
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String adddress1 = request.getParameter("adddress1");
            String adddress2 = request.getParameter("adddress2");
            String adddress3 = request.getParameter("adddress3");
            String email = request.getParameter("email");
            String mobileno = request.getParameter("mobileno");
            String telephoneno = request.getParameter("telephoneno");

            System.out.println(gupid + " - " + firstName + " - " + lastName + " - " + adddress1 + " - " + adddress2 + " - " + adddress3 + " - " + email + " - " + mobileno + " - " + telephoneno);

            GeneralUserProfile gup = (GeneralUserProfile) sess.createQuery("From GeneralUserProfile Where id='" + gupIdInt + "'").setMaxResults(1).uniqueResult();

            if (gup != null) {

                gup.setFirstName(firstName);
                gup.setLastName(lastName);
                gup.setAddress1(adddress1);
                gup.setAddress2(adddress2);
                gup.setAddress3(adddress3);
                gup.setMobileNo(mobileno);
                gup.setHomeNo(telephoneno);
                gup.setEmail(email);

                sess.update(gup);
                t.commit();

                status = 200;
                message = "Profile Data Update Successfully!";
                System.out.println("Done");

            } else {

                status = 400;
                message = "User Not Found!!!";
                System.out.println("User Not Found!!!");

            }

            sess.flush();
            sess.clear();

        } catch (Exception e) {
            status = 500;
            message = "Error Occurred";
            e.printStackTrace();
        } finally {
            sess.close();
        }
        objSend.put("status", status);
        objSend.put("message", message);
        response.getWriter().print(objSend);
        System.out.println(objSend);
    }
}
