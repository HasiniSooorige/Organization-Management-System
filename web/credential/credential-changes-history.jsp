<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Logic.UserCredentialHistoryDAO"%>
<%@page import="Model.Mapping.UserCredentialHistory"%>
<%@page import="Model.Logic.CredentialTypeDAO"%>
<%@page import="Model.Mapping.UserCredentialType"%>
<%@page import="Model.Logic.CredentialCategoryDAO"%>
<%@page import="Model.Logic.ProjectsDAO"%>
<%@page import="Model.Mapping.UserCredentialCategory"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Logic.NotificationManagerDAO"%>
<%@page import="Model.Mapping.NotificationManager"%>
<%@page import="java.util.List"%>
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

        <title>Credential  Changes History - Exon</title>
        <meta name="description" content="" />


        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
            />
        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="../assets/css/projectStyles.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />


        <script type="text/javascript" src="../assets/scripts/pages/CredentialChangesHistoryJs.js"></script>
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
                                <span class="text-primary fw-light">Credentials Changes History</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Credentials Changes History
                            </h6>


                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-12">
                                                <div class="card-body">

                                                    <div class="row">
                                                        <div class="row my-3">
                                                            <div class="col-md-3">

                                                                <select   id="filter-type" class="filterHistory form-select form-select-md" aria-label=".form-select-sm example">
                                                                    <option  value="0">Select Credential</option>
                                                                    <%                                                                            for (UserCredentialType type : CredentialTypeDAO.listByQuery(sess, null, null)) {
                                                                    %>
                                                                    <option value="<%=type.getName()%>"><%=type.getName()%></option>
                                                                    <% }
                                                                    %>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-3">

                                                                <select id="filter-cat" class="filterHistory form-select form-select-md" aria-label=".form-select-sm example">
                                                                    <option  value="0">Select Credential Category</option>
                                                                    <%                                                                            for (UserCredentialCategory cat : CredentialCategoryDAO.listByQuery(sess, null, null)) {
                                                                    %>
                                                                    <option value="<%=cat.getName()%>"><%=cat.getName()%></option>
                                                                    <% }
                                                                    %>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-3">

                                                                <select  id="filter-pro"  class="filterHistory form-select form-select-md" aria-label=".form-select-sm example">
                                                                    <option value="0">Select Project</option>
                                                                    <%                                                                            for (Projects p : ProjectsDAO.listByQuery(sess, null, null)) {
                                                                    %>
                                                                    <option value="<%=p.getName()%>"><%=p.getName()%></option>
                                                                    <% }
                                                                    %>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-3">  
                                                                <button type="button" class="btn btn-primary"onclick="filterHistory_function();" style="width: 100%;">Search</button>
                                                            </div>
                                                            <div id="filterEmptyErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please select at least one filter.</small></div>

                                                        </div>

                                                        <div class="col-12 offset-12 mt-3">

                                                            <div style="float: left;">
                                                                <div class="navbar-nav align-items-center">
                                                                    <div class="nav-item d-flex align-items-center">
                                                                        <i class="bx bx-search fs-4 lh-0"></i>
                                                                        <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="credHistoryTable();">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div> 

                                                        <div class="table-responsive text-nowrap" id="credHisDataDiv">
                                                            <table id="credHistoryTableMngId" class="table table-hover">
                                                                <thead class="sticky-header table-light" id="credHisHeader">
                                                                    <tr>
                                                                        <th scope="col">ID</th>
                                                                        <th scope="col">Type</th>
                                                                        <th scope="col">Category</th>
                                                                        <th scope="col">Project</th>
                                                                        <th scope="col">Role</th>
                                                                        <th scope="col">Updated By</th>
                                                                        <th scope="col">Updated Date</th>
                                                                        <th scope="col">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="credHisBody">

                                                                    <%                                                            for (UserCredentialHistory e : UserCredentialHistoryDAO.listByQuery(sess, null, null)) {


                                                                    %>

                                                                    <tr class="tabletrfilterHistory">

                                                                        <td><%=e.getId()%> </td>
                                                                        <td class="type" data-type="<%=e.getUserCredentials().getUserCredentialType().getName()%>"><%=e.getUserCredentials().getUserCredentialType().getName()%></td>

                                                                        <td class="cat" data-cat="<%=e.getUserCredentials().getUserCredentialCategory().getName()%>"><%=e.getUserCredentials().getUserCredentialCategory().getName()%></td>
                                                                        <td class="pro" data-pro="<%=e.getUserCredentials().getProjects().getName()%>"><%=e.getUserCredentials().getProjects().getName()%></td>
                                                                        <td>                            
                                                                            <%
                                                                                Integer credid = e.getUserCredentials().getId();
                                                                                UserCredentialRole credR = (UserCredentialRole) sess.createQuery("From UserCredentialRole Where user_credentials_id='" + credid + "'").setMaxResults(1).uniqueResult();
                                                                            %>
                                                                            <%=credR.getCredentialRoles().getName()%>
                                                                        </td>
                                                                        <td><%=e.getGeneralUserProfile().getFirstName()%> <%=e.getGeneralUserProfile().getLastName()%></td>
                                                                        <td><%=Com.getDate(e.getUpdatedDate())%> </td>
                                                                        <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewCedentialHistoryData(<%=e.getId()%>);"></i></td>
                                                                    </tr>

                                                                    <%
                                                                        }

                                                                    %>


                                                                </tbody>
                                                                <tfoot>
                                                                    <tr>
                                                                        <td colspan="8">
                                                                            <span style="float: left;">
                                                                                <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                                <button type="button" class="btn btn-outline-primary" onclick="loadAllCredHistory()" id="allButton">All</button>
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

        <!------------Modal - Credential Changes History Details ------------>
        <div class="modal fade" id="viewCredHistoryM" tabindex="-1" aria-labelledby="viewCred" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Credential Changes History Details</span></h4> 
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
                                <input class="form-control" type="text" id="credTypeHistorySpan" name="credTypeHistorySpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Category</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credCatHistorySpan" name="credCatHistorySpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Credential Role</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credHistoryRoleSpan" name="credHistoryRoleSpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Project</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credHistoryProjectSpan" name="credHistoryProjectSpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Username</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credUsernameHistorySpan" name="credUsernameHistorySpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Old Password</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credPasswordHistorySpan" name="credPasswordHistorySpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Updated By</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="credUpdatedByEmp" name="credUpdatedByEmp" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Updated Date & Time</label>
                            <div class="col-sm-8">
                                <input class="form-control" type="text" id="creUpdatedHistorySpan" name="creUpdatedHistorySpan" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label">Reason</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" type="text" id="credReasonHistory" name="credReasonHistory" style="height: auto;" readonly></textarea>
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
            var tableRows = document.querySelectorAll("#credHisBody tr");
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

        <script>

            function credHistoryTable() {

                var input = document.querySelector('.form-control');
                var filter = input.value.toUpperCase();


                var rows = document.getElementById('credHisBody').getElementsByTagName('tr');


                for (var i = 0; i < rows.length; i++) {

                    var cells = rows[i].getElementsByTagName('td');


                    for (var j = 0; j < cells.length; j++) {
                        var cell = cells[j];


                        if (cell) {
                            var textValue = cell.textContent || cell.innerText;
                            if (textValue.toUpperCase().indexOf(filter) > -1) {
                                rows[i].style.display = '';
                                break;
                            } else {
                                rows[i].style.display = 'none';
                            }
                        }
                    }
                }
            }

            function loadAllCredHistory() {

                var paginationElement = document.getElementById("pagination");
                paginationElement.innerHTML = "";

                var tableBody = document.getElementById("credHisBody");
                var allRows = tableBody.getElementsByTagName("tr");

                for (var i = 0; i < allRows.length; i++) {
                    allRows[i].style.display = "";
                }

                var pageSizeButtons = document.querySelectorAll('.page-size');
                for (var i = 0; i < pageSizeButtons.length; i++) {
                    pageSizeButtons[i].classList.remove('active');
                }

                var tableDiv = document.getElementById("credHisDataDiv");
                tableDiv.style.maxHeight = "700px"; // Set the maximum height

                var tableHeader = document.getElementById("credHisHeader");
                tableHeader.style.overflowY = "none";

                var table = document.getElementById("credHisBody");
                table.style.overflowY = "auto"; // Enable vertical scrolling
            }
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
    <%                } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
