/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.ComPath;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.Employee;
import Model.Mapping.PettyCashApprovalLevel;
import Model.Mapping.PettyCashTransactionHistory;
import Model.Mapping.PettyCashTransactionHistoryDocument;
import Model.Mapping.PettyCashWallet;
import Model.Mapping.TransactionType;
import Model.Mapping.UserLogin;
import java.io.BufferedReader;
import java.io.File;
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
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Ashan Kavindu
 */
@WebServlet(name = "SendtoReview", urlPatterns = {"/SendtoReview"})
public class SendtoReview extends HttpServlet {

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
            String Description = jsonObject.getString("description");
            String settlmentID = jsonObject.getString("settlmentID");
            System.out.println("des "+Description);
            JSONArray jsonArray = jsonObject.getJSONArray("data");
            JSONObject responseJson = new JSONObject();
            if (Description.isEmpty()) {
                responseJson.put("status", "Please enter a Description");
            } else if (jsonArray.length() <= 0) {
                responseJson.put("status", "Please Add Records");
            } else {
                Session session = NewHibernateUtil.getSessionFactory().openSession();
                Transaction tr = session.beginTransaction();
                UserLogin user = (UserLogin) req.getSession().getAttribute("user");

                double totAmount = 0.0;
                for (int i = 0; i < jsonArray.length(); i++) {
                    totAmount += Double.parseDouble(jsonArray.getJSONObject(i).getString("amount"));
                }
                PettyCashWallet pettyCashWallet = (PettyCashWallet) session.createQuery("FROM PettyCashWallet WHERE employee_id=(SELECT id FROM Employee WHERE general_user_profile_id='" + user.getGeneralUserProfile().getId() + "')").setMaxResults(1).uniqueResult();
if(pettyCashWallet!=null){
                if (pettyCashWallet.getAmount() >= totAmount) {
                    PettyCashApprovalLevel approvalLevel = (PettyCashApprovalLevel) session.createQuery("from PettyCashApprovalLevel where name='pending'").uniqueResult();
//                    PettyCashApprovalLevel RejectLevel = (PettyCashApprovalLevel) session.createQuery("from PettyCashApprovalLevel where name='Reject'").uniqueResult();
                    List<PettyCashTransactionHistory> pcthdata = (List<PettyCashTransactionHistory>) session.createQuery("from PettyCashTransactionHistory where petty_cash_wallet_id='" + pettyCashWallet.getId() + "' and petty_cash_approval_level_id='" + approvalLevel.getId() + "'").list();
                    if (pcthdata.size() != 0) {
                        double pcthtotal = 0.0;
                        for (PettyCashTransactionHistory data : pcthdata) {
                            pcthtotal += data.getAmount();
                        }
                        if (pettyCashWallet.getAmount() - pcthtotal >= totAmount) {

                            if (!settlmentID.isEmpty()) {
                                PettyCashTransactionHistory pettyCashTransactionHistory = (PettyCashTransactionHistory) session.createQuery("FROM PettyCashTransactionHistory WHERE id='" + settlmentID + "'").setMaxResults(1).uniqueResult();
                                if (pettyCashTransactionHistory.getPettyCashApprovalLevel().getId() == 3) {
                                    List<PettyCashTransactionHistoryDocument> documents = (List<PettyCashTransactionHistoryDocument>) session.createQuery("from PettyCashTransactionHistoryDocument where petty_cash_transaction_history_id='" + pettyCashTransactionHistory.getId() + "'").list();
                                    File imageFile;
                                    for (PettyCashTransactionHistoryDocument document : documents) {
                                        imageFile = new File(ComPath.getFILE_PATH() + "web/pettyCashWalletimgs/" + document.getDoc());
                                        if (imageFile.exists()) {
                                            imageFile.delete();
                                        }
                                    }
                                    session.createQuery("Delete from PettyCashTransactionHistoryDocument where petty_cash_transaction_history_id='" + pettyCashTransactionHistory.getId() + "'").executeUpdate();
                                    session.delete(pettyCashTransactionHistory);
                                }
                            }

                            PettyCashTransactionHistory pcth = new PettyCashTransactionHistory();
                            pcth.setAmount(totAmount);
                            pcth.setTransactionDate(new Date());
                            pcth.setPettyCashWallet(pettyCashWallet);
                            pcth.setTransactionType((TransactionType) session.createQuery("FROM TransactionType WHERE name='Card'").setMaxResults(1).uniqueResult());
                            pcth.setPettyCashApprovalLevel(approvalLevel);
                            pcth.setDescription(Description);
                            session.save(pcth);
                            for (int i = 0; i < jsonArray.length(); i++) {
                                JSONObject rowData = jsonArray.getJSONObject(i);

                                PettyCashTransactionHistoryDocument pcthd = new PettyCashTransactionHistoryDocument();
                                pcthd.setAmount(Double.parseDouble(rowData.getString("amount")));
                                pcthd.setTransactionDate(new Date());
                                pcthd.setDoc(rowData.getString("attachment"));
                                pcthd.setUploadedDate(new Date());
                                pcthd.setExpenseDescription(rowData.getString("expenseDescription"));
                                pcthd.setPettyCashTransactionHistory(pcth);

                                session.save(pcthd);
                            }
                            responseJson.put("status", "success");
                        } else {
                            responseJson.put("status", "invalid Amount");
                        }
                    } else {
                         if (!settlmentID.isEmpty()) {
                            PettyCashTransactionHistory pettyCashTransactionHistory = (PettyCashTransactionHistory) session.createQuery("FROM PettyCashTransactionHistory WHERE id='" + settlmentID + "'").setMaxResults(1).uniqueResult();
                            if (pettyCashTransactionHistory.getPettyCashApprovalLevel().getId() == 3) {
                                List<PettyCashTransactionHistoryDocument> documents = (List<PettyCashTransactionHistoryDocument>) session.createQuery("from PettyCashTransactionHistoryDocument where petty_cash_transaction_history_id='" + pettyCashTransactionHistory.getId() + "'").list();
                                File imageFile;
                                for (PettyCashTransactionHistoryDocument document : documents) {
                                    imageFile = new File(ComPath.getFILE_PATH() + "web/pettyCashWalletimgs/" + document.getDoc());
                                    if (imageFile.exists()) {
                                        imageFile.delete();
                                    }
                                }
                                session.createQuery("Delete from PettyCashTransactionHistoryDocument where petty_cash_transaction_history_id='" + pettyCashTransactionHistory.getId() + "'").executeUpdate();
                                session.delete(pettyCashTransactionHistory);
                            }
                        }
                        PettyCashTransactionHistory pcth = new PettyCashTransactionHistory();
                        pcth.setAmount(totAmount);
                        pcth.setTransactionDate(new Date());
                        pcth.setPettyCashWallet(pettyCashWallet);
                        pcth.setTransactionType((TransactionType) session.createQuery("FROM TransactionType WHERE name='Card'").setMaxResults(1).uniqueResult());
                        pcth.setPettyCashApprovalLevel(approvalLevel);
                        pcth.setDescription(Description);
                        session.save(pcth);
                        for (int i = 0; i < jsonArray.length(); i++) {
                            JSONObject rowData = jsonArray.getJSONObject(i);

                            PettyCashTransactionHistoryDocument pcthd = new PettyCashTransactionHistoryDocument();
                            pcthd.setAmount(Double.parseDouble(rowData.getString("amount")));
                            pcthd.setTransactionDate(new Date());
                            pcthd.setDoc(rowData.getString("attachment"));
                            pcthd.setUploadedDate(new Date());
                            pcthd.setExpenseDescription(rowData.getString("expenseDescription"));
                            pcthd.setPettyCashTransactionHistory(pcth);

                            session.save(pcthd);
                        }
                        responseJson.put("status", "success");
                    }

                    tr.commit();
                    session.close();

                } else {
                    responseJson.put("status", "invalid Amount");
                }
}else{
 responseJson.put("status", "Wallet Amount is 0.00 !");
}  
            }
            resp.getWriter().write(responseJson.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
