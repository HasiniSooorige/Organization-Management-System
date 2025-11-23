/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;


import Model.Connection.NewHibernateUtil;
import Model.Mapping.UserCredentialIssuingManager;
import Model.Mapping.UserCredentials;
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
import org.hibernate.Transaction;

@WebServlet(name = "SendCredentialsEmail", urlPatterns = {"/SendCredentialsEmail"})
public class SendCredentialsEmail extends HttpServlet {

    String usernamex, psw, reason,editedby,credIssuid;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         org.hibernate.Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        org.hibernate.Session sess2 = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t2 = sess2.beginTransaction();
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
        credIssuid = request.getParameter("id");
        usernamex = request.getParameter("username");
        reason = request.getParameter("reason");
        psw = request.getParameter("password");
       editedby = request.getParameter("editby");
System.out.println("emailsending");
        final String username = "umesha@exon.lk";//your email id
//        final String username = "hasinirsoorige9845@gmail.com";//your email id
        final String password = "kikxkckoalclzwal";// your password
        Properties props = new Properties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        try {
            
              UserCredentialIssuingManager credissu = (UserCredentialIssuingManager) sess.createQuery("From UserCredentialIssuingManager Where id='" + credIssuid + "'").setMaxResults(1).uniqueResult();

            UserCredentials cred = (UserCredentials) sess.createQuery("From UserCredentials Where id='" + credissu.getUserCredentials().getId() + "'").setMaxResults(1).uniqueResult();

       
            
            
            Message message = new MimeMessage(session);
             Message messagesec = new MimeMessage(session);
            message.setFrom(new InternetAddress("Exon"));
            messagesec.setFrom(new InternetAddress("Exon"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("hasinirsoorige9845@gmail.com"));
                     messagesec.setRecipients(Message.RecipientType.TO, InternetAddress.parse("hasinirsoorige9845@gmail.com"));
            MimeBodyPart textPart = new MimeBodyPart();
           Multipart multipart = new MimeMultipart();
            String final_Text = "<b><h3>Admin Panel"+",</b></h3>"+"<br>The Username and Password related to the ID-"+credIssuid+" (Credential ID) have been updated by "+ editedby+
                    "<br><br>Reason- "+reason+"<br><br>So in future To access the project data, use updated username and password as your credentials."+"<br><br>Username: " + usernamex + " <br>   " +   "Password: " + psw+" <br> Credential ID: "+credissu.getUserCredentials().getId()  +" <br> Project Name: "+cred.getProjects().getName()+" <br> Credential Type: "+cred.getUserCredentialType().getName()+" <br> Credential Category: "+cred.getUserCredentialCategory().getName()+"<br><br><br>Thank You.";
          textPart.setText(final_Text);
          //  message.setSubject(psw);
            multipart.addBodyPart(textPart);
           // message.setContent(multipart,"text/html");
              message.setContent(final_Text,"text/html");
            messagesec.setContent(final_Text,"text/html");
            message.setSubject("Credentials Details - Exon");
            messagesec.setSubject("Credentials Details - Exon");
            //out.println("Sending");
            Transport.send(message);
             Transport.send(messagesec);
            System.out.println("emailsending");
      } catch (Exception e) {
            out.println(e);
        }
    }

}