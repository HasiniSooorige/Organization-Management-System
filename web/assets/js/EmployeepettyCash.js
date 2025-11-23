async function viewDocuments(id) {
    const viewDocumentsDetails = {
        id: id,
    };
    try {
        const response = await fetch("../loadViewAllAttachmentsModel", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(viewDocumentsDetails),
        });
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const data = await response.json();
        const attachmentsDiv = document.getElementById("loadAttachments");
        attachmentsDiv.innerHTML = "";
        let totAmount = 0;
        let numberOfAttachments = 0;
        data.documents.forEach(document => {
            totAmount += document.totAmount;
            numberOfAttachments = document.numberOfAttachments;
            const documentBody = `
                <div class="col-12 col-lg-4 mt-2" onclick="singleattachementModalView('` + document.amount + `','` + document.expense_description + `','` + document.doc + `');">
                    <div class="row ms-1 me-1">
                        <img src="../pettyCashWalletimgs/` + document.doc + `" class="img-fluid border-1 border-label-primary"  style="height:150px;"/>
                    </div>
                    <div class="row ms-1 me-1">
                        <span class="bg-primary p-1 text-white" style="opacity: 0.4;">Rs.` + document.amount + `</span>
                    </div>
                </div>
            `;
            attachmentsDiv.innerHTML += documentBody;
        });
        document.getElementById("numberOfAttachments").innerHTML = "Number of Attachments: " + numberOfAttachments;
        document.getElementById("getAllAmount").innerHTML = "Rs." + totAmount;
    } catch (error) {
        alert(error);
    }
}
function singleattachementModalView(amount, expense_description, image) {
    document.getElementById("singleattachementModalAmount").innerHTML = amount;
    document.getElementById("singleattachementModalExpenseDescription").innerHTML = expense_description;
    document.getElementById("singleattachementModalImage").setAttribute("src", "../pettyCashWalletimgs/" + image + "");
    const modalToggle = new bootstrap.Modal(document.getElementById('singleattachementModalToggle'));
    modalToggle.show();
}
function setTotal() {
    const table = document.getElementById("table");
    const rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    let total = 0;
    for (let i = 0; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName("td");
        const amountText = cells[1].textContent.trim();
        const amountValue = parseFloat(amountText.replace("Rs.", "").replace(/[^\d.]/g, ''));
        if (!isNaN(amountValue)) {
            total += amountValue;
        }
    }
    document.getElementById("setTotal").value = "Rs." + total.toFixed(2);
}
function validateNumericInput(input) {
    input.value = input.value.replace(/[^0-9.]/g, '');
    // Ensure there's only one dot in the input
    const dotCount = (input.value.match(/\./g) || []).length;
    if (dotCount > 1) {
        input.value = input.value.replace(/\.+$/, '');
    }

    // Limit to two decimal places
    const parts = input.value.split('.');
    if (parts.length > 1 && parts[1].length > 2) {
        parts[1] = parts[1].substring(0, 2);
        input.value = parts.join('.');
    }
}
function readDoc(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.readAsDataURL(input.files[0]);
        document.getElementById("updoc").classList.add("btn-yellow");
        document.getElementById("updoc").innerHTML = "<i class='fa fa-cloud-upload' aria-hidden='true'></i>&nbsp;Update Attachment";
    } else {
        document.getElementById("updoc").classList.remove("btn-yellow");
        document.getElementById("updoc").innerHTML = "<i class='fa fa-cloud-upload' aria-hidden='true'></i>&nbsp;Upload Attachment";
    }
}

