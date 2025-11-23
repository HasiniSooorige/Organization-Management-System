package Servlets;

import Model.CommonMethod.ComPath;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "UploadClaimDoc", urlPatterns = {"/UploadClaimDoc"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50) // 50 MB

public class UploadClaimDoc extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        try {
            // Process file upload
            Part filePart = request.getPart("fileToUpload"); // Assuming your file input field has the name "fileToUpload"

            String root = ComPath.getFILE_PATH();

            if (filePart.getSubmittedFileName() != null) {
                String fileName = getFileName(filePart);
                File path1 = new File(root + "/Upload_Claim");
                if (!path1.exists()) {
                    boolean status = path1.mkdirs();
                   
                }
                String filePath = path1 + File.separator + fileName;
           
                
                // Save the uploaded file to the local directory
                try (InputStream fileContent = filePart.getInputStream()) {
                    Path filepath = Paths.get(filePath);
                    Files.copy(fileContent, filepath, StandardCopyOption.REPLACE_EXISTING);
                }

                // Store file information in the database
                // ...
                response.getWriter().write("File uploaded successfully: " + fileName);
            }
        } catch (Exception ex) {
            System.out.println("Error: " + ex);
            response.getWriter().write("File upload failed: " + ex.getMessage());
        }
    }

    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
