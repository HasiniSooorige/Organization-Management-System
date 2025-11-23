function filterTable() {

    var allCheckbox = document.getElementById("all");
    var pendingCheckbox = document.getElementById("pending");
    var ongoingCheckbox = document.getElementById("ongoing");
    var completedCheckbox = document.getElementById("completed");

    var tableBody = document.getElementById("tableempbody");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var statusCell = row.cells[3];

        if (allCheckbox.checked) {
            row.style.display = "";
        } else {
            var status = statusCell.textContent.trim();

            if ((pendingCheckbox.checked && status === "Pending") ||
                    (ongoingCheckbox.checked && status === "Ongoing") ||
                    (completedCheckbox.checked && status === "Completed")) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }

    var tableFooter = document.getElementById("tableFootTr");
    tableFooter.style.display = "none";

    var tableDiv = document.getElementById("tableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("tbleHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function  viewProjectDetails(id) {
    $("#viewProjectData").modal('show')

    console.log(id);

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                const obj = JSON.parse(str);
                var d = new Date(obj.startedDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#viewstartDate1').val(today);

                if (obj.completedDate == null) {

                    var nullComDate = "N/A";
                    $('#viewendDate1').val(nullComDate);

                } else {
                    var dE = new Date(obj.completedDate);
                    let dateLE = dE.toISOString();
                    var nowE = new Date(dateLE);
                    var dayE = ("0" + nowE.getDate()).slice(-2);
                    var monthE = ("0" + (nowE.getMonth() + 1)).slice(-2);
                    var todayE = nowE.getFullYear() + "-" + (monthE) + "-" + (dayE);

                    $('#viewendDate1').val(todayE);
                }

                var proName = document.getElementById("viewProName1");
                proName.value = obj.name;

                var proDescription = document.getElementById("viewProDes1");
                proDescription.value = obj.description;

                document.getElementById("status1").setAttribute("value", obj.statusName);
                document.getElementById("viewProDocument").setAttribute("value", obj.projectDocuments);

                if (obj.projectDocuments === null || "") {
                    $('#proDocViewDiv').css('display', 'none');
                    $('#proDocViewDivEpmty').css('display', 'block');
                } else {
                    $('#proDocViewDiv').css('display', 'block');
                    $('#proDocViewDivEpmty').css('display', 'none');
                }

                var imageNamePro = obj.logoUrl;
                console.log("Image : " + imageNamePro);

                viewProjectLogo(imageNamePro);

                var proClient = document.getElementById("clientView1");
                proClient.value = obj.generalOrganizationProfileName;

                document.getElementById("clientEmailView").setAttribute("value", obj.email);
                document.getElementById("clientMoNoView").setAttribute("value", obj.contactNo);
                document.getElementById("clientFaxNoView").setAttribute("value", obj.faxNo);
                document.getElementById("countryName1").setAttribute("value", obj.countryName);
            }
        }
    };
    request.open("POST", "../ProjectDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

    viewProjectEmpList(id);

}

function viewProjectLogo(imageNamePro) {
    var imagename = imageNamePro;
    var imageUrl = "../ViewProjectLogo?imageName=" + imagename;

    var img = document.getElementById("imgProject");
    img.src = imageUrl;
    img.height = 250;
    img.width = 250;

    var imageContainer = document.getElementById("projectLogoView");
    imageContainer.appendChild(img);
    img.style.display = 'block';
}

function viewProjectEmpList(id) {

    console.log("Emp List :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____c");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var proEmpListViewDiv = document.getElementById("proEmpListViewDiv");
                var proEmpListViewDivEmpty = document.getElementById("proEmpListViewDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    proEmpListViewDiv.style.display = 'none';
                    proEmpListViewDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    proEmpListViewDiv.style.display = 'block';
                    proEmpListViewDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("empTableBodyView");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var employee = data[i];

                    console.log(employee);

                    var name = employee.FirstName + " " + employee.LastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = name;
                    tr.appendChild(tdName);

                    var tdDesignation = document.createElement("td");
                    tdDesignation.textContent = employee.Designation;
                    tr.appendChild(tdDesignation);

                    var tdProjectRole = document.createElement("td");
                    tdProjectRole.textContent = employee.ProjectEmpRole;
                    tr.appendChild(tdProjectRole);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectEmpRoleListView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function projectActiveInactiveStatus(proId, statusId) {

    $("#projectActivationModel").modal('show');

    document.getElementById("deactiveProId").setAttribute("value", proId);
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

function projectDeactivationClose() {
    $("#projectActivationModel").modal('hide');
}

function projectDeactivationSave() {

    var proId = document.getElementById("deactiveProId").value;
    var proStatusId = document.getElementById("deactiveStatusId").value;

    $.post('.././UpdateProjectStatus', {
        status: proStatusId,
        id: proId

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

    $("#projectActivationModel").modal('hide');
}

function  uploadClientDocument(id) {
    $("#uploadClientDocument").modal('show');

    document.getElementById("rowId").setAttribute("value", id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____g");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var clientAgreementListViewDiv = document.getElementById("clientAgreementListViewDiv");
                var clientAgreementListViewDivEmpty = document.getElementById("clientAgreementListViewDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    clientAgreementListViewDiv.style.display = 'none';
                    clientAgreementListViewDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    clientAgreementListViewDiv.style.display = 'block';
                    clientAgreementListViewDivEmpty.style.display = 'none';
                }


                var tbody = document.getElementById("agreementTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var proAgreement = data[i];

                    console.log(proAgreement);

                    var tr = document.createElement("tr");

                    var tdAgreement = document.createElement("td");
                    tdAgreement.textContent = proAgreement.document;
                    tr.appendChild(tdAgreement);

                    var tdUploadDate = document.createElement("td");
                    tdUploadDate.textContent = proAgreement.uploadedDate;
                    tr.appendChild(tdUploadDate);

                    var tdView = document.createElement("td");
                    tdView.innerHTML = `<button class="btn rounded-pill btn-outline-info" onclick="openPdf('${proAgreement.document}');">View</button>`;
                    tr.appendChild(tdView);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../ProjectAgreementHistoryView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);
}

function openPdf(docName) {
    const name = docName;

    const servletUrl = `../ViewPdfDocument?name=${encodeURIComponent(name)}`;

    fetch(servletUrl, {
        method: "GET",
    })
            .then(response => response.blob())
            .then(blob => {
                const pdfUrl = URL.createObjectURL(blob);
                window.open(pdfUrl, "_blank");
            })
            .catch(error => {
                console.error("Error fetching PDF:", error);
            });

}

function editProjectDetails(id) {
    $("#editProjectDetails").modal('show');

    document.getElementById("rowIdEdit").setAttribute("value", id);

    var request = new XMLHttpRequest();

    console.log("_____a");

    request.onreadystatechange = function () {

        console.log("_____b");

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var editProName1 = document.getElementById("editProName1");
                editProName1.value = obj.name;

                var editProDes1 = document.getElementById("editProDes1");
                editProDes1.value = obj.description;

                var statusSelect = document.getElementById("editstatus1");
                for (var i = 0; i < statusSelect.options.length; i++) {
                    if (statusSelect.options[i].value == obj.statusId) {
                        statusSelect.options[i].selected = true;
                        console.log("Status selected: " + statusSelect.options[i].value);
                        break;
                    }
                }

                var d = new Date(obj.startedDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#startDate').val(today);

                if (obj.completedDate == null) {
                    var startDate = $(this).val();
                    $('#endDate').attr('min', startDate);
                } else {
                    var dE = new Date(obj.completedDate);
                    let dateLE = dE.toISOString();
                    var nowE = new Date(dateLE);
                    var dayE = ("0" + nowE.getDate()).slice(-2);
                    var monthE = ("0" + (nowE.getMonth() + 1)).slice(-2);
                    var todayE = nowE.getFullYear() + "-" + (monthE) + "-" + (dayE);

                    $('#endDate').val(todayE);
                }


            }
        }
    };
    request.open("POST", "../ProjectDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);
}

function ProjectTeamDetails(id) {
    $("#projectTeamtDetails").modal('show');
    document.getElementById("rowIdProTeam").setAttribute("value", id);
    editProjectEmpList(id);
}

function editProjectEmpList(id) {

    console.log("Emp List :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____c");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var currentTeamDiv = document.getElementById("currentTeamDiv");
                var currentTeamDivEmpty = document.getElementById("currentTeamDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    currentTeamDiv.style.display = 'none';
                    currentTeamDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    currentTeamDiv.style.display = 'block';
                    currentTeamDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("empTableBodyEdit");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var employee = data[i];

                    console.log(employee);

                    var name = employee.FirstName + " " + employee.LastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = name;
                    tr.appendChild(tdName);

                    var tdDesignation = document.createElement("td");
                    tdDesignation.textContent = employee.Designation;
                    tr.appendChild(tdDesignation);

                    var tdProjectRole = document.createElement("td");
                    tdProjectRole.textContent = employee.ProjectEmpRole;
                    tr.appendChild(tdProjectRole);

                    if (employee.IsActive === true) {
                        var tdProjectIsActive = document.createElement("td");
                        var badgeActive = document.createElement("span");
                        badgeActive.textContent = "Active";
                        badgeActive.classList.add("badge", "bg-label-success", "me-1");
                        tdProjectIsActive.style.alignItems = "center";
                        tdProjectIsActive.appendChild(badgeActive);
                        tr.appendChild(tdProjectIsActive);

                        var tdProjecRemoveButton = document.createElement("td");
                        tdProjecRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-danger" style="width: 100px;" onclick="activeEmp('${id}', '${employee.EmpId}', '${employee.ProEmpRoleId}', '${employee.IsActive}');">Remove</button>`;
                        tr.appendChild(tdProjecRemoveButton);
                    } else {
                        var tdProjectIsActive = document.createElement("td");
                        var badgeActive = document.createElement("span");
                        badgeActive.textContent = "Inactive";
                        badgeActive.classList.add("badge", "bg-label-danger", "me-1");
                        tdProjectIsActive.style.alignItems = "center";
                        tdProjectIsActive.appendChild(badgeActive);
                        tr.appendChild(tdProjectIsActive);

                        var tdProjecRemoveButton = document.createElement("td");
                        tdProjecRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-success" style="width: 100px;" onclick="activeEmp('${id}', '${employee.EmpId}', '${employee.ProEmpRoleId}', '${employee.IsActive}');">Add</button>`;
                        tr.appendChild(tdProjecRemoveButton);
                    }


                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectEmpRoleListEdit", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function activeEmp(projectId, empId, roleId, status) {

    $("#projectTeamtDetails").modal('hide');

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
    request.open("POST", "../ProjectTeamStatusUpdate", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("projectId=" + projectId + "&empId=" + empId + "&roleId=" + roleId + "&status=" + status);
    return true;
}

function openProjectDocument() {

    const projectDoc = $('#viewProDocument').val();

    const fileName = projectDoc;
    console.log(fileName);

    var servletURL = '../ViewProjectDocs';
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
            } else if (fileName.endsWith('.mp4')) {
                var video = document.createElement('video');
                video.src = fileURL;
                video.controls = true;
                var newWindow = window.open('', '_blank');
                newWindow.document.body.appendChild(video);
            }
        }
    };

    xhr.send();

}

function closeClientUpload() {
    $("#uploadClientDocument").modal('hide');
}

function closeEditProject() {
    $("#editProjectDetails").modal('hide');
}

function updateProTeam() {

    var tableBody = document.getElementById('empTableBodyEditForm');
    var rows = tableBody.getElementsByTagName('tr');

    var empEdit = document.getElementById("empNameEditForm");
    var roleEdit = document.getElementById("projectroleEditForm");

    if (rows.length <= 0) {
        document.getElementById("emptableErrNotifyEditForm").removeAttribute("hidden");
        empEdit.style.borderColor = 'red';
        roleEdit.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emptableErrNotifyEditForm").setAttribute("hidden", "");
        empEdit.style.borderColor = '';
        roleEdit.style.borderColor = '';
    }
}

function addNewRowEmpRoleEditForm() {

    event.preventDefault();

    var empEdit = document.getElementById("empNameEditForm");
    var valueEmpEdit = empEdit.value;
    var textEmpEdit = empEdit.options[empEdit.selectedIndex].text;

    var roleEdit = document.getElementById("projectroleEditForm");
    var valueRoleEdit = roleEdit.value;
    var textRoleEdit = roleEdit.options[roleEdit.selectedIndex].text;

    if (empEdit.value === "") {
        document.getElementById("empNameErrNotifyEditForm").removeAttribute("hidden");
        empEdit.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("empNameErrNotifyEditForm").setAttribute("hidden", "");
        empEdit.style.borderColor = '';
    }

    if (roleEdit.value === "") {
        document.getElementById("proRoleErrNotifyEditForm").removeAttribute("hidden");
        roleEdit.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("proRoleErrNotifyEditForm").setAttribute("hidden", "");
        roleEdit.style.borderColor = '';
    }

    $('#allEmpTableEditForm').show();

    var newRow = '<tr>' +
            '<td hidden><input type="hidden" name="valueEmpEdit[]" value="' + valueEmpEdit + '">' + valueEmpEdit + '</td>' +
            '<td><input type="hidden" name="textEmpEdit[]" value="' + textEmpEdit + '">' + textEmpEdit + '</td>' +
            '<td hidden><input type="hidden" name="valueRoleEdit[]" value="' + valueRoleEdit + '">' + valueRoleEdit + '</td>' +
            '<td><input type="hidden" name="textRoleEdit[]" value="' + textRoleEdit + '">' + textRoleEdit + '</td>' +
            '<td><input type="button" class="btn rounded-pill btn-outline-danger" onclick="removeProjectEmpEditForm(this);" value="Remove"/>'
    '</tr>';

    $('#empTableBodyEditForm').append(newRow);

    $('#tableIntakeRowEditForm').css('display', 'block');

    document.getElementById("empNameEditForm").selectedIndex = 0;
    document.getElementById("projectroleEditForm").selectedIndex = 0;

}

function closeProjectTeam() {
    $("#projectTeamtDetails").modal('hide');
}

function editProjectDataValidate() {

    var proeditval = document.getElementById("editProDes1");

    if (proeditval.value === "") {
        document.getElementById("proEditDiscError").removeAttribute("hidden");
        proeditval.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("proEditDiscError").setAttribute("hidden", "");
        proeditval.style.borderColor = '';
    }
    return true;
}
function removeProjectEmpEditForm(rowId) {

    var tbleRowId = rowId.parentNode.parentNode;

    var table = document.getElementById("allEmpTableEditForm");
    table.deleteRow(tbleRowId.rowIndex);
}
function checkDuplicateEmpProjectTeam() {
    var emp = document.getElementById("empNameEditForm");
    var valueEmp = emp.value;

    var empRole = document.getElementById("projectroleEditForm");
    var valueEmpRole = empRole.value;

    const table = document.getElementById("allEmpTableEditForm");
    const columnIndex = 0;
    const columnIndexRole = 2;

    const columnValues = [];
    const columnValuesRole = [];

    for (let i = 1; i < table.rows.length; i++) {
        const cellValue = table.rows[i].cells[columnIndex].textContent || table.rows[i].cells[columnIndex].innerText;
        const cellValueRole = table.rows[i].cells[columnIndexRole].textContent || table.rows[i].cells[columnIndexRole].innerText;

        columnValues.push(cellValue);
        columnValuesRole.push(cellValueRole);
    }
    console.log("Column 0 Values: " + columnValues);
    console.log("Column 2 Values: " + columnValuesRole);

    const buttonEmp = document.getElementById("saveEmpRole");

    if (columnValues.includes(valueEmp) && columnValuesRole.includes(valueEmpRole)) {
        document.getElementById("empalreadyexistEditForm").removeAttribute("hidden");
        buttonEmp.disabled = true;
        return false;
    } else {
        document.getElementById("empalreadyexistEditForm").setAttribute("hidden", "");
        buttonEmp.disabled = false;
        return true;
    }
}

function selectEndDate() {

    const startDateInput = document.getElementById('startDate');
    const endDateInput = document.getElementById('endDate');

    const selectedStartDate = startDateInput.value;

    endDateInput.min = selectedStartDate;

    if (endDateInput.value < selectedStartDate) {
        endDateInput.value = '';
    }
}

function searchProjectTable() {

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

function loadAllProjectRows() {

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

    var tableDiv = document.getElementById("tableDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("tbleHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function uploadClientDoc() {

    var clientDocs = document.getElementById("clientDocs");

    if (!clientDocs || clientDocs.files.length === 0) {
        document.getElementById("clientDocError").removeAttribute("hidden");
        document.getElementById("clientDocs").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientDocError").setAttribute("hidden", "");
        document.getElementById("clientDocs").style.borderColor = '';
    }
    return true;
}