function addRecord() {
    let getExpenseDescription = document.getElementById("getExpenseDescription");
    let getAmountForAddRecord = document.getElementById("getAmountForAddRecord");
    let filesInput = document.getElementById("files");
    if (getExpenseDescription.value === "") {
        alert("Please Add Expense Description");
        getAmountForAddRecord.classList.remove("updated-border-danger");
        getExpenseDescription.classList.add("updated-border-danger");
        document.getElementById("updoc").classList.remove("btn-red");
    } else if (getAmountForAddRecord.value === "") {
        alert("Please Add Amount");
        getAmountForAddRecord.classList.add("updated-border-danger");
        getExpenseDescription.classList.remove("updated-border-danger");
        document.getElementById("updoc").classList.remove("btn-red");
    } else if (filesInput.files.length === 0) {
        alert("Please Upload Attachment");
        getAmountForAddRecord.classList.remove("updated-border-danger");
        getExpenseDescription.classList.remove("updated-border-danger");
        document.getElementById("updoc").classList.add("btn-red");
    } else {
        getAmountForAddRecord.classList.remove("updated-border-danger");
        getExpenseDescription.classList.remove("updated-border-danger");
        document.getElementById("updoc").classList.remove("btn-red");
        var selectedFile = filesInput.files[0];
        var renamedFile = renameSelectedFile(selectedFile);
        const newRow = document.getElementById("table").getElementsByTagName("tbody")[0].insertRow();
        const ExpenseDescriptionCell = newRow.insertCell();
        const AmountCell = newRow.insertCell();
        const AttachmentCell = newRow.insertCell();
        ExpenseDescriptionCell.textContent = getExpenseDescription.value;
        AmountCell.textContent = getAmountForAddRecord.value;
        AttachmentCell.style.fontSize = "0px";
        AttachmentCell.textContent = renamedFile.name;
        const imgElement = document.createElement("img");
        imgElement.src = URL.createObjectURL(renamedFile);
        imgElement.className = "img-fluid";
        imgElement.style.width = "80px";
        imgElement.style.height = "80px";
        AttachmentCell.appendChild(imgElement);

        if (selectedFile) {
            //                                                            uploadFile(selectedFile);
            //                                                            loadedImages.push(selectedFile);
            loadedImages.push(renamedFile);
        } else {
            console.log('No file selected.');
        }
        setTotal();
        getExpenseDescription.value = "";
        getAmountForAddRecord.value = "";
        filesInput.value = "";
        document.getElementById("updoc").classList.remove("btn-yellow");
        document.getElementById("updoc").innerHTML = "<i class='fa-solid fa-upload'></i>&nbsp;Upload Attachment";
        //                                                        var openModalButton = document.querySelector('[data-bs-target="#exampleModalToggle"]');
        //                                                        openModalButton.click();
        closeviewAddRecordModel();
        ViewSettlementModel();
    }
}
function renameSelectedFile(file) {
    // Generate a unique name based on timestamp and random number
    const uniqueName = Date.now() + '-' + Math.random().toString(36).substring(7);

    // Get the file extension
    const fileExtension = file.name.split('.').pop();

    // Create a new File object with the updated name
    const renamedFile = new File([file], uniqueName + '.' + fileExtension, {
        type: file.type,
        lastModified: file.lastModified
    });

    return renamedFile;
}

const loadedImages = [];
function loadImg() {
    let table = document.getElementById("table");
    let rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    if (loadedImages.length == rows.length) {
        for (let i = 0; i < loadedImages.length; i++) {
            const selectedFile = loadedImages[i];
            const url = "../PettyCashImgUploader";
            const formData = new FormData();
            formData.append("file", selectedFile);
            fetch(url, {
                method: "POST",
                body: formData
            })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error("Network response was not ok");
                        }
                        return response.json();
                    })
                    .then(data => {
                        console.log("Response from servlet:", data);
                    })
                    .catch(error => {
                        console.error("There was a problem with the fetch operation:", error);
                    });
        }
    } else {
        alert("Please update your settlement attachments");
    }
}
async function sendForReview(id) {
    let table = document.getElementById("table");
    let rows = table.getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    if (loadedImages.length == rows.length) {
        let description = document.getElementById("getDescription").value;
        let settlmentid = "";
        if (id != null) {
            settlmentid += id;
        }
        let data = [];
        for (let i = 0; i < rows.length; i++) {
            let row = rows[i];
            let cells = row.getElementsByTagName("td");
            let rowData = {
                expenseDescription: cells[0].textContent,
                amount: cells[1].textContent,
                attachment: cells[2].textContent,
            };
            data.push(rowData);
        }

        let payload = {
            description: description,
            data: data,
            settlmentID: settlmentid,
        };
        try {
            const response = await fetch("../SendtoReview", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(payload),
            });
            if (response.ok) {
                const responseData = await response.json();

                if (responseData.status === "Please enter a Description") {
                    document.getElementById("getDescription").classList.add("updated-border-danger");
                    table.classList.remove("updated-border-danger");
                    alert(responseData.status);
                } else if (responseData.status === "Please Add Records") {
                    document.getElementById("getDescription").classList.remove("updated-border-danger");
                    table.classList.add("updated-border-danger");
                    alert(responseData.status);
                } else if (responseData.status === "success") {
                    loadImg();
                    alert(responseData.status);
                    location.reload();
                } else {
                    alert(responseData.status);
                }
            } else {
                alert("Request failed with status: " + response.status);
            }
        } catch (error) {
            alert("An error occurred: " + error.message);
        }
    } else {
        alert("Please update your settlement attachments");
    }
}

