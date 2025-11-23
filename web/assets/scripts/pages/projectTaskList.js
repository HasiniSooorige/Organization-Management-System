/* global URL, Swal */
function taskActiveStatus(projectId, projectStatus, taskId, taskStatus) {

    if (projectStatus == 0) {
        $("#DeactiveProjectTaskStatusModel").modal('show');
    } else if (projectStatus == 1) {
        $("#taskActiveInactiveModel").modal('show');

        document.getElementById("deactiveProjectId").setAttribute("value", projectId);
        document.getElementById("deactiveTaskId").setAttribute("value", taskId);
        document.getElementById("deactiveStatusId").setAttribute("value", taskStatus);

        if (taskStatus == 1) {
            $('#deactivateMsg').css('display', 'block');
            $('#activateMsg').css('display', 'none');

            $('#deactivateTitle').css('display', 'block');
            $('#activateTitle').css('display', 'none');
        } else if (taskStatus == 0) {
            $('#deactivateMsg').css('display', 'none');
            $('#activateMsg').css('display', 'block');

            $('#deactivateTitle').css('display', 'none');
            $('#activateTitle').css('display', 'block');
        }
    }
}


function taskDeactivationClose() {
    $("#taskActiveInactiveModel").modal('hide');
}

function DeactiveProjectTask() {
    $("#DeactiveProjectTaskStatusModel").modal('hide');
}

