<%@page import="Model.Logic.CredentialTypeDAO"%>
<%@page import="Model.Mapping.UserCredentialType"%>
<%@page import="Model.Logic.NotificationManagerDAO"%>
<%@page import="Model.Mapping.NotificationManager"%>
<%@page import="java.util.List"%>
<%@page import="Model.Logic.CredentialCategoryDAO"%>
<%@page import="Model.Logic.CredentialRolesDAO"%>
<%@page import="Model.Mapping.UserCredentialCategory"%>
<%@page import="Model.Mapping.CredentialRoles"%>
<%@page import="Model.Logic.ProjectsDAO"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Logic.UserCredentialIssuingManagerDAO"%>
<%@page import="Model.Mapping.UserCredentialIssuingManager"%>
<%@page import="Model.Logic.UserCredentialRoleDAO"%>
<%@page import="Model.Mapping.UserCredentialRole"%>
<%@page import="Model.Logic.UserCredentialsDAO"%>
<%@page import="Model.Mapping.UserCredentials"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html
    lang="en"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="assets/"
    data-template="vertical-menu-template-free"
    >
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Credential Access Manager - Exon</title>
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <script type="text/javascript" src="../assets/scripts/pages/CredentialAccessManagerJs.js"></script>

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


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

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />
        <link rel="stylesheet" href="../assets/css/projectStyles.css" />

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <!-- Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.6.0/js/bootstrap.min.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>

        <link href="https://datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="https://datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="https://cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
        <script src="../assets/js/config.js"></script>

    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if (!(request.getSession().getAttribute("GUP_ID") == null)) {


    %>
    <body>
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
                            <h4 class="fw-bold py-1 mb-1">
                                <span class="text-primary fw-light">Credential Access Manager</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Credential Access Manager
                            </h6>

                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-12">
                                                <div class="card-body">

                                                    <div class="row mb-4">
                                                        <div style="align-content: center" class="col-sm-3">
                                                            <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Create Password Access</label>
                                                        </div>
                                                        <div class="col-sm-7" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                                        <div class="col-sm-2"><button type="button" class="btn rounded-pill btn-outline-secondary" style="width: 100%" data-bs-toggle="modal" data-bs-target="#addCredentialModal">Create</button></div>
                                                    </div>


                                                    <div class="row my-4">
                                                        <div class="col-md-3">

                                                            <select   id="filter-type" class="filtersecond form-select form-select-md" aria-label=".form-select-sm example">
                                                                <option  value="0">Select Credential Type</option>
                                                                <%                                                                            for (UserCredentialType type : CredentialTypeDAO.listByQuery(sess, null, null)) {
                                                                %>
                                                                <option value="<%=type.getName()%>"> <%=type.getName()%>  </option>
                                                                <% }
                                                                %>
                                                            </select>
                                                        </div>

                                                        <div class="col-md-3">

                                                            <select id="filter-cat" class="filtersecond form-select form-select-md" aria-label=".form-select-sm example">
                                                                <option  value="0">Select Credential Category</option>
                                                                <%                                                                            for (UserCredentialCategory cat : CredentialCategoryDAO.listByQuery(sess, null, null)) {
                                                                %>
                                                                <option value="<%=cat.getName()%>"> <%=cat.getName()%>  </option>
                                                                <% }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">

                                                            <select  id="filter-pro"  class="filtersecond form-select form-select-md" aria-label=".form-select-sm example">
                                                                <option value="0">Select Employee</option>
                                                                <%                                                                            for (Employee emp : EmployeeDAO.listByQuery(sess, null, null)) {

                                                                %>
                                                                <option value="<%=emp.getGeneralUserProfile().getFirstName()%> <%=emp.getGeneralUserProfile().getLastName()%>"> <%=emp.getGeneralUserProfile().getFirstName()%> <%=emp.getGeneralUserProfile().getLastName()%></option>
                                                                <% }
                                                                %>
                                                            </select>
                                                        </div>

                                                        <div class="col-md-3">  

                                                            <button type="button" style="width: 100%;" class="btn btn-primary"onclick="filter_functionsec();" >Search</button>
                                                        </div>
                                                        <div id="filterEmptydashbordErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please select at least one filter.</small></div>
                                                    </div>
                                                    <div class="mt-4 mb-4">
                                                        <div style="float: left;">
                                                            <div class="navbar-nav align-items-center">
                                                                <div class="nav-item d-flex align-items-center">
                                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchCredAccessMan();">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="filter" class="col-8 offset-4 text-end">

                                                            <label>Status: &nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                            <span>
                                                                <input class="form-check-input" type="checkbox" value="All"  id="all"  checked >
                                                                <label class="form-check-label">
                                                                    All &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </label>
                                                            </span>
                                                            <span>
                                                                <input class="form-check-input" type="checkbox" value="Active"  id="activeOption"  >
                                                                <input value="Active" id="inputlable" hidden="" readonly />
                                                                <label class="form-check-label" id="inputlable" for="pending">
                                                                    Active &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </label>
                                                            </span>
                                                            <span>
                                                                <input class="form-check-input" type="checkbox" value="Inactive" id=""  >
                                                                <label class="form-check-label" for="ongoing">
                                                                    Inactive &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </label>
                                                            </span>


                                                        </div>
                                                    </div>
                                                    <script>

                                                        $(document).ready(function () {
                                                            $("input:checkbox").on("change", function () {
                                                                var selectedValue = $(this).val();

                                                                // Uncheck other checkboxes
                                                                $("input:checkbox").not(this).prop("checked", false);

                                                                if ($("input:checkbox:checked").length === 0 || selectedValue === "All") {
                                                                    $(".status").parent().show();
                                                                } else {
                                                                    $(".status").parent().hide();
                                                                    $(".status:contains(" + selectedValue + ")").parent().show();
                                                                }
                                                            });
                                                        });
                                                    </script>



                                                    <div class="row">
                                                        <div class="col-md-12 m-2 table-responsive text-nowrap" id="credAccessManTableDataDiv">

                                                            <table class="tableFilter table table-hover" id="credAccessTableMngId">

                                                                <thead class="sticky-header table-light" id="credAccessManHeader">
                                                                    <tr>
                                                                        <th scope="col">ID</th>
                                                                        <th scope="col">Type</th>
                                                                        <th scope="col">Category</th>
                                                                        <th scope="col">Project</th>
                                                                        <th scope="col">Employee</th>
                                                                        <th scope="col">Role</th>
                                                                        <th scope="col">Status</th>
                                                                        <th scope="col">View</th>
                                                                        <th scope="col">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="credAccessManBody">
                                                                    <%
                                                                        String row_color = "table-default";
                                                                        String badge_color = "badge bg-label-warning me-1";

                                                                        for (UserCredentialIssuingManager e : UserCredentialIssuingManagerDAO.listByQuery(sess, null, null)) {

                                                                            if (e.getIsActive() == Boolean.TRUE) { //Active
                                                                                row_color = "table-success";
                                                                                badge_color = "badge bg-label-success me-1";
                                                                            } else if (e.getIsActive() == Boolean.FALSE) {//Ongoing
                                                                                row_color = "table-danger";
                                                                                badge_color = "badge bg-label-danger me-1";
                                                                            }
                                                                    %>

                                                                    <tr class="tabletr <%=row_color%>">

                                                                        <td><%=e.getId()%></td>
                                                                        <td class="type" data-type="<%=e.getUserCredentials().getUserCredentialType().getName()%>"><%=e.getUserCredentials().getUserCredentialType().getName()%></td>
                                                                        <td class="cat" data-cat="<%=e.getUserCredentials().getUserCredentialCategory().getName()%>"><%=e.getUserCredentials().getUserCredentialCategory().getName()%></td>
                                                                        <td><%=e.getUserCredentials().getProjects().getName()%></td>
                                                                        <td class="pro" data-pro="<%=e.getGeneralUserProfile().getFirstName()%> <%=e.getGeneralUserProfile().getLastName()%>"><%=e.getGeneralUserProfile().getFirstName()%> <%=e.getGeneralUserProfile().getLastName()%></td>
                                                                        <td>                           
                                                                            <%
                                                                                Integer id = e.getUserCredentials().getId();
                                                                                UserCredentialRole credR = (UserCredentialRole) sess.createQuery("From UserCredentialRole Where user_credentials_id='" + id + "'").setMaxResults(1).uniqueResult();
                                                                            %>
                                                                            <%=credR.getCredentialRoles().getName()%>  
                                                                        </td>
                                                                        <td class="status"> <span class="<%=badge_color%>">  
                                                                                <%  if (e.getIsActive() == Boolean.TRUE) {    %>
                                                                                Active
                                                                                <%       } else {  %>
                                                                                Inactive
                                                                                <%       }%>
                                                                            </span>
                                                                        </td>

                                                                        <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewCedentialAccessData(<%=e.getId()%>);"></i></td>
                                                                            <% if (e.getIsActive() == Boolean.TRUE) {
                                                                            %>
                                                                        <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="credAccessActiveInactive(<%=e.getId()%>, <%=e.getIsActive()%>);" id="activeButton">Inactive</button></td>  
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="credAccessActiveInactive(<%=e.getId()%>, <%=e.getIsActive()%>);" id="activeButton">Active</button></td>
                                                                        <%                                                            }

                                                                        %>
                                                                    </tr>

                                                                    <%                                                                        }

                                                                    %>   


                                                                </tbody>
                                                                <tfoot>
                                                                    <tr>
                                                                        <td colspan="9">
                                                                            <span style="float: left;">
                                                                                <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                                <button type="button" class="btn btn-outline-primary" onclick="loadCedAccessManRows()" id="allButton">All</button>
                                                                            </span>

                                                                            <span style="float: right;">
                                                                                <nav aria-label="Page navigation">
                                                                                    <ul class="pagination" id="pagination"></ul>
                                                                                </nav>
                                                                            </span>
                                                                        </td>
                                                                    </tr>
                                                                </tfoot>
                                                            </table>

                                                        </div>

                                                    </div>

                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- / Content -->
                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                </div>
                <!-- / Layout page -->
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>
        <!-- / Layout wrapper -->




        <!------------------------ Modals - Create Password Access --------------------------------->
        <div class="modal fade" id="addCredentialModal" tabindex="-1" aria-labelledby="addCredentialModal" data-bs-backdrop='static' aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Create Password Access</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>

                    <div class="modal-body">

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Create Access By</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="credEmpinptAceess" value="<%=request.getSession().getAttribute("user_name")%>" name="credEmpinptAceess" readonly>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Select Employee</label>
                            <div class="col-sm-9">
                                <select class="form-select" name="empAcessiD" id="empAcessiD">
                                    <option selected disabled value="">Select Employee</option>
                                    <%                                                                            for (Employee emp : EmployeeDAO.listByQuery(sess, null, null)) {
                                            if (emp.getIsActive() == Boolean.TRUE) {
                                    %>
                                    <option value="<%=emp.getGeneralUserProfile().getId()%>"> <%=emp.getGeneralUserProfile().getFirstName()%> <%=emp.getGeneralUserProfile().getLastName()%> - <%=emp.getDesignation().getName()%> </option>
                                    <% }
                                        }
                                    %>
                                </select>

                                <div id="credselectEmpErrorNotify"  hidden=""  class="alert-box error text-danger"><small>Please Select Employee</small></div>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div style="align-content: center" class="col-sm-3">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Credential List</label>
                            </div>
                            <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                        </div>

                        <div class="col-md-12">
                            <div class="row my-3">
                                <div class="col-md-3">

                                    <select   id="filter-company" class="filterPswTable form-select form-select-md" aria-label=".form-select-sm example">
                                        <option  value="0">Select Credential Type</option>
                                        <%                                                                            for (UserCredentialType type : CredentialTypeDAO.listByQuery(sess, null, null)) {
                                        %>
                                        <option value="<%=type.getName()%>"> <%=type.getName()%>  </option>
                                        <% }
                                        %>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <select id="filter-contact" class="filterPswTable form-select form-select-md" aria-label=".form-select-sm example">
                                        <option  value="0">Select Credential Category</option>
                                        <%                                                                            for (UserCredentialCategory cat : CredentialCategoryDAO.listByQuery(sess, null, null)) {
                                        %>
                                        <option value="<%=cat.getName()%>"> <%=cat.getName()%>  </option>
                                        <% }
                                        %>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <select  id="filter-range"  class="filterPswTable form-select form-select-md" aria-label=".form-select-sm example">
                                        <option value="0">Select Project</option>
                                        <%                                                                            for (Projects p : ProjectsDAO.listByQuery(sess, null, null)) {

                                        %>
                                        <option value="<%=p.getName()%>"> <%=p.getName()%>  </option>
                                        <%  }
                                        %>
                                    </select>
                                </div>

                                <div class="col-md-3">  
                                    <button type="button" style="width: 100%;" class="btn btn-primary"onclick="filterCreateModel();" >Search</button>
                                </div>
                                <div id="filterEmptyErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please select at least one filter.</small></div>
                            </div>        

                            <table id="accessTable" class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Action</th>
                                        <th scope="col">Type</th>
                                        <th scope="col">Category</th>
                                        <th scope="col">Role</th>
                                        <th scope="col">Project</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        for (UserCredentials e : UserCredentialsDAO.listByQuery(sess, null, null)) {
                                            if (e.getIsActive() == Boolean.TRUE) {

                                    %>

                                    <tr class="tabletrSecond">
                                        <td><input class="form-check-input" name="type"  type="checkbox" value="<%=e.getId()%>" id="flexCheckDefault" name="flexCheckDefault"></td> 
                                        <td class="company" data-company="<%=e.getUserCredentialType().getName()%>"><%=e.getUserCredentialType().getName()%> </td>
                                        <td class="contact" data-contact="<%=e.getUserCredentialCategory().getName()%>"><%=e.getUserCredentialCategory().getName()%></td>
                                        <td>                            
                                            <%
                                                Integer id = e.getId();
                                                UserCredentialRole credR = (UserCredentialRole) sess.createQuery("From UserCredentialRole Where user_credentials_id='" + id + "'").setMaxResults(1).uniqueResult();
                                            %>
                                            <%=credR.getCredentialRoles().getName()%>  
                                        </td>
                                        <td class="range" data-range="<%=e.getProjects().getName()%>"><%=e.getProjects().getName()%></td>
                                    </tr>
                                    <%
                                            }
                                        }

                                    %>
                                </tbody>
                            </table>
                            <div id="arrayEmptyErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please select at least one credential.</small></div>

                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" data-bs-dismiss="modal" aria-label="Close" style="width: 200px;">Cancel</button>
                                <button type="submit" id= "cred_add_btn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="giveCredentialsAccess(<%=request.getSession().getAttribute("GUP_ID")%>);">Save</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!------------------------ Modals - View Credential--------------------------------->
        <div class="modal fade" id="viewCredAccessModel" tabindex="-1" aria-labelledby="viewCred" data-bs-backdrop='static' aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Credential Access Data</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>


                    <div class="modal-body">


                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Type</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="typeSpanAc" name="typeSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Category</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credCatSpanAc" name="credCatSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Role</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="roleSpanAc" name="roleSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Project</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="projectSpanAc" name="projectSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Status</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="statusSpanAc" name="statusSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Employee</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="employeeSpanAc" name="employeeSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Employee Status</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="empStatusSpanAc" name="empStatusSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">View Status</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="viewedSpanAc" name="viewedSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Assigned Date</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="assignedSpanAc" name="assignedSpanAc" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Last Updated Date</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="lastDateSpanAc" name="lastDateSpanAc" readonly/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!---------------------------Active/ Inactive Credential - Model---------------------------->   
        <div class="modal fade" id="credActiveInactiveModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="deactivateTitle" style="display: hide;"><span class="text-primary fw-light">Credential Access Deactivation</span></h4> 
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="activateTitle" style="display: hide;"><span class="text-primary fw-light">Credential Access Activation</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3" id="deactivateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  deactivate  this  credential access? <br><br>
                                If you deactivated this credential, password has to be updated by an admin. <br><br>
                                Do you want to continue?</p>
                        </div>

                        <div class="row mb-3" id="activateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  activate  this  credential access? <br><br>
                                If you activated this credential, password has to be updated by an admin. <br><br>
                                Do you want to continue?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="deactiveCredId" name="deactiveCredId" readonly/>
                            <input class="form-control" id="deactiveStatusId" name="deactiveStatusId" readonly/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="credAccessDeactivationClose();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="credAccessActionSave();">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div> 


        <!---------------------------Edit Credential (AFTER ACTIVE/INACTIVE) - Model---------------------------->  
        <div class="modal fade" id="editCredAfterInactiveModel" tabindex="-1" aria-labelledby="editCred" data-bs-backdrop='static'  aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Edit Credential Access</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>

                    <div class="modal-body">

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Username <label class="text-danger">*</label></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="credUsernameEditIn" name="credUsernameEditIn">
                                <div id="credUsernameEditErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Username</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Password <label class="text-danger">*</label></label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="passwordEditIn" name="passwordEditIn">
                                <div id="credPasswordEditErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Password</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Reason <label class="text-danger">*</label></label>
                            <div class="col-sm-10">
                                <textarea class="form-control" id="credNoteEditIn" name="credNoteEditIn" rows="3"></textarea>
                                <div id="credReasonErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Reason</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Edited By</label>
                            <div class="col-sm-10">
                                <input class="form-control" id="credEmpinptEditIn" name="credEmpinptEditIn" value="<%=request.getSession().getAttribute("user_name")%>" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" data-bs-dismiss="modal" aria-label="Close" style="width: 200px;">Cancel</button>
                                <button type="submit" id= "cred_add_btn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="credAccessEdit(<%=(request.getSession().getAttribute("GUP_ID"))%>)">Save</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

                            
                                <script>
//       ----- Pagination  -----
        var currentPage = 1;
        var pageSize = 10;
        var tableRows = document.querySelectorAll("#credAccessManBody tr");
        var totalPages = Math.ceil(tableRows.length / pageSize);

        function updatePagination() {
            var pagination = document.getElementById("pagination");
            pagination.innerHTML = "";

            if (totalPages <= 1) {
                return;
            }

            var maxPageLinks;

            if (pageSize === 10) {
                maxPageLinks = 100;
            } else if (pageSize === 25) {
                maxPageLinks = 40;
            } else if (pageSize === 50) {
                maxPageLinks = 20;
            }

            var startPage = Math.max(1, currentPage - Math.floor(maxPageLinks / 2));
            var endPage = Math.min(totalPages, startPage + maxPageLinks - 1);

            if (endPage - startPage < maxPageLinks - 1) {
                startPage = Math.max(1, endPage - maxPageLinks + 1);
            }

            for (var i = startPage; i <= endPage; i++) {
                var li = document.createElement("li");
                li.className = "page-item";
                var a = document.createElement("a");
                a.className = "page-link";
                a.href = "javascript:void(0);";
                a.innerText = i;
                a.onclick = function () {
                    currentPage = parseInt(this.innerText);
                    updateTable();
                };
                li.appendChild(a);
                pagination.appendChild(li);
            }
        }

        function updateTable() {
            var startIndex = (currentPage - 1) * pageSize;
            var endIndex = currentPage * pageSize;

            tableRows.forEach(function (row, index) {
                if (index >= startIndex && index < endIndex) {
                    row.style.display = "table-row";
                } else {
                    row.style.display = "none";
                }
            });

            updatePagination();
        }

        function setPageSize(size) {
            pageSize = size;
            currentPage = 1;
            totalPages = Math.ceil(tableRows.length / pageSize);
            updateTable();

            var buttons = document.querySelectorAll('.page-size');
            buttons.forEach(function (button) {
                if (button.getAttribute('data-size') === size.toString()) {
                    button.classList.add('active');
                } else {
                    button.classList.remove('active');
                }
            });
        }

        updateTable();
    </script>

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

        <script src="../assets/vendor/js/menu.js"></script>
        <!-- endbuild -->

        <!-- Vendors JS -->
        <script src="../assets/vendor/libs/apex-charts/apexcharts.js"></script>

        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>

        <!-- Page JS -->
        <script src="../assets/js/dashboards-analytics.js"></script>

        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>







