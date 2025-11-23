<%@page import="Model.Mapping.ProjectEmployeeRole"%>
<%@page import="Model.Mapping.ProjectEmployees"%>
<%@page import="Model.Mapping.GupGopManager"%>
<%@page import="Model.Mapping.Projects"%>
<%@page import="Model.Mapping.HelpTicketCategory"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page import="Model.Mapping.HelpTicket"%>
<%@page import="Model.Mapping.GeneralUserProfile"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Model.Mapping.UserLogin"%>
<%@page import="Model.Connection.NewHibernateUtil"%>
<!DOCTYPE html>
<!--User/EMP-->
<html lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default"
      data-assets-path="../assets/" data-template="vertical-menu-template-free">

    <head>
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
            />

        <title>Exon | Add Ticket </title> 
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

        <script type="text/javascript" src="../assets/scripts/pages/NewHelpTicket.js"></script>

    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {

            if ((!(request.getSession().getAttribute("Emp_GUP") == null)) || (!(request.getSession().getAttribute("C_GUP") == null))) {

                boolean LOGINUSER = false;

                if (!(request.getSession().getAttribute("C_GUP") == null)) {
                    LOGINUSER = true;
                } else if (!(request.getSession().getAttribute("Emp_GUP") == null)) {
                    LOGINUSER = false;
                }
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
                    <%                        GeneralUserProfile user_profile = null;

                        try {
                            user_profile = user.getGeneralUserProfile();

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    %>

                    <!-- Content wrapper -->
                    <div class="content-wrapper">

                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">
                            <div class="row">
                                <div class="col-lg-10 order-0">
                                    <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                            Add Help Ticket</span>
                                    </h4>
                                    <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                            Tasks . New Ticket
                                    </h6>
                                </div>
                            </div>
                            <div class="row text-right" id="add_alert_pro" style="display: none">
                                <div class="mb-3 col-12">
                                    <div class="alert alert-warning">
                                        <h6 class="alert-heading mb-1 text-danger">Project Selection and Document Uploads are not mandatary.</h6>
                                        <p class="mb-0 text-danger">You can upload a help ticket without selecting the project and uploading a document.</p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="row">
                            <div class="card mb-4">
                                <div class="card-body p-lg-5" style="margin: 0 30px 0 30px ;">
                                    <form>
                                        <%                                        GupGopManager gup = (GupGopManager) sess.createQuery("FROM GupGopManager where generalUserProfile.id='" + user_profile.getId() + "'").uniqueResult();

                                        %>

                                        <div class="mb-3 row">
                                            <label for="ticketCategory" class="col-md-2 col-form-label">Ticket Category  <label class="text-danger">*</label></label>
                                            <div class="col-md-10">
                                                <%                                                        List<HelpTicketCategory> helpTicketCategories = sess.createQuery("from HelpTicketCategory").list();
                                                %>
                                                <select id="ticketCategory" class="form-select" onchange="categorySelect();">
                                                    <option value="" selected disabled>Select Category</option>
                                                    <%
                                                        for (HelpTicketCategory category : helpTicketCategories) {
                                                            if (LOGINUSER) {
                                                                if (!category.getName().equals("Other")) {

                                                    %>
                                                    <option value="<%=category.getId()%>"><%=category.getName()%></option>

                                                    <%
                                                        }
                                                    } else {
                                                    %>
                                                    <option value="<%=category.getId()%>"><%=category.getName()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>

                                                <div id="ticketCategoryError"  hidden=""  class="alert-box error text-danger"><small>Please Select Ticket Category</small></div>
                                            </div>
                                        </div>
                                        <%    if (LOGINUSER) {
                                                //CLIENT LOG
                                        %>

                                        <div class="mb-3 row">
                                            <label for="projectSelect" class="col-md-2 col-form-label">Project  <label class="text-danger">*</label></label>
                                            <div class="col-md-10">
                                                <select id="projectSelect" class="form-select">

                                                    <%
                                                        GupGopManager g = (GupGopManager) sess.createQuery("From GupGopManager where generalUserProfile.id='" + user.getGeneralUserProfile().getId() + "'").setMaxResults(1).uniqueResult();
                                                        Integer UserOrg = g.getGeneralOrganizationProfile().getId();
                                                        if (g != null) {

                                                            List<Projects> projects = sess.createQuery("FROM Projects Where generalOrganizationProfile.id='" + UserOrg + "'").list();
                                                    %>
                                                    <option value="">Select Project</option>
                                                    <%
                                                        if (projects != null) {

                                                            for (Projects p : projects) {
                                                    %>
                                                    <option value="<%=p.getId()%>"><%=p.getName()%></option>

                                                    <%                                                   }

                                                    } else {
                                                    %>
                                                    <option >You are not assign any project</option>
                                                    <%
                                                        }

                                                    } else {
                                                    %>
                                                    <option >You are not assign any project</option>
                                                    <%
                                                        }
                                                    %> 
                                                </select>
                                                <div id="projectSelectClienterror"  hidden=""  class="alert-box error text-danger"><small>Please Select Project</small></div>

                                            </div>
                                        </div>
                                        <%
                                            // IF LOGIN clent
                                            if (g != null) {

                                                List<GupGopManager> gupGOP = sess.createQuery("FROM GupGopManager Where general_organization_profile_id='" + UserOrg + "'").list();
                                        %>
                                        <div class="mb-3 row">
                                            <label class="col-md-2 col-form-label">Requested by <label class="text-danger">*</label></label>
                                            <div class="col-md-10">
                                                <select  id="requestor" class="form-select">
                                                    <option value="" selected disabled>Select User Name</option>
                                                    <%
                                                        if (gupGOP != null) {

                                                            for (GupGopManager gupgop : gupGOP) {
                                                    %>
                                                    <option value="<%=gupgop.getGeneralUserProfile().getId()%>"><%=gupgop.getGeneralUserProfile().getFirstName() + " " + gupgop.getGeneralUserProfile().getLastName()%></option>
                                                    <%                                                   }

                                                        }
                                                    %>
                                                </select>
                                                <div id="requesterError"  hidden=""  class="alert-box error text-danger"><small>Please Select Your Name</small></div>

                                            </div>
                                        </div>
                                        <%
                                            }
                                        } else {
                                            //EMP LOG
                                        %>

                                        <div class="mb-3 row">
                                            <label class="col-md-2 col-form-label">Assigned Projects  <label id="ProjectAstro" class="text-danger">*</label></label>
                                            <div class="col-md-10">
                                                <select id="projectSelect" class="form-select">
                                                    <option value="">Select Project</option>
                                                    <%
                                                        List<ProjectEmployees> p_e_list = sess.createQuery("From ProjectEmployees where employee.generalUserProfile='" + user.getGeneralUserProfile().getId() + "'").list();
                                                        if (p_e_list != null) {
                                                            for (ProjectEmployees p : p_e_list) {
                                                    %>
                                                    <option value="<%=p.getProjects().getId()%>"><%=p.getProjects().getName()%></option>

                                                    <%                                                   }
                                                        }

                                                    %>
                                                </select>
                                                <div id="projectSelecterror"  hidden=""  class="alert-box error text-danger"><small>Please Select Assigned Project</small></div>
                                            </div>
                                        </div>

                                        <%                                        }
                                        %>

                                        <div class="mb-3 row">
                                            <label class="col-form-label col-md-2">Description  <label class="text-danger">*</label></label>
                                            <div class="col-md-10">

                                                <textarea class="form-control " id="description" rows="5"></textarea>
                                                <div id="descriptionerror"  hidden=""  class="alert-box error text-danger"><small>Please Enter Description</small></div>
                                            </div>
                                        </div>
                                        <div class="mb-3 row">
                                            <label class="col-form-label col-md-2">Document <label id="docAstro" class="text-danger">*</label></label>
                                            <div class="col-md-10">
                                                <input class="form-control" type="file" id="tfiles" multiple onclick="ticketImageView();" accept="image/png, image/jpeg, image/jpg, .doc, .docx, .pdf">
                                                <div id="documenterror"  hidden=""  class="alert-box error text-danger"><small>Please select a document to upload.</small></div>
                                            </div>
                                        </div>

                                        <div class="row mb-3" style="display: none" id="imagePreview">

                                            <label class="col-sm-2 col-form-label">Image Preview </label>

                                            <img class="col-sm-10" id="empDocPreview" src="#" alt="Uploaded Image">

                                        </div>
                                        <%
                                            if (LOGINUSER) {
                                        %>
                                        <div class="row mb-3">
                                            <div class="col-sm-12" align="right">
                                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;">Cancel</button>
                                                <button type="submit" id="add_btn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="submitTicket('clent', <%=user.getId()%>)">Save</button>
                                            </div>
                                        </div>
                                        <%
                                        } else {
                                        %>

                                        <div class="row mb-3">
                                            <div class="col-sm-12" align="right">
                                                <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;">Cancel</button>
                                                <button type="submit" id="add_btn" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="submitTicket('emp', <%=user.getId()%>)">Save</button>
                                            </div>
                                        </div>
                                        <%
                                            }
                                        %>
                                    </form>
                                </div>

                            </div>

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

        <script src="../assets/js/ticket.js"></script>

    </body>
    <%
            } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>