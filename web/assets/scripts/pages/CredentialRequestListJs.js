function approveCedentialViewRequest(id) {

    $("#ApproveModel").modal('show');
    document.getElementById("requestId").setAttribute("value", id);
}

function acceptClose() {
    $("#ApproveModel").modal('hide');
}

function accesptSave() {
    
    $("#ApproveModel").modal('hide');
    var requestId = document.getElementById("requestId").value;

    $.post('.././ApproveCedentialViewRequest', {
        id: requestId
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
        } else if (value.status === 400) {
            Swal.fire({
                title: value.message,
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            }).then(function () {
                location.reload();
            });
        }
    });

}

function deleteCedentialViewRequestData(id) {
    
    $("#RejectModel").modal('show');
    document.getElementById("requestId").setAttribute("value", id);

}

function rejectClose() {
    $("#RejectModel").modal('hide');
}

function rejectSave() {
    
    $("#RejectModel").modal('hide');
    var requestId = document.getElementById("requestId").value;

    $.post('.././DeleteCedentialViewRequestData', {
        id: requestId
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
        } else if (value.status === 400) {
            Swal.fire({
                title: value.message,
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            }).then(function () {
                location.reload();
            });
        }
    });

}

function searchCredReqTable() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('credReqBody').getElementsByTagName('tr');


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

function loadAllCredReqRows() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("credReqBody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("credReqDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("credReqHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("credReqBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}