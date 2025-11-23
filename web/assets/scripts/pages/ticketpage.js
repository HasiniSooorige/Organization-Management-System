// ------------------Search Ticket--------------------

function ticketSearch() {

    var datefrom = document.getElementById("flatpickr-date").value;
    var dateto = document.getElementById("flatpickr-date1").value;

    fetchDataFromServer(datefrom, dateto);

}

function ticketSearchUser() {

    var datefrom = document.getElementById("flatpickr-date").value;
    var dateto = document.getElementById("flatpickr-date1").value;
    var status = document.getElementById("ticketRequestStatus").value;

    fetchDataFromServerUser(datefrom, dateto, status);

}

function fetchDataFromServer(datefrom, dateto, requestby, status) {
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                const trimmedResponse = xhr.responseText.trim();

                console.log('Received trimmed response:', trimmedResponse);

                try {
                    const responseData = JSON.parse(trimmedResponse);
                    console.log('Parsed data:', responseData);
                    updateTableWithData(responseData);
                } catch (error) {
                    console.error('Error parsing JSON:', error);
                }
            } else {
                console.error('Error fetching data:', xhr.statusText);
            }
        }
    };

    // Modify the URL to match your server's endpoint for fetching data based on parameters
    const url = `../TicketSearch?datefrom=${datefrom}&dateto=${dateto}&requestby=${requestby}&status=${status}`;
    xhr.open('GET', url, true);
    xhr.send();
}

function fetchDataFromServerUser(datefrom, dateto, status) {
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                const trimmedResponse = xhr.responseText.trim();

                console.log('Received trimmed response:', trimmedResponse);

                try {
                    const responseData = JSON.parse(trimmedResponse);
                    console.log('Parsed data:', responseData);
                    updateTableWithDataUser(responseData);
                } catch (error) {
                    console.error('Error parsing JSON:', error);
                }
            } else {
                console.error('Error fetching data:', xhr.statusText);
            }
        }
    };

    // Modify the URL to match your server's endpoint for fetching data based on parameters
    const url = `../UserTicketSearch?datefrom=${datefrom}&dateto=${dateto}&status=${status}`;
    xhr.open('GET', url, true);
    xhr.send();
}



function updateTableWithDataUser(data) {

    var table = document.getElementById('ticketTable');

    // Clear existing rows from the table
    table.innerHTML = '';

    // Add the table headers
    const headerRow = table.insertRow();
    const headers = ['Ticket No', 'Request Date', 'Ticket Category', 'Request Status', 'Action'];
    headers.forEach(headerText => {
        const headerCell = document.createElement('th');
        headerCell.textContent = headerText;
        headerRow.appendChild(headerCell);
    });

    // Add the data rows
    data.forEach(rowData => {
        const row = table.insertRow();
        const rowDataValues = [rowData.enteredDate, rowData.category];

        const idCell = row.insertCell();
        const idContent = `<strong>${rowData.id}</strong>`;
        idCell.innerHTML = idContent;

        rowDataValues.forEach(value => {
            const cell = row.insertCell();
            cell.textContent = value;
        });

        const statusCell = row.insertCell();
        const statusContent = `<span class="badge bg-label-primary me-1">${rowData.status}</span>`;
        statusCell.innerHTML = statusContent;



        // Add the Action column content
        const actionCell = row.insertCell();
        const actionContent = `
        <a class="btn btn-sm btn-outline-success" href="javascript:void(0);" id="${rowData.id}" onclick="openEditModalUser(this.id)"><i class="bx bx-show me-1"></i>View</a>

    `;
        actionCell.innerHTML = actionContent;
    });
}

function updateTableWithData(data) {

    var table = document.getElementById('ticketTable');

    // Clear existing rows from the table
    table.innerHTML = '';

    // Add the table headers
    const headerRow = table.insertRow();
    const headers = ['Ticket No', 'Request Date', 'Request By', 'Ticket Category', 'Request Status', 'Action'];
    headers.forEach(headerText => {
        const headerCell = document.createElement('th');
        headerCell.textContent = headerText;
        headerRow.appendChild(headerCell);
    });

    // Add the data rows
    data.forEach(rowData => {
        const row = table.insertRow();
        const rowDataValues = [rowData.enteredDate, rowData.requestBy, rowData.category];

        const idCell = row.insertCell();
        const idContent = `<strong>${rowData.id}</strong>`;
        idCell.innerHTML = idContent;

        rowDataValues.forEach(value => {
            const cell = row.insertCell();
            cell.textContent = value;
        });

        const statusCell = row.insertCell();
        const statusContent = `<span class="badge bg-label-primary me-1">${rowData.status}</span>`;
        statusCell.innerHTML = statusContent;


        // Add the Action column content
        const actionCell = row.insertCell();
        const actionContent = `
        <a class="btn btn-sm btn-outline-success" href="javascript:void(0);" id="${rowData.id}" onclick="openEditModal(this.id)"><i class="bx bx-show me-1"></i>View</a>
`;
        actionCell.innerHTML = actionContent;
    });
}

