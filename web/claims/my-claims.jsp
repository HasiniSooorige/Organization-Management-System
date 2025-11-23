<%@page import="Model.Mapping.ClaimApproval"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.ClaimStatus"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Mapping.Claims"%>
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

        <title>Exon | My Claims</title>

        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <!--Lightbox CDN-->
        <link rel="stylesheet"
              type="text/css"
              href="../assets/css/lightbox/dist/css/lightbox.min.css">
        <script src=
                "../assets/css/lightbox/dist/js/lightbox-plus-jquery.min.js">
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
        <link rel="stylesheet" href="../assets/css/projectStyles.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

        <!-- Page CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10/dist/sweetalert2.min.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- SweetAlert JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

        <!-- Helpers -->

        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/MooTools-Core-1.6.0.js"></script>


        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>

    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if ((!(request.getSession().getAttribute("GUP_ID") == null)) || (!(request.getSession().getAttribute("Emp_GUP") == null))) {


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
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    My Claims List</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks .  My Claims List </span>
                            </h6>
                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">

                                        <div class="d-flex align-items-end row">

                                            <div class="col-12 offset-12 mt-3">
                                                <div style="float: left; margin-left: 30px;">
                                                    <div class="navbar-nav align-items-center">
                                                        <div class="nav-item d-flex align-items-center">
                                                            <i class="bx bx-search fs-4 lh-0"></i>
                                                            <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchmyclaims();">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> 
                                            <div class="col-sm-12">

                                                <div class="card-body">

                                                    <div class="row mb-3">
                                                        <div style="align-content: center" class="col-sm-2">
                                                            <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">New Claim</label>
                                                        </div>
                                                        <div class="col-sm-8" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                                        <div class="col-sm-2"><button type="button" class="btn rounded-pill btn-outline-secondary" style="width: 100%" data-bs-toggle="modal" data-bs-target="#addRequestClaim">Request</button></div>
                                                        <div style="height: 10px;"></div>
                                                    </div>


                                                    <div class="row">
                                                        <div class="col-md-12 m-2">
                                                            <div class="table-responsive text-nowrap" id="myClaimsDataDiv" >
                                                                <table class="table table-hover" id="mployeeClaims">
                                                                    <thead class="sticky-header table-light" id="myClaimsHeader">
                                                                        <tr>
                                                                            <th scope="col">Id</th>
                                                                            <th scope="col">Added Date</th>
                                                                            <th scope="col">Total </th>
                                                                            <th scope="col">Notes</th>
                                                                            <th scope="col">Status</th>
                                                                            <th scope="col">Actions</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody id="myclaimsbody">
                                                                        <%   int count = 1;
                                                                            String lastStatus = null;
                                                                            String clz = null;
                                                                            List<Claims> cat_list = sess.createQuery("From Claims where employee.generalUserProfile.id='" + user.getGeneralUserProfile().getId() + "'").list();

                                                                            for (Claims c : cat_list) {
                                                                        %>
                                                                        <tr>
                                                                            <td> <%= count%></td>

                                                                            <%
                                                                                Date addedDate = c.getAddedDate();
                                                                                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                                                                String formattedDate = dateFormat.format(addedDate);
                                                                            %>

                                                                            <td><%=formattedDate%></td>
                                                                            <td class="">RS. <%= c.getTotalAmount()%></td>
                                                                            <td> <%= c.getNote()%></td>

                                                                            <%
                                                                                ClaimApproval lastClaimApproval = null;

                                                                                List<ClaimApproval> claimAp = sess.createQuery("From ClaimApproval where claims_id='" + c.getId() + "'").list();

                                                                                if (!claimAp.isEmpty()) {
                                                                                    System.out.println(count + " - Not Empty !!!");
                                                                                    lastClaimApproval = claimAp.get(claimAp.size() - 1);

                                                                                    if (lastClaimApproval.getClaimApprovalType().getId() == 1) {
                                                                                        lastStatus = "Approved";
                                                                                        clz = "badge bg-label-success me-1";
                                                                                    } else if (lastClaimApproval.getClaimApprovalType().getId() == 2) {
                                                                                        lastStatus = "Rejected";
                                                                                        clz = "badge bg-label-danger me-1";
                                                                                    }
                                                                                }
                                                                            %>

                                                                            <%                                                                                if (c.getClaimStatus().getId() == 1) {
                                                                            %>
                                                                            <td><span class="badge bg-label-info me-1"><%=c.getClaimStatus().getName()%></span></td>
                                                                                <%
                                                                                } else if (c.getClaimStatus().getId() == 2) {
                                                                                %>
                                                                            <td><span class="badge bg-label-warning me-1"><%=c.getClaimStatus().getName()%></span><span class="<%=clz%>"> <%=lastStatus%></span></td>
                                                                                    <%
                                                                                    } else if (c.getClaimStatus().getId() == 3) {
                                                                                    %>
                                                                            <td><span class="badge bg-label-primary me-1"><%=c.getClaimStatus().getName()%></span> <span class="<%=clz%>"><%=lastStatus%></span></td>
                                                                                <%
                                                                                    }
                                                                                %>

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
                                                        <td colspan="6">
                                                            <span style="float: left;">
                                                                <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                <button type="button" class="btn btn-outline-primary" onclick="loadMyClaims()" id="allButton">All</button>
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


        <!-- Add Request Claims-->

        <div class="modal fade" id="addRequestClaim" tabindex="-1" aria-labelledby="addRequestClaim" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">New Claim Request</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>

                    <div class="modal-body">

                        <div class="row clearfix">
                            <div class="col-md-12 table-responsive">

                                <table class="table table-bordered table-sortable" id="">

                                    <tbody>
                                        <tr data-name="name">
                                            <td>Date <label class="text-danger">*</label></td>
                                            <td>
                                                <input type="date" name='req_date'  placeholder='Date' class="form-control" id="req_date"/>
                                                <div id="dateErrNotify"  hidden=""  class="text-danger">Please Enter Date<span></span></div>
                                            </td>
                                        </tr>
                                        <tr data-name="mail">
                                            <td>Amount <label class="text-danger">*</label></td>
                                            <td>
                                                <input type="number" name='req_amount' placeholder='Amount' class="form-control" id="req_amount"/>
                                                <div id="amountErrNotify"  hidden=""  class=" text-danger"> Please Enter Amount<span></span></div>
                                            </td>
                                        </tr>
                                        <tr data-name="sel">
                                            <td>Attachment <label class="text-danger">*</label></td>
                                            <td>
                                                <input accept="image/png, image/gif, image/jpeg"  name="fileToUpload" id="fileToUpload" type="file" value="" class="form-control req_attach" >
                                                <div id="attachmentErrNotify"  hidden=""  class=" text-danger"> Please Upload the Attachment<span></span></div>
                                            </td>
                                        </tr>
                                        <tr data-name="tes">
                                            <td>Type <label class="text-danger">*</label></td>
                                            <td>
                                                <select id="claimType" name="claimType" class="select2 form-select">
                                                    <option selected disabled value="" >Select Type</option>
                                                    <option >Traveling</option>
                                                    <option >Food and Beverage</option>
                                                    <option >Stationary</option>
                                                </select>
                                                <div id="typeErrNotify"  hidden=""  class=" text-danger"> Please Select the Claim Type<span></span></div>
                                            </td>
                                        </tr>
                                        <!--</tr>-->
                                    </tbody>
                                </table>
                            </div>
                        </div >

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="addRow();">Add</button>
                            </div>
                        </div>

                        <input hidden="" id="" value="<%=user.getId()%>">
                        <div id="addNewTableDiv" style="display: none;">
                            <table id="tab_logic" class="tab_logic table table-bordered table-hover table-sortable mt-4" >
                                <thead>
                                    <tr>
                                        <th class="text-center">Date</th>
                                        <th class="text-center">Amount</th>
                                        <th class="text-center">Attachment</th>
                                        <th class="text-center">Claim Type</th>
                                        <th class="text-center" style="border-top: 1px solid #ffffff; border-right: 1px solid #ffffff;"></th>
                                    </tr> </thead>

                                <tbody id="tableBody" ></tbody>

                            </table>

                            <div class="row mb-3">
                                <label class="col-sm-2 col-form-label">Description<label class="text-danger">*</label></label>
                                <div class="col-sm-10">
                                    <textarea name="req_desc" placeholder="Description" class="form-control" id="req_desc"></textarea>
                                    <div id="desErrNotify"  hidden=""  class=" text-danger"> Please Enter Description<span></span></div>

                                </div>
                            </div>
                            <div class="row">

                                <div class="col-md-12 my-3">

                                    <div class="d-flex justify-content-between">
                                        <label>Total Claim Amount</label>

                                        <div ><b><label id="total"></label></b></div>
                                    </div>
                                </div>
                                <!--
                                                                <div class="col-md-12">
                                                                    <button type="submit" class="btn btn-primary col-md-12" value="save" onclick="RequestClaim1(<%=user.getId()%>)" >Request Claim</button>
                                                                </div>
                                -->
                                <div class="row mb-3">
                                    <div class="col-sm-12" align="right">
                                        <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" data-bs-dismiss="modal">Cancel</button>
                                        <button type="submit" class="btn rounded-pill btn-primary" style="width: 200px;" value="save" onclick="RequestClaim1(<%=user.getId()%>)">Request Claim</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--View Claims-->

        <div class="modal fade" id="requestClaims" tabindex="-1" aria-labelledby="requestClaims" aria-hidden="true">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Modal - View Credential-->
        <div class="modal fade" id="viewCred" tabindex="-1" aria-labelledby="viewCred" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabe3"></h5>
                        <button type="button"  class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#ID</th>
                                            <th scope="col">Date</th>
                                            <th scope="col">Amount</th>
                                            <th scope="col">Reason</th>
                                            <th scope="col">Attachment</th>
                                        </tr>
                                    </thead>
                                    <tbody id="unicEmployee">

                                    </tbody>
                                </table>

                            </div>


                            <div class="col-md-12 my-5">
                                <div class="d-flex justify-content-between">
                                    <div>Total Claim Amount</div>


                                    <div><b>Rs. 00.00</b></div>
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
        var tableRows = document.querySelectorAll("#myclaimsbody tr");
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
        <script src="../"></script>
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
        <script src="../js/claims.js"></script>



        <!-- Vendors JS -->

        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

        <!-- Page JS -->
        <script src="../assets/js/pages-account-settings-account.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>


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
