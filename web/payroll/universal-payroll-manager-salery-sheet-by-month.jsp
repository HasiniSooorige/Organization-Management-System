
<%@page import="Model.Connection.NewHibernateUtil"%>
<%@page import="Model.CommonMethod.Com"%>
<%@page import="java.util.List"%>
<%@page import="Model.Mapping.UniversalPayrollManager"%>
<%@page import="org.hibernate.Session"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Session sess = NewHibernateUtil.getSessionFactory().openSession();
    int selectedMonth = 0;
    int selectedYear = 0;
    String selected_month = "";
    if (!(request.getParameter("yea").equals("0"))) {
        String[] arr = request.getParameter("yea").split("-");
        selectedYear = Integer.parseInt(arr[0].trim());
        selectedMonth = Integer.parseInt(arr[1].trim());
        selected_month = selectedYear + "-" + selectedMonth + "-01";
    }
    System.out.println("selected_month " + selected_month);
    List<UniversalPayrollManager> payrollManagers = sess.createQuery("from UniversalPayrollManager "
            + "where YEAR(salaryDate)='" + selectedYear + "' AND MONTH(salaryDate)='" + selectedMonth + "'").list();
%>
<div class="row">
    <div class="col-md-12">
        <a  href="../print/print-c-form.jsp?month=<%=  selected_month%>" target="_blank" class="btn btn-sm grey-mint" > Print C Form<br/>
            <span class="glyphicon glyphicon-print"> </span>
        </a>
    </div>
</div>
<br/><br/><br/>
<table class="table table-responsive table-bordered table-hover" id="salery_sheet_table">
    <thead>
        <tr>
            <th>#</th>
            <th>EPF No</th>
            <th>Name</th>
            <th>NIC</th>
            <th>Basic Salary</th>
            <th>BR</th>
            <th>Gross Salary</th>
            <th>No pay</th>
            <th>Salary for EPF</th>
            <th>EPF 8%</th>
            <th>EPF 12%</th>
            <th>ETF 3%</th>
            <th>Attendance</th>
            <th>Performance</th>
            <th>Incentive</th>
            <th>Traveling</th>
            <th>House Rental</th>
            <th>Salary Advance</th>
            <th>Other Deductions</th>
            <th>Tax</th>
            <th>Total</th>
            <th>Print Salary Slip</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%
            int count = 0;
            int isEpf = 1;
            String name = "";
            for (UniversalPayrollManager pm : payrollManagers) {
                isEpf = 1;

                if (pm.getEmployee().getIsEpf() != null) {
                    if (!pm.getEmployee().getIsEpf()) {
                        isEpf = 0;
                    }
                }
                name = pm.getEmployee().getGeneralUserProfile().getFirstName() + " " + pm.getEmployee().getGeneralUserProfile().getLastName();
                if (pm.getEmployee().getGeneralUserProfile().getNameWithIn() != null && !pm.getEmployee().getGeneralUserProfile().getNameWithIn().equalsIgnoreCase("Null")) {
                    name = pm.getEmployee().getGeneralUserProfile().getNameWithIn();
                }
        %>
        <tr>
            <td><%= ++count%></td>
            <td><%= pm.getEmployee().getEpfNo()%></td>
            <td><%=name%></td>
            <td><%= pm.getEmployee().getGeneralUserProfile().getNic()%></td>
            <td class="editable-td">
                <span id="basic_salery_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getBasicSalary())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="basic_salery<%= pm.getId()%>" value="<%= pm.getBasicSalary()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="br_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getBr())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="br<%= pm.getId()%>" value="<%= pm.getBr()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td id="gross_salery<%= pm.getId()%>"><%= Com.numformat(pm.getGrossSalary())%></td>
            <td class="editable-td">
                <span id="no_pay_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getNoPay())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="no_pay<%= pm.getId()%>" value="<%= pm.getNoPay()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td id="salary_for_epf<%= pm.getId()%>"><%= Com.numformat(pm.getGrossSalary() - pm.getNoPay())%></td>
            <td id="epf_8<%= pm.getId()%>"><%= Com.numformat(pm.getEpf8())%></td>
            <td id="epf_12<%= pm.getId()%>"><%= Com.numformat(pm.getEpf12())%></td>
            <td id="etf_3<%= pm.getId()%>"><%= Com.numformat(pm.getEtf3())%></td>
            <td class="editable-td">
                <span id="attantance_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getAttendance())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="attantance<%= pm.getId()%>" value="<%= pm.getAttendance()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="porfoments_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getPerformance())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="porfoments<%= pm.getId()%>" value="<%= pm.getPerformance()%>">
            </td>
            <td class="editable-td">
                <span id="insentive_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getIncentive())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="insentive<%= pm.getId()%>" value="<%= pm.getIncentive()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="traveling_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getTravelling())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="traveling<%= pm.getId()%>" value="<%= pm.getTravelling()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="house_rental_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getHouseRental())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="house_rental<%= pm.getId()%>" value="<%= pm.getHouseRental()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="salary_advance_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getSalaryAdvanced())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="salary_advance<%= pm.getId()%>" value="<%= pm.getSalaryAdvanced()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="other_deductions_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getOtherDeduction())%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="other_deductions<%= pm.getId()%>" value="<%= pm.getOtherDeduction()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td class="editable-td">
                <span id="other_deductions_text<%= pm.getId()%>" class="input_text<%= pm.getId()%>"><%= Com.numformat(pm.getTax() )%></span>
                <input class="number_only edit_input<%= pm.getId()%>" type="hidden" id="tax<%= pm.getId()%>" value="<%= pm.getTax()%>" onkeyup="calculateSalery('<%= pm.getId()%>', '<%= isEpf%>');">
            </td>
            <td id="total<%= pm.getId()%>"><%= Com.numformat(pm.getTotalSalary())%></td>
            <td class="text-center">
                <a  href="../print/print-employee-salary-sheet.jsp?pmId=<%=  pm.getId()%>" target="_blank" class="btn btn-sm grey-mint" > Print<br/>
                    <span class="glyphicon glyphicon-print"> </span>
                </a>

            </td>
            <td>
                <button type="button" id="edit_btn<%= pm.getId()%>" class="btn btn-xs btn-warning" onclick="enableEditOption('<%= pm.getId()%>', '<%= isEpf%>');">Edit</button>
                <button type="button" id="save_btn<%= pm.getId()%>" class="btn btn-xs btn-success" onclick="savePaySheet('<%= pm.getId()%>', '<%= isEpf%>');" style="display: none">Save</button>
            </td>
        </tr>
        <%
            }
        %>

    </tbody>
