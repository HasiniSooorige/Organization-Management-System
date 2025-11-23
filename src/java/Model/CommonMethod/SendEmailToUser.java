/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.CommonMethod;

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

/**
 *
 * @author Personal
 */
public class SendEmailToUser {

    public boolean sendEmail(String to, String subject, String body) {
        boolean b = false;
        try {
            final String username = "umesha@exon.lk";//your email id
//            final String username = "hasinirsoorige9845@gmail.com";//your email id
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
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("Exon"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            MimeBodyPart textPart = new MimeBodyPart();
            Multipart multipart = new MimeMultipart();

            multipart.addBodyPart(textPart);
            // message.setContent(multipart,"text/html");
            message.setContent(body, "text/html");

            message.setSubject(subject);
            //out.println("Sending");
            Transport.send(message);
            b = true;
            System.out.println("emailsending");
        } catch (Exception e) {
            b = false;
            e.printStackTrace();
        }
        return b;
    }
}
