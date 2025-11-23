<%-- 
    Document   : clientList
    Created on : Sep 12, 2023, 8:44:21 AM
    Author     : HP
--%>

<%@page import="Model.Logic.GeneralOrganizationProfileDAO"%>
<%@page import="Model.Mapping.GeneralOrganizationProfile"%>
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

        <title>Exon Admin | Client Manager</title> 

        <meta name="description" content="" />
        <!-- jQuery -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"
        ></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>
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

        <script src="../assets/vendor/js/helpers.js"></script>

        <script src="../assets/js/config.js"></script>
        <script type="text/javascript" src="../assets/scripts/pages/ListofClients.js"></script>

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
                    <!-- Content wrapper -->
                    <div class="content-wrapper">
                        <!-- Content -->
                        <div class="container-xxl flex-grow-1 container-p-y">
                            <h4 class="fw-bold py-1 mb-1"><span class="text-primary fw-light">
                                    Clients Manager</span>
                            </h4>
                            <h6 class="fw-bold py-1 mb-4"><span class="text-muted fw-light">
                                    Maintain . Clients Manager
                            </h6>
                            <div class="row">
                                <!-- Basic Layout -->
                                <div class="card mb-4">
                                    <div class="col-12 offset-12 mt-3">

                                        <div style="float: left;">
                                            <div class="navbar-nav align-items-center">
                                                <div class="nav-item d-flex align-items-center">
                                                    <i class="bx bx-search fs-4 lh-0"></i>
                                                    <input type="text" class="form-control border-0 shadow-none ps-1 ps-sm-2" placeholder="Search..." aria-label="Search..." oninput="searchClientTable();">
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                                    <div id="tableDiv">
                                        <div class="table-responsive text-nowrap" id="clientTableDataDiv">
                                            <table id="table_projects"  class="table table-striped">
                                                <thead class="sticky-header table-light" id="clientHeader">
                                                    <tr>
                                                        <th>Id</th>
                                                        <th>Name</th>
                                                        <th>Email</th>
                                                        <th>Contact No</th>
                                                        <th>View</th>
                                                        <th>Details</th>
                                                        <th>Edit</th>
                                                        <th>Employee</th>
                                                    </tr>
                                                </thead>

                                                <tbody class="table-border-bottom-0" id="tableempbody">

                                                    <%                                                        int table_row_id = 0;
                                                        for (GeneralOrganizationProfile e : GeneralOrganizationProfileDAO.listByQuery(sess, null, null)) {
                                                            table_row_id++;

                                                    %>

                                                    <tr>

                                                        <td><%=table_row_id%> </td>
                                                        <td class="project-client-cell"><%=e.getName()%> </td>
                                                        <td class="project-client-cell"><%=e.getEmail()%></td>
                                                        <td><%=e.getContactNo()%></td>
                                                        <td><i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewClientDetails(<%=e.getId()%>);"></i></td>
                                                        <td><button  class="btn rounded-pill btn-outline-info" onclick="addClientEmployee(<%=e.getId()%>);" >Add</button></td>
                                                        <td><button  class="btn rounded-pill btn-outline-success" onclick="editClientDetails(<%=e.getId()%>);" >Edit</button></td>
                                                        <td><button  class="btn rounded-pill btn-outline-warning" onclick="clientTeamDetails(<%=e.getId()%>);" >Team</button></td>

                                                    </tr>

                                                    <%                                                                                                      }

                                                    %>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="8">
                                                            <span style="float: left;">
                                                                <button type="button" class="btn btn-outline-primary page-size active"  data-size="10" onclick="setPageSize(10)">10</button>
                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="25" onclick="setPageSize(25)">25</button>
                                                                <button type="button" class="btn btn-outline-primary page-size" data-size="50" onclick="setPageSize(50)">50</button>
                                                                <button type="button" class="btn btn-outline-primary" onclick="loadAllClientRows()" id="allButton">All</button>
                                                            </span>

                                                            <span style="float: right;">
                                                                <nav aria-label="Page navigation">
                                                                    <ul class="pagination" id="pagination"></ul>
                                                                </nav>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                            </table>
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
    <!-- / Layout wrapper -->


    <!--=============================Model - View Client Data Start==================================-->

    <div class="modal fade" id="viewClientData" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                    <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Client Details</span></h4> 
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                        ></button>

                </div>
                <div class="modal-body">

                    <form>

                        <div class="row mb-3">

                            <div class="col-sm-4"></div>

                            <div class="col-sm-4" id="clientLogoView" style="height: 250px;">
                                <img id="imgClient" src="#" alt="client logo" style="display: none;">
                            </div>

                            <div class="col-sm-4"></div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Name</label>

                            <div class="col-sm-10">

                                <input class="form-control" type="text" id="viewCliName" name="viewClientName" readonly/>

                            </div>
                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Address 1</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text" id="viewCliAdd1" name="viewCliAdd1" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Address 2</label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text" id="viewCliAdd2" name="viewCliAdd2" readonly/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-2 col-form-label">Address 3</label>

                            <div class="col-sm-10">

                                <input class="form-control" type="text" id="viewCliAdd3" name="viewCliAdd3" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Email</label>

                            <div class="col-sm-10 ">

                                <input class="form-control" type="text" id="CliEmail" name="CliEmail" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Contact No</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewCliContact" name="viewCliContact" readonly/>

                            </div>

                            <label class="col-sm-2 col-form-label">Fax No</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewCliFaxNo" name="viewCliFaxNo" readonly/>

                            </div>

                        </div>

                        <div class="row mb-3">

                            <label class="col-sm-2 col-form-label">Created Date</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewCliCreateDate" name="viewCliCreateDate" readonly/>

                            </div>

                            <label class="col-sm-2 col-form-label">Country</label>

                            <div class="col-sm-4">

                                <input class="form-control" type="text" id="viewCliCountry" name="viewCliCountry" readonly/>

                            </div>

                        </div>

                        <div style="height: 10px;"></div>


                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-2">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Client Team</label>
                            </div>

                            <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="clientTeamDiv" style="display: none;">
                            <div class="row" id="tableIntakeRowViewClient">
                                <div class="col-sm-12">

                                    <table id="allClientTeamTableView" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Name</th>
                                                <th>NIC</th>
                                                <th>Email</th>
                                                <th>Mobile No</th>
                                            </tr>
                                        </thead>

                                        <tbody id="ClientTeamTableBodyView">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="clientTeamDivEmpty" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12" >
                                    No Client Members Added.
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">

                            <div style="align-content: center" class="col-sm-2">
                                <label class="card-title text-primary" class="form-label" style="margin: 7px 0 0 0 !important;">Project List</label>
                            </div>

                            <div class="col-sm-10" style="align-content: center;"><hr style="margin: 20px 0px 12px 0px !important"></div>

                        </div>

                        <div class="row mb-3" id="projectListDiv" style="display: none;">
                            <div class="row" id="tableIntakeRowViewClientProList">
                                <div class="col-sm-8">

                                    <table id="ClientProListTableView" class="table">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Name</th>
                                                <th>Status</th>
                                            </tr>
                                        </thead>

                                        <tbody id="ClientProListTableBodyView">

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="row mb-3" id="projectListDivEmpty" style="display: none;">
                            <div class="row">
                                <div class="col-sm-12" >
                                    No Projects Added.
                                </div>
                            </div>
                        </div>

                    </form>
                </div>


            </div>
        </div>

    </div>

    <!--================================Model - View Client Data end==================================-->


    <!--=============================Model - Add Client Data Start==================================-->

    <div class="modal fade" id="addNewClientEmployee" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                    <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Add Client Employee</span></h4> 
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                        ></button>

                </div>
                <div class="modal-body">
                    <div class="row mb-3" hidden>

                        <label class="col-sm-2 col-form-label">Client Id</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="clientId" name="clientId" />
                        </div>

                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">First Name <label class="text-danger">*</label></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="clientFirstName" name="clientFirstName" />
                            <div id="clientFirstNameError"  hidden=""  class="text-danger"><small>Please Enter First Name</small></div>
                        </div>

                        <label class="col-sm-2 col-form-label">Last Name <label class="text-danger">*</label></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="clientLastName" name="clientLastName"/>

                            <div id="clientLastNameError"  hidden=""  class="text-danger"><small>Please Enter Last Name</small></div>
                        </div>
                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">NIC <label class="text-danger">*</label></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="clientNic" name="clientNic"/>

                            <div id="clientNicError"  hidden=""  class="text-danger"><small>Please Enter NIC</small></div>
                            <div id="clientNicinvalidError"  hidden=""  class="text-danger"><small>Please Enter a Valid NIC</small></div>
                        </div>
                        <label class="col-sm-2 col-form-label">Email <label class="text-danger">*</label></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="clientemail" name="clientemail" />

                            <div id="clientemailError"  hidden=""  class="text-danger"><small>Please Enter Email</small></div>
                            <div id="clientemailInvalidError"  hidden=""  class="text-danger"><small>Please Enter a Valid Email</small></div>
                        </div>
                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Telephone No <label class="text-danger">*</label></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="companycontactNo" name="companycontactNo" />

                            <div id="companycontactNoError"  hidden=""  class="text-danger"><small>Please Enter Telephone No</small></div>
                            <div id="companycontactNoinValidError"  hidden=""  class="text-danger"><small>Please Enter Valid Telephone No</small></div>
                        </div>
                        <label class="col-sm-2 col-form-label">Mobile No <label class="text-danger">*</label></label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="clientMobileNo" name="clientMobileNo"/>

                            <div id="clientMobileNoErrr"  hidden=""  class="text-danger"><small>Please Enter Mobile No</small></div>
                            <div id="clientMobileNoinValidErrr"  hidden=""  class="text-danger"><small>Please Enter a Valid Mobile No</small></div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-12" align="right">
                            <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeAddNewClient();">Cancel</button>
                            <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;" id="saveNewClient" name="saveNewClient" onclick="addNewRowNewClient();">Save</button>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <!--================================Model - Add Client Data end==================================-->

    <!--=============================Model - Edit Client Data Start==================================-->

    <div class="modal fade" id="editClient" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                    <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Edit Client Details</span></h4> 
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                        ></button>

                </div>
                <div class="modal-body">
                    <div class="row mb-3" hidden>

                        <label class="col-sm-2 col-form-label">Client Id</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="editClientId" name="editClientId" />
                        </div>

                    </div>

                    <div style="height: 10px;"></div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Name</label>

                        <div class="col-sm-10">

                            <input class="form-control" type="text" id="editCliName" name="editCliName" readonly/>

                        </div>

                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Address 1</label>
                        <div class="col-sm-10">
                            <input class="form-control" type="text" id="editCliAdd1" name="editCliAdd1"/>

                            <div id="EditAddress1Error"  hidden=""  class="text-danger"><small>Please Enter Address Line 1</small></div>
                        </div>

                    </div>

                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">Address 2</label>
                        <div class="col-sm-10">
                            <input class="form-control" type="text" id="editCliAdd2" name="editCliAdd2"/>

                            <div id="EditAddress2Error"  hidden=""  class="text-danger"><small>Please Enter Address Line 2</small></div>
                        </div>
                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Address 3</label>

                        <div class="col-sm-10">

                            <input class="form-control" type="text" id="editCliAdd3" name="editCliAdd3"/>
                            <div id="editAddress3Error"  hidden=""  class="text-danger"><small>Please Enter Address Line 3</small></div>
                        </div>

                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Email</label>

                        <div class="col-sm-10">

                            <input class="form-control" type="text" id="editCliEmail" name="editCliEmail"/>
                            <div id="editEmailError"  hidden=""  class="text-danger"><small>Please Enter Your Email</small></div>
                            <div id="editEmailinvalidError"  hidden=""  class="text-danger"><small>Please Enter a Valid Email</small></div>
                        </div>
                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Mobile No</label>

                        <div class="col-sm-4">

                            <input class="form-control" type="text" id="editCliContact" name="editCliContact"/>
                            <div id="editContactError"  hidden=""  class="text-danger"><small>Please Enter Your Mobile No</small></div>
                            <div id="editcontactInvalidError"  hidden=""  class="text-danger"><small>Please Enter Valid Mobile No</small></div>
                        </div>

                        <label class="col-sm-2 col-form-label">Fax No</label>

                        <div class="col-sm-4">

                            <input class="form-control" type="text" id="editCliFaxNo" name="editCliFaxNo"/>
                            <div id="editFaxError"  hidden=""  class="text-danger"><small>Please Enter Fax No</small></div>
                            <div id="editFaxInvalidError"  hidden=""  class="text-danger"><small>Please Enter a Valid Fax No</small></div>
                        </div>
                    </div>

                    <div class="row mb-3">

                        <label class="col-sm-2 col-form-label">Created Date</label>

                        <div class="col-sm-4">

                            <input class="form-control" type="text" id="editCliCreateDate" name="editCliCreateDate" readonly/>

                        </div>

                        <label class="col-sm-2 col-form-label">Country</label>

                        <div class="col-sm-4">

                            <input class="form-control" type="text" id="editCliCountry" name="editCliCountry" readonly/>

                        </div>

                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-12" align="right">
                            <button type="reset" class="btn rounded-pill btn-outline-primary" style="width: 200px;" onclick="closeEditClient();">Cancel</button>
                            <button type="submit" id= "showAlert" class="btn rounded-pill btn-primary" style="width: 200px;" onclick="editClientData();">Save</button>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>

    <!--================================Model - Edit Client Data end==================================-->


    <!--=============================Model - Client Team Start==================================-->

    <div class="modal fade" id="clientEmpDetails" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="padding-top: 20px !important; height: 50px;">
                    <h4 class="fw-bold py-3 mb-4 mt-4"><span class="text-primary fw-light">Client Employee Details</span></h4> 
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close"
                        ></button>

                </div>
                <div class="modal-body">

                    <div class="row mb-3"  id="clientEmployeeListDiv" style="display: none;">
                        <div class="row" id="tableIntakeRowClientTeam">
                            <div class="col-sm-12">

                                <table id="ClientTeamEmpTable" class="table">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Name</th>
                                            <th>NIC</th>
                                            <th>Email</th>
                                            <th>Mobile No</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>

                                    <tbody id="ClientTeamEmpTableBody">

                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>

                    <div class="row mb-3" id="clientEmployeeListDivEmpty" style="display: none;">
                        <div class="row">
                            <div class="col-sm-12" >
                                No Client Employee Added.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!--================================Model -  Client Team end==================================-->


    <script type="text/javascript">
        url = new URL(window.location.href);
        if (url.searchParams.has('ClientSuccess')) {
            Swal.fire({
                title: 'Successfully Saved',
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true,
                closeOnConfirm: false,
                timer: 1500,
            }).then(function () {
                window.location.href = 'clientList.jsp';
            });

        }

        if (url.searchParams.has('ClientError')) {
            Swal.fire({
                title: 'Data Not Saved',
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true,
                closeOnConfirm: false,
                timer: 1500,
            }).then(function () {
                window.location.href = 'clientList.jsp';
            });

        }

        if (url.searchParams.has('messageSuccess')) {
            Swal.fire({
                title: 'Successfully Saved',
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true,
                closeOnConfirm: false,
                timer: 1500,
            }).then(function () {
                window.location.href = 'clientList.jsp';
            });

        }

        if (url.searchParams.has('messageError')) {
            Swal.fire({
                title: 'Data Not Saved',
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true,
                closeOnConfirm: false,
                timer: 1500,
            }).then(function () {
                window.location.href = 'clientList.jsp';
            });

        }


    </script>

    <script>
