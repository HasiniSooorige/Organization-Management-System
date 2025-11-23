/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Com.Tools.Security;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SendEmail", urlPatterns = {"/SendEmail"})
public class SendEmail extends HttpServlet {

    String name, psw, email, empname;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        org.hibernate.Session sess = NewHibernateUtil.getSessionFactory().openSession();
        response.setContentType("text/html");
        name = request.getParameter("username");
        email = request.getParameter("email");
        psw = request.getParameter("password");
        empname = request.getParameter("name");
        System.out.println("emailsending");
        System.out.println("psw");

        final String username = "umesha@exon.lk";//your email id
//        final String username = "hasinirsoorige9845@gmail.com";//your email id
        final String password = "kikxkckoalclzwal";// your password
        Properties props = new Properties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        UserLogin ul = (UserLogin) sess.createQuery("UserLogin from where username='" + name + "'").setMaxResults(1).uniqueResult();

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("Exon"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            MimeBodyPart textPart = new MimeBodyPart();
            Multipart multipart = new MimeMultipart();
            String final_Text = "<b><h3>Dear " + empname + ",</b></h3>" + "<br>We are delighted to tell you that your Exon account has now been set up."
                    + "<br>To access your account, use your username and password as your credentials to log into Exon account." + "<br><br>Username: " + name + " <br>   " + "Password: " + Security.decrypt(ul.getPassword()) + "<br><br><br>Thank You.";
            textPart.setText(final_Text);
            //  message.setSubject(psw);
            multipart.addBodyPart(textPart);
            // message.setContent(multipart,"text/html");
            message.setContent(final_Text, "text/html");

            message.setSubject("Your Exon Account Login Details");
            //out.println("Sending");
            Transport.send(message);
            System.out.println("emailsending");
        } catch (Exception e) {
            out.println(e);
        }
    }

}
