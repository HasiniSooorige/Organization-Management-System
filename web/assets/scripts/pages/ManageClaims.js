function approve() {
    $('#requestClaims').modal('hide');
    $('#approveClaim').modal('show');
}

function approveCanceled() {
    $('#approveClaim').modal('hide');
}

function disapprove() {
    $('#requestClaims').modal('hide');
    $('#disapproveClaim').modal('show');
}

function disapproveCancel() {
    $('#disapproveClaim').modal('hide');
}


function approveHAC(id) {

    $('#approveClaim').modal('hide');
    const labelText = document.getElementById('exampleModalLabel');
    const claimId = labelText.textContent;
    var approveAdmin = "Human";
    if (claimId != "") {
        $.post('../FinanceStatus', {
            id: id,
            claimId: claimId,
            approveAdmin: approveAdmin,
            val: "Approve"
        }, function (data) {

            if (data.status === 200) {
                Swal.fire({
                    title: "Claim Approve Success!",
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            } else {
                Swal.fire({
                    title: "Claim Approve Error!",
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            }
        });
    } else {
        alert("Claim Id Not Found");
    }
}


function approveCancel(id) {

    $('#disapproveClaim').modal('hide');
    const labelText = document.getElementById('exampleModalLabel');
    const claimId = labelText.textContent;
    var approveAdmin = "Human";
    if (claimId != "") {
        $.post('../FinanceStatus', {
            id: id,
            claimId: claimId,
            approveAdmin: approveAdmin,
            val: "Dissapprove"
        }, function (data) {
            if (data.status == 200) {
                Swal.fire({
                    title: "Claim Dissapprove Success!",
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            } else {
                Swal.fire({
                    title: "Claim Dissapprove Error!",
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            }
        });
    } else {
        alert("Claim ID not Found!");
    }
}


function approvefc() {
    $('#requestClaims').modal('hide');
    $('#approveClaimfc').modal('show');
}

function approveCanceledfc() {
    $('#approveClaimfc').modal('hide');
}

function disapprovefc() {
    $('#requestClaims').modal('hide');
    $('#disapproveClaimfc').modal('show');
}

function disapproveCancelfc() {
    $('#disapproveClaimfc').modal('hide');
}

function approveFIN(id) {

    $('#approveClaimfc').modal('hide');
    const labelText = document.getElementById('exampleModalLabel');
    const claimId = labelText.textContent;
    var approveAdmin = "Finance";
    if (claimId != "")
    {
        $.post('../FinanceStatus', {
            id: id,
            claimId: claimId,
            approveAdmin: approveAdmin,
            val: "Approve"
        }, function (data) {
            if (data.status === 200) {
                Swal.fire({
                    title: "Claim Approve Success!",
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            } else {
                Swal.fire({
                    title: "Claim Approve Error!",
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            }

        });
    } else {
        alert("Claim ID Not Found!");
    }

}

function disapproveClaimFinance(id) {

    $('#disapproveClaimfc').modal('hide');
    const labelText = document.getElementById('exampleModalLabel');
    const claimId = labelText.textContent;
    var approveAdmin = "Finance";
    if (claimId != "") {
        $.post('../FinanceStatus', {
            id: id,
            claimId: claimId,
            approveAdmin: approveAdmin,
            val: "Dissapprove"
        }, function (data) {
            if (data.status == 200) {
                Swal.fire({
                    title: "Claim Dissapprove Success!",
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            } else {
                Swal.fire({
                    title: "Claim Dissapprove Error!",
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                }).then(function () {
                    location.reload();
                });
            }
        });
    } else {
        alert("Claim ID Not Found!");
    }
}

function approveRequest(id) {

    var r = new XMLHttpRequest();
    const labelElement = document.getElementById('totalAmount');
    labelElement.textContent = "Rs. 0.00";
    var tableBody = document.getElementById("requestClaimTb").getElementsByTagName('tbody')[0];
    tableBody.innerHTML = "";
    r.onreadystatechange = function () {
        if (r.readyState == 4) {
            if (r.status == 200) {

                var t = r.responseText;
                // Parse the JSON response from the servlet
                var data = JSON.parse(t);
                var L = 1;
                var amount = 0;
                for (var i = 0; i < data.length; i++) {

                    var reqclaim = data[i];
                    var tr = document.createElement("tr");
                    var tdId = document.createElement("td");
                    tdId.textContent = L;
                    tr.appendChild(tdId);
                    var tddate = document.createElement("td");
                    tddate.textContent = reqclaim.date;
                    tr.appendChild(tddate);
                    var tdamount = document.createElement("td");
                    tdamount.textContent = "Rs." + reqclaim.amount;
                    tr.appendChild(tdamount);
                    var tdfileUrl = document.createElement("td");
                    tdfileUrl.textContent = reqclaim.fileUrl;
                    tr.appendChild(tdfileUrl);
                    tableBody.appendChild(tr);
                    amount += parseInt(reqclaim.amount);
                    const labelElement = document.getElementById('totalAmount');
                    labelElement.textContent = "Rs. " + amount + ".00";
                    const labelElement1 = document.getElementById('exampleModalLabel');
                    labelElement1.textContent = reqclaim.claimId;
                    L++;
                }

            } else {

                alert("No ok")
                console.error('Failed to fetch data from the server.');
            }
        }

    }
    ;
    r.open("POST", "../viewRequestClaim", true);
    r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    r.send("id=" + id);
    $('#requestClaims').modal('show');
}


function removeFakePathPrefix(inputValue) {
    return inputValue.replace("C:\\fakepath\\", "");
}


function validateForm() {
// Reset error messages
    document.getElementById("epfErrNotify").setAttribute("hidden", "")

    // Validate Date
    const dateField = document.getElementById("req_date");
    if (!dateField.value) {
        document.getElementById("epfErrNotify").textContent = "Date is required.";
        return false;
    }

// Validate Amount
    const amountField = document.getElementById("req_amount");
    if (!amountField.value) {
        document.getElementById("epfErrNotify").textContent = "Amount is required.";
        return false;
    }

// Validate Attachment (File Upload)
    const attachField = document.getElementById("inputGroupFile01");
    if (!attachField.value) {
        document.getElementById("epfErrNotify").textContent = "Attachment is required.";
        return false;
    }

// Validate Description (Optional)
    const descField = document.getElementById("req_desc");
    if (descField.value.length > 200) {
        document.getElementById("epfErrNotify").textContent = "Description should be less than 200 characters.";
        return false;
    }

    return true; // Form is valid
}


function collectDataFromTable(userID) {

    var tableRows = document.querySelectorAll('#tableBody tr');
    var formData = new FormData(); // Create a FormData object to send the form data

    tableRows.forEach(function (row) {
        var date = row.querySelector('.req_date').value;
        var claimAmount1 = row.querySelector('.req_amount').value;
        var attachment = row.querySelector('.file_Upload').value;
        var claimType = row.querySelector('.claim_Type').value;
        // Set the values in the FormData object
        formData.append('req_date[]', date);
        formData.append('req_amount[]', claimAmount1);
        formData.append('attachment[]', attachment);
        formData.append('claimType[]', claimType);
    });
    const amo = document.getElementById("total").innerHTML;
    const numbersOnly = amo.replace(/^\.|[^0-9.]/g, '');
    const textareaElement = document.getElementById('req_desc');
    const textEntered = textareaElement.value;
    formData.append('textEntered', textEntered);
    formData.append('totalAmount', numbersOnly);
    formData.append('userID', userID);
    return formData;
}

function RequestClaim1(userID) {

    var description = document.getElementById("req_desc").value;

    if (description === "") {
        document.getElementById("desErrNotify").removeAttribute("hidden");
        document.getElementById("req_desc").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("desErrNotify").setAttribute("hidden", "");
        document.getElementById("req_desc").style.borderColor = '';
    }

    var formData = collectDataFromTable(userID);
    $.ajax({
        url: '../CreateClaim',
        method: 'POST',
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            console.log(data);
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
                });
            }
        }
    });
    $("#addRequestClaim").modal('hide');
}



document.getElementById("fileToUpload").addEventListener("change", function () {
    var fileInput = this;
    var file = fileInput.files[0];
    var formData = new FormData();
    formData.append("fileToUpload", file);
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "../UploadClaimDoc", true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            // Handle the server's response after the file is uploaded
            console.log(xhr.responseText);
        }
    };
    xhr.send(formData);
});
function addRow() {

    var tableBody = document.getElementById("tableBody");
    var newRow = document.createElement("tr");
    newRow.setAttribute("data-id", tableBody.children.length);

    // Get user input from JSP input fields
    var dateInput = document.getElementById("req_date").value;
    var amountInput = document.getElementById("req_amount").value;
    var attachmentInput = document.getElementById("fileToUpload").value;
    var claimTypeInput = document.getElementById("claimType").value;

    if (dateInput === "") {
        document.getElementById("dateErrNotify").removeAttribute("hidden");
        document.getElementById("req_date").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("dateErrNotify").setAttribute("hidden", "");
        document.getElementById("req_date").style.borderColor = '';
    }

    if (amountInput === "") {
        document.getElementById("amountErrNotify").removeAttribute("hidden");
        document.getElementById("req_amount").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("amountErrNotify").setAttribute("hidden", "");
        document.getElementById("req_amount").style.borderColor = '';
    }

    if (attachmentInput === "") {
        document.getElementById("attachmentErrNotify").removeAttribute("hidden");
        document.getElementById("fileToUpload").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("attachmentErrNotify").setAttribute("hidden", "");
        document.getElementById("fileToUpload").style.borderColor = '';
    }

    if (claimTypeInput === "") {
        document.getElementById("typeErrNotify").removeAttribute("hidden");
        document.getElementById("claimType").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("typeErrNotify").setAttribute("hidden", "");
        document.getElementById("claimType").style.borderColor = '';

    }


    // Add date input field to the new row
    var dateCell = document.createElement("td");
    dateCell.innerHTML = '<input type="text" name="req_date[]" Readonly class="form-control req_date" value="' + dateInput + '" />';
    // Add amount input field to the new row
    var amountCell = document.createElement("td");
    amountCell.innerHTML = '<input type="text" name="req_amount[]" Readonly class="form-control req_amount" value="' + amountInput + '" />';
    // Add file input field to the new row
    var attachmentFileName = attachmentInput.replace(/^.*[\\\/]/, '');
    var attachmentCell = document.createElement("td");
    attachmentCell.innerHTML = '<input type="text" name="fileToUpload[]" Readonly class="form-control file_Upload" value="' + attachmentFileName + '" />';
    // Add select input field to the new row
    var claimTypeCell = document.createElement("td");
    claimTypeCell.innerHTML = '<input type="text" name="claimType[]" Readonly class="form-control claim_Type" value="' + claimTypeInput + '" />';

    $('#addNewTableDiv').css('display', 'block');
    // Append cells to the new row
    newRow.appendChild(dateCell);
    newRow.appendChild(amountCell);
    newRow.appendChild(attachmentCell);
    newRow.appendChild(claimTypeCell);
    // Append the new row to the table body
    tableBody.appendChild(newRow);

    total();
    clearFields();

    return true;
}

function clearFields() {
    // Get references to the input fields
    var dateInput = document.getElementById("req_date");
    var amountInput = document.getElementById("req_amount");
    var fileInput = document.getElementById("fileToUpload");
    var claimTypeSelect = document.getElementById("claimType");
// Reset the values of the input fields
    dateInput.value = "";
    amountInput.value = "";
    fileInput.value = "";
    claimTypeSelect.value = ""; // Resetting a select element to its initial state

}


function total() {
    var tableRows = document.getElementById("tableBody").getElementsByTagName("tr");
    var totalAmount = 0;
    for (var i = 0; i < tableRows.length; i++) {
        var amountInput = parseFloat(tableRows[i].querySelector(".req_amount").value) || 0;
        totalAmount += amountInput;
    }

    var labelElement = document.getElementById("total");
    labelElement.textContent = "Rs " + totalAmount.toFixed(2);
}





function approveRequest1(id) {

    var r = new XMLHttpRequest();
    const labelElement = document.getElementById('totalAmount');
    labelElement.textContent = "Rs. 0.00";
    var tableBody = document.getElementById("requestClaimTb1").getElementsByTagName('tbody')[0];
    tableBody.innerHTML = "";
    r.onreadystatechange = function () {
        if (r.readyState == 4) {
            if (r.status == 200) {

                var t = r.responseText;
                var data = JSON.parse(t);
                var L = 1;
                var amount = 0;
                for (var i = 0; i < data.length; i++) {

                    var reqclaim = data[i];
                    var tr = document.createElement("tr");
                    var tdId = document.createElement("td");
                    tdId.textContent = L;
                    tr.appendChild(tdId);
                    var tddate = document.createElement("td");
                    tddate.textContent = reqclaim.date;
                    tr.appendChild(tddate);
                    var tdamount = document.createElement("td");
                    tdamount.textContent = "Rs. " + reqclaim.amount;
                    tr.appendChild(tdamount);
                    var encodedString = reqclaim.fileUrl;
                    var img = document.createElement("img");
                    img.id = "imageContainer";
                    img.width = 150;
                    img.height = 150;
                    const servletUrl = `../ViewImage?name=${encodeURIComponent(encodedString)}`;
                    // Append the <img> element to a container in your HTML
                    img.innerHTML = ""; // Clear any previous content
                    img.src = servletUrl;
                    // Create a <td> element for the image and append the <img> element to it
                    var tdfileUrl = document.createElement("td");
                    tdfileUrl.appendChild(img);
                    tr.appendChild(tdfileUrl);
                    tableBody.appendChild(tr);
                    amount += parseInt(reqclaim.amount);
                    const labelElement = document.getElementById('totalAmount');
                    labelElement.textContent = "Rs. " + amount + ".00";
                    const labelElement1 = document.getElementById('exampleModalLabel');
                    labelElement1.textContent = reqclaim.claimId;
                    L++;
                }

            } else {
                alert("No ok")
                console.error('Failed to fetch data from the server.');
            }
        }

    }
    ;
    r.open("POST", "../viewRequestClaim", true);
    r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    r.send("claimid=" + id);
    $('#requestClaims').modal('show');
}

function searchmyclaims() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('myclaimsbody').getElementsByTagName('tr');


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

function loadMyClaims() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("myclaimsbody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("myClaimsDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("myClaimsHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("myclaimsbody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function searchHClaims() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('hclaimsBody').getElementsByTagName('tr');


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

function loadHclaims() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("hclaimsBody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("hClaimDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("hclaimsHead");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("hclaimsBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}

function searchFinClaims() {

    var input = document.querySelector('.form-control');
    var filter = input.value.toUpperCase();


    var rows = document.getElementById('finClaimBody').getElementsByTagName('tr');


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

function loadFinClaims() {

    var paginationElement = document.getElementById("pagination");
    paginationElement.innerHTML = "";

    var tableBody = document.getElementById("finClaimBody");
    var allRows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < allRows.length; i++) {
        allRows[i].style.display = "";
    }

    var pageSizeButtons = document.querySelectorAll('.page-size');
    for (var i = 0; i < pageSizeButtons.length; i++) {
        pageSizeButtons[i].classList.remove('active');
    }

    var tableDiv = document.getElementById("finClaimDataDiv");
    tableDiv.style.maxHeight = "700px"; // Set the maximum height

    var tableHeader = document.getElementById("finClaimHeader");
    tableHeader.style.overflowY = "none";

    var table = document.getElementById("finClaimBody");
    table.style.overflowY = "auto"; // Enable vertical scrolling
}