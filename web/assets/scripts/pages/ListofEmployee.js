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

function getEmpFilter() {
    const allCheckbox = document.getElementById('all');
    const currentCheckbox = document.getElementById('currentemployee');
    const resignCheckbox = document.getElementById('resignemployee');
    const rows = document.querySelectorAll('#table_allusers tbody tr');


    rows.forEach((row) => {
        const isActive = row.getAttribute('data-isactive');
        if (allCheckbox.checked || (currentCheckbox.checked && isActive === '1') || (resignCheckbox.checked && isActive === '0')) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });

    var tableFooter = document.getElementById("emptableFootTr");
    tableFooter.style.display = "none";

    var tableDiv = document.getElementById("empTableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("empTableHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tablebody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function viewRowData(value) {

    $("#largeModal").modal('show')

    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                const obj = JSON.parse(str);
                console.log(obj);

                var d = new Date(obj.registereddate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                $('#regisered1').val(today);

                var dob = new Date(obj.dateofbirth);
                let dateDob = dob.toISOString();
                var nowDob = new Date(dateDob);
                var dayDob = ("0" + nowDob.getDate()).slice(-2);
                var monthDob = ("0" + (nowDob.getMonth() + 1)).slice(-2);
                var todayDob = nowDob.getFullYear() + "-" + (monthDob) + "-" + (dayDob);
                $('#dateofbirth').val(todayDob);


                if (obj.epfno === "") {
                    $('#epfNoLable').css('display', 'none');
                    $('#epfNoDiv').css('display', 'none');
                } else {
                    $('#epfNoLable').css('display', 'block');
                    $('#epfNoDiv').css('display', 'block');
                }
                document.getElementById("epf_no1").setAttribute("value", obj.epfno);
                document.getElementById("organization_by1").setAttribute("value", obj.generalorganizationname);
                document.getElementById("designation1").setAttribute("value", obj.designation);
                document.getElementById("nic1").setAttribute("value", obj.nic);
                document.getElementById("first_name1").setAttribute("value", obj.firstname);
                document.getElementById("last_name1").setAttribute("value", obj.lastname);
                document.getElementById("email1").setAttribute("value", obj.email);
                document.getElementById("mobile_no1").setAttribute("value", obj.mobileno);
                document.getElementById("emergency_contact").setAttribute("value", obj.emergencyContactNo);
                document.getElementById("address11").setAttribute("value", obj.address1);
                document.getElementById("address21").setAttribute("value", obj.address2);
                document.getElementById("address31").setAttribute("value", obj.address3);
                document.getElementById("home_no1").setAttribute("value", obj.homeno);
                document.getElementById("country_id1").setAttribute("value", obj.coutry);
                document.getElementById("gender1").setAttribute("value", obj.gender);
            }
        }
    };
    request.open("POST", "../EmployeeDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + value);
}

function empActiveInactiveStatus(gupId, statusId) {

    $("#EmpActivationModel").modal('show');

    document.getElementById("deactiveGupId").setAttribute("value", gupId);
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

function DeactivationClose() {
    $("#EmpActivationModel").modal('hide');
}

function empResignStatus() {
    $("#EmpResignStatusModel").modal('show');
}

function ResignStatusClose() {
    $("#EmpResignStatusModel").modal('hide');
}

function DeactivationSave() {

    var empGupId = document.getElementById("deactiveGupId").value;
    var empStatusId = document.getElementById("deactiveStatusId").value;

    $.post('.././UpdateActiveStatus', {
        status: empStatusId,
        gupid: empGupId

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
        }
    });

    $("#EmpActivationModel").modal('hide');
}

function UploadRowData(value) {

    $("#EmpDocUploadModel").modal('show');

    document.getElementById("empId").setAttribute("value", value);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____g");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("empDocumentTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var empDocument = data[i];

                    console.log(empDocument);

                    var tr = document.createElement("tr");

                    var tdDocType = document.createElement("td");
                    tdDocType.textContent = empDocument.documenttypename;
                    tr.appendChild(tdDocType);

                    var tdDocName = document.createElement("td");
                    tdDocName.textContent = empDocument.name;
                    tr.appendChild(tdDocName);

                    var tdDocument = document.createElement("td");
                    tdDocument.textContent = empDocument.url;
                    tr.appendChild(tdDocument);

                    var tdView = document.createElement("td");
                    tdView.innerHTML = `<button class="btn rounded-pill btn-outline-info" onclick="openDocument('${empDocument.url}');">View</button>`;
                    tr.appendChild(tdView);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../EmployeeDocumentHistoryView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + value);


}

