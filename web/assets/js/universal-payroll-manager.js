function searchSalerySheetByMonth() {

    var year = $('#year-select').val();
    var month = $('#month-select').val();
    var yea = year + "-" + month;
    alert(yea);
    if (year !== "" && month !== "") {
        var month = $('#date_selected_value_salery_sheet').val();
        $("#search_btn").hide();
        $("#preloader_search").show();
        $.post('../payroll/universal-payroll-manager-salery-sheet-by-month.jsp', {
            yea:yea
        }, function (data) {
            $("#search_btn").show();
            $("#preloader_search").hide();
            $('#salery_sheet_by_month_table').empty();
            $('#salery_sheet_by_month_table').html(data);
        });
    } else {
        alert("select month");
    }
}

function enableEditOption(id) {
    
    $('.edit_input' + id + '[type="hidden"]').each(function () {
        this.type = 'text';
    });
    $(".input_text" + id).toggleClass("input_text_none");
    $('#edit_btn' + id).css('display', 'none');
$('#save_btn' + id).css('display', 'block');
}

function AddEmployeeToSalerySheet() {

    var year = $('#year-select').val();
    var month = $('#month-select').val();
    alert(year + " " + month);
    if (year !== "" && month !== "") {
        var confirmmsg = confirm("Do you Want to Continue ?");
        if (confirmmsg) {

            var table_Details_Table = document.getElementById("payroll_table");
            var rows_Details_Table = table_Details_Table.rows.length;

            var check = false;

            for (i = 1; i < rows_Details_Table; i++) {
                if (document.getElementById("checkbox" + i).checked == true) {
                    check = true;
                }
            }
            if (check == false) {
                alert("Select atleast one emplyoee who wants to add !");
            } else {
                var jsn_object_route_from = {jsn: []};

                for (i = 1; i < rows_Details_Table; i++) {
                    var CellsVal = table_Details_Table.rows.item(i).cells;
                    var empid = CellsVal.item(4).innerHTML;
                    if (document.getElementById("checkbox" + i).checked == true) {
                        jsn_object_route_from.jsn.push({"empid": empid});
                    }

                }
                var json_array_route_from = JSON.stringify(jsn_object_route_from);
                $("#add_btn").hide();
                $("#add_preloader").show();
                $.post('../AddEmployeesToSalarySheet', {
                    jsnobj: json_array_route_from,
                    month: month,
                    year: year
                }, function (data) {
                    $("#add_btn").show();
                    $("#add_preloader").hide();
                    alert(data.message);
                    location.reload();
                });
            }

        }
    } else {
        alert("select month");
    }

}
function Set_EmployeeCheckedAll() {


    var table_Details_Table = document.getElementById("payroll_table");
    var rows_Details_Table = table_Details_Table.rows.length;
    alert(rows_Details_Table);
    if (document.getElementById('checkbox').checked) {
        for (i = 1; i < rows_Details_Table; i++) {

            var s = "checkbox" + (i);
            if (!$('#' + s).is(':disabled')) {
                $('#' + s).prop('checked', true);
            } else {
                $('#' + s).prop('checked', false);
            }
        }
    } else {
        for (i = 1; i < rows_Details_Table; i++) {

            var s = "checkbox" + (i);

            $('#' + s).prop('checked', false);
        }
    }



}
function calculateSalery(id, isEpf) {
    var basic_salery = parseFloat($('#basic_salery' + id).val());
    var br = parseFloat($('#br' + id).val());
    $('#gross_salery' + id).html(basic_salery + br);
    var gross_salery = parseFloat($('#gross_salery' + id).html());
    var no_pay = parseFloat($('#no_pay' + id).val());
    $('#salary_for_epf' + id).html(gross_salery - no_pay);
    var salary_for_epf = parseFloat($('#salary_for_epf' + id).html()); //P7
    if (isEpf === '0') {
        console.log("isEpf 0");
        $('#epf_8' + id).html(0);
        $('#epf_12' + id).html(0);
        $('#etf_3' + id).html(0);
    } else {
        console.log("isEpf 1");
        $('#epf_8' + id).html((salary_for_epf * 8) / 100);
        $('#epf_12' + id).html((gross_salery * 12) / 100);
        $('#etf_3' + id).html((gross_salery * 3) / 100);
    }




    var epf_8 = parseFloat($('#epf_8' + id).html()); //Q7
    var attantance = parseFloat($('#attantance' + id).val()); //T7
    var porfoments = parseFloat($('#porfoments' + id).val()); //U7
    var insentive = parseFloat($('#insentive' + id).val()); //V7
    var traveling = parseFloat($('#traveling' + id).val()); //W7
    var house_rental = parseFloat($('#house_rental' + id).val()); //X7
    var salary_advance = parseFloat($('#salary_advance' + id).val()); //Y7
    var other_deductions = parseFloat($('#other_deductions' + id).val()); //Z7
    var tax = parseFloat($('#tax' + id).val()); //Z7

    var total = salary_for_epf - epf_8 + attantance + porfoments + insentive + traveling
            + house_rental - salary_advance - other_deductions-tax;
    $('#total' + id).html(total);
}

