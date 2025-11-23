<%@page import="Model.Logic.NotificationManagerDAO"%>
<%@page import="Model.Mapping.NotificationManager"%>
<%@page import="java.util.List"%>
<%@page import="Com.Tools.Security"%>
<%@page import="Model.Logic.UserCredentialRoleDAO"%>
<%@page import="Model.Mapping.UserCredentialRole"%>
<%@page import="Model.Logic.UserCredentialsDAO"%>
<%@page import="Model.Mapping.UserCredentials"%>
<%@page import="Model.Logic.ProjectsDAO"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Logic.CredentialCategoryDAO"%>
<%@page import="Model.Mapping.UserCredentialCategory"%>
<%@page import="Model.Logic.CredentialRolesDAO"%>
<%@page import="Model.Mapping.CredentialRoles"%>
<%@page import="Model.Mapping.UserCredentialType"%>
<%@page import="Model.Logic.CredentialTypeDAO"%>

<%@page import="Model.Mapping.UserLogin"%>
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

        <title>Exon Admin | All Credentials</title>

        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <script type="text/javascript" src="../assets/scripts/pages/credentialsJsAll.js"></script>

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
                                <span class="text-primary fw-light">All Credentials</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . All Credentials
                            </h6>

                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-12">
                                                <div class="card-body">

                                                    <div class="row mb-4">
                                                        <div style="align-content: center" class="col-sm-2">
                                                            <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Add Credential</label>
                                                        </div>
                                                        <div class="col-sm-8" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                                        <div class="col-sm-2"><button type="button" class="btn rounded-pill btn-outline-secondary" style="width: 100%" data-bs-toggle="modal" data-bs-target="#addCredentialModal">New</button></div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3">

                                                            <select   id="filter-company" class="filter form-select form-select-md" aria-label=".form-select-sm example">
                                                                <option  value="0">Select Credential Type</option>
                                                                <%                                                                            for (UserCredentialType type : CredentialTypeDAO.listByQuery(sess, null, null)) {
                                                                %>
                                                                <option value="<%=type.getName()%>"> <%=type.getName()%>  </option>
                                                                <% }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">

                                                            <select id="filter-contact" class="filter form-select form-select-md" aria-label=".form-select-sm example">
                                                                <option  value="0">Select Credential Category</option>
                                                                <%                                                                            for (UserCredentialCategory cat : CredentialCategoryDAO.listByQuery(sess, null, null)) {
                                                                %>
                                                                <option value="<%=cat.getName()%>"> <%=cat.getName()%>  </option>
                                                                <% }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <select  id="filter-range"  class="filter form-select form-select-md" aria-label=".form-select-sm example">
                                                                <option value="0">Select Project</option>
                                                                <%                                                                            for (Projects p : ProjectsDAO.listByQuery(sess, null, null)) {
                                                                        if (p.getIsActive()) {
                                                                %>
                                                                <option value="<%=p.getName()%>"> <%=p.getName()%>  </option>
                                                                <%   }
                                                                    }
                                                                %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-3">  

                                                            <button type="button" class="btn btn-primary"onclick="filter_function();" style="width: 100%">Search</button>
                                                        </div>
                                                        <div id="filterEmptyErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please select at least one filter.</small></div>
                                                    </div>
                                                    <div class="mt-4 mb-4">
                                                        <div style="float: left;">
                                                            <div class="navbar-nav align-items-center">
                                                                <div class="nav-item d-flex align-items-center">
                                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchAllCredential();">
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
                                                                <input class="form-check-input" type="checkbox" value="Active"  id="optionActive"   >
                                                                <label class="form-check-label">
                                                                    Active &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </label>
                                                            </span>
                                                            <span>
                                                                <input class="form-check-input" type="checkbox" value="Inactive" id="optionInactive" >
                                                                <label class="form-check-label">
                                                                    Inactive &nbsp;&nbsp;&nbsp;&nbsp;
                                                                </label>
                                                            </span>


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
                                                    </div>
                                                    <div class="row">
                                                        <div class="table-responsive text-nowrap" id="allCredentialDataDiv">

                                                            <table id="allCredentialTableList" class="table table-hover">

                                                                <thead class="sticky-header table-light" id="allCredentialHeader">
                                                                    <tr>
                                                                        <th scope="col">ID</th>
                                                                        <th scope="col">Type</th>
                                                                        <th scope="col">Category</th>
                                                                        <th scope="col">Project</th>
                                                                        <th scope="col">Username</th>
                                                                        <th scope="col">Role</th>
                                                                        <th scope="col">Status</th>
                                                                        <th scope="col">View</th>
                                                                        <th scope="col">Action</th>
                                                                    </tr>
                                                                </thead>

                                                                <tbody class="table-border-bottom-0" id="tableempbody">

                                                                    <%
                                                                        String row_color = "table-default";
                                                                        String badge_color = "badge bg-label-warning me-1";

                                                                        List<UserCredentials> uc = sess.createQuery("From UserCredentials").list();
                                                                        for (UserCredentials e : uc) {

                                                                            if (e.getIsActive() == Boolean.TRUE) { //Active
                                                                                row_color = "table-success";
                                                                                badge_color = "badge bg-label-success me-1";
                                                                            } else if (e.getIsActive() == Boolean.FALSE) {//Ongoing
                                                                                row_color = "table-danger";
                                                                                badge_color = "badge bg-label-danger me-1";
                                                                            }

                                                                    %>

                                                                    <tr class="<%=row_color%>">

                                                                        <td><%=e.getId()%> </td>
                                                                        <td class="company" data-company="<%=e.getUserCredentialType().getName()%>"><%=e.getUserCredentialType().getName()%></td>
                                                                        <td class="contact" data-contact="<%=e.getUserCredentialCategory().getName()%>"><%=e.getUserCredentialCategory().getName()%></td>
                                                                        <td class="range" data-range="<%=e.getProjects().getName()%>"><%=e.getProjects().getName()%></td>
                                                                        <td><%=e.getUsername()%></td>

                                                                        <td>                            <%
                                                                            String id = "" + e.getId();
                                                                            UserCredentialRole credR = (UserCredentialRole) sess.createQuery("From UserCredentialRole Where userCredentials.id='" + id + "'").setMaxResults(1).uniqueResult();
                                                                            %>
                                                                            <%=credR.getCredentialRoles().getName()%>  </td>



                                                                        <td class="status">  <span class="<%=badge_color%>">  
                                                                                <% if (e.getIsActive() == Boolean.TRUE) {
                                                                                %>
                                                                                Active
                                                                                <%
                                                                                } else {

                                                                                %>
                                                                                Inactive
                                                                                <%                                                            }

                                                                                %>
                                                                            </span></td>

                                                                        <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewCedentialData(<%=e.getId()%>);"></i></td>
                                                                            <% if (e.getIsActive() == Boolean.TRUE) {
                                                                            %>
                                                                        <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="credActiveInactive(<%=e.getId()%>, <%=e.getIsActive()%>);" id="activeButton">Inactive</button></td>  
                                                                        <%
                                                                        } else {

                                                                        %>
                                                                        <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="credActiveInactive(<%=e.getId()%>, <%=e.getIsActive()%>);" id="activeButton">Active</button></td>
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
                                                                                <button type="button" class="btn btn-outline-primary" onclick="loadAllCredentialRow()" id="allButton">All</button>
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

                                <!-- Total Revenue -->



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

        <!---------------------------Add Credential - Model---------------------------->                        
        <div class="modal fade" id="addCredentialModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Add New Credential</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>

                    <div class="modal-body">

                        <div class="row mb-3">

                            <label class="col-sm-4 col-form-label">Credential Type <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <select class="form-select" id="credType" name="credType">
                                    <option selected disabled value="">Select Credential Type</option>
                                    <%                                                                            for (UserCredentialType type : CredentialTypeDAO.listByQuery(sess, null, null)) {
                                    %>
                                    <option value="<%=type.getId()%>"> <%=type.getName()%>  </option>
                                    <% }
                                    %>
                                </select>

                                <div id="credTypeErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Select Credential Type</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-4 col-form-label">Credential Category <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <select class="form-select" id="credCategory" name="credCategory">

                                    <option selected disabled value="">Select Credential Category</option>
                                    <%                                                                            for (UserCredentialCategory cat : CredentialCategoryDAO.listByQuery(sess, null, null)) {
                                    %>
                                    <option value="<%=cat.getId()%>"> <%=cat.getName()%>  </option>
                                    <% }
                                    %>
                                </select>

                                <div id="credCategoryErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Select Credential Category</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-4 col-form-label">Credential Role <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <select class="form-select" id="credRole" name="credRole">

                                    <option selected disabled value="">Select Credential Role</option>
                                    <%                                                                            for (CredentialRoles role : CredentialRolesDAO.listByQuery(sess, null, null)) {
                                    %>
                                    <option value="<%=role.getId()%>"> <%=role.getName()%>  </option>
                                    <% }
                                    %>
                                </select>

                                <div id="credRoleErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Select Credential Role</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Project <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <select class="form-select" id="credProject" name="credProject">


                                    <option selected disabled value="">Select Project</option>
                                    <%                                                                            for (Projects p : ProjectsDAO.listByQuery(sess, null, null)) {
                                            if (p.getIsActive()) {

                                    %>
                                    <option value="<%=p.getId()%>"> <%=p.getName()%>  </option>
                                    <%    }
                                        }
                                    %>
                                </select>

                                <div id="credProjectErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Select Project</small></div>
                            </div>
                        </div> 

                        <div class="row mb-3">

                            <label class="col-sm-4 col-form-label">Username <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="credUsername" name="credUsername" aria-describedby="cred_username" placeholder="Enter Username">

                                <div id="credUsernameErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter User Name</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Password <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="credPassword" name="credPassword" aria-describedby="credPassword" placeholder="Enter Password">

                                <div id="credPasswordErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Password</small></div>
                            </div>
                        </div>

                        <div class="row mb-5">

                            <label class="col-sm-4 col-form-label">Note <label class="text-danger">*</label></label>

                            <div class="col-sm-8">
                                <textarea class="form-control" id="credNote" name="credNote" rows="3"></textarea>
                                <div id="credNoteErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Note</small></div>
                            </div>

                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" data-bs-dismiss="modal" aria-label="Close" style="width: 200px;">Cancel</button>
                                <button type="submit" id= "cred_add_btn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="addNewCredential(<%=(request.getSession().getAttribute("GUP_ID"))%>);">Save</button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>                      

        <!---------------------------View Credential - Model---------------------------->    
        <div class="modal fade" id="viewCedentialData" tabindex="-1" data-bs-backdrop='static' aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Credential Details</span></h4> 
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
                                <input class="form-control" type="text" id="credentialType" name="credentialType" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Category</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentialCategory" name="credentialCategory" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Role</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentialRole" name="credentialRole" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Project</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentialProject" name="credentialProject" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Status</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentialstatus" name="credentialstatus" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Username</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentialUsername" name="credentialUsername" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Last Edited By</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentiaLastEditBy" name="credentiaLastEditBy" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Created Date</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credentialCreateDate" name="credentialCreateDate" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Note</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" type="text" id="credentialNote" name="credentialNote" style="height: auto;" readonly></textarea>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

        <!---------------------------Edit Credential - Model---------------------------->    
        <div class="modal fade" id="editCredModel" tabindex="-1" aria-labelledby="editCred" data-bs-backdrop='static'  aria-hidden="true">
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

                            <label class="col-sm-2 col-form-label">Username  <label class="text-danger">*</label></label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="credUsernameEdit" name="credUsernameEdit" aria-describedby="credUsernameEdit">
                                <div id="credUsernameEditErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Username</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Password <label class="text-danger">*</label></label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="passwordEdit" name="passwordEdit" aria-describedby="passwordEdit" placeholder="Enter Password">

                                <div id="credPasswordEditErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Password</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Reason <label class="text-danger">*</label></label>

                            <div class="col-sm-10">
                                <textarea class="form-control" id="credNoteEdit" name="credNoteEdit" rows="3"></textarea>
                                <div id="credReasonErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Reason</small></div>
                            </div>

                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" data-bs-dismiss="modal" aria-label="Close" style="width: 200px;">Cancel</button>
                                <button type="submit" id= "cred_add_btn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="Credential_edit(<%=(request.getSession().getAttribute("GUP_ID"))%>);">Save</button>
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

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="deactivateTitle" style="display: hide;"><span class="text-primary fw-light">Credential Deactivation</span></h4> 
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="activateTitle" style="display: hide;"><span class="text-primary fw-light">Credential Activation</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3" id="deactivateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  deactivate  this  credential? <br><br>
                                If you deactivated this credential, password has to be updated by an admin. <br><br>
                                Do you want to continue?</p>
                        </div>

                        <div class="row mb-3" id="activateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  activate  this  credential? <br><br>
                                If you activated this credential, password has to be updated by an admin. <br><br>
                                Do you want to continue?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="deactiveCredId" name="deactiveCredId" readonly/>
                            <input class="form-control" id="deactiveStatusId" name="deactiveStatusId" readonly/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="credDeactivationClose();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="credActionSave();">Yes</button>
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
        var tableRows = document.querySelectorAll("#tableempbody tr");
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
        <!-- Core JS -->
        <!-- build:js assets/vendor/js/core.js -->
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
