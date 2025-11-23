<%-- 
    Document   : header
    Created on : Oct 18, 2023, 10:40:38 PM
    Author     : CHAMA COMPUTERS
--%>

<%@page import="Model.Logic.UserLoginDAO"%>
<%@page import="Model.Mapping.UserLogin"%>
<%
    //UserLogin user = (UserLogin) request.getSession().getAttribute("user");

    int ulid = Integer.parseInt((String.valueOf(request.getSession().getAttribute("User_ID"))));
    UserLogin user = UserLoginDAO.getByID(sess, ulid);
%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<!-- Navbar -->
<nav class="layout-navbar navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme" id="layout-navbar">
    <div class="navbar-nav-right d-flex " id="navbar-collapse">

        <div class="navbar-nav align-items-center">
            <div class="nav-item d-flex align-items-center">
                <h4 class="fw-bold py-1 mb-1"><span class="text-muted fw-light"><b>Welcome To The Exon Management Portal</b></span></h4>
            </div>
        </div>

        <ul class="navbar-nav flex-row align-items-center ms-auto">

            <!--Notification-->
            <li class="nav-item dropdown-notifications navbar-dropdown dropdown me-3 me-xl-1">
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                    <i class="bx bx-bell bx-sm"></i>
                    <span class="badge bg-danger rounded-pill badge-notifications"></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-end py-0">
                    <li class="dropdown-menu-header border-bottom">
                        <div class="dropdown-header d-flex align-items-center py-3">
                            <h5 class="text-body mb-0 me-auto">Notification</h5>
                            <a href="javascript:void(0)" class="dropdown-notifications-all text-body" data-bs-toggle="tooltip" data-bs-placement="top" aria-label="Mark all as read" data-bs-original-title="Mark all as read"><i class="bx fs-4 bx-envelope-open"></i></a>
                        </div>
                    </li>
                    <li class="dropdown-notifications-list scrollable-container ps">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item list-group-item-action dropdown-notifications-item">
                                <div class="d-flex">
                                    <div class="flex-shrink-0 me-3">
                                        <div class="avatar">
                                            <img src="../assets/img/avatars/1.png" alt="" class="w-px-40 h-auto rounded-circle">
                                        </div>
                                    </div>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">Congratulation!</h6>
                                        <p class="mb-0">Put Notification Here...</p>
                                        <small class="text-muted">1h ago</small>
                                    </div>
                                    <div class="flex-shrink-0 dropdown-notifications-actions">
                                        <a href="javascript:void(0)" class="dropdown-notifications-read"><span class="badge badge-dot"></span></a>
                                        <a href="javascript:void(0)" class="dropdown-notifications-archive"><span class="bx bx-x"></span></a>
                                    </div>
                                </div>
                            </li>

                        </ul>
                        <div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div></div></li>
                    <li class="dropdown-menu-footer border-top p-3">
                        <button class="btn btn-primary text-uppercase w-100">view all notifications</button>
                    </li>
                </ul>
            </li>
            <!-- / Notification-->

            <!-- User -->
            <li class="nav-item navbar-dropdown dropdown-user dropdown">
                <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                        <img src="../assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                        <a class="dropdown-item" href="#">
                            <div class="d-flex">
                                <div class="flex-shrink-0 me-3">
                                    <div class="avatar avatar-online">
                                        <img src="../assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                                    </div>
                                </div>
                                <div class="flex-grow-1">
                                    <span class="fw-semibold d-block"><%=user.getGeneralUserProfile().getFirstName()%> <%=user.getGeneralUserProfile().getLastName()%></span>
                                    <small class="text-muted"></small>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <div class="dropdown-divider"></div>
                    </li>
                    <li>
                        <a class="dropdown-item" href="../employee/profile.jsp">
                            <i class="bx bx-user me-2"></i>
                            <span class="align-middle">My Profile</span>
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="#">
                            <i class="bx bx-cog me-2"></i>
                            <span class="align-middle">Settings</span>
                        </a>
                    </li>

                    <li>
                        <div class="dropdown-divider"></div>
                    </li>
                    <li>
                        <a class="dropdown-item" href="../logout.jsp" >
                            <i class="bx bx-power-off me-2"></i>
                            <span class="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
            </li>
            <!--/ User -->
        </ul>
    </div>
</nav>
<!-- / Navbar -->

