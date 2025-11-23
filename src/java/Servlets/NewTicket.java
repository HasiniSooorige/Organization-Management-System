package Servlets;

import Model.CommonMethod.ComPath;
import Model.CommonMethod.Commons;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.GeneralUserProfile;
import Model.Mapping.HelpTicket;
import Model.Mapping.HelpTicketAttachments;
import Model.Mapping.HelpTicketCategory;
import Model.Mapping.HelpTicketStatus;
import Model.Mapping.HelpTicketSubmitType;
import Model.Mapping.Projects;
import Model.Mapping.UserLogin;
import filteration.Filteration;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import org.json.simple.JSONObject;

@WebServlet(name = "NewTicket", urlPatterns = {"/NewTicket"})
@MultipartConfig
public class NewTicket extends HttpServlet {

    String file_path = ComPath.getFILE_PATH() + "/HelpTickets/";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Commons commonsInstance = new Commons();
        String admin_email = commonsInstance.ADMIN_EMAIL;
        String admin_password = commonsInstance.ADMIN_PASSWORD;

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        StringBuilder sb = new StringBuilder();
        String save_as = "";
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";

        String newId;
        String requesterName;

        try {

            for (Part part : request.getParts()) {
                String submittedFileName = part.getSubmittedFileName();
                System.out.println("submittedFileName -" + submittedFileName);
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    save_as = System.currentTimeMillis() + "-" + Filteration.getFilteredFilename(submittedFileName);
                    String savePath = file_path + save_as;
                    Files.copy(part.getInputStream(), Paths.get(savePath));
                    sb.append(savePath).append(";");
                }
            }

            String ticketCategory = request.getParameter("ticketCategory");
            String project = request.getParameter("project");
            String requestor = request.getParameter("requestor");
            String description = request.getParameter("description");
            String UserLoginUser = request.getParameter("loginid");
            String loginid = request.getSession().getAttribute("User_ID").toString();

            UserLogin userLogin = (UserLogin) sess.createQuery("FROM UserLogin WHERE id = " + loginid).uniqueResult();

            List<HelpTicket> list = sess.createQuery("From HelpTicket").list();

            if (!list.isEmpty()) {
                String tid = sess.createQuery("SELECT ticketId FROM HelpTicket ORDER BY id DESC").setMaxResults(1).list().stream().findFirst().orElse(null).toString();
                newId = generateTicketID(tid);
            } else {
                newId = generateNewTicketID();
            }

            HelpTicket ht = new HelpTicket();

            ht.setTicketId(newId);
            ht.setEnteredDate(new Date());
            ht.setDescription(description);
            ht.setHelpTicketCategory((HelpTicketCategory) sess.load(HelpTicketCategory.class, Integer.parseInt(ticketCategory)));
            ht.setHelpTicketStatus(new HelpTicketStatus(1));
            ht.setHelpTicketSubmitType((HelpTicketSubmitType) sess.load(HelpTicketSubmitType.class, 1));
            if ((requestor == null) || ("undefined".equals(requestor))) {
                ht.setRequestedBy((GeneralUserProfile) sess.load(GeneralUserProfile.class, userLogin.getGeneralUserProfile().getId()));
            } else {
                ht.setRequestedBy((GeneralUserProfile) sess.load(GeneralUserProfile.class, Integer.parseInt(requestor)));
            }
            ht.setSubmitRefference((UserLogin) sess.load(UserLogin.class, Integer.parseInt(UserLoginUser)));
            if (project == null || project.trim().isEmpty()) {
                System.out.println("Project Null");
            } else {
                ht.setProjects((Projects) sess.load(Projects.class, Integer.parseInt(project)));
            }

            sess.save(ht);

            if (save_as == null || save_as.trim().isEmpty()) {
                System.out.println("Document null");
            } else {

                HelpTicketAttachments ha = new HelpTicketAttachments();
                ha.setHelpTicket(ht);
                ha.setUrl(save_as);

                sess.save(ha);
            }

            t.commit();

            //                            email START
            UserLogin admin = (UserLogin) sess.createQuery("From UserLogin Where user_role_id='" + 1 + "'").setMaxResults(1).uniqueResult();
            String adminEmail = admin.getGeneralUserProfile().getEmail();

