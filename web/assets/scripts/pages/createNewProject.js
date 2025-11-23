/* global URL */

function validate_nic(nic) {
    var cnic_no_regex = new RegExp('^[0-9+]{9}[vV|xX]$');
    var new_cnic_no_regex = new RegExp('^[0-9+]{12}$');
    if (nic.length == 10) {
        return true;
    } else if (nic.length == 12 && new_cnic_no_regex.test(nic)) {
        return true;
    } else {
        return false;
    }

}

function validate_phone(phone) {
    var phone_no_regex = new RegExp('^[0-9]+$');
    if (phone.length == 10 && phone_no_regex.test(phone)) {
        return true;
    } else {
        return false;
    }

}

function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    if (re.test(email)) {
        return true;
    } else {
        return false;
    }
}

function saveNewProject() {

    var tableBody = document.getElementById('empTableBody');
    var rows = tableBody.getElementsByTagName('tr');

    var proName = $('#projectname').val();
    var proDesc = document.getElementById("projectDescription").value;
    var orgName = document.getElementById("organization");
    var fileProject = document.getElementById("fileProject");

    if (proName === "") {
        document.getElementById("proNameErrNotify").removeAttribute("hidden");
        document.getElementById("projectname").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("proNameErrNotify").setAttribute("hidden", "");
        document.getElementById("projectname").style.borderColor = '';
    }
    if (proDesc === "") {
        document.getElementById("proDescripErrNotify").removeAttribute("hidden");
        document.getElementById("projectDescription").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("proDescripErrNotify").setAttribute("hidden", "");
        document.getElementById("projectDescription").style.borderColor = '';
    }
    if (rows.length <= 0) {
        document.getElementById("emptableErrNotify").removeAttribute("hidden");
        document.getElementById("empName").style.borderColor = 'red';
        document.getElementById("projectrole").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emptableErrNotify").setAttribute("hidden", "");
        document.getElementById("empName").style.borderColor = '';
        document.getElementById("projectrole").style.borderColor = '';
    }
    if (orgName.value === "") {
        document.getElementById("clientNameErrNotify").removeAttribute("hidden");
        orgName.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientNameErrNotify").setAttribute("hidden", "");
        orgName.style.borderColor = '';
    }
    if (!fileProject || fileProject.files.length === 0) {
        document.getElementById("projectLogoError").removeAttribute("hidden");
        document.getElementById("fileProject").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("projectLogoError").setAttribute("hidden", "");
        document.getElementById("fileProject").style.borderColor = '';
    }
    return true;

}

function addClientModal() {
    $("#addClientModal").modal('show');
}

function checkDuplicateEmp() {

    var emp = document.getElementById("empName");
    var valueEmp = emp.value;

    var empRole = document.getElementById("projectrole");
    var valueEmpRole = empRole.value;

    const table = document.getElementById("allEmpTable");
    const columnIndex = 0;
    const columnIndexRole = 2;

    const columnValues = [];
    const columnValuesRole = [];

    for (let i = 1; i < table.rows.length; i++) {
        const cellValue = table.rows[i].cells[columnIndex].textContent || table.rows[i].cells[columnIndex].innerText;
        const cellValueRole = table.rows[i].cells[columnIndexRole].textContent || table.rows[i].cells[columnIndexRole].innerText;

        columnValues.push(cellValue);
        columnValuesRole.push(cellValueRole);
    }
    console.log("Column 0 Values: " + columnValues);
    console.log("Column 2 Values: " + columnValuesRole);

    const buttonEmp = document.getElementById("saveEmpRole");

    if (columnValues.includes(valueEmp) && columnValuesRole.includes(valueEmpRole)) {
        document.getElementById("empalreadyexist").removeAttribute("hidden");
        buttonEmp.disabled = true;
        return false;
    } else {
        document.getElementById("empalreadyexist").setAttribute("hidden", "");
        buttonEmp.disabled = false;
        return true;
    }
}

