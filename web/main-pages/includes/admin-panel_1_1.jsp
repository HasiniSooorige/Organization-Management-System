<%-- 
    Document   : admin-panel
    Created on : Jul 20, 2023, 11:21:15 AM
    Author     : Nilupul Nethmina
--%>
<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="org.hibernate.Session"%>
<%
    Session sess = NewHibernateUtil.getSessionFactory().openSession();
%>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />



<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>





<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
    <div class="app-brand demo">
        <a href="../main-pages/page-mng_dash_bord.jsp" class="app-brand-link">
            <span class="app-brand-text demo text-body fw-bolder">Exon</span>
        </a>
    </div>

    <div class="menu-inner-shadow"></div>

    <ul class="menu-inner py-1 ">
        <!-- Dashboard -->
        <li class="menu-item active">
            <a href="../main-pages/page-mng_dash_bord.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">Dashboard</div>
            </a>
        </li>
        <li class="menu-item">
            <a href="../main-pages/employee-leave-manager.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Employee -request leave</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../reports/leave-approval-status.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Admin -Leave Manager</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../reports/leave-list-view.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Admin -Leave History</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../help-ticket/admin-ticket-dashboard.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Admin-Help Ticket</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../help-ticket/admin-ht-response.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Admin-Ticket Respond</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../help-ticket/user-ticket-page.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">User - Help Ticket</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../help-ticket/user-new-ticket.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">User -Ticket Add</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../help-ticket/user-ht-reply.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">User -Ticket Reply</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../main-pages/universal-payroll-manager.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Paysheet-Add emp</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../main-pages/universal-payroll-manager-salary-sheet.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Paysheet-salary</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../tasks/create-new-interface.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Interface-create</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../tasks/assign-interface-to-user-roles.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Interface-assign to roles</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../projects/createProjects.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Project-Create Projects</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../projects/projectList.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Project-Projects List</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../projects/createTask.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Project-Create Task</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../projects/taskList.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Project-Task List</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../projects/clientList.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Project-Client List</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../main-pages/registerEmployee.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Emp reg</div>
            </a>    

        </li>
        <li class="menu-item">
            <a href="../main-pages/employeeList.jsp" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-lock-open-alt"></i>
                <div data-i18n="Account Settings">Emp list</div>
            </a>    

        </li>


    </ul>
</aside>
