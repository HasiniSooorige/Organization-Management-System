<%-- 
    Document   : userNotification
    Created on : Sep 29, 2023, 8:43:37 PM
    Author     : kanna
--%>

<%@page import="Model.Logic.NotificationManagerDAO"%>
<%@page import="Model.Mapping.NotificationManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification - Exon</title>
        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css" />

    </head>

    <body>

        <!-- Layout wrapper -->
        <div class="layout-wrapper layout-content-navbar">
            <div class="layout-container">
                <!-- Menu -->

                <%@include file="includes/admin-panel.jsp" %>
                <!-- / Menu -->

                <!-- Layout container -->
                <div class="layout-page">
                    <!-- Navbar -->
                    <%@include file="includes/header.jsp" %>
                    <!-- / Navbar -->

                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Notifications</h4>


                            <div class="row">
                                <div class="col-lg-12 mb-4 order-0">
                                    <div class="card">
                                        <div class="d-flex align-items-end row">
                                            <div class="col-sm-12">
                                                <div class="card-body">



                                                    <div class="row">


                                                        <div class="col-md-12 m-2">

                                                            <table id="credHistoryTableMngId" class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col">#ID</th>
                                                                        <th scope="col">Date</th>
                                                                        <th scope="col">Type</th>

                                                                        <th scope="col">View</th>
                                                                        <th scope="col">Delete</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>

                                                                    <%                                                            for (NotificationManager e : NotificationManagerDAO.listByQuery(sess, null, null)) {

                                                                            if (e.getIsViewed() == Boolean.FALSE) {
                                                                    %>

                                                                    <tr>

                                                                        <td><%=e.getId()%> </td>
                                                                        <td><%=e.getNotifyDate()%></td>

                                                                        <td><%=e.getNotificationType().getName()%></td>



                                                                        <td><button   onclick="viewCedentialNotificationData(<%=e.getId()%>);" type="button" class="btn btn-warning"><i class="fa-solid fa-eye"></i></button></td>


                                                                    </tr>

                                                                    <%
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
                                    </div>
                                </div>

                                <!-- Total Revenue -->



                            </div>

                        </div>
                        <!-- / Content -->



                        <div class="content-backdrop fade"></div>
                    </div>
                    <!-- Content wrapper -->
                </div>
                <!-- / Layout page -->
            </div>

            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>
        </div>
        <!-- / Layout wrapper -->




        <!--Modal - View Credential-->

        <div class="modal fade" id="viewCredNotificationModel" tabindex="-1" aria-labelledby="viewCred" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Notification Number - <span id="credNotificationNumberSpan"></span></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="alert alert-danger" role="alert">


                                <div class="col-md-12">
                                    <div class="mb-12">
                                        <h5 class="mb-1">Description</h5>
                                        <span id="credNotificationDescriptionSpan"></span>
                                    </div>
                                </div>

                            </div><br>
                            <div class="alert alert-danger" role="alert">
                                <div class="col-md-6">





                                    <div class="mb-4">
                                        <h5 class="mb-1">Date</h5>
                                        <span id="credNotificationDateSpan"></span>
                                    </div>

                                    <div class="mb-4">
                                        <h5 class="mb-1">Notification Type</h5>
                                        <span id="credNotificationtypeSpan"></span>
                                    </div>




                                </div>  
                            </div>




                        </div>




                    </div>
                </div>
            </div>
        </div>

        <!-- Core JS -->
        <%@include file="../assets/js/include/all_scripts.jsp" %>

    </body>
</html>
