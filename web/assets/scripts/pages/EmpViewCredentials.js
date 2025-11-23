function  viewCedentialEmployeeAccessData(idc) {

    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {


        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                const obj = JSON.parse(str);

                if (obj === 1) {
                    // viewed // requested // request pending
                    document.getElementById("first_time_request").style.display = "none";
                    document.getElementById("next_time_request").style.display = "";
                    document.getElementById("requestPending").style.display = "";
                    document.getElementById("requestbtndiv").style.display = "none";
                    document.getElementById("requestDenied").style.display = "none";
                    document.getElementById("forcredentialId").setAttribute("value", idc);
                    $("#viewCedentialEmployeeAccessData").modal('show');

                } else if (obj === 0) {
                    // viewed // requested // request denied
                    document.getElementById("first_time_request").style.display = "none";
                    document.getElementById("next_time_request").style.display = "";
                    document.getElementById("requestPending").style.display = "none";
                    document.getElementById("requestDenied").style.display = "";
                    document.getElementById("requestbtndiv").style.display = "none";
                    document.getElementById("forcredentialId").setAttribute("value", idc);
                    $("#viewCedentialEmployeeAccessData").modal('show');
                    
                } else if (obj === null) {
                    // viewed // not requested
                    document.getElementById("first_time_request").style.display = "none";
                    document.getElementById("next_time_request").style.display = "";
                    document.getElementById("requestPending").style.display = "none";
                    document.getElementById("requestDenied").style.display = "none";
                    document.getElementById("requestbtndiv").style.display = "";
                    document.getElementById("forcredentialId").setAttribute("value", idc);
                    $("#viewCedentialEmployeeAccessData").modal('show');
                } else {
                    //not viewed
                    document.getElementById("first_time_request").style.display = "";
                    document.getElementById("next_time_request").style.display = "none";

                    var d = new Date(obj.assigndate);
                    let dateL = d.toISOString();
                    var now = new Date(dateL);
                    var day = ("0" + now.getDate()).slice(-2);
                    var month = ("0" + (now.getMonth() + 1)).slice(-2);
                    var today = now.getFullYear() + "-" + (month) + "-" + (day);

                    document.getElementById("typeSpanEmp").setAttribute("value", obj.type);
                    document.getElementById("roleSpanEmp").setAttribute("value", obj.roll);
                    document.getElementById("catSpanEmp").setAttribute("value", obj.category);
                    document.getElementById("createDateSpanEmp").setAttribute("value", today);
                    document.getElementById("projectSpanEmp").setAttribute("value", obj.project);
                    document.getElementById("usernameSpanEmp").setAttribute("value", obj.username);
                    document.getElementById("passwordSpanEmp").setAttribute("value", obj.password);
                    document.getElementById("noteSpanEmp").setAttribute("value", obj.note);

                    $("#viewCedentialEmployeeAccessData").modal('show');
                    update_view_Credential(idc);
                }
            }
        }
    };
    request.open("POST", "../CredentialEmployeeDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);
}


function update_view_Credential(id) {

    $.post('.././EditEmployeeCredentialView', {
        id: id
    }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
            location.reload();
        } else {
            alert("Error");
            location.reload();
        }

    });
}


function requestEmpAccessCredential() {

    var empAcessId = document.getElementById("forcredentialId").value;

    $('#viewCedentialEmployeeAccessData').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                var data = request.response;
                var output = JSON.parse(data);
                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    }).then(function () {
                        location.reload();
                    });
                }
                if (output.status === 400) {

                    Swal.fire({
                        title: output.message,
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }
            }
        }
    };

    request.open("POST", "../CreateUserCredentiaLViewRequest", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("empAcessId=" + empAcessId);

    return true;
}

function searchEmpViewCredTable() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('empViewCredBody').getElementsByTagName('tr');


    for (var i = 0; i < rows.length; i++) {

        var cells = rows[i].getElementsByTagName('td');


        for (var j = 0; j < cells.length; j++) {
            var cell = cells[j];


            if (cell) {
                var textValue = cell.textContent || cell.innerText;
                if (textValue.toUpperCase().indexOf(filter) > -1) {
                    rows[i].style.display = '';
                    break;
                } else {
                    rows[i].style.display = 'none';
                }
            }
        }
    }
}

function loadEmpViewCredRows() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("empViewCredBody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("empViewCredTableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("empViewCredHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("empViewCredBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}