function taskDeactivationSave() {

    var projectId = document.getElementById("deactiveProjectId").value;
    var taskId = document.getElementById("deactiveTaskId").value;
    var taskStatusId = document.getElementById("deactiveStatusId").value;

    $.post('.././UpdateTaskStatus', {
        status: taskStatusId,
        taskid: taskId,
        projectId: projectId

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

    $("#taskActiveInactiveModel").modal('hide');
}

function viewTaskDetails(taskid) {
    $("#viewTaskDetails").modal('show');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                console.log(str);
                const obj = JSON.parse(str);
                console.log(obj);

                var taskName = document.getElementById("viewName");
                taskName.value = obj.taskName;
                var taskNote = document.getElementById("viewNote");
                taskNote.value = obj.taskNote;
                document.getElementById("viewPriority").setAttribute("value", obj.priorityName);
                document.getElementById("viewStatus").setAttribute("value", obj.statusName);

                var d = new Date(obj.assignedDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var AssignDate = now.getFullYear() + "-" + (month) + "-" + (day);
                $('#viewAssignDate').val(AssignDate);

                var d2 = new Date(obj.dueDate);
                let dateL2 = d2.toISOString();
                var now2 = new Date(dateL2);
                var day2 = ("0" + now2.getDate()).slice(-2);
                var month2 = ("0" + (now2.getMonth() + 1)).slice(-2);
                var dueDate = now2.getFullYear() + "-" + (month2) + "-" + (day2);
                $('#viewDueDate').val(dueDate);

                var d3 = new Date(obj.endDate);
                let dateL3 = d3.toISOString();
                var now3 = new Date(dateL3);
                var day3 = ("0" + now3.getDate()).slice(-2);
                var month3 = ("0" + (now3.getMonth() + 1)).slice(-2);
                var endDate = now3.getFullYear() + "-" + (month3) + "-" + (day3);
                $('#viewEndDate').val(endDate);

                if (obj.startDate === null) {
                    var nullStartDate = "N/A";
                    $('#viewstartDate').val(nullStartDate);
                } else {
                    document.getElementById("viewstartDate").setAttribute("value", obj.startDate);
                }

                if (obj.endDate === null) {
                    var nullEndDate = "N/A";
                    $('#viewEndDate').val(nullEndDate);
                } else {
                    document.getElementById("viewEndDate").setAttribute("value", obj.endDate);
                }

                if (obj.completedDate === null) {
                    var nullCompleteDate = "N/A";
                    $('#viewCompleteDate').val(nullCompleteDate);
                } else {
                    document.getElementById("viewCompleteDate").setAttribute("value", obj.completedDate);
                }

            }
        }
    };
    request.open("POST", "../TaskEditDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + taskid);

    viewTaskDocument(taskid);

    viewTaskTeamMembers(taskid);
}

function viewTaskDocument(taskid) {

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var TaskDocDiv = document.getElementById("TaskDocDiv");
                var TaskDocDivEmpty = document.getElementById("TaskDocDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    TaskDocDiv.style.display = 'none';
                    TaskDocDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    TaskDocDiv.style.display = 'block';
                    TaskDocDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("taskDocTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var taskDocuments = data[i];

                    console.log(taskDocuments);

                    var tr = document.createElement("tr");

                    var tdDocument = document.createElement("td");
                    tdDocument.textContent = taskDocuments.url;
                    tr.appendChild(tdDocument);

                    var tdView = document.createElement("td");
                    tdView.innerHTML = `<button class="btn rounded-pill btn-outline-info" onclick="openTaskDocument('${taskDocuments.url}');">View</button>`;
                    tr.appendChild(tdView);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../TaskDocumentView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + taskid);
}

function openTaskDocument(documentName) {

    const fileName = documentName;
    console.log(fileName);

    var servletURL = '../TaskDocumentOpen';
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

function viewTaskTeamMembers(taskid) {

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var taskTeamDiv = document.getElementById("taskTeamDiv");
                var taskTeamDivEmpty = document.getElementById("taskTeamDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    taskTeamDiv.style.display = 'none';
                    taskTeamDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    taskTeamDiv.style.display = 'block';
                    taskTeamDivEmpty.style.display = 'none';
                }


                var tbody = document.getElementById("taskEmpBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var taskEmployee = data[i];

                    console.log(taskEmployee);
                    var empName = taskEmployee.FirstName + " " + taskEmployee.LastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = empName;
                    tr.appendChild(tdName);

                    var tdDesignation = document.createElement("td");
                    tdDesignation.textContent = taskEmployee.Designation;
                    tr.appendChild(tdDesignation);

                    var tdProjectRole = document.createElement("td");
                    tdProjectRole.textContent = taskEmployee.ProjectEmpRole;
                    tr.appendChild(tdProjectRole);

                    if (taskEmployee.startDate === null || taskEmployee.startDate === "" || taskEmployee.startDate === undefined) {
                        var tdStartDate = document.createElement("td");
                        tdStartDate.textContent = "N/A";
                        tr.appendChild(tdStartDate);
                    } else {
                        var tdStartDate = document.createElement("td");
                        tdStartDate.textContent = taskEmployee.startDate;
                        tr.appendChild(tdStartDate);
                    }

                    if (taskEmployee.endDate === null || taskEmployee.endDate === "" || taskEmployee.endDate === undefined) {
                        var tdEndDate = document.createElement("td");
                        tdEndDate.textContent = "N/A";
                        tr.appendChild(tdEndDate);
                    } else {
                        var tdEndDate = document.createElement("td");
                        tdEndDate.textContent = taskEmployee.endDate;
                        tr.appendChild(tdEndDate);
                    }





                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../TaskEmployeeView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + taskid);
}

function uploadTaskDocument(id) {
    $("#uploadTaskDocument").modal('show')

    document.getElementById("rowId").setAttribute("value", id);
}

function closeTaskUpload() {
    $("#uploadTaskDocument").modal('hide');
}

function taskDocUploader() {

    let docPreview = document.getElementById("imagePreview");
    let empDocument = document.getElementById("taskDocPreview");
    let inputFile = document.getElementById("taskDoc");

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

function editTaskDetails(id) {

    $("#editTaskDetails").modal('show');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
                console.log(str);
                const obj = JSON.parse(str);
                console.log(obj);


                document.getElementById("editTaskId").setAttribute("value", obj.taskId);
                var taskName = document.getElementById("editTaskName");

                document.getElementById("editStartDate").setAttribute("value", obj.startDate);
                document.getElementById("editEndDate").setAttribute("value", obj.endDate);

                taskName.value = obj.taskName;
                var taskNote = document.getElementById("editTaskNote");
                taskNote.value = obj.taskNote;
                document.getElementById("editCompleteDate").setAttribute("value", obj.completedDate);

                var prioritySelect = document.getElementById("edittaskPriority");
                for (var i = 0; i < prioritySelect.options.length; i++) {
                    if (prioritySelect.options[i].value == obj.priorityId) {
                        prioritySelect.options[i].selected = true;
                        console.log("Priority selected: " + prioritySelect.options[i].value);
                        break;
                    }
                }

                var statusSelect = document.getElementById("editTaskStatus");
                for (var i = 0; i < statusSelect.options.length; i++) {
                    if (statusSelect.options[i].value == obj.statusId) {
                        statusSelect.options[i].selected = true;
                        console.log("Status selected: " + statusSelect.options[i].value);
                        break;
                    }
                }

            }
        }
    };
    request.open("POST", "../TaskEditDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);
}

function closeEditTask() {
    $("#editTaskDetails").modal('hide');
}

function editTaskData() {

    var taskId = document.getElementById("editTaskId").value;
    var taskNote = document.getElementById("editTaskNote").value;
    var taskPriority = document.getElementById("edittaskPriority").value;
//    var taskStatus = document.getElementById("editTaskStatus").value;
    var StartDate = document.getElementById("editStartDate").value;
    var CompleteDate = document.getElementById("editCompleteDate").value;
    var EndDate = document.getElementById("editEndDate").value;

    if (taskNote === "") {
        document.getElementById("editTaskNoteError").removeAttribute("hidden");
        document.getElementById("editTaskNote").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("editTaskNoteError").setAttribute("hidden", "");
        document.getElementById("editTaskNote").style.borderColor = '';
    }

    $("#editTaskDetails").modal('hide');

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

    request.open("POST", "../EditTaskDetails", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("taskId=" + taskId + "&taskNote=" + taskNote + "&taskPriority=" + taskPriority + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&CompleteDate=" + CompleteDate);
}

function taskTeamMembers(taskId, projecTId) {

    $("#taskTeamtDetails").modal('show');

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("taskTeamMemersTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var employee = data[i];

                    console.log(employee);

                    var nameEmp = employee.FirstName + " " + employee.LastName;

                    var tr = document.createElement("tr");

                    var tdEmpId = document.createElement("td");
                    tdEmpId.textContent = employee.EmpId;
                    tdEmpId.style.display = "none";
                    tr.appendChild(tdEmpId);


                    var tdName = document.createElement("td");
                    tdName.textContent = nameEmp;
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
                        tdProjecRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-danger" style="width: 100px;" onclick="activeTaskEmp('${taskId}', '${employee.EmpId}', '${employee.ProEmpRoleId}', '${employee.IsActive}');">Remove</button>`;
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
                        tdProjecRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-success" style="width: 100px;" onclick="activeTaskEmp('${taskId}', '${employee.EmpId}', '${employee.ProEmpRoleId}', '${employee.IsActive}');">Add</button>`;
                        tr.appendChild(tdProjecRemoveButton);
                    }


                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../TaskEmpListStatusView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + taskId);

    loadAddNewTaskEmp(taskId, projecTId);

}

function activeTaskEmp(taskId, empId, projectRoleId, isActive) {

    $("#taskTeamtDetails").modal('hide');

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
                        allowEscapeKey: true,
                        closeOnConfirm: false,
                        timer: 1000
                    }).then(function () {
                        location.reload();
                    });
                }
            }
        }
    };
    request.open("POST", "../TaskTeamStatusUpdate", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("taskId=" + taskId + "&empId=" + empId + "&projectRoleId=" + projectRoleId + "&isActive=" + isActive);
    return true;

}