function savePaySheet(id) {
    if ($('#basic_salery' + id).val() !== "00.00") {

        var basic_salery = parseFloat($('#basic_salery' + id).val());
        var br = parseFloat($('#br' + id).val());
        var no_pay = parseFloat($('#no_pay' + id).val());
        var attantance = parseFloat($('#attantance' + id).val());
        var porfoments = parseFloat($('#porfoments' + id).val());
        var insentive = parseFloat($('#insentive' + id).val());
        var traveling = parseFloat($('#traveling' + id).val());
        var house_rental = parseFloat($('#house_rental' + id).val());
        var salary_advance = parseFloat($('#salary_advance' + id).val());
        var other_deductions = parseFloat($('#other_deductions' + id).val());
        var tax = parseFloat($('#tax' + id).val());
        

        var confirmmsg = confirm("Do you Want to Continue ?");
        if (confirmmsg) {
            $.post('../UniversalPayrollSaveSalarySheet', {
                pmId: id,
                basic_salery: basic_salery,
                br: br,
                no_pay: no_pay,
                attantance: attantance,
                porfoments: porfoments,
                insentive: insentive,
                traveling: traveling,
                house_rental: house_rental,
                salary_advance: salary_advance,
                other_deductions: other_deductions,
                tax: tax
            }, function (data) {
                alert(data.message);
                if (data.status === 200) {
                    $('.edit_input' + id + '[type="text"]').each(function () {
                        this.type = 'hidden';
                    });
                    $(".input_text" + id).removeClass("input_text_none");
                    $('#edit_btn' + id).css('display', 'block');
                    $('#save_btn' + id).css('display', 'none');

                    $('#basic_salery_text' + id).html(numeral($('#basic_salery'+id).val()).format('0,0.00'));
                    $('#br_text' + id).html(numeral($('#br'+id).val()).format('0,0.00'));
                    $('#no_pay_text' + id).html(numeral($('#no_pay'+id).val()).format('0,0.00'));
                    $('#attantance_text' + id).html(numeral($('#attantance'+id).val()).format('0,0.00'));
                    $('#porfoments_text' + id).html(numeral($('#porfoments'+id).val()).format('0,0.00'));
                    $('#insentive_text' + id).html(numeral($('#insentive'+id).val()).format('0,0.00'));
                    $('#traveling_text' + id).html(numeral($('#traveling'+id).val()).format('0,0.00'));
                    $('#house_rental_text' + id).html(numeral($('#house_rental'+id).val()).format('0,0.00'));
                    $('#salary_advance_text' + id).html(numeral($('#salary_advance'+id).val()).format('0,0.00'));
                    $('#other_deductions_text' + id).html(numeral($('#other_deductions'+id).val()).format('0,0.00'));
                    $('#gross_salery' + id).html(numeral($('#gross_salery'+id).html()).format('0,0.00'));
                    $('#salary_for_epf' + id).html(numeral($('#salary_for_epf'+id).html()).format('0,0.00'));
                    $('#total' + id).html(numeral($('#total'+id).html()).format('0,0.00'));
                    $('#epf_8' + id).html(numeral($('#epf_8'+id).html()).format('0,0.00'));
                    $('#epf_12' + id).html(numeral($('#epf_12'+id).html()).format('0,0.00'));
                    $('#etf_3' + id).html(numeral($('#etf_3'+id).html()).format('0,0.00'));
                    $('#tax' + id).html(numeral($('#tax'+id).html()).format('0,0.00'));
                }
            });
        }



    } else {
        alert("Please Emter Basic Salary Field");
    }

}