</table>


<script>
    var table = $('#salery_sheet_table');
    var oTable = table.dataTable({
        // Internationalisation. For more info refer to http://datatables.net/manual/i18n
        "language": {
            "aria": {
                "sortAscending": ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            },
            "emptyTable": "No data available in table",
            "info": "Showing _START_ to _END_ of _TOTAL_ entries",
            "infoEmpty": "No entries found",
            "infoFiltered": "(filtered1 from _MAX_ total entries)",
            "lengthMenu": "_MENU_ entries",
            "search": "Search:",
            "zeroRecords": "No matching records found"
        },
        // Or you can use remote translation file
        //"language": {
        //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
        //},

        buttons: [
//                                                            {extend: 'print', className: 'btn dark btn-outline'},
//                                                            {extend: 'copy', className: 'btn red btn-outline'},
//                                                            {extend: 'pdf', className: 'btn green btn-outline'},
            //                                {extend: 'csv', className: 'btn purple btn-outline '},
            {extend: 'colvis', className: 'btn dark btn-outline', text: 'Columns'}
        ],
        // setup responsive extension: http://datatables.net/extensions/responsive/
        responsive: false,
        //"ordering": false, disable column ordering 
        //"paging": false, disable pagination

        //        fixedHeader: {
        //            header: true,
        ////            headerOffset: fixedHeaderOffset
        //        },

        "order": [
            [0, 'asc']
        ],
        "lengthMenu": [
            [5, 10, 15, 20, -1],
            [5, 10, 15, 20, "All"] // change per page values here
        ],
        // set the initial value
        "pageLength": 10,
        "dom": "<'row' <'col-md-12'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable

        // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
        // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js). 
        // So when dropdowns used the scrollable div should be removed. 
        //"dom": "<'row' <'col-md-12'T>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",
    });

    $('.number_only').keypress(function () {
        validateAmount(event);
    });
</script>



