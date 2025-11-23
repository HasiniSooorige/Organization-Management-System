<%@page import="Model.Mapping.LeaveType"%>
<%@page import="java.util.Date"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Logic.ProjectsDAO"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Logic.ProjectEmployeeRoleDAO"%>
<%@page import="Model.Mapping.ProjectEmployeeRole"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="java.util.List"%>
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

        <title>Employee | Exon Leave Request</title> 

        <meta name="description" content="" />
        <!-- jQuery -->
        <link href="https://datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

        <link rel="stylesheet" href="../css/projectStyles.css" type="text/css"/>

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
    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if ((!(request.getSession().getAttribute("GUP_ID") == null)) || (!(request.getSession().getAttribute("Emp_GUP") == null))) {


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
                                    Leave Request</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Leave Request
                            </h6>
                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4">

                                    <div class="card-body" >
                                        <div class="row mb-3" hidden="">
                                            <label class="col-sm-2 col-form-label">Requested Date </label>
                                            <div class="col-sm-10">
                                                <input type="date"  id="reqDate" class="form-control" value="<%= Com.getDate(new Date())%>" readonly/>
                                            </div>
                                        </div>
                                        <div class="row mb-3" hidden="">
                                            <label class="col-sm-2 col-form-label">NIC </label>
                                            <div class="col-sm-10">
                                                <input class="form-control" id="empNic" name="empNic" value="<%= user.getGeneralUserProfile().getNic()%>" readonly/>
                                            </div>
                                        </div>

                                        <div class="row mb-3" hidden="">
                                            <label class="col-sm-2 col-form-label">Name </label>
                                            <div class="col-sm-10">
                                                <input class="form-control" id="projectname" name="projectname" value="<%=user.getGeneralUserProfile().getFirstName() + " " + user.getGeneralUserProfile().getLastName()%>" readonly/>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Leave Category <label class="text-danger">*</label></label>
                                            <div class="col-sm-10">
                                                <select id="leaveSelect" class="select2 form-select">
                                                    <option selected disabled value="">Select Category</option>
                                                    <option>Annual Leave</option>
                                                    <option>Casual Leave</option>
                                                    <option>Other Leave</option>
                                                </select>
                                                <div id="selectError"  hidden=""  class="text-danger"><small>Please select leave category</small></div>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Reason for Leave <label class="text-danger">*</label></label>
                                            <div class="col-sm-10">
                                                <textarea style="height: 150px; resize: none;"
                                                          class="form-control"
                                                          type="text"
                                                          id="leaveComment"
                                                          name="projectDescription"></textarea>
                                                <div id="commentField"  hidden=""  class="text-danger"><small>Please enter reason for leave</small></div>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Leave Type <label class="text-danger">*</label></label>
                                            <div class="col-sm-10">

                                                <span>
                                                    <input class="form-check-input" type="radio" name="LeaveType" value="FullDay" id="fullDay" checked>
                                                    <label class="form-check-label mb-3" for="vacation">
                                                        Full Day &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </label>
                                                </span>
                                                <span>
                                                    <div class="col-sm-6 px-2">
                                                        <table><tr>
                                                                <td><label class="col-form-label">From <label class="text-danger">*</label></label></td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td><input type="date" id="startdate1" class="form-control" /></td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td><label class="col-form-label">To <label class="text-danger">*</label></label></td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td><input type="date" id="enddate1" class="form-control" /></td>
                                                        </table>
                                                    </div> 
                                                </span>
                                                <div id="fulldayVali"  hidden=""  class="text-danger"><small>Please Fill All Full Day Leave Fields</small></div>

                                                <br><br>

                                                <span>
                                                    <input class="form-check-input" type="radio" name="LeaveType" value="Half Day" id="halfDay" >
                                                    <label class="form-check-label" for="vacation">
                                                        Half Day &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </label>
                                                    <br><br>
                                                </span>
                                                <span>
                                                    <div class="col-sm-10 mb-3  px-2" >
                                                        <table><tr>

                                                                <td><label class="col-form-label"><input type="radio" class="form-check-input " name="dayTime" value="AM" > AM</label> </td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td><label class="col-form-label"><input type="radio" class="form-check-input " name="dayTime" value="PM"> PM</label></td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td> <label class=" mx-4 col-form-label">Date <label class="text-danger">*</label></label></td>
                                                                <td> <input type="date" id="halfDate" class="form-control" /></td>
                                                        </table>
                                                    </div> 
                                                </span>
                                                <div id="halfdayVali"  hidden=""  class="text-danger"><small>Please Fill All Half Day Leave Fields</small></div>

                                                <br><br>

                                                <span>
                                                    <input class="form-check-input" type="radio" name="LeaveType" value="Short Leave" id="shortLeave" >
                                                    <label class="form-check-label" for="vacation">
                                                        Short Leave &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </label>
                                                </span>
                                                <span>
                                                    <br>
                                                    <br>
                                                    <div class="col-sm-10  px-2">
                                                        <table><tr>
                                                                <td> <label class=" col-form-label">Time from <label class="text-danger">*</label></label></td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td><input class="form-control" id="shTimeFrom" value="" name="projectname" type="time" /> </td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td> <label class=" col-form-label">Time to <label class="text-danger">*</label></label></td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td><input class="form-control" id="shTimeTo" value="" name="projectname" type="time" /> </td>
                                                                <td><div class="tbSpace"></div></td>
                                                                <td> <label class=" mx-4 col-form-label">Date <label class="text-danger">*</label></label></td>
                                                                <td> <input type="date" id="shortLeaveDate" class="form-control" /></td>
                                                        </table>
                                                    </div>                                                 
                                                </span>
                                                <div id="shortfdayVali"  hidden=""  class="text-danger"><small>Please Fill All Short Leave Fields</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3 mt-5">
                                            <div class="col-sm-12" align="right">
                                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="clearFelds();">Cancel</button>
                                                <button id= "" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="leaveCheckk();">Save</button>
                                            </div>
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
        <!-- / Layout wrapper -->

        <!-- Core JS -->
        <!-- build:js assets/vendor/js/core.js -->
        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="multiselect.min.js"></script>

        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script src="../JsController/JsController.js"></script>
        <script src="../assets/scripts/pages/LeaveMng.js"></script>

        <!--  load DataTables  -->
        <script
            src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/js/jquery.dataTables.min.js"
            integrity="sha512-BkpSL20WETFylMrcirBahHfSnY++H2O1W+UnEEO4yNIl+jI2+zowyoGJpbtk6bx97fBXf++WJHSSK2MV4ghPcg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
        ></script>
        <script src="https://datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="https://cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>
        <script src="../assets/js/jquery.dataTables.min.js" type="text/javascript"></script>
        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>
        <script type="text/javascript" src="../JsController/JsController.js">
        </script>

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.5.6/tinymce.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/tinymce/4.5.6/jquery.tinymce.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/5/tinymce.min.js"></script>;

        <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
