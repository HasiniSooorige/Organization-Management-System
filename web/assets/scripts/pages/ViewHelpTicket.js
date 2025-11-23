function viewHelpAttachDocs(attachDocs) {
    const fileName = attachDocs;
    console.log(fileName);

    var servletURL = '../HelpTicketDocumentOpen';
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

function newResponseModel() {
    $("#newResponseModel").modal('show');
}

function newReplyOpen() {
    $("#newReplyModel").modal('show');
}

function closeResponseModel() {
    $("#newResponseModel").modal('hide');
}

function closeReplyModel() {
    $("#newReplyModel").modal('hide');
}

function helpResDoc() {

    let docPreview = document.getElementById("imagePreview");
    let empDocument = document.getElementById("helpresDocPreview");
    let inputFile = document.getElementById("helpres");

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

function helpTicketResponse() {
    var message = document.getElementById("message").value;

    if (message === "") {
        document.getElementById("messageErrNotify").removeAttribute("hidden");
        document.getElementById("message").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("messageErrNotify").setAttribute("hidden", "");
        document.getElementById("message").style.borderColor = '';
    }
}

function responseDocView(documentName) {


    const fileName = documentName;
    console.log(fileName);

    var servletURL = '../ResponseChatDocumentOpen';
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

function replyDocView(documentName) {


    const fileName = documentName;
    console.log(fileName);

    var servletURL = '../ReplyChatDocumentOpen';
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