const table = document.getElementById("table").getElementsByTagName("tbody")[0];
const clickHandler = function (event) {
    const clickedRow = event.target.closest('tr');
    if (clickedRow) {
        const rowData = Array.from(clickedRow.cells).map(cell => cell.textContent);
        clickedRow.remove();
        for (let i = 0; i < loadedImages.length; i++) {
            if (loadedImages[i].name === rowData[2]) {
                loadedImages.splice(i, 1);
                break;
            }
        }
        setTotal();
    }
};
table.addEventListener("click", clickHandler);


async function getRejectedAction(id, description, amount) {

    let Description = document.getElementById("getDescription");
    Description.classList.remove("updated-border-danger");
    document.getElementById("table").classList.remove("updated-border-danger");
    document.getElementById("SettlementModalToggleHeader").innerHTML = "Update Settlement";
    Description.value = description;
    document.getElementById("sendtoreview").removeAttribute("onclick");
    document.getElementById("sendtoreview").setAttribute("onclick", "sendForReview('" + id + "')");

    let payload = {
        settlementID: id,
    };

    try {
        const response = await fetch("../GetRejectedSettlementDetails", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(payload),
        });

        if (response.ok) {
            const responseData = await response.json();
            var dataArray = responseData.data; // Use responseData directly
            const tableBody = document.getElementById("table").getElementsByTagName("tbody")[0];
            tableBody.innerHTML = "";
            for (var i = 0; i < dataArray.length; i++) {
                var dataObject = dataArray[i];
                const newRow = document.getElementById("table").getElementsByTagName("tbody")[0].insertRow();
                const ExpenseDescriptionCell = newRow.insertCell();
                const AmountCell = newRow.insertCell();
                const AttachmentCell = newRow.insertCell();
                ExpenseDescriptionCell.textContent = dataObject.exDescription;
                AmountCell.textContent = dataObject.amount;
                AttachmentCell.style.fontSize = "0px";
                AttachmentCell.textContent = dataObject.attachmentName; // Assuming you have the attachment name in your JSON
                const imgElement = document.createElement("img");
                imgElement.src = "../pettyCashWalletimgs/" + dataObject.img;
                imgElement.className = "img-fluid";
                imgElement.style.width = "80px";
                imgElement.style.height = "80px";
                AttachmentCell.appendChild(imgElement);


            }
            setTotal();
            ViewSettlementModel();
        } else {
            alert("Request failed with status: " + response.status);
        }
    } catch (error) {
        alert("An error occurred: " + error.message);
    }
}
function ViewSettlementModel() {
    const modalToggle = new bootstrap.Modal(document.getElementById('SettlementModalToggle'));
    modalToggle.show();
}
function refreshSettlementModelTable() {
    let Description = document.getElementById("getDescription");
    let table = document.getElementById("table");
    Description.classList.remove("updated-border-danger");
    table.classList.remove("updated-border-danger");
    document.getElementById("SettlementModalToggleHeader").innerHTML = "New Settlement";
    Description.value = "";
    const tableBody = table.getElementsByTagName("tbody")[0];
    tableBody.innerHTML = "";
    setTotal();
    document.getElementById("sendtoreview").removeAttribute("onclick");
    document.getElementById("sendtoreview").setAttribute("onclick", "sendForReview()");
}
function closeviewAddRecordModel() {
    $('#viewAddRecordModel').modal('hide');
}
function viewAddRecordModel() {
    const modalToggle = new bootstrap.Modal(document.getElementById('viewAddRecordModel'));
    $('#SettlementModalToggle').modal('hide');

    modalToggle.show();
}