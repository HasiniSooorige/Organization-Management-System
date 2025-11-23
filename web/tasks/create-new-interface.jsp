<%-- 
    Document   : create-new-interface
    Created on : Oct 13, 2023, 12:28:16 PM
    Author     : Personal
--%>

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
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
        <title>Exon - UI Manager</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
        <!--<script src="../assets/scripts/pages/jquery.min.js" type="text/javascript"></script>-->
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <link rel="stylesheet" href="../assets/css/projectStyles.css" type="text/css"/>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
            />

        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>

        <link href="//datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="//datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="//cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

        <!--paginatio-->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <script src="../assets/js/admin-task.js"></script>

    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if (!(request.getSession().getAttribute("GUP_ID") == null)) {


    %>
    <body>
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->
                <%@include  file="../main-pages/includes/admin-panel.jsp" %>
                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@include file="../main-pages/includes/header.jsp" %>

                    <!-- / Navbar -->
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    User Interface Manager</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . User Interface Manager
                                </span>
                            </h6>

                            <div class="card" id="create-new-interface">
                                <div class="col-12 col-md-12 portlet-title ">
                                    <h5 class="fw-bold p-4 py-1 mt-3 mb-1 text-primary"><span > Create New UI Menu</span></h5>
                                </div>
                                <div class="portlet-body p-4">
                                    <div class="row">
                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Menu Name <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="menu_name" name="menu_name" >

                                                <div id="menuNameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Menu Name</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Menu Icon <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="menu_icon" name="menu_icon" >

                                                <div id="menuIconErrNotify"  hidden=""  class="text-danger"><small>Please Enter Menu Icon</small></div>
                                            </div>

                                        </div>
                                    </div>

                                    <br>
                                    <div class="row mb-3">
                                        <div class="col-sm-12" align="right">
                                            <button type="submit" id= "empReg" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="saveNewMenu();">Save</button>                                                
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <br/> <br/> 
                            <!--DB Menu-->
                            <div class="card" id="create-new-interface" >
                                <div class="col-12 col-md-12 portlet-title ">
                                    <h5 class="fw-bold py-1 mb-1 mt-3 p-4 text-primary"><span>Main Menu</span></h5>
                                </div>
                                <div class="card-img p-4 " style="height: max-content">
                                    <div class="row container-fluid overflowtable pt-4 pt-md-0">
                                        <div class="col-md-12 m-2">
                                            <div class="table-responsive text-nowrap" >
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Menu Icon</th>
                                                            <th>Menu Name</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="menu_data">
                                                        <%                                                        List<InterfaceMenu> ul_list = sess.createQuery("from InterfaceMenu ").list();

                                                            for (InterfaceMenu im : ul_list) {
                                                        %>
                                                        <tr>
                                                            <td><i class="<%= im.getIcon()%>"></i></td>
                                                            <td><%= im.getMenuName()%></td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br/> <br/>               
                            <!--DB Menu-->
                            <div class="card" id="create-new-interface" >
                                <div class="col-12 col-md-12 portlet-title ">
                                    <h5 class="fw-bold py-1 p-4 mb-1 mt-3 text-primary"><span >Create New Interface</span></h5>
                                </div>
                                <div class="card-img p-4 " style="height: max-content">
                                    <div class="row container-fluid overflowtable pt-4 pt-md-0">
                                        <div class="col-md-12 m-2">

                                            <div class="form-body">

                                                <div class="row mb-3">
                                                    <label class="col-sm-2 col-form-label">Interface Menu <label class="text-danger">*</label></label>
                                                    <div class="col-sm-4">
                                                        <select class="form-select" id="inmenu" name="inmenu">
                                                            <option selected disabled value="">Select Menu</option>
                                                            <%for (InterfaceMenu menu : InterfaceMenuDAO.listByQuery(sess, null, null)) {%>
                                                            <option value="<%=menu.getIfId()%>"><%=menu.getMenuName()%></option>
                                                            <%}%>
                                                        </select>

                                                        <div id="inmenuErrNotify"  hidden=""  class="text-danger"><small>Please Select Interface Menu</small></div>
                                                    </div>

                                                    <label class="col-sm-2 col-form-label">Interface Sub Menu <label class="text-danger">*</label></label>
                                                    <div class="col-sm-4">
                                                        <select class="form-select" id="insmenu" name="insmenu">
                                                            <option selected disabled value="">Select Sub Menu</option>
                                                            <option value="1">Task</option>
                                                            <option value="2">Reports</option>
                                                            <option value="3">Maintain</option>
                                                            <option value="4">Main</option>
                                                        </select>

                                                        <div id="insmenuErrNotify"  hidden=""  class="text-danger"><small>Please Select Sub Menu</small></div>
                                                    </div>

                                                </div>

                                                <div class="row mb-3">
                                                    <label class="col-sm-2 col-form-label">Interface Name <label class="text-danger">*</label></label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="inname" name="inname" >

                                                        <div id="innameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Interface Name</small></div>
                                                    </div>

                                                    <label class="col-sm-2 col-form-label">Display Name <label class="text-danger">*</label></label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="indsname" name="indsname" >                                                            

                                                        <div id="indsnameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Display Name</small></div>
                                                    </div>

                                                </div>

                                                <div class="row mb-3">
                                                    <label class="col-sm-2 col-form-label">Interface URL <label class="text-danger">*</label></label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="inurl" name="inurl" >

                                                        <div id="inurlErrNotify"  hidden=""  class="text-danger"><small>Please Enter Interface URL </small></div>
                                                    </div>

                                                    <label class="col-sm-2 col-form-label">Interface Icon <label class="text-danger">*</label></label>
                                                    <div class="col-sm-4">
                                                        <input type="text" class="form-control" id="inicon" name="inicon" >                                                           

                                                        <div id="iniconErrNotify"  hidden=""  class="text-danger"><small>Please Enter Interface Icon</small></div>
                                                    </div>

                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-sm-12" align="right">
                                                        <button type="submit"   id= "empReg" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="saveNewinterface();">Save</button>
                                                    </div>
                                                </div>
                                            </div>               
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <br/>   <br/>
                            <!--System interface-->
                            <div class="card" id="create-new-interface" >

                                <div class="col-12 col-md-12 portlet-title ">
                                    <h5 class="fw-bold p-4 py-1 mt-3 text-primary"><span >All Interface</span></h5>
                                </div>

                                <div class="card-body">
                                    <div class="portlet light portlet-fit bordered">

                                        <div class="portlet-body">
                                            <div class="table-responsive text-nowrap">
                                                <table class="table table-hover" id="sample_1" >
                                                    <thead>
                                                        <tr>
                                                            <th>Interface Name</th>
                                                            <th>Display Name</th>
                                                            <th>Menu Name</th>
                                                            <th>Sub Menu Name</th>
                                                            <th>URL</th>
                                                            <th>Icon</th>
                                                            <th>Remove</th>
                                                            <th>Update</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tbody_data">
                                                        <%  int index = 0;
                                                            for (SystemInterface inf : SystemInterfaceDAO.listByQuery(sess, null, null)) {
                                                                index++;
                                                        %>
                                                        <tr id="row<%= inf.getSiId()%>">
                                                            <td onclick="setDetailsToUpdate('<%=inf.getSiId()%>')"><%=inf.getInterfaceName()%></td>
                                                            <td><%=inf.getDisplayName()%></td>
                                                            <td><%
                                                                if (inf.getInterfaceMenu() != null) {
                                                                    out.write(inf.getInterfaceMenu().getMenuName());
                                                                } else {
                                                                    out.write("N/A");
                                                                }
                                                                %></td>
                                                            <td><%
                                                                if (inf.getInterfaceSubMenu() != null) {
                                                                    out.write(inf.getInterfaceSubMenu().getName());
                                                                } else {
                                                                    out.write("N/A");
                                                                }
                                                                %></td>
                                                            <td><%=inf.getUrl()%></td>
                                                            <td> <i class="<%= inf.getIcon()%>"></i></td>
                                                            <td><button class="btn rounded-pill btn-outline-danger" onclick="removeInterface(<%= inf.getSiId()%>);">REMOVE</button></td>
                                                            <td><button class="btn rounded-pill btn-outline-info" onclick="showUpdateForm(<%= inf.getSiId()%>);">UPDATE</button></td>
                                                        </tr>
                                                        <%}%>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br/>   <br/>
                            <div id="ajaxselect" class="modal" tabindex="-1" data-backdrop="static" data-keyboard="false" style="width: 100%; margin: 0 auto; top: 5%; left: 0">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <div class="portlet-title">
                                            <div class="caption">
                                                <i class=" icon-layers font-green-soft"></i>
                                                <span class="caption-subject font-green-soft bold uppercase">Update Interface</span>
                                            </div>
                                        </div>
                                        <a href="" onclick="close();"  class="close" >x</a>
                                    </div>
                                    <div class="modal-body" id="ajaxviewselect">
                                        Loading...
                                    </div>
                                </div>
                            </div>
                            <!-- / Content -->
                        </div>
                        <!-- Content wrapper -->
                    </div>
                    <!-- / Layout page -->
                </div>
                <!-- Overlay -->  
            </div>
            <!-- / Layout wrapper -->
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

