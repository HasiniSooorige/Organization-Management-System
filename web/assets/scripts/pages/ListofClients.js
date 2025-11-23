/* global Swal */
function validate_nic(nic) {
    var cnic_no_regex = new RegExp('^[0-9+]{9}[vV|xX]$');
    var new_cnic_no_regex = new RegExp('^[0-9+]{12}$');
    if (nic.length == 10) {
        return true;
    } else if (nic.length == 12 && new_cnic_no_regex.test(nic)) {
        return true;
    } else {
        return false;
    }

}

function validate_phone(phone) {
    var phone_no_regex = new RegExp('^[0-9]+$');
    if (phone.length == 10 && phone_no_regex.test(phone)) {
        return true;
    } else {
        return false;
    }

}

function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    if (re.test(email)) {
        return true;
    } else {
        return false;
    }
}

function viewClientDetails(id) {
    $("#viewClientData").modal('show');

    console.log(id);

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.createdDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#viewCliCreateDate').val(today);

                document.getElementById("viewCliName").setAttribute("value", obj.name);
                document.getElementById("viewCliAdd1").setAttribute("value", obj.address1);
                document.getElementById("viewCliAdd2").setAttribute("value", obj.address2);
                document.getElementById("viewCliAdd3").setAttribute("value", obj.address3);
                document.getElementById("CliEmail").setAttribute("value", obj.email);
                document.getElementById("viewCliContact").setAttribute("value", obj.contactNo);
                document.getElementById("viewCliFaxNo").setAttribute("value", obj.faxNo);
                document.getElementById("viewCliCountry").setAttribute("value", obj.country);

                var imageName = obj.logo;
                console.log(imageName);

                viewClientLogo(imageName);
            }
        }
    };
    request.open("POST", "../ClientDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

    viewClientTeamList(id);
    viewProjectListbyClient(id);
}

