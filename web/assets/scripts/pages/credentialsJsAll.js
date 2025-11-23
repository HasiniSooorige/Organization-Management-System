/* global Swal */

function addNewCredential(userGUPID) {

    var credType = document.getElementById("credType").value;
    var credCategory = document.getElementById("credCategory").value;
    var credRole = document.getElementById("credRole").value;
    var credProject = document.getElementById("credProject").value;
    var credUsername = document.getElementById("credUsername").value;
    var credPassword = document.getElementById("credPassword").value;
    var credNote = document.getElementById("credNote").value;


    if (credType === "") {
        document.getElementById("credTypeErrNotify").removeAttribute("hidden");
        document.getElementById("credType").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credTypeErrNotify").setAttribute("hidden", "");
        document.getElementById("credType").style.borderColor = '';
    }
    if (credCategory === "") {
        document.getElementById("credCategoryErrNotify").removeAttribute("hidden");
        document.getElementById("credCategory").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credCategoryErrNotify").setAttribute("hidden", "");
        document.getElementById("credCategory").style.borderColor = '';
    }
    if (credRole === "") {
        document.getElementById("credRoleErrNotify").removeAttribute("hidden");
        document.getElementById("credRole").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credRoleErrNotify").setAttribute("hidden", "");
        document.getElementById("credRole").style.borderColor = '';
    }
    if (credProject === "") {
        document.getElementById("credProjectErrNotify").removeAttribute("hidden");
        document.getElementById("credProject").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credProjectErrNotify").setAttribute("hidden", "");
        document.getElementById("credProject").style.borderColor = '';
    }
    if (credUsername === "") {
        document.getElementById("credUsernameErrNotify").removeAttribute("hidden");
        document.getElementById("credUsername").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credUsernameErrNotify").setAttribute("hidden", "");
        document.getElementById("credUsername").style.borderColor = '';
    }
    if (credPassword === "") {
        document.getElementById("credPasswordErrNotify").removeAttribute("hidden");
        document.getElementById("credPassword").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credPasswordErrNotify").setAttribute("hidden", "");
        document.getElementById("credPassword").style.borderColor = '';
    }
    if (credNote === "") {
        document.getElementById("credNoteErrNotify").removeAttribute("hidden");
        document.getElementById("credNote").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credNoteErrNotify").setAttribute("hidden", "");
        document.getElementById("credNote").style.borderColor = '';
    }

    $('#addCredentialModal').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;
                const  output = JSON.parse(data);
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
                        icon: 'error',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }
            }
        }
    };

    request.open("POST", "../CreateUserCredential", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("credType=" + credType + "&credCategory=" + credCategory + "&credRole=" + credRole + "&credProject=" + credProject
            + "&credUsername=" + credUsername + "&credPassword=" + credPassword + "&credNote=" + credNote + "&userGUPID=" + userGUPID);
    return true;
}

function  viewCedentialData(idc) {

    console.log(idc);

    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {


        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.createddate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                document.getElementById("credentialType").setAttribute("value", obj.type);
                document.getElementById("credentialCategory").setAttribute("value", obj.category);
                document.getElementById("credentialRole").setAttribute("value", obj.roll);
                document.getElementById("credentialProject").setAttribute("value", obj.project);
                document.getElementById("credentialstatus").setAttribute("value", obj.status);
                document.getElementById("credentialUsername").setAttribute("value", obj.username);
                document.getElementById("credentiaLastEditBy").setAttribute("value", obj.employeename);
                document.getElementById("credentialCreateDate").setAttribute("value", today);
                var Description = document.getElementById("credentialNote");
                Description.value = obj.note;

                $("#viewCedentialData").modal('show');

            }
        }
    };
    request.open("POST", "../CredentialDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

}

function editCredentials(idc) {

    $("#editCredModel").modal('show');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                document.getElementById("credUsernameEdit").setAttribute("value", obj.username);

            }
        }
    };
    request.open("POST", "../CredentialDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

}

function filter_function() {
    $('table tbody tr').hide();

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
    $('table tr').each(function () {

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
            $(this).show();  //displaying row which satisfies all conditions
        }

    });
}

function credActiveInactive(credId, statusId) {

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

function credDeactivationClose() {
    $("#credActiveInactiveModel").modal('hide');
}

var cred_Id;
var credStatus_Id;
function credActionSave() {

    cred_Id = document.getElementById("deactiveCredId").value;
    credStatus_Id = document.getElementById("deactiveStatusId").value;

    $("#credActiveInactiveModel").modal('hide');
    $("#editCredModel").modal('show');
}

function Credential_edit(EditorId) {

    var credId = cred_Id;
    var credStatusId = credStatus_Id;
    var credUsername = $('#credUsernameEdit').val();
    var password = $('#passwordEdit').val();
    var note = $('#credNoteEdit').val();

    if (credUsername === "") {
        document.getElementById("credUsernameEditErrNotify").removeAttribute("hidden");
        document.getElementById("credUsernameEdit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credUsernameEditErrNotify").setAttribute("hidden", "");
        document.getElementById("credUsernameEdit").style.borderColor = '';
    }
    if (password === "") {
        document.getElementById("credPasswordEditErrNotify").removeAttribute("hidden");
        document.getElementById("passwordEdit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credPasswordEditErrNotify").setAttribute("hidden", "");
        document.getElementById("passwordEdit").style.borderColor = '';
    }
    if (note === "") {
        document.getElementById("credReasonErrNotify").removeAttribute("hidden");
        document.getElementById("credNoteEdit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("credReasonErrNotify").setAttribute("hidden", "");
        document.getElementById("credNoteEdit").style.borderColor = '';
    }

    $('#editCredModel').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();

    $.post('.././CredentialStatusUpdate', {
        id: credId,
        status: credStatusId,
        username: credUsername,
        password: password,
        note: note,
        emp: EditorId

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

function searchAllCredential() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('tableempbody').getElementsByTagName('tr');


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

function loadAllCredentialRow() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("tableempbody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("allCredentialDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("allCredentialHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}
