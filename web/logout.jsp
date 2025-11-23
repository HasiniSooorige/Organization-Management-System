<%-- 
    Document   : logout
    Created on : Oct 30, 2023, 9:24:58 AM
    Author     : Personal
--%>
<%
    HttpSession ses = request.getSession(false);

    try {
        int i = (Integer) ses.getAttribute("User_ID");

        if (i > 0) {

            ses.invalidate();
            response.addHeader("Refresh", "1");
        } else {

            session.invalidate();
            response.sendRedirect("index.jsp");
        }
//        int u = 0;
//        if (ses.getAttribute("GUP_ID") != null) {
//            u = (Integer) ses.getAttribute("User_ID");
//        }
//        if (ses.getAttribute("Emp_ID") != null) {
//            System.out.println("emppppppppppp");
//            u = (Integer) ses.getAttribute("Emp_ID");
//        }
//        if (ses.getAttribute("C_GUP") != null) {
//            u = (Integer) ses.getAttribute("C_GUP");
//        }
//        if (u > 0) {
//            ses.invalidate();
//            response.addHeader("Refresh", "1");
//        } else {
//            response.sendRedirect("../index.jsp");
//        }

    } catch (Exception e) {
        response.sendRedirect("index.jsp");
    } finally {
//        System.gc();
    }


%>