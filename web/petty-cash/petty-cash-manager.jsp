<%-- 
    Document   : pettyCash
    Created on : Sep 16, 2023, 2:23:04 PM
    Author     : Ashan Kavindu
--%>

<%@page import="Model.Mapping.UserLogin"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Mapping.PettyCashTransactionHistory"%>
<%@page import="java.util.List"%>
<%@page import="Model.Mapping.Employee"%>
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
        <title>Exon Admin- Petty Cash Wallet</title>
        <meta name="description" content="" />
        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/logo1.jpeg" />

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

        <!-- Page CSS -->

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
                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard</h4>
                            <div class="card" id="dashboard">
                                <div class="card-img p-4 " style="height: max-content">
                                    <div class="row">
                                        <div class="col-12 col-md-6 col-lg-4 p-2">
                                            <div class="card" style="color: #3AB85C; background-image: linear-gradient(to right, #BCFDCA, #97EDAA);">
                                                <div class="card-img p-4 ">
                                                    <h4 class="card-title text-white">Exon Cash Wallet</h4>
                                                    <p class="card-text">Available Balance</p>
                                                    <p class="card-text fs-4"><b>
                                                            <%                                                                String formattedBalance = "00.00";
                                                                PettyCashWallet balanceRec = (PettyCashWallet) sess.createQuery("from PettyCashWallet u where employee_id='" + user.getId() + "'").uniqueResult();
