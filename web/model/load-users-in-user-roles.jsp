<%-- 
    Document   : load-users-in-user-roles
    Created on : Apr 7, 2022, 12:06:13 PM
    Author     : Personal
--%>

<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="Model.Mapping.UserRole"%>
<%@page import="Model.Logic.UserRoleDAO"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Session sess = NewHibernateUtil.getSessionFactory().openSession();
    if (session.getAttribute("GUP_ID") != null) {
        int userrole_id = Integer.parseInt(request.getParameter("userrole_id"));
        UserRole ur = UserRoleDAO.getByID(sess, userrole_id);
%>
<div class="portlet light portlet-fit">
    <div class="portlet-title bg-blue-steel">
        <div class="caption">
            <span class="caption-subject font-white ca-title">Users in User Role</span>
        </div>
    </div>
    <div class="portlet-body">    
        <div class="row">
            <div class="col-md-12">
                <div class="form-group form-md-line-input">
                    <input type="text" style="padding-right: 5px; font-weight: bold"  class="form-control" disabled="" value="<%= ur.getName() %>"/>
                    <label for="form_control_1" class="bold">User Role</label>
                </div>
            </div>
        </div>
        <div class="row">
            <%
                List<UserLogin> ul_list = sess.createQuery("from UserLogin where isActive!=0 AND userRole.urId='" + userrole_id + "'").list();
                if (!(ul_list.isEmpty())) {
                    int count=0;
            %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Nic</th>
                        <th>Username</th>
                        <th>Full Name</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (UserLogin ul : ul_list) {
                    %>
                    <tr>
                        <td><%= ++count %></td>
                        <td><%= ul.getGeneralUserProfile().getNic() %></td>
                        <td><%= ul.getUsername() %></td>
                        <td><%= ul.getGeneralUserProfile().getFirstName()+" "+ul.getGeneralUserProfile().getLastName() %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            %>



        </div>
    </div>
</div>


<%} else {
        response.sendRedirect("../login/admin.jsp");
    }
%>
