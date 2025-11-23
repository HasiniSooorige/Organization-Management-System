<%-- 
    Document   : employeeList
    Created on : Oct 19, 2023, 12:28:30 PM
    Author     : HP
--%>

<%@page import="Model.Mapping.EmployeeDocuments"%>
<%@page import="Model.Logic.DesignationDAO"%>
<%@page import="Model.Mapping.Designation"%>
<%@page import="Model.Logic.DocumentTypeDAO"%>
<%@page import="Model.Mapping.DocumentType"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.Employee"%>
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

        <title>Exon Admin | Employee List</title>

        <meta name="description" content="" />
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>

        <script type="text/javascript" src="../assets/scripts/pages/ListofEmployee.js"></script>
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
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css"/>

        <link rel="stylesheet" href="../assets/css/projectStyles.css" type="text/css"/>

        <script type="text/javascript" src="../assets/js/uploadImg.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.5.6/tinymce.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/tinymce/4.5.6/jquery.tinymce.min.js"></script>

        <script src="https://cdn.tiny.cloud/1/no-api-key/tinymce/6/tinymce.min.js" referrerpolicy="origin"></script>
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

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>
        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />


        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <link rel="stylesheet" href="../assets/css/projectStyles.css" />
        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
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
                        <!-- Basic Layout & Basic with Icons -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Employee Manager</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Maintain . Employee Manager
                            </h6>
                            <div class="row">

                                <div class="card mb-4" id ="tableDiv">

                                    <div class="col-12 offset-12 mt-3 mb-3">

                                        <div style="float: left;">
                                            <div class="navbar-nav align-items-center">
                                                <div class="nav-item d-flex align-items-center">
                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchTable();">
                                                </div>
                                            </div>
                                        </div>

                                        <div style="float: right">
                                            <label>Type : &nbsp;&nbsp;&nbsp;&nbsp;</label>

                                            <input class="form-check-input" type="checkbox" value="" id="all" onclick="getEmpFilter();"  checked>
                                            <label class="form-check-label" for="all">
                                                All
                                            </label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input class="form-check-input" type="checkbox" value="" id="currentemployee" onclick="getEmpFilter();">
                                            <label class="form-check-label" for="currentemployee">
                                                Current Employees
                                            </label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input class="form-check-input" type="checkbox" value="" id="resignemployee" onclick="getEmpFilter();">
                                            <label class="form-check-label" for="resignemployee">
                                                Resign Employees
                                            </label>
                                        </div>
                                    </div> 
                                    <div class="table-responsive text-nowrap" id="empTableDataDiv">
                                        <table id="table_allusers"  class="table">
                                            <thead class="sticky-header" id="empTableHeader">
                                                <tr>
                                                    <th>Id</th>
                                                    <th>NIC</th>
                                                    <th>email</th>
                                                    <th>name</th>
                                                    <th>mobile no</th>
                                                    <th>profile completion</th>
                                                    <th>View</th>
                                                    <th>Action</th>
                                                    <th>Upload</th>
                                                    <th>Edit</th>
                                                    <th>Resignation</th>
                                                </tr>
                                            </thead>
                                            <tbody class="table-border-bottom-0" id="tablebody" >
                                                <%                                                    int table_row_id = 0;
                                                    for (Employee e : EmployeeDAO.listByQuery(sess, null, null)) {
                                                        table_row_id++;
                                                        if ((e.getIsActive() == Boolean.TRUE) && (e.getResignationDate() == null)) {

                                                %>
                                                <!--Active tr-->
                                                <tr  data-isactive="1">

                                                    <td><%=table_row_id%></td>
                                                    <td><%=e.getGeneralUserProfile().getNic()%></td>
                                                    <td><%=e.getGeneralUserProfile().getEmail()%></td>
                                                    <td><%=e.getGeneralUserProfile().getFirstName()%> <%=e.getGeneralUserProfile().getLastName()%></td>
                                                    <td><%=e.getGeneralUserProfile().getMobileNo()%></td>
                                                    <td>
                                                        <%
                                                            List<EmployeeDocuments> list = sess.createQuery("From EmployeeDocuments Where employee_id='" + e.getId() + "'").list();

                                                            int emp_doc_type = 0;
                                                            boolean type1Incremented = false;
                                                            boolean type2Incremented = false;
                                                            boolean type3Incremented = false;
                                                            boolean type4Incremented = false;

                                                            if (!list.isEmpty()) {
                                                                for (EmployeeDocuments empDoc : list) {
                                                                    if (empDoc.getDocumentType().getId() == 1 && !type1Incremented) {
                                                                        emp_doc_type += 25;
                                                                        type1Incremented = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 2 && !type2Incremented) {
                                                                        emp_doc_type += 25;
                                                                        type2Incremented = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 3 && !type3Incremented) {
                                                                        emp_doc_type += 25;
                                                                        type3Incremented = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 4 && !type4Incremented) {
                                                                        emp_doc_type += 25;
                                                                        type4Incremented = true;
                                                                    }
                                                                }
                                                            }
                                                        %>
                                                        <div class="progress">
                                                            <div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: <%= emp_doc_type%>%" aria-valuenow="<%= emp_doc_type%>%" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </td>
                                                    <td  style="color: #697a8d;"><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewRowData(<%=e.getId()%>);"></i></td>
                                                    <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="empActiveInactiveStatus(<%=e.getGeneralUserProfile().getId()%>, <%=e.getIsActive()%>);" id="activeButton">Inactive</button></td>  
                                                    <td><button  class="btn rounded-pill btn-outline-info" onclick="UploadRowData(<%=e.getId()%>);" >Upload</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-success" onclick="editRowData(<%=e.getGeneralUserProfile().getId()%>);" >Edit</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-warning" onclick="viewResignation(<%=e.getId()%>);" >Resignation</button></td>


                                                </tr>

                                                <%                                                                                                   } else if ((e.getIsActive() == Boolean.FALSE) && (e.getResignationDate() == null)) {

                                                %>
                                                <!--Inactive tr-->
                                                <tr class="table-danger" data-isactive="1">

                                                    <td><%=table_row_id%></td>
                                                    <td><%=e.getGeneralUserProfile().getNic()%></td>
                                                    <td><%=e.getGeneralUserProfile().getEmail()%></td>
                                                    <td><%=e.getGeneralUserProfile().getFirstName()%> <%=e.getGeneralUserProfile().getLastName()%></td>
                                                    <td><%=e.getGeneralUserProfile().getMobileNo()%></td>
                                                    <td>
                                                        <%
                                                            List<EmployeeDocuments> list = sess.createQuery("From EmployeeDocuments Where employee_id='" + e.getId() + "'").list();

                                                            int emp_doc_type_inactive = 0;
                                                            boolean type1Incremented_inactive = false;
                                                            boolean type2Incremented_inactive = false;
                                                            boolean type3Incremented_inactive = false;
                                                            boolean type4Incremented_inactive = false;

                                                            if (!list.isEmpty()) {
                                                                for (EmployeeDocuments empDoc : list) {
                                                                    if (empDoc.getDocumentType().getId() == 1 && !type1Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type1Incremented_inactive = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 2 && !type2Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type2Incremented_inactive = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 3 && !type3Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type3Incremented_inactive = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 4 && !type4Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type4Incremented_inactive = true;
                                                                    }
                                                                }
                                                            }
                                                        %>
                                                        <div class="progress">
                                                            <div class="progress-bar progress-bar-striped bg-danger" role="progressbar" style="width: <%= emp_doc_type_inactive%>%" aria-valuenow="<%= emp_doc_type_inactive%>%" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </td>
                                                    <td style="color: #697a8d;"><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewRowData(<%=e.getId()%>);"></i></td>
                                                    <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="empActiveInactiveStatus(<%=e.getGeneralUserProfile().getId()%>, <%=e.getIsActive()%>);" id="activeButton">Active</button></td>  
                                                    <td><button  class="btn rounded-pill btn-outline-info" onclick="UploadRowData(<%=e.getId()%>);" >Upload</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-success" onclick="editRowData(<%=e.getGeneralUserProfile().getId()%>);" >Edit</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-warning" onclick="viewResignation(<%=e.getId()%>);" >Resignation</button></td>

                                                </tr>
                                                <%                                                                                                   } else if ((e.getIsActive() == Boolean.FALSE) && (e.getResignationDate() != null)) {
                                                %>
                                                <!--Resign tr-->
                                                <tr class="table-warning" data-isactive="0">

                                                    <td><%=table_row_id%></td>
                                                    <td><%=e.getGeneralUserProfile().getNic()%></td>
                                                    <td><%=e.getGeneralUserProfile().getEmail()%></td>
                                                    <td><%=e.getGeneralUserProfile().getFirstName()%> <%=e.getGeneralUserProfile().getLastName()%></td>
                                                    <td><%=e.getGeneralUserProfile().getMobileNo()%></td>
                                                    <td>
                                                        <%
                                                            List<EmployeeDocuments> list = sess.createQuery("From EmployeeDocuments Where employee_id='" + e.getId() + "'").list();

                                                            int emp_doc_type_inactive = 0;
                                                            boolean type1Incremented_inactive = false;
                                                            boolean type2Incremented_inactive = false;
                                                            boolean type3Incremented_inactive = false;
                                                            boolean type4Incremented_inactive = false;

                                                            if (!list.isEmpty()) {
                                                                for (EmployeeDocuments empDoc : list) {
                                                                    if (empDoc.getDocumentType().getId() == 1 && !type1Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type1Incremented_inactive = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 2 && !type2Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type2Incremented_inactive = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 3 && !type3Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type3Incremented_inactive = true;
                                                                    } else if (empDoc.getDocumentType().getId() == 4 && !type4Incremented_inactive) {
                                                                        emp_doc_type_inactive += 25;
                                                                        type4Incremented_inactive = true;
                                                                    }
                                                                }
                                                            }
                                                        %>
                                                        <div class="progress">
                                                            <div class="progress-bar progress-bar-striped bg-warning" role="progressbar" style="width: <%= emp_doc_type_inactive%>%" aria-valuenow="<%= emp_doc_type_inactive%>%" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </td>
                                                    <td style="color: #697a8d;"><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewRowData(<%=e.getId()%>);"></i></td>
                                                    <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="empResignStatus();" id="activeButton">Resigned</button></td>  
                                                    <td><button  class="btn rounded-pill btn-outline-info" onclick="UploadRowData(<%=e.getId()%>);" >Upload</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-success" onclick="editRowData(<%=e.getGeneralUserProfile().getId()%>);" >Edit</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-warning" onclick="viewResignation(<%=e.getId()%>);" >Resignation</button></td>

                                                </tr>

                                                <%                                                        }

                                                    }
                                                %>
                                            </tbody>

                                            <tfoot>
                                                <tr id="emptableFootTr">
                                                    <td colspan="11">
                                                        <span style="float: left;">
                                                            <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                            <button type="button" class="btn btn-outline-primary" onclick="loadAllRows()" id="allButton">All</button>
                                                        </span>

                                                        <span style="float: right;">
                                                            <nav aria-label="Page navigation">
                                                                <ul class="pagination" id="pagination"></ul>
                                                            </nav>
                                                        </span>
                                                    </td>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                                <!-- Bootstrap Table with Header - Light -->
                            </div>
                        </div>

                        <!-- / Content -->



                        <div class="content-backdrop fade"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content wrapper -->

        <!------------------------------------------------ View Model ---------------------------------------------------->
        <div class="modal fade" id="largeModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mt-3 mb-4 mt-4"><span class="text-primary fw-light">Employee Details</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>

                    <div class="modal-body">

                        <form>
                            <div class="row mb-3">

                                <label class="col-sm-3 col-form-label" id="epfNoLable" style="display: none">EPF NO</label>
                                <div class="col-sm-9 mb-2" id="epfNoDiv" style="display: none">
                                    <input class="form-control" id="epf_no1" name="epf_no" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Registered Date</label>
                                <div class="col-sm-9 mb-2">
                                    <input type="date" class="form-control" id="regisered1" name="regisered" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Branch</label>
                                <div class="col-sm-9 mb-2">
                                    <input class="form-control" id="organization_by1" name="organization_by" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Designation</label>
                                <div class="col-sm-9">
                                    <input class="form-control" id="designation1" name="designation" readonly/>
                                </div>

                            </div>
                            <div class="row mb-3">
                                <label class="card-title text-primary" class="form-label" for="country_id">Basic Details</label>

                                <label class="col-sm-3 col-form-label">NIC</label>
                                <div class="col-sm-9 mb-2">
                                    <input
                                        class="form-control"
                                        type="text"
                                        id="nic1"
                                        name="nic"
                                        autofocus
                                        readonly />
                                </div>

                                <label class="col-sm-3 col-form-label">Gender</label>
                                <div class="col-sm-9 mb-2">
                                    <input class="form-control" id="gender1" name="gender1" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">First Name</label>
                                <div class="col-sm-9 mb-2">
                                    <input
                                        class="form-control"
                                        type="text"
                                        id="first_name1"
                                        name="first_name"
                                        autofocus
                                        readonly
                                        />
                                </div>

                                <label class="col-sm-3 col-form-label">Last Name</label>
                                <div class="col-sm-9 mb-2">
                                    <input class="form-control" type="text" name="last_name" id="last_name1" readonly />
                                </div>

                                <label class="col-sm-3 col-form-label">Date of Birth</label>
                                <div class="col-sm-9">
                                    <input class="form-control" type="date" name="dateofbirth" id="dateofbirth" readonly />
                                </div>

                            </div>


                            <div class="row mb-3">

                                <label class="card-title text-primary" class="form-label" for="country_id">Contact Details</label>

                                <label class="col-sm-3 col-form-label">E-mail</label>
                                <div class="col-sm-9 mb-2">
                                    <input class="form-control" type="text" id="email1" name="email" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Mobile No</label>
                                <div class="col-sm-9 mb-2">
                                    <input type="text" id="mobile_no1" name="mobile_no" class="form-control" readonly />
                                </div>

                                <label class="col-sm-3 col-form-label">Telephone No</label>
                                <div class="col-sm-9 mb-2">
                                    <input class="form-control" type="text" id="home_no1" name="home_no" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Emergency Contact No</label>
                                <div class="col-sm-9 mb-2">
                                    <input class="form-control" type="text" id="emergency_contact" name="emergency_contact" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Address 1</label>
                                <div class="col-sm-9 mb-2">
                                    <input type="text" class="form-control" id="address11" name="address1" readonly/>
                                </div>
                                <label class="col-sm-3 col-form-label">Address 2</label>
                                <div class="col-sm-9 mb-2">
                                    <input type="text" class="form-control" id="address21" name="address2" readonly/>
                                </div> 

                                <label class="col-sm-3 col-form-label">Address 3</label>
                                <div class="col-sm-9 mb-2">
                                    <input type="text" class="form-control" id="address31" name="address3" readonly/>
                                </div>

                                <label class="col-sm-3 col-form-label">Country</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="country_id1" name="country_id" readonly/>
                                </div>

                            </div>
                        </form>


                    </div>

                </div>
            </div>
        </div>    

        <!---------------------------------------------------------Resignation_modal-------------------------------------->
        <div class="modal fade" id="ResignationModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Employee Resignation</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-sm-12">
                                <input type="text" class="form-control resignLable" id="alreadyResign" name="alreadyResign" style="display: hide" readonly/>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Registered Date</label>
                            <div class="col-sm-4">
                                <input type="date" class="form-control" id="regisered1model2" name="regisered"  class="form-control" readonly/>
                            </div>
                            <label class="col-sm-2 col-form-label">Resignation Date <label class="text-danger">*</label></label>
                            <div class="col-sm-4">
                                <input type="date" value="" class="form-control" id="resignation" name="resignation" onclick="selectResignDate();" />

                                <div id="resignationDateError"  hidden=""  class="text-danger"><small>Please Enter Resignation Date</small></div>
                            </div>

                        </div>

                        <div style="height: 10px;"></div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="resignationClose();">Cancel</button>
                                <input type="text" class="d-none" id="inputid"/>
                                <button type="submit" class="btn rounded-pill btn-primary" style="width: 200px;" id="resbtn" onclick="ResignationSave();">Save</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>   

        <!---------------------------------------------------------Employee Active / Deactivate Modal-------------------------------------->
        <div class="modal fade" id="EmpActivationModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="deactivateTitle" style="display: hide;"><span class="text-primary fw-light">Employee Deactivation</span></h4> 
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="activateTitle" style="display: hide;"><span class="text-primary fw-light">Employee Activation</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3" id="deactivateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  deactivate  this  employee  account?</p>
                        </div>

                        <div class="row mb-3" id="activateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  activate  this  employee  account?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="deactiveGupId" name="deactiveGupId" readonly hidden/>
                            <input class="form-control" id="deactiveStatusId" name="deactiveStatusId" readonly hidden/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="DeactivationClose();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="DeactivationSave();">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!---------------------------------------------------------Employee Resignation Status Modal-------------------------------------->
        <div class="modal fade" id="EmpResignStatusModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Employee Resign</span></h4>

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">This employee has already resigned!</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="deactiveGupId" name="deactiveGupId" readonly hidden/>
                            <input class="form-control" id="deactiveStatusId" name="deactiveStatusId" readonly hidden/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="ResignStatusClose();">Close</button>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>   

        <!---------------------------------------------------------Edit Model-------------------------------------------->
        <div class="modal fade" id="EmpEditModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mt-3 mb-4" style="padding-top: 50px;"><span class="text-primary fw-light">Edit Employee Details</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">

                            <label class="col-sm-3 col-form-label" id="editEpfNoLable" style="display: hide;">EPF NO</label>
                            <div class="col-sm-9 mb-2" id="EditEpfNo">
                                <input class="form-control" id="epf_no" name="epf_no" readonly/>
                            </div>
                            <label class="col-sm-3 col-form-label">Registered Date</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="regisered" name="regisered" readonly/>
                            </div>

                            <label class="col-sm-3 col-form-label">Branch</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="generalorganizationname" name="generalorganizationname" readonly/>
                            </div>
                            <label class="col-sm-3 col-form-label">Designation</label>
                            <div class="col-sm-9">
                                <select id="designation" name="designation" class="select2 form-select">
                                    <%                                                                            for (Designation d : DesignationDAO.listByQuery(sess, null, null)) {

                                    %>
                                    <option value="<%=d.getId()%>"> <%=d.getName()%> </option>
                                    <% }

                                    %>
                                </select>

                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="card-title text-primary" class="form-label">Basic Details</label>
                        </div>


                        <div class="row mb-3">

                            <label class="col-sm-3 col-form-label">NIC</label>
                            <div class="col-sm-9 mb-2">
                                <input
                                    class="form-control"
                                    type="text"
                                    id="nic_edit"
                                    name="nic_edit" readonly
                                    />
                            </div>

                            <label class="col-sm-3 col-form-label">Gender</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="gender_edit" name="gender_edit" readonly/>
                            </div>


                            <label class="col-sm-3 col-form-label">First Name</label>
                            <div class="col-sm-9 mb-2">
                                <input
                                    class="form-control"
                                    type="text"
                                    id="first_name_edit"
                                    name="first_name_edit"
                                    autofocus
                                    />

                                <div id="first_nameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your First Name</small></div>
                            </div>


                            <label class="col-sm-3 col-form-label">Last Name</label>
                            <div class="col-sm-9 mb-2">
                                <input class="form-control" type="text" name="last_name_edit" id="last_name_edit"  />

                                <div id="last_nameErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Last Name</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Date of Birth</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="dobEdit" name="dobEdit" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="card-title text-primary" class="form-label">Contact Details</label>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-3 col-form-label">E-mail</label>
                            <div class="col-sm-9 mb-2">
                                <input
                                    class="form-control"
                                    type="text"
                                    id="email_edit"
                                    name="email_edit"

                                    />

                                <div id="emailErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Email</small></div>
                                <div id="emailErrNotify_valide"  hidden=""  class="text-danger"><small>Please Enter a Valid Email</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Mobile Number</label>
                            <div class="col-sm-9 mb-2">
                                <input
                                    type="text"
                                    id="mobile_no_edit"
                                    name="mobile_no_edit"
                                    class="form-control"
                                    />
                                <div id="mobile_noErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Mobile No</small></div>
                                <div id="mobile_noErrNotify_valide"  hidden=""  class="text-danger"><small>Please Enter a Valid Mobile No</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Telephone No</label>
                            <div class="col-sm-9 mb-2">
                                <input class="form-control" type="text" id="home_no_edit" name="home_no_edit" />

                                <div id="homenoErrNotify"  hidden=""  class="text-danger"><small>Please Enter Your Telephone No</small></div>
                                <div id="homeno_correctErrNotify"  hidden=""  class="text-danger"><small>Please Enter Valid Telephone No</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Emergency Contact No</label>
                            <div class="col-sm-9 mb-2">
                                <input class="form-control" type="text" id="emegencyContactEdit" name="emegencyContactEdit" />

                                <div id="emegencyContactEditErr"  hidden=""  class="text-danger"><small>Please Enter Emergency Contact No</small></div>
                                <div id="emegencyContactEditinvalidErr"  hidden=""  class="text-danger"><small>Please Enter Valid Emergency Contact No</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Address 1</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="address1_edit" name="address1_edit" />

                                <div id="address1ErrNotify"  hidden=""  class="text-danger"><small>Please Enter Address Line 1</small></div>
                            </div>
                            <label class="col-sm-3 col-form-label">Address 2</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="address2_edit" name="address2_edit"/>

                                <div id="address2ErrNotify"  hidden=""  class="text-danger"><small>Please Enter Address Line 2</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Address 3</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="address3_edit" name="address3_edit"/>

                                <div id="address3ErrNotify"  hidden=""  class="text-danger"><small>Please Enter Address Line 3</small></div>
                            </div>

                            <label class="col-sm-3 col-form-label">Country</label>
                            <div class="col-sm-9 mb-2">
                                <input type="text" class="form-control" id="coutry" name="coutry" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button  class="btn rounded-pill btn-outline-primary" onclick="close_employee_edit();" style="width: 200px;">Cancel</button>
                                <button type="submit"  class="btn rounded-pill btn-primary" onclick="validate_Employee_edit();" style="width: 200px;">Save</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>   

        <!---------------------------------------------------------Upload Model------------------------------------------>
        <div class="modal fade" id="EmpDocUploadModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4" style="padding-top: 50px;"><span class="text-primary fw-light">Employee Document Upload</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">
                        <form action="../EmployeeDocumentUpload" id="clientdetails" method="post" enctype="multipart/form-data" onsubmit="return empDocumentUpload();">   


                            <div class="row mb-3" hidden>
                                <input class="form-control" id="empId" name="empId"/>
                            </div>
                            <div class="row mb-3">
                                <div class="col-sm-4"><label class="col-form-label">Document Type <label class="text-danger">*</label></label></div>

                                <div class="col-sm-6">
                                    <select id="docType" name="docType" class="select2 form-select">
                                        <option selected disabled value="">Select Document Type</option>
                                        <%                                                                            for (DocumentType emp : DocumentTypeDAO.listByQuery(sess, null, null)) {
                                        %>
                                        <option value="<%=emp.getId()%>"> <%=emp.getName()%></option>
                                        <% }
                                        %>
                                    </select>

                                    <div id="typeError"  hidden=""  class="text-danger"><small>Please Select Document Type</small></div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-4"><label class="col-form-label">Document Name <label class="text-danger">*</label></label></div>

                                <div class="col-sm-6">
                                    <input class="form-control" id="docName" name="docName"/>

                                    <div id="nameError"  hidden=""  class="text-danger"><small>Please Enter Document Name</small></div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-4"><label class="col-form-label">Upload Document <label class="text-danger">*</label></label></div>

                                <div class="col-sm-6">
                                    <input accept="image/png, image/jpeg, image/jpg, .doc, .docx, .pdf" onclick="empDocUploader();" id="empDoc"  name="empDoc" type="file" value="" class="form-control"  multiple="multiple" />
                                    <input type="text" id="txt_base64" hidden />

                                    <div id="docNameError"  hidden=""  class="text-danger"><small>Please select a document to upload.</small></div>
                                </div>
                            </div>

                            <div class="row mb-3" style="display: none" id="imagePreview">

                                <label class="col-sm-4 col-form-label">Image Preview </label>

                                <img class="col-sm-6" id="empDocPreview" src="#" alt="Uploaded Document">

                            </div>  

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeEmpDocModel();">Cancel</button>
                                    <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>
                        </form>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-3">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Uploaded Documents</label>
                            </div>

                            <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3">
                            <div class="row" id="tableIntakeRowDocument">
                                <div class="col-sm-12">

                                    <table id="empDocumentTable" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Document Type</th>
                                                <th>Document Name</th>
                                                <th>Document</th>
                                                <th>View</th>
                                            </tr>
                                        </thead>

                                        <tbody id="empDocumentTableBody">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            url = new URL(window.location.href);
            if (url.searchParams.has('messageDocSuccess')) {
                Swal.fire({
                    title: 'Document Successfully Saved !',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'employee-list.jsp';
                });
            }

            if (url.searchParams.has('messageDocError')) {
                Swal.fire({
                    title: 'Document Name Can`t Empty !',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'employee-list.jsp';
                });
            }
        </script>

        <script>
            //       ----- Pagination  -----
            var currentPage = 1;
            var pageSize = 10;
            var tableRows = document.querySelectorAll("#tablebody tr");
            var totalPages = Math.ceil(tableRows.length / pageSize);

            function updatePagination() {
                var pagination = document.getElementById("pagination");
                pagination.innerHTML = "";

                if (totalPages <= 1) {
                    return;
                }

                var maxPageLinks;

                if (pageSize === 10) {
                    maxPageLinks = 100;
                } else if (pageSize === 25) {
                    maxPageLinks = 40;
                } else if (pageSize === 50) {
                    maxPageLinks = 20;
                }

                var startPage = Math.max(1, currentPage - Math.floor(maxPageLinks / 2));
                var endPage = Math.min(totalPages, startPage + maxPageLinks - 1);

                if (endPage - startPage < maxPageLinks - 1) {
                    startPage = Math.max(1, endPage - maxPageLinks + 1);
                }

                for (var i = startPage; i <= endPage; i++) {
                    var li = document.createElement("li");
                    li.className = "page-item";
                    var a = document.createElement("a");
                    a.className = "page-link";
                    a.href = "javascript:void(0);";
                    a.innerText = i;
                    a.onclick = function () {
                        currentPage = parseInt(this.innerText);
                        updateTable();
                    };
                    li.appendChild(a);
                    pagination.appendChild(li);
                }
            }

            function updateTable() {
                var startIndex = (currentPage - 1) * pageSize;
                var endIndex = currentPage * pageSize;

                tableRows.forEach(function (row, index) {
                    if (index >= startIndex && index < endIndex) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                });

                updatePagination();
            }

            function setPageSize(size) {
                pageSize = size;
                currentPage = 1;
                totalPages = Math.ceil(tableRows.length / pageSize);
                updateTable();

                var buttons = document.querySelectorAll('.page-size');
                buttons.forEach(function (button) {
                    if (button.getAttribute('data-size') === size.toString()) {
                        button.classList.add('active');
                    } else {
                        button.classList.remove('active');
                    }
                });
            }

            updateTable();
        </script>

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

        <script src="../assets/vendor/js/menu.js"></script>

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
