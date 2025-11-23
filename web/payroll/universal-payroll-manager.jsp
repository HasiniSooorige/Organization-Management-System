<%-- 
    Document   : create-new-interface
    Created on : Oct 13, 2023, 12:28:16 PM
    Author     : Personal
--%>

<%@page import="Model.Mapping.Employee"%>
<%@page import="java.util.Date"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Logic.SystemInterfaceDAO"%>
<%@page import="Model.Mapping.SystemInterface"%>
<%@page import="Model.Logic.InterfaceSubMenuDAO"%>
<%@page import="Model.Mapping.InterfaceSubMenu"%>
<%@page import="java.util.List"%>
<%@page import="Model.Logic.InterfaceMenuDAO"%>
<%@page import="Model.Mapping.InterfaceMenu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html
    lang="en"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="assets/"
    data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
        <title>Exon | Manage Employee</title>
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/logo1.jpeg" />
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"/>
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
        <script src="../assets/js/config.js"></script>
        <style>
            thead,
            tbody,
            tfoot,
            tr,
            td,
            th {
                border-color: #cccccc !important;
                border-style: solid;
                border-width: 0;
            }

            .title-label-color-green{
                background-color: #1BBC9B  !important;
                color: #233446 !important;
            }
            .title-label-color-puple{
                background-color: #9B59B6   !important;
                color: #233446 !important;
            }
            .btn-success {
                color: #fff;
                background-color: #009999;
                border-color: #2dc0cd;
            }
            .btn-success:hover {
                color: #fff;
                background-color: #00cccc;
                border-color: #2dc0cd;
            }
        </style>
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
                            <h4 class="fw-bold py-1 mb-1"><span class="text-muted fw-light">
                                    Manage Employee</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Add Employees to Salary sheet
                            </h6>
                            <div class="card" id="create-new-interface">
                                <div class="col-12 col-md-12 portlet-title title-label-color-green">
                                    <h5 class="fw-bold py-1 mb-1 text-uppercase p-4"><span class="text-white"> Add Employees to Salary sheet</span></h5>
                                </div>
                                <div class="portlet-body">
                                    <div class="row p-4">
                                        <%                                        int thisYear = Com.getYearFromDate(new Date());
                                            int thisMonth = Com.getMonthFromDate(new Date());
                                        %>
                                        <div class="row ">
                                            <div class="col-lg-12">
                                                <div class="col-lg-6">
                                                    <label class="col-sm-2 col-form-label" for="basic-default-name">Year</label>
                                                    <select id="year-select" name="designation" class="select2 form-select">
                                                        <option value="<%=thisYear%>"><%=thisYear%></option>
                                                        <option value="2020">2020</option>
                                                        <option value="2021">2021</option>
                                                        <option value="2022">2022</option>
                                                        <option value="2023">2023</option>
                                                        <option value="2024">2024</option>
                                                        <option value="2025">2025</option>


                                                    </select>

                                                </div>
                                                <div class="col-lg-6">
                                                    <label class="col-sm-2 col-form-label" for="basic-default-name">Month</label>
                                                    <select id="month-select" name="designation" class="select2 form-select">
                                                        <option value="1">1 - Jan</option>
                                                        <option value="2">2 - Fab</option>
                                                        <option value="3">3 - Mar</option>
                                                        <option value="4">4 - Apr</option>
                                                        <option value="5">5 - May</option>
                                                        <option value="6">6 - Jun</option>
                                                        <option value="7">7 - Jul</option>
                                                        <option value="8">8 - Aug</option>
                                                        <option value="9">9 - Sep</option>
                                                        <option value="10">10 - Oct</option>
                                                        <option value="11">11 - Nov</option>
                                                        <option value="12">12 - Dec</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br/>                 

                                    <div class="row p-4">
                                        <table class="table table-striped table-bordered table-hover table-responsive" id="payroll_table" >
                                            <thead>
                                                <tr>
                                                    <th> No </th>
                                                    <th> Employee Nic </th>
                                                    <th> Name </th>
                                                    <th><div class="md-checkbox text-left"><label for="form_control_1">Select All</label>
                                                            <input type="checkbox" id="checkbox" class="md-check" onclick="Set_EmployeeCheckedAll()" >
                                                            <label for="checkbox">
                                                                <span class="inc"></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> </label>
                                                        </div>  </th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%
                                                    int i = 1;
                                                    List<Employee> emp_list = sess.createQuery("from Employee where isActive=1").list();
                                                    String name = "";
                                                    for (Employee emp : emp_list) {
                                                        name = emp.getGeneralUserProfile().getFirstName() + " " + emp.getGeneralUserProfile().getLastName();

                                                %>
                                                <tr >
                                                    <td> <%=i%> </td>
                                                    <td><%=emp.getGeneralUserProfile().getNic()%></td>
                                                    <td><%=name%></td>
                                                    <td class="text-center"> 
                                                        <div class="md-checkbox text-left "><label id="dis_val<%=i%>" class="font-red-flamingo" for="form_control_1"></label><label class="font-yellow-gold" id="dis_valx<%=i%>" for="form_control_1"></label>
                                                            <input type="checkbox" id="checkbox<%=i%>"  class="md-check">
                                                            <label for="checkbox<%=i%>">
                                                                <span class="inc"></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> </label>
                                                        </div></td>
                                                    <td class="hidden" style="display: none;"><%= emp.getId()%></td>
                                                </tr>
                                                <%
                                                        i++;
                                                    }
                                                %>


                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="row">       
                                        <div class="col-md-12">
                                            <div style="padding-top: 10px;">
                                                <div class="row mb-3 p-4">
                                                    <div class="col-sm-12" align="right">
                                                        <button type="submit"   id= "empReg" class="btn-success  btn-primary" style="width: 200px;" onclick="AddEmployeeToSalerySheet();">Add</button>
                                                    </div>
                                                </div>

                                                <div class="row text-right" id="add_preloader" style="display: none">
                                                    <span style="color: #f00; font-size: 20px; font-weight: bold">Please Wait.....</span>
                                                    <img src="../assets/img/preloader.gif" style="width: 150px;">
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
                </div>
                <!-- / Layout wrapper -->
            </div>
        </div>

        <!-- Core JS -->
        <%@include file="../assets/js/include/all_scripts.jsp" %>
        <style>
            @media only screen and (max-width: 600px) {
                .overflowtable {
                    overflow: auto;
                }
            }
        </style>
        <script>
            function viewDisbursement() {
                document.getElementById("Cash_Settlements").classList.add("d-none");
                document.getElementById("Disbursement").classList.remove("d-none");
            }
            function viewCashSettlements() {
                document.getElementById("Cash_Settlements").classList.remove("d-none");
                document.getElementById("Disbursement").classList.add("d-none");
            }
        </script>
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>

