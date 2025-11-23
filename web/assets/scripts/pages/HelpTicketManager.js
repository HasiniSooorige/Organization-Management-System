function searchHelpTicket() {
    var input = document.getElementById("searchInput");
    var tableBody = document.getElementById("helpTicketTableBody");

    var query = input.value.toLowerCase();

    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var ticketData = rows[i].textContent.toLowerCase();
        if (ticketData.includes(query)) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
}

function filterHelpTicketTable() {
    var allCheckbox = document.getElementById("all");
    var pendingCheckbox = document.getElementById("pending");
    var ongoingCheckbox = document.getElementById("ongoing");
    var solvedCheckbox = document.getElementById("solved");
    var closedCheckbox = document.getElementById("closed");

    var tableBody = document.getElementById("helpTicketTableBody");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var statusCell = row.cells[4];

        if (allCheckbox.checked) {
            row.style.display = "";
        } else {
            var status = statusCell.textContent.trim();

            if ((pendingCheckbox.checked && status === "Pending") ||
                    (ongoingCheckbox.checked && status === "Ongoing") ||
                    (solvedCheckbox.checked && status === "Solved") ||
                    (closedCheckbox.checked && status === "Closed")) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }

    var tableFooter = document.getElementById("helpTicketTableFootTr");
    tableFooter.style.display = "none";

    var tableDiv = document.getElementById("tableHelpTicketDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("tbleTicketHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("helpTicketTableBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling

}

function filterHelpTicketUser() {
    var allCheckbox = document.getElementById("allUser");
    var pendingCheckbox = document.getElementById("pendingUser");
    var ongoingCheckbox = document.getElementById("ongoingUser");
    var solvedCheckbox = document.getElementById("solvedUser");
    var closedCheckbox = document.getElementById("closedUser");

    var tableBody = document.getElementById("helpTicketTableBody");
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
                    (solvedCheckbox.checked && status === "Solved") ||
                    (closedCheckbox.checked && status === "Closed")) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }

    var tableFooter = document.getElementById("helpTicketTableFootTr");
    tableFooter.style.display = "none";

    var tableDiv = document.getElementById("tableHelpTicketDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("tbleTicketHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("helpTicketTableBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function loadAllTicketRows() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";


    var tableBody = document.getElementById("helpTicketTableBody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("tableHelpTicketDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("tbleTicketHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("helpTicketTableBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}


function enableToDate() {
    var fromDate = document.getElementById("fromDate").value;
    var toDateInput = document.getElementById("toDate");

    toDateInput.disabled = !fromDate;

    toDateInput.min = fromDate;
}

function ticketSearchbyDate() {
    var fromDateValue = document.getElementById("fromDate").value;
    var toDateValue = document.getElementById("toDate").value;

    if (fromDateValue === "") {
        document.getElementById("fromDateError").removeAttribute("hidden");
        document.getElementById("fromDate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("fromDateError").setAttribute("hidden", "");
        document.getElementById("fromDate").style.borderColor = '';
    }
    if (toDateValue === "") {
        document.getElementById("toDateError").removeAttribute("hidden");
        document.getElementById("toDate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("toDateError").setAttribute("hidden", "");
        document.getElementById("toDate").style.borderColor = '';
    }

    var fromDate = new Date(fromDateValue);
    var toDate = new Date(toDateValue);


    var rows = document.getElementById("helpTicketTableBody").getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var requestDate = new Date(rows[i].getElementsByTagName("td")[1].innerText);

        if (requestDate >= fromDate && requestDate <= toDate) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }

    var tableFooter = document.getElementById("helpTicketTableFootTr");
    tableFooter.style.display = "none";

    var tableDiv = document.getElementById("tableHelpTicketDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("tbleTicketHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("helpTicketTableBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}