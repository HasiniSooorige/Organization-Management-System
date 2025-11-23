<%-- 
    Document   : approve-claim-finance
    Created on : Sep 12, 2023, 1:15:50 PM
    Author     : Gimna Katugampala
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Mapping.Claims"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="java.util.List"%>
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

        <title>Exon Admin | Claim Manager</title>

        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!--Lightbox CDN-->
        <link rel="stylesheet"
              type="text/css"
              href="../assets/lightbox2/dist/css/lightbox.min.css">
        <script src=
                "../assets/lightbox2/dist/js/lightbox-plus-jquery.min.js">
        </script>

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

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />
        <link rel="stylesheet" href="../assets/css/projectStyles.css" />

        <!-- Page CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- SweetAlert JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
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


                        <!-- Content wrapper -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Finance - Approve Request Claims (Final Approval)</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Finance - Approve Request Claims </span>
                            </h6>
                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-12">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div style="float: left;">
                                                            <div class="navbar-nav align-items-start">
                                                                <div class="nav-item d-flex align-items-center">
                                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchFinClaims();">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-12 m-2">
                                                            <div class="table-responsive text-nowrap" id="finClaimDataDiv">
                                                                <table class="table table-hover" id="finClaimTable">
                                                                    <thead class="sticky-header table-light" id="finClaimHeader">
                                                                        <tr>
                                                                            <th scope="col">ID</th>
                                                                            <th scope="col">Date</th>
                                                                            <th scope="col">Employee Name</th>
                                                                            <th scope="col">Total Amount ( Rs. )</th>
                                                                            <th scope="col">Actions</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="finClaimBody">
                                                                        <%   int count = 1;
                                                                            List<Claims> cat_list = sess.createQuery("From Claims WHERE claim_status_id ='2' AND status ='1'").list();
                                                                            for (Claims c : cat_list) {
                                                                        %>

                                                                        <tr>
                                                                            <td> <%= count%></td>
                                                                            <%
                                                                                Date addedDate = c.getAddedDate();
                                                                                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                                                String formattedDate = dateFormat.format(addedDate);
                                                                            %>
                                                                            <td><%= formattedDate%></td>
                                                                            <%   List<Employee> cList = sess.createQuery("From Employee WHERE id = " + c.getEmployee().getId() + " ").list();

                                                                                for (Employee E : cList) {
                                                                            %>
                                                                            <td ><%= E.getGeneralUserProfile().getFirstName()%> <%=E.getGeneralUserProfile().getLastName()%> </td>
                                                                            <% }%>
                                                                            <td> <%= c.getTotalAmount()%></td>

                                                                            <td>
                                                                                <i  id="viewClaims" type="button" class="fa fa-eye" onclick="approveRequest1(<%=c.getId()%>);"></i>
                                                                            </td>
                                                                        </tr>


                                                                        <%  count++;
                                                                            }
                                                                        %>

                                                                    </tbody>
                                                                    <tfoot>
                                                                        <tr>
                                                                            <td colspan="5">
                                                                                <span style="float: left;">
                                                                                    <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                                    <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                                    <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                                    <button type="button" class="btn btn-outline-primary" onclick="loadFinClaims()" id="allButton">All</button>
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

                                <!-- Total Revenue -->
                            </div>

                        </div>
                    </div>
                    <!-- / Layout page -->
                </div>

                <!-- Overlay -->
                <div class="layout-overlay layout-menu-toggle"></div>
            </div>

        </div>
        <!-- / Layout wrapper -->
        <%
            UserLogin login = (UserLogin) request.getSession().getAttribute("user");

        %>
        <!--view claims--> 
        <div class="modal fade" id="requestClaims" tabindex="-1" aria-labelledby="viewCred" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Request Claim ID - <label id="exampleModalLabel" class="text-primary"></label></span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <table id="requestClaimTb1" class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">ID</th>
                                            <th scope="col">Date</th>
                                            <th scope="col">Amount</th>
                                            <th scope="col">Attachment</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-md-12 d-flex justify-content-end">
                                <div class="justify-content-end col-md-3"><label>Total Claim Amount :</label></div>
                                <div class="justify-content-end"><b><label id="totalAmount"></label></b></div>
                            </div>

                            <div class="row mb-3 mt-3">
                                <div class="col-sm-12" align="right">
                                    <button type="button" class="btn rounded-pill btn-success" style="width: 200px;" onclick="approvefc();" id="req_btn_approve_hac"><i class="fa fa-check"></i> Approve</button>
                                    <button type="button" class="btn rounded-pill btn-danger" style="width: 200px;" onclick="disapprovefc();" id="req_btn_disapprove_hac"><i class="fa fa-times"></i> Disapprove</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>  

        <!--Approve confirm Model-->
        <div class="modal fade" id="approveClaimfc" tabindex="-1" aria-labelledby="approveClaimfc" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Claim Request Approve</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p class="col-sm-12">Do  you  want  to  approve  this  claim?</p>
                            </div>

                            <div class="row mb-3 mt-3">
                                <div class="col-sm-12" align="right">
                                    <button type="button" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="approveCanceledfc();" id="req_btn_disapprove_hac">No</button>
                                    <button type="button" class="btn rounded-pill btn-primary col-sm-4" onclick="approveFIN(<%=login.getId()%>);" id="req_btn_approve_hac">Yes</button>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
        </div>   

        <!--Disapprove confirm Model-->
        <div class="modal fade" id="disapproveClaimfc" tabindex="-1" aria-labelledby="disapproveClaimfc" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Claim Request Disapprove</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <p class="col-sm-12">Do  you  want  to  Disapprove  this  claim?</p>
                            </div>

                            <div class="row mb-3 mt-3">
                                <div class="col-sm-12" align="right">
                                    <button type="button" class="btn rounded-pill btn-outline-primary col-sm-4"  onclick="disapproveCancel();" id="req_btn_approve_hac">No</button>
                                    <button type="button" class="btn rounded-pill btn-primary col-sm-4"  onclick="disapproveClaimFinance(<%=login.getId()%>);" id="req_btn_disapprove_hac">Yes</button>
                                </div>
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
        var tableRows = document.querySelectorAll("#finClaimBody tr");
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
        <script src="../assets/scripts/pages/ManageClaims.js"></script>

        <!-- Index JS -->
        <script src="../assets/js/index.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
