/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.ClaimItems;
import Model.RequestClaimM;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.simple.JSONArray;

/**
 *
 * @author Suren Fernando
 */
@WebServlet(name = "viewRequestClaim", urlPatterns = {"/viewRequestClaim"})
public class viewRequestClaim extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("claimid");
      
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        Transaction t = sess.beginTransaction();
        JSONArray jSONArray = new JSONArray();

        try {

            List<RequestClaimM> gms = new ArrayList<>();

            List<ClaimItems> list = sess.createQuery("From ClaimItems Where claims_id='" + id + "'").list();

            String content = "";

            if (!list.isEmpty()) {

              

                for (ClaimItems per : list) {

                    RequestClaimM gm = new RequestClaimM();

                    gm.setId(per.getId());
                    gm.setClaimId(per.getClaims().getId());
                    gm.setDate(per.getBilldDate());
                    gm.setAmount(per.getAmount());
                    gm.setFileUrl(per.getAttachment()); 
                   
                    gms.add(gm);

                }

                String jsonString = new Gson().toJson(gms);
                response.getWriter().print(jsonString);
                
             
                
                
                
            } else {
                System.out.println("list Error");
            }

        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            sess.close();
        }

    }
}
