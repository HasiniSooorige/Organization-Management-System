package Servlets;

import Model.CommonMethod.ComPath;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.json.JSONObject;

@WebServlet(name = "PettyCashImgUploader", urlPatterns = {"/PettyCashImgUploader"})
@MultipartConfig // Add this annotation to enable handling multipart requests
public class PettyCashImgUploader extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String filename = filePart.getSubmittedFileName();
        System.out.println("Selected file name:" + filename);
        String uploadPath = ComPath.getFILE_PATH() + "pettyCashWalletimgs/" + filename;
        System.out.println(uploadPath);

        try (FileOutputStream fos = new FileOutputStream(uploadPath);
                InputStream is = filePart.getInputStream()) {

            byte[] data = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(data)) != -1) {
                fos.write(data, 0, bytesRead);
            }

            JSONObject responseJson = new JSONObject();
            responseJson.put("status", "done");
            response.getWriter().write(responseJson.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject errorJson = new JSONObject();
            errorJson.put("status", "error");
            errorJson.put("message", "File upload failed");
            response.getWriter().write(errorJson.toString());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
