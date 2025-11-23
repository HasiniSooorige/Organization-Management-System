/* global Swal */

function submitTicket(type, userId) {

    var log_type = type;

    var tcategory = document.getElementById('ticketCategory').value;
    var project = document.getElementById('projectSelect').value;
    var description = document.getElementById('description').value;
    var formfiles = document.getElementById('tfiles');

    if (log_type === "clent") {
        var requestor = document.getElementById('requestor').value;

        if (tcategory === '') {
            document.getElementById("ticketCategoryError").removeAttribute("hidden");
            document.getElementById("ticketCategory").style.borderColor = 'red';
            return false;
        } else {
            document.getElementById("ticketCategoryError").setAttribute("hidden", "");
            document.getElementById("ticketCategory").style.borderColor = '';
        }

        if (project === '') {
            document.getElementById("projectSelectClienterror").removeAttribute("hidden");
            document.getElementById("projectSelect").style.borderColor = 'red';
            return false;
        } else {
            document.getElementById("projectSelectClienterror").setAttribute("hidden", "");
            document.getElementById("projectSelect").style.borderColor = '';
        }

        if (requestor === '') {
            document.getElementById("requesterError").removeAttribute("hidden");
            document.getElementById("requestor").style.borderColor = 'red';
            return false;
        } else {
            document.getElementById("requesterError").setAttribute("hidden", "");
            document.getElementById("requestor").style.borderColor = '';
        }

        if (description === '') {
            document.getElementById("descriptionerror").removeAttribute("hidden");
            document.getElementById("description").style.borderColor = 'red';
            return false;
        } else {
            document.getElementById("descriptionerror").setAttribute("hidden", "");
            document.getElementById("description").style.borderColor = '';
        }

        if (formfiles.files.length === 0) {
            document.getElementById("documenterror").removeAttribute("hidden");
            document.getElementById("tfiles").style.borderColor = 'red';
            return false;
        } else {
            document.getElementById("documenterror").setAttribute("hidden", "");
            document.getElementById("tfiles").style.borderColor = '';
        }

    }

    if (log_type === "emp") {
        if (tcategory != 4) {
            if (tcategory === '') {
                document.getElementById("ticketCategoryError").removeAttribute("hidden");
                document.getElementById("ticketCategory").style.borderColor = 'red';
                return false;
            } else {
                document.getElementById("ticketCategoryError").setAttribute("hidden", "");
                document.getElementById("ticketCategory").style.borderColor = '';
            }

            if (project === '') {
                document.getElementById("projectSelecterror").removeAttribute("hidden");
                document.getElementById("projectSelect").style.borderColor = 'red';
                return false;
            } else {
                document.getElementById("projectSelecterror").setAttribute("hidden", "");
                document.getElementById("projectSelect").style.borderColor = '';
            }

            if (description === '') {
                document.getElementById("descriptionerror").removeAttribute("hidden");
                document.getElementById("description").style.borderColor = 'red';
                return false;
            } else {
                document.getElementById("descriptionerror").setAttribute("hidden", "");
                document.getElementById("description").style.borderColor = '';
            }

            if (formfiles.files.length === 0) {
                document.getElementById("documenterror").removeAttribute("hidden");
                document.getElementById("tfiles").style.borderColor = 'red';
                return false;
            } else {
                document.getElementById("documenterror").setAttribute("hidden", "");
                document.getElementById("tfiles").style.borderColor = '';
            }

        } else {
            if (tcategory === '') {
                document.getElementById("ticketCategoryError").removeAttribute("hidden");
                document.getElementById("ticketCategory").style.borderColor = 'red';
                return false;
            } else {
                document.getElementById("ticketCategoryError").setAttribute("hidden", "");
                document.getElementById("ticketCategory").style.borderColor = '';
            }
            if (description === '') {
                document.getElementById("descriptionerror").removeAttribute("hidden");
                document.getElementById("description").style.borderColor = 'red';
                return false;
            } else {
                document.getElementById("descriptionerror").setAttribute("hidden", "");
                document.getElementById("description").style.borderColor = '';
            }
        }
    }

    var formData = new FormData();

    for (var i = 0; i < formfiles.files.length; i++) {
        formData.append('files', formfiles.files[i]);
    }
    formData.append('ticketCategory', tcategory);
    formData.append('project', project);
    formData.append('requestor', requestor);
    formData.append('description', description);
    formData.append('type', type);
    formData.append('loginid', userId);

    var xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                if (xhr.responseText == "200") {
                    Swal.fire({
                        title: 'Help Ticket Successfully Uploaded.',
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    }).then(function () {
                        location.reload();
                    });
                } else if (xhr.responseText == "400") {
                    Swal.fire({
                        title: 'Error Uploading the Help Ticket. Please try again.',
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }

            }
        }

    };
    xhr.open('POST', '../NewTicket', true);
    xhr.send(formData);
}


function categorySelect() {
    var category = document.getElementById("ticketCategory").value;
    if (category == 4) {

        $("#add_alert_pro").show();
        $("#ProjectAstro").hide();
        $("#docAstro").hide();
    } else {
        $("#add_alert_pro").hide();
        $("#ProjectAstro").show();
        $("#docAstro").show();
    }

}

function ticketImageView() {
    let docPreview = document.getElementById("imagePreview");
    let empDocument = document.getElementById("empDocPreview");
    let inputFile = document.getElementById("tfiles");

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