function loadAddNewTaskEmp(taskId, projecTId) {

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../ReadProjectEmployee?projectId=" + projecTId, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var employeeNames = JSON.parse(xhr.responseText);

            var tableBody = document.getElementById("addNewTaskEmpBody");

            tableBody.innerHTML = "";

            employeeNames.forEach(function (employee) {
                var row = tableBody.insertRow();

                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);

                cell1.textContent = employee.EmpId;
                cell1.style.display = "none";
                cell2.textContent = employee.FirstName + ' ' + employee.LastName;
                cell3.textContent = employee.ProjectEmpRole;
                cell4.innerHTML = `<button class="btn rounded-pill btn-outline-info" style="width: 100px;" onclick="addNewTaskEmp('${taskId}', '${employee.EmpId}');">Add</button>`;
            });
        }
    };
    xhr.send();

}

function addNewTaskEmp(taskId, taskEmpId) {

    $("#taskTeamtDetails").modal('hide');

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
    request.open("POST", "../CreateNewTaskEmployee", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("taskId=" + taskId + "&taskEmpId=" + taskEmpId);

}

function filterTableByPriority() {

    var allCheckbox = document.getElementById("allPriority");
    var urgentCheckbox = document.getElementById("Urgent");
    var importantCheckbox = document.getElementById("Important");
    var mediumCheckbox = document.getElementById("Medium");
    var lowCheckbox = document.getElementById("Low");

    var tableBody = document.getElementById("task_project_table_body");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var priorityCell = row.cells[3];

        if (priorityCell) {
            var priority = priorityCell.textContent.trim();

            if (allCheckbox.checked) {
                row.style.display = "";
            } else {
                if ((urgentCheckbox.checked && priority === "Urgent") ||
                        (importantCheckbox.checked && priority === "Important") ||
                        (mediumCheckbox.checked && priority === "Medium") ||
                        (lowCheckbox.checked && priority === "Low")) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }
    }
}

function filterTableByStatus() {
    var allCheckbox = document.getElementById("allStatus");
    var pendingCheckbox = document.getElementById("Pending");
    var ongoingCheckbox = document.getElementById("Ongoing");
    var completedCheckbox = document.getElementById("Completed");

    var tableBody = document.getElementById("task_project_table_body");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var statusCell = row.cells[4];
        if (statusCell) {
            var status = statusCell.textContent.trim();

            if (allCheckbox.checked) {
                row.style.display = "";
            } else {
                if ((pendingCheckbox.checked && status === "Pending") ||
                        (ongoingCheckbox.checked && status === "Ongoing") ||
                        (completedCheckbox.checked && status === "Completed")) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            }
        }
    }
}

