/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

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
    
    public static void Send(String email, String template) {
        final String username = "rushtech69@gmail.com";//your email id
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
                        final_Text = "<b><h3>Dear, TICKET_ALERT</b></h3>" + "<br>We are delighted to tell you that your Exon account has now been set up."
                                + "<br>To access your account, use your username and password as your credentials to log into Exon account." + "<br><br>Username: <br>   " + "Password: <br><br><br>Thank You.";
                        email_subject = "Exon Ticket Alert";
                        break;
                    }
                case "RESPONSE_ALERT":
                    {
                        final_Text = "<b><h3>Dear,RESPONSE ALERT</b></h3>" + "<br>We are delighted to tell you that your Exon account has now been set up."
                                + "<br>To access your account, use your username and password as your credentials to log into Exon account." + "<br><br>Username: <br>   " + "Password: <br><br><br>Thank You.";
                        email_subject = "Exon Response Alert";
                        break;
                    }
                case "REPLY_ALERT":
                    {
                        final_Text = "<b><h3>Dear, REPLT ALERT</b></h3>" + "<br>We are delighted to tell you that your Exon account has now been set up."
                                + "<br>To access your account, use your username and password as your credentials to log into Exon account." + "<br><br>Username: <br>   " + "Password: <br><br><br>Thank You.";
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
