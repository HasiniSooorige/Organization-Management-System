/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.ComPath;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Suren Fernando
 */
@WebServlet(name = "ViewImage", urlPatterns = {"/ViewImage"})
public class ViewImage extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       

        String name = request.getParameter("name");

        String root = ComPath.getFILE_PATH();
        String imageFilePath = root + "/Upload_Claim/" + name; // Update the directory path

        File imageFile = new File(imageFilePath);

        if (imageFile.exists()) {

            // Determine the content type based on the image file extension
            String contentType = getContentType(name);
            response.setContentType(contentType);

            // Set the response headers (optional)
            response.setHeader("Content-Disposition", "inline; filename=" + imageFile.getName());

            try (FileInputStream in = new FileInputStream(imageFile);
                    OutputStream out = response.getOutputStream()) {
                // Write the image data to the response
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        } else {
            response.getWriter().println("Image not found");
        }
    }

    // Helper method to determine content type based on file extension
    private String getContentType(String fileName) {
        if (fileName.endsWith(".jpeg") || fileName.endsWith(".jpg")) {
            return "image/jpeg";
        } else if (fileName.endsWith(".png")) {
            return "image/png";
        } else if (fileName.endsWith(".gif")) {
            return "image/gif";
        } else {
            return "application/octet-stream";
        }
    }
}
