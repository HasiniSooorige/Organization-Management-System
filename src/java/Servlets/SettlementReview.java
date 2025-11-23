/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.PettyCashApprovalLevel;
import Model.Mapping.PettyCashTransactionHistory;
import Model.Mapping.PettyCashTransactionHistoryDocument;
import Model.Mapping.PettyCashWallet;
import Model.Mapping.UserLogin;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.json.JSONObject;

/**
 *
 * @author Ashan Kavindu
 */
@WebServlet(name = "SettlementReview", urlPatterns = {"/SettlementReview"})
public class SettlementReview extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        try {
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = req.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String jsonData = sb.toString();
            JSONObject jsonObject = new JSONObject(jsonData);
            int id = jsonObject.getInt("id");
            Integer action = jsonObject.getInt("action");
//            System.out.println(action);
            JSONObject responseJson = new JSONObject();
            Session session = NewHibernateUtil.getSessionFactory().openSession();
            Transaction tr = session.beginTransaction();
            PettyCashApprovalLevel level = (PettyCashApprovalLevel) session.createQuery("from PettyCashApprovalLevel where id='" + action + "'").uniqueResult();
            if (action == 2) {
                PettyCashTransactionHistory pcth = (PettyCashTransactionHistory) session.createQuery("from PettyCashTransactionHistory where id='" + id + "'").uniqueResult();
                pcth.setPettyCashApprovalLevel(level);
                UserLogin login = (UserLogin) req.getSession().getAttribute("user");
                pcth.setEmployee((Employee) session.createQuery("from Employee where id='" + login.getId() + "'").uniqueResult());
                session.update(pcth);

                PettyCashWallet EmployeeWallet = (PettyCashWallet) session.createQuery("from PettyCashWallet u where id='" + pcth.getPettyCashWallet().getId() + "'").uniqueResult();
                EmployeeWallet.setAmount(EmployeeWallet.getAmount() - pcth.getAmount());
                session.update(EmployeeWallet);
                PettyCashWallet balanceRec = (PettyCashWallet) session.createQuery("from PettyCashWallet u where employee_id='" + login.getId() + "'").uniqueResult();
                balanceRec.setAmount(balanceRec.getAmount() + pcth.getAmount());
                session.update(balanceRec);
                responseJson.put("status", "Approved");
            } else if (action == 3) {
                if (!jsonObject.getString("comment").isEmpty()) {
                    PettyCashTransactionHistory pcth = (PettyCashTransactionHistory) session.createQuery("from PettyCashTransactionHistory where id='" + id + "'").uniqueResult();
                    pcth.setPettyCashApprovalLevel(level);
                    pcth.setComment(jsonObject.getString("comment"));
                    session.update(pcth);
                    responseJson.put("status", "Rejected");
                } else {
                    responseJson.put("status", "Please add a Comment");
                }

            } else {
                responseJson.put("status", "error");
            }
            tr.commit();
            session.close();
            resp.getWriter().write(responseJson.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
