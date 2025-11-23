/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Mapping.Country;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.UserCredentialType;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.json.simple.JSONArray;

/**
 *
 * @author Jalana
 */

@WebServlet(name = "ReadCredetialTypes", urlPatterns = {"/ReadCredetialTypes"})

public class ReadCredetialTypes extends HttpServlet {

 
     @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
   JSONArray js = new JSONArray();
        Map m = new HashMap();
        try {
            
            Session s=NewHibernateUtil.getSessionFactory().openSession();
            Criteria c=s.createCriteria(UserCredentialType.class);
            List<UserCredentialType>cat_list=c.list();
            List<String> list = new ArrayList<String>();
//            String option_tags="";
            for(UserCredentialType type:cat_list){
//            option_tags+="<option>"+country.getName()+"</option>";
//            
//            System.out.println("coutry_123");
//                System.out.println(country.getName());
                list.add(type.getName());


            }
            resp.getWriter().write(js.toJSONString(list));
//            resp.getWriter().write(option_tags);
        } catch (Exception e) {
        e.printStackTrace();
        }
        
    }

}