//                                                                DecimalFormat decimalFormat = new DecimalFormat("0.00");
//                                                                System.out.println("------------------------------------" + balanceRec.getAmount());
                                                                if (balanceRec != null && balanceRec.getAmount() != null) {
                                                                    DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                                                    formattedBalance = decimalFormat.format(balanceRec.getAmount());
                                                                }


                                                            %>
                                                            LKR <%= formattedBalance%> </b></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-6 col-lg-4 p-2">
                                            <div class="card" style="color: #9A9CFF; background-image: linear-gradient(to right, #E7E7FF, #CCCCF6);">
                                                <div class="card-img p-4 ">
                                                    <h4 class="card-title text-white">Exon Cash Wallet</h4>
                                                    <p class="card-text">Cash Settlements</p>
                                                    <p class="card-text fs-4"><b>
                                                            <%int noofSettlement = sess.createQuery("from PettyCashTransactionHistory u where petty_cash_approval_level_id='1'").list().size();
                                                            %> <%= noofSettlement%>
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
                                        <div class="col-12 col-md-6">
                                            <h5 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Disbursement</h5>
                                        </div>
                                        <div class="col-12 col-md-3">
                                            <button class="btn btn-purple container-fluid" data-bs-target="#exampleModalToggle" data-bs-toggle="modal">+ Add Disbursement</button>
                                        </div>
                                        <div class="col-12 col-md-3 pt-2 pt-md-0">
                                            <button class="btn btn-purple container-fluid" onclick="viewCashSettlements();">Cash Settlements</button>
                                        </div>
                                    </div>
                                    <div class="row container-fluid overflowtable pt-4 pt-md-0">
                                        <div class="col-md-12 m-2">

                                            <table class="table table-hover">
                                                <thead class="text-center">
                                                    <tr>
                                                        <th scope="col">Disbursement ID</th>
                                                        <th scope="col">Disbursement Date</th>
                                                        <th scope="col">Employee Name</th>
                                                        <th scope="col">Amount</th>
                                                        <th scope="col">Settled Amount</th>
                                                        <th scope="col"> Total Remain Amount</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="text-center" id="Disbursement">
                                                    <% List<PettyCashWallet> pcw = (List<PettyCashWallet>) sess.createQuery("from PettyCashWallet").list();
                                                        for (PettyCashWallet wallet : pcw) {
                                                            int totAmount = 0;
                                                            List<PettyCashTransactionHistory> pcth = (List<PettyCashTransactionHistory>) sess.createQuery("from PettyCashTransactionHistory where petty_cash_wallet_id='" + wallet.getId() + "'and petty_cash_approval_level_id='2'").list();
                                                            for (PettyCashTransactionHistory data : pcth) {
                                                                totAmount += data.getAmount();
                                                            }
                                                            DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                                    %>
                                                    <tr>
                                                        <td <%if (wallet.getAmount() == 0) {%>class="line-through"<%}%>><%= wallet.getId()%></td>
                                                        <td <%if (wallet.getAmount() == 0) {%>class="line-through"<%}%>><%= new SimpleDateFormat("dd-MM-yyyy").format(wallet.getUpdatedDate())%></td>
                                                        <td <%if (wallet.getAmount() == 0) {%>class="line-through"<%}%>><%=  wallet.getEmployee().getGeneralUserProfile().getFirstName() + " " + wallet.getEmployee().getGeneralUserProfile().getLastName()%></td>
                                                        <td <%if (wallet.getAmount() == 0) {%>class="line-through"<%}%>>Rs.<%= decimalFormat.format(wallet.getAmount() + totAmount)%></td>
                                                        <td <%if (wallet.getAmount() == 0) {%>class="line-through"<%}%>><span class="bg-green container">Rs.<%=decimalFormat.format(totAmount)%></span></td>
                                                        <td <%if (wallet.getAmount() == 0) {%>class="line-through"<%}%>><span class="bg-yellow container">Rs.<%=decimalFormat.format(wallet.getAmount())%></span></td>
                                                    </tr>
                                                    <%}%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card d-none" id="Cash_Settlements">
                                <div class="card-img p-4 " style="height: max-content">
                                    <div class="row">
                                        <div class="col-12 col-md-9">
                                            <h5 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Cash Settlements</h5>
                                        </div>
                                        <div class="col-12 col-md-3 pt-2 pt-md-0">
                                            <button class="btn btn-purple container-fluid" onclick="viewDisbursement();">Disbursement</button>
                                        </div>
                                    </div>
                                    <div class="row container-fluid overflowtable pt-4 pt-md-0">
                                        <div class="col-md-12 m-2">

                                            <table class="table table-hover">
                                                <thead class="text-center">
                                                    <tr>
                                                        <th scope="col">Settlement ID</th>
                                                        <th scope="col">Employee Name</th>
                                                        <th scope="col">Description</th>
                                                        <th scope="col">Amount</th>
                                                        <th scope="col">View</th>
                                                        <th scope="col">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="text-center">
                                                    <% DecimalFormat decimalFormat = new DecimalFormat("0.00");
                                                        List<PettyCashTransactionHistory> pcth = (List<PettyCashTransactionHistory>) sess.createQuery("from PettyCashTransactionHistory u where petty_cash_approval_level_id='1'").list();
                                                        for (PettyCashTransactionHistory data : pcth) {
                                                    %>
                                                    <tr>
                                                        <td><%= data.getId()%></td>
                                                        <td><%=data.getPettyCashWallet().getEmployee().getGeneralUserProfile().getFirstName() + " " + data.getPettyCashWallet().getEmployee().getGeneralUserProfile().getLastName()%></td>
                                                        <td><%=data.getDescription()%></td>
                                                        <td>Rs.<%=decimalFormat.format(data.getAmount())%></td>
                                                        <td><button class="btn btn-yellow container" data-bs-target="#attachementModalToggle" data-bs-toggle="modal" onclick="viewDocuments(<%= data.getId()%>);"><i class="fa-solid fa-eye"></i> &nbsp;View</button></td>
                                                        <td>
                                                            <button class="btn btn-green container" onclick="Approve(<%= data.getId()%>, 'approve');">Approve</button>
                                                            <br/>
                                                            <button class="mt-2 btn btn-red container" data-bs-target="#RejectModalToggle" data-bs-toggle="modal" onclick="setRejectDetails(<%= data.getId()%>, 'reject');">Reject</button>
                                                        </td>
                                                        <!-- <td>
                                                                <button class="mt-2 btn btn-red container">Not Approved</button>
                                                            </td>-->
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
                            <!-- / Content -->

                        </div>
                        <!-- Content wrapper -->
                    </div>
                    <!-- / Layout page -->
                </div>

                <!-- Overlay -->
                <div class="layout-overlay layout-menu-toggle"></div>
            </div>
            <!--Model Start-->
            <div class="modal fade" id="exampleModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">New Disbursement</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <table>
                                    <tr>
                                        <td>
                                            <span class="fs-6 mt-2 mb-2">Disbursement Date</span>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control mt-2 mb-2" value="<%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("dd-MM-yyyy"))%>" disabled="true"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="fs-6 mt-2 mb-2">Employee</span>
                                        </td>
                                        <td>
                                            <select class="form-select border-0 mt-2 mb-2" id="employee">
                                                <option value="Select">Select</option>
                                                <%
                                                    List<Employee> employees = sess.createQuery("from Employee").list();

                                                    for (Employee employee : employees) {
                                                %>
                                                <option value="<%= employee.getId()%>"><%= employee.getGeneralUserProfile().getFirstName() + " " + employee.getGeneralUserProfile().getLastName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="fs-6 mt-2 mb-2">Amount</span>
                                        </td>
                                        <td>
                                            <input type="text" class="form-control mt-2 mb-2"  id="amount" oninput="validateNumericInput(this)" placeholder="Add amount"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                            <button class="btn btn-purple container mt-4 mb-4" onclick="addnewDisbursement();">Send</button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Model End-->
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
            <!--Reject Model Start-->
            <div class="modal fade" id="RejectModalToggle" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Settlement Review</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <table>
                                    <tr>
                                        <td class=" text-center">
                                            <span class="fs-6">Comment:</span>  
                                        </td>
                                        <td>
                                            <input type="text" class="form-control mt-2 mb-2"  id="Addcomment" placeholder="Add Comment"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><button class="mt-2 btn btn-red container" id="rejectModelbtn">Reject</button></td>
                                    </tr>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <!--Reject Model End-->
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
                                    Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. 
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
        </div>
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
        <script src="../assets/scripts/pages/ManageClaims.js"></script>

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
        </style>
        <script src="../assets/scripts/pages/Adminpettycash.js"></script>
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>


