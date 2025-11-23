package Servlets;

import Com.Tools.Security;
import Model.Connection.NewHibernateUtil;
import Model.Mapping.LoginSession;
import Model.Mapping.UserLogin;
import filteration.Filteration;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.Transaction;
import static java.lang.System.out;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;

@WebServlet(name = "SelectLogin", urlPatterns = {"/SelectLogin"})
public class SelectLogin extends HttpServlet {

    UserLogin userX;
    private static final SimpleDateFormat FORMATTER = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(Calendar.getInstance().getTime());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        Session hibernate = NewHibernateUtil.getSessionFactory().openSession();
        Transaction tr1 = hibernate.beginTransaction();
        HttpSession ses = request.getSession();

        boolean success = false;
        String message = "";
        Integer idURoll = null;
        String link = "";

        JSONArray js = new JSONArray();
        Map m = new HashMap();
        String origin = request.getHeader("Origin");
        System.out.println("origin " + origin);

        try {

            String uname = Filteration.getFilteredUsername(request.getParameter("uuser"));
            String pass = request.getParameter("upassword");
            UserLogin u_login = (UserLogin) hibernate.createQuery("FROM UserLogin where username='" + uname + "'").setMaxResults(1).uniqueResult();
            String ps = "";

            if (u_login.getIsActive()) {

                if (u_login == null) {
                    message = "Invalid Username or Password.";
                    System.out.println("Invalid Username or Password.");

                } else {
                    ps = Security.decrypt(u_login.getPassword());
                    if (ps.equals(pass)) {
                        if (u_login.getIsActive() == false) {
                            message = "Your Account is Suspended. Please contact System Admin.";
                        } else {

                            String ip = request.getHeader("CF-Connecting-IP");
                            if (ip == null) {
                                ip = request.getRemoteAddr();
                            }

                            LoginSession session = new LoginSession();
                            session.setStartTime(convertStringToDate(timeStamp));
                            session.setEndTime(null);
                            session.setIp(ip);
                            session.setUserLogin(u_login);
                            hibernate.save(session);

                            u_login.setCountAttempt(0);
                            hibernate.update(u_login);
                            ses.setAttribute("user", u_login);
                            ses.setAttribute("user_name", u_login.getGeneralUserProfile().getFirstName() + " " + u_login.getGeneralUserProfile().getLastName());
                            ses.setAttribute("Session_ID", session.getId());
                            ses.setAttribute("User_ID", u_login.getId());

                            //U ROLE
                            idURoll = u_login.getUserRole().getId();
                            if (u_login.getUserRole().getName().equals("Super Admin")) {
                                ses.setAttribute("GUP_ID", u_login.getGeneralUserProfile().getId());
                                System.out.println("super gup set");
                                link = "page-mng-dashboard.jsp";
                            }
                            if (u_login.getUserRole().getName().equals("Manager")) {
                                link = "page-mng-dashboard.jsp";

                                ses.setAttribute("User_ID", u_login.getId());
                                ses.setAttribute("GUP_ID", u_login.getGeneralUserProfile().getId());
                                System.out.println("manager gup set");
                            }
                            if (u_login.getUserRole().getName().equals("Employee")) {
                                ses.setAttribute("Emp_ID", u_login.getId());
                                ses.setAttribute("Emp_GUP", u_login.getGeneralUserProfile().getId());

                                link = "page-emp-dashboard.jsp";
                            }
                            if (u_login.getUserRole().getName().equals("Client")) {

                                ses.setAttribute("C_ID", u_login.getId());
                                ses.setAttribute("C_GUP", u_login.getGeneralUserProfile().getId());
                                link = "page-external-dashboard.jsp";
                            }
                            success = true;
                        }

                    } else {
                        System.out.println("password_not match");

                        if (u_login.getCountAttempt() >= 3) {
                            message = "Your Account is Suspended. Please contact System Admin.";

                            UserLogin ul = (UserLogin) hibernate.load(UserLogin.class, u_login.getId());
                            ul.setIsActive(false);
                            hibernate.saveOrUpdate(ul);

                        } else {
                            System.out.println("Invalid Username or Password_next_line.");
                            int count = u_login.getCountAttempt();
                            count++;

                            UserLogin ul = (UserLogin) hibernate.load(UserLogin.class, u_login.getId());
                            ul.setCountAttempt(count);
                            hibernate.saveOrUpdate(ul);

                            message = "Invalid Username or Password.";
                        }
                    }
                    tr1.commit();
                }

            } else {
                message = "Deactivated Account.";
                System.out.println("Deactivated account.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            message = "Error Occurred .";

        } finally {
            hibernate.close();
        }
        String stringCookies = request.getHeader("Cookie");
        System.out.println(stringCookies);
        String arr = stringCookies.split("JSESSIONID=")[1];
        System.out.println(arr);
        String jsession_value = arr.split(";")[0];
        System.out.println("jsession_value :" + jsession_value);

        response.setHeader("set-cookie", "JSESSIONID=" + jsession_value + ";HttpOnly;SameSite=Strict;Secure");
        System.out.println("suc " + success);
        System.out.println("link " + link);
        System.out.println("roll: " + idURoll);
        m.put("success", success);
        m.put("message", message);
        m.put("idURoll", idURoll);
        m.put("link", link);
        js.add(m);
        out.print(js.toJSONString());
        response.getWriter().write(js.toJSONString());
//            

    }

    public static Date convertStringToDate(String date) {
        if (date != null) {
            try {
                return FORMATTER.parse(date);
            } catch (ParseException e) {
                // nothing we can do if the input is invalid
                throw new RuntimeException(e);
            }
        }
        return null;
    }

}
