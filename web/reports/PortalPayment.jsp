<%@page import="Model.Mapping.UserLogin"%>
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

        <title>Exon Admin | Portal Payment</title>

        <meta name="description" content="" />

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

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
        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.11.4/date-1.1.1/datatables.min.css"/>

        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.11.4/date-1.1.1/datatables.min.js"></script>

        <link href="https://nightly.datatables.net/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="https://nightly.datatables.net/js/jquery.dataTables.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.11.4/b-2.2.2/b-colvis-2.2.2/b-html5-2.2.2/b-print-2.2.2/datatables.min.css"/>

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.11.4/b-2.2.2/b-colvis-2.2.2/b-html5-2.2.2/b-print-2.2.2/datatables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.11.4/rg-1.1.4/datatables.min.css"/>
        <script type="text/javascript" src="https://cdn.datatables.net/v/dt/jszip-2.5.0/dt-1.11.4/b-2.2.2/b-colvis-2.2.2/b-html5-2.2.2/rg-1.1.4/datatables.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

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
                                    Portal Payment Details </span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Portal Payment Details</span>
                            </h6>

                            <div class="row">
                                <!-- Bootstrap Table with Header - Light -->
                                <div class="card" id ="tableDiv">

                                    <div class="table-responsive text-nowrap">
                                        <br>
                                        <form onsubmit="loadPortalPayment(this);return false">


                                            <div class="col-sm-12 row mb-3">

                                                <label class="col-sm-1 col-form-label">From <label class="text-danger">*</label></label>
                                                <div class="col-sm-3">
                                                    <input type="date"  id="startdate" name="startdate" class="form-control" />

                                                    <div id="startdateErrNotify"  hidden=""  class="text-danger"><small>Please Enter Start Date</small></div>
                                                       </div>

                                                <div class="col-sm-1"></div>

                                                <label class="col-sm-1 col-form-label">To <label class="text-danger">*</label></label>

                                                <div class="col-sm-3">
                                                    <input type="date" id="enddate" name="enddate" class="form-control" />

                                                    <div id="enddateErrNotify"  hidden=""  class="text-danger"><small>Please Enter End Date</small></div>
                                                      </div>

                                                <div class="col-sm-1"></div>

                                                <div class="col-sm-2">
                                                    <button type="submit" id= "showAlert" class="btn  btn-primary">Search</button>    
                                                </div>
                                            </div>     

                                        </form>
                                        <br>

                                        <br>
                                        <table id="loadPortalPayment_table"  class="table">

<!--                                            <thead class="table-light">
                                                <tr>
                                                    <th>Voucher ID</th>
                                                    <th>NIC</th>
                                                    <th>Name</th>
                                                    <th>total</th>
                                                    <th>Institute</th>
                                                    <th>Description</th>
                                                    <th>Payment Mode</th>
                                                    <th>Payment Date</th>
                                                </tr>
                                            </thead>
                                            <tbody class="table-border-bottom-0">

                                            </tbody>-->
                                        </table>
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

                    <!-- Overlay -->
                    <!--<div class="layout-overlay layout-menu-toggle"></div>-->
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
        <script src="../assets/js/searchByDate.js"></script>
        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
    <%                         } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
