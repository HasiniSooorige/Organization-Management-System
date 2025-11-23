<%-- 
    Document   : createProjects
    Created on : Aug 12, 2023, 7:26:08 PM
    Author     : HP
--%>

<%@page import="Model.Logic.CountryDAO"%>
<%@page import="Model.Mapping.Country"%>
<%@page import="Model.Logic.GeneralOrganizationProfileDAO"%>
<%@page import="Model.Mapping.GeneralOrganizationProfile"%>
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
        <title>Exon Admin | Project Manager</title> 
        <meta name="description" content="" />

        <script src="../assets/scripts/pages/createNewProject.js"></script>
        <!-- jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>

        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


        <!--  load DataTables  -->
        <script
            src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/js/jquery.dataTables.min.js"
            integrity="sha512-BkpSL20WETFylMrcirBahHfSnY++H2O1W+UnEEO4yNIl+jI2+zowyoGJpbtk6bx97fBXf++WJHSSK2MV4ghPcg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
        ></script>
        <link href="https://datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="https://datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="https://cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">
        <link rel="stylesheet" href="../assets/css/projectStyles.css" type="text/css"/>
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
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <script src="../assets/vendor/js/helpers.js"></script>
        <script src="../assets/js/config.js"></script>
        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.5.6/tinymce.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/tinymce/4.5.6/jquery.tinymce.min.js"></script>
        <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Create Projects </span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Create Projects</span>
                            </h6>
                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <form action="../CreateNewProject" enctype="multipart/form-data" id="clientdetails" method="post" onsubmit="return saveNewProject();">
                                            <div class="row mb-3">
                                                <div style="align-content: center" class="col-sm-2">
                                                    <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Client Details</label>
                                                </div>
                                                <div class="col-sm-8" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                                <div class="col-sm-2"><button type="button" class="btn rounded-pill btn-outline-secondary" style="width: 100%" onclick="addClientModal();">Add New</button></div>
                                                <div style="height: 10px;"></div>
                                            </div>
                                            <div class="row mb-3">
                                                <div style="align-content: center" class="col-sm-2">
                                                    <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Project Details</label>
                                                </div>
                                                <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                                <div style="height: 10px;"></div>
                                            </div>
                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label">Project Name <label class="text-danger">*</label></label>
                                                <div class="col-sm-10">
                                                    <input class="form-control" id="projectname" name="projectname"/>

                                                    <div id="proNameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Project Name</small></div>
                                                </div>

                                            </div>

                                            <div class="row mb-3">
                                                <label class="col-sm-2 col-form-label">Description <label class="text-danger">*</label></label>

                                                <div class="col-sm-10">
                                                    <textarea style="height: 150px;"
                                                              class="form-control"
                                                              type="text"
                                                              id="projectDescription"
                                                              name="projectDescription"></textarea>

                                                    <div id="proDescripErrNotify"  hidden=""  class="text-danger"><small>Please Enter Project Description</small></div>
                                                </div>

                                            </div>

                                            <div class="row mb-3">

                                                <div style="align-content: center" class="col-sm-2">
                                                    <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Project Team</label>
                                                </div>

                                                <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                                            </div>

                                            <div class="row mb-3">

                                                <div class="col-sm-5">
                                                    <select id="empName" name="empName" class="select2 form-select">
                                                        <option selected disabled value="">Select Employee</option>
                                                        <%                                                            for (Employee emp : EmployeeDAO.listByQuery(sess, null, null)) {
                                                                if (emp.getIsActive() == Boolean.TRUE) {
                                                        %>
                                                        <option value="<%=emp.getId()%>"> <%=emp.getGeneralUserProfile().getFirstName()%> <%=emp.getGeneralUserProfile().getLastName()%> - <%=emp.getDesignation().getName()%> </option>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                    </select>

                                                    <div id="empNameErrNotify"  hidden=""  class="text-danger"><small>Please Select Employee</small></div>
                                                </div>

                                                <div class="col-sm-5">
                                                    <select id="projectrole" name="projectrole" class="select2 form-select" onchange="checkDuplicateEmp();">
                                                        <option selected disabled value="">Select Employee Role</option>
                                                        <%                                                                            for (ProjectEmployeeRole p : ProjectEmployeeRoleDAO.listByQuery(sess, null, null)) {
                                                        %>
                                                        <option value="<%=p.getId()%>"> <%=p.getName()%> </option>
                                                        <% }
                                                        %>
                                                    </select>

                                                    <div id="proRoleErrNotify"  hidden=""  class="text-danger"><small>Please Select Employee Role</small></div>
                                                    <div id="empalreadyexist"  hidden=""  class="alert-box mt-3 error text-danger"><small>Employee is already enrolled in this employee role !</small></div>

                                                </div>

                                                <div class="col-sm-2">

                                                    <button type="button" class="btn rounded-pill btn-outline-secondary" style="width: 100%" id="saveEmpRole" name="saveEmpRole" onclick="addNewRowEmpRole();">Add</button>

                                                </div>


                                            </div>

                                            <div class="row mb-3">
                                                <div class="row" id="tableIntakeRow" style="display: none;">
                                                    <div class="col-sm-12">

                                                        <table id="allEmpTable" class="table">
                                                            <thead class="table-light">
                                                                <tr>
                                                                    <th hidden>Employee Id</th>
                                                                    <th>Name & Designation</th>
                                                                    <th hidden>Project Role ID</th>
                                                                    <th>Project Role</th>
                                                                    <th>Remove</th>
                                                                </tr>
                                                            </thead>

                                                            <tbody class="table-border-bottom-0" id="empTableBody">

                                                            </tbody>
                                                        </table>

                                                    </div>
                                                </div>
                                                <div id="emptableErrNotify"  hidden=""  class="text-danger"><small>Please assign the employee to a project role!</small></div> 
                                            </div>

                                            <div class="row mb-3">

                                                <label class="col-sm-2 col-form-label">Client Name <label class="text-danger">*</label></label>
                                                <div class="col-sm-4">
                                                    <select id="organization" name="organization" class="select2 form-select">
                                                        <option selected disabled value="">Select Organization</option>
                                                        <%                                                                            for (GeneralOrganizationProfile gop : GeneralOrganizationProfileDAO.listByQuery(sess, null, null)) {
                                                        %>
                                                        <option value="<%=gop.getId()%>"> <%=gop.getName()%> </option>
                                                        <% }
                                                        %>
                                                    </select>
                                                    <div id="clientNameErrNotify"  hidden=""  class="text-danger"><small>Please Select Client</small></div>
                                                </div>

                                                <label class="col-sm-2 col-form-label">Project Logo <label class="text-danger">*</label></label>
                                                <div class="col-sm-4">
                                                    <input accept="image/png, image/gif, image/jpeg" onclick="imageUploader();"
                                                           id="fileProject"  name="fileProject" type="file" value="" class="form-control"  multiple="multiple" />
                                                    <input type="text" id="txt_base64" hidden />

                                                    <div id="projectLogoError"  hidden=""  class="text-danger"><small>Please select a project logo to upload.</small></div>

                                                </div>
                                            </div>

                                            <div class="row mb-3"  id="proLogoViewMainDiv" style="display: none">

                                                <label class="col-sm-2 col-form-label">View Project Logo</label>
                                                <img class="col-sm-10" id="uploadedImage" src="#" alt="Uploaded Image">
                                            </div>


                                            <div class="row mb-3">
                                                <div class="col-sm-12" align="right">
                                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;">Cancel</button>
                                                    <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                                </div>
                                            </div>
                                        </form>
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

        <!--=============================Add Client-model- Start==================================-->
        <div class="modal fade" id="addClientModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Add New Client</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <form action="../CreateClientDetails" id="clientdetails" method="post" enctype="multipart/form-data" onsubmit="return saveNewClients();">   
                            <div class="row mb-3">

                                <div style="align-content: center" class="col-sm-3">
                                    <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Company details</label>
                                </div>

                                <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                            </div>
                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Name<label class="text-danger">*</label></label>

                                <div class="col-sm-4">
                                    <input class="form-control" type="text" id="cname" name="cname"/>

                                    <div id="nameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Company Name</small></div>
                                </div>

                                <label class="col-sm-2 col-form-label">Country <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <select id="country" name="country" class="select2 form-select">
                                        <option selected disabled value="">Select Country</option>
                                        <%                                                                            for (Country co : CountryDAO.listByQuery(sess, null, null)) {
                                        %>
                                        <option value="<%=co.getId()%>"> <%=co.getName()%> </option>
                                        <% }
                                        %>

                                    </select>

                                    <div id="countryErrNotify"  hidden=""  class="text-danger"><small>Please Select Country</small></div>
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

                                <label class="col-sm-2 col-form-label">Email <label class="text-danger">*</label></label>

                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="cEmail" name="cEmail"/>

                                    <div id="emaildataErrNotify"  hidden=""  class="text-danger"><small>Please Enter Email</small></div>
                                    <div id="emaildataCorrectErrNotify"  hidden=""  class="text-danger"><small>Please Enter a Valid Email</small></div>
                                </div>

                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Mobile No <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="cMobile" name="cMobile"/>

                                    <div id="cMobileErrNotify"  hidden=""  class="text-danger"><small>Please Enter Mobile No</small></div>
                                    <div id="cMobileCorrectErrNotify"  hidden=""  class="text-danger"><small>Please Enter a Valid Mobile No</small></div>
                                </div>

                                <label class="col-sm-2 col-form-label">Fax No <label class="text-danger">*</label></label>

                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="cFaxNo" name="cFaxNo"/>

                                    <div id="faxdataErrNotify"  hidden=""  class="text-danger"><small>Please Enter Fax No</small></div>
                                    <div id="faxdataCorrectErrNotify"  hidden=""  class="text-danger"><small>Please Enter a Valid Fax No</small></div>
                                </div>

                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Logo <label class="text-danger">*</label></label>

                                <div class="col-sm-4">
                                    <input accept="image/png, image/gif, image/jpeg" onclick="clientlogoView();"
                                           id="file1"  name="file1" type="file" value="" class="form-control"  multiple="multiple" />

                                    <div id="clientDocError"  hidden=""  class="text-danger"><small>Please select a company logo to upload.</small></div>
                                </div>

                            </div>

                            <div class="row mb-3" id="logoViewMainDiv" style="display: none">

                                <label class="col-sm-2 col-form-label">View Client Logo </label>
                                <img class="col-sm-10" id="viewClientImage" src="#" alt="Uploaded Image">
                            </div>

                            <div class="row mb-3">

                                <div style="align-content: center" class="col-sm-4">
                                    <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Reference Member Details</label>
                                </div>

                                <div class="col-sm-8" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">First Name <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="clientFirstName" name="clientFirstName" />
                                    <div id="clientFirstNameError"  hidden=""  class="text-danger"><small>Please Enter First Name</small></div>
                                </div>

                                <label class="col-sm-2 col-form-label">Last Name <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="clientLastName" name="clientLastName"/>

                                    <div id="clientLastNameError"  hidden=""  class="text-danger"><small>Please Enter Last Name</small></div>
                                </div>
                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">NIC <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="clientNic" name="clientNic"/>

                                    <div id="clientNicError"  hidden=""  class="text-danger"><small>Please Enter NIC</small></div>
                                    <div id="clientNicinvalidError"  hidden=""  class="text-danger"><small>Please Enter a Valid NIC</small></div>
                                </div>
                                <label class="col-sm-2 col-form-label">Email <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="clientemail" name="clientemail" />

                                    <div id="clientemailError"  hidden=""  class="text-danger"><small>Please Enter Email</small></div>
                                    <div id="clientemailInvalidError"  hidden=""  class="text-danger"><small>Please Enter a Valid Email</small></div>
                                </div>
                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Telephone No <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="companycontactNo" name="companycontactNo" />

                                    <div id="companycontactNoError"  hidden=""  class="text-danger"><small>Please Enter Telephone No</small></div>
                                    <div id="companycontactNoinValidError"  hidden=""  class="text-danger"><small>Please Enter Valid Telephone No</small></div>
                                </div>
                                <label class="col-sm-2 col-form-label">Mobile No <label class="text-danger">*</label></label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="clientMobileNo" name="clientMobileNo"/>

                                    <div id="clientMobileNoErrr"  hidden=""  class="text-danger"><small>Please Enter Mobile No</small></div>
                                    <div id="clientMobileNoinValidErrr"  hidden=""  class="text-danger"><small>Please Enter a Valid Mobile No</small></div>
                                </div>
                            </div>

                            <div style="height: 10px;"></div>

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeclientData();">Cancel</button>
                                    <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>

            </div>
        </div> 
        <!--================================Add client_modal end==================================-->

        <!-- Core JS -->
        <!-- build:js assets/vendor/js/core.js -->
        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

        <script type="text/javascript">
                                        url = new URL(window.location.href);
                                        if (url.searchParams.has('messageSuccess')) {
                                            Swal.fire({
                                                title: 'Project created Successfully!',
                                                icon: 'success',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('messageError')) {
                                            Swal.fire({
                                                title: 'Data Not Saved',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('messageExistError')) {
                                            Swal.fire({
                                                title: 'Project Already Exists !',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('messageClientSuccess')) {
                                            Swal.fire({
                                                title: 'Successfully Saved',
                                                icon: 'success',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('messageClientError')) {
                                            Swal.fire({
                                                title: 'Data Not Saved',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('clientExistsError')) {
                                            Swal.fire({
                                                title: 'Client Already Exists !',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('clientMemkberExistsError')) {
                                            Swal.fire({
                                                title: 'Client Reference Member Already Exists !',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }
                                        
                                        if (url.searchParams.has('clientUserNameError')) {
                                            Swal.fire({
                                                title: 'UserName Already Used !',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }

                                        if (url.searchParams.has('messagelogoError')) {
                                            Swal.fire({
                                                title: 'Project Logo Can`t Empty !',
                                                icon: 'error',
                                                showConfirmButton: true,
                                                allowOutsideClick: true,
                                                allowEscapeKey: true,
                                                closeOnConfirm: false,
                                                timer: 1500,
                                            }).then(function () {
                                                window.location.href = 'create-projects.jsp';
                                            });

                                        }
        </script>

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
