/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model.CommonMethod;

import java.util.HashMap;
import java.util.Map;
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
 * @author Sudeera Perera
 */
public class Mail {

    //templates
    //RESPONSE_ALERT
    //TICKET_ALERT
    //REPLY_ALERT
    
    public static void Send(String email, String template, Map<String, String> hashMap) {
        final String username = "umesha@exon.lk";//your email id
//        final String username = "rushtech69@gmail.com";//your email id
        final String password = "tlaigjvdtyhgvdrk";// your password
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
            System.out.println("Email sending started");
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("Exon"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            MimeBodyPart textPart = new MimeBodyPart();
            Multipart multipart = new MimeMultipart();
            String final_Text = null;
            String email_subject = null;
            switch (template) {
                case "TICKET_ALERT":
                    {
                        final_Text = "<b><h3>New Help Ticket</b></h3>" + "<br>Submitted by: "+hashMap.get("submittedby")+ 
                                "<br>Category: " + hashMap.get("category")+
                                "<br>Message: " + hashMap.get("message")+
                                "<br><br>Visit the link to see more details: "+hashMap.get("link")+
                                "<br><br>Thank You.<br>Exon Team";
                        email_subject = "New Help Ticket";
                        break;
                    }
                case "RESPONSE_ALERT":
                    {
                        final_Text = "<h3><b>New Ticket Response</b></h3>" + 
                                "<br>Ticket id: "+hashMap.get("ticketid")+ 
                                "<br>Response: " + hashMap.get("response")+
                                "<br>Status: " + hashMap.get("status")+
                                "<br><br>Visit the link to see more details: "+hashMap.get("link")+
                                "<br><br>Thank You."
                                + "<br>Exon Team";
                        email_subject = "Ticket Response";
                        break;
                    }
                case "REPLY_ALERT":
                    {
                        final_Text = "<h3><b>New Ticket Reply</b></h3>" + 
                                "<br>Ticket id: "+hashMap.get("ticketid")+ 
                                "<br>Reply: " + hashMap.get("message")+
                                "<br><br>Visit the link to see more details: "+hashMap.get("link")+
                                "<br><br>Thank You."
                                + "<br>Exon Team";
                        email_subject = "Exon Reply Alert";
                        break;
                    }
                default:
                    break;
            }
            
            textPart.setText(final_Text);
            //  message.setSubject(psw);
            multipart.addBodyPart(textPart);
            // message.setContent(multipart,"text/html");
            message.setContent(final_Text, "text/html");

            message.setSubject(email_subject);
            //out.println("Sending");
            Transport.send(message);
            System.out.println("Email sent");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