            HelpTicketCategory htc = (HelpTicketCategory) sess.createQuery("From HelpTicketCategory Where id='" + Integer.parseInt(ticketCategory) + "'").setMaxResults(1).uniqueResult();

            if ((requestor == null) || ("undefined".equals(requestor))) {
                GeneralUserProfile gup = (GeneralUserProfile) sess.createQuery("From GeneralUserProfile Where id='" + userLogin.getGeneralUserProfile().getId() + "'").setMaxResults(1).uniqueResult();
                requesterName = gup.getFirstName() + " " + gup.getLastName();
            } else {
                GeneralUserProfile gup = (GeneralUserProfile) sess.createQuery("From GeneralUserProfile Where id='" + Integer.parseInt(requestor) + "'").setMaxResults(1).uniqueResult();
                requesterName = gup.getFirstName() + " " + gup.getLastName();
            }

            Properties props = new Properties();
            props.put("mail.smtp.auth", true);
            props.put("mail.smtp.starttls.enable", true);
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            javax.mail.Session session = javax.mail.Session.getInstance(props,
                    new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(admin_email, admin_password);
                }
            });
            try {
                Message message_1 = new MimeMessage(session);
                message_1.setFrom(new InternetAddress("Exon"));
                message_1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(adminEmail));
                MimeBodyPart textPart = new MimeBodyPart();
                Multipart multipart = new MimeMultipart();

                String helpTicketDashboard = "<a href=\"http://system.exon.lk/help-ticket/admin-ticket-dashboard.jsp\" style=\"color:#000000;\" target=\"_blank\"> <strong><em>Help Desk System</em></strong></a>";

                String final_Text = "<div style=\"text-align:justify; \">\n"
                        + "        Dear Admin ,<br>"
                        + "<p>A new help ticket has been submitted and is awaiting your attention. Here are the details:</p>\n"
                        + "Ticket ID&nbsp;:&nbsp;&nbsp;" + newId + "<br>\n"
                        + "Category&nbsp;&nbsp;:&nbsp;&nbsp;" + htc.getName() + "<br>\n"
                        + "Requestor&nbsp;:&nbsp;&nbsp;" + requesterName + "<br>\n"
                        + "<p>Please log in to our help desk system at " + helpTicketDashboard + " to review and address this ticket promptly.</p>\n"
                        + "<p>Best Regards,</p>\n"
                        + "<p>Exon Software Solutions (Pvt) Ltd</p>\n"
                        + "</div>\n"
                        + "";

                textPart.setText(final_Text);
                multipart.addBodyPart(textPart);
                message_1.setContent(final_Text, "text/html");

                message_1.setSubject("New Help Ticket Received - Ticket ID " + newId);
                Transport.send(message_1);
                System.out.println("emailsending");
            } catch (Exception e) {
                message = "Somthing went wrong!";
            }
//emal END

            out.print("200");

            sess.flush();
            sess.clear();

        } catch (Exception e) {

            out.print("400");

            e.printStackTrace();
        } finally {
            sess.close();
        }

    }

    public static String generateTicketID(String lastTicketId) {
        int ticketCounter = extractLast4Digits(lastTicketId) + 1;
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        DecimalFormat ticketNumberFormat = new DecimalFormat("0000");
        String formattedTicketNumber = ticketNumberFormat.format(ticketCounter);
        return String.format("T%d%02d%s", year, month, formattedTicketNumber);
    }

    public static String generateNewTicketID() {
        int ticketCounter = 1;
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        DecimalFormat ticketNumberFormat = new DecimalFormat("0000");
        String formattedTicketNumber = ticketNumberFormat.format(ticketCounter);
        return String.format("T%d%02d%s", year, month, formattedTicketNumber);
    }

    public static int extractLast4Digits(String input) {
        if (input.length() < 4) {
            throw new IllegalArgumentException("Input string is too short");
        }
        String last4Characters = input.substring(input.length() - 4);
        try {
            return Integer.parseInt(last4Characters);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Last 4 characters are not a valid integer", e);
        }
    }
}