function openDocument(documentName) {

    const fileName = documentName;
    console.log(fileName);

    var servletURL = '../EmployeeDocumentOpen';
    var fullURL = servletURL + '?fileName=' + fileName;

    var xhr = new XMLHttpRequest();
    xhr.open('GET', fullURL, true);

    xhr.responseType = 'blob';

    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var blob = xhr.response;
            var fileURL = window.URL.createObjectURL(blob);

            if (fileName.endsWith('.pdf') || fileName.endsWith('.doc') || fileName.endsWith('.docx')) {
                window.open(fileURL, '_blank');
            } else if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg') || fileName.endsWith('.png')) {
                var img = new Image();
                img.src = fileURL;
                var newWindow = window.open('', '_blank');
                newWindow.document.body.appendChild(img);
            }
        }
    };

    xhr.send();

}

function editRowData(value) {

    $("#EmpEditModel").modal('show');

    var gupId = value;
    edit_data_load(gupId);
}

function edit_data_load(gupId) {
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.registereddate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                $('#regisered').val(today);

                var dob = new Date(obj.dateofbirth);
                let dateDob = dob.toISOString();
                var nowDob = new Date(dateDob);
                var dayDob = ("0" + nowDob.getDate()).slice(-2);
                var monthDob = ("0" + (nowDob.getMonth() + 1)).slice(-2);
                var todayDob = nowDob.getFullYear() + "-" + (monthDob) + "-" + (dayDob);
                $('#dobEdit').val(todayDob);

                if (obj.epfno === "") {
                    $('#editEpfNoLable').css('display', 'none');
                    $('#EditEpfNo').css('display', 'none');
                } else {
                    $('#editEpfNoLable').css('display', 'block');
                    $('#EditEpfNo').css('display', 'block');
                }

                document.getElementById("epf_no").setAttribute("value", obj.epfno);
                document.getElementById("generalorganizationname").setAttribute("value", obj.generalorganizationname);
                document.getElementById("gender_edit").setAttribute("value", obj.gender);
                document.getElementById("nic_edit").setAttribute("value", obj.nic);
                document.getElementById("first_name_edit").setAttribute("value", obj.firstname);
                document.getElementById("last_name_edit").setAttribute("value", obj.lastname);
                document.getElementById("email_edit").setAttribute("value", obj.email);
                document.getElementById("mobile_no_edit").setAttribute("value", obj.mobileno);
                document.getElementById("address1_edit").setAttribute("value", obj.address1);
                document.getElementById("address2_edit").setAttribute("value", obj.address2);
                document.getElementById("address3_edit").setAttribute("value", obj.address3);
                document.getElementById("home_no_edit").setAttribute("value", obj.homeno);
                document.getElementById("coutry").setAttribute("value", obj.coutry);
                document.getElementById("emegencyContactEdit").setAttribute("value", obj.emergencyContactNo);


                var designation = document.getElementById("designation");
                for (var i = 0; i < designation.options.length; i++) {
                    if (designation.options[i].value == obj.designation) {
                        designation.options[i].selected = true;
                        console.log("Designation selected: " + designation.options[i].value);
                        break;
                    }
                }

            }
        }
    };
    request.open("POST", "../EditEmployeeData", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("gupId=" + gupId);
}

function viewResignation(value) {
    $("#ResignationModal").modal('show');
    Resignation(value);
    document.getElementById("inputid").value = value;
}

function Resignation(value) {

    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                const obj = JSON.parse(str);
                if (obj.resignationDate == null) {
                    $('#resignation').prop('disabled', false);
                    $('#resignation').val("");
                    $('#resbtn').show();
                    $('#alreadyResign').hide();
                } else {
                    var rd = new Date(obj.resignationDate);
                    let rdate = rd.toISOString();
                    var rnow = new Date(rdate);
                    var rday = ("0" + rnow.getDate()).slice(-2);
                    var rmonth = ("0" + (rnow.getMonth() + 1)).slice(-2);
                    var resignationdate = rnow.getFullYear() + "-" + (rmonth) + "-" + (rday);
                    $('#resignation').val(resignationdate);
                    $('#resignation').prop('disabled', true);
                    $('#resbtn').hide();
                    $('#alreadyResign').show();
                    var inputElement = document.getElementById("alreadyResign");
                    inputElement.value = "THE EMPLOYEE HAS ALREADY RESIGNED !";
                }
                var d = new Date(obj.registereddate);

                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);
                $('#regisered1').val(today);
                $('#regisered1model2').val(today);
            }
        }
    };
    request.open("POST", "../EmployeeDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + value);
}