function closeTaskComment() {
    $("#addTaskComment").modal('hide');
}

var com_taskId;
var com_projectId;
function taskComments(taskId, projectId) {

    console.log("taskProjectId-----------------------------------" + projectId);
    $("#addTaskComment").modal('show');

    com_taskId = taskId;
    com_projectId = projectId;

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var comHistoryDiv = document.getElementById("comHistoryDiv");
                var comHistoryDivEmpty = document.getElementById("comHistoryDivEmpty");
                if (Array.isArray(data) && data.length === 0) {

                    console.log('Data is an empty array.');
                    comHistoryDiv.style.display = 'none';
                    comHistoryDivEmpty.style.display = 'block';

                } else {

                    console.log('Data is not an empty array.');
                    comHistoryDiv.style.display = 'block';
                    comHistoryDivEmpty.style.display = 'none';
                }

                var tbody = document.getElementById("commentTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var taskComments = data[i];

                    console.log(taskComments);

                    var name = taskComments.gupFirstName + " " + taskComments.gupLastName;

                    var EMPname = taskComments.gupFirstNameEMP + " " + taskComments.gupLastNameEMP;

                    var tr = document.createElement("tr");

                    var tdDate = document.createElement("td");
                    var date = new Date(taskComments.addedDate);

                    var year = date.getFullYear();
                    var month = ("0" + (date.getMonth() + 1)).slice(-2); // getMonth() returns 0-11, add 1 to get 1-12 and pad with leading zero
                    var day = ("0" + date.getDate()).slice(-2); // pad with leading zero

// Extract hours, minutes, and seconds
                    var hours = date.getHours();
                    var minutes = ("0" + date.getMinutes()).slice(-2); // pad with leading zero
                    var seconds = ("0" + date.getSeconds()).slice(-2); // pad with leading zero

// Determine AM/PM
                    var ampm = hours >= 12 ? 'PM' : 'AM';

// Convert hours to 12-hour format
                    hours = hours % 12;
                    hours = hours ? hours : 12; // the hour '0' should be '12'
                    hours = ("0" + hours).slice(-2); // pad with leading zero

                    var formattedDate = `${year}-${month}-${day}`;
                    var formattedTime = `${hours}:${minutes}:${seconds} ${ampm}`;

                    tdDate.innerHTML = `${formattedDate}<br>${formattedTime}`;

                    tr.appendChild(tdDate);



                    var tdCommentBy = document.createElement("td");
                    tdCommentBy.textContent = name;
                    tr.appendChild(tdCommentBy);

                    var tdMentionEmp = document.createElement("td");
                    tdMentionEmp.textContent = EMPname;
                    tr.appendChild(tdMentionEmp);

                    var tdComment = document.createElement("td");
                    tdComment.textContent = taskComments.comment;
                    tr.appendChild(tdComment);



                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../TaskCommentView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("taskId=" + taskId + "&projectId=" + projectId);

    taskprojectEmp(projectId);
}

function taskprojectEmp(proId) {
    console.log("proId-----------------------------------" + proId);

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../ReadProjectEmployee?projectId=" + proId, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var employeeNames = JSON.parse(xhr.responseText);
            console.log(employeeNames);

            var select = document.getElementById("taskProEmp");

            select.innerHTML = '<option selected disabled value="">Select Project Employee</option>';

            // Populate the select element with new options
            employeeNames.forEach(function (employee) {
                var option = document.createElement("option");
                option.value = employee.EmpId;
                option.text = employee.FirstName + " " + employee.LastName;
                select.appendChild(option);
            });
        }
    };
    xhr.send();
}