// Help ticket response

function submitResponse() {

//    document.getElementById("btn1").disabled = true;
    $("#btn-div").hide();
    $("#add_preloader").show();
    var tid = document.getElementById('tid').value;
    var tmsg = document.getElementById('tmsg').value;
    var tstat = document.getElementById('tstat').value;
    var formfiles = document.getElementById('tuploads');
    var loginid = document.getElementById('loginid').value;
    var trid = document.getElementById('trid').value;
//    var loginid = <%=login.getId; %>;
//    alert(loginid);

    const url = '../TicketResponse';

    const data = new FormData();

    for (var i = 0; i < formfiles.files.length; i++) {
        data.append('files', formfiles.files[i]);
    }

    data.append('tid', tid);
    data.append('tmsg', tmsg);
    data.append('tstat', tstat);
    data.append('loginid', loginid);
    data.append('trid', trid);

    const requestOptions = {
        method: 'POST',
        body: data
    };

    fetch(url, requestOptions)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.text(); // Parse response as text
            })
            .then(data => {
                console.log('Response:', data);
                alert("Response submitted successfully!");
                window.location = './admin-ticket-dashboard.jsp';
            })
            .catch(error => console.error('Error sending POST request:', error));
    $("#add_preloader").hide();
    $("#btn-div").show();
}




// --------------------Edit Ticket--------------------

function openEditModal(buttonId) {
    // Set the button ID in a hidden input inside the modal
    document.getElementById('editModalButtonId').value = buttonId;
    document.getElementById('exampleModalLabel').innerHTML = buttonId;

    // Open the modal
    const editModal = new bootstrap.Modal(document.getElementById('editTicketModal'));
    fetchTicketData(buttonId);
    editModal.show();

}



function fetchTicketData(ticketId) {
    const url = `../ViewTicket?ticketId=${ticketId}`;

    fetch(url)
            .then(response => response.json())
            .then(data => {
                // Update the modal with the fetched data
                console.log(data);
                console.log(data[0]);
                console.log(data[0][0]);
                console.log(data[0][0].enteredDate);
                document.getElementById('createdDate').innerHTML = data[0][0].enteredDate;
                document.getElementById('requestor').innerHTML = data[0][0].requestBy;
                document.getElementById('tcategory').innerHTML = data[0][0].category;
                document.getElementById('description').innerHTML = data[0][0].description;
                document.getElementById('responseBtn').value = ticketId;

                var files = data[0][0].download.split(";");

                const downloadContainer = document.getElementById('downloadContainer');
                downloadContainer.innerHTML = '';


                updateResponseTable(data[1]);

                files.forEach(file => {
                    console.log(file);
                    var fileNames = file.split('/');
                    var filename = fileNames[fileNames.length - 1]
                    console.log(String(file));
                    console.log(filename);

                    const downloadLink = document.createElement('a');
                    downloadLink.href = file; // Replace with the URL of the file
                    downloadLink.download = filename; // Specify the desired filename
                    downloadLink.textContent = 'Download ' + filename; // Set link text

                    const breake = document.createElement('br');


                    downloadContainer.appendChild(downloadLink);
                    downloadContainer.appendChild(breake);
                });


            })
            .catch(error => console.error('Error fetching ticket data:', error));

}


function updateResponseTable(data) {
    var table = document.getElementById('responseTable');

    // Clear existing rows from the table
    table.innerHTML = '';

    // Add the table headers
    const headerRow = table.insertRow();
    const headers = ['Response Date', 'Response', 'Responded By', 'Reply', 'Reply Date', 'Rating'];
    headers.forEach(headerText => {
        const headerCell = document.createElement('th');
        headerCell.textContent = headerText;
        headerRow.appendChild(headerCell);
    });

    // Add the data rows
    data.forEach(rowData => {
        const row = table.insertRow();
        const rowDataValues = [rowData.responddate, rowData.respondcomment, rowData.respondrespondedby, rowData.replycomment, rowData.replydate, rowData.replyrating];

        rowDataValues.forEach(value => {
            const cell = row.insertCell();
            cell.textContent = value;
        });

    });
}




// --------------------User Modal--------------------

function openEditModalUser(buttonId) {
    // Set the button ID in a hidden input inside the modal
    document.getElementById('editModalButtonId').value = buttonId;
    document.getElementById('exampleModalLabel').innerHTML = buttonId;

    // Open the modal
    const editModal = new bootstrap.Modal(document.getElementById('editTicketModal2'));
    fetchTicketDataReply(buttonId);
    editModal.show();

}