function addNewRowEmpRole() {

    event.preventDefault();

    var emp = document.getElementById("empName");
    var valueEmp = emp.value;
    var textEmp = emp.options[emp.selectedIndex].text;

    var role = document.getElementById("projectrole");
    var valueRole = role.value;
    var textRole = role.options[role.selectedIndex].text;

    if (emp.value === "") {
        document.getElementById("empNameErrNotify").removeAttribute("hidden");
        emp.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("empNameErrNotify").setAttribute("hidden", "");
        emp.style.borderColor = '';
    }

    if (role.value === "") {
        document.getElementById("proRoleErrNotify").removeAttribute("hidden");
        role.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("proRoleErrNotify").setAttribute("hidden", "");
        role.style.borderColor = '';
    }

    $('#allEmpTable').show();

    var newRow = '<tr>' +
            '<td hidden><input type="hidden" name="valueEmp[]" value="' + valueEmp + '">' + valueEmp + '</td>' +
            '<td><input type="hidden" name="textEmp[]" value="' + textEmp + '">' + textEmp + '</td>' +
            '<td hidden><input type="hidden" name="valueRole[]" value="' + valueRole + '">' + valueRole + '</td>' +
            '<td><input type="hidden" name="textRole[]" value="' + textRole + '">' + textRole + '</td>' +
            '<td><input type="button" class="btn rounded-pill btn-outline-danger" onclick="removeProjectEmp(this);" value="Remove"/>'
    '</tr>';

    $('#empTableBody').append(newRow);
    document.getElementById("emptableErrNotify").setAttribute("hidden", "");
    $('#tableIntakeRow').css('display', 'block');

    document.getElementById("empName").selectedIndex = 0;
    document.getElementById("projectrole").selectedIndex = 0;

}

function removeProjectEmp(rowId) {

    var tbleRowId = rowId.parentNode.parentNode;

    var table = document.getElementById("allEmpTable");
    table.deleteRow(tbleRowId.rowIndex);


}

function imageUploader() {

    let inputFile = document.getElementById("fileProject");
    let profilePic = document.getElementById("uploadedImage");
    let proLogoViewMainDiv = document.getElementById("proLogoViewMainDiv");

    inputFile.onchange = function () {
        try {
            profilePic.src = URL.createObjectURL(inputFile.files[0]);
            console.log("File: " + this.value);
            imagename = this.value.split('\\').pop().split('/').pop();
            console.log(imagename);
            profilePic.style.width = "350px";
            profilePic.style.height = "300px";
        } catch (error) {
            console.error("Error loading image:", error);
        }
        proLogoViewMainDiv.style.display = 'block';
    };

}

function closeclientData() {
    $("#addClientModal").modal('hide');
}

