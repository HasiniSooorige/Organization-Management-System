/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Sudeera Perera
 */
@WebServlet(name = "NewTicketReply", urlPatterns = {"/NewTicketReply"})
public class NewTicketReply extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); //To change body of generated methods, choose Tools | Templates.
        
        String ticketId = req.getParameter("ticketId");
            String replyMessage = req.getParameter("replyMessage");
            String rating = req.getParameter("rating");

            System.out.println("Ticket ID: " + ticketId);
            System.out.println("Reply Message: " + replyMessage);
            System.out.println("Rating: " + rating);
//            
//            out.print(ticketId);
//            out.print(replyMessage);
//            out.print(rating);
        
    }

    

}
