<%-- 
    Document   : salarySheet
    Created on : Sep 7, 2023, 10:43:42 AM
    Author     : Developer
--%>

<%@page import="java.util.Date"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Logic.PayRollDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salary Sheet</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/logo1.jpeg" />
        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
            />
        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>
        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />
        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <!-- Page CSS -->
        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
        <script type="text/javascript" src="../JsController/JsController.js"></script>
        <script src="../assets/js/config.js"></script>
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">-->
        <!--<link href="css/style.css" type="text/css" rel="stylesheet" />-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
        <link href="https://datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="https://datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="https://cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <style>
            .list-items ul{
                list-style: none;
            }
            .list-items ul li ul{
                margin-left:10px;
            }
            .list-items ul li{
                margin-bottom:5px;
            }
            .input_text{
                display: block;
            }
            .input_text_none{
                display: none;
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
        <!-- Layout wrapper -->
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
                            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Salary Sheet</h4>
                            <div class="row">
                                <!-- Bootstrap Table with Header - Light -->
                                <div class="card" id ="tableDiv">
                                    <div class="text-nowrap" style="padding: 20px">
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
                                                        <option value="<%=thisMonth%>"><%=thisMonth%></option>
                                                        <option value="1">1 - Jan</option>
                                                        <option value="2">2 _Mar</option>
                                                        <option value="3">3</option>
                                                        <option value="4">4</option>
                                                        <option value="5">5</option>
                                                        <option value="6">6</option>
                                                        <option value="7">7</option>
                                                        <option value="8">8</option>
                                                        <option value="9">9</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row " > 
                                            <div class="row mb-3">
                                                <div class="col-sm-12" align="right">
                                                    <button type="submit"   id= "search" class="btn-success  btn-primary" style="width: 200px;" onclick="searchSalerySheetByMonth();">Search</button>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="dataTables_length" id="table_allusers_length">
                                            <label>Show 
                                                <select name="table_allusers_length" aria-controls="table_allusers" class="">
                                                    <option value="10">10</option>
                                                    <option value="25">25</option>
                                                    <option value="50">50</option>
                                                    <option value="100">100</option>
                                                </select>entries</label>

                                            <div id="table_allusers_filter" class="dataTables_filter" style="float: right">
                                                <label>Search:
                                                    <input type="search" class="" placeholder="" aria-controls="table_allusers">
                                                </label>
                                            </div>
                                        </div>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <br>
                                        <div class="table-responsive">
                                            <div class="row">       
                                                <img src="../assets/img/preloader.gif" style="margin: 0 auto; display: none; width: 100px;" id="preloader_search">
                                                <div class="col-md-12" id="salery_sheet_by_month_table">
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <label id="divDes" style="color: red" class="form-label"></label>
                                        </div>
                                    </div>
                                </div>
                                <!-- Bootstrap Table with Header - Light -->
                            </div>
                        </div>
                        <!-- / Content -->
                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                    <script>$("a[data-target=#largeModal]").click(function (ev) {
                            ev.preventDefault();
                            var target = $(this).attr("href");
                            // load the url and show modal on success
                            $("#largeModal .modal-body").load(target, function () {
                                $("#largeModal").modal("show");
                            });
                        });
                        $('#largeModal').on('hidden', function () {
                            $(this).removeData('modal');
                        });
                    </script>
                    <!-- Overlay -->
                    <!--<div class="layout-overlay layout-menu-toggle"></div>-->
                </div>
            </div>
        </div>
        <!-- Core JS -->
        <%@include file="../assets/js/include/all_scripts.jsp" %>
        <script>

            $(function () {
                $("#year-month-picker").datepicker({
                    dateFormat: 'yy-mm',
                    changeMonth: true,
                    changeYear: true,
                    showButtonPanel: true,
                    onClose: function (dateText, inst) {
                        var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                        var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val(
                                );
                        $(this).datepicker('setDate', ne
                                w Date(year, month, 1));

                    }
                });
            });
        </script>

    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
