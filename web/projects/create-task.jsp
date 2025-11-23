<%-- 
    Document   : createTask
    Created on : Oct 9, 2023, 11:15:40 AM
    Author     : HP
--%>

<%@page import="Model.Logic.ProjectTaskPriorityDAO"%>
<%@page import="Model.Mapping.ProjectTaskPriority"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <title>Exon Admin | Assign Tasks</title> 

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

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <!-- Page CSS -->

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>
        <script type="text/javascript" src="../assets/scripts/pages/projectTask.js">
        </script>

        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.8/dist/sweetalert2.all.min.js"></script>

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
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Assign Tasks</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Tasks . Assign Tasks
                            </h6>
                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Select Project <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <select id="TaskprojectName" name="TaskprojectName" class="select2 form-select col-sm-10" onchange="loadProjectEmp();">
                                                    <option selected disabled value="">Select Project</option>
                                                    <%                                                                            for (Projects p : ProjectsDAO.listByQuery(sess, null, null)) {
                                                            if (p.getIsActive() == Boolean.TRUE) {
                                                    %>
                                                    <option value="<%=p.getId()%>"> <%=p.getName()%></option>
                                                    <% }
                                                        }
                                                    %>
                                                </select>
                                                <div id="TaskprojectNameError"  hidden="" class="text-danger"><small>Please Select Project Name</small></div>

                                            </div>

                                            <label class="col-sm-2 col-form-label">Priority <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <select id="taskPriority" name="taskPriority" class="select2 form-select col-sm-10">
                                                    <option selected disabled value="">Select Priority Status</option>
                                                    <%                                                                            for (ProjectTaskPriority p : ProjectTaskPriorityDAO.listByQuery(sess, null, null)) {
                                                    %>
                                                    <option value="<%=p.getId()%>"> <%=p.getName()%></option>
                                                    <% }
                                                    %>
                                                </select>
                                                <div id="taskPriorityError"  hidden=""  class="text-danger"><small>Please Select Task Priority</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Task Name <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input class="form-control" id="taskName" name="taskName"/>

                                                <div id="taskNameError"  hidden=""  class="text-danger"><small>Please Enter Task Name</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Assign Employee <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">

                                                <div class="selectBox" onclick="showCheckboxes()">
                                                    <select id="assignEmpSelect" name="assignEmpSelect" class="select2 form-select">
                                                        <option>Select Employees</option>
                                                    </select>
                                                    <div class="overSelect"></div>
                                                </div>
                                                <div id="checkboxes">
                                                    <table id="table_allempnames">

                                                        <tbody class="table-border-bottom-0"id="tableempbody">

                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div id="taskAssignEmpError"  hidden=""  class="text-danger"><small>Please Assign the Task to the Employee</small></div>
                                            </div>

                                        </div>

                                        <div class="row mb-3">


                                            <label class="col-sm-2 col-form-label">Assign Date <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="date" class="form-control" id="taskAssignDate" name="taskAssignDate"/>

                                                <div id="taskAssignDateError"  hidden=""  class="text-danger"><small>Please Enter Task Assign Date</small></div>
                                            </div>

                                            <label class="col-sm-2 col-form-label">Due Date <label class="text-danger">*</label></label>
                                            <div class="col-sm-4">
                                                <input type="date" class="form-control" id="taskDueDate" name="taskDueDate" onclick="taskDueDate();"/>

                                                <div id="taskDueDateError"  hidden=""  class="text-danger"><small>Please Enter Task Due Date</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label class="col-sm-2 col-form-label">Note <label class="text-danger">*</label></label>
                                            <div class="col-sm-10">
                                                <textarea style="height: 150px;"
                                                          class="form-control"
                                                          type="text"
                                                          id="taskNote"
                                                          name="taskNote"></textarea>
                                                <div id="taskNoteError"  hidden=""  class="text-danger"><small>Please Enter Task Note</small></div>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col-sm-12" align="right">
                                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;">Cancel</button>
                                                <button type="submit" id= "taskCreate" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="addNewTask();">Save</button>
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

        <script src="../assets/vendor/libs/jquery/jquery.js"></script>
        <script src="../assets/vendor/libs/popper/popper.js"></script>
        <script src="../assets/vendor/js/bootstrap.js"></script>
        <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

        <script src="../assets/vendor/js/menu.js"></script>
        <!-- endbuild -->

        <!-- Vendors JS -->

        <!-- Main JS -->
        <script src="../assets/js/main.js"></script>
        <script src="../assets/scripts/pages/projectTask.js"></script>

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

