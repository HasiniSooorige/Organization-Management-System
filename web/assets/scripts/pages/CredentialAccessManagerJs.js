function filterCreateModel() {
    $('.tabletrSecond').hide(); //hide all rows

    var companyFlag = 0;
    var companyValue = $('#filter-company').val();
    var contactFlag = 0;
    var contactValue = $('#filter-contact').val();
    var rangeFlag = 0;
    var rangeValue = $('#filter-range').val();

    //setting intial values and flags needed
    if (companyValue == 0 && contactValue == 0 && rangeValue == 0) {
        document.getElementById("filterEmptyErrNotify").removeAttribute("hidden");
        document.getElementById("filter-company").style.borderColor = 'red';
        document.getElementById("filter-contact").style.borderColor = 'red';
        document.getElementById("filter-range").style.borderColor = 'red';

    } else {
        document.getElementById("filterEmptyErrNotify").setAttribute("hidden", "");
        document.getElementById("filter-company").style.borderColor = '';
        document.getElementById("filter-contact").style.borderColor = '';
        document.getElementById("filter-range").style.borderColor = '';
    }

    //traversing each row one by one
    $('.tabletrSecond').each(function () {

        if (companyValue == 0) {   //if no value then display row
            companyFlag = 1;
        } else if (companyValue == $(this).find('td.company').data('company')) {
            companyFlag = 1;       //if value is same display row
        } else {
            companyFlag = 0;
        }

        if (contactValue == 0) {
            contactFlag = 1;
        } else if (contactValue == $(this).find('td.contact').data('contact')) {
            contactFlag = 1;
        } else {
            contactFlag = 0;
        }

        if (rangeValue == 0) {
            rangeFlag = 1;
        } else if (rangeValue == $(this).find('td.range').data('range')) {
            rangeFlag = 1;
        } else {
            rangeFlag = 0;
        }


        if (companyFlag && contactFlag && rangeFlag) {
            $(this).show();
        }

    });
}

function filter_functionsec() {
    $('.tabletr').hide(); //hide all rows

    var companyFlagsec = 0;
    var companyValuesec = $('#filter-type').val();
    var contactFlagsec = 0;
    var contactValuesec = $('#filter-cat').val();
    var rangeFlagsec = 0;
    var rangeValuesec = $('#filter-pro').val();

    //setting intial values and flags needed
    if (companyValuesec == 0 && contactValuesec == 0 && rangeValuesec == 0) {
        document.getElementById("filterEmptydashbordErrNotify").removeAttribute("hidden");
        document.getElementById("filter-type").style.borderColor = 'red';
        document.getElementById("filter-cat").style.borderColor = 'red';
        document.getElementById("filter-pro").style.borderColor = 'red';

    } else {
        document.getElementById("filterEmptydashbordErrNotify").setAttribute("hidden", "");
        document.getElementById("filter-type").style.borderColor = '';
        document.getElementById("filter-cat").style.borderColor = '';
        document.getElementById("filter-pro").style.borderColor = '';
    }

    //traversing each row one by one
    $('.tabletr').each(function () {

        if (companyValuesec == 0) {   //if no value then display row
            companyFlagsec = 1;
        } else if (companyValuesec == $(this).find('td.type').data('type')) {
            companyFlagsec = 1;       //if value is same display row
        } else {
            companyFlagsec = 0;
        }

        if (contactValuesec == 0) {
            contactFlagsec = 1;
        } else if (contactValuesec == $(this).find('td.cat').data('cat')) {
            contactFlagsec = 1;
        } else {
            contactFlagsec = 0;
        }

        if (rangeValuesec == 0) {
            rangeFlagsec = 1;
        } else if (rangeValuesec == $(this).find('td.pro').data('pro')) {
            rangeFlagsec = 1;
        } else {
            rangeFlagsec = 0;
        }

        if (companyFlagsec && contactFlagsec && rangeFlagsec) {
            $(this).show();  //displaying row which satisfies all conditions
        }

    });

}

function  viewCedentialAccessData(idc) {

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                const obj = JSON.parse(str);
                
                var dateObj = new Date(obj.assigndate);
                var year = dateObj.getFullYear();
                var month = ("0" + (dateObj.getMonth() + 1)).slice(-2);
                var day = ("0" + dateObj.getDate()).slice(-2);
                var hours = ("0" + dateObj.getHours()).slice(-2);
                var minutes = ("0" + dateObj.getMinutes()).slice(-2);
                var seconds = ("0" + dateObj.getSeconds()).slice(-2);
                var assingDate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
                
                var dateObj2 = new Date(obj.lastchangeddate);
                var year2 = dateObj2.getFullYear();
                var month2 = ("0" + (dateObj2.getMonth() + 1)).slice(-2);
                var day2 = ("0" + dateObj2.getDate()).slice(-2);
                var hours2 = ("0" + dateObj2.getHours()).slice(-2);
                var minutes2 = ("0" + dateObj2.getMinutes()).slice(-2);
                var seconds2 = ("0" + dateObj2.getSeconds()).slice(-2);
                var lastCDate = year2 + "-" + month2 + "-" + day2 + " " + hours2 + ":" + minutes2 + ":" + seconds2;

                document.getElementById("projectSpanAc").setAttribute("value", obj.project);
                document.getElementById("employeeSpanAc").setAttribute("value", obj.employeename);
                document.getElementById("roleSpanAc").setAttribute("value", obj.roll);
                document.getElementById("lastDateSpanAc").setAttribute("value", lastCDate);
                document.getElementById("statusSpanAc").setAttribute("value", obj.status);
                document.getElementById("empStatusSpanAc").setAttribute("value", obj.assigned);
                document.getElementById("credCatSpanAc").setAttribute("value", obj.category);
                document.getElementById("typeSpanAc").setAttribute("value", obj.type);
                document.getElementById("assignedSpanAc").setAttribute("value", assingDate);
                document.getElementById("viewedSpanAc").setAttribute("value", obj.viewed);

                $("#viewCredAccessModel").modal('show');
            }
        }
    };
    request.open("POST", "../CredentialDataAccessView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);



}

