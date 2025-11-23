/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.Connection.NewHibernateUtil;
import Model.Logic.UserLoginDAO;
import Model.Mapping.GeneralUserProfile;
import Model.Mapping.UniversalPayrollManager;
import Model.Mapping.UserLogin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.json.simple.JSONObject;

/**
 *
 * @author Personal
 */
@WebServlet(name = "UniversalPayrollSaveSalarySheet", urlPatterns = {"/UniversalPayrollSaveSalarySheet"})
public class UniversalPayrollSaveSalarySheet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("GUP_ID") != null) {
            JSONObject objSend = new JSONObject();
            int status = 200;
            String message = "";
            Session sess = NewHibernateUtil.getSessionFactory().openSession();
            String gup_id = req.getSession().getAttribute("GUP_ID").toString();
            UserLogin ul = UserLoginDAO.getByID(sess, Integer.parseInt(gup_id));
            if (ul.getUserRole().getId() == 1 || ul.getUserRole().getId() == 2) {
                GeneralUserProfile gup = (GeneralUserProfile) sess.load(GeneralUserProfile.class, Integer.parseInt(req.getSession().getAttribute("GUP_ID").toString()));
                try {
                    String pmId = req.getParameter("pmId");
                    UniversalPayrollManager payrollManager = (UniversalPayrollManager) sess.load(UniversalPayrollManager.class, Integer.parseInt(pmId));
                    if (payrollManager != null) {
                        double basic_salery = Double.parseDouble(req.getParameter("basic_salery"));
                        double br = Double.parseDouble(req.getParameter("br"));
                        double no_pay = Double.parseDouble(req.getParameter("no_pay"));
                        double attantance = Double.parseDouble(req.getParameter("attantance"));
                        double porfoments = Double.parseDouble(req.getParameter("porfoments"));
                        double insentive = Double.parseDouble(req.getParameter("insentive"));
                        double traveling = Double.parseDouble(req.getParameter("traveling"));
                        double house_rental = Double.parseDouble(req.getParameter("house_rental"));
                        double salary_advance = Double.parseDouble(req.getParameter("salary_advance"));
                        double other_deductions = Double.parseDouble(req.getParameter("other_deductions"));
                        double tax = Double.parseDouble(req.getParameter("tax"));
                        
                        double gross_salary = basic_salery + br;
                        double salary_for_epf = gross_salary - no_pay;
                        boolean isEpf = true;
                        if (payrollManager.getEmployee().getIsEpf() != null) {
                            if (!payrollManager.getEmployee().getIsEpf()) {
                                isEpf = false;
                            }
                        }
                        double epf_8 = 0.0;
                        double epf_12 = 0.0;
                        double etf_3 = 0.0;
                        if (isEpf) {
                            epf_8 = (salary_for_epf * 8) / 100;
                            epf_12 = (salary_for_epf * 12) / 100;
                            etf_3 = (salary_for_epf * 3) / 100;
                        }
                        
                        double total = salary_for_epf - epf_8 + attantance + porfoments + insentive + traveling
                                + house_rental - salary_advance - other_deductions - tax;
                        
                        payrollManager.setAttendance(attantance);
                        payrollManager.setBasicSalary(basic_salery);
                        payrollManager.setBr(br);
                        payrollManager.setEpf12(epf_12);
                        payrollManager.setEpf8(epf_8);
                        payrollManager.setEtf3(etf_3);
                        
                        payrollManager.setGeneralUserProfileByGeneralUserProfileGupIdUpdatedBy(gup);
                        payrollManager.setGrossSalary(gross_salary);
                        payrollManager.setHouseRental(house_rental);
                        payrollManager.setIncentive(insentive);
                        payrollManager.setLastUpdateTime(new Date());
                        payrollManager.setNoPay(no_pay);
                        payrollManager.setOtherDeduction(other_deductions);
                        payrollManager.setPerformance(porfoments);
                        payrollManager.setSalaryAdvanced(salary_advance);
                        payrollManager.setTax(tax);
                        payrollManager.setTotalSalary(total);
                        payrollManager.setTravelling(traveling);
                        sess.update(payrollManager);
                        message = "Successfully Saved";
                        status = 200;
                        
                    } else {
                        message = "Invalid";
                        status = 404;
                    }
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    status = 500;
                    message = "ERROR";
                }
            }
            sess.beginTransaction().commit();
            sess.flush();
            sess.close();
            
            objSend.put("status", status);
            objSend.put("message", message);
            resp.setContentType("text/json;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            try {
                out.print(objSend);
            } finally {
                out.close();
            }
        } else {
            resp.sendRedirect("login/admin.jsp");
        }
    }
    
}
