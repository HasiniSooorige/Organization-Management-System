<%-- 
    Document   : taskList
    Created on : Oct 12, 2023, 11:09:17 AM
    Author     : HP
--%>

<%@page import="Model.Mapping.TaskAssignEmployees"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page import="Model.Logic.ProjectTasksDAO"%>
<%@page import="Model.Logic.ProjectTaskPriorityDAO"%>
<%@page import="Model.Mapping.ProjectTaskPriority"%>
<%@page import="Model.Mapping.ProjectTasks"%>
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

        <title>Exon Admin | Task Manager</title> 

        <meta name="description" content="" />
        <!-- jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
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

        <!-- Page CSS -->

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>

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

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

        <script src="../assets/scripts/pages/projectTaskList.js"></script>
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
                <!-- Menu -->
                <%@include  file="../main-pages/includes/admin-panel.jsp" %>
                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@include file="../main-pages/includes/header.jsp" %>
                    <!-- / Navbar -->
                    <div class="content-wrapper">
                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">Task Manager</span></h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Maintain . Task Manager
                            </h6>

                            <div class="row">
                                <!-- Basic Layout -->


                                <div class="card mb-4" id ="tableDiv">
                                    <div class="col-12 mt-3 mb-3">
                                        <div style="float: left;">
                                            <div class="navbar-nav align-items-center">
                                                <div class="nav-item d-flex align-items-center">
                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchTask();">
                                                </div>
                                            </div>
                                        </div>
                                        <div  style="float: right;">
                                            <table>
                                                <tr>
                                                    <td><label>Status:</label></td>
                                                    <td  style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="allStatus" onclick="filterTableByStatus();" checked>
                                                        <label class="form-check-label" for="all">
                                                            All
                                                        </label>
                                                    </td>
                                                    <td style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Pending" onclick="filterTableByStatus();">
                                                        <label class="form-check-label" for="Pending">
                                                            Pending
                                                        </label>
                                                    </td>
                                                    <td  style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Ongoing" onclick="filterTableByStatus();">
                                                        <label class="form-check-label" for="Ongoing">
                                                            Ongoing
                                                        </label>
                                                    </td>
                                                    <td  style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Completed" onclick="filterTableByStatus();">
                                                        <label class="form-check-label" for="completed">
                                                            Completed
                                                        </label>
                                                    </td>
                                                    <td style="padding-left: 20px;"></td>
                                                </tr>
                                                <tr height="10"></tr>
                                                <tr>
                                                    <td><label>Priority :</label></td>
                                                    <td style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="allPriority" onclick="filterTableByPriority();" checked>
                                                        <label class="form-check-label" for="allPriority">
                                                            All
                                                        </label>
                                                    </td>
                                                    <td  style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Urgent" onclick="filterTableByPriority();">
                                                        <label class="form-check-label" for="Urgent">
                                                            Urgent
                                                        </label>
                                                    </td>
                                                    <td  style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Important" onclick="filterTableByPriority();">
                                                        <label class="form-check-label" for="Important">
                                                            Important
                                                        </label>
                                                    </td>
                                                    <td style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Medium" onclick="filterTableByPriority();">
                                                        <label class="form-check-label" for="Medium">
                                                            Medium
                                                        </label>
                                                    </td>
                                                    <td  style="padding-left: 20px;">
                                                        <input class="form-check-input" type="checkbox" value="" id="Low" onclick="filterTableByPriority();">
                                                        <label class="form-check-label" for="Low">
                                                            Low
                                                        </label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>     


                                    <div class="table-responsive text-nowrap" id="tableDataDivTask">
                                        <table id="task_project_table"  class="table">
                                            <thead id="tbleHeaderTask" class="sticky-header">
                                            <th>Project Name</th>
                                            <th>Task Id</th>
                                            <th>Task Name</th>
                                            <th>Priority</th>
                                            <th>Status</th>
                                            <th>Due Date</th>
                                            <th>View</th>
                                                <%                                                        if (!(request.getSession().getAttribute("GUP_ID") == null)) {
                                                        System.out.println("GUP_ID");
                                                %>
                                            <th>Assign</th>
                                            <th>Action</th>
                                            <th>Upload</th>
                                            <th>Edit</th>
                                            <th>Team</th>
                                            <th>Comments</th>
                                                <% } else if (!(request.getSession().getAttribute("Emp_GUP") == null)) { %>
                                            <th>Action</th>
                                            <th>Upload</th>
                                            <th>Comments</th>
                                                <% } %>
                                            </thead>


                                            <tbody class="table-border-bottom-0" id="task_project_table_body">



                                                <%
                                                    int table_row_id = 0;
                                                    if (!(request.getSession().getAttribute("GUP_ID") == null)) {

                                                        Object AdminGupValue = request.getSession().getAttribute("GUP_ID");
                                                        int adminLoginId = (Integer) AdminGupValue;

                                                        Employee admin = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + adminLoginId + "'").setMaxResults(1).uniqueResult();
                                                        Integer adminId = admin.getId();

                                                        String project_row_color = "table-default";
                                                        String task_row_color = "table-default";

                                                        for (Projects e : ProjectsDAO.listByQuery(sess, null, null)) {
                                                            boolean projectDisplayed = false;
                                                            if (e.getIsActive() == Boolean.TRUE) {
                                                                project_row_color = "table-success";
                                                            } else {
                                                                project_row_color = "table-danger";
                                                            }
                                                %>

                                                <tr style="border-top: #cccccc solid;" class="table-success" id="mainTbleRow">

                                                    <%
                                                        for (ProjectTasks p : ProjectTasksDAO.listByQuery(sess, null, null)) {
                                                            if (e.getId() == p.getProjects().getId()) {
                                                                table_row_id++;
                                                                if (p.getIsActive() == Boolean.TRUE) {
                                                                    task_row_color = "table-success";
                                                                } else {
                                                                    task_row_color = "table-danger";
                                                                }


                                                    %>
                                                    <td class="project-client-cell <%=project_row_color%>" id="projectNameCell">
                                                        <%                                                            if (!projectDisplayed) {
                                                                out.print(e.getName());
                                                                projectDisplayed = true;
                                                            }
                                                        %>
                                                    </td>
                                                    <td class="<%=task_row_color%>" id="taskIdCell"><%=table_row_id%></td>
                                                    <td class="project-client-cell <%=task_row_color%>"><%=p.getName()%></td>
                                                    <td class="<%=task_row_color%>"><%=p.getProjectTaskPriority().getName()%></td>
                                                    <%
                                                        if (p.getStatus().getId() == 1) {
                                                    %>
                                                    <td class="<%=task_row_color%>"><span class="badge bg-label-warning me-1"><%=p.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (p.getStatus().getId() == 2) {
                                                        %>
                                                    <td class="<%=task_row_color%>"><span class="badge bg-label-info me-1"><%=p.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (p.getStatus().getId() == 3) {
                                                        %>
                                                    <td class="<%=task_row_color%>"><span class="badge bg-label-success me-1"><%=p.getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (p.getStatus().getId() == 4) {
                                                        %>
                                                    <td class="<%=task_row_color%>"><span class="badge bg-label-primary me-1"><%=p.getStatus().getName()%></span></td>
                                                        <%
                                                            }
                                                        %>
                                                    <td class="<%=task_row_color%>"><%=p.getDueDate()%></td>

                                                    <td class="<%=task_row_color%>"><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewTaskDetails(<%=p.getId()%>);"></i></td>

                                                    <!-----------------------> 
                                                    <%
                                                        ProjectEmployees adminProject = (ProjectEmployees) sess.createQuery("From ProjectEmployees Where employee_id='" + adminId + "'  and projects_id = '" + e.getId() + "' ").setMaxResults(1).uniqueResult();

                                                        if (adminProject != null) {
                                                            Integer projectEmpAdminId = adminProject.getId();

                                                            TaskAssignEmployees taskAdminTAE = (TaskAssignEmployees) sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmpAdminId + "'  and project_tasks_id = '" + p.getId() + "'").setMaxResults(1).uniqueResult();

                                                            if (taskAdminTAE != null) {
                                                    %>


                                                    <% if (taskAdminTAE.getStartDate() == null && taskAdminTAE.getEndDate() == null) {%>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-danger" style="width: 150px;" onclick="taskAdmitAction(<%=taskAdminTAE.getId()%>)" >Admit Task</button></td>
                                                    <%  } else if (taskAdminTAE.getStartDate() != null && taskAdminTAE.getEndDate() == null) {%>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-success" style="width: 150px;" onclick="taskEndAction(<%=taskAdminTAE.getId()%>, <%=taskAdminTAE.getProjectEmployees().getProjects().getId()%>, <%=taskAdminTAE.getProjectTasks().getId()%>)" >End Task</button></td>
                                                    <% } else if (taskAdminTAE.getStartDate() != null && taskAdminTAE.getEndDate() != null) {%>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-warning" style="width: 150px;" onclick="endTaskNote();" >Task End</button></td>
                                                    <% }%>

                                                    <%                                                                        } else {
                                                    %>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-dark" style="width: 150px;" onclick="notAssignTaskNote();" >Not Assign</button></td>
                                                    <%
                                                        }

                                                    } else {

                                                    %>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-dark" style="width: 150px;" onclick="notAssignTaskNote();" >Not Assign</button></td>
                                                    <%
                                                        }
                                                    %>

                                                    <% if (p.getIsActive() == Boolean.TRUE) {%>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="taskActiveStatus(<%=e.getId()%>, <%=e.getIsActive()%>, <%=p.getId()%>, <%=p.getIsActive()%>);" >Inactive</button></td>
                                                    <% } else if (p.getIsActive() == Boolean.FALSE) {%>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-danger" style="width: 110px;" onclick="taskActiveStatus(<%=e.getId()%>, <%=e.getIsActive()%>, <%=p.getId()%>, <%=p.getIsActive()%>);" >Active</button></td>
                                                    <% }%>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-info" onclick="uploadTaskDocument(<%=p.getId()%>);" >Upload</button></td>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-success" onclick="editTaskDetails(<%=p.getId()%>);" >Edit</button></td>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-warning" onclick="taskTeamMembers(<%=p.getId()%>, <%=e.getId()%>);" >Team</button></td>
                                                    <td class="<%=task_row_color%>"><button  class="btn rounded-pill btn-outline-primary" onclick="taskComments(<%=p.getId()%>, <%=e.getId()%>)" >Comments</button></td>
                                                </tr>



                                                <%

                                                            }

                                                        }
                                                    }
                                                } else if (!(request.getSession().getAttribute("Emp_GUP") == null)) {
                                                    int table_row_id_emp = 0;
                                                    for (Projects e : ProjectsDAO.listByQuery(sess, null, null)) {
                                                        boolean projectDisplayed = false;
                                                        if (e.getIsActive() == Boolean.TRUE) {


                                                %>

                                                <tr  style="border-top: #cccccc solid !important;" id="mainTbleRow">

                                                    <%                                                            Object empGupValue = request.getSession().getAttribute("Emp_GUP");
                                                        int empLoginId = (Integer) empGupValue;

                                                        Employee emp = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + empLoginId + "'").setMaxResults(1).uniqueResult();
                                                        Integer employeeeId = emp.getId();

                                                        List<ProjectEmployees> listProject = sess.createQuery("From ProjectEmployees Where employee_id='" + employeeeId + "'").list();

                                                        if (!listProject.isEmpty()) {

                                                            for (ProjectEmployees pe : listProject) {

                                                                Integer projectEmployee = pe.getId();

                                                                List<TaskAssignEmployees> listTask = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmployee + "'").list();

                                                                if (!listTask.isEmpty()) {

                                                                    for (TaskAssignEmployees tae : listTask) {

                                                                        if (e.getId() == tae.getProjectTasks().getProjects().getId()) {
                                                                            if (tae.getProjectTasks().getIsActive() == Boolean.TRUE) {
                                                                                table_row_id_emp++;

                                                    %>

                                                    <td class="project-client-cell">
                                                        <%                                                            if (!projectDisplayed) {
                                                                out.print(e.getName());
                                                                projectDisplayed = true;
                                                            }
                                                        %>
                                                    </td>
                                                    <td><%=table_row_id_emp%></td>
                                                    <td class="project-client-cell"><%=tae.getProjectTasks().getName()%></td>
                                                    <td><%=tae.getProjectTasks().getProjectTaskPriority().getName()%></td>
                                                    <%
                                                        if (tae.getProjectTasks().getStatus().getId() == 1) {
                                                    %>
                                                    <td><span class="badge bg-label-warning me-1"><%=tae.getProjectTasks().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (tae.getProjectTasks().getStatus().getId() == 2) {
                                                        %>
                                                    <td><span class="badge bg-label-info me-1"><%=tae.getProjectTasks().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (tae.getProjectTasks().getStatus().getId() == 3) {
                                                        %>
                                                    <td><span class="badge bg-label-success me-1"><%=tae.getProjectTasks().getStatus().getName()%></span></td>
                                                        <%
                                                        } else if (tae.getProjectTasks().getStatus().getId() == 4) {
                                                        %>
                                                    <td><span class="badge bg-label-primary me-1"><%=tae.getProjectTasks().getStatus().getName()%></span></td>
                                                        <%
                                                            }
                                                        %>
                                                    <td><%=tae.getProjectTasks().getDueDate()%></td>
                                                    <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewTaskDetails(<%=tae.getProjectTasks().getId()%>);"></i></td>
                                                        <% if (tae.getStartDate() == null && tae.getEndDate() == null) {%>
                                                    <td><button  class="btn rounded-pill btn-outline-danger" style="width: 150px;" onclick="taskAdmitAction(<%=tae.getId()%>)" >Admit Task</button></td>
                                                    <%  } else if (tae.getStartDate() != null && tae.getEndDate() == null) {%>
                                                    <td><button  class="btn rounded-pill btn-outline-success" style="width: 150px;" onclick="taskEndAction(<%=tae.getId()%>, <%=tae.getProjectEmployees().getProjects().getId()%>, <%=tae.getProjectTasks().getId()%>)" >End Task</button></td>
                                                    <% } else if (tae.getStartDate() != null && tae.getEndDate() != null) {%>
                                                    <td><button  class="btn rounded-pill btn-outline-warning" style="width: 150px;" onclick="endTaskNote();" >Task End</button></td>
                                                    <% }%>
                                                    <td><button  class="btn rounded-pill btn-outline-info" onclick="uploadTaskDocument(<%=tae.getProjectTasks().getId()%>);" >Upload</button></td>
                                                    <td><button  class="btn rounded-pill btn-outline-primary" onclick="taskComments(<%=tae.getProjectTasks().getId()%>, <%=tae.getProjectTasks().getProjects().getId()%>)">Comments</button></td>
                                                </tr>

                                                <%}

                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }

                                                        }
                                                    }
                                                %>
                                            </tbody>
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

        <!--=============================Model - View Task Details Start==================================-->

        <div class="modal fade" id="viewTaskDetails" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Task Details</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Name</label>

                            <div class="col-sm-10">
                                <textarea class="form-control" type="text" id="viewName" name="viewName" style="height: auto;" readonly></textarea>
                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Note</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" type="text" id="viewNote" name="viewNote" style="height: auto;" readonly></textarea>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Priority</label>

                            <div class="col-sm-4">
                                <input class="form-control" type="text" id="viewPriority" name="viewPriority" readonly/>
                            </div>

                            <label class="col-sm-2 col-form-label">Status</label>

                            <div class="col-sm-4">
                                <input class="form-control" type="text" id="viewStatus" name="viewStatus" readonly/>
                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Assign Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewAssignDate" name="viewAssignDate" readonly/>

                            </div>

                            <label class="col-sm-2 col-form-label">Due Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewDueDate" name="viewDueDate" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Start Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewstartDate" name="viewstartDate" readonly/>

                            </div>

                            <label class="col-sm-2 col-form-label">End Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewEndDate" name="viewEndDate" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Complete Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewCompleteDate" name="viewCompleteDate" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-3">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Task Documents</label>
                            </div>

                            <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="TaskDocDiv" style="display: none;">

                            <div class="row">
                                <div class="col-sm-12">

                                    <table id="taskDocTable" class="table">

                                        <tbody id="taskDocTableBody">

                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="TaskDocDivEmpty" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12" >
                                    No Task Documents Uploaded.
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-2">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Task Team</label>
                            </div>

                            <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="taskTeamDiv" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12">

                                    <table id="taskEmp" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Name</th>
                                                <th>Designation</th>
                                                <th>Project Role</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                            </tr>
                                        </thead>

                                        <tbody id="taskEmpBody">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="taskTeamDivEmpty" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12" >
                                    No Active Members on the Task Team.
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>

        <!--================================Model - View Task Details end==================================-->     

        <!--=============================Model - Active/ Deactive Task Start==================================-->

        <div class="modal fade" id="taskActiveInactiveModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="deactivateTitle" style="display: hide;"><span class="text-primary fw-light">Task Deactivation</span></h4> 
                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;" id="activateTitle" style="display: hide;"><span class="text-primary fw-light">Task Activation</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3" id="deactivateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  deactivate  this project task?</p>
                        </div>

                        <div class="row mb-3" id="activateMsg" style="display: hide;">
                            <p class="col-sm-12">Do  you  want  to  activate  this  project  task?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="deactiveProjectId" name="deactiveProjectId" readonly hidden/>
                            <input class="form-control" id="deactiveTaskId" name="deactiveTaskId" readonly hidden/>
                            <input class="form-control" id="deactiveStatusId" name="deactiveStatusId" readonly hidden/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="taskDeactivationClose();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="taskDeactivationSave();">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--=============================Model - Active/ Deactive Task End==================================-->

        <!--=============================Model - Inactive Project Status Task Start==================================-->

        <div class="modal fade" id="DeactiveProjectTaskStatusModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Task Deactivated</span></h4>

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">The Project is Already Inactive. The Task Cannot be Activated. </p>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="DeactiveProjectTask();">Close</button>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>   

        <!--=============================Model - Inactive Project Status Task End==================================-->

        <!--=============================Model - Upload Task Document Start==================================-->

        <div class="modal fade" id="uploadTaskDocument" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Upload Task Document</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>
                    </div>

                    <div class="modal-body">

                        <form action="../TaskDocumentUpload" id="clientDocumentUpload" method="post" enctype="multipart/form-data" onsubmit="return saveTaskDocument();">


                            <div class="row mb-3" hidden>

                                <label class="col-sm-2 col-form-label" for="basic-default-name">Task Id</label>
                                <div class="col-sm-10">
                                    <input class="form-control" id="rowId" name="rowId"/>
                                </div>
                            </div>


                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label" for="basic-default-name">Document <label class="text-danger">*</label></label>
                                <div class="col-sm-10">
                                    <input accept="image/png, image/jpeg, image/jpg, .doc, .docx, .pdf, .mp4" onclick="taskDocUploader();" 
                                           id="taskDoc"  name="taskDoc" type="file" value="" class="form-control"  multiple="multiple" />
                                    <small>Only .png, .jpg, .jpeg, .doc, .docx, .pdf and .mp4 files are allowed.</small>
                                    <div id="taskDocError"  hidden=""  class="text-danger"><small>Please select a Document to upload.</small></div>
                                </div>
                            </div>

                            <div class="row mb-3" style="display: none" id="imagePreview">
                                <label class="col-sm-2 col-form-label">Image Preview</label>

                                <img class="col-sm-10" id="taskDocPreview" src="#" alt="Uploaded Document">

                            </div>  

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeTaskUpload();">Cancel</button>
                                    <button type="submit" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>

        </div>

        <!--================================Model - Upload Task Document end==================================-->

        <!--=============================Model - Edit Task Data Start==================================-->

        <div class="modal fade" id="editTaskDetails" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Edit Task Details</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <div class="row mb-3" hidden>

                            <label class="col-sm-2 col-form-label">Task Id</label>

                            <div class="col-sm-10">

                                <input class="form-control" type="text" id="editTaskId" name="editTaskId" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Name</label>

                            <div class="col-sm-10">

                                <textarea class="form-control" type="text" id="editTaskName" name="editTaskName" readonly></textarea>

                            </div>

                        </div>

                        <div class="row mb-3" >

                            <label class="col-sm-2 col-form-label">Note</label>
                            <div class="col-sm-10">
                                <textarea class="form-control" type="text" id="editTaskNote" name="editTaskNote"></textarea>

                                <div id="editTaskNoteError"  hidden=""  class="text-danger"><small>Please Enter Task Note</small></div>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Priority</label>

                            <div class="col-sm-4">

                                <select id="edittaskPriority" name="edittaskPriority" class="select2 form-select col-sm-10">
                                    <%
                                        for (ProjectTaskPriority pt : ProjectTaskPriorityDAO.listByQuery(sess, null, null)) {
                                    %>
                                    <option value="<%=pt.getId()%>"> <%=pt.getName()%></option>
                                    <% }
                                    %>
                                </select>

                            </div>

                            <label class="col-sm-2 col-form-label">Start Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="date" id="editStartDate" name="editStartDate" onclick="editStartDateSelect();"/>

                            </div>

                        </div>


                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">End Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="date" id="editEndDate" name="editEndDate" onclick="editEndDateSelect();"/>

                            </div>

                            <label class="col-sm-2 col-form-label">Complete Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="date" id="editCompleteDate" name="editCompleteDate" onclick="editCompleteDateSelect();"/>

                            </div>


                        </div>


                        <div style="height: 10px;"></div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeEditTask();">Cancel</button>
                                <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="editTaskData();">Save</button>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <!--================================Model - Edit Task Data end==================================-->

        <!--=============================Model - Task Team Start==================================-->

        <div class="modal fade" id="taskTeamtDetails" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Task Team Details</span></h4> 
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

                        <div class="row mb-3">
                            <div class="row">
                                <div class="col-sm-12">

                                    <table id="taskTeamMembersTable" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th hidden>Emp Id</th>
                                                <th>Name</th>
                                                <th>Designation</th>
                                                <th>Project Role</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>

                                        <tbody id="taskTeamMemersTableBody">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>



                        <div class="row mb-3">
                            <label >Add New Members</label>
                        </div>

                        <div class="row mb-3">
                            <div class="row">
                                <div class="col-sm-12">

                                    <table id="addNewTaskEmp" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th hidden>Employee Id</th>
                                                <th>Name</th>
                                                <th>Project Role</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>

                                        <tbody class="table-border-bottom-0" id="addNewTaskEmpBody">

                                        </tbody>
                                    </table>

                                </div>
                            </div> 
                        </div>

                    </div>


                </div>
            </div>

        </div>

        <!--================================Model - Task Team end==================================-->

        <!--=============================Model - Add Task Comment Start==================================-->

        <div class="modal fade" id="addTaskComment" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Add Task Comment</span></h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">

                            <label class="col-sm-4 col-form-label" for="basic-default-name">Mention Project Employee <label class="text-danger">*</label></label>
                            <div class="col-sm-8">
                                <select id="taskProEmp" name="taskProEmp" class="select2 form-select col-sm-10"></select>

                                <div id="taskProEmpError"  hidden=""  class="text-danger"><small>Please select the project employee to whom the comment relates</small></div>
                            </div>
                        </div>
                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label" for="basic-default-name">Comment <label class="text-danger">*</label></label>
                            <div class="col-sm-10">
                                <textarea type="text" class="form-control" id="taskComment" name="taskComment"></textarea>

                                <div id="taskCommentError"  hidden=""  class="text-danger"><small>Please Enter the Comment for the Task</small></div>
                            </div>
                        </div>

                        <div class="row" style="float: right;">

                            <% UserLogin login = (UserLogin) request.getSession().getAttribute("user");

                                System.out.println("User Id : " + login.getId());
                            %>

                            <div class="col-sm-12">
                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeTaskComment();">Cancel</button>
                                <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;" id="saveTaskComment" name="saveTaskComment" onclick="addNewTaskComment(<%=login.getId()%>);">Save</button>
                            </div>
                        </div>

                        <div style="height: 50px;"></div>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-3">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Comment History</label>
                            </div>

                            <div class="col-sm-9" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="comHistoryDiv" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12">

                                    <table id="commentTable" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Date</th>
                                                <th>Commented By</th>
                                                <th>Mentioned Employee</th>
                                                <th>Comment</th>
                                            </tr>
                                        </thead>

                                        <tbody id="commentTableBody">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="comHistoryDivEmpty" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12" >
                                    No Comments Added.
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>

        <!--================================Model - Add Task Comment end==================================-->

        <!--=============================Model - Admit Task Start==================================-->

        <div class="modal fade" id="admitTaskModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Admit Task</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">Do you want to admit to this project task now?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="taskAssignEmptbleId" name="taskAssignEmptbleId" readonly/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="closeAdmitTask();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="admitTask();">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--=============================Model - Admit Task End==================================-->

        <!--=============================Model - End Task Start==================================-->

        <div class="modal fade" id="endTaskModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">End Task</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">Do you want to end to this project task?</p>
                        </div>

                        <div class="row mb-3" hidden>
                            <input class="form-control" id="taskAssignEmpTableId" name="taskAssignEmpTableId" readonly/>
                            <input class="form-control" id="taskAssignProjectId" name="taskAssignProjectId" readonly/>
                            <input class="form-control" id="taskAssignTaskId" name="taskAssignTaskId" readonly/>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="closeEndTask();">No</button>
                                <button type="submit" class="btn rounded-pill btn-primary col-sm-4" onclick="endTask();">Yes</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--=============================Model - End Task End==================================-->

        <!--=============================Model - End Task Note Start==================================-->

        <div class="modal fade" id="endTaskNote" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Task End</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">You already finished this task. </p>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="closeEndTaskNote();">Cancel</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--=============================Model - End Task Note End==================================-->
        
        <!--=============================Model - Not Assign Task Start==================================-->

        <div class="modal fade" id="notAssignTaskNote" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">

                        <h4 class="fw-bold py-3 mt-3" style="padding-top: 50px;"><span class="text-primary fw-light">Task Not Assign</span></h4> 

                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"

                            ></button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <p class="col-sm-12">You are not assigned this task.</p>
                        </div>

                        <div class="row mb-3">
                            <div class="col-sm-12" align="right">
                                <button type="reset" class="btn rounded-pill btn-outline-primary col-sm-4" onclick="closeNotAssignTaskNote();">Cancel</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>  

        <!--=============================Model - Not Assign Task End==================================-->


        <script type="text/javascript">
            url = new URL(window.location.href);
            if (url.searchParams.has('TaskSuccess')) {
                Swal.fire({
                    title: 'Task Documents Successfully Uploaded !',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'task-list.jsp';
                });
            }

            if (url.searchParams.has('TaskError')) {
                Swal.fire({
                    title: 'Data Not Saved',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'task-list.jsp';
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
                    timer: 1500
                }).then(function () {
                    window.location.href = 'task-list.jsp';
                });
            }
        </script>

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
        <script src="../assets/vendor/js/menu.js"></script>

        <script src="../assets/js/main.js"></script>

        <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

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
