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


    if (proName === "") {
        document.getElementById("proNameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("proNameErrNotify").setAttribute("hidden", "");
    }

    if (proDesc === "") {
        document.getElementById("proDescripErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("proDescripErrNotify").setAttribute("hidden", "");
    }

    if (rows.length <= 0) {
        document.getElementById("emptableErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("emptableErrNotify").setAttribute("hidden", "");
    }

    if (orgName.value === "") {
        document.getElementById("clientNameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientNameErrNotify").setAttribute("hidden", "");
    }

    if (!validateFileSize()) {
        return;
    }
    return true;

}

function addClientModal() {
    $("#addClientModal").modal('show')
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
        return false;
    } else {
        document.getElementById("empNameErrNotify").setAttribute("hidden", "");
    }

    if (role.value === "") {
        document.getElementById("proRoleErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("proRoleErrNotify").setAttribute("hidden", "");
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

    let profilePic = document.getElementById("uploadedImage");
    let inputFile = document.getElementById("fileProject");

    inputFile.onchange = function () {
        profilePic.src = URL.createObjectURL(inputFile.files[0]);
        console.log("File: " + this.value);
        imagename = this.value.split('\\').pop().split('/').pop();
        console.log(imagename);
    }
    profilePic.style.display = 'block';

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

    if (cname === "") {
        document.getElementById("nameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("nameErrNotify").setAttribute("hidden", "");
    }
    if (country.value === "") {
        document.getElementById("countryErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("countryErrNotify").setAttribute("hidden", "");
    }
    if (address1 === "") {
        document.getElementById("address1ErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("address1ErrNotify").setAttribute("hidden", "");
    }
    if (address2 === "") {
        document.getElementById("address2ErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("address2ErrNotify").setAttribute("hidden", "");
    }
    if (address3 === "") {
        document.getElementById("address3ErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("address3ErrNotify").setAttribute("hidden", "");
    }

    if (cEmail === "") {
        document.getElementById("emaildataErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("emaildataErrNotify").setAttribute("hidden", "");
    }
    if (!validateEmail(cEmail)) {
        document.getElementById("emaildataCorrectErrNotify").removeAttribute("hidden");
        return false;
    } else {

        document.getElementById("emaildataCorrectErrNotify").setAttribute("hidden", "");
    }
    if (cMobile === "") {
        document.getElementById("cMobileErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("cMobileErrNotify").setAttribute("hidden", "");
    }
    if (!validate_phone(cMobile)) {
        document.getElementById("cMobileCorrectErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("cMobileCorrectErrNotify").setAttribute("hidden", "");
    }
    if (cFaxNo === "") {
        document.getElementById("faxdataErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("faxdataErrNotify").setAttribute("hidden", "");
    }
    if (!validate_phone(cFaxNo)) {
        document.getElementById("faxdataCorrectErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("faxdataCorrectErrNotify").setAttribute("hidden", "");
    }
    return true;
}

function clientlogoView() {


    let clientPic = document.getElementById("viewClientImage");
    let inputFileclient = document.getElementById("file1");

    inputFileclient.onchange = function () {
        clientPic.src = URL.createObjectURL(inputFileclient.files[0]);
        console.log("File: " + this.value);
        imagename = this.value.split('\\').pop().split('/').pop();
        console.log(imagename);
    }
    clientPic.style.display = 'block';
}