function addNewTaskComment(userId) {

    var commentTaskId = com_taskId;
    var commentProjectId = com_projectId;

    var comment = document.getElementById("taskComment").value;

    var commentMentionEmp = document.getElementById("taskProEmp").value;

    if (commentMentionEmp === "") {
        document.getElementById("taskProEmpError").removeAttribute("hidden");
        document.getElementById("taskProEmp").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskProEmpError").setAttribute("hidden", "");
        document.getElementById("taskProEmp").style.borderColor = '';
    }
    if (comment === "") {
        document.getElementById("taskCommentError").removeAttribute("hidden");
        document.getElementById("taskComment").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskCommentError").setAttribute("hidden", "");
        document.getElementById("taskComment").style.borderColor = '';
    }

    $("#addTaskComment").modal('hide');

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

    request.open("POST", "../CreateNewTaskComment", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("comment=" + comment + "&userId=" + userId + "&commentTaskId=" + commentTaskId + "&commentProjectId=" + commentProjectId + "&mentionEmpId=" + commentMentionEmp);

}

function editStartDateSelect() {
    const today = new Date().toISOString().split('T')[0];
    const dateInput = document.getElementById('editStartDate');
    dateInput.min = today;
}

function editEndDateSelect() {
    const startTask = document.getElementById('editStartDate');
    const endDateInput = document.getElementById('editEndDate');
    const selectedStartDate = startTask.value;

    endDateInput.min = selectedStartDate;

    if (endDateInput.value < selectedStartDate) {
        endDateInput.value = '';
    }
}

function editCompleteDateSelect() {
    const startTask = document.getElementById('editEndDate');
    const endDateInput = document.getElementById('editCompleteDate');
    const selectedStartDate = startTask.value;

    endDateInput.min = selectedStartDate;

    if (endDateInput.value < selectedStartDate) {
        endDateInput.value = '';
    }
}

function searchTask() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('task_project_table_body').getElementsByTagName('tr');


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

function saveTaskDocument() {
    var taskDoc = document.getElementById("taskDoc");

    if (!taskDoc || taskDoc.files.length === 0) {
        document.getElementById("taskDocError").removeAttribute("hidden");
        document.getElementById("taskDoc").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskDocError").setAttribute("hidden", "");
        document.getElementById("taskDoc").style.borderColor = '';
    }
    return true;
}

function taskAdmitAction(taskAssignEmptbleId) {

    console.log("taskAssignEmptbleId :" + taskAssignEmptbleId);

    $("#admitTaskModal").modal('show');

    document.getElementById("taskAssignEmptbleId").setAttribute("value", taskAssignEmptbleId);
}

function closeAdmitTask() {
    $("#admitTaskModal").modal('hide');
}

function admitTask() {
    $("#admitTaskModal").modal('hide');

    var taskAssignEmptbleId = document.getElementById("taskAssignEmptbleId").value;

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

    request.open("POST", "../EmployeeAdmitTask", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + taskAssignEmptbleId);

}

function taskEndAction(taskAssignEmpTableId, projectId, taskId) {

    $("#endTaskModal").modal('show');

    document.getElementById("taskAssignEmpTableId").setAttribute("value", taskAssignEmpTableId);
    document.getElementById("taskAssignProjectId").setAttribute("value", projectId);
    document.getElementById("taskAssignTaskId").setAttribute("value", taskId);

}

function closeEndTask() {
    $("#endTaskModal").modal('hide');
}

function endTask() {
    $("#endTaskModal").modal('hide');

    var taskAssignEmpTableId = document.getElementById("taskAssignEmpTableId").value;
    var taskAssignProjectId = document.getElementById("taskAssignProjectId").value;
    var taskAssignTaskId = document.getElementById("taskAssignTaskId").value;

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;
                const  output = JSON.parse(data);
                if (output.status === 200) {
                    
                    //pop-up comment model
                    taskComments(taskAssignTaskId, taskAssignProjectId);
                    $("#EndTaskComment").modal('show');
                    
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

    request.open("POST", "../EmployeeEndTask", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + taskAssignEmpTableId + "&taskAssignProjectId=" + taskAssignProjectId + "&taskAssignTaskId=" + taskAssignTaskId);
}

function endTaskNote() {
 $("#endTaskNote").modal('show');
}

function  closeEndTaskNote(){
     $("#endTaskNote").modal('hide');
}

function notAssignTaskNote() {
 $("#notAssignTaskNote").modal('show');
}

function  closeNotAssignTaskNote(){
     $("#notAssignTaskNote").modal('hide');
}