/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Designation;
import Model.Mapping.DocumentType;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;

/**
 *
 * @author kbnc
 */
public class ReadDocType extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        
      try {
            
            Session s=NewHibernateUtil.getSessionFactory().openSession();
            Criteria c=s.createCriteria(DocumentType.class);
            List<DocumentType>cat_list=c.list();
            String option_tags="";
            for(DocumentType doc_type:cat_list){
            option_tags+="<option>"+doc_type.getName()+"</option>";
            
            System.out.println("doc_type_ll");
                System.out.println(doc_type.getName());
            }
            resp.getWriter().write(option_tags);
        } catch (Exception e) {
        e.printStackTrace();
        }
    }

   
}