function fetchTicketDataReply(ticketId) {
    console.log(ticketId)
    const url = `../ViewTicket?ticketId=${ticketId}`;

    fetch(url)
            .then(response => response.json())
            .then(data => {
                // Update the modal with the fetched data
                console.log(data);
                console.log(data[0]);
                console.log(data[0][0]);
                console.log(data[0][0].enteredDate);
                document.getElementById('createdDate').innerHTML = data[0][0].enteredDate;
                document.getElementById('requestor').innerHTML = data[0][0].requestBy;
                document.getElementById('tcategory').innerHTML = data[0][0].category;
                document.getElementById('description').innerHTML = data[0][0].description;
//                document.getElementById('responseBtn').value = ticketId;
                updateResponseTableReply(data[1], data[0]);

                var files = data[0][0].download.split(";");


                const downloadContainer = document.getElementById('downloadContainer');
                downloadContainer.innerHTML = '';


                files.forEach(file => {
                    console.log(file);
                    var fileNames = file.split('/');
                    var filename = fileNames[fileNames.length - 1]
                    console.log(String(file));
                    console.log(filename);

                    const downloadLink = document.createElement('a');
                    downloadLink.href = file; // Replace with the URL of the file
                    downloadLink.download = filename; // Specify the desired filename
                    downloadLink.textContent = 'Download ' + filename; // Set link text

                    const breake = document.createElement('br');


                    downloadContainer.appendChild(downloadLink);
                    downloadContainer.appendChild(breake);
                });
            })
            .catch(error => console.error('Error fetching ticket data:', error));
}

function updateResponseTableReply(data, link) {
    var table = document.getElementById('responseTable');

    table.innerHTML = '';


    // Add the table headers
    const headerRow = table.insertRow();
    const headers = ['Response Date', 'Response', 'Responded By', 'Reply', 'Reply Date', 'Rating', 'Action'];
    headers.forEach(headerText => {
        const headerCell = document.createElement('th');
        headerCell.textContent = headerText;
        headerRow.appendChild(headerCell);
    });

    // Add the data rows
    data.forEach(rowData => {
        const row = table.insertRow();
        const rowDataValues = [rowData.responddate, rowData.respondcomment, rowData.respondrespondedby, rowData.replycomment, rowData.replydate, rowData.replyrating];

        rowDataValues.forEach(value => {
            const cell = row.insertCell();
            cell.textContent = value;
        });

        if (rowData.replydate === "") {
            const statusCell = row.insertCell();
            const statusContent = `
<form id="ticketReplyForm" action="./user-ht-reply.jsp" method="post">
                                                            <input type="hidden" name="ticketId" id="responseBtn" value="` + rowData.ticketId + `">  <!-- Replace this with the actual ticketId -->
                                                          <!-- Replace this with the actual ticketId -->
                                                <input type="hidden" name="responseId" id="responseBtn" value="` + rowData.respondid + `">            
                                                <input class="btn btn-primary" type="submit" value="Reply">
                                                        </form>
            `;
            statusCell.innerHTML = statusContent;
        }




    });


}


function submitReply() {

    $("#btn-div").hide();
    $("#add_preloader").show();
    var replyMsg = document.getElementById("replyMsg").value;
    var ticketNo = document.getElementById("ticketId").value;
    var responseId = document.getElementById("responseId").value;
    var formfiles = document.getElementById("formFileMultiple");


    var rating = $("#starRating").rateYo("option", "rating"); //returns 50
    if (replyMsg == "") {
        alert("Reply Message Cannot Be Null!");
        $("#btn-div").show();
        $("#add_preloader").hide();
    } else {
        var confirm_msg = confirm("Do you want to reply?");
        if (confirm_msg) {
            console.log(replyMsg);
            console.log(ticketNo);
            console.log(rating);
            var formData = {

                'replyMessage': $('#replyMsg').val(),
                'ticketId': $('#ticketId').val(),
                'responseId': $('#responseId').val(),
                'rating': rating,
            };




            $.ajax({
                type: 'POST', // define the type of HTTP verb we want to use (POST for our form)
                url: '../AddTicketReply', // the url where we want to POST
                data: formData, // our data object                    
                dataType: 'json', // what type of data do we expect back from the server
                encode: true
            })
                    // using the done promise callback
                    .done(function (data) {
                        // log data to the console so we can see
                        alert(data);
                        $("#btn-div").show();
                        $("#add_preloader").hide();
                        window.location = "user-ticket-page.jsp";
                    }

                    );

            $("#btn-div").show();
            $("#add_preloader").hide();
            window.location = "user-ticket-page.jsp";
        }
    }

}

function ticketImgPreviewImage(id) {

    $.post('../model/model-preview-ticket.jsp', {
        id: id
    }, function (data) {

    });


}



        