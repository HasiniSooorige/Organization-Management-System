<%-- 
   Document   : profile
   Created on : Nov 10, 2023, 8:40:20 AM
   Author     : HP
--%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Mapping.GeneralUserProfile"%>

<!DOCTYPE html>
<html   lang="en"
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

        <title>Exon Admin | Profile</title> 

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

        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>

        <script type="text/javascript" src="../assets/scripts/pages/ProfileSetting.js"></script>

        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            System.out.println((request.getSession(false).getAttribute("user")));
            if (!(request.getSession().getAttribute("User_ID") == null)) {


    %>
    <body onload="loadProfilePhoto();">
        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- / Menu -->
                <%@include file="../main-pages/includes/admin-panel.jsp" %>
                <!-- / Menu -->
                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@include file="../main-pages/includes/header.jsp" %>
                    <!-- / Navbar -->

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="py-3 mb-4">
                                <span class="text-muted fw-light">Account Settings </span>
                            </h4>
                            <div class="row">
                                <div class="col-lg-12 mb-12 order-0">
                                    <!--<div class="card">-->


                                    <div class="card mb-4">
                                        <h5 class="card-header">Profile Details</h5>
                                        <!-- Account -->
                                        <div class="card-body">
                                            <form id="uploadForm" action="../UploadProfileImage" method="post" enctype="multipart/form-data">
                                                <div class="d-flex align-items-start align-items-sm-center gap-4">

                                                    <input class="form-control" type="text" id="userId" name="userId" value="<%=user.getGeneralUserProfile().getId()%>" readonly hidden>
                                                    <input class="form-control" type="text" id="userImage" name="userImage" value="<%=user.getGeneralUserProfile().getProfileImgUrl()%>" readonly hidden>

                                                    <div class="col-sm-4" id="ProfileImageView" style="height: 100px; width: 100px;">
                                                        <img src="#" alt="user-avatar" class="d-block rounded" height="100" width="100" id="uploadedAvatar">
                                                    </div>
                                                    
                                                    <div class="button-wrapper">
                                                        <label for="uploadProfile" class="btn btn-outline-secondary me-2 mb-4" tabindex="0">
                                                            <span class="d-none d-sm-block">Choose Profile Photo</span>
                                                            <i class="bx bx-upload d-block d-sm-none"></i>
                                                            <input type="file" id="uploadProfile" name="uploadProfile" class="account-file-input" hidden="" value="" 
                                                                   accept="image/png, image/jpeg, image/jpg" multiple="multiple"  onclick="profileImageView();"/>
                                                        </label>

                                                        <button type="submit" class="btn btn-primary mb-4">
                                                            Upload
                                                        </button>
                                                        <p class="text-muted mb-0">Allowed JPG, JPEG or PNG only.</p>

                                                    </div>

                                                </div>
                                            </form>


                                        </div>
                                        <hr class="my-0">
                                        <div class="card-body">
                                            <div class="row">

                                                <div class="mb-3">
                                                    <input class="form-control" type="text" id="gupid" name="gupid" value="<%=user.getGeneralUserProfile().getId()%>" readonly hidden>
                                                </div>

                                                <% if (!(request.getSession().getAttribute("Emp_GUP") == null)) {
                                                        Object empGupValue = request.getSession().getAttribute("Emp_GUP");
                                                        int empGupId = (Integer) empGupValue;

                                                        Employee emp = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + empGupId + "'").setMaxResults(1).uniqueResult();
                                                %>
                                                <div class="mb-3 col-md-6">
                                                    <label for="firstName" class="form-label">EPF No</label>
                                                    <input class="form-control" type="text" id="epfno" name="epfno" value="<%=emp.getEpfNo()%>" readonly>
                                                </div>
                                                <% }%>
                                                <div class="mb-3 col-md-6">
                                                    <label for="lastName" class="form-label">NIC</label>
                                                    <input class="form-control" type="text" name="nic" id="nic" value="<%=user.getGeneralUserProfile().getNic()%>" readonly>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="firstName" class="form-label">First Name</label>
                                                    <input class="form-control" type="text" id="firstName" name="firstName" value="<%=user.getGeneralUserProfile().getFirstName()%>">

                                                    <div id="firstNameError"  hidden=""  class="alert-box error" style="color:red;"><span>First Name Required</span></div>
                                                </div>

                                                <div class="mb-3 col-md-6">
                                                    <label for="lastName" class="form-label">Last Name</label>
                                                    <input class="form-control" type="text" name="lastName" id="lastName" value="<%=user.getGeneralUserProfile().getLastName()%>">

                                                    <div id="lastNameError"  hidden=""  class="alert-box error" style="color:red;"><span>Last Name Required</span></div>
                                                </div>

                                                <div class="mb-3 col-md-6">
                                                    <label for="email" class="form-label">Address 1</label>
                                                    <input class="form-control" type="text" id="adddress1" name="adddress1" value="<%=user.getGeneralUserProfile().getAddress1()%>">

                                                    <div id="address1Error"  hidden=""  class="alert-box error" style="color:red;"><span>Address 1 Required</span></div>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="organization" class="form-label">Address 2</label>
                                                    <input type="text" class="form-control" id="adddress2" name="adddress2" value="<%=user.getGeneralUserProfile().getAddress2()%>">

                                                    <div id="address2Error"  hidden=""  class="alert-box error" style="color:red;"><span>Address 2 Required</span></div>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="phoneNumber">Address 3</label>
                                                    <input type="text" id="adddress3" name="adddress3" class="form-control" value="<%=user.getGeneralUserProfile().getAddress3()%>">

                                                    <div id="address3Error"  hidden=""  class="alert-box error" style="color:red;"><span>Address 3 Required</span></div>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="address" class="form-label">Email</label>
                                                    <input type="text" class="form-control" id="email" name="email" value="<%=user.getGeneralUserProfile().getEmail()%>">

                                                    <div id="emailError"  hidden=""  class="alert-box error" style="color:red;"><span>Email Required</span></div>
                                                    <div id="emailInvalidError"  hidden=""  class="alert-box error" style="color:red;"><span>Enter Valid Email</span></div>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="state" class="form-label">Mobile No</label>
                                                    <input class="form-control" type="text" id="mobileno" name="mobileno" value="<%=user.getGeneralUserProfile().getMobileNo()%>">

                                                    <div id="mobilenoError"  hidden=""  class="alert-box error" style="color:red;"><span>Mobile No Required</span></div>
                                                    <div id="mobilenoInvalidError"  hidden=""  class="alert-box error" style="color:red;"><span>Enter Correct Mobile No</span></div>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="zipCode" class="form-label">Telephone No</label>
                                                    <input type="text" class="form-control" id="telephoneno" name="telephoneno" value="<%=user.getGeneralUserProfile().getHomeNo()%>">

                                                    <div id="telephonenoError"  hidden=""  class="alert-box error" style="color:red;"><span>Telephone No Required</span></div>
                                                    <div id="telephonenoInvalidError"  hidden=""  class="alert-box error" style="color:red;"><span>Enter Correct Telephone No</span></div>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="country">Gender</label>
                                                    <input type="text" class="form-control" id="gender" name="gender" value="<%=user.getGeneralUserProfile().getGender().getName()%>" readonly>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="country">Country</label>
                                                    <input type="text" class="form-control" id="country" name="country" value="<%=user.getGeneralUserProfile().getCountry().getName()%>" readonly>
                                                </div>
                                                <% if (!(request.getSession().getAttribute("Emp_GUP") == null)) {
                                                        Object empGup = request.getSession().getAttribute("Emp_GUP");
                                                        int employGupId = (Integer) empGup;

                                                        Employee employ = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + employGupId + "'").setMaxResults(1).uniqueResult();%>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="country">Organization</label>
                                                    <input type="text" class="form-control" id="organization" name="organization" value="<%=employ.getGeneralOrganizationProfile().getName()%>" readonly>
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="country">Designation</label>
                                                    <input type="text" class="form-control" id="designation" name="designation" value="<%=employ.getDesignation().getName()%>" readonly>
                                                </div>
                                                <% }%>
                                                
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="country">Registered Date</label>
                                                    <input type="text" class="form-control" id="registerdate" name="registerdate" value="<%=user.getGeneralUserProfile().getProfileCreatedDate()%>" readonly>
                                                </div>

                                            </div>
                                            <div class="mt-2" style="float: right;">
                                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;">Cancel</button>
                                                <button type="submit" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="updateProfileData();">Save</button>
                                            </div>
                                        </div>
                                        <!-- /Account -->
                                    </div>
                                    -
                                </div>

                                <!-- Total Revenue -->
                            </div>
                        </div>
                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->

                </div>
                <!-- / Layout page -->
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>
        <!-- Core JS -->
        <!-- build:js assets/vendor/js/core.js -->

        <script type="text/javascript">
            url = new URL(window.location.href);
            if (url.searchParams.has('messageSuccess')) {
                Swal.fire({
                    title: 'Profile Image Upload Successfully!',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'profile.jsp';
                });

            }

            if (url.searchParams.has('userError')) {
                Swal.fire({
                    title: 'User Not Found !',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'profile.jsp';
                });

            }
            if (url.searchParams.has('messageError')) {
                Swal.fire({
                    title: 'Select Profile Image!',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'profile.jsp';
                });

            }
        </script>

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
    </body>
    <%                } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
