/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.HelpTicket;
import Model.Mapping.HelpTicketAttachments;
import Model.Mapping.HelpTicketRespond;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;

/**
 *
 * @author Sudeera Perera
 */
@WebServlet(name = "ViewTicket", urlPatterns = {"/ViewTicket"})
public class ViewTicket extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp)
            throws ServletException, IOException {
        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        try {
            String ticketId = filteration.Filteration.getFilteredUsername(request.getParameter("ticketId"));

            HelpTicket ticket = (HelpTicket) sess.createQuery("FROM HelpTicket WHERE ticketId='" + ticketId + "'").uniqueResult();

            HelpTicketAttachments hta = (HelpTicketAttachments) sess.createQuery("FROM HelpTicketAttachments where helpTicket.id='" + ticket.getId() + "'").uniqueResult();
            String[] parts = hta.getUrl().split(";");
            System.out.println("Parts: " + parts);

            List<HelpTicketRespond> responds = sess.createQuery("FROM HelpTicketRespond WHERE helpTicket.id='" + ticket.getId() + "'").list();

            JsonArray helpTicketsJsonArray = new JsonArray();
            JsonArray helpTicketsJsonArray2 = new JsonArray();
            JsonObject helpTicketJson = new JsonObject();

            for (HelpTicketRespond respond : responds) {
                JsonObject helpTicketRespondJson = new JsonObject();

                if (respond.getHelpTicketRespondType().getId() == 1) {

                    helpTicketRespondJson.addProperty("respondid", respond.getId());
                    helpTicketRespondJson.addProperty("tid", respond.getHelpTicket().getId());
                    helpTicketRespondJson.addProperty("ticketId", respond.getHelpTicket().getTicketId());
                    helpTicketRespondJson.addProperty("responddate", respond.getRespondDate().toString());
                    helpTicketRespondJson.addProperty("respondcomment", respond.getComment());
                    helpTicketRespondJson.addProperty("respondrespondedby", respond.getRespondedGup().getFirstName() + " " + respond.getRespondedGup().getLastName());

                }

                if (respond.getHelpTicketRespondType().getId() == 2) {
                    for (JsonElement array : helpTicketsJsonArray2) {
                        JsonObject item = array.getAsJsonObject();
                        int respondid = item.get("tid").getAsInt();
                        if (respondid == respond.getHelpTicket().getId()) {
                            item.addProperty("replydate", respond.getRespondDate().toString());
                            item.addProperty("replycomment", respond.getComment());
                            item.addProperty("replyrating", respond.getRating());
                        }
                    }
                } else {
                    helpTicketRespondJson.addProperty("replydate", "");
                    helpTicketRespondJson.addProperty("replycomment", "");
                    helpTicketRespondJson.addProperty("replyrating", "");
                }

                helpTicketsJsonArray2.add(helpTicketRespondJson);
            }

            helpTicketJson.addProperty("id", ticket.getTicketId());
            helpTicketJson.addProperty("enteredDate", ticket.getEnteredDate().toString());
//            Comment Hasini
//            helpTicketJson.addProperty("requestBy", ticket.getRequestedBy());
            helpTicketJson.addProperty("category", ticket.getHelpTicketCategory().getName());
            helpTicketJson.addProperty("description", ticket.getDescription());
            helpTicketJson.addProperty("download", String.join(";", parts));

            helpTicketsJsonArray.add(helpTicketJson);

            JsonArray helpTicketsJsonArrayMain = new JsonArray();
            helpTicketsJsonArrayMain.add(helpTicketsJsonArray);
            helpTicketsJsonArrayMain.add(helpTicketsJsonArray2);

            String jsonResponse = helpTicketsJsonArrayMain.toString();
            System.out.println("Json: " + jsonResponse);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            sess.flush();
            sess.clear();
            sess.close();
        }
    }
}