function ResignationSave() {

    var resignation = document.getElementById("resignation").value;
    var id = document.getElementById("inputid").value;

    if (resignation === "") {
        document.getElementById("resignationDateError").removeAttribute("hidden");
        document.getElementById("resignation").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("resignationDateError").setAttribute("hidden", "");
        document.getElementById("resignation").style.borderColor = '';

    }

    $("#ResignationModal").modal('hide');
    let jsonObject = {
        "res": resignation,
        "id": id
    }

    let jsonString = JSON.stringify(jsonObject);
    let request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                let data = this.response;
                let resp = JSON.parse(data);
                if (resp.status === 200) {
                    Swal.fire({
                        title: resp.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    }).then(function () {
                        location.reload();
                    });

                } else if (resp.status === 500) {

                    Swal.fire({
                        title: resp.message,
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }

            }
        }
    };

    request.open("POST", "../SaveResignation", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send(jsonString);
    return true;

}

function resignationClose() {
    $("#ResignationModal").modal('hide');
}

function validate_Employee_edit(frm) {

    var epf_no = $('#epf_no').val();
    var nic = $('#nic_edit').val();
    var first_name = $('#first_name_edit').val();
    var last_name = $('#last_name_edit').val();
    var email = $('#email_edit').val();
    var mobile_no = $('#mobile_no_edit').val();
    var emergency_contact = $('#emegencyContactEdit').val();
    var address1 = $('#address1_edit').val();
    var address2 = $('#address2_edit').val();
    var address3 = $('#address3_edit').val();
    var home_no = $('#home_no_edit').val();
    var designation = $('#designation').val();


    if (first_name === "") {
        document.getElementById("first_nameErrNotify").removeAttribute("hidden");
        document.getElementById("first_name_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("first_nameErrNotify").setAttribute("hidden", "");
        document.getElementById("first_name_edit").style.borderColor = '';
    }
    if (last_name === "") {
        document.getElementById("last_nameErrNotify").removeAttribute("hidden");
        document.getElementById("last_name_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("last_nameErrNotify").setAttribute("hidden", "");
        document.getElementById("last_name_edit").style.borderColor = '';
    }
    if (email === "") {
        document.getElementById("emailErrNotify").removeAttribute("hidden");
        document.getElementById("email_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emailErrNotify").setAttribute("hidden", "");
        document.getElementById("email_edit").style.borderColor = '';
    }
    if (!validateEmail(email)) {
        document.getElementById("emailErrNotify_valide").removeAttribute("hidden");
        document.getElementById("email_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emailErrNotify_valide").setAttribute("hidden", "");
        document.getElementById("email_edit").style.borderColor = '';
    }
    if (mobile_no === "") {
        document.getElementById("mobile_noErrNotify").removeAttribute("hidden");
        document.getElementById("mobile_no_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("mobile_noErrNotify").setAttribute("hidden", "");
        document.getElementById("mobile_no_edit").style.borderColor = '';
    }
    if (!validate_phone(mobile_no)) {
        document.getElementById("mobile_noErrNotify_valide").removeAttribute("hidden");
        document.getElementById("mobile_no_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("mobile_noErrNotify_valide").setAttribute("hidden", "");
        document.getElementById("mobile_no_edit").style.borderColor = '';
    }
    if (emergency_contact === "") {
        document.getElementById("emegencyContactEditErr").removeAttribute("hidden");
        document.getElementById("emegencyContactEdit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emegencyContactEditErr").setAttribute("hidden", "");
        document.getElementById("emegencyContactEdit").style.borderColor = '';
    }
    if (!validate_phone(emergency_contact)) {
        document.getElementById("emegencyContactEditinvalidErr").removeAttribute("hidden");
        document.getElementById("emegencyContactEdit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emegencyContactEditinvalidErr").setAttribute("hidden", "");
        document.getElementById("emegencyContactEdit").style.borderColor = '';
    }
    if (address1 === "") {
        document.getElementById("address1ErrNotify").removeAttribute("hidden");
        document.getElementById("address1_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("address1ErrNotify").setAttribute("hidden", "");
        document.getElementById("address1_edit").style.borderColor = '';
    }
    if (address2 === "") {
        document.getElementById("address2ErrNotify").removeAttribute("hidden");
        document.getElementById("address2_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("address2ErrNotify").setAttribute("hidden", "");
        document.getElementById("address2_edit").style.borderColor = '';
    }
    if (address3 === "") {
        document.getElementById("address3ErrNotify").removeAttribute("hidden");
        document.getElementById("address3_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("address3ErrNotify").setAttribute("hidden", "");
        document.getElementById("address3_edit").style.borderColor = '';
    }
    if (home_no === "") {
        document.getElementById("homenoErrNotify").removeAttribute("hidden");
        document.getElementById("home_no_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("homenoErrNotify").setAttribute("hidden", "");
        document.getElementById("home_no_edit").style.borderColor = '';
    }
    if (!validate_phone(home_no)) {
        document.getElementById("homeno_correctErrNotify").removeAttribute("hidden");
        document.getElementById("home_no_edit").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("homeno_correctErrNotify").setAttribute("hidden", "");
        document.getElementById("home_no_edit").style.borderColor = '';
    }

    $("#EmpEditModel").modal('hide');

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


                } else if (output.status === 400) {

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
    request.open("POST", "../EditEmployeeDataSave", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("designation=" + designation + "&epf_no=" + epf_no + "&nic=" + nic + "&first_name=" + first_name + "&last_name=" + last_name + "&address1=" + address1
            + "&address2=" + address2 + "&address3=" + address3 + "&mobile_no=" + mobile_no + "&home_no=" + home_no + "&email=" + email + "&emergency_contact=" + emergency_contact);

    return true;
}

function close_employee_edit() {
    $("#EmpEditModel").modal('hide');
}

function empDocumentUpload() {

    var documentType = document.getElementById("docType");
    var documentName = $('#docName').val();
    var empDocInput = document.getElementById("empDoc");

    if (documentType.value === "") {
        document.getElementById("typeError").removeAttribute("hidden");
        documentType.style.borderColor = 'red';

        return false;
    } else {
        document.getElementById("typeError").setAttribute("hidden", "");
        documentType.style.borderColor = '';

    }
    if (documentName === "") {
        document.getElementById("nameError").removeAttribute("hidden");
        document.getElementById("docName").style.borderColor = 'red';

        return false;
    } else {
        document.getElementById("nameError").setAttribute("hidden", "");
        document.getElementById("docName").style.borderColor = '';

    }

    if (!empDocInput && empDocInput.files.length === 0) {
        document.getElementById("docNameError").removeAttribute("hidden");
        document.getElementById("empDoc").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("docNameError").setAttribute("hidden", "");
        document.getElementById("empDoc").style.borderColor = '';
    }

    return true;
}

function empDocUploader() {

    let docPreview = document.getElementById("imagePreview");
    let empDocument = document.getElementById("empDocPreview");
    let inputFile = document.getElementById("empDoc");

    inputFile.onchange = function () {
        const imagename = this.value.split('\\').pop().split('/').pop();
        const fileExtension = imagename.split('.').pop().toLowerCase();

        if (fileExtension === 'jpeg' || fileExtension === 'png' || fileExtension === 'jpg') {
            console.log("image");
            empDocument.src = URL.createObjectURL(inputFile.files[0]);

            empDocument.style.width = '250px';
            empDocument.style.height = '200px';

            docPreview.style.display = 'block';
        } else {
            console.log("pdf");
        }

    };
}

function closeEmpDocModel() {
    $("#EmpDocUploadModel").modal('hide');
}

function selectResignDate() {

    const startDateInput = document.getElementById('regisered1model2');
    const endDateInput = document.getElementById('resignation');

    const selectedStartDate = startDateInput.value;

    endDateInput.min = selectedStartDate;

    if (endDateInput.value < selectedStartDate) {
        endDateInput.value = '';
    }
}

function searchTable() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('tablebody').getElementsByTagName('tr');


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

function loadAllRows() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";


    var tableBody = document.getElementById("tablebody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("empTableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("empTableHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tablebody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}