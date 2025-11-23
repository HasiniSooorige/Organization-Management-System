<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="Model.ProjectTaskM"%>
<%@page import="Model.Mapping.TaskAssignEmployees"%>
<%@page import="Model.Logic.ProjectEmployeesDAO"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Mapping.ProjectTasks"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Mapping.GeneralUserProfile"%>
<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Mapping.UserLogin"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>
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

        <title>Exon Admin | Dashboard</title>
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

    </head>

</head>
<%
    if ((request.getSession(false).getAttribute("user") == null)) {

        response.sendRedirect("../index.jsp");
    } else {
        if (!(request.getSession().getAttribute("GUP_ID") == null)) {

            String today = Com.getDate(new Date());
            String year = today.substring(0, 4);

%>
<body onload="handleItemClick(<%=year%>);">
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
        <div class="layout-container">
            <!-- / Menu -->
            <%@include file="includes/admin-panel.jsp" %>
            <!-- / Menu -->
            <!-- Layout container -->
            <div class="layout-page">
                <!-- Navbar -->
                <%@include file="includes/header.jsp" %>
                <!-- / Navbar -->
                <%                    if ((uls.getUserRole().getId() == 1) || (uls.getUserRole().getId() == 2)) {

                        System.out.println("NIC " + user.getGeneralUserProfile().getNic());
                        int all_project_all = 0;
                        int all_project_pending = 0;
                        int all_project_ongoing = 0;
                        int all_project_completed = 0;
                        int all_project_active = 0;
                        int all_project_inactive = 0;

                        int all_task_all = 0;
                        int all_task_pending = 0;
                        int all_task_ongoing = 0;
                        int all_task_completed = 0;

                        List<Projects> pro_list = sess.createQuery("from Projects ").list();
                        for (Projects project : pro_list) {
                            all_project_all++;
                            if (project.getIsActive() == Boolean.TRUE) {
                                all_project_active++;
                                if (project.getStatus().getId() == 1) {
                                    all_project_pending++;
                                } else if (project.getStatus().getId() == 2) {
                                    all_project_ongoing++;
                                } else if (project.getStatus().getId() == 3) {
                                    all_project_completed++;
                                }
                            } else {
                                all_project_inactive++;
                            }

                        }

                        List<ProjectTasks> task_list = sess.createQuery("from ProjectTasks ").list();
                        for (ProjectTasks task : task_list) {
                            all_task_all++;

                            if (task.getStatus().getId() == 1) {
                                all_task_pending++;
                            } else if (task.getStatus().getId() == 2) {
                                all_task_ongoing++;
                            } else if (task.getStatus().getId() == 3) {
                                all_task_completed++;
                            }

                        }

                        Object adminGupValue = request.getSession().getAttribute("GUP_ID");
                        int adminLoginId = (Integer) adminGupValue;

                        int adminId = 0;
                        Employee emp = (Employee) sess.createQuery("From Employee Where general_user_profile_id='" + adminLoginId + "'").setMaxResults(1).uniqueResult();
                        adminId = emp.getId();
                        List<ProjectEmployees> proEmp_list = sess.createQuery("From ProjectEmployees Where employee_id='" + adminId + "'").list();

                        int my_project_all = 0;
                        int my_project_pending = 0;
                        int my_project_ongoing = 0;
                        int my_project_completed = 0;

                        int my_task_all = 0;
                        int my_task_pending = 0;
                        int my_task_ongoing = 0;
                        int my_task_completed = 0;

                        int my_pending_urgent = 0;
                        int my_pending_important = 0;
                        int my_pending_medium = 0;
                        int my_pending_low = 0;

                        int my_ongoing_urgent = 0;
                        int my_ongoing_important = 0;
                        int my_ongoing_medium = 0;
                        int my_ongoing_low = 0;

                        List<ProjectTaskM> pt = new ArrayList();

                        if (!proEmp_list.isEmpty()) {
                            System.out.println("Project List Size : " + proEmp_list.size());

                            for (ProjectEmployees pe : proEmp_list) {

                                if (pe.getProjects().getIsActive() == Boolean.TRUE) {
                                    my_project_all++;
                                    if (pe.getProjects().getStatus().getId() == 1) {
                                        my_project_pending++;
                                    } else if (pe.getProjects().getStatus().getId() == 2) {
                                        my_project_ongoing++;
                                    } else if (pe.getProjects().getStatus().getId() == 3) {
                                        my_project_completed++;
                                    }
                                }

                                Integer projectEmployee = pe.getId();

                                List<TaskAssignEmployees> listTask = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmployee + "'").list();

                                if (!listTask.isEmpty()) {
                                    System.out.println("Task Emp list Size : " + listTask.size());

                                    for (TaskAssignEmployees tae : listTask) {
                                        if (tae.getIsActive() == Boolean.TRUE) {
                                            my_task_all++;
                                            if (tae.getProjectTasks().getStatus().getId() == 1) {
                                                my_task_pending++;

                                                if (tae.getProjectTasks().getProjectTaskPriority().getId() == 1) {
                                                    my_pending_urgent++;
                                                } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 2) {
                                                    my_pending_important++;
                                                } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 3) {
                                                    my_pending_medium++;
                                                } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 4) {
                                                    my_pending_low++;
                                                }

                                            } else if (tae.getProjectTasks().getStatus().getId() == 2) {
                                                my_task_ongoing++;

                                                if (tae.getProjectTasks().getProjectTaskPriority().getId() == 1) {
                                                    my_ongoing_urgent++;
                                                } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 2) {
                                                    my_ongoing_important++;
                                                } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 3) {
                                                    my_ongoing_medium++;
                                                } else if (tae.getProjectTasks().getProjectTaskPriority().getId() == 4) {
                                                    my_ongoing_low++;
                                                }

                                            } else if (tae.getProjectTasks().getStatus().getId() == 3) {
                                                my_task_completed++;

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

                        request.setAttribute("pendingPercentage", all_project_pending);
                        request.setAttribute("ongoingPercentage", all_project_ongoing);
                        request.setAttribute("completedPercentage", all_project_completed);

                        request.setAttribute("my_pendingPercentage", my_project_pending);
                        request.setAttribute("my_ongoingPercentage", my_project_ongoing);
                        request.setAttribute("my_completedPercentage", my_project_completed);

                        request.setAttribute("my_pendingUrgent", my_pending_urgent);
                        request.setAttribute("my_pendingImportant", my_pending_important);
                        request.setAttribute("my_pendingMedium", my_pending_medium);
                        request.setAttribute("my_pendingLow", my_pending_low);

                        request.setAttribute("my_ongoingUrgent", my_ongoing_urgent);
                        request.setAttribute("my_ongoingImportant", my_ongoing_important);
                        request.setAttribute("my_ongoingMedium", my_ongoing_medium);
                        request.setAttribute("my_ongoingLow", my_ongoing_low);

                        request.setAttribute("ptJson", ptJson);
                %>
                <!-- Content wrapper -->
                <div class="content-wrapper">
                    <!-- Exon Software Solutions -->
                    <div class="container-xxl flex-grow-1 container-p-y">
                        <div class="col-lg-12 col-md-12 order-1">
                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-7">
                                                <div class="card-body">
                                                    <h5 class="card-title text-primary">Exon Software Solutions Pvt Ltd
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
                            </div>


                            <% List<GeneralUserProfile> doblist = sess.createQuery("from GeneralUserProfile WHERE dob IS NOT NULL").list();
                                for (GeneralUserProfile g : doblist) {
                                    if (Com.getDate(g.getDob()).equals(Com.getDate(new Date()))) {
                                        if (user.getGeneralUserProfile().getId() != g.getId()) {
                                            System.out.println("iths birthday " + g.getFirstName() + " " + g.getLastName() + " " + Com.getDate(new Date()) + " ");
                            %>
                            <!-- Birthday  -->
                            <div class="row mb-5">
                                <div class="mb-4">
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
                                </div>
                            </div>
                            <%
                                        }
                                    }
                                }%>


                            <!--All -  Project -->

                            <div class="row">
                                <!--All - Project Statistics-->
                                <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2 mb-4">
                                    <div class="card" style="background-color: #f4fff4; border-bottom: 5px #71dd37 solid;">
                                        <div class="card-header d-flex align-items-center justify-content-between pb-0">
                                            <div class="card-title mb-0">
                                                <h5 class="m-0 me-2">All Project Statistics</h5>
                                            </div>
                                            <div>
                                                <a href="../projects/project-list.jsp" class="btn p-0" id="projectStatistics" style="text-decoration: none;">
                                                    <i class='bx bx-chevrons-right'></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-3" style="position: relative;">
                                                <div class="d-flex flex-column align-items-start gap-1" id="allchart"></div>

                                                <div id="allchart"></div>

                                                <div class="resize-triggers"><div class="expand-trigger"><div style="width: 253px; height: 139px;"></div></div><div class="contract-trigger"></div></div></div>

                                            <ul class="p-0 m-0">
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-primary"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">All</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=all_project_all%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Active</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=all_project_active%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-secondary"><i class='bx bx-bookmark-alt'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Inactive</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=all_project_inactive%></h5>
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
                                                            <h5 class="mb-0"><%=all_project_pending%></h5>
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
                                                            <h5 class="mb-0"><%=all_project_ongoing%></h5>
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
                                                            <h5 class="mb-0"><%=all_project_completed%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <!--All - Project Tasks-->
                                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                                    <div class="card mb-6" style="background-color: #f4fff4; border-bottom: 5px #71dd37 solid;">
                                        <div class="row row-bordered g-0">
                                            <div class="col-md-8" >
                                                <div class="card-header d-flex justify-content-between">

                                                    <div>
                                                        <h5 class="card-title mb-0">All Completed Task Progress</h5>
                                                    </div>

                                                    <div class="selectBox">
                                                        <select class="select2 form-select" onchange="handleItemClick(value);" style="border: 1px #696CFF solid; font-size: 12px;">
                                                            <option selected disabled value="<%=year%>" ><%=year%></option>
                                                            <option value="2023">2023</option>
                                                            <option value="2024">2024</option>
                                                            <option value="2025">2025</option>
                                                        </select>
                                                    </div>
                                                </div>


                                                <div style="padding: 15px;">

                                                    <div id="admintaskChart" style="min-height: 280px;"></div>

                                                    <div class="resize-triggers"><div class="expand-trigger"><div style="width: 418px; height: 290px;"></div></div><div class="contract-trigger"></div></div>

                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="card-header d-flex justify-content-between">
                                                    <div>
                                                        <h5 class="card-title mb-0">All Task Status Report</h5>
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
                                                                        <h5 class="mb-0"><%=all_task_all%></h5>
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
                                                                        <h5 class="mb-0"><%=all_task_pending%></h5>
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
                                                                        <h5 class="mb-0"><%=all_task_ongoing%></h5>
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
                                                                        <h5 class="mb-0"><%=all_task_completed%></h5>
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

                            </div>  
                            <div class="row">
                                <!--projects-->
                                <div class="col-12 col-md-8 col-lg-4 order-3 order-md-2 mb-4">
                                    <div class="card h-100"  style="background-color: #fff7f2; border-bottom: 5px #ffab00 solid;">
                                        <div class="card-header d-flex align-items-center justify-content-between pb-0">
                                            <div class="card-title mb-0">
                                                <h5 class="m-0 me-2">My Project Statistics</h5>
                                            </div>
                                            <div>
                                                <a href="../projects/project-list.jsp" class="btn p-0" id="projectStatistics" style="text-decoration: none;">
                                                    <i class='bx bx-chevrons-right'></i>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-3" style="position: relative;">
                                                <div class="d-flex flex-column align-items-start gap-1" id="mychart"></div>
                                                <div id="mychart"></div>

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
                                                            <h5 class="mb-0"><%=my_project_all%></h5>
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
                                                            <h5 class="mb-0"><%=my_project_pending%></h5>
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
                                                            <h5 class="mb-0"><%=my_project_ongoing%></h5>
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
                                                            <h5 class="mb-0"><%=my_project_completed%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
                                    <div class="card" style="background-color: #fff7f2; border-bottom: 5px #ffab00 solid;">
                                        <div class="row row-bordered g-0">
                                            <div class="col-md-8">
                                                <div class="card-header d-flex justify-content-between">

                                                    <div>
                                                        <h5 class="card-title mb-0">My Completed Tasks Progress</h5>
                                                    </div>

                                                    <div class="selectBox">
                                                        <select class="select2 form-select" onchange="handleAdminTask(value, <%=adminId%>);" style="border: 1px #696CFF solid; font-size: 12px;">
                                                            <option selected disabled value="<%=year%>"><%=year%></option>
                                                            <option value="2023">2023</option>
                                                            <option value="2024">2024</option>
                                                            <option value="2025">2025</option>
                                                        </select>
                                                    </div>
                                                </div>


                                                <div style="padding: 15px;">

                                                    <div id="mytaskChart" style="min-height: 280px;"></div>

                                                    <div class="resize-triggers"><div class="expand-trigger"><div style="width: 418px; height: 290px;"></div></div><div class="contract-trigger"></div></div>

                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="card-header d-flex justify-content-between">
                                                    <div>
                                                        <h5 class="card-title mb-0">My Task Status Report</h5>
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
                                                                        <h5 class="mb-0"><%=my_task_all%></h5>
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
                                                                        <h5 class="mb-0"><%=my_task_pending%></h5>
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
                                                                        <h5 class="mb-0"><%=my_task_ongoing%></h5>
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
                                                                        <h5 class="mb-0"><%=my_task_completed%></h5>
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
                                    <div class="card" style="background-color: #fff7f2; border-bottom: 5px #ffab00 solid;">
                                        <div class="row row-bordered g-0">
                                            <div class="col-md-6">
                                                <div class="card-header d-flex justify-content-between">

                                                    <div>
                                                        <h5 class="card-title mb-0">My Project Tasks Priority</h5>
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
                                                        <h5 class="card-title mb-0">My Task Priority Report</h5>
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
                                                                            <span><h5 class="mb-0"><%=my_task_pending%></h5></span>
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
                                                                            <h5 class="mb-0"><%=my_pending_urgent%></h5>
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
                                                                            <h5 class="mb-0"><%=my_pending_important%></h5>
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
                                                                            <h5 class="mb-0"><%=my_pending_medium%></h5>
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
                                                                            <h5 class="mb-0"><%=my_pending_low%></h5>
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
                                                                            <h5 class="mb-0"><%=my_task_ongoing%></h5>
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
                                                                            <h5 class="mb-0"><%=my_ongoing_urgent%></h5>
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
                                                                            <h5 class="mb-0"><%=my_ongoing_important%></h5>
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
                                                                            <h5 class="mb-0"><%=my_ongoing_medium%></h5>
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
                                                                            <h5 class="mb-0"><%=my_ongoing_low%></h5>
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

                        </div></div>

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
    <!-- Page JS -->
    <script src="../assets/scripts/pages/adminDashboard.js"></script>
    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>

    <!--js files-->



    <!--All- Project Statistics-->
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

                                                            var allchart = new ApexCharts(
                                                                    document.querySelector("#allchart"),
                                                                    options
                                                                    );
                                                            allchart.render();
    </script>
    <!-- / All-Project Statistics-->

    <!--My- Project Statistics-->
    <script>
        var mypendingPercentageValue = <%= request.getAttribute("my_pendingPercentage")%>;
        var myongoingPercentageValue = <%= request.getAttribute("my_ongoingPercentage")%>;
        var mycompletedPercentageValue = <%= request.getAttribute("my_completedPercentage")%>;
        var options = {
            chart: {
                type: 'donut'
            },
            series: [mypendingPercentageValue, myongoingPercentageValue, mycompletedPercentageValue],
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

        var mychart = new ApexCharts(
                document.querySelector("#mychart"),
                options
                );
        mychart.render();
    </script>
    <!-- / My-Project Statistics-->

    <!--My-Project Tasks-->
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
        if (mytaskchart) {
            mytaskchart.destroy();
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

        mytaskchart = new ApexCharts(document.querySelector("#mytaskChart"), options);
        mytaskchart.render();
    </script>
    <!--/ My- Project Tasks-->

    <!--My - Task Priority-->
    <script>

        var pending_urgent = <%= request.getAttribute("my_pendingUrgent")%>;
        var pending_important = <%= request.getAttribute("my_pendingImportant")%>;
        var pending_medium = <%= request.getAttribute("my_pendingMedium")%>;
        var pending_low = <%= request.getAttribute("my_pendingLow")%>;

        var ongoing_urgent = <%= request.getAttribute("my_ongoingUrgent")%>;
        var ongoing_important = <%= request.getAttribute("my_ongoingImportant")%>;
        var ongoing_medium = <%= request.getAttribute("my_ongoingMedium")%>;
        var ongoing_low = <%= request.getAttribute("my_ongoingLow")%>;

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
    <!--/ My - Task Priority-->



</body>
<%
        } else {
            response.sendRedirect("../index.jsp");
        }
    }
%>
</html>
