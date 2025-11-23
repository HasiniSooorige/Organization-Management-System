<%-- 
    Document   : view_leave_request
    Created on : Sep 4, 2023, 4:40:15 PM
    Author     : Gimna Katugampala
--%>

<%@page import="Model.Mapping.UserLogin"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html
    lang="en"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="../assets/"
    data-template="vertical-menu-template-free"
    >
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />

        <title>View Leave Request</title>

        <meta name="description" content="" />



        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

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
        <script type="text/javascript" src="../assets/js/JsController.js"></script>

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



    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if (!(request.getSession().getAttribute("GUP_ID") == null)) {


    %>

    <body onload="loadusers_all();">
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

                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <!-- Basic Layout & Basic with Icons -->

                        <!-- Basic Layout -->
                        <div class="modal fade" id="largeModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel3"></h5>
                                        <button
                                            type="button"
                                            class="btn-close"
                                            data-bs-dismiss="modal"
                                            aria-label="Close"

                                            ></button>
                                    </div>
                                    <div class="modal-body">


                                        <form >
                                            <!--<form action="javascript:;" class="needs-validation" novalidate="" id="user-register">-->
                                            <div class="row mb-3">
                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">EPF NO:</label>
                                                <div class="col-sm-4">
                                                    <input class="form-control" id="epf_no1" name="epf_no" readonly/>
                                                </div>
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Registered Date:</label>
                                                <div class="col-sm-4">
                                                    <input type="date" class="form-control" id="regisered1" name="regisered"  class="form-control" id="basic-default-name" readonly/>
                                                </div>
                                                <div style="height: 10px;"></div>

                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Branch:</label>
                                                <div class="col-sm-4">

                                                    <input class="form-control" id="organization_by1" name="organization_by" readonly/>


                                                </div>
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Designation:</label>
                                                <div class="col-sm-4">
                                                    <input class="form-control" id="designation1" name="designation" readonly/>


                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <label class="card-title text-primary" class="form-label" for="country_id">Basic Details</label>

                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">NIC:</label>
                                                <div class="col-sm-4">
                                                    <input
                                                        class="form-control"
                                                        type="text"
                                                        id="nic1"
                                                        name="nic"
                                                        autofocus
                                                        readonly />
                                                </div>

                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Gender:</label>
                                                <div class="col-sm-4">
                                                    <input class="form-control" id="gender1" name="gender1" readonly/>


                                                </div>


                                                <div style="height: 10px;"></div>

                                                <label class="col-sm-2 col-form-label" for="basic-default-name">First Name:</label>
                                                <div class="col-sm-4">
                                                    <input
                                                        class="form-control"
                                                        type="text"
                                                        id="first_name1"
                                                        name="first_name"
                                                        autofocus
                                                        readonly
                                                        />
                                                </div>
                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Last Name:</label>
                                                <div class="col-sm-4">
                                                    <input class="form-control" type="text" name="last_name" id="last_name1" readonly />
                                                </div>

                                            </div>


                                            <div class="row mb-3">

                                                <label class="card-title text-primary" class="form-label" for="country_id">Contact Details</label>





                                                <label class="col-sm-2 col-form-label" for="basic-default-name">E-mail:</label>
                                                <div class="col-sm-4">
                                                    <input class="form-control" type="text" id="email1" name="email" readonly/>
                                                </div>

                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Phone No:</label>
                                                <div class="col-sm-4">
                                                    <input type="text" id="mobile_no1" name="mobile_no" class="form-control" readonly />
                                                </div>
                                                <div style="height: 10px;"></div>
                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Address 1:</label>
                                                <div class="col-sm-4">
                                                    <input type="text" class="form-control" id="address11" name="address1" readonly/>
                                                </div>
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Home No:</label>
                                                <div class="col-sm-4">
                                                    <input class="form-control" type="text" id="home_no1" name="home_no" readonly/>
                                                </div>

                                                <div style="height: 10px;"></div>
                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Address 2:</label>
                                                <div class="col-sm-4">
                                                    <input type="text" class="form-control" id="address21" name="address2" readonly/>
                                                </div> 
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Country:</label>
                                                <div class="col-sm-4">
                                                    <input type="text" class="form-control" id="country_id1" name="country_id" readonly/>

                                                </div>

                                                <div style="height: 10px;"></div>
                                                <label class="col-sm-2 col-form-label" for="basic-default-name">Address 3:</label>
                                                <div class="col-sm-4">
                                                    <input type="text" class="form-control" id="address31" name="address3" readonly/>
                                                </div>

                                                <!--<label class="form-label" for="country_id">EPF NO</label>-->





                                            </div>





                                        </form>


                                    </div>

                                </div>
                            </div>
                        </div>    

                        <!--Resignation_modal-->
                        <div class="modal fade" id="ResignationModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <!--<h5 class="modal-title" id="exampleModalLabel3"></h5>-->
                                        <button
                                            type="button"
                                            class="btn-close"
                                            data-bs-dismiss="modal"
                                            aria-label="Close"

                                            ></button>
                                    </div>
                                    <div class="modal-body">
                                        <!--<form action="javascript:;" class="needs-validation" novalidate="" id="user-register">-->
                                        <div class="row mb-3">
                                            <!--<label class="form-label" for="country_id">EPF NO</label>-->
                                            <label class="col-sm-2 col-form-label" for="basic-default-name">Registered Date:</label>
                                            <div class="col-sm-4">
                                                <%

                                                %>
                                                <input type="date" class="form-control" id="regisered1model2" name="regisered"  class="form-control" readonly/>
                                            </div>
                                            <label class="col-sm-2 col-form-label" for="basic-default-name">Resignation Date:</label>
                                            <div class="col-sm-4">
                                                <input type="date" value="" class="form-control" id="resignation" name="resignation"  class="form-control" id="basic-default-name" />
                                            </div>
                                            <div class="col-sm-4">
                                                <input type="text" class="d-none" id="inputid"/>
                                                <button class="btn btn-primary" id="resbtn" onclick="ResignationSave();">Save</button>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>   
                        <!--Resignation_modal-->







                        <div class="container-xxl flex-grow-1 container-p-y">

                            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Leave Request List</h4>

                            <div class="row">


                                <!-- Bootstrap Table with Header - Light -->
                                <div class="card" id ="tableDiv">



                                    <div class="table-responsive text-nowrap">
                                        <table id="table_allusers"  class="table">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>NIC</th>
                                                    <th>Name</th>
                                                    <th>Reason Type</th>
                                                    <th>Leave Type</th>
                                                    <th>Comment</th>
                                                    <th>Date From</th>
                                                    <th>Date From</th>
                                                    <th>View</th>
                                                    <th>Action</th>
                                         
                                                </tr>
                                            </thead>
<!--                                            <tbody class="table-border-bottom-0"id="tablebody">

                                            </tbody>-->
                                        </table>
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

                    <script>$("a[data-target=#ResignationModal]").click(function (ev) {
                            ev.preventDefault();
                            var target = $(this).attr("href");

                            // load the url and show modal on success
                            $("#ResignationModal .modal-body").load(target, function () {
                                $("#ResignationModal").modal("show");
                            });
                        });
                        $('#ResignationModal').on('hidden', function () {
                            $(this).removeData('modal');
                        });
                    </script>

                    <!-- Overlay -->
                    <!--<div class="layout-overlay layout-menu-toggle"></div>-->
                </div>
            </div>
        </div>
            </div>
        </div>

                <!-- build:js assets/vendor/js/core.js -->

                <script src="../assets/vendor/js/bootstrap.js"></script>


                <script src="../assets/vendor/js/menu.js"></script>
                <!-- endbuild -->

                <!-- Vendors JS -->
                <script src="../assets/vendor/libs/apex-charts/apexcharts.js"></script>

                <!-- Main JS -->
                <script src="../assets/js/main.js"></script>

                <!-- Page JS -->

                <!-- Place this tag in your head or just before your close body tag. -->
                <script async defer src="https://buttons.github.io/buttons.js"></script>
                </body>
                <%
                } }
                %>
                </html>
