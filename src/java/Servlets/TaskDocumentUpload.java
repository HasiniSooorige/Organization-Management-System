/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.ComPath;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.GeneralOrganizationProfile;
import Model.Mapping.ProjectGopAgreement;
import Model.Mapping.ProjectTaskAttachments;
import Model.Mapping.ProjectTasks;
import Model.Mapping.Projects;
import static Servlets.ClientDocumentUpload.convertStringToDate;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "TaskDocumentUpload", urlPatterns = {"/TaskDocumentUpload"})
public class TaskDocumentUpload extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("______Task  Document  Upload_______");

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int stat = 200;
        String message = "";
        String taskId = "";

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (isMultipart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            try {

                List items = upload.parseRequest(request);
                Iterator iterator = items.iterator();
                while (iterator.hasNext()) {
                    FileItem item = (FileItem) iterator.next();

                    if (item.isFormField()) {
                        String itemName = item.getFieldName();
                        if (itemName.equals("rowId")) {
                            taskId = item.getString();
                            System.out.println("Task Id String Type : " + taskId);
                        }
                    }

                    if (!item.isFormField()) {

                        String fileName = item.getName();
                        String doc_id = item.getFieldName();

                        System.out.println(doc_id);

                        String root = ComPath.getFILE_PATH();
                        File path = new File(root + "/TaskDocument");
                        if (!path.exists()) {
                            boolean status = path.mkdirs();
                        }
                        File uploadedFile = new File(path + "/" + fileName);

                        System.out.println(uploadedFile.getAbsolutePath());

                        System.out.println("list___");

                        if (fileName != "") {
                            item.write(uploadedFile);

                            ProjectTaskAttachments pta = new ProjectTaskAttachments();

                            pta.setUrl(fileName);
                            pta.setProjectTasks((ProjectTasks) sess.load(ProjectTasks.class, Integer.parseInt(taskId)));

                            sess.save(pta);

                            t.commit();

                            stat = 200;
                            message = "Task Documents Successfully Uploaded !";

                            objSend.put("status", stat);
                            objSend.put("TaskSuccess", message);
                            System.out.println(objSend);
                            response.sendRedirect("projects/task-list.jsp?TaskSuccess=" + "success");
                        } else {
                            stat = 400;
                            message = "No file selected for upload. Please choose a file to upload before proceeding !";

                            objSend.put("status", stat);
                            objSend.put("DocUploadError", message);
                            response.sendRedirect("projects/task-list.jsp?DocUploadError=" + "error");
                        }

                    } else {
                    }

                }

                sess.close();

            } catch (FileUploadException e) {
                stat = 400;
                message = "Fill All Fields !";

                objSend.put("status", stat);
                objSend.put("TaskError", message);
                response.sendRedirect("projects/task-list.jsp?TaskError=" + "error");
                out.println(e);
            } catch (Exception e) {
                out.println(e);
            }
        } else {
            out.println("Not Multipart");
        }

    }

}
