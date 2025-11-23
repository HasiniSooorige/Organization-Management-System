<%@page import="com.google.gson.Gson"%>
<%@page import="Model.ProjectTaskM"%>
<%@page import="Model.Mapping.ProjectTasks"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Model.Mapping.TaskAssignEmployees"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page import="java.util.Date"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Mapping.GeneralUserProfile"%>
<%@page import="Model.Mapping.LoginSession"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html
    lang="en"
    class="light-style layout-menu-fixed"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="assets/"
    data-template="vertical-menu-template-free"
    >
    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />

        <title>Exon Employee | Dashboard</title>
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
        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />
        <!-- Page CSS -->
        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>
        <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
        <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
        <script src="../assets/js/config.js"></script>
        <script>
            window.location.hash = "no-back-button";

            // Again because Google Chrome doesn't insert
            // the first hash into the history
            window.location.hash = "Again-No-back-button";

            window.onhashchange = function () {
                window.location.hash = "no-back-button";
            }
        </script>
        <script src="../assets/vendor/libs/apex-charts/apexcharts.js"></script>
    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            System.out.println((request.getSession(false).getAttribute("user")));
            if (!(request.getSession().getAttribute("Emp_GUP") == null)) {

                String today = Com.getDate(new Date());
                String year = today.substring(0, 4);
    %>

    <body>

        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->
                <%@include file="includes/admin-panel.jsp" %>
                <!-- / Menu -->

                <!-- Layout container -->
                <div class="layout-page">
                    <%@include file="includes/header.jsp" %>

                    <%                        String canvas_anim = "";
                        boolean is1stLOGIN = false;
                        List<LoginSession> ls = sess.createQuery("From LoginSession where userLogin.id='" + user.getId() + "'").list();
                        if (ls.size() <= 1) {
                            canvas_anim = "background-image:url('../assets/img/item/6k2.gif')";
                            is1stLOGIN = true;
                        }

                        if ((uls.getUserRole().getId() == 3)) {

                            Object empGupValue = request.getSession().getAttribute("Emp_GUP");
                            int empLoginId = (Integer) empGupValue;

                            int employeeeId = 0;
                            Employee emp = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + empLoginId + "'").setMaxResults(1).uniqueResult();
                            employeeeId = emp.getId();

                            List<ProjectEmployees> list = sess.createQuery("From ProjectEmployees Where employee_id='" + employeeeId + "'").list();

                            int project_all = 0;
                            int project_pending = 0;
                            int project_ongoing = 0;
                            int project_completed = 0;

                            int task_all = 0;
                            int task_pending = 0;
                            int task_ongoing = 0;
                            int task_completed = 0;

                            int pending_urgent = 0;
                            int pending_important = 0;
                            int pending_medium = 0;
                            int pending_low = 0;

                            int ongoing_urgent = 0;
                            int ongoing_important = 0;
                            int ongoing_medium = 0;
                            int ongoing_low = 0;

                            List<ProjectTaskM> pt = new ArrayList();

                            if (!list.isEmpty()) {
                                System.out.println("Project List Size : " + list.size());

                                for (ProjectEmployees pe : list) {

                                    if (pe.getProjects().getIsActive() == Boolean.TRUE) {
                                        project_all++;
                                        if (pe.getProjects().getStatus().getId() == 1) {
                                            project_pending++;
                                        } else if (pe.getProjects().getStatus().getId() == 2) {
                                            project_ongoing++;
                                        } else if (pe.getProjects().getStatus().getId() == 3) {
                                            project_completed++;
                                        }
                                    }

                                    Integer projectEmployee = pe.getId();

                                    List<TaskAssignEmployees> listTask = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmployee + "'").list();

                                    if (!listTask.isEmpty()) {
                                        System.out.println("Task Emp list Size : " + listTask.size());

                                        for (TaskAssignEmployees tae : listTask) {
                                            if (tae.getIsActive() == Boolean.TRUE) {
                                                task_all++;
                                                if (tae.getProjectTasks().getStatus().getId() == 1) {
                                                    task_pending++;

                                                    if (tae.getProjectTasks().getProjectTaskPriority().getId() == 1) {
                                                        pending_urgent++;
                                                    } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 2) {
                                                        pending_important++;
                                                    } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 3) {
                                                        pending_medium++;
                                                    } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 4) {
                                                        pending_low++;
                                                    }

                                                } else if (tae.getProjectTasks().getStatus().getId() == 2) {
                                                    task_ongoing++;

                                                    if (tae.getProjectTasks().getProjectTaskPriority().getId() == 1) {
                                                        ongoing_urgent++;
                                                    } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 2) {
                                                        ongoing_important++;
                                                    } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 3) {
                                                        ongoing_medium++;
                                                    } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 4) {
                                                        ongoing_low++;
                                                    }

                                                } else if (tae.getProjectTasks().getStatus().getId() == 3) {
                                                    task_completed++;

                                                    Integer projectTaskId = tae.getProjectTasks().getId();

                                                    List<ProjectTasks> listTaskYear = sess.createQuery("From ProjectTasks Where id='" + projectTaskId + "' and YEAR(completed_date)='" + year + "'").list();

                                                    if (!listTaskYear.isEmpty()) {

                                                        System.out.println("list-size : " + listTaskYear.size());

                                                        for (ProjectTasks per : listTaskYear) {

                                                            ProjectTaskM pem = new ProjectTaskM();
                                                            pem.setCompletedDate(per.getCompletedDate());
                                                            pt.add(pem);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                }
                            }
                            Gson gson = new Gson();
                            String ptJson = gson.toJson(pt);

                            request.setAttribute("pendingPercentage", project_pending);
                            request.setAttribute("ongoingPercentage", project_ongoing);
                            request.setAttribute("completedPercentage", project_completed);

                            request.setAttribute("pendingUrgent", pending_urgent);
                            request.setAttribute("pendingImportant", pending_important);
                            request.setAttribute("pendingMedium", pending_medium);
                            request.setAttribute("pendingLow", pending_low);

                            request.setAttribute("ongoingUrgent", ongoing_urgent);
                            request.setAttribute("ongoingImportant", ongoing_important);
                            request.setAttribute("ongoingMedium", ongoing_medium);
                            request.setAttribute("ongoingLow", ongoing_low);

                            request.setAttribute("ptJson", ptJson);


                    %>
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="row">
                                <div class="col-lg-12 mb-12 order-0">
                                    <div class="card" >
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-7">
                                                <div class="card-body">
                                                    <h5 class="card-title text-primary"><%=user.getGeneralUserProfile().getFirstName() + " " + user.getGeneralUserProfile().getLastName()%> ,  Welcome to Exon Software Solutions Pvt Ltd
                                                    </h5>
                                                     
                                                    <p class="mb-4"> Governing Policies and procedures<br/>
                                                        of the -<span class="fw-bold"> Exon Software Solutions Pvt Ltd</span><br/> Colombo Branch
                                                    </p>
                                                    <a href="https://exon.lk/" target=" " class="btn btn-sm btn-outline-primary">View More</a>
                                                </div>
                                            </div>
                                            <div class="col-sm-5 text-center text-sm-left">
                                                <div class="card-body pb-0 px-0 px-md-4">
                                                    <img
                                                        src="../assets/img/illustrations/man-with-laptop-light.png"
                                                        height="140"
                                                        alt="View Badge User"
                                                        data-app-dark-img="illustrations/man-with-laptop-dark.png"
                                                        data-app-light-img="illustrations/man-with-laptop-light.png"
                                                        />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Total Revenue -->
                            </div><br/><br/>
                            <%
                                if (is1stLOGIN) {
                            %>
                            <div class="row " >
                                <div class="col-md">
                                    <div class="card mb-3 alert-success" >
                                        <div class="col-lg-12" style="<%=canvas_anim%> ">
                                            <div class="card-body">
                                                <h3 class="alert-success text-center">WELCOME ON BOARD!</h3>
                                                <h5 class="card-title text-center">We're excited to have you on board. Enjoy your journey with us!</h5><br/>
                                                <h5 class="card-title text-center">We're thrilled to have you on board and embark on this exciting journey together. 🌟 <br/>This marks the beginning of your career with us, and we believe that with your talents and contributions, we'll achieve great things as a team.</h5>
                                                <img style=" display: block;
                                                     margin-left: auto;
                                                     margin-right: auto;  " src="../assets/img/welcome-team-img.png" width="20%" >
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                }%>

                            <%

                                List<GeneralUserProfile> doblist = sess.createQuery("from GeneralUserProfile WHERE dob IS NOT NULL").list();
                                for (GeneralUserProfile g : doblist) {
                                    if (Com.getDate(g.getDob()).equals(Com.getDate(new Date()))) {
                                        if (user.getGeneralUserProfile().getId() != g.getId()) {
                                            System.out.println("iths birthday " + g.getFirstName() + " " + g.getLastName() + " " + Com.getDate(new Date()) + " ");
                            %>

                            <div
                                class="bs-toast toast fade show bg-dark"
                                role="alert"
                                aria-live="assertive"
                                aria-atomic="true">
                                <div class="toast-header">
                                    <i class="bx bx-bell me-2"></i>
                                    <div class="me-auto fw-medium">Bootstrap</div>

                                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                </div>
                                <div class="toast-body">
                                    Today is <%=g.getFirstName() + " " + g.getLastName()%>'s Birthday!
                                </div>
                            </div>
                            <%
                            } else {

                            %>

                            <h5 class="pb-1 mb-4">Birthday wish from your team</h5>
                            <div class="row mb-5">
                                <div class="col-md">
                                    <div class="card mb-3">
                                        <div class="row g-0" style="background-image:url('../assets/img/item/6k2.gif')">
                                            <div class="col-md-4">
                                                <img class="card-img card-img-left" src="../assets/img/item/birth.jpg" alt="Card image" />                      </div>
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <h5 class="card-title">Happy Birthday</h5>
                                                    <p class="card-text">
                                                        On this special day, we want to take a moment to celebrate not only the day you were born but also the incredible contributions you bring to our team. Your hard work, dedication, and positive attitude make our workplace a better and more enjoyable environment for everyone.

                                                    </p>
                                                    <p class="card-text"><small class="text-muted">- From Your Team</small></p>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="col-md">
                                    <div class="card mb-3">
                                        <div class="row g-0">
                                            <div class="col-md-8">
                                                <div class="card-body">
                                                    <h5 class="card-title">Card title</h5>
                                                    <p class="card-text">
                                                        This is a wider card with supporting text below as a natural lead-in to additional content.
                                                        This content is a little bit longer.
                                                    </p>
                                                    <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <img class="card-img card-img-right" src="../assets/img/elements/17.jpg" alt="Card image" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%            }
                                    }
                                }
                            %>
                            <div class="row">
                                <!--projects-->
                                <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2 mb-4">
                                    <div class="card h-100">
                                        <div class="card-header d-flex align-items-center justify-content-between pb-0">
                                            <div class="card-title mb-0">
                                                <h5 class="m-0 me-2">Project Statistics</h5>
                                            </div>
                                            <div>
                                                <a href="../projects/project-list.jsp" class="btn p-0" id="projectStatistics" style="text-decoration: none;">
                                                    <i class='bx bx-chevrons-right'></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-3" style="position: relative;">
                                                <div class="d-flex flex-column align-items-start gap-1" id="chart"></div>
                                                <div id="chart"></div>

                                                <div class="resize-triggers"><div class="expand-trigger"><div style="width: 253px; height: 139px;"></div></div><div class="contract-trigger"></div></div></div>

                                            <ul class="p-0 m-0">
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">All</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=project_all%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-warning"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Pending</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=project_pending%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-info"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Ongoing</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=project_ongoing%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-success"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Completed</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=project_completed%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                                    <div class="card">
                                        <div class="row row-bordered g-0">
                                            <div class="col-md-8">
                                                <div class="card-header d-flex justify-content-between">

                                                    <div>
                                                        <h5 class="card-title mb-0">Completed Tasks Progress</h5>
                                                    </div>

                                                    <div class="selectBox">
                                                        <select class="select2 form-select" onchange="handleEmployeeTask(value, <%=employeeeId%>);" style="border: 1px #696CFF solid; font-size: 12px;">
                                                            <option selected disabled value="<%=year%>"><%=year%></option>
                                                            <option value="2023">2023</option>
                                                            <option value="2024">2024</option>
                                                            <option value="2025">2025</option>
                                                        </select>
                                                    </div>
                                                </div>


                                                <div style="padding: 15px;">

                                                    <div id="taskChart" style="min-height: 280px;"></div>

                                                    <div class="resize-triggers"><div class="expand-trigger"><div style="width: 418px; height: 290px;"></div></div><div class="contract-trigger"></div></div>

                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="card-header d-flex justify-content-between">
                                                    <div>
                                                        <h5 class="card-title mb-0">Task Status Report</h5>
                                                    </div>
                                                    <div>
                                                        <a href="../projects/task-list.jsp" class="btn p-0" id="projectStatistics" style="text-decoration: none;">
                                                    <i class='bx bx-chevrons-right'></i>
                                                </a>
                                            </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="report-list">
                                                        <div class="report-list-item rounded-2 mb-3">
                                                            <div class="d-flex align-items-start">
                                                                <div class="avatar flex-shrink-0 me-3">
                                                                    <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-task'></i></span>
                                                                </div>
                                                                <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                    <div class="d-flex flex-column">
                                                                        <span>All</span>
                                                                        <h5 class="mb-0"><%=task_all%></h5>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="report-list-item rounded-2 mb-3">
                                                            <div class="d-flex align-items-start">
                                                                <div class="avatar flex-shrink-0 me-3">
                                                                    <span class="avatar-initial rounded bg-label-warning"><i class='bx bx-task'></i></span>
                                                                </div>
                                                                <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                    <div class="d-flex flex-column">
                                                                        <span>Pending</span>
                                                                        <h5 class="mb-0"><%=task_pending%></h5>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="report-list-item rounded-2 mb-3">
                                                            <div class="d-flex align-items-start">
                                                                <div class="avatar flex-shrink-0 me-3">
                                                                    <span class="avatar-initial rounded bg-label-info"><i class='bx bx-task'></i></span>
                                                                </div>
                                                                <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                    <div class="d-flex flex-column">
                                                                        <span>Ongoing</span>
                                                                        <h5 class="mb-0"><%=task_ongoing%></h5>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="report-list-item rounded-2">
                                                            <div class="d-flex align-items-start">
                                                                <div class="avatar flex-shrink-0 me-3">
                                                                    <span class="avatar-initial rounded bg-label-success"><i class='bx bx-task'></i></span>
                                                                </div>
                                                                <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                    <div class="d-flex flex-column">
                                                                        <span>Completed</span>
                                                                        <h5 class="mb-0"><%=task_completed%></h5>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--/ Total Income -->
                                </div>
                                <!--task-->
                                <div class="col-12 col-lg-12 order-2 order-md-3 order-lg-2 mb-4">
                                    <div class="card">
                                        <div class="row row-bordered g-0">
                                            <div class="col-md-6">
                                                <div class="card-header d-flex justify-content-between">

                                                    <div>
                                                        <h5 class="card-title mb-0">Project Tasks Priority</h5>
                                                    </div>


                                                </div>


                                                <div style="padding: 15px;">

                                                    <div id="taskChartPriority" style="min-height: 280px;"></div>

                                                    <div class="resize-triggers"><div class="expand-trigger"><div style="width: 418px; height: 290px;"></div></div><div class="contract-trigger"></div></div>

                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="card-header d-flex justify-content-between pb-0">
                                                    <div>
                                                        <h5 class="card-title mb-0">Task Priority Report</h5>
                                                    </div>
                                                    <div>
                                                        <a href="../projects/task-list.jsp" class="btn p-0" id="projectStatistics" style="text-decoration: none;">
                                                    <i class='bx bx-chevrons-right'></i>
                                                </a>
                                            </div>
                                                </div>

                                                <div class="col-md-6" style="float: left">
                                                    <div class="card-body">
                                                        <div class="report-list">
                                                            <div class="report-list-item rounded-2 mb-3">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-warning"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span><b>Pending Task</b></span>
                                                                            <span><h5 class="mb-0"><%=task_pending%></h5></span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2 mb-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Urgent</span>
                                                                            <h5 class="mb-0"><%=pending_urgent%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2 mb-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-success"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Important</span>
                                                                            <h5 class="mb-0"><%=pending_important%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2 mb-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-primary"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Medium</span>
                                                                            <h5 class="mb-0"><%=pending_medium%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-dark"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Low</span>
                                                                            <h5 class="mb-0"><%=pending_low%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-6" style="float: right">
                                                    <div class="card-body">
                                                        <div class="report-list">
                                                            <div class="report-list-item rounded-2 mb-3">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-info"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span><b>Ongoing Task</b></span>
                                                                            <h5 class="mb-0"><%=task_ongoing%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2 mb-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Urgent</span>
                                                                            <h5 class="mb-0"><%=ongoing_urgent%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2 mb-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-success"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Important</span>
                                                                            <h5 class="mb-0"><%=ongoing_important%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2 mb-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-primary"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Medium</span>
                                                                            <h5 class="mb-0"><%=ongoing_medium%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="report-list-item rounded-2">
                                                                <div class="d-flex align-items-start">
                                                                    <div class="avatar flex-shrink-0 me-3">
                                                                        <span class="avatar-initial rounded bg-label-dark"><i class='bx bx-task'></i></span>
                                                                    </div>
                                                                    <div class="d-flex justify-content-between align-items-end w-100 flex-wrap gap-2">
                                                                        <div class="d-flex flex-column">
                                                                            <span>Low</span>
                                                                            <h5 class="mb-0"><%=ongoing_low%></h5>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <!--/ Total Income -->
                                </div>
                            </div>
                            <div class="content-backdrop fade"></div>
                        </div>
                        <!-- Content wrapper -->
                        <%
                            } else {

                                response.sendRedirect("../index.jsp");
                            }
                        %>
                    </div>



                    <!-- / Layout page -->
                </div>
                <!-- Overlay -->
                <div class="layout-overlay layout-menu-toggle"></div>
            </div>
            <!-- / Layout wrapper -->
            <!-- Page JS -->
            <script src="../assets/scripts/pages/employeeDashboard.js"></script>
            <!--Project Statistics-->
            <script>
            var pendingPercentageValue = <%= request.getAttribute("pendingPercentage")%>;
            var ongoingPercentageValue = <%= request.getAttribute("ongoingPercentage")%>;
            var completedPercentageValue = <%= request.getAttribute("completedPercentage")%>;
            var options = {
                chart: {
                    type: 'donut'
                },
                series: [pendingPercentageValue, ongoingPercentageValue, completedPercentageValue],
                labels: ['Pending', 'Ongoing', 'Completed'],
                colors: ['#fcc147', '#33dbff', '#81ff3d'],
                responsive: [{
                        breakpoint: 480,
                        options: {
                            chart: {
                                width: 200
                            },
                            legend: {
                                position: 'bottom'
                            }
                        }
                    }],
                dataLabels: {
                    enabled: true,
                    formatter: function (val, opts) {
                        return val.toFixed(2) + "%";
                    },
                    style: {
                        fontSize: '12px',
                        colors: ['#566a7f', '#566a7f', '#566a7f'],
                        fontWeight: 'light'
                    }
                }
            }

            var chart = new ApexCharts(
                    document.querySelector("#chart"),
                    options
                    );
            chart.render();
            </script>
            <!-- / Project Statistics-->

            <!--Project Tasks-->
            <script>
                var ptJson = '<%= request.getAttribute("ptJson")%>';

                var ptArray = JSON.parse(ptJson);

                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

                const monthlyData = {};

                months.forEach(month => {
                    monthlyData[month] = 0;
                });

                for (var i = 0; i < ptArray.length; i++) {
                    var taskDocument = ptArray[i];
                    var date = new Date(taskDocument.completedDate);
                    var month = date.toLocaleString('en-us', {month: 'short'});
                    monthlyData[month]++;
                }

                // Prepare data for chart
                const taskCounts = months.map(month => monthlyData[month]);

                // Destroy existing chart if it exists
                if (empTaskChart) {
                    empTaskChart.destroy();
                }

                // Create ApexCharts
                var options = {
                    chart: {
                        type: 'area',
                        toolbar: {
                            show: false
                        }
                    },
                    dataLabels: {
                        enabled: false
                    },
                    xaxis: {
                        categories: months,
                        title: {
                            text: 'Month'
                        }
                    },
                    yaxis: {
                        title: {
                            text: 'Number of Tasks'
                        },
                        labels: {
                            formatter: function (value) {
                                return Math.round(value);
                            }
                        }
                    },
                    series: [{
                            name: 'Completed Tasks',
                            data: taskCounts
                        }],
                    stroke: {
                        curve: 'smooth',
                        width: 2
                    }
                };

                empTaskChart = new ApexCharts(document.querySelector("#taskChart"), options);
                empTaskChart.render();
            </script>
            <!--/ Project Tasks-->

            <!--Task Priority-->
            <script>

                var pending_urgent = <%= request.getAttribute("pendingUrgent")%>;
                var pending_important = <%= request.getAttribute("pendingImportant")%>;
                var pending_medium = <%= request.getAttribute("pendingMedium")%>;
                var pending_low = <%= request.getAttribute("pendingLow")%>;

                var ongoing_urgent = <%= request.getAttribute("ongoingUrgent")%>;
                var ongoing_important = <%= request.getAttribute("ongoingImportant")%>;
                var ongoing_medium = <%= request.getAttribute("ongoingMedium")%>;
                var ongoing_low = <%= request.getAttribute("ongoingLow")%>;

                var categories = ['Urgent', 'Important', 'Medium', 'Low'];
                var pendingData = [pending_urgent, pending_important, pending_medium, pending_low];
                var ongoingData = [ongoing_urgent, ongoing_important, ongoing_medium, ongoing_low];

                var options = {
                    chart: {
                        type: 'bar',
                        toolbar: {
                            show: false
                        }
                    },
                    plotOptions: {
                        bar: {
                            horizontal: false,
                            columnWidth: '55%',
                            endingShape: 'rounded'
                        }
                    },
                    colors: ["#ffc107", "#0d6efd"],
                    series: [
                        {
                            name: 'Pending Tasks',
                            data: pendingData
                        },
                        {
                            name: 'Ongoing Tasks',
                            data: ongoingData
                        }
                    ],
                    dataLabels: {
                        enabled: false
                    },
                    stroke: {
                        show: true,
                        width: 3,
                        colors: ['transparent']
                    },
                    xaxis: {
                        categories: categories,
                        title: {
                            text: 'Priority'
                        }
                    },
                    yaxis: {
                        title: {
                            text: 'Number of Tasks'
                        },
                        labels: {
                            formatter: function (value) {
                                return Math.round(value);
                            }
                        }
                    }
                };

                var chart = new ApexCharts(document.getElementById('taskChartPriority'), options);
                chart.render();
            </script>
            <!--/ Task Priority-->


            <!-- Core JS -->
            <!-- build:js assets/vendor/js/core.js -->
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



            <!-- Place this tag in your head or just before your close body tag. -->
            <script async defer src="https://buttons.github.io/buttons.js"></script>


            <!--js files-->
    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
