<%-- 
    Document   : registerEmployee
    Created on : Oct 19, 2023, 12:27:56 PM
    Author     : HP
--%>

<%@page import="Model.CommonMethod.Com"%>
<%@page import="java.util.Date"%>
<%@page import="Model.Logic.CountryDAO"%>
<%@page import="Model.Mapping.Country"%>
<%@page import="Model.Logic.GenderDAO"%>
<%@page import="Model.Mapping.Gender"%>
<%@page import="Model.Logic.DesignationDAO"%>
<%@page import="Model.Mapping.Designation"%>
<%@page import="Model.Logic.GeneralOrganizationProfileDAO"%>
<%@page import="Model.Mapping.GeneralOrganizationProfile"%>
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

        <title>Exon Admin | Employee Registration</title> 

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

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="../assets/css/projectStyles.css" />

        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>

        <script type="text/javascript" src="../assets/scripts/pages/createEmployee.js"></script>

        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

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
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Employee Registration</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Employee Registration
                            </h6>
                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4">
                                    <div class="card-body">

                                        <div class="row mb-3">

                                            <label class="col-sm-2 col-form-label">EPF NO</label>
                                            <div class="col-sm-4">
                                                <input class="form-control" id="epf_num" name="epf_num"/>
                                            </div>
                                            <label class="col-sm-2 col-form-label">Registered Date</label>
                                            <div class="col-sm-4">
                                                <input type="text" value="<%=Com.getDate(new Date())%>" class="form-control" id="regisered" name="regisered" disabled style="background-color: white;"/>
                                            </div>

                                        </div>

                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Branch <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <select id="branch" name="branch" class="select2 form-select">
                                                    <option selected disabled value="">Select Branch</option>
                                                    <%                                                                            for (GeneralOrganizationProfile p : GeneralOrganizationProfileDAO.listByQuery(sess, null, null)) {

                                                            if (p.getOrganizationType().getId() == 4) {
                                                    %>
                                                    <option value="<%=p.getId()%>"> <%=p.getName()%> </option>
                                                    <% }
                                                        }
                                                    %>
                                                </select>
                                                <div id="branchErrNotify"  hidden=""  class="text-danger"><small>Please Select Branch</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Designation <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <select id="designation" name="designation" class="select2 form-select">
                                                    <option selected disabled value="">Select Designation</option>
                                                    <%
                                                        for (Designation d : DesignationDAO.listByQuery(sess, null, null)) {
                                                    %>
                                                    <option value="<%=d.getId()%>"><%=d.getName()%></option>
                                                    <% }
                                                    %>
                                                </select>
                                                <div id="DesignationErrNotify"  hidden=""  class="text-danger"><small>Please Select Designation</small></div>
                                            </div>

                                        </div>

                                        <div class="row mb-3">
                                            <label class="card-title text-primary" class="form-label">Basic Details</label>

                                            <label class="col-sm-2 col-form-label">NIC <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input class="form-control" type="text" id="nic" name="nic" />

                                                <div id="nicErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your NIC</small></div>
                                                <div id="nicErrNotify_wrg"  hidden=""  class="text-danger"><small>Please Enter a Valid NIC</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Gender <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <select id="gender" name="gender" class="select2 form-select">
                                                    <option selected disabled value="">Select Gender</option>
                                                    <%                                                                            for (Gender gen : GenderDAO.listByQuery(sess, null, null)) {

                                                    %>
                                                    <option value="<%=gen.getId()%>"> <%=gen.getName()%> </option>
                                                    <% }

                                                    %>
                                                </select>

                                                <div id="genderErrNotify"  hidden=""  class="text-danger"><small>Please Select Gender</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">

                                            <label class="col-sm-2 col-form-label">First Name <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input class="form-control" type="text" id="first_name" name="first_name" />

                                                <div id="first_nameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your First Name</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Last Name <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input class="form-control" type="text" name="last_name" id="last_name" />

                                                <div id="last_nameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Last Name</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Date of Birth <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="date" class="form-control" id="dob" name="dob" />

                                                <div id="dobErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Date of Birth</small></div>
                                            </div> 
                                        </div>

                                        <div class="row mb-3">

                                            <label class="card-title text-primary" class="form-label">Contact Details</label>

                                            <label class="col-sm-2 col-form-label">E-mail <label class="text-danger">*</label></label>

                                            <div class="col-sm-4">
                                                <input class="form-control" type="text" id="email" name="email" autocomplete="off" />

                                                <div id="emailErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Email</small></div>
                                                <div id="emailErrNotify_valide"  hidden=""  class="text-danger"><small>Please Enter a Valid Email</small></div>
                                            </div>


                                            <label class="col-sm-2 col-form-label">Mobile No <label class="text-danger">*</label></label>

                                            <div class="col-sm-4">
                                                <input type="text" id="mobile_no" name="mobile_no" class="form-control" />

                                                <div id="mobile_noErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Mobile No</small></div>
                                                <div id="mobile_noErrNotify_valide"  hidden=""  class="text-danger"><small>Please Enter a Valid Mobile No</small></div>
                                            </div>

                                        </div>


                                        <div class="row mb-3">

                                            <label class="col-sm-2 col-form-label">Telephone No <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input class="form-control" type="tel" id="home_no" name="home_no" />

                                                <div id="homenoErrNotify"  hidden=""  class="text-danger" ><small>Please Enter Your Telephone No</small></div>
                                                <div id="homenoformatErrNotify"  hidden=""  class="text-danger"><small>Please Enter Valid Telephone No</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Emergency Contact No <label class="text-danger">*</label></label>

                                            <div class="col-sm-4">
                                                <input type="text" id="emergency_no" name="emergency_no" class="form-control" />

                                                <div id="emergencynoErrNotify"  hidden=""  class="text-danger" ><small>Please Enter Emergency Contact No</small></div>
                                                <div id="emergencynoformatErrNotify"  hidden=""  class="text-danger"><small>Please Enter Valid Emergency Contact No</small></div>
                                            </div>

                                        </div>

                                        <div class="row mb-3">

                                            <label class="col-sm-2 col-form-label">Address 1 <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="address1" name="address1" />

                                                <div id="address1ErrNotify"  hidden=""  class="text-danger"><small>Please Enter Address Line 1</small></div>
                                            </div>
                                            <label class="col-sm-2 col-form-label">Address 2 <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="address2" name="address2"/>

                                                <div id="address2ErrNotify"  hidden=""  class="text-danger"><small>Please Enter Address Line 2</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">

                                            <label class="col-sm-2 col-form-label">Address 3 <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="text" class="form-control" id="address3" name="address3"/>

                                                <div id="address3ErrNotify"  hidden=""  class="text-danger"><small>Please Enter Address Line 3</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Country <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <select id="country" name="country" class="select2 form-select">
                                                    <option selected disabled value="">Select Country</option>
                                                    <%                                                                            for (Country c : CountryDAO.listByQuery(sess, null, null)) {

                                                    %>
                                                    <option value="<%=c.getId()%>"> <%=c.getName()%> </option>
                                                    <% }

                                                    %>
                                                </select>

                                                <div id="country_idErrNotify"  hidden=""  class="text-danger"><small>Please Select Country</small></div>
                                            </div>

                                        </div>

                                        <div style="height: 10px;"></div>
                                        <div class="row mb-3">
                                            <div class="col-sm-12" align="right">
                                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="field_clear();">Cancel</button>
                                                <button type="submit"   id= "empReg" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="validate_Registration();">Register</button>
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

            <script src="../assets/vendor/libs/jquery/jquery.js"></script>
            <script src="../assets/vendor/libs/popper/popper.js"></script>
            <script src="../assets/vendor/js/bootstrap.js"></script>
            <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

            <script src="../assets/vendor/js/menu.js"></script>

            <script src="../assets/js/main.js"></script>

    </body>
    <%                } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
