<%@page import="Model.Mapping.UserCredentialViewRequest"%>
<%@page import="java.util.List"%>
<%@page import="Model.Logic.UserCredentialIssuingManagerDAO"%>
<%@page import="Model.Mapping.UserCredentialIssuingManager"%>
<%@page import="Model.Mapping.UserCredentialRole"%>
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

        <title>Employee View Credentials - Exon</title>
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <script type="text/javascript" src="../assets/scripts/pages/EmpViewCredentials.js"></script>

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
            if (!(request.getSession().getAttribute("Emp_GUP") == null)) {


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
                                <span class="text-primary fw-light">Employee View Credentials</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Employee View Credentials
                                </span>
                            </h6>

                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div style="float: left;">
                                                <div class="navbar-nav align-items-start mx-4 mt-3">
                                                    <div class="nav-item d-flex align-items-center">
                                                        <i class="bx bx-search fs-4 lh-0"></i>
                                                        <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchEmpViewCredTable();">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-12">

                                                <div class="card-body">

                                                    <div class="table-responsive text-nowrap" id="empViewCredTableDataDiv">
                                                        <table class="table table-hover">
                                                            <thead class="sticky-header table-light" id="empViewCredHeader">
                                                                <tr>
                                                                    <th scope="col">Project</th>
                                                                    <th scope="col">Role</th>
                                                                    <th scope="col">Type</th>
                                                                    <th scope="col">Category</th>
                                                                    <th scope="col">View Status</th>
                                                                    <th scope="col">View</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="empViewCredBody">


                                                                <%                                                Object gupId = request.getSession().getAttribute("Emp_GUP");
                                                                    Integer logingupId = (Integer) gupId;

                                                                    List<UserCredentialIssuingManager> list = sess.createQuery("From UserCredentialIssuingManager Where employee_id='" + logingupId + "'").list();

                                                                    for (int i = 0; i < list.size(); i++) {

                                                                        String row_color = "table-default";
                                                                        String badge_color = "badge bg-label-warning me-1";

                                                                        if (list.get(i).getFirstTimeViewed() == Boolean.FALSE && list.get(i).getIsChanged() == Boolean.FALSE) { //no viewed // no request
                                                                            row_color = "table-success";
                                                                            badge_color = "badge bg-label-success me-1";
                                                                        } else if (list.get(i).getFirstTimeViewed() == Boolean.TRUE && list.get(i).getIsChanged() == Boolean.FALSE) { //viewed //no request
                                                                            row_color = "table-default";
                                                                            badge_color = "badge bg-label-primary me-1";
                                                                        } else if (list.get(i).getFirstTimeViewed() == Boolean.TRUE && list.get(i).getIsChanged() == Boolean.TRUE) {
                                                                            row_color = "table-info";
                                                                            badge_color = "badge bg-label-info me-1";
                                                                        }

                                                                        if (list.get(i).getIsResigned() == Boolean.FALSE) {
                                                                %>

                                                                <tr class=" <%=row_color%>">
                                                                    <td><%=list.get(i).getUserCredentials().getProjects().getName()%> </td>
                                                                    <td>                            
                                                                        <%
                                                                            Integer id = list.get(i).getUserCredentials().getId();
                                                                            UserCredentialRole credR = (UserCredentialRole) sess.createQuery("From UserCredentialRole Where user_credentials_id='" + id + "'").setMaxResults(1).uniqueResult();
                                                                        %>
                                                                        <%=credR.getCredentialRoles().getName()%>  
                                                                    </td>
                                                                    <td><%=list.get(i).getUserCredentials().getUserCredentialType().getName()%></td>
                                                                    <td><%=list.get(i).getUserCredentials().getUserCredentialCategory().getName()%></td>
                                                                    <td class="status"> <span class="<%=badge_color%>">  
                                                                            <%  if (list.get(i).getFirstTimeViewed() == Boolean.FALSE && list.get(i).getIsChanged() == Boolean.FALSE) {    %>
                                                                            Not Viewed
                                                                            <%       } else if (list.get(i).getFirstTimeViewed() == Boolean.TRUE && list.get(i).getIsChanged() == Boolean.FALSE) {  %>
                                                                            Viewed
                                                                            <%       } else if (list.get(i).getFirstTimeViewed() == Boolean.TRUE && list.get(i).getIsChanged() == Boolean.TRUE) {  %>
                                                                            Requested

                                                                            <%
                                                                                }
                                                                            %>
                                                                        </span>
                                                                        <%
                                                                            if (list.get(i).getFirstTimeViewed() == Boolean.TRUE && list.get(i).getIsChanged() == Boolean.TRUE) {
                                                                                Integer isuMngrId = list.get(i).getId();
                                                                                UserCredentialViewRequest userCredVR1 = (UserCredentialViewRequest) sess.createQuery("From UserCredentialViewRequest Where user_credential_issuing_manager_id='" + isuMngrId + "'").setMaxResults(1).uniqueResult();
                                                                                List<UserCredentialViewRequest> userCredVR = sess.createQuery("From UserCredentialViewRequest Where user_credential_issuing_manager_id='" + isuMngrId + "'").list();
                                                                                Integer reqStataus = 1;
                                                                                if (!userCredVR.isEmpty()) {
                                                                                    for (int y = 0; y < userCredVR.size(); y++) {
                                                                                        if (userCredVR.get(y).getIsActive() == Boolean.TRUE) {
                                                                                            reqStataus = 1;
                                                                                        } else {
                                                                                            reqStataus = 0;
                                                                                        }
                                                                                    }
                                                                                }

                                                                                if (reqStataus == 1) {  %>
                                                                        <span class="badge bg-label-warning me-1">Pending</span>
                                                                        <% } else {  %>
                                                                        <span class="badge bg-label-danger me-1">Rejected</span>
                                                                        <%  }

                                                                            }%>
                                                                    </td>
                                                                    <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewCedentialEmployeeAccessData(<%=list.get(i).getId()%>);"></i></td>
                                                                </tr>

                                                                <%
                                                                        }
                                                                    }

                                                                %>   
                                                            </tbody>
                                                            <tfoot>
                                                                <tr>
                                                                    <td colspan="6">
                                                                        <span style="float: left;">
                                                                            <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                            <button type="button" class="btn btn-outline-primary" onclick="loadEmpViewCredRows()" id="allButton">All</button>
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



        <!-- Modals - View Employee Access Credential Details-->
        <div class="modal fade" id="viewCedentialEmployeeAccessData" tabindex="-1" aria-labelledby="viewEmpCred" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Employee Access Credential Details</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>

                    <!-- 1st Time View //not viewed --> 
                    <div id="first_time_request" class="modal-body">

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Type</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="typeSpanEmp" name="typeSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Category</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="catSpanEmp" name="catSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Role</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="roleSpanEmp" name="roleSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Project</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="projectSpanEmp" name="projectSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Date Created</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="createDateSpanEmp" name="createDateSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Username</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="usernameSpanEmp" name="usernameSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Password</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="passwordSpanEmp" name="passwordSpanEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Note</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="noteSpanEmp" name="noteSpanEmp" readonly/>
                            </div>
                        </div>

                    </div>


                    <!--After 1st Time view // viewed --> 
                    <div id="next_time_request" class="modal-body">

                        <div class="max-auto">
                            <div class="text-center">
                                <h4>You are Allowed Only to View the Credentials Once</h4>
                                <p>If You Want You Can Request to See the Credential one more time</p>
                            </div>
                            <div class="row mb-3" hidden>
                                <label class="col-sm-4 col-form-label">Id</label>
                                <div class="col-sm-8">
                                    <input class="form-control" type="text" id="forcredentialId" name="forcredentialId" readonly/>
                                </div>
                            </div>
                            <div class="row mb-5" id="requestbtndiv">
                                <div class="col-sm-12 mt-3" align="center">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" data-bs-dismiss="modal" aria-label="Close" style="width: 200px;">Cancel</button>
                                    <button type="submit" id="requestbtn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="requestEmpAccessCredential();">Send Request</button>
                                </div>
                            </div>

                            <!--// viewed // requested // request pending-->
                            <div class="row mb-3" id="requestPending">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-10 mt-3" align="center" style="font-size: 20px; border: 2px #ff9933 solid; color: #ff9933;">
                                    Your Credential View Request is Pending Admin Approval.
                                </div>
                                <div class="col-sm-1"></div>
                            </div>

                            <!--// viewed // requested // request denied-->
                            <div class="row mb-3" id="requestDenied">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-10 mt-3" align="center" style="font-size: 20px; border: 2px #ff0000 solid; color: #ff0000;">
                                    Your View Request has been Rejected by the Admin.
                                </div>
                                <div class="col-sm-1"></div>
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
            var tableRows = document.querySelectorAll("#empViewCredBody tr");
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
    <%            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
