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
 * @author HP
 */
@WebServlet(name = "ViewPdfDocument", urlPatterns = {"/ViewPdfDocument"})
public class ViewPdfDocument extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("_________________View  Pdf  Document______________________________");
        
        String name = request.getParameter("name");
        System.out.println(name);
        
        String root = ComPath.getFILE_PATH();
        String pdfFilePath = root + "/ClientAgreements/" + name;
        System.out.println(pdfFilePath);
        
        File pdfFile = new File(pdfFilePath);
        
        if (pdfFile.exists()) {
            // Set the content type and headers
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=" + pdfFile.getName());

            try (FileInputStream in = new FileInputStream(pdfFile);
                 OutputStream out = response.getOutputStream()) {
                // Write the PDF data to the response
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
        } else {
            response.getWriter().println("PDF not found");
        }
        
    }


}
