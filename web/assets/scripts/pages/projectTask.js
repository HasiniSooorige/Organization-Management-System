/* global Swal */

function loadProjectEmp() {
    var emp = document.getElementById("TaskprojectName");
    var projectId = emp.value;

    var xhr = new XMLHttpRequest();
    xhr.open("GET", "../ReadProjectEmployee?projectId=" + projectId, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var employeeNames = JSON.parse(xhr.responseText);
            console.log(employeeNames);

            var checkboxesTable = document.getElementById("table_allempnames");
            var tbody = checkboxesTable.querySelector("#tableempbody");

            while (tbody.firstChild) {
                tbody.removeChild(tbody.firstChild);
            }
            for (var i = 0; i < employeeNames.length; i++) {

                var newRow = document.createElement("tr");
                var checkboxCell = document.createElement("td");
                var checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.id = "assignEmp" + employeeNames[i].id;
                checkbox.name = "assignEmp";
                checkbox.value = employeeNames[i].EmpId;
                checkboxCell.appendChild(checkbox);

                var spaceTd = document.createElement("td");
                spaceTd.width = 10;

                var secondTd = document.createElement("td");
                secondTd.textContent = employeeNames[i].FirstName + " " + employeeNames[i].LastName + " - " + employeeNames[i].ProjectEmpRole;
                secondTd.height = 30;

                newRow.appendChild(checkboxCell);
                newRow.appendChild(spaceTd);
                newRow.appendChild(secondTd);

                checkboxesTable.querySelector("#tableempbody").appendChild(newRow);
            }
        }
    };
    xhr.send();
}



var expanded = false;

function showCheckboxes() {
    var checkboxes = document.getElementById("checkboxes");
    if (!expanded) {
        checkboxes.style.display = "block";
        expanded = true;
    } else {
        checkboxes.style.display = "none";
        expanded = false;
    }
}


function addNewTask() {

    var emp = document.getElementById("TaskprojectName");
    var projectId = emp.value;

    var taskName = document.getElementById("taskName").value;

    var checkboxes = document.getElementsByName("assignEmp");
    var checkedValues = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            checkedValues.push(checkboxes[i].value);
        }
    }

    var taskPriority = document.getElementById("taskPriority");
    var taskPriorityValue = taskPriority.value;

    var taskDueDate = document.getElementById("taskDueDate").value;
    var taskAssignDate = document.getElementById("taskAssignDate").value;

    var taskNote = document.getElementById("taskNote").value;

    if (projectId === "") {
        document.getElementById("TaskprojectNameError").removeAttribute("hidden");
        emp.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("TaskprojectNameError").setAttribute("hidden", "");
        emp.style.borderColor = '';
    }
    if (taskPriorityValue === "") {
        document.getElementById("taskPriorityError").removeAttribute("hidden");
        taskPriority.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskPriorityError").setAttribute("hidden", "");
        taskPriority.style.borderColor = '';
    }
    if (taskName === "") {
        document.getElementById("taskNameError").removeAttribute("hidden");
        document.getElementById("taskName").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskNameError").setAttribute("hidden", "");
        document.getElementById("taskName").style.borderColor = '';
    }
    if (checkedValues.length === 0) {
        document.getElementById("taskAssignEmpError").removeAttribute("hidden");
        document.getElementById("assignEmpSelect").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskAssignEmpError").setAttribute("hidden", "");
        document.getElementById("assignEmpSelect").style.borderColor = '';
    }
    if (taskAssignDate === "") {
        document.getElementById("taskAssignDateError").removeAttribute("hidden");
        document.getElementById("taskAssignDate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskAssignDateError").setAttribute("hidden", "");
        document.getElementById("taskAssignDate").style.borderColor = '';
    }
    if (taskDueDate === "") {
        document.getElementById("taskDueDateError").removeAttribute("hidden");
        document.getElementById("taskDueDate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskDueDateError").setAttribute("hidden", "");
        document.getElementById("taskDueDate").style.borderColor = '';
    }
    if (taskNote === "") {
        document.getElementById("taskNoteError").removeAttribute("hidden");
        document.getElementById("taskNote").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("taskNoteError").setAttribute("hidden", "");
        document.getElementById("taskNote").style.borderColor = '';
    }

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

    request.open("POST", "../CreateNewTask", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("projectId=" + projectId + "&taskName=" + taskName + "&checkedValues=" + checkedValues + "&taskPriorityValue=" + taskPriorityValue + "&taskAssignDate=" + taskAssignDate + "&taskDueDate=" + taskDueDate + "&taskNote=" + taskNote);
    return true;

}
function taskDueDate() {
    const today = new Date().toISOString().split('T')[0];
    const dateInput = document.getElementById('taskDueDate');
    dateInput.min = today;
}
