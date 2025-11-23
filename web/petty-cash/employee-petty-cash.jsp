<%-- 
    Document   : pettyCash
    Created on : Sep 16, 2023, 2:23:04 PM
    Author     : Ashan Kavindu
--%>
<%@page import="Model.Mapping.PettyCashTransactionHistoryDocument"%>
<%@page import="Model.Mapping.GeneralUserProfile"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Model.Mapping.PettyCashTransactionHistory"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Model.Mapping.PettyCashWallet"%>
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

        <title>Exon - Employee Petty Cash</title>

        <meta name="description" content="" />

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
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" />
        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />
        <!--<link rel="stylesheet" href="../css/bootstrap.css" />-->
        <!-- Page CSS -->

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
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
                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard</h4>
                            <div class="card">
                                <div class="card-img p-4 " style="height: max-content">
                                    <div class="row">
                                        <div class="col-12 col-md-6 col-lg-4 p-2">
                                            <div class="card" style="color: #3AB85C; background-image: linear-gradient(to right, #BCFDCA, #97EDAA);">
                                                <div class="card-img p-4 ">
                                                    <h4 class="card-title text-white">My Cash Wallet</h4>
                                                    <p class="card-text">Available Balance</p>
                                                    <p class="card-text fs-4"><b>LKR 
                                                            <%                                                                PettyCashWallet pcw = (PettyCashWallet) sess.createQuery("from PettyCashWallet u where employee_id=(select id from Employee Where general_user_profile_id='" + user.getGeneralUserProfile().getId() + "')").uniqueResult();
                                                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                                                if (pcw != null) {

                                                                    String formattedBalance = decimalFormat.format(pcw.getAmount());
                                                            %>
                                                            <%= formattedBalance%> 
                                                            <%} else {%>
                                                            0.00
                                                            <% }%>
                                                        </b></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 col-lg-4 p-2">
                                            <div class="card" style="color: #9A9CFF; background-image: linear-gradient(to right, #E7E7FF, #CCCCF6);">
                                                <div class="card-img p-4 ">
                                                    <h4 class="card-title text-white">My Cash Wallet</h4>
                                                    <p class="card-text">Pending Settlement</p>
                                                    <p class="card-text fs-4"><b>LKR
                                                            <%
                                                                String formattedPendingBalance = "";
                                                                if (pcw != null) {
                                                                    List<PettyCashTransactionHistory> pcth = (List<PettyCashTransactionHistory>) sess.createQuery("from  PettyCashTransactionHistory u where petty_cash_wallet_id='" + pcw.getId() + "'And petty_cash_approval_level_id=(select id from  PettyCashApprovalLevel where name='pending')").list();

                                                                    double balanceAmount = 0;
                                                                    for (PettyCashTransactionHistory data : pcth) {
                                                                        balanceAmount += data.getAmount();

                                                                    }
                                                                    formattedPendingBalance = decimalFormat.format(balanceAmount);
                                                            %>
                                                            <%= formattedPendingBalance%> 
                                                            <%} else {%>
                                                            0.00
                                                            <% }%>
                                                        </b></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 col-lg-4 p-2">
                                            <div class="card" style="color: #EF9393; background-image: linear-gradient(to right, #FCDDDD, #EF9393);">
                                                <div class="card-img p-4 ">
                                                    <h4 class="card-title text-white">My Cash Wallet</h4>
                                                    <p class="card-text">Rejected</p>
                                                    <p class="card-text fs-4"><b>
                                                            <%
                                                                if (pcw != null) {
                                                                    int noofSettlement = sess.createQuery("from PettyCashTransactionHistory u where petty_cash_wallet_id='" + pcw.getId() + "' and petty_cash_approval_level_id='3'").list().size();
                                                            %> <%= noofSettlement%><%} else {%>
                                                            0
                                                            <%}%>
                                                        </b></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h4 class="fw-bold py-3 pt-5 "><span class="text-muted fw-light">Manage Petty Cash</h4>

                            <div class="card" id="Disbursement">
                                <div class="card-img p-4 " style="height: max-content">
                                    <div class="row">
                                        <div class="col-12 col-md-9">
                                            <h5 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Cash Settlements</h5>
                                        </div>
                                        <div class="col-12 col-md-3">
                                            <button    id= "empReg" class="btn-primary  btn-primary" style="width: 200px;" onclick="ViewSettlementModel();refreshSettlementModelTable();">+ Add Settlement</button>

                                        </div>
                                    </div>
                                    <div class="row container-fluid overflowtable pt-4 pt-md-0">
                                        <div class="col-md-12 m-2">

                                            <table class="table table-hover">
                                                <thead class="text-center">
                                                    <tr>
                                                        <th scope="col">Settlement ID</th>
                                                        <th scope="col">Settlement Date</th>
                                                        <th scope="col">Description</th>
                                                        <th scope="col">Attachement</th>
                                                        <th scope="col">Amount</th>
                                                        <th scope="col">Status</th>
                                                        <th scope="col">Comment</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="text-center">
                                                    <%
                                                        if (pcw != null) {
                                                            List<PettyCashTransactionHistory> pcwData = (List<PettyCashTransactionHistory>) sess.createQuery("from PettyCashTransactionHistory where petty_cash_wallet_id='" + pcw.getId() + "'").list();
                                                            for (PettyCashTransactionHistory history : pcwData) {
                                                    %>
                                                    <tr>
                                                        <td><%= history.getId()%></td>
                                                        <td><%= new SimpleDateFormat("dd-MM-yyyy").format(history.getTransactionDate())%></td>
                                                        <td><%= history.getDescription()%></td>
                                                        <td><button class="btn btn-yellow container" data-bs-target="#attachementModalToggle" data-bs-toggle="modal" onclick="viewDocuments(<%=history.getId()%>);"><i class="fa-solid fa-eye"></i> &nbsp;View</button></td>
                                                        <td>Rs.<%= decimalFormat.format(history.getAmount())%></td>
                                                        <td>
                                                            <span class="<% if (history.getPettyCashApprovalLevel().getId() == 2) { %>bg-green container<% } else if (history.getPettyCashApprovalLevel().getId() == 3) { %>bg-red container<% } else if (history.getPettyCashApprovalLevel().getId() == 1) { %>bg-yellow container<% } %>">
                                                                <%if (history.getPettyCashApprovalLevel().getId() == 1) { %>
                                                                <span>Pending<span class="blinking-dots"></span></span>
                                                                    <% } else if (history.getPettyCashApprovalLevel().getId() == 2) { %>
                                                                Approved
                                                                <% } else if (history.getPettyCashApprovalLevel().getId() == 3) {%>
                                                                <span onclick="getRejectedAction(<%= history.getId()%>, '<%= history.getDescription()%>', 'Rs. <%= decimalFormat.format(history.getAmount())%>');" style="cursor: pointer;"> Rejected <i class="fa fa-exclamation-triangle blink"></i></span>
                                                                    <% }%>
                                                            </span>
                                                        </td>
                                                        <td><%=history.getComment()%></td>
                                                    </tr>
                                                    <%}
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td>Nor Records</td>
                                                    </tr>
                                                    <%
                                                        }%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- / Content -->

                        </div>
                        <!-- Content wrapper -->
                    </div>
                    <!-- / Layout page -->
                </div></div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>
        <!--Model Start-->
        <div class="modal fade" id="SettlementModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="SettlementModalToggleHeader">New Settlement</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-4 mt-2 mt-lg-3 mb-2"><span class="fs-6">Settlement Date</span></div>
                            <div class="col-8 mt-2 mb-2"><input type="text" class="form-control" value="<%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd-MM-yyyy"))%>" disabled="true"/></div>
                            <div class="col-4 mt-lg-3 mb-2"><span class="fs-6">Balance</span></div>
                            <div class="col-8 mt-2 mb-2"><input type="text" class="form-control" value="LKR <%
                                if (pcw != null) {
                                    out.print(decimalFormat.format(pcw.getAmount() - Double.parseDouble(formattedPendingBalance)));
                                } else {%>0.00<%}%>" disabled="true"/></div>
                            <div class="col-4 mt-3 mb-2"><span class="fs-6">Description</span></div>
                            <div class="col-8 mt-2 mb-2"><input type="text" class="form-control" id="getDescription"/></div>
                            <div class="offset-lg-4 col-12 col-lg-8 mt-2 mb-2">
                                <button class="btn-purple  btn-primary" onclick="viewAddRecordModel();">+ &nbsp;Add Record</button>
                            </div>
                            <div class="offset-lg-4 col-12 col-lg-8 mt-2 mb-2" style="overflow-y:auto; max-height: 150px;">
                                <table class="table table-hover container" id="table">
                                    <thead style="position: -webkit-sticky; position:sticky; top: 0;">
                                        <tr>
                                            <th style="font-size: 9px;">Expense Description</th>
                                            <th style="font-size: 9px;">Amount</th>
                                            <th style="font-size: 9px;">Attachment</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-4 mt-2 mb-2"> <span class="fs-6">Total Amount</span></div>
                            <div class="col-8"><input type="text" class="form-control" value="Rs.0.00" id="setTotal" disabled="true"/></div>
                            <br/><br/>
                            <div class="offset-lg-4 col-12 col-lg-8">
                                <button class="btn-success rounded-pill btn-primary" style="width: 200px;" onclick="sendForReview();" id="sendtoreview">Send for Review</button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Model End-->
        <!--Model2 Start-->
        <div class="modal fade" id="viewAddRecordModel" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="viewAddRecordModel">Add Record</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <table>
                                <tr>
                                    <td>
                                        <span class="fs-6 mt-2 mb-2">Expense Description</span>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control mt-2 mb-2" id="getExpenseDescription"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span class="fs-6 mt-2 mb-2">Amount</span>
                                    </td>
                                    <td>
                                        <input type="text" class="form-control mt-2 mb-2" oninput="validateNumericInput(this)" id="getAmountForAddRecord"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="file" id="files" name="files" accept="image/*" hidden onchange="readDoc(this)">                                            
                                        <label id="updoc" for="files" class="btn btn-purple container">
                                            <i class="fa fa-cloud-upload" aria-hidden="true"></i>
                                            &nbsp;Upload Attachment
                                        </label>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <button class="btn-success rounded-pill btn-primary" style="width: 200px;" onclick="addRecord();">+ &nbsp;Add Record</button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!--Model2 End-->
        <!--Attachements Model Start-->
        <div class="modal fade" id="attachementModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">View All Attachments</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-6">
                                <span class="fs-6" id="numberOfAttachments">Number of Attachments: 06</span>
                            </div>
                            <div class="col-6 text-end">
                                <span class="fs-6">Amount: <span class="fw-bold bg-yellow" id="getAllAmount">Rs.15,000.00</span></span>
                            </div>
                        </div>
                        <hr class="text-puple"/>
                        <div class="row text-center pointer" id="loadAttachments">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Attachements Model End-->
        <!--Single Attachement Model Start-->
        <div class="modal fade" id="singleattachementModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Single Attachment View</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <span class="fs-6">Amount: <span class="fw-bold bg-yellow" id='singleattachementModalAmount'>Rs. 1500.00 </span></span>

                        </div>
                        <div class="row">
                            <span class="fs-6">Expense Description: </span>
                            <p class="fs-6" id="singleattachementModalExpenseDescription">
                            </p>
                        </div>
                        <hr class="text-puple"/>
                        <div class="row text-center pointer p-5">
                            <image src="../White Simple Minimalist Business Invoice.png" id="singleattachementModalImage" class="img-fluid  border-1 border-label-primary"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Single Attachement Model End-->
        <!-- / Layout wrapper -->
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

        <!-- Index JS -->
        <script src="../assets/js/index.js"></script>

        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
        <style>
            @media only screen and (max-width: 600px) {
                .overflowtable {
                    overflow: auto;
                }
            }
            .blink {
                color: #EF9494; /* Set initial color */
                animation: blinking 1.5s infinite; /* 1.5s duration, infinite repetitions */
            }
            .blink:hover{
                cursor: pointer;
            }
            @keyframes blinking {
                0%, 100% {
                    opacity: 1; /* Fully visible */
                }
                50% {
                    opacity: 0; /* Completely invisible */
                }
            }
            .blinking-dots {
                font-size: 24px;
                animation: blink 1s infinite;
            }

            .blinking-dots::before,
            .blinking-dots::after {
                content: ".";
                opacity: 0;
                animation: blink 1s infinite;
                animation-delay: 0.25s; /* Delay for the second dot */
            }

            @keyframes blink {
                50% {
                    opacity: 1;
                }
            }
        </style>
        <script src="../assets/scripts/pages/EmployeepettyCash.js"></script>
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>

