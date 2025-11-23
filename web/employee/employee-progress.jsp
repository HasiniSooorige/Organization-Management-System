<%-- 
    Document   : employee-progress
    Created on : May 2, 2024, 9:16:41 AM
    Author     : HP
--%>


<%@page import="Model.Mapping.TaskAssignEmployees"%>
<%@page import="Model.Logic.EmployeeDAO"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page import="Model.Mapping.Employee"%>
<%@page import="Model.Mapping.Employee"%>
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

        <title>Exon Admin | Employee Progress</title> 

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

        <script>
            function loadProfileImage(userImage, employId) {

                var img = document.createElement('img');
                if (userImage === "null" || userImage === "") {
                    img.src = "../assets/img/avatars/userImage.jpg";
                } else {
                    var imageUrl = "../ViewProfilePhoto?imageName=" + userImage;
                    img.src = imageUrl;
                }
                img.alt = 'Profile Image';
                img.onload = function () {
                    document.getElementById('profileImgDiv_' + employId).appendChild(img);
                };

            }
        </script>

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
                                    Employee Progress</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Reports . Employee Progress
                            </h6>
                            <!--Employee Projects & Tasks-->
                            <div class="row">
                                <% for (Employee e : EmployeeDAO.listByQuery(sess, null, null)) {
                                        if ((e.getIsActive() == Boolean.TRUE) && (e.getResignationDate() == null)) {
                                            Integer empId = e.getId();

                                            int emp_task_all = 0;
                                            int emp_task_pending = 0;
                                            int emp_task_ongoing = 0;
                                            int emp_task_completed = 0;

                                            List<ProjectEmployees> listProject = sess.createQuery("From ProjectEmployees Where employee_id='" + empId + "'").list();

                                            if (!listProject.isEmpty()) {

                                                for (ProjectEmployees pe : listProject) {

                                                    if (pe.getIsActive() == Boolean.TRUE) {

                                                        Integer projectEmployee = pe.getId();

                                                        List<TaskAssignEmployees> listTask = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmployee + "'").list();

                                                        if (!listTask.isEmpty()) {

                                                            for (TaskAssignEmployees tae : listTask) {

                                                                if (tae.getProjectTasks().getIsActive() == Boolean.TRUE) {
                                                                    emp_task_all++;
                                                                    if (tae.getProjectTasks().getStatus().getId() == 1) {
                                                                        emp_task_pending++;
                                                                    } else if (tae.getProjectTasks().getStatus().getId() == 2) {
                                                                        emp_task_ongoing++;
                                                                    } else if (tae.getProjectTasks().getStatus().getId() == 3) {
                                                                        emp_task_completed++;
                                                                    }

                                                                }

                                                            }
                                                        }
                                                    }
                                                }
                                            }

                                            String border_colour = "#71dd37";
                                            if (emp_task_pending == 0 && emp_task_ongoing == 0) {
                                                border_colour = "#ff3e1d";
                                            }
                                %>

                                <% if (emp_task_pending == 0 && emp_task_ongoing == 0) {%>
                                <div class="col-sm-6 col-lg-3 mb-4">
                                    <div class="card card-border-shadow-primary h-100" style="border-bottom: 5px <%=border_colour%> solid;">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-2 pb-1" >
                                                <div class="avatar me-2 rounded bg-label-primary" id="profileImgDiv_<%=empId%>">
                                                </div>        
                                                <script>
                                                    loadProfileImage('<%=e.getGeneralUserProfile().getProfileImgUrl()%>', '<%=empId%>');
                                                </script>

                                                <h4 class="ms-1 mb-0"><%= e.getGeneralUserProfile().getFirstName()%> <%= e.getGeneralUserProfile().getLastName()%></h4>
                                            </div>
                                            <ul class="p-0 m-0">
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">All Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_all%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-warning"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Pending Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_pending%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-info"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Ongoing Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_ongoing%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-success"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Completed Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_completed%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>

                                        </div>
                                    </div>
                                </div>
                                <% }
                                        }
                                    } %>
                                <% for (Employee e : EmployeeDAO.listByQuery(sess, null, null)) {
                                        if ((e.getIsActive() == Boolean.TRUE) && (e.getResignationDate() == null)) {
                                            Integer empId = e.getId();

                                            int emp_task_all = 0;
                                            int emp_task_pending = 0;
                                            int emp_task_ongoing = 0;
                                            int emp_task_completed = 0;

                                            List<ProjectEmployees> listProject = sess.createQuery("From ProjectEmployees Where employee_id='" + empId + "'").list();

                                            if (!listProject.isEmpty()) {

                                                for (ProjectEmployees pe : listProject) {

                                                    if (pe.getIsActive() == Boolean.TRUE) {

                                                        Integer projectEmployee = pe.getId();

                                                        List<TaskAssignEmployees> listTask = sess.createQuery("From TaskAssignEmployees Where project_employees_id='" + projectEmployee + "'").list();

                                                        if (!listTask.isEmpty()) {

                                                            for (TaskAssignEmployees tae : listTask) {

                                                                if (tae.getProjectTasks().getIsActive() == Boolean.TRUE) {
                                                                    emp_task_all++;
                                                                    if (tae.getProjectTasks().getStatus().getId() == 1) {
                                                                        emp_task_pending++;
                                                                    } else if (tae.getProjectTasks().getStatus().getId() == 2) {
                                                                        emp_task_ongoing++;
                                                                    } else if (tae.getProjectTasks().getStatus().getId() == 3) {
                                                                        emp_task_completed++;
                                                                    }

                                                                }

                                                            }
                                                        }
                                                    }
                                                }
                                            }

                                            String border_colour = "#71dd37";
                                            if (emp_task_pending == 0 && emp_task_ongoing == 0) {
                                                border_colour = "#ff3e1d";
                                            }
                                %>
                                <% if (emp_task_pending != 0 || emp_task_ongoing != 0) {%>
                                <div class="col-sm-6 col-lg-3 mb-4">
                                    <div class="card card-border-shadow-primary h-100" style="border-bottom: 5px <%=border_colour%> solid;">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center mb-2 pb-1">
                                                <div class="avatar me-2 rounded bg-label-primary" id="profileImgDiv_<%=empId%>">
                                                </div>        
                                                <script>
                                                    loadProfileImage('<%=e.getGeneralUserProfile().getProfileImgUrl()%>', '<%=empId%>');
                                                </script>
                                                <h4 class="ms-1 mb-0"><%= e.getGeneralUserProfile().getFirstName()%> <%= e.getGeneralUserProfile().getLastName()%></h4>
                                            </div>
                                            <ul class="p-0 m-0">
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-danger"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">All Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_all%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-warning"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Pending Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_pending%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex pb-1">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-info"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Ongoing Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_ongoing%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="d-flex">
                                                    <div class="avatar flex-shrink-0 me-3">
                                                        <span class="avatar-initial rounded bg-label-success"><i class='bx bx-list-ol'></i></span>
                                                    </div>
                                                    <div class="d-flex w-75 flex-wrap align-items-center justify-content-between gap-2">
                                                        <div class="me-2">
                                                            <h6 class="mb-0">Completed Task</h6>
                                                        </div>
                                                        <div>
                                                            <h5 class="mb-0"><%=emp_task_completed%></h5>
                                                        </div>
                                                    </div>
                                                </li>
                                            </ul>

                                        </div>
                                    </div>
                                </div>
                                <% }
                                        }
                                    }%>
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
