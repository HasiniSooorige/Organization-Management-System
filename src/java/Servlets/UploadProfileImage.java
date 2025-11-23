/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.ComPath;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.GeneralUserProfile;
import filteration.Filteration;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONObject;

/**
 *
 * @author HP
 */
@WebServlet(name = "UploadProfileImage", urlPatterns = {"/UploadProfileImage"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 10, // 10 MB
        maxFileSize = 1024 * 1024 * 1000, // 1 GB
        maxRequestSize = 1024 * 1024 * 1000)   	// 1 GB)
public class UploadProfileImage extends HttpServlet {

    String file_path = ComPath.getFILE_PATH() + "/ProfileImages/";
    private static final long serialVersionUID = 1L;
    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(Calendar.getInstance().getTime());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("________________Upload  Profile  Image ________________________");
        response.setContentType("text/html");
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONObject objSend = new JSONObject();
        int status = 200;
        String message = "";
        String save_as = "";
        try {
            String userId = request.getParameter("userId");
            Integer gupIdInt = Integer.parseInt(userId);

            Path filepath_photo;

            String uploadDirectory_photo = file_path;
            Part filePart_photo = request.getPart("uploadProfile");
            String fileName_photo = getFileName(filePart_photo);
            save_as = System.currentTimeMillis() + "-" + Filteration.getFilteredFilename(fileName_photo);
            System.out.println("--Image-- " + fileName_photo);
            if (!"".equals(fileName_photo)) {
                try (InputStream fileContent_photo = filePart_photo.getInputStream()) {
                    filepath_photo = Paths.get(uploadDirectory_photo, save_as);
                    Files.copy(fileContent_photo, filepath_photo, StandardCopyOption.REPLACE_EXISTING);
                }

                GeneralUserProfile gup = (GeneralUserProfile) sess.createQuery("From GeneralUserProfile Where id='" + gupIdInt + "'").setMaxResults(1).uniqueResult();

                if (gup != null) {

                    gup.setProfileImgUrl(save_as);

                    sess.update(gup);
                    t.commit();

                    status = 200;
                    message = "Profile Image Upload Successfully!";
                    System.out.println("Done");

                    objSend.put("status", status);
                    objSend.put("messageSuccess", message);
                    response.sendRedirect("main-pages/profile.jsp?messageSuccess=" + "success");

                } else {

                    status = 400;
                    message = "User Not Found!!!";
                    System.out.println("User Not Found!!!");

                    objSend.put("status", status);
                    objSend.put("userError", message);
                    response.sendRedirect("main-pages/profile.jsp?userError=" + "error");

                }
            } else {
                status = 400;
                message = "Image Null!!!";
                System.out.println("Image Null!!!");

                objSend.put("status", status);
                objSend.put("messageError", message);
                response.sendRedirect("main-pages/profile.jsp?messageError=" + "error");
            }
        } catch (Exception e) {

            System.out.println("catch read");
            status = 500;
            message = "Data Not Saved !";

            e.printStackTrace();
        } finally {
            sess.close();
        }

    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 2, token.length() - 1);
            }
        }
        return "";
    }
}
