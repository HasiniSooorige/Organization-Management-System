p-4<%-- 
    Document   : create-new-interface
    Created on : Oct 13, 2023, 12:28:16 PM
    Author     : Personal
--%>

<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Model.Logic.UserRoleDAO"%>
<%@page import="Model.Mapping.UserRole"%>
<%@page import="Model.Logic.SystemInterfaceDAO"%>
<%@page import="Model.Mapping.SystemInterface"%>
<%@page import="Model.Logic.InterfaceSubMenuDAO"%>
<%@page import="Model.Mapping.InterfaceSubMenu"%>
<%@page import="java.util.List"%>
<%@page import="Model.Logic.InterfaceMenuDAO"%>
<%@page import="Model.Mapping.InterfaceMenu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html
    lang="en"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
        <title>Exon - Create New Interface</title>
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/" />
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"/>
        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />
        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />
        <!-- Page CSS -->
        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
        <script src="../assets/js/config.js"></script>
        <style>
            thead,
            tbody,
            tfoot,
            tr,
            td,
            th {
                border-color: #cccccc !important;
                border-style: solid;
                border-width: 0;
            }

            .title-label-color-green{
                background-color: #1BBC9B  !important;
                color: #233446 !important;
            }
            .title-label-color-puple{
                background-color: #9B59B6   !important;
                color: #233446 !important;
            }
            .btn-success {
                color: #fff;
                background-color: #009999;
                border-color: #2dc0cd;
            }
            .btn-success:hover {
                color: #fff;
                background-color: #00cccc;
                border-color: #2dc0cd;
            }
            .list-items ul{
                list-style: none;
            }
            .list-items ul li ul{
                margin-left:10px;
            }
            .list-items ul li{
                margin-bottom:5px;
            }
        </style>
    </head>
   <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if (!(request.getSession().getAttribute("GUP_ID") == null)) {


    %>
    <body>
  
        <!-- Layout wrapper -->
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->
                <%@include file="../main-pages/includes/admin-panel.jsp" %>
                <!-- / Menu -->

                <!-- Layout container -->
                <div class="layout-page">
                    <%@include file="../main-pages/includes/header.jsp" %>
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-muted fw-light">
                                    Assign Interface to User Role</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Assign Interface to User Role 
                            </h6>
                            <div class="card" id="create-new-interface">
                                <div class="portlet-body">
                                    <div class="row">
                                        <div class="col-md-6 list-items p-4">
                                            <h4>System Interfaces</h4>
                                            <div class="md-checkbox text-left"><label for="form_control_1">Select All</label>
                                                <input type="checkbox" id="checkbox" class="md-check" onclick="Set_interfaceCheckedAll()" >
                                                <label for="checkbox">
                                                    <span class="inc"></span>
                                                    <span class="check"></span>
                                                    <span class="box"></span> </label>
                                            </div>
                                            <ul >
                                                <%                                                List<SystemInterface> si_list = SystemInterfaceDAO.listByQuery(sess, null, "interfaceMenu.ifId ASC");
                                                    int count = 1;
                                                    if (!(si_list.isEmpty())) {
                                                        int menuid = 0;
                                                        for (SystemInterface si : si_list) {
                                                            if (menuid != si.getInterfaceMenu().getIfId()) {
                                                                if (si.getInterfaceSubMenu().getIfsId() == 4) {
                                                %>
                                                <li>
                                                    <div class="md-checkbox text-left">
                                                        <input type="checkbox" id="checkbox_interface<%=count%>" class="md-check" value="<%= si.getSiId()%>">
                                                        <label for="checkbox_interface<%=count%>">
                                                            <span class="inc"></span>
                                                            <span class="check"></span>
                                                            <span class="box"></span> 
                                                        </label>
                                                        <i class="<%= si.getIcon()%>"></i>
                                                        <span class="title"><%= si.getDisplayName()%></span>
                                                    </div>

                                                </li>
                                                <%
                                                    ++count;
                                                } else {
                                                %>
                                                <li>
                                                    <i class="fa fa-tasks"></i>
                                                    <span class="title"><%= si.getInterfaceMenu().getMenuName()%></span>
                                                    <ul>
                                                        <li>
                                                            <%
                                                                SystemInterface si1obj = (SystemInterface) sess.createQuery("from SystemInterface where  interfaceMenu.ifId='" + si.getInterfaceMenu().getIfId() + "' AND  interfaceSubMenu.ifsId=1").setMaxResults(1).uniqueResult();
                                                                if (si1obj != null) {%>
                                                            <i class="icon-globe"></i>
                                                            <span class="title">Tasks</span>
                                                            <%}
                                                            %>
                                                            <ul>
                                                                <%
                                                                    for (SystemInterface si2 : SystemInterfaceDAO.listByQuery(sess, " interfaceMenu.ifId='" + si.getInterfaceMenu().getIfId() + "'", null)) {
                                                                        if (si2.getInterfaceSubMenu().getIfsId() == 1 && si2.getInterfaceMenu().getMenuName().equals(si.getInterfaceMenu().getMenuName())) {
                                                                %>
                                                                <li>
                                                                    <div class="md-checkbox text-left">
                                                                        <input type="checkbox" id="checkbox_interface<%=count%>" class="md-check" value="<%= si2.getSiId()%>">
                                                                        <label for="checkbox_interface<%=count%>">
                                                                            <span class="inc"></span>
                                                                            <span class="check"></span>
                                                                            <span class="box"></span> 
                                                                        </label>
                                                                        <i class="<%= si2.getIcon()%>"></i>
                                                                        <span class="title"><%= si2.getDisplayName()%></span>
                                                                    </div>
                                                                </li>
                                                                <%
                                                                            ++count;
                                                                        }
                                                                    }
                                                                %>
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <%
                                                                SystemInterface si2obj = (SystemInterface) sess.createQuery("from SystemInterface where  interfaceMenu.ifId='" + si.getInterfaceMenu().getIfId() + "' AND  interfaceSubMenu.ifsId=2").setMaxResults(1).uniqueResult();
                                                                if (si2obj != null) {%>
                                                            <i class="icon-globe"></i>
                                                            <span class="title">Reports</span>
                                                            <%}
                                                            %>
                                                            <ul>
                                                                <%
                                                                    for (SystemInterface si2 : SystemInterfaceDAO.listByQuery(sess, " interfaceMenu.ifId='" + si.getInterfaceMenu().getIfId() + "'", null)) {
                                                                        if (si2.getInterfaceSubMenu().getIfsId() == 2 && si2.getInterfaceMenu().getMenuName().equals(si.getInterfaceMenu().getMenuName())) {
                                                                %>
                                                                <li>
                                                                    <div class="md-checkbox text-left">
                                                                        <input type="checkbox" id="checkbox_interface<%=count%>" class="md-check" value="<%= si2.getSiId()%>">
                                                                        <label for="checkbox_interface<%=count%>">
                                                                            <span class="inc"></span>
                                                                            <span class="check"></span>
                                                                            <span class="box"></span> 
                                                                        </label>
                                                                        <i class="<%= si2.getIcon()%>"></i>
                                                                        <span class="title"><%= si2.getDisplayName()%></span>
                                                                    </div>
                                                                </li>
                                                                <%
                                                                            ++count;
                                                                        }
                                                                    }
                                                                %>
                                                            </ul>
                                                        </li>
                                                        <li>
                                                            <%
                                                                SystemInterface si3obj = (SystemInterface) sess.createQuery("from SystemInterface where  interfaceMenu.ifId='" + si.getInterfaceMenu().getIfId() + "' AND  interfaceSubMenu.ifsId=3").setMaxResults(1).uniqueResult();
                                                                if (si3obj != null) {%>
                                                            <i class="icon-globe"></i>
                                                            <span class="title">Maintain</span>
                                                            <%}
                                                            %>
                                                            <ul>
                                                                <%
                                                                    for (SystemInterface si2 : SystemInterfaceDAO.listByQuery(sess, " interfaceMenu.ifId='" + si.getInterfaceMenu().getIfId() + "'", null)) {
                                                                        if (si2.getInterfaceSubMenu().getIfsId() == 3 && si2.getInterfaceMenu().getMenuName().equals(si.getInterfaceMenu().getMenuName())) {
                                                                %>
                                                                <li>
                                                                    <div class="md-checkbox text-left">
                                                                        <input type="checkbox" id="checkbox_interface<%=count%>" class="md-check" value="<%= si2.getSiId()%>">
                                                                        <label for="checkbox_interface<%=count%>">
                                                                            <span class="inc"></span>
                                                                            <span class="check"></span>
                                                                            <span class="box"></span> 
                                                                        </label>
                                                                        <i class="<%= si2.getIcon()%>"></i>
                                                                        <span class="title"><%= si2.getDisplayName()%></span>
                                                                    </div>
                                                                </li>
                                                                <%
                                                                            ++count;
                                                                        }
                                                                    }
                                                                %>
                                                            </ul>
                                                        </li>


                                                    </ul>
                                                </li>
                                                <%
                                                                }
                                                            }
                                                            menuid = si.getInterfaceMenu().getIfId();
                                                        }
                                                    }
                                                %>


                                            </ul>
                                        </div>  
                                        <div class="col-md-6 p-4 list-items">
                                            <h4>User Roles</h4>
                                            <ul>
                                                <%
                                                    List<UserRole> ur_list = UserRoleDAO.listByQuery(sess, null, null);
                                                    int role_count = 1;
                                                    for (UserRole ur : ur_list) {
                                                %>
                                                <li>
                                                    <div class="md-checkbox text-left">
                                                        <input type="checkbox" id="checkbox_role<%= role_count%>" class="md-check" value="<%= ur.getId()%>">
                                                        <label for="checkbox_role<%= role_count%>">
                                                            <span class="inc"></span>
                                                            <span class="check"></span>
                                                            <span class="box"></span> 
                                                        </label>
                                                        <span class="title"><%= ur.getName()%></span>
                                                    </div>
                                                </li>
                                                <%
                                                        ++role_count;
                                                    }
                                                %>
                                            </ul>
                                        </div>  
                                    </div> 

                                    <br>
                                    <div class="row p-4 mb-3">
                                        <div class="col-sm-12" align="right">
                                            <button class="btn btn-success " type="button" onclick="addInterfaceToUserRoleNew();"> <i class="fa fa-plus"></i>Add</button>                                        </div>
                                    </div>

                                </div>
                                <input type="hidden" id="count" value="<%= count%>">
                                <input type="hidden" id="role_count" value="<%= role_count%>">
                                <br/><br/><br/> 
                                <!--Interfaces for user-role-->
                                <div class="card" id="create-new-interface">
                                        <h5 class="fw-bold p-4 py-1 mb-1 text-uppercase"><span> User Interfaces for user-role</span></h5>
                                    <div class="portlet-body ">
                                        <div class="card" id="create-new-interface">
                                            <div class="portlet-body">   
                                                <div class="row">
                                                    <div class="col-md-12 p-4">
                                                        <div class="form-group form-md-line-input" id="interface_field">
                                                            <label for="form_control_1">Select Interface<span class="required">*</span></label>
                                                            <span class="help-block"></span>
                                                            <select class="form-control" id="interface" name="interface" onchange="loadInterfaceTouserRole();">
                                                                <option value="0">Select Interface</option>
                                                                <%for (SystemInterface si : SystemInterfaceDAO.listByQuery(sess, null, null)) {%>
                                                                <option value="<%=si.getSiId()%>"><%= si.getInterfaceMenu().getMenuName()%> |<%if (si.getInterfaceSubMenu() != null) {%><%= si.getInterfaceSubMenu().getName()%><%}%>  | <%= si.getInterfaceName()%></option>
                                                                <%}%>
                                                            </select>
                                                        </div>
                                                        <div style="text-align: center; height: 50px;">
                                                            <img src="../assets/img/preloader.gif" id="preloader1" style="display: none">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row p-4">
                                                    <table class=" p-4 table table-striped table-bordered table-hover user-role" id="">
                                                        <thead>
                                                        <th>#</th>
                                                        <th>User Role</th>
                                                        <th style="width: 10%;"></th>
                                                        </thead>
                                                        <tbody id="in_to_userrole">
                                                            <tr><td colspan="3">No records found.</td></tr>
                                                        </tbody>
                                                    </table>
                                                </div>        
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--Interfaces for user-role-->
                                <br/> <br/> <br/>
                                <!--User role for user interfaces-->
                                <div class="card" id="create-new-interface">
                                   

                                            <h5 class="fw-bold p-4 py-1 mb-1 text-uppercase"><span >User role for user interfaces</span></h5>
                                    
                                    <div class="portlet-body">
                                        <div class="portlet-body">   
                                            <div class="row p-4">
                                                <div class="col-md-12">
                                                    <div class="form-group form-md-line-input" id="userrole_field">
                                                        <label for="form_control_1">Select User Role<span class="required">*</span></label>
                                                        <span class="help-block"></span>
                                                        <select class="form-control" id="userrole" name="userrole" onchange="loadUserRoleToInterface();">
                                                            <option value="0">Select Interface</option>
                                                            <%for (UserRole ur : UserRoleDAO.listByQuery(sess, null, null)) {%>
                                                            <option value="<%=ur.getId()%>"><%= ur.getName()%></option>
                                                            <%}%>
                                                        </select>
                                                    </div>

                                                    <!--                                                    <div class="row">       
                                                                                                            <div class="col-md-12">
                                                                                                                <div style="padding-top: 10px;">
                                                                                                                    <div class="margiv-top-10 text-right">
                                                                                                                        <button class="btn purple" type="button" onclick="checkUsersToUserRole();"> <i class="fa fa-search"></i>Check Users in User Role</button>
                                                                                                                    </div>
                                                                                                                </div>
                                                                                                            </div>
                                                                                                        </div>-->

                                                    <div style="text-align: center; height: 50px;">
                                                        <img src="../assets/img/preloader.gif" id="preloader2" style="display: none">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row p-4">
                                                <table class="table table-striped table-bordered table-hover user-role" id="">
                                                    <thead>
                                                    <th>#</th>
                                                    <th>User Interface</th>
                                                    <th style="width: 10%;"></th>
                                                    </thead>
                                                    <tbody id="in_to_userinterfaces">
                                                        <tr><td colspan="3">No records found.</td></tr>
                                                    </tbody>
                                                </table>
                                            </div> 
                                            <br/><br/><br/>
                                        </div>
                                    </div>
                                </div>
                                <!--User role for user interfaces-->
                            </div>
                            <!-- Content wrapper -->
                        </div>
                        <!-- / Layout page -->
                    </div>
                    <!-- Overlay -->  
                </div>
                <!-- / Layout wrapper -->
            </div>
        </div>
            <%@include file="../assets/js/include/all_scripts.jsp" %>

            <style>
                @media only screen and (max-width: 600px) {
                    .overflowtable {
                        overflow: auto;
                    }
                }
            </style>
            <script>
                function viewDisbursement() {
                    document.getElementById("Cash_Settlements").classList.add("d-none");
                    document.getElementById("Disbursement").classList.remove("d-none");
                }
                function viewCashSettlements() {
                    document.getElementById("Cash_Settlements").classList.remove("d-none");
                    document.getElementById("Disbursement").classList.add("d-none");
                }
            </script>
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>

