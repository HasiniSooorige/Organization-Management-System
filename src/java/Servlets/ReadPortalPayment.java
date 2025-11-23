/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Model.CommonMethod.Com;
import Model.Mapping.GeneralUserProfile;
import Model.Connection.NewHibernateUtil;
import Model.EmployeeM;
import Model.Mapping.Employee;
import Model.Mapping.Voucher;
import Model.VoucherM;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.joda.time.LocalDate;

/**
 *
 * @author jalana
 */
@WebServlet(name = "ReadPortalPayment", urlPatterns = {"/ReadPortalPayment"})
public class ReadPortalPayment extends HttpServlet {

    Voucher gupp;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("read_paymentPortal_all_servlet_call");

        String minDate = req.getParameter("dateMin");
        String maxDate = req.getParameter("dateMax");
        System.out.println(" check");
        System.out.println(minDate);
        System.out.println(maxDate);

        LocalDate dt1 = LocalDate.parse(minDate);
        LocalDate dt2 = LocalDate.parse(maxDate);

        Session sess = NewHibernateUtil.getSessionFactory().openSession();
        try {
            List<VoucherM> uds = new ArrayList<>();
            List<Voucher> list = sess.createQuery("From Voucher Where voucherType='" + 1 + "'").list();
            if (!list.isEmpty()) {

                System.out.println("list-size " + list.size());
                for (Voucher gup : list) {
                    VoucherM ud = new VoucherM();
                    LocalDate checkDt = LocalDate.parse(Com.getDate(gup.getPaymentDate()));
                    Boolean containsToday = (!checkDt.isBefore(dt1)) && (!checkDt.isAfter(dt2));
                    //  System.out.println(containsToday);
                    if (containsToday) {
                        ud.setNic(gup.getGeneralUserProfile().getNic());
                        ud.setVid(gup.getVid());
                        ud.setVoucherTotal(Com.numformat(gup.getVoucherTotal()));
                        ud.setInstitute(gup.getGeneralOrganizationProfile().getName());
                        ud.setName(gup.getGeneralUserProfile().getFirstName() + " " + gup.getGeneralUserProfile().getLastName());
                        ud.setDescription(gup.getDescription());
                        ud.setPaymentMode(gup.getPaymentMode().getName());
                        ud.setPaymentDate(Com.getDate(gup.getPaymentDate()));
                        uds.add(ud);
                    //    System.out.println(uds);
                    }

                }
            }
            
            String jsonString = new Gson().toJson(uds);
            
                 resp.getWriter().print(jsonString);
 
            
          
        } catch (Exception e) {

            e.printStackTrace();
        } finally {
            sess.close();
        }

    }

}