function giveCredentialsAccess(userId) {

    var empAcessiD = document.getElementById("empAcessiD").value;

    if (empAcessiD === "") {
        document.getElementById("credselectEmpErrorNotify").removeAttribute("hidden");
        document.getElementById("empAcessiD").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credselectEmpErrorNotify").setAttribute("hidden", "");
        document.getElementById("empAcessiD").style.borderColor = '';
    }

    var checkedValues = [];
    var checkboxes = document.querySelectorAll('input[type=checkbox]:checked');

    for (var i = 0; i < checkboxes.length; i++) {
        checkedValues.push(checkboxes[i].value);
    }

    if (checkedValues.length === 1 && checkedValues[0] === 'All') {
        document.getElementById("arrayEmptyErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("arrayEmptyErrNotify").setAttribute("hidden", "");
    }

    $('#addCredentialModal').modal('hide');
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

    request.open("POST", "../CreateUserCredentialAccess", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + checkedValues + "&accessemp=" + userId + "&emp=" + empAcessiD);

    return true;

}

function credAccessActiveInactive(credId, statusId) {

    $("#credActiveInactiveModel").modal('show');

    document.getElementById("deactiveCredId").setAttribute("value", credId);
    document.getElementById("deactiveStatusId").setAttribute("value", statusId);

    if (statusId == 1) {
        $('#deactivateMsg').css('display', 'block');
        $('#activateMsg').css('display', 'none');

        $('#deactivateTitle').css('display', 'block');
        $('#activateTitle').css('display', 'none');
    } else if (statusId == 0) {
        $('#deactivateMsg').css('display', 'none');
        $('#activateMsg').css('display', 'block');

        $('#deactivateTitle').css('display', 'none');
        $('#activateTitle').css('display', 'block');
    }

}

function credAccessDeactivationClose() {
    $("#credActiveInactiveModel").modal('hide');
}

var credAccessId;
var credAccessStatusId;

function credAccessActionSave() {

    credAccessId = document.getElementById("deactiveCredId").value;
    credAccessStatusId = document.getElementById("deactiveStatusId").value;

    $("#credActiveInactiveModel").modal('hide');
    $("#editCredAfterInactiveModel").modal('show');

}

function credAccessEdit(empGUPid) {


    var credAccess_Id = credAccessId;
    var credAccessStatus_Id = credAccessStatusId;

    var credUsername = $('#credUsernameEditIn').val();
    var password = $('#passwordEditIn').val();
    var reason = $('#credNoteEditIn').val();

    if (credUsername === "") {
        document.getElementById("credUsernameEditErrNotify").removeAttribute("hidden");
        document.getElementById("credUsernameEditIn").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credUsernameEditErrNotify").setAttribute("hidden", "");
        document.getElementById("credUsernameEditIn").style.borderColor = '';
    }
    if (password === "") {
        document.getElementById("credPasswordEditErrNotify").removeAttribute("hidden");
        document.getElementById("passwordEditIn").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credPasswordEditErrNotify").setAttribute("hidden", "");
        document.getElementById("passwordEditIn").style.borderColor = '';
    }
    if (reason === "") {
        document.getElementById("credReasonErrNotify").removeAttribute("hidden");
        document.getElementById("credNoteEditIn").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credReasonErrNotify").setAttribute("hidden", "");
        document.getElementById("credNoteEditIn").style.borderColor = '';
    }

    $('#editCredAfterInactiveModel').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();

    $.post('.././CredentialAccessStatusUpdate', {

        id: credAccess_Id,
        status: credAccessStatus_Id,
        username: credUsername,
        password: password,
        reason: reason,
        emp: empGUPid

    }, function (data) {

        const value = JSON.parse(data);
        if (value.status === 200) {
            Swal.fire({
                title: value.message,
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            }).then(function () {
                location.reload();
            });
        } else if (value.status === 300) {
            Swal.fire({
                title: value.message,
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            }).then(function () {
                location.reload();
            });
        } else if (value.status === 400) {
            Swal.fire({
                title: value.message,
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            });
        }
    });
}

function searchCredAccessMan() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('credAccessManBody').getElementsByTagName('tr');


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

function loadCedAccessManRows() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("credAccessManBody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("credAccessManTableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("credAccessManHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("credAccessManBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}