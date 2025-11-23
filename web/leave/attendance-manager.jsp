<%-- 
    Document   : attendance-test
    Created on : Oct 25, 2023, 3:50:56 PM
    Author     : Personal
--%>


<%@page import="java.util.Date"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Exon Admin</title> 
        <meta name="description" content="" />
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />
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
        <!-- Helpers -->
    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {
    %>
    <jsp:forward page="../index.jsp"></jsp:forward>
    <%  }
    %>
    <body >
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
                <!-- / Navbar -->
                  
                    <%                       
                        if (user.getUserRole().getId().equals(1) && user.getUserRole().getId().equals(2) && user.getUserRole().getId().equals(3)) {
                           System.out.println("Alligible to attendance mark " + user.getGeneralUserProfile().getNameWithIn());
                        }
                    %>
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-3 mb-4">
                                <span class="text-muted fw-light">Mark Attendance</span>
                            </h4>
                            <div class="card p-2 ">
                                <div class="card-body  ">
                                    <form action="" method="">
                                        <div class="form-group p-2 ">
                                            <label class="p-2" for="employeeId">Employee NIC:</label>
                                            <input type="text" class="form-control" id="employeeNic" name="employeeId" value=" <%= user.getGeneralUserProfile().getNic() %> " required readonly>
                                        </div>
                                        <!-- Date Field -->
                                        <div class="form-group p-2 ">
                                            <label class="p-2" for="date">Date:</label>

                                            <input type="date" class="form-control" id="date" name="date" value="<%= Com.getDate(new Date()) %> " required readonly>
                                        </div>

                                        <!-- In Time Field -->
                                        <div class="form-group col-md-12 p-2">
                                            <label class="p-2" for="inTime">In Time:</label>
                                            <input type="time" class="form-control" value="<%= Com.getTime(new Date()) %>" id="inTime" name="inTime" required readonly>
                                            <div style="height: 5px;"></div>

                                            <div id="SaveIn"  hidden=""  class="alert-box success"><span>Mark In time Saved.</span></div>

                                            <button type="submit" class="btn rounded-pill btn-primary m-3 float-end" id="saveInTime" onclick="markIntime();">Save In Time</button>



                                        </div>
                                        <!-- out Time Field -->

                                        <br>
                                        <br>

                                        <div class="form-group col-md-12 p-2" >
                                            <label class="p-2" >Out Time:</label>
                                            <input type="time" class="form-control" id="outTime"  required readonly>

                                            <div id="SaveOut"  hidden=""  class="alert-box success"><span>Mark out time Saved.</span></div>

                                            <button class="btn rounded-pill btn-primary m-3 float-end" id="saveTime" onclick="">Save out Time</button>

                                        </div>

                                        <br>
                                        <br>
                                        <br>

                                        <!--
                                                                                <div class="float-end mx-3">
                                        
                                        
                                                                                    <button class="btn rounded-pill btn-success mt-3" id="markAttendance" onclick="markIntime();">Mark Attendance</button>
                                                                                </div>-->


                                        <div id="AttendMarked"  hidden=""  style="width: 50%; margin: 0 auto;" class="alert-box notice "><span>Attendance Marked Successfully.</span></div>
                                    </form>
                                </div>
                            </div>

                        </div>
                        <!-- Content wrapper -->
                    </div>
                    <!-- / Layout page -->
                </div>
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>


        <!-- Clock -->

        <style type= "text/css">

            .alert-box {
                color:#555;
                border-radius:10px;
                font-family:Tahoma,Geneva,Arial,sans-serif;font-size:15px;
                padding:15px 50px;
                margin :10px;
                text-align: center;
            }
            .alert-box span {
                font-weight:bold;

            }
            .error {
                background:#ffecec url('../images/error.png') no-repeat 10px 50%;
                border:1px solid #f5aca6;
            }
            .success {
                background:#e9ffd9 url('../../images/success.png') no-repeat 10px 50%;
                border:1px solid #a6ca8a;
            }
            .warning {
                background:#fff8c4 url('../../images/warning.png') no-repeat 10px 50%;
                border:1px solid #f2c779;
            }
            .notice {
                background:#e3f7fc url('../../images/notice.png') no-repeat 10px 50%;
                border:1px solid #8ed9f6;
            }




            button {
                padding: 15px;
                text-align: center;
            }
        </style>

        <script>



            // Assuming you have a reference to the element
            var element = document.getElementById("AttendMarked");

            // Get the computed style of the element
            var computedStyle = window.getComputedStyle(element);

            if (computedStyle.display === "none") {
                setInterval(updateClock, 1000);
            } else {
                console.log("Element is not hidden.");
            }


        </script>

        <!-- Display Attendance Records -->

    </div>

    <!-- Add Bootstrap JS and jQuery (optional) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../assets/vendor/libs/popper/popper.js"></script>
    <script src="../assets/vendor/js/bootstrap.js"></script>
    <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <!-- Main JS -->
    <script src="../assets/js/main.js"></script>
    <script src="../assets/scripts/pages/JsController_attendance.js"></script>
    <!-- Page JS -->
    <script src="../assets/js/pages-account-settings-account.js"></script>
    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <script src="../assets/vendor/js/helpers.js"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>

    <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>
</body>
</html>
