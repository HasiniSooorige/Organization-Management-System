<%-- 
    Document   : user-ticket-view
    Created on : Jan 11, 2024, 11:05:59 AM
    Author     : HP
--%>

<%@page import="Model.Mapping.HelpTicketRespond"%>
<%@page import="Model.Logic.HelpTicketStatusDAO"%>
<%@page import="Model.Mapping.HelpTicketStatus"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="Model.Mapping.HelpTicketAttachments"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="Model.Mapping.HelpTicket"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  lang="en" class="light-style layout-menu-fixed " dir="ltr" data-theme="theme-default"
       data-assets-path="../assets/" data-template="vertical-menu-template-free">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

        <title>Exon User | Ticket View</title>

        <meta name="description"
              content="Most Powerful &amp; Comprehensive Bootstrap 5 HTML Admin Dashboard Template built for developers!" />
        <meta name="keywords" content="dashboard, bootstrap 5 dashboard, bootstrap 5 design, bootstrap 5">
        <!-- Canonical SEO -->
        <link rel="canonical" href="https://themeselection.com/products/sneat-bootstrap-html-admin-template/">

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="../assets/img/icons/ExonHalfLogo.jpg" />

        <script type="text/javascript" src="../assets/scripts/pages/ViewHelpTicket.js"></script>
        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
            rel="stylesheet">

        <!-- Icons. Uncomment required icon fonts -->
        <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />


        <!-- Core CSS -->
        <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
        <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
        <link rel="stylesheet" href="../assets/css/demo.css" />

        <!-- Vendors CSS -->
        <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

        <link rel="stylesheet" href="../assets/vendor/libs/apex-charts/apex-charts.css" />

        <!-- Fonts -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">

        <link rel="stylesheet" href="../assets/css/projectStyles.css" type="text/css"/>

        <!-- Flatpicker for date picker -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">


        <!-- Flatpicker -->
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

        <!-- Helpers -->
        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>

        <!-- Include SweetAlert from CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <!-- Include jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>


        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async="async" src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
        <script>
            window.dataLayer = window.dataLayer || [];

            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());
            gtag('config', 'GA_MEASUREMENT_ID');
        </script>

    </head>
    <%
        if ((request.getSession(false).getAttribute("user") == null)) {

            response.sendRedirect("../index.jsp");
        } else {
            if (!(request.getSession().getAttribute("Emp_GUP") == null) || !(request.getSession().getAttribute("C_GUP") == null)) {

                boolean LOGINUSER = false;
                boolean IS_CLOCED_TICKED = false;

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
                    <!-- Content wrapper -->
                    <div class="content-wrapper">

                        <!-- Content -->

                        <div class="container-xxl flex-grow-1 container-p-y">

                            <div class="row mb-3">
                                <div class="col-lg-10 mb-2 order-0">
                                    <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                            Help Ticket Details</span>
                                    </h4>
                                    <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                            Tasks . Help Ticket Details</span>
                                    </h6>
                                </div>
                            </div>
                            <%    if (request.getParameter("tid") != null) {
                                    int tid = Integer.parseInt(request.getParameter("tid"));
                                    HelpTicket helpTicket = (HelpTicket) sess.load(HelpTicket.class, tid);

                                    if (helpTicket.getHelpTicketStatus().getId() == 4) {
                                        IS_CLOCED_TICKED = true;
                                    }

                            %>
                            <div class="card">

                                <div class="card-body">

                                    <%                                        if (IS_CLOCED_TICKED) {
                                    %>
                                    <div class="row mb-3">
                                        <div class="col-sm-12" style="border: #ff0000 2px solid; text-align: center">
                                            <label class="col-form-label text-danger" style="font-size: 16px">  THIS  TICKET  IS  CLOSED. </label>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>

                                    <div class="row mb-3">

                                        <label class="col-sm-2 col-form-label">Ticket Id</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" id="ticketId" name="ticketId" value="<%=helpTicket.getTicketId()%>" readonly/>
                                        </div>
                                        <%
                                            if (helpTicket.getHelpTicketCategory().getId() != 4) {
                                        %>
                                        <label class="col-sm-2 col-form-label">Project</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" id="ticketId" name="ticketId" value="<%=helpTicket.getProjects().getName()%>" readonly/>
                                        </div>
                                        <% }%>

                                    </div>
                                    <div class="row mb-3">

                                        <label class="col-sm-2 col-form-label">Ticket Category</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" id="ticketCategory" name="ticketCategory" value="<%=helpTicket.getHelpTicketCategory().getName()%>" readonly/>
                                        </div>
                                        <label class="col-sm-2 col-form-label">Ticket Status</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" id="ticketStatus" name="ticketStatus" value="<%=helpTicket.getHelpTicketStatus().getName()%>" readonly/>
                                        </div>

                                    </div>
                                    <div class="row mb-3">

                                        <label class="col-sm-2 col-form-label">Requested By</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" id="ticketRequestedBy" name="ticketRequestedBy" value="<%=helpTicket.getRequestedBy().getFirstName()%> <%=helpTicket.getRequestedBy().getLastName()%>" readonly/>
                                        </div>
                                        <label class="col-sm-2 col-form-label">Created Date</label>
                                        <div class="col-sm-4">
                                            <input class="form-control" type="text" id="ticketCreatedDate" name="ticketCreatedDate" value="<%=Com.getDate(helpTicket.getEnteredDate())%>" readonly/>
                                        </div>


                                    </div>
                                    <div class="row mb-3">

                                        <label class="col-sm-2 col-form-label">Description</label>
                                        <div class="col-sm-10">
                                            <textarea class="form-control" type="text" id="ticketDescription" name="ticketDescription" readonly><%=helpTicket.getDescription()%></textarea>
                                        </div>
                                    </div>
                                    <div class="row mb-3">

                                        <label class="col-sm-2 col-form-label">Attachment</label>
                                        <%
                                            HelpTicketAttachments attach1 = (HelpTicketAttachments) sess.createQuery("From HelpTicketAttachments where helpTicket.id='" + helpTicket.getId() + "'").setMaxResults(1).uniqueResult();

                                            String filteredFileName = "N/A";
                                            if (attach1 != null) {

                                                String fileName = attach1.getUrl();
                                                Pattern pattern = Pattern.compile("\\d+");
                                                Matcher matcher = pattern.matcher(fileName);
                                                if (matcher.find()) {
                                                    int startIndex = matcher.start();

                                                    filteredFileName = fileName.substring(0, startIndex) + fileName.substring(startIndex + matcher.group().length() + 1);

                                                } else {
                                                    System.out.println("No numeric code found in the file name.");
                                                }
                                        %>

                                        <div class="col-sm-8">
                                            <input class="form-control" type="text" id="ticketAttachment" name="ticketAttachment" value="<%=filteredFileName%>" readonly/>
                                        </div>
                                        <div class="col-sm-2">
                                            <button class="btn rounded-pill btn-outline-info" onclick="viewHelpAttachDocs('<%=attach1.getUrl()%>');" style="width: 100%;">View</button>
                                        </div>

                                        <%
                                        } else {
                                        %>

                                        <div class="col-sm-10">
                                            <input class="form-control" type="text" id="ticketAttachment" name="ticketAttachment" value="N/A" readonly/>
                                        </div>
                                        <%
                                            }
                                        %>

                                    </div>

                                    <%
                                        if (!IS_CLOCED_TICKED) {
                                    %>

                                    <div class="row mb-3 mt-5">
                                        <div style="align-content: center" class="col-sm-2">
                                            <label class="card-title text-primary" class="col-form-label" style="margin: 7px 0 0 0 !important;">New Reply</label>
                                        </div>
                                        <div class="col-sm-8" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                        <div class="col-sm-2"><button type="button" class="btn rounded-pill btn-outline-primary" style="width: 100%" onclick="newReplyOpen();">Add</button></div>

                                    </div>
                                    <%
                                        }
                                    %>

                                    <div class="row mb-3 ">
                                        <div style="align-content: center" class="col-sm-5">
                                            <label class="card-title text-primary" class="col-form-label" style="margin: 7px 0 0 0 !important;">Ticket ID <%=helpTicket.getTicketId()%> - Response & Replies</label>
                                        </div>
                                        <div class="col-sm-7" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>
                                    </div>

                                    <!--Chat History-->
                                    <div  class="row mb-3 col-sm-12" id="mainMsgDiv">
                                        <% List<HelpTicketRespond> list = sess.createQuery("From HelpTicketRespond Where help_ticket_id='" + tid + "'").list();

                                            if (!list.isEmpty()) {
                                                for (HelpTicketRespond respond : list) {

                                                    if (respond.getHelpTicketRespondType().getId() == 1) {
                                        %>
                                        <div class="col-sm-8 mt-3 justify-content-start" id="adminMsgDivUser">
                                            <div class="row">
                                                <div class="col-sm-4" style="text-align: left;">
                                                    <label ><%=respond.getRespondedGup().getFirstName()%> <%=respond.getRespondedGup().getLastName()%></label>
                                                </div>
                                                <div class="col-sm-4"></div>
                                                <div class="col-sm-4" style="text-align: right">
                                                    <label class="col-form-label"><%= Com.getFullDateTime(respond.getRespondDate())%></label>
                                                </div>
                                            </div>
                                            <div class="row"><hr></div>
                                            <div class="row">
                                                <div>
                                                    <label ><%=respond.getComment()%></label>
                                                </div>
                                            </div>

                                            <%
                                                if (respond.getDoc() != null) {
                                            %>
                                            <div class="row">
                                                <label class="col-form-label">Attachment : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=respond.getDoc()%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                                    <i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="responseDocView('<%=respond.getDoc()%>');"></i></label>
                                            </div>
                                            <%  }  %>
                                        </div>
                                        <div class="col-sm-4"></div>
                                        <%
                                        } else if (respond.getHelpTicketRespondType().getId() == 2) {


                                        %>
                                        <div class="col-sm-4"></div>
                                        <div class="col-sm-8 mt-3 justify-content-end" id="userMsgDivUser">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label ><%=respond.getRespondedGup().getFirstName()%> <%=respond.getRespondedGup().getLastName()%></label>
                                                </div>
                                                <div class="col-sm-4"></div>
                                                <div class="col-sm-4" style="text-align: right">
                                                    <label class="col-form-label"><%= Com.getFullDateTime(respond.getRespondDate())%></label>
                                                </div>
                                            </div>
                                            <div class="row"><hr></div>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <label ><%=respond.getComment()%></label>
                                                </div>
                                            </div>
                                            <%
                                                if (respond.getDoc() != null) {
                                            %>
                                            <div class="row">
                                                <label class="col-form-label">Attachment : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=respond.getDoc()%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                                    <i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="replyDocView('<%=respond.getDoc()%>');"></i></label>
                                            </div>
                                            <%  }  %>
                                        </div>

                                        <%                  }
                                            }
                                        } else {
                                        %>
                                        <div class="row">
                                            <label class="col-form-label" style="font-size: 16px;">Waiting for Admin Response . . . </label>
                                        </div>
                                        <%  }
                                        %>
                                    </div>


                                </div>  <!--    card-body-end-->
                            </div>  <!--    card-end-->

                        </div>

                    </div>
                    <!-- / Content -->

                    <div class="content-backdrop fade"></div>

                </div>
                <!-- Content wrapper -->
            </div>
            <!-- / Layout page -->
            <!-- Overlay -->
            <div class="layout-overlay layout-menu-toggle"></div>

        </div>
        <!-- / Layout wrapper -->

        <!--=============================Add reply_model Start==================================-->
        <div class="modal fade" id="newReplyModel" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                        <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Help Ticket Reply</h4> 
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                            ></button>

                    </div>

                    <div class="modal-body">  
                        <form action="../HelpTicketReplyAdd" id="clientdetails" method="post" enctype="multipart/form-data" onsubmit="return helpTicketResponse();">   

                            <div class="row mb-3" hidden>

                                <label class="col-sm-2 col-form-label">User GUP ID</label>

                                <div class="col-sm-10">
                                    <% if (LOGINUSER) {%>
                                    <input class="form-control" type="text" id="userGUP" name="userGUP" value="<%=request.getSession().getAttribute("C_GUP")%>" readonly/>
                                    <%  } else {%>
                                    <input class="form-control" type="text" id="userGUP" name="userGUP" value="<%=request.getSession().getAttribute("Emp_GUP")%>" readonly/>
                                    <%   }%>

                                </div>
                                <label class="col-sm-2 col-form-label">Ticket Id</label>

                                <div class="col-sm-10">
                                    <input class="form-control" type="text" id="tikID" name="tikID" value="<%=helpTicket.getId()%>" readonly/>
                                </div>

                            </div>


                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Ticket No</label>

                                <div class="col-sm-10">
                                    <input class="form-control" type="text" id="ticketid" name="ticketid" value="<%=helpTicket.getTicketId()%>" readonly/>
                                </div>

                            </div>
                            <div class="row mb-3">

                                <label class="col-sm-2 col-form-label">Message  <label class="text-danger">*</label></label>

                                <div class="col-sm-10">
                                    <textarea class="form-control" type="text" id="message" name="message"></textarea>

                                    <div id="messageErrNotify"  hidden=""  class="alert-box error text-danger"><small>Please Enter Message</small></div>
                                </div>

                            </div>

                            <div class="row mb-3">
                                <div class="col-sm-2"><label class="col-form-label">Attachment</label></div>

                                <div class="col-sm-10">
                                    <input accept="image/png, image/jpeg, image/jpg, .doc, .docx, .pdf" onclick="helpResDoc();" id="helpres"  name="helpres"
                                           type="file" value="" class="form-control"  multiple="multiple" />
                                </div>
                            </div>

                            <div class="row mb-3" style="display: none" id="imagePreview">

                                <label class="col-sm-2 col-form-label">Image Preview </label>

                                <img class="col-sm-10" id="helpresDocPreview" src="#" alt="Uploaded Document">

                            </div>  

                            <div style="height: 10px;"></div>

                            <div class="row mb-3">
                                <div class="col-sm-12" align="right">
                                    <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeReplyModel();">Cancel</button>
                                    <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;">Save</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div> 
        <!--================================Add reply_model end==================================-->

        <script type="text/javascript">
            url = new URL(window.location.href);
            if (url.searchParams.has('messageSuccess')) {
                Swal.fire({
                    title: 'Reply Successfully Saved !',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'user-ticket-view.jsp?tid=<%=helpTicket.getId()%>';
                });
            }

            if (url.searchParams.has('messageError')) {
                Swal.fire({
                    title: 'Reply Not Saved !',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500
                }).then(function () {
                    window.location.href = 'user-ticket-view.jsp?tid=<%=helpTicket.getId()%>';
                });
            }
        </script>



        <%            }
        %> 
        <script src="../assets/scripts/pages/ticketpage.js"></script>

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

        <script src="../assets/js/dashboards-analytics.js"></script>


        <!-- Place this tag in your head or just before your close body tag. -->
        <script async defer src="https://buttons.github.io/buttons.js"></script>
    </body>
    <%         } else {
                response.sendRedirect("../index.jsp");
            }
        }
    %>
</html>