function viewClientTeamList(id) {

    console.log("Client Team List :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var clientTeamDiv = document.getElementById("clientTeamDiv");
                var clientTeamDivEmpty = document.getElementById("clientTeamDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    clientTeamDiv.style.display = 'none';
                    clientTeamDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    clientTeamDiv.style.display = 'block';
                    clientTeamDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("ClientTeamTableBodyView");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var client_employee = data[i];

                    console.log(client_employee);

                    var cli_emp_name = client_employee.gupFirstName + " " + client_employee.gupLastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = cli_emp_name;
                    tr.appendChild(tdName);

                    var tdNIC = document.createElement("td");
                    tdNIC.textContent = client_employee.gupNic;
                    tr.appendChild(tdNIC);

                    var tdEmail = document.createElement("td");
                    tdEmail.textContent = client_employee.gupEmail;
                    tr.appendChild(tdEmail);

                    var tdMobileNo = document.createElement("td");
                    tdMobileNo.textContent = client_employee.gupMobileNo;
                    tr.appendChild(tdMobileNo);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ClientTeamListView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function viewProjectListbyClient(id) {

    console.log("Project List by Client :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var projectListDiv = document.getElementById("projectListDiv");
                var projectListDivEmpty = document.getElementById("projectListDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    projectListDiv.style.display = 'none';
                    projectListDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    projectListDiv.style.display = 'block';
                    projectListDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("ClientProListTableBodyView");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var projectList = data[i];

                    console.log(projectList);

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = projectList.proName;
                    tr.appendChild(tdName);

                    var tdStatus = document.createElement("td");
                    tdStatus.textContent = projectList.proStatus;
                    tr.appendChild(tdStatus);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectListbyClientView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function viewClientLogo(image) {
    var imagename = image;
    var imageUrl = "../ViewClientLogo?imageName=" + imagename;

    var img = document.getElementById("imgClient");
    img.src = imageUrl;
    img.height = 250;
    img.width = 250;

    var imageContainer = document.getElementById("clientLogoView");
    imageContainer.appendChild(img);
    img.style.display = 'block';
}

function addClientEmployee(id) {
    $("#addNewClientEmployee").modal('show');

    document.getElementById("clientId").setAttribute("value", id);
}

function editClientDetails(id) {

    $("#editClient").modal('show');

    document.getElementById("editClientId").setAttribute("value", id);

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.createdDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#editCliCreateDate').val(today);

                document.getElementById("editCliName").setAttribute("value", obj.name);
                document.getElementById("editCliAdd1").setAttribute("value", obj.address1);
                document.getElementById("editCliAdd2").setAttribute("value", obj.address2);
                document.getElementById("editCliAdd3").setAttribute("value", obj.address3);
                document.getElementById("editCliEmail").setAttribute("value", obj.email);
                document.getElementById("editCliContact").setAttribute("value", obj.contactNo);
                document.getElementById("editCliFaxNo").setAttribute("value", obj.faxNo);
                document.getElementById("editCliCountry").setAttribute("value", obj.country);

            }
        }
    };
    request.open("POST", "../ClientDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);
}

function clientTeamDetails(id) {
    $("#clientEmpDetails").modal('show');

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var clientEmployeeListDiv = document.getElementById("clientEmployeeListDiv");
                var clientEmployeeListDivEmpty = document.getElementById("clientEmployeeListDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    clientEmployeeListDiv.style.display = 'none';
                    clientEmployeeListDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    clientEmployeeListDiv.style.display = 'block';
                    clientEmployeeListDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("ClientTeamEmpTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var client_employee = data[i];

                    console.log(client_employee);

                    var cli_emp_name = client_employee.gupFirstName + " " + client_employee.gupLastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = cli_emp_name;
                    tr.appendChild(tdName);

                    var tdNIC = document.createElement("td");
                    tdNIC.textContent = client_employee.gupNic;
                    tr.appendChild(tdNIC);

                    var tdEmail = document.createElement("td");
                    tdEmail.textContent = client_employee.gupEmail;
                    tr.appendChild(tdEmail);

                    var tdMobileNo = document.createElement("td");
                    tdMobileNo.textContent = client_employee.gupMobileNo;
                    tr.appendChild(tdMobileNo);

                    if (client_employee.gupGopStatus === true) {
                        var tdStatus = document.createElement("td");
                        var badgeActive = document.createElement("span");
                        badgeActive.textContent = "Active";
                        badgeActive.classList.add("badge", "bg-label-success", "me-1");
                        tdStatus.style.alignItems = "center";
                        tdStatus.appendChild(badgeActive);
                        tr.appendChild(tdStatus);

                        var tdEmpRemoveButton = document.createElement("td");
                        tdEmpRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-danger" style="width: 100px;" onclick="activeClientEmployee('${id}', '${client_employee.gupId}' , '${client_employee.gupGopStatus}');">Remove</button>`;
                        tr.appendChild(tdEmpRemoveButton);
                    } else {
                        var tdStatus = document.createElement("td");
                        var badgeActive = document.createElement("span");
                        badgeActive.textContent = "Inactive";
                        badgeActive.classList.add("badge", "bg-label-danger", "me-1");
                        tdStatus.style.alignItems = "center";
                        tdStatus.appendChild(badgeActive);
                        tr.appendChild(tdStatus);

                        var tdEmpRemoveButton = document.createElement("td");
                        tdEmpRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-success" style="width: 100px;" onclick="activeClientEmployee('${id}', '${client_employee.gupId}' , '${client_employee.gupGopStatus}');">Add</button>`;
                        tr.appendChild(tdEmpRemoveButton);
                    }

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ClientTeamListStatus", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);
}

function activeClientEmployee(OrgId, EmpId, ActiveStatus) {

    $("#clientEmpDetails").modal('hide');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;

                console.log(data);

                const  output = JSON.parse(data);


                console.log(output);

                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
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
    request.open("POST", "../ClientTeamListStatusUpdate", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("OrgId=" + OrgId + "&EmpId=" + EmpId + "&ActiveStatus=" + ActiveStatus);

    return true;
}

function addNewRowNewClient() {

    var clientId = $('#clientId').val();
    var clientFirstName = $('#clientFirstName').val();
    var clientLastName = $('#clientLastName').val();
    var clientNic = $('#clientNic').val();
    var clientemail = $('#clientemail').val();
    var companycontactNo = $('#companycontactNo').val();
    var clientMobileNo = $('#clientMobileNo').val();

    if (clientFirstName === "") {
        document.getElementById("clientFirstNameError").removeAttribute("hidden");
        document.getElementById("clientFirstName").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientFirstNameError").setAttribute("hidden", "");
        document.getElementById("clientFirstName").style.borderColor = '';
    }
    if (clientLastName === "") {
        document.getElementById("clientLastNameError").removeAttribute("hidden");
        document.getElementById("clientLastName").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientLastNameError").setAttribute("hidden", "");
        document.getElementById("clientLastName").style.borderColor = '';
    }
    if (clientNic === "") {
        document.getElementById("clientNicError").removeAttribute("hidden");
        document.getElementById("clientNic").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientNicError").setAttribute("hidden", "");
        document.getElementById("clientNic").style.borderColor = '';
    }
    if (!validate_nic(clientNic)) {
        document.getElementById("clientNicinvalidError").removeAttribute("hidden");
        document.getElementById("clientNic").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientNicinvalidError").setAttribute("hidden", "");
        document.getElementById("clientNic").style.borderColor = '';
    }
    if (clientemail === "") {
        document.getElementById("clientemailError").removeAttribute("hidden");
        document.getElementById("clientemail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientemailError").setAttribute("hidden", "");
        document.getElementById("clientemail").style.borderColor = '';
    }
    if (!validateEmail(clientemail)) {
        document.getElementById("clientemailInvalidError").removeAttribute("hidden");
        document.getElementById("clientemail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientemailInvalidError").setAttribute("hidden", "");
        document.getElementById("clientemail").style.borderColor = '';
    }
    if (companycontactNo === "") {
        document.getElementById("companycontactNoError").removeAttribute("hidden");
        document.getElementById("companycontactNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("companycontactNoError").setAttribute("hidden", "");
        document.getElementById("companycontactNo").style.borderColor = '';
    }
    if (!validate_phone(companycontactNo)) {
        document.getElementById("companycontactNoinValidError").removeAttribute("hidden");
        document.getElementById("companycontactNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("companycontactNoinValidError").setAttribute("hidden", "");
        document.getElementById("companycontactNo").style.borderColor = '';
    }
    if (clientMobileNo === "") {
        document.getElementById("clientMobileNoErrr").removeAttribute("hidden");
        document.getElementById("clientMobileNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientMobileNoErrr").setAttribute("hidden", "");
        document.getElementById("clientMobileNo").style.borderColor = '';
    }
    if (!validate_phone(clientMobileNo)) {
        document.getElementById("clientMobileNoinValidErrr").removeAttribute("hidden");
        document.getElementById("clientMobileNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientMobileNoinValidErrr").setAttribute("hidden", "");
        document.getElementById("clientMobileNo").style.borderColor = '';
    }

    $("#addNewClientEmployee").modal('hide');
    var clientIdClear = $('#clientId').val('');
    var clientFirstNameClear = $('#clientFirstName').val('');
    var clientLastNameClear = $('#clientLastName').val('');
    var clientNicClear = $('#clientNic').val('');
    var clientemailClear = $('#clientemail').val('');
    var companycontactNoClear = $('#companycontactNo').val('');
    var clientMobileNoClear = $('#clientMobileNo').val('');


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
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }
            }
        }
    };
    request.open("POST", "../CreateNewClient", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("clientId=" + clientId + "&clientFirstName=" + clientFirstName + "&clientLastName=" + clientLastName + "&clientNic=" + clientNic + "&clientemail=" + clientemail + "&companycontactNo=" + companycontactNo + "&clientMobileNo=" + clientMobileNo);
    return true;

}

function closeAddNewClient() {
    $("#addNewClientEmployee").modal('hide');
}

function closeEditClient() {
    $("#editClient").modal('hide');
}

function editClientData() {

    var editClientId = $('#editClientId').val();
    var editCliAdd1 = $('#editCliAdd1').val();
    var editCliAdd2 = $('#editCliAdd2').val();
    var editCliAdd3 = $('#editCliAdd3').val();
    var editCliEmail = $('#editCliEmail').val();
    var editCliContact = $('#editCliContact').val();
    var editCliFaxNo = $('#editCliFaxNo').val();

    if (editCliAdd1 === "") {
        document.getElementById("EditAddress1Error").removeAttribute("hidden");
        document.getElementById("editCliAdd1").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("EditAddress1Error").setAttribute("hidden", "");
        document.getElementById("editCliAdd1").style.borderColor = '';
    }
    if (editCliAdd2 === "") {
        document.getElementById("EditAddress2Error").removeAttribute("hidden");
        document.getElementById("editCliAdd2").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("EditAddress2Error").setAttribute("hidden", "");
        document.getElementById("editCliAdd2").style.borderColor = '';
    }
    if (editCliAdd3 === "") {
        document.getElementById("editAddress3Error").removeAttribute("hidden");
        document.getElementById("editCliAdd3").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editAddress3Error").setAttribute("hidden", "");
        document.getElementById("editCliAdd3").style.borderColor = '';
    }
    if (editCliEmail === "") {
        document.getElementById("editEmailError").removeAttribute("hidden");
        document.getElementById("editCliEmail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editEmailError").setAttribute("hidden", "");
        document.getElementById("editCliEmail").style.borderColor = '';
    }
    if (!validateEmail(editCliEmail)) {
        document.getElementById("editEmailinvalidError").removeAttribute("hidden");
        document.getElementById("editCliEmail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editEmailinvalidError").setAttribute("hidden", "");
        document.getElementById("editCliEmail").style.borderColor = '';
    }
    if (editCliContact === "") {
        document.getElementById("editContactError").removeAttribute("hidden");
        document.getElementById("editCliContact").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editContactError").setAttribute("hidden", "");
        document.getElementById("editCliContact").style.borderColor = '';
    }
    if (!validate_phone(editCliContact)) {
        document.getElementById("editcontactInvalidError").removeAttribute("hidden");
        document.getElementById("editCliContact").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editcontactInvalidError").setAttribute("hidden", "");
        document.getElementById("editCliContact").style.borderColor = '';
    }
    if (editCliFaxNo === "") {
        document.getElementById("editFaxError").removeAttribute("hidden");
        document.getElementById("editCliFaxNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editFaxError").setAttribute("hidden", "");
        document.getElementById("editCliFaxNo").style.borderColor = '';
    }
    if (!validate_phone(editCliFaxNo)) {
        document.getElementById("editFaxInvalidError").removeAttribute("hidden");
        document.getElementById("editCliFaxNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editFaxInvalidError").setAttribute("hidden", "");
        document.getElementById("editCliFaxNo").style.borderColor = '';
    }

    $("#editClient").modal('hide');

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
                        allowEscapeKey: true,
                        closeOnConfirm: false,
                        timer: 1000
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
    request.open("POST", "../EditClientDetails", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("editClientId=" + editClientId + "&editCliAdd1=" + editCliAdd1 + "&editCliAdd2=" + editCliAdd2 + "&editCliAdd3=" + editCliAdd3 + "&editCliEmail=" + editCliEmail + "&editCliContact=" + editCliContact + "&editCliFaxNo=" + editCliFaxNo);
}

function searchClientTable() {

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

function loadAllClientRows() {

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

    var tableDiv = document.getElementById("clientTableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("clientHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}