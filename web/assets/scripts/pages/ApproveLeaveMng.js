function approveAction(id) {
    $("#approveLeaveModel").modal('show');
    document.getElementById("leaveId").setAttribute("value", id);
}

function declineAction(id) {
    $("#declinedLeaveModel").modal('show');
    document.getElementById("leaveId").setAttribute("value", id);
}

function approveLeaveStatus(userId) {

    var leaveId = document.getElementById("leaveId").value;

    $.post('.././LeaveStatusApprove', {
        leaveid: leaveId,
        userId: userId

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
        } else {
            Swal.fire({
                title: "Not Saved, Try Again!!!",
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            }).then(function () {
                location.reload();
            });
        }
    });

    $("#approveLeaveModel").modal('hide');
}

function declineLeaveStatus(userId) {

    var leaveId = document.getElementById("leaveId").value;
    var reason = document.getElementById("reason").value;

    $.post('.././LeaveStatusDecline', {
        leaveid: leaveId,
        userId: userId,
        reason:reason

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
        } else {
            Swal.fire({
                title: "Not saved, Try Again!!!",
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            }).then(function () {
                location.reload();
            });
        }
    });

    $("#declinedLeaveModel").modal('hide');
}

function performFiltering() {

    var allCheckbox = document.getElementById("all");
    var pendingCheckbox = document.getElementById("pending");
    var ongoingCheckbox = document.getElementById("approved");
    var completedCheckbox = document.getElementById("declined");

    var tableBody = document.getElementById("tableempbody");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var statusCell = row.cells[8];

        if (allCheckbox.checked) {
            row.style.display = "";
        } else {
            var status = statusCell.textContent.trim();

            if ((pendingCheckbox.checked && status === "Pending") ||
                    (ongoingCheckbox.checked && status === "Approved") ||
                    (completedCheckbox.checked && status === "Declined")) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }

    var tableFooter = document.getElementById("tableFootTr");
    tableFooter.style.display = "none";

    var tableDiv = document.getElementById("leaveHistoryTableData");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("leaveHisHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function searchLeaveHistoryTable() {

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

function searchLeaveApproveTable() {

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

function loadLeaveHistory() {
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

    var tableDiv = document.getElementById("leaveHistoryTableData");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("leaveHisHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function loadLeaveApprove() {
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

    var tableDiv = document.getElementById("leaveApproveTableData");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("approveHisHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("tableempbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}