//       ----- Pagination  -----
        var currentPage = 1;
        var pageSize = 10;
        var tableRows = document.querySelectorAll("#tableempbody tr");
        var totalPages = Math.ceil(tableRows.length / pageSize);

        function updatePagination() {
            var pagination = document.getElementById("pagination");
            pagination.innerHTML = "";

            if (totalPages <= 1) {
                return;
            }

            var maxPageLinks;

            if (pageSize === 10) {
                maxPageLinks = 100;
            } else if (pageSize === 25) {
                maxPageLinks = 40;
            } else if (pageSize === 50) {
                maxPageLinks = 20;
            }

            var startPage = Math.max(1, currentPage - Math.floor(maxPageLinks / 2));
            var endPage = Math.min(totalPages, startPage + maxPageLinks - 1);

            if (endPage - startPage < maxPageLinks - 1) {
                startPage = Math.max(1, endPage - maxPageLinks + 1);
            }

            for (var i = startPage; i <= endPage; i++) {
                var li = document.createElement("li");
                li.className = "page-item";
                var a = document.createElement("a");
                a.className = "page-link";
                a.href = "javascript:void(0);";
                a.innerText = i;
                a.onclick = function () {
                    currentPage = parseInt(this.innerText);
                    updateTable();
                };
                li.appendChild(a);
                pagination.appendChild(li);
            }
        }

        function updateTable() {
            var startIndex = (currentPage - 1) * pageSize;
            var endIndex = currentPage * pageSize;

            tableRows.forEach(function (row, index) {
                if (index >= startIndex && index < endIndex) {
                    row.style.display = "table-row";
                } else {
                    row.style.display = "none";
                }
            });

            updatePagination();
        }

        function setPageSize(size) {
            pageSize = size;
            currentPage = 1;
            totalPages = Math.ceil(tableRows.length / pageSize);
            updateTable();

            var buttons = document.querySelectorAll('.page-size');
            buttons.forEach(function (button) {
                if (button.getAttribute('data-size') === size.toString()) {
                    button.classList.add('active');
                } else {
                    button.classList.remove('active');
                }
            });
        }

        updateTable();
    </script>


    <!-- build:js assets/vendor/js/core.js -->
    <script src="../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../assets/vendor/libs/popper/popper.js"></script>
    <script src="../assets/vendor/js/bootstrap.js"></script>
    <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="multiselect.min.js"></script>

    <script src="../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="../assets/js/main.js"></script>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

    <!-- Page JS -->
    <script src="../assets/js/pages-account-settings-account.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>

</body>
<%         } else {
            response.sendRedirect("../index.jsp");
        }
    }
%>
</html>

