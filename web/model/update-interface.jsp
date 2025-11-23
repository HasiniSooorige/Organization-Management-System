<%-- 
    Document   : update-interface
    Created on : Sep 14, 2021, 11:33:27 PM
    Author     : sachintha
--%>

<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="Model.Logic.SystemInterfaceDAO"%>
<%@page import="Model.Mapping.SystemInterface"%>
<%@page import="Model.Logic.InterfaceSubMenuDAO"%>
<%@page import="Model.Mapping.InterfaceSubMenu"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Model.Logic.InterfaceMenuDAO"%>
<%@page import="Model.Mapping.InterfaceMenu"%>

<%
    Session sess = NewHibernateUtil.getSessionFactory().openSession();
    int si_id = Integer.parseInt(request.getParameter("interface_id"));
    System.out.println(si_id);
    SystemInterface si = SystemInterfaceDAO.getByID(sess, si_id);
    System.out.println(si);
%>
<form id="new_interface">
    <div class="form-body">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group form-md-line-input" id="inmenu_field">
                    <label for="form_control_1">Interface Menu</label>
                    <span class="help-block"></span>
                    <select class="form-control" id="inmenu<%= si_id %>" name="inmenu<%= si_id %>">
                        <option value="<%= si.getInterfaceMenu().getIfId()%>"><%= si.getInterfaceMenu().getMenuName()%></option>
                        <%for (InterfaceMenu menu : InterfaceMenuDAO.listByQuery(sess, null, null)) {
                                if (menu.getIfId() != si.getInterfaceMenu().getIfId()) {
                        %>
                        <option value="<%=menu.getIfId()%>"><%=menu.getMenuName()%></option>
                        <%}
                            }%>
                    </select>
                </div>
            </div>


            <div class="col-md-6">
                <div class="form-group form-md-line-input" id="insmenu_field">
                    <label for="form_control_1">Interface Sub Menu</label>
                    <span class="help-block"></span>
                    <select class="form-control" id="insmenu<%= si_id %>" name="insmenu">
                        <option value="<%= si.getInterfaceSubMenu().getIfsId()%>"><%= si.getInterfaceSubMenu().getName()%></option>
                        <%for (InterfaceSubMenu menu : InterfaceSubMenuDAO.listByQuery(sess, null, null)) {
                                if (menu.getIfsId() != si.getInterfaceSubMenu().getIfsId()) {
                        %>
                        <option value="<%=menu.getIfsId()%>"><%=menu.getName()%></option>
                        <%}
                            }%>
                    </select>
                </div>
            </div>
        </div> 
        <div class="row">
            <div class="col-md-6">
                <div class="form-group form-md-line-input" id="inname_field">
                    <label for="form_control_1">Interface Name</label>
                    <span class="help-block"></span>
                    <input type="text" class="form-control" id="inname<%= si_id %>" name="inname" value="<%= si.getInterfaceName() %>">
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group form-md-line-input" id="indsname_field">
                    <label for="form_control_1">Display Name</label>
                    <span class="help-block"></span>
                    <input type="text" class="form-control" id="indsname<%= si_id %>" name="indsname" value="<%= si.getDisplayName() %>">
                </div>
            </div> 
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group form-md-line-input" id="inurl_field">
                    <label for="form_control_1">Interface URL</label>
                    <span class="help-block"></span>
                    <input type="text" class="form-control" id="inurl<%= si_id %>" name="inurl" value="<%= si.getUrl() %>">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="form-group form-md-line-input" id="inicon_field">
                    <label for="form_control_1">icon</label>
                    <span class="help-block"></span>
                    <input type="text" class="form-control" id="inicon<%= si_id %>" name="inicon" value="<%= si.getIcon() %>">
                </div>
            </div>
        </div>
           
        <div class="row">       
            <div class="col-md-12">
                <div style="padding-top: 10px;">
                    <div class="margiv-top-10 text-right">
                        <button class="btn btn-primary " type="button" onclick="updateInterface(<%= si_id%>);"> Update</button>
                    </div>
                </div>
            </div>
        </div>
    </div>               

</form>
