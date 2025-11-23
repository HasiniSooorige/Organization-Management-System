function viewDisbursement() {
    document.getElementById("Cash_Settlements").classList.add("d-none");
    document.getElementById("Disbursement").classList.remove("d-none");
}
function viewCashSettlements() {
    document.getElementById("Cash_Settlements").classList.remove("d-none");
    document.getElementById("Disbursement").classList.add("d-none");
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
async function addnewDisbursement() {
    let emp = document.getElementById("employee");
    let amount = document.getElementById("amount");
    emp.classList.remove("updated-border-danger");
    amount.classList.remove("updated-border-danger");
    const disbursementDetails = {
        emp: emp.value,
        amount: amount.value,
    };
    try {
        const response = await fetch("../AddnewDisbursement", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(disbursementDetails),
        });
        const data = await response.text();
        let resp = JSON.parse(data);
//                                                        alert(resp);
        if (resp.status == "Please Select Employee") {
            alert(resp.status);
            emp.classList.remove("border-0");
            emp.classList.add("updated-border-danger");
        } else if (resp.status == "Please Add amount") {
            alert(resp.status);
            amount.classList.add("updated-border-danger");
        } else if (resp.status == "invalid amount") {
            alert(resp.status);
            amount.classList.add("updated-border-danger");
        } else if (resp.status == "Added new Disbursement" || resp.status == "Available allocations were successfully updated") {
            emp.classList.remove("updated-border-danger");
            amount.classList.remove("updated-border-danger");
            emp.value = "Select";
            amount.value = "";
//                                                            loadDashboard();
            location.reload();
            alert(resp.status);
        } else {
            alert(resp.status);
        }
    } catch (error) {
        alert(error);
    }
}
function loadDashboard() {

    fetch('loadDashboard.jsp')
            .then(response => response.text())
            .then(data => {
                document.getElementById("dashboard").innerHTML = data;
            })
            .catch(error => {
                console.error('Error:', error);
            });
}
async function Approve(id, action) {
    let getAction;
    if (action === "approve") {
        getAction = 2;
    } else {
        getAction = 3;
    }

    const SettlementReview = {
        action: getAction,
        id: id,
        comment: document.getElementById("Addcomment").value,
    };
    try {
        const response = await fetch("../SettlementReview", {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(SettlementReview),
        });
        const data = await response.text();
        let resp = JSON.parse(data);
        if (resp.status == "Approved") {
            alert(resp.status);
            location.reload();
        } else if (resp.status == "Please add a Comment") {
            alert(resp.status);
            document.getElementById("Addcomment").classList.add("updated-border-danger");
        } else if (resp.status == "Rejected") {
            alert(resp.status);
            location.reload();
        } else {
            alert(resp.status);
        }
//                                                        alert(resp.status);
//                                                        location.reload();
    } catch (error) {
        alert(error);
    }
}
function setRejectDetails(id, action) {
    document.getElementById("rejectModelbtn").addEventListener("click", function () {
        Approve(id, action);
    });
}
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
                        <img src="../pettyCashWalletimgs/` + document.doc + `" class="img-fluid border-1 border-label-primary" style="height:150px;"/>
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
