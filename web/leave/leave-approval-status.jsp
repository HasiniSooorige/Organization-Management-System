<%-- 
    Document   : projectList
    Created on : Aug 19, 2023, 3:53:18 PM
    Author     : HP
--%>
<%@page import="Model.Mapping.LeaveType"%>
<%@page import="Model.Logic.LeaveDAO"%>
<%@page import="Model.Mapping.LeaveRequest"%>
<%@page import="Model.Logic.ProjectEmployeeRoleDAO"%>
<%@page import="Model.Mapping.ProjectEmployeeRole"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Logic.StatusDAO"%>
<%@page import="Model.Mapping.Status"%>
<%@page import="Model.Logic.ProjectsDAO"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Mapping.UserLogin"%>
<!DOCTYPE html>
<html lang="en"
      class="light-style layout-menu-fixed"
      dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />

        <title>Exon Admin | Leave Manager</title> 

        <meta name="description" content="" />
        <!-- jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>




        <link rel="stylesheet" href="../assets/css/projectStyles.css" type="text/css"/>

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

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

        <!-- Page CSS -->

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>
        <script src="../assets/scripts/pages/ApproveLeaveMng.js"></script>


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


    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if (!(request.getSession().getAttribute("GUP_ID") == null)) {
    %>
    <body onload=" performFiltering();">
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- / Menu -->
                <%@include  file="../main-pages/includes/admin-panel.jsp" %>
                <!-- / Menu -->
                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@include file="../main-pages/includes/header.jsp" %>
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">

                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Leave Approval Sheet </span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Maintain . Leave Approval Sheet</span>
                            </h6>

                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4">
                                    <div class="card-body" id ="tableDiv">

                                        <div>
                                            <div class="navbar-nav align-items-start">
                                                <div class="nav-item d-flex align-items-center">
                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchLeaveApproveTable();">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="table-responsive text-nowrap" id="leaveApproveTableData">
                                            <table id="table_projects"  class="table">
                                                <thead class="sticky-header table-light" id="approveHisHeader">
                                                    <tr>
                                                        <th>Id</th>
                                                        <th >Name</th>
                                                        <th>Requested Date</th>
                                                        <th>Category</th>
                                                        <th>Reason</th>
                                                        <th>Date From</th>
                                                        <th>Date To</th>
                                                        <th>Leave Type</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>

                                                <tbody class="table-border-bottom-0" id="tableempbody">

                                                    <%                                                        int table_row_id = 0;
                                                        for (LeaveRequest e : LeaveDAO.listByQuery(sess, null, null)) {

                                                            if (e.getLeaveApprovalStatus().getId() == 1) {
                                                                table_row_id++;
                                                    %>
                                                    <tr>
                                                        <td><%=table_row_id%> </td>
                                                        <td><%=e.getEmployeeByEmployeeId().getGeneralUserProfile().getFirstName()%> <%=e.getEmployeeByEmployeeId().getGeneralUserProfile().getLastName()%> </td>
                                                        <td><%=e.getRequestedDate()%></td>
                                                        <td><%=e.getReason()%></td>
                                                        <td><%=e.getComment()%></td> 
                                                        <td><%=e.getDateFrom()%></td> 
                                                        <td><%=e.getDateTo()%></td>  
                                                        <td><%= e.getLeaveType().getName()%></td> 
                                                        <td><button  class="btn rounded-pill btn-outline-success" onclick="approveAction(<%=e.getId()%>);" >Approve</button>
                                                            <button  class="btn rounded-pill btn-outline-danger" onclick="declineAction(<%=e.getId()%>);" >Decline</button></td>
                                                    </tr>
                                                    <%                                                                                                      }
                                                        }
                                                    %>
                                                </tbody>
                                                <tfoot id="tableFootTr">
                                                    <tr>
                                                        <td colspan="9">
                                                            <span style="float: left;">
                                                                <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                <button type="button" class="btn btn-outline-primary" onclick="loadLeaveApprove()" id="allButton">All</button>
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
                    <!-- Content wrapper -->
                </div>
                <!-- / Layout page -->
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>


        <!--================================Model - Leave Approve start==================================-->

        <div class="modal fade" id="approveLeaveModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Leave Approve</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">Do  you  want  to  approve  this  leave request?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="leaveId" name="leaveId" readonly hidden/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" data-bs-dismiss="modal">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="approveLeaveStatus(<%=user.getId()%>);">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--================================Model - Leave Approve end==================================-->

        <!--================================Model - Leave Declined start==================================-->

        <div class="modal fade" id="declinedLeaveModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Leave Decline</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">Do  you  want  to  decline  this  leave request?</p>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Reason </label>
                            <div class="col-sm-10">
                                <textarea style="height: 150px; resize: none;"
                                          class="form-control"
                                          type="text"
                                          id="reason"
                                          name="reason"></textarea>
                            </div>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="leaveId" name="leaveId" readonly hidden/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" data-bs-dismiss="modal">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="declineLeaveStatus(<%=user.getId()%>);">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--================================Model - Leave Declined end==================================-->


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

        <!-- / Layout wrapper -->
        <!-- build:js assets/vendor/js/core.js -->
        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <!--<script src="multiselect.min.js"></script>-->

        <script src="../assets/vendor/js/menu.js"></script>
        <!-- endbuild -->

        <!-- Vendors JS -->

        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

        <!-- Page JS -->
        <script src="../assets/js/pages-account-settings-account.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>

    </body>
    <%         } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
