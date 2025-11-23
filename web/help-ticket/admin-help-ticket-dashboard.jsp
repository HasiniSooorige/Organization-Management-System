<%-- 
    Document   : admin-help-ticket-dashboard
    Created on : Jan 8, 2024, 3:51:46 PM
    Author     : HP
--%>

<%@page import="Model.Mapping.GeneralUserProfile"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Logic.HelpTicketDAO"%>
<%@page import="Model.Logic.HelpTicketStatusDAO"%>
<%@page import="Model.Mapping.HelpTicketStatus"%>
<%@page import="Model.Mapping.HelpTicket"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html    lang="en"
         class="light-style layout-menu-fixed"
         dir="ltr"
         data-theme="theme-default"
         data-assets-path="../assets/"
         data-template="vertical-menu-template-free"
         >
    <head>
        <meta charset="utf-8" />
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Exon Admin | Ticket Dashboard</title>

        <meta name="description"/>
        <!-- Canonical SEO -->
        <link rel="canonical" href="https://themeselection.com/products/sneat-bootstrap-html-admin-template/">

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet">

        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

        <script type="text/javascript" src="../assets/scripts/pages/HelpTicketManager.js"></script>

        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <!-- Page CSS -->

        <!-- Flatpicker for date picker -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">


        <!-- Flatpicker -->
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>


        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>

        <link href="//datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="//datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="//cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <!--<script src="../assets/scripts/pages/ticketpage.js"></script>-->

        <link rel="stylesheet" href="../assets/css/projectStyles.css" type="text/css"/>

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
                                    Help Ticket Manager</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Maintain . Help Ticket Manager
                            </h6>

                            <!--date Search Section -->
                            <div class="row">
                                <div class="col-lg-12 mb-4">
                                    <div class="row">
                                        <div class="col-lg-1">
                                            <label class="col-form-label">Date From</label>
                                        </div>
                                        <div class="col-lg-3">
                                            <input type="date" class="form-control" placeholder="YYYY-MM-DD" id="fromDate" onchange="enableToDate()"/>
                                            <div id="fromDateError"  hidden=""  class="alert-box error text-danger"><small>Please Enter Date</small></div>
                                        </div>
                                        <div class="col-lg-1"></div>
                                        <div class="col-lg-1">
                                            <label class="col-form-label">Date To</label>
                                        </div>
                                        <div class="col-lg-3">
                                            <input type="date" class="form-control" placeholder="YYYY-MM-DD" id="toDate" disabled />
                                            <div id="toDateError"  hidden=""  class="alert-box error text-danger"><small>Please Enter Date</small></div>
                                        </div>
                                        <div class="col-lg-1"></div>
                                        <div class=" col-lg-2">
                                            <button class="form-control btn btn-primary" onclick="ticketSearchbyDate();">Search</button>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- Table -->
                            <div class="row">
                                <div class="card mb-4">
                                    <div class="col-12 offset-12 mt-3 mb-3">
                                        <div style="float: left;">
                                            <div class="navbar-nav align-items-center">
                                                <div class="nav-item d-flex align-items-center">
                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                    <input type="text" id="searchInput" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchHelpTicket()">
                                                </div>
                                            </div>
                                        </div>
                                        <div style="float: right">
                                            <label>Status: &nbsp;&nbsp;&nbsp;&nbsp;</label>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="all" onclick="filterHelpTicketTable();" checked>
                                                <label class="form-check-label" for="all">
                                                    All &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="pending" onclick="filterHelpTicketTable();">
                                                <label class="form-check-label" for="pending">
                                                    Pending &nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="ongoing" onclick="filterHelpTicketTable();">
                                                <label class="form-check-label" for="ongoing">
                                                    Ongoing &nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="solved" onclick="filterHelpTicketTable();">
                                                <label class="form-check-label" for="solved">
                                                    Solved &nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="closed" onclick="filterHelpTicketTable();">
                                                <label class="form-check-label" for="closed">
                                                    Closed &nbsp;&nbsp;
                                                </label>
                                            </span>
                                        </div>
                                    </div>     

                                    <div class="table-responsive text-nowrap" id="tableHelpTicketDataDiv">
                                        <table class="table" id="ticketTable">
                                            <thead id="tbleTicketHeader" class="sticky-header">
                                                <tr>
                                                    <th>Ticket No</th>
                                                    <th>Requested Date</th>
                                                    <th>Requested By</th>
                                                    <th>Ticket Category</th>
                                                    <th>Request Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody class="table-border-bottom-0" id="helpTicketTableBody">
                                                <%                                                    for (HelpTicket ticket : HelpTicketDAO.listByQuery(sess, null, null)) {

                                                        String row_color = "table-default";
                                                        String badge_color = "badge bg-label-warning me-1";

                                                        if (ticket.getHelpTicketStatus().getId() == 1) {//Pending
                                                            row_color = "table-default";
                                                            badge_color = "badge bg-label-warning me-1";
                                                        } else if (ticket.getHelpTicketStatus().getId() == 2) {//Ongoing
                                                            row_color = "table-info";
                                                            badge_color = "badge bg-label-info me-1";
                                                        } else if (ticket.getHelpTicketStatus().getId() == 3) {//Solved
                                                            row_color = "table-success";
                                                            badge_color = "badge bg-label-success me-1";
                                                        } else if (ticket.getHelpTicketStatus().getId() == 4) {//Closed
                                                            row_color = "table-danger";
                                                            badge_color = "badge bg-label-danger me-1";
                                                        }
                                                %>

                                                <tr class="<%=row_color%>">
                                                    <td><%=ticket.getTicketId()%></td>
                                                    <td><%= Com.getDate(ticket.getEnteredDate())%></td>
                                                    <td><%=ticket.getRequestedBy().getFirstName()%> <%=ticket.getRequestedBy().getLastName()%></td>
                                                    <td><%=ticket.getHelpTicketCategory().getName()%></td>
                                                    <td><span class="<%=badge_color%>"><%=ticket.getHelpTicketStatus().getName()%></span></td>
                                                    <td>
                                                        <a class="btn rounded-pill btn-outline-success" href="admin-ticket-view.jsp?tid=<%=ticket.getId()%>" target="_blank" id="<%=ticket.getTicketId()%>">View</a>
                                                    </td>
                                                </tr>
                                                <%
                                                    }

                                                %>
                                            </tbody>
                                            <tfoot>
                                                <tr  id="helpTicketTableFootTr">
                                                    <td colspan="6">
                                                        <span class="page-size-buttons" style="float: left;">
                                                            <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                            <button type="button" class="btn btn-outline-primary" onclick="loadAllTicketRows()" id="allButton">All</button>
                                                        </span>

                                                        <span class="page-navigation" style="float: right;">
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

                        <!-- / Content -->
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


        <script>
            //       ----- Pagination  OnLoad-----
            var currentPage = 1;
            var pageSize = 10;
            var tableRows = document.querySelectorAll("#helpTicketTableBody tr");
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


        <script src="../assets/scripts/pages/ticketpage.js"></script>

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

        <script src="../assets/vendor/js/menu.js"></script>
        <!-- endbuild -->

        <!-- Vendors JS -->
        <script src="../assets/vendor/libs/apex-charts/apexcharts.js"></script>

        <script src="../assets/js/main.js"></script>
        <script src="../assets/js/dashboards-analytics.js"></script>
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
    <%         } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
