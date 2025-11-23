/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.Com;
import Model.CommonMethod.Commons;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.ProjectEmployeeRole;
import Model.Mapping.ProjectEmployees;
import Model.Mapping.Projects;
import Model.Mapping.Status;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.lang.reflect.Type;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "ProjectTeamUpdate", urlPatterns = {"/ProjectTeamUpdate"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
        maxFileSize = 1024 * 1024 * 1000, // 1 GB
        maxRequestSize = 1024 * 1024 * 1000)   	// 1 GB)
public class ProjectTeamUpdate extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("_____________Project Team Update_______________");

        Commons commonsInstance = new Commons();
        String admin_email = commonsInstance.ADMIN_EMAIL;
        String admin_password = commonsInstance.ADMIN_PASSWORD;

        String today = Com.getDate(new Date());

        response.setContentType("text/html");
        Session sess = NewHibernateUtil.getSessionFactory().openSession();

        JSONObject objSend = new JSONObject();

        int status = 200;
        String message = "";
        boolean success = false;
        String json_authors = "";
        int[] empIdInt = null;
        int[] empRoleIdInt = null;
        Status caa = null;

        try {

            String rowIdProTeam = request.getParameter("rowIdProTeam");
            int rowIdInt = Integer.parseInt(rowIdProTeam);
            System.out.println(rowIdProTeam);

            String[] empId = request.getParameterValues("valueEmpEdit[]");
            String[] empName = request.getParameterValues("textEmpEdit[]");
            String[] empRoleId = request.getParameterValues("valueRoleEdit[]");
            String[] empRole = request.getParameterValues("textRoleEdit[]");

            if (empId != null) {
                empIdInt = new int[empId.length];
                for (int i = 0; i < empId.length; i++) {
                    empIdInt[i] = Integer.parseInt(empId[i]);
                    System.out.println("Emp Id Int --" + empIdInt[i]);
                }

                empRoleIdInt = new int[empId.length];
                for (int i = 0; i < empRoleId.length; i++) {
                    empRoleIdInt[i] = Integer.parseInt(empRoleId[i]);
                    System.out.println("Emp Role Id Int --" + empRoleIdInt[i]);
                }

                JSONArray jsonArray = new JSONArray();

                for (int i = 0; i < empId.length; i++) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("valueEmp", empIdInt[i]);
                    jsonObject.put("textEmp", empName[i]);
                    jsonObject.put("valueRole", empRoleIdInt[i]);
                    jsonObject.put("textRole", empRole[i]);

                    jsonArray.add(jsonObject);

                }
                json_authors = jsonArray.toString();
            }

            if (!"".equals(json_authors)) {
                Gson gson = new Gson();
                Type listType = new TypeToken<ArrayList<ProjectEmployees>>() {
                }.getType();

                List<ProjectEmployees> userArray = gson.fromJson(json_authors, listType);

                int i = 0;

                for (ProjectEmployees ram : userArray) {

                    Transaction t = sess.beginTransaction();

                    Criteria c4 = sess.createCriteria(Employee.class);
                    c4.add(Restrictions.eq("id", empIdInt[i]));
                    Employee em = (Employee) c4.uniqueResult();

                    Criteria c8 = sess.createCriteria(ProjectEmployeeRole.class);
                    c8.add(Restrictions.eq("id", empRoleIdInt[i]));
                    ProjectEmployeeRole proRole = (ProjectEmployeeRole) c8.uniqueResult();

                    Criteria c1 = sess.createCriteria(Projects.class);
                    c1.add(Restrictions.eq("id", rowIdInt));
                    Projects proName = (Projects) c1.uniqueResult();

                    ProjectEmployees pm = (ProjectEmployees) sess.createQuery("From ProjectEmployees Where projects_id='" + rowIdInt + "'  and employee_id = '" + empIdInt[i] + "' and project_employee_role_id = '" + empRoleIdInt[i] + "' ").setMaxResults(1).uniqueResult();

                    String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(Calendar.getInstance().getTime());

                    if (pm == null) {

                        pm = new ProjectEmployees();

                        pm.setAssignedDate(convertStringToDate(timeStamp));
                        pm.setProjects((Projects) sess.load(Projects.class, rowIdInt));
                        pm.setEmployee(em);
                        pm.setProjectEmployeeRole(proRole);
                        pm.setIsActive(true);
                        sess.save(pm);

                        //                            email START
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
                            message_1.setRecipients(Message.RecipientType.TO, InternetAddress.parse(em.getGeneralUserProfile().getEmail()));
                            MimeBodyPart textPart = new MimeBodyPart();
                            Multipart multipart = new MimeMultipart();
                            String link = "<a href=\"http://system.exon.lk\" style=\"color:#6666CC;\" target=\"_blank\"> <strong><em>Exon Management System</em></strong></a>";

                            String final_Text = "<div style=\"text-align:justify; \">\n"
                                    + "        Dear " + em.getGeneralUserProfile().getFirstName() + " " + em.getGeneralUserProfile().getLastName() + ",<br>"
                                    + "<p>This email is to inform you that you have been assigned to the " + proName.getName() + " project, effective " + today + ". Your role in this project will be " + proRole.getName() + ".</p>\n"
                                    + "<p>Please acknowledge receipt of this assignment at your earliest convenience.</p>\n"
                                    + "<p>Best Regards,</p>\n"
                                    + "<p>Exon Software Solutions (Pvt) Ltd</p>\n"
                                    + "</div>\n"
                                    + "";
                            textPart.setText(final_Text);
                            multipart.addBodyPart(textPart);
                            message_1.setContent(final_Text, "text/html");
                            message_1.setSubject("Project Assignment");
                            Transport.send(message_1);
                            System.out.println("Create Project Email Sending - " + em.getGeneralUserProfile().getFirstName());
                        } catch (Exception e) {
                            message = "Somthing went wrong!";
                        }
//emal END

                        t.commit();
                        sess.clear();
                        i = i + 1;

                        status = 200;
                        message = "Project Team Successfully Updated !";

                        objSend.put("status", status);
                        objSend.put("projectTeamSuccess", message);
                    } else {

                        System.out.println("pm not null");

                        status = 400;
                        message = "Project Employee Already Exists !";

                        objSend.put("status", status);
                        objSend.put("projectTeamAlreadyError", message);
                    }

                }
            }

        } catch (Exception e) {

            System.out.println("catch read");
            status = 500;
            message = "Project Team not Updated !";

            objSend.put("status", status);
            objSend.put("projectTeamError", message);

            e.printStackTrace();
        } finally {
            sess.close();
        }

        if (status == 200) {
            response.sendRedirect("projects/project-list.jsp?projectTeamSuccess=" + "success");
        } else if (status == 400) {
            response.sendRedirect("projects/project-list.jsp?projectTeamAlreadyError=" + "error");
        } else if (status == 500) {
            response.sendRedirect("projects/project-list.jsp?projectTeamError=" + "error");
        }

    }

    public static Date convertStringToDate(String date) {
        if (!"".equals(date)) {
            try {
                return FORMATTER.parse(date);
            } catch (ParseException e) {
                // nothing we can do if the input is invalid
                throw new RuntimeException(e);
            }
        }
        return null;
    }

}