function saveNewClients() {

    var cname = $('#cname').val();
    var country = document.getElementById("country");
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();
    var cEmail = $('#cEmail').val();
    var cMobile = $('#cMobile').val();
    var cFaxNo = $('#cFaxNo').val();
    var clientLogo = document.getElementById("file1");

    var clientFirstName = $('#clientFirstName').val();
    var clientLastName = $('#clientLastName').val();
    var clientNic = $('#clientNic').val();
    var clientemail = $('#clientemail').val();
    var companycontactNo = $('#companycontactNo').val();
    var clientMobileNo = $('#clientMobileNo').val();

    if (cname === "") {
        document.getElementById("nameErrNotify").removeAttribute("hidden");
        document.getElementById("cname").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("nameErrNotify").setAttribute("hidden", "");
        document.getElementById("cname").style.borderColor = '';
    }
    if (country.value === "") {
        document.getElementById("countryErrNotify").removeAttribute("hidden");
        document.getElementById("country").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("countryErrNotify").setAttribute("hidden", "");
        document.getElementById("country").style.borderColor = '';
    }
    if (address1 === "") {
        document.getElementById("address1ErrNotify").removeAttribute("hidden");
        document.getElementById("address1").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("address1ErrNotify").setAttribute("hidden", "");
        document.getElementById("address1").style.borderColor = '';
    }
    if (address2 === "") {
        document.getElementById("address2ErrNotify").removeAttribute("hidden");
        document.getElementById("address2").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("address2ErrNotify").setAttribute("hidden", "");
        document.getElementById("address2").style.borderColor = '';
    }
    if (address3 === "") {
        document.getElementById("address3ErrNotify").removeAttribute("hidden");
        document.getElementById("address3").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("address3ErrNotify").setAttribute("hidden", "");
        document.getElementById("address3").style.borderColor = '';
    }
    if (cEmail === "") {
        document.getElementById("emaildataErrNotify").removeAttribute("hidden");
        document.getElementById("cEmail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emaildataErrNotify").setAttribute("hidden", "");
        document.getElementById("cEmail").style.borderColor = '';
    }
    if (!validateEmail(cEmail)) {
        document.getElementById("emaildataCorrectErrNotify").removeAttribute("hidden");
        document.getElementById("cEmail").style.borderColor = 'red';
        return false;
    } else {

        document.getElementById("emaildataCorrectErrNotify").setAttribute("hidden", "");
        document.getElementById("cEmail").style.borderColor = '';
    }
    if (cMobile === "") {
        document.getElementById("cMobileErrNotify").removeAttribute("hidden");
        document.getElementById("cMobile").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("cMobileErrNotify").setAttribute("hidden", "");
        document.getElementById("cMobile").style.borderColor = '';
    }
    if (!validate_phone(cMobile)) {
        document.getElementById("cMobileCorrectErrNotify").removeAttribute("hidden");
        document.getElementById("cMobile").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("cMobileCorrectErrNotify").setAttribute("hidden", "");
        document.getElementById("cMobile").style.borderColor = '';
    }
    if (cFaxNo === "") {
        document.getElementById("faxdataErrNotify").removeAttribute("hidden");
        document.getElementById("cFaxNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("faxdataErrNotify").setAttribute("hidden", "");
        document.getElementById("cFaxNo").style.borderColor = '';
    }
    if (!validate_phone(cFaxNo)) {
        document.getElementById("faxdataCorrectErrNotify").removeAttribute("hidden");
        document.getElementById("cFaxNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("faxdataCorrectErrNotify").setAttribute("hidden", "");
        document.getElementById("cFaxNo").style.borderColor = '';
    }
    if (!clientLogo || clientLogo.files.length === 0) {
        document.getElementById("clientDocError").removeAttribute("hidden");
        document.getElementById("file1").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientDocError").setAttribute("hidden", "");
        document.getElementById("file1").style.borderColor = '';
    }

    if (clientFirstName === "") {
        document.getElementById("clientFirstNameError").removeAttribute("hidden");
        document.getElementById("clientFirstName").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientFirstNameError").setAttribute("hidden", "");
        document.getElementById("clientFirstName").style.borderColor = '';
    }
    if (clientLastName === "") {
        document.getElementById("clientLastNameError").removeAttribute("hidden");
        document.getElementById("clientLastName").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientLastNameError").setAttribute("hidden", "");
        document.getElementById("clientLastName").style.borderColor = '';
    }
    if (clientNic === "") {
        document.getElementById("clientNicError").removeAttribute("hidden");
        document.getElementById("clientNic").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientNicError").setAttribute("hidden", "");
        document.getElementById("clientNic").style.borderColor = '';
    }
    if (!validate_nic(clientNic)) {
        document.getElementById("clientNicinvalidError").removeAttribute("hidden");
        document.getElementById("clientNic").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientNicinvalidError").setAttribute("hidden", "");
        document.getElementById("clientNic").style.borderColor = '';
    }
    if (clientemail === "") {
        document.getElementById("clientemailError").removeAttribute("hidden");
        document.getElementById("clientemail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientemailError").setAttribute("hidden", "");
        document.getElementById("clientemail").style.borderColor = '';
    }
    if (!validateEmail(clientemail)) {
        document.getElementById("clientemailInvalidError").removeAttribute("hidden");
        document.getElementById("clientemail").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientemailInvalidError").setAttribute("hidden", "");
        document.getElementById("clientemail").style.borderColor = '';
    }
    if (companycontactNo === "") {
        document.getElementById("companycontactNoError").removeAttribute("hidden");
        document.getElementById("companycontactNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("companycontactNoError").setAttribute("hidden", "");
        document.getElementById("companycontactNo").style.borderColor = '';
    }
    if (!validate_phone(companycontactNo)) {
        document.getElementById("companycontactNoinValidError").removeAttribute("hidden");
        document.getElementById("companycontactNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("companycontactNoinValidError").setAttribute("hidden", "");
        document.getElementById("companycontactNo").style.borderColor = '';
    }
    if (clientMobileNo === "") {
        document.getElementById("clientMobileNoErrr").removeAttribute("hidden");
        document.getElementById("clientMobileNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientMobileNoErrr").setAttribute("hidden", "");
        document.getElementById("clientMobileNo").style.borderColor = '';
    }
    if (!validate_phone(clientMobileNo)) {
        document.getElementById("clientMobileNoinValidErrr").removeAttribute("hidden");
        document.getElementById("clientMobileNo").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("clientMobileNoinValidErrr").setAttribute("hidden", "");
        document.getElementById("clientMobileNo").style.borderColor = '';
    }
    return true;
}

function clientlogoView() {

    let inputFileclient = document.getElementById("file1");
    let logoViewMainDiv = document.getElementById("logoViewMainDiv");
    let clientPic = document.getElementById("viewClientImage");

    inputFileclient.onchange = function () {
        try {
            clientPic.src = URL.createObjectURL(inputFileclient.files[0]);
            console.log("File: " + this.value);
            imagename = this.value.split('\\').pop().split('/').pop();
            console.log(imagename);
            console.log("Image URL: " + URL.createObjectURL(inputFileclient.files[0]));
            clientPic.style.width = "250px";
            clientPic.style.height = "200px";
        } catch (error) {
            console.error("Error loading image:", error);
        }
        logoViewMainDiv.style.display = 'block';
    };

}