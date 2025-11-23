<%-- 
    Document   : projectList
    Created on : Aug 19, 2023, 3:53:18 PM
    Author     : HP
--%>


<%@page import="Model.Mapping.ProjectGopAgreement"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page import="Model.Logic.ProjectEmployeeRoleDAO"%>
<%@page import="Model.Mapping.ProjectEmployeeRole"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Logic.StatusDAO"%>
<%@page import="Model.Mapping.Status"%>
<%@page import="Model.Logic.ProjectsDAO"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Mapping.UserLogin"%>
<!DOCTYPE html>
<html lang="en"
      class="light-style layout-menu-fixed"
      dir="ltr"
      data-theme="theme-default"
      data-assets-path="../assets/"
      data-template="vertical-menu-template-free">
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />

        <title>Exon Admin | Project List</title> 

        <meta name="description" content="" />
        <!-- jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src= "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>
        <script type="text/javascript" src="../assets/scripts/pages/ListofProjects.js"></script>

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js" type="text/javascript"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.css" rel="stylesheet"/>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.5/sweetalert2.min.js"></script>

        <link href="//datatables.net/download/build/nightly/jquery.dataTables.css" rel="stylesheet" type="text/css" />
        <script src="//datatables.net/download/build/nightly/jquery.dataTables.js"></script>
        <script src="//cdn.rawgit.com/ashl1/datatables-rowsgroup/v1.0.0/dataTables.rowsGroup.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

        <!--paginatio-->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if ((!(request.getSession().getAttribute("GUP_ID") == null)) || (!(request.getSession().getAttribute("Emp_GUP") == null))) {


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
                                    Projects Manager</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Maintain . Projects Manager </span>
                            </h6>

                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4" id ="tableDiv">

                                    <div class="col-12 offset-12 mt-3 mb-3">
                                        <div style="float: left;">
                                            <div class="navbar-nav align-items-center">
                                                <div class="nav-item d-flex align-items-center">
                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchProjectTable();">
                                                </div>
                                            </div>
                                        </div>
                                        <div style="float: right">
                                            <label>Status: &nbsp;&nbsp;&nbsp;&nbsp;</label>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="all" onclick="filterTable();" checked>
                                                <label class="form-check-label" for="all">
                                                    All &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="pending" onclick="filterTable();">
                                                <label class="form-check-label" for="pending">
                                                    Pending &nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="ongoing" onclick="filterTable();">
                                                <label class="form-check-label" for="ongoing">
                                                    Ongoing &nbsp;&nbsp;&nbsp;&nbsp;
                                                </label>
                                            </span>
                                            <span>
                                                <input class="form-check-input" type="checkbox" value="" id="completed" onclick="filterTable();">
                                                <label class="form-check-label" for="completed">
                                                    Completed &nbsp;&nbsp;
                                                </label>
                                            </span>
                                        </div>
                                    </div>     


                                    <div class="table-responsive text-nowrap" id="tableDataDiv">
                                        <table id="table_projects"  class="table">

                                            <thead id="tbleHeader" class="sticky-header">
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Project</th>
                                                    <th>Client</th>
                                                    <th>Status</th>
                                                        <%                                                                if (!(request.getSession().getAttribute("GUP_ID") == null)) {    %>
                                                    <th>Agreement</th>
                                                        <% } %>
                                                    <th>View</th>
                                                        <%                                                                if (!(request.getSession().getAttribute("GUP_ID") == null)) {   %>
                                                    <th>Action</th>
                                                    <th>Upload</th>
                                                    <th>Edit</th>
                                                    <th>Team</th>
                                                        <% } %>
                                                </tr>
                                            </thead>

                                            <tbody class="table-border-bottom-0" id="tableempbody">

                                                <%
                                                    int table_row_id = 0;
                                                    if (!(request.getSession().getAttribute("GUP_ID") == null)) {

                                                        for (Projects e : ProjectsDAO.listByQuery(sess, null, null)) {
                                                            table_row_id++;
                                                            if (e.getIsActive() == Boolean.TRUE) {

                                                %>

                                                <tr class="table-success">

                                                    <td><%=table_row_id%> </td>
                                                    <td class="project-client-cell"><%=e.getName()%> </td>
                                                    <td class="project-client-cell"><%=e.getGeneralOrganizationProfile().getName()%></td>
                                                    <%
                                                        if (e.getStatus().getId() == 1) {
                                                    %>
                                                    <td><span class="badge bg-label-warning me-1"><%=e.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (e.getStatus().getId() == 2) {
                                                        %>
                                                    <td><span class="badge bg-label-info me-1"><%=e.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (e.getStatus().getId() == 3) {
                                                        %>
                                                    <td><span class="badge bg-label-success me-1"><%=e.getStatus().getName()%></span></td>
                                                        <%
                                                            }
                                                        %>
                                                    <td>
                                                        <%
                                                            List<ProjectGopAgreement> list = sess.createQuery("From ProjectGopAgreement Where projects_id='" + e.getId() + "'").list();
                                                            int emp_doc_type = 0;
                                                            if (!list.isEmpty()) {
                                                                emp_doc_type += 100;
                                                            }
                                                        %>
                                                        <div class="progress">
                                                            <div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width:<%= emp_doc_type%>%" aria-valuenow="<%= emp_doc_type%>%" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </td>
                                                    <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewProjectDetails(<%=e.getId()%>);"></i></td>
                                                    <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="projectActiveInactiveStatus(<%=e.getId()%>, <%=e.getIsActive()%>);" id="activeButton">Inactive</button></td>  
                                                    <td><button  class="btn rounded-pill btn-outline-info" onclick="uploadClientDocument(<%=e.getId()%>);" >Upload</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-success" onclick="editProjectDetails(<%=e.getId()%>);" >Edit</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-warning" onclick="ProjectTeamDetails(<%=e.getId()%>);" >Team</button></td>
                                                </tr>

                                                <%                                                                                                   } else {

                                                %>

                                                <tr  class="table-danger">

                                                    <td><%=table_row_id%> </td>
                                                    <td class="project-client-cell"><%=e.getName()%> </td>
                                                    <td class="project-client-cell"><%=e.getGeneralOrganizationProfile().getName()%></td>
                                                    <%
                                                        if (e.getStatus().getId() == 1) {
                                                    %>
                                                    <td><span class="badge bg-label-warning me-1"><%=e.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (e.getStatus().getId() == 2) {
                                                        %>
                                                    <td><span class="badge bg-label-info me-1"><%=e.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (e.getStatus().getId() == 3) {
                                                        %>
                                                    <td><span class="badge bg-label-success me-1"><%=e.getStatus().getName()%></span></td>
                                                        <%
                                                            }
                                                        %>
                                                    <td>
                                                        <%
                                                            List<ProjectGopAgreement> list = sess.createQuery("From ProjectGopAgreement Where projects_id='" + e.getId() + "'").list();
                                                            int emp_doc_type = 0;
                                                            if (!list.isEmpty()) {
                                                                emp_doc_type += 100;
                                                            }
                                                        %>
                                                        <div class="progress">
                                                            <div class="progress-bar progress-bar-striped bg-danger" role="progressbar" style="width:<%= emp_doc_type%>%" aria-valuenow="<%= emp_doc_type%>%" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </td>
                                                    <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewProjectDetails(<%=e.getId()%>);"></i></td>
                                                    <td><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="projectActiveInactiveStatus(<%=e.getId()%>, <%=e.getIsActive()%>);" id="activeButton">Active</button></td>  
                                                    <td><button  class="btn rounded-pill btn-outline-info" onclick="uploadClientDocument(<%=e.getId()%>);" >Upload</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-success" onclick="editProjectDetails(<%=e.getId()%>);" >Edit</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-warning" onclick="ProjectTeamDetails(<%=e.getId()%>);" >Team</button></td>
                                                </tr>
                                                <%                                                                                                   }
                                                    }

                                                } else if (!(request.getSession().getAttribute("Emp_GUP") == null)) {
                                                    int table_row_id_emp = 0;
                                                    Object empGupValue = request.getSession().getAttribute("Emp_GUP");
                                                    int empLoginId = (Integer) empGupValue;

                                                    Employee emp = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + empLoginId + "'").setMaxResults(1).uniqueResult();

                                                    Integer employeeeId = emp.getId();

                                                    List<ProjectEmployees> list = sess.createQuery("From ProjectEmployees Where employee_id='" + employeeeId + "'").list();

                                                    if (!list.isEmpty()) {
                                                        System.out.println("List Size : " + list.size());

                                                        for (ProjectEmployees pe : list) {
                                                            table_row_id_emp++;
                                                            if (pe.getProjects().getIsActive() == Boolean.TRUE) {
                                                %>



                                                <tr class="table-success">

                                                    <td><%=table_row_id_emp%> </td>
                                                    <td class="project-client-cell"><%=pe.getProjects().getName()%> </td>
                                                    <td class="project-client-cell"><%=pe.getProjects().getGeneralOrganizationProfile().getName()%></td>
                                                    <%
                                                        if (pe.getProjects().getStatus().getId() == 1) {
                                                    %>
                                                    <td><span class="badge bg-label-warning me-1"><%=pe.getProjects().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (pe.getProjects().getStatus().getId() == 2) {
                                                        %>
                                                    <td><span class="badge bg-label-info me-1"><%=pe.getProjects().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (pe.getProjects().getStatus().getId() == 3) {
                                                        %>
                                                    <td><span class="badge bg-label-success me-1"><%=pe.getProjects().getStatus().getName()%></span></td>
                                                        <%
                                                            }
                                                        %>
                                                    <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewProjectDetails(<%=pe.getProjects().getId()%>);"></i></td>
                                                </tr>

                                                <%                                                                                                   } else {

                                                %>

                                                <tr  class="table-danger">

                                                    <td><%=table_row_id_emp%> </td>
                                                    <td class="project-client-cell"><%=pe.getProjects().getName()%> </td>
                                                    <td class="project-client-cell"><%=pe.getProjects().getGeneralOrganizationProfile().getName()%></td>
                                                    <%
                                                        if (pe.getProjects().getStatus().getId() == 1) {
                                                    %>
                                                    <td><span class="badge bg-label-warning me-1"><%=pe.getProjects().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (pe.getProjects().getStatus().getId() == 2) {
                                                        %>
                                                    <td><span class="badge bg-label-info me-1"><%=pe.getProjects().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (pe.getProjects().getStatus().getId() == 3) {
                                                        %>
                                                    <td><span class="badge bg-label-success me-1"><%=pe.getProjects().getStatus().getName()%></span></td>
                                                        <%
                                                            }
                                                        %>
                                                    <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewProjectDetails(<%=pe.getProjects().getId()%>);"></i></td>
                                                </tr>

                                                <%
                                                                }
                                                            }
                                                        }

                                                    }


                                                %>
                                            </tbody>
                                            <tfoot>
                                                <tr  id="tableFootTr">
                                                    <td colspan="10">
                                                        <span class="page-size-buttons" style="float: left;">
                                                            <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                            <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                            <button type="button" class="btn btn-outline-primary" onclick="loadAllProjectRows()" id="allButton">All</button>
                                                        </span>

                                                        <span class="page-navigation" style="float: right;">
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


        <!--=============================Model - View Project Data Start==================================-->

        <div class="modal fade" id="viewProjectData" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Project Details</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">

                            <div class="col-sm-4"></div>

                            <div class="col-sm-4" id="projectLogoView" style="height: 250px;">
                                <img id="imgProject" src="#" alt="project logo" style="display: none;">
                            </div>
                            <div class="col-sm-4"></div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Name</label>

                            <div class="col-sm-10">
                                <textarea class="form-control" type="text" id="viewProName1" name="viewProName1" style="height: auto;" readonly></textarea>
                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Description</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" type="text" id="viewProDes1" name="viewProDes1" style="height: auto;" readonly></textarea>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Status</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text" id="status1" name="status" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Start Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewstartDate1" name="viewstartDate" readonly/>

                            </div>

                            <label class="col-sm-2 col-form-label">Complete Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewendDate1" name="viewendDate" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-3">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Project Document</label>
                            </div>

                            <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="proDocViewDiv" style="display: none; height: 50px;" >

                            <div class="col-sm-8" id="proDocumentName" style="float: left;">

                                <input class="form-control viewDocStyle" type="text" id="viewProDocument" name="viewProDocument" readonly/>

                            </div>

                            <div class="col-sm-4" id="proDocumentDiv" style="float: right;">
                                <button class="btn rounded-pill btn-outline-info" onclick="openProjectDocument();">View</button>
                            </div>
                        </div>

                        <div class="row mb-3" id="proDocViewDivEpmty" style="display: none">

                            <div class="col-sm-12" id="proDocumentName">

                                No Project Document Uploaded.

                            </div>

                        </div>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-2">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Project Team</label>
                            </div>

                            <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="proEmpListViewDiv" style="display: none">
                            <div class="row" id="tableIntakeRowView">
                                <div class="col-sm-12">

                                    <table id="allEmpRoleTableView" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Name</th>
                                                <th>Designation</th>
                                                <th>Project Role</th>
                                            </tr>
                                        </thead>

                                        <tbody id="empTableBodyView">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="proEmpListViewDivEmpty" style="display: none">

                            <div class="col-sm-12" id="proDocumentName">

                                No Active Members on the Project Team.

                            </div>

                        </div>


                        <%    if (!(request.getSession().getAttribute("GUP_ID") == null)) {
                                System.out.println("GUP_ID");
                        %>
                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-2">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Client Details</label>
                            </div>

                            <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Client Name</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" type="text" id="clientView1" name="clientView1" style="height: auto;" readonly></textarea>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Email</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="clientEmailView" name="clientEmailView" readonly/>
                            </div>

                            <label class="col-sm-2 col-form-label">Contact No</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="clientMoNoView" name="clientMoNoView" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Fax No</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="clientFaxNoView" name="clientFaxNoView" readonly/>
                            </div>

                            <label class="col-sm-2 col-form-label">Country</label>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" id="countryName1" name="countryName1" readonly/>
                            </div>
                        </div>

                        <% } %>
                    </div>


                </div>
            </div>

        </div>

        <!--================================Model - View Project Data end==================================-->

        <!--================================Model - Project Active / Deactivate start==================================-->

        <div class="modal fade" id="projectActivationModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="deactivateTitle" style="display: hide;"><span class="text-primary fw-light">Project Deactivation</span></h4> 
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="activateTitle" style="display: hide;"><span class="text-primary fw-light">Project Activation</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3" id="deactivateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  deactivate  this  project?</p>
                        </div>

                        <div class="row mb-3" id="activateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  activate  this  project?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="deactiveProId" name="deactiveProId" readonly hidden/>
                            <input class="form-control" id="deactiveStatusId" name="deactiveStatusId" readonly hidden/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="projectDeactivationClose();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="projectDeactivationSave();">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--================================Model - Project Active / Deactivate end==================================-->

        <!--=============================Model - Upload Project Document Start==================================-->

        <div class="modal fade" id="uploadClientDocument" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Upload Client Agreement</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <form action="../ClientDocumentUpload" id="clientDocumentUpload" method="post" enctype="multipart/form-data" onsubmit="return uploadClientDoc();">


                            <div class="row mb-3" hidden>

                                <label class="col-sm-2 col-form-label">Row Id :</label>
                                <div class="col-sm-10">
                                    <input class="form-control" id="rowId" name="rowId"/>
                                </div>
                            </div>


                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Agreement <label class="text-danger">*</label></label>
                                <div class="col-sm-10">
                                    <input id="clientDocs"  name="clientDocs" type="file" value="" class="form-control"  accept=".pdf" />
                                    <input type="text" id="txt_base64" hidden />

                                    <div id="clientDocError"  hidden=""  class="text-danger"><small>Please select a client agreement to upload.</small></div>

                                </div>
                                <div style="height: 10px;"></div>


                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeClientUpload();">Cancel</button>
                                    <button type="submit" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>

                        </form>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-3">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Agreement History</label>
                            </div>

                            <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="clientAgreementListViewDiv" style="display: none">
                            <div class="row" id="tableIntakeRowAgreement">
                                <div class="col-sm-12">

                                    <table id="agreementTable" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Agreement</th>
                                                <th>Uploaded Date</th>
                                                <th>View</th>
                                            </tr>
                                        </thead>

                                        <tbody id="agreementTableBody">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="clientAgreementListViewDivEmpty" style="display: none">

                            <div class="col-sm-12" id="proDocumentName">

                                No Client Agreement Uploaded.

                            </div>

                        </div>

                    </div>


                </div>
            </div>

        </div>

        <!--================================Model - Upload Project Document end==================================-->

        <!--=============================Model - Edit Project Data Start==================================-->

        <div class="modal fade" id="editProjectDetails" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Update Project Details</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <form action="../EditProjectData" enctype="multipart/form-data" id="clientdetails" method="post" onsubmit="return editProjectDataValidate();">

                            <div class="row mb-3" hidden>

                                <label class="col-sm-2 col-form-label">Row Id</label>
                                <div class="col-sm-10">
                                    <input class="form-control" id="rowIdEdit" name="rowIdEdit"/>
                                </div>
                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Name</label>

                                <div class="col-sm-10">

                                    <textarea class="form-control" type="text" id="editProName1" name="editProName1"></textarea>

                                </div>

                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Description</label>
                                <div class="col-sm-10">
                                    <textarea class="form-control" type="text" id="editProDes1" name="editProDes1"></textarea>

                                    <div id="proEditDiscError"  hidden  class="text-danger"><small>Please Enter Project Description.</small></div>
                                </div>
                            </div>

                            <div class="row mb-3" hidden>

                                <label class="col-sm-2 col-form-label">Status</label>
                                <div class="col-sm-10">
                                    <select id="editstatus1" name="editstatus1" class="select2 form-select">
                                        <%                                                                            for (Status sts : StatusDAO.listByQuery(sess, null, null)) {
                                        %>
                                        <option value="<%=sts.getId()%>"> <%=sts.getName()%></option>
                                        <% }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Start Date</label>

                                <div class="col-sm-4">

                                    <input class="form-control" type="date" id="startDate" name="startDate" readonly/>

                                </div>

                                <label class="col-sm-2 col-form-label">Complete Date</label>

                                <div class="col-sm-4">

                                    <input class="form-control" type="date" id="endDate" name="endDate" onclick="selectEndDate();"/>

                                </div>

                            </div>

                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Project Document</label>
                                <div class="col-sm-10">
                                    <input id="proDocs"  name="proDocs" type="file" value="" class="form-control"  multiple="multiple" accept="image/png, image/jpeg, image/jpg, .doc, .docx, .pdf, .mp4"/>
                                    <input type="text" id="txt_base64" hidden />
                                     <small>Only .png, .jpg, .jpeg, .doc, .docx, .pdf and .mp4 files are allowed.</small>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeEditProject();">Cancel</button>
                                    <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>

                        </form>
                    </div>


                </div>
            </div>

        </div>

        <!--================================Model - Edit Project Data end==================================-->

        <!--=============================Model - Project Team Start==================================-->

        <div class="modal fade" id="projectTeamtDetails" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Project Team Details</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <label >Current Team Members</label>
                        </div>

                        <div class="row mb-3" id="currentTeamDiv" style="display: none;">
                            <div class="row" id="tableIntakeRowEdit">
                                <div class="col-sm-12">

                                    <table id="allEmpRoleTableEdit" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Name</th>
                                                <th>Designation</th>
                                                <th>Project Role</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>

                                        <tbody id="empTableBodyEdit">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="currentTeamDivEmpty" style="display: none">

                            <div class="col-sm-12">

                                No Current Team Members.

                            </div>

                        </div>

                        <form action="../ProjectTeamUpdate" enctype="multipart/form-data" id="projectTeam" method="post" onsubmit="return updateProTeam();">

                            <div class="row mb-3" hidden>

                                <label class="col-sm-2 col-form-label">Row Id</label>
                                <div class="col-sm-10">
                                    <input class="form-control" id="rowIdProTeam" name="rowIdProTeam"/>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label >Add New Members</label>
                            </div>

                            <div class="row mb-3">

                                <div class="col-sm-5">
                                    <select id="empNameEditForm" name="empNameEditForm" class="select2 form-select">
                                        <option selected disabled value="">Select Employee</option>
                                        <%                                                                            for (Employee emp : EmployeeDAO.listByQuery(sess, null, null)) {
                                                if (emp.getIsActive() == Boolean.TRUE) {
                                        %>
                                        <option value="<%=emp.getId()%>"> <%=emp.getGeneralUserProfile().getFirstName()%> <%=emp.getGeneralUserProfile().getLastName()%> - <%=emp.getDesignation().getName()%> </option>
                                        <% }
                                            }
                                        %>
                                    </select>
                                    <div id="empNameErrNotifyEditForm"  hidden=""  class="text-danger"><small>Please Select Employee</small></div>
                                </div>

                                <div class="col-sm-5">
                                    <select id="projectroleEditForm" name="projectroleEditForm" class="select2 form-select" onchange="checkDuplicateEmpProjectTeam();">
                                        <option selected disabled value="">Select Employee Role</option>
                                        <%                                                                            for (ProjectEmployeeRole p : ProjectEmployeeRoleDAO.listByQuery(sess, null, null)) {
                                        %>
                                        <option value="<%=p.getId()%>"> <%=p.getName()%> </option>
                                        <% }
                                        %>
                                    </select>
                                    <div id="proRoleErrNotifyEditForm"  hidden=""  class="text-danger"><small>Please Select Employee Role</small></div>
                                    <div id="empalreadyexistEditForm"  hidden=""  class="alert-box mt-3 error text-danger"><small>Employee is already enrolled in this employee role !</small></div>
                                </div>

                                <div class="col-sm-2">

                                    <button type="button" class="btn rounded-pill btn-outline-secondary" style="width: 100%" id="saveEmpRole" name="saveEmpRole" onclick="addNewRowEmpRoleEditForm();">Save</button>

                                </div>

                                <div style="height: 10px;"></div>
                            </div>

                            <div class="row mb-3">
                                <div class="row" id="tableIntakeRowEditForm" style="display: none;">
                                    <div class="col-sm-12">

                                        <table id="allEmpTableEditForm" class="table">
                                            <thead class="table-light">
                                                <tr>
                                                    <th hidden>Employee Id</th>
                                                    <th>Name & Designation</th>
                                                    <th hidden>Project Role ID</th>
                                                    <th>Project Role</th>
                                                    <th>Remove</th>
                                                </tr>
                                            </thead>

                                            <tbody class="table-border-bottom-0" id="empTableBodyEditForm">

                                            </tbody>
                                        </table>

                                    </div>
                                </div>
                                <div id="emptableErrNotifyEditForm"  hidden=""  class="text-danger"><small>Please assign the employee to a project role!</small></div> 
                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeProjectTeam();">Cancel</button>
                                    <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>
                        </form>

                    </div>


                </div>
            </div>

        </div>

        <!--================================Model - Project Team end==================================-->

        <script type="text/javascript">
            url = new URL(window.location.href);
            if (url.searchParams.has('ClientSuccess')) {
                Swal.fire({
                    title: 'Successfully Saved',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
                });
            }

            if (url.searchParams.has('ClientError')) {
                Swal.fire({
                    title: 'Data Not Saved',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
                });
            }

            if (url.searchParams.has('DocUploadError')) {
                Swal.fire({
                    title: 'No file selected for upload. Please choose a file to upload before proceeding !',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
                });
            }

            if (url.searchParams.has('messageSuccess')) {
                Swal.fire({
                    title: 'Successfully Saved',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
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
                    window.location.href = 'project-list.jsp';
                });
            }

            if (url.searchParams.has('projectTeamSuccess')) {
                Swal.fire({
                    title: 'Project Team Successfully Updated !',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
                });
            }

            if (url.searchParams.has('projectTeamError')) {
                Swal.fire({
                    title: 'Project Team not Updated. One of the Project Employees Already Exists !',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
                });
            }

            if (url.searchParams.has('projectTeamAlreadyError')) {
                Swal.fire({
                    title: 'Project Employee Already Exists !',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    window.location.href = 'project-list.jsp';
                });
            }


        </script>
        <script>
            //       ----- Pagination  OnLoad-----
            var currentPage = 1;
            var pageSize = 10;
            var tableRows = document.querySelectorAll("#tableempbody tr");
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
        <script src="multiselect.min.js"></script>

        <script src="../assets/vendor/js/menu.js"></script>

        <script src="../assets/js/main.js"></script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

        <script src="../assets/js/pages-account-settings-account.js"></script>

        <script async defer src="https://buttons.github.io/buttons.js"></script>

    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
