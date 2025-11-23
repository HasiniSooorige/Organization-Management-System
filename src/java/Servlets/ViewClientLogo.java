/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.ComPath;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
@WebServlet(name = "ViewClientLogo", urlPatterns = {"/ViewClientLogo"})
public class ViewClientLogo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("________________View  Client  Logo__________________");

        String imageName = request.getParameter("imageName");
        System.out.println(imageName);

        if (imageName != null) {
            String root = ComPath.getFILE_PATH();
            String imagePath = root + "/clientLogo/" + imageName;

            response.setContentType("image/jpeg");
            response.setContentType("image/png");
            response.setContentType("image/jpg");

            // Open the image file and copy its contents to the response output stream
            try (InputStream inputStream = new FileInputStream(imagePath);
                    OutputStream outputStream = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                // Handle errors (e.g., image not found)
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } else {
            // Image name parameter missing
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

}
