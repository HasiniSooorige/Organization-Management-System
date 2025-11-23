/* global Swal */

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
    a

}

function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    if (re.test(email)) {
        return true;
    } else {
        return false;
    }
}

function validate_Registration() {

    var epf_no = $('#epf_num').val();

    var organization_by = document.getElementById("branch");
    var org_value = organization_by.value;

    var designation = document.getElementById("designation");
    var designation_value = designation.value;

    var nic = $('#nic').val();
    var gender = document.getElementById("gender");
    var genderId = gender.value;

    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var dob = $('#dob').val();

    var email = $('#email').val();
    var mobile_no = $('#mobile_no').val();
    var home_no = $('#home_no').val();
    var emergency_contact_no = $('#emergency_no').val();
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();

    var country_id = document.getElementById("country");
    var country_text = country_id.value;


    if (org_value === "") {
        document.getElementById("branchErrNotify").removeAttribute("hidden");
        organization_by.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("branchErrNotify").setAttribute("hidden", "");
        organization_by.style.borderColor = '';
    }
    if (designation_value === "") {
        document.getElementById("DesignationErrNotify").removeAttribute("hidden");
        designation.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("DesignationErrNotify").setAttribute("hidden", "");
        designation.style.borderColor = '';
    }
    if (nic === "") {
        document.getElementById("nicErrNotify").removeAttribute("hidden");
        document.getElementById("nic").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("nicErrNotify").setAttribute("hidden", "");
        document.getElementById("nic").style.borderColor = '';
    }
    if (!validate_nic(nic)) {
        document.getElementById("nicErrNotify_wrg").removeAttribute("hidden");
        document.getElementById("nic").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("nicErrNotify_wrg").setAttribute("hidden", "");
        document.getElementById("nic").style.borderColor = '';
    }
    if (gender.value === "") {
        document.getElementById("genderErrNotify").removeAttribute("hidden");
        gender.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("genderErrNotify").setAttribute("hidden", "");
        gender.style.borderColor = '';
    }
    if (first_name === "") {
        document.getElementById("first_nameErrNotify").removeAttribute("hidden");
        document.getElementById("first_name").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("first_nameErrNotify").setAttribute("hidden", "");
        document.getElementById("first_name").style.borderColor = '';
    }
    if (last_name === "") {
        document.getElementById("last_nameErrNotify").removeAttribute("hidden");
        document.getElementById("last_name").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("last_nameErrNotify").setAttribute("hidden", "");
        document.getElementById("last_name").style.borderColor = '';
    }
    if (dob === "") {
        document.getElementById("dobErrNotify").removeAttribute("hidden");
        document.getElementById("dob").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("dobErrNotify").setAttribute("hidden", "");
        document.getElementById("dob").style.borderColor = '';
    }
    if (email === "") {
        document.getElementById("emailErrNotify").removeAttribute("hidden");
        document.getElementById("email").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emailErrNotify").setAttribute("hidden", "");
        document.getElementById("email").style.borderColor = '';
    }
    if (!validateEmail(email)) {
        document.getElementById("emailErrNotify_valide").removeAttribute("hidden");
        document.getElementById("email").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emailErrNotify_valide").setAttribute("hidden", "");
        document.getElementById("email").style.borderColor = '';
    }
    if (mobile_no === "") {
        document.getElementById("mobile_noErrNotify").removeAttribute("hidden");
        document.getElementById("mobile_no").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("mobile_noErrNotify").setAttribute("hidden", "");
        document.getElementById("mobile_no").style.borderColor = '';
    }
    if (!validate_phone(mobile_no)) {
        document.getElementById("mobile_noErrNotify_valide").removeAttribute("hidden");
        document.getElementById("mobile_no").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("mobile_noErrNotify_valide").setAttribute("hidden", "");
        document.getElementById("mobile_no").style.borderColor = '';
    }
    if (home_no === "") {
        document.getElementById("homenoErrNotify").removeAttribute("hidden");
        document.getElementById("home_no").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("homenoErrNotify").setAttribute("hidden", "");
        document.getElementById("home_no").style.borderColor = '';
    }
    if (!validate_phone(home_no)) {
        document.getElementById("homenoformatErrNotify").removeAttribute("hidden");
        document.getElementById("home_no").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("homenoformatErrNotify").setAttribute("hidden", "");
        document.getElementById("home_no").style.borderColor = '';
    }
    if (emergency_contact_no === "") {
        document.getElementById("emergencynoErrNotify").removeAttribute("hidden");
        document.getElementById("emergency_no").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emergencynoErrNotify").setAttribute("hidden", "");
        document.getElementById("emergency_no").style.borderColor = '';
    }
    if (!validate_phone(emergency_contact_no)) {
        document.getElementById("emergencynoformatErrNotify").removeAttribute("hidden");
        document.getElementById("emergency_no").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("emergencynoformatErrNotify").setAttribute("hidden", "");
        document.getElementById("emergency_no").style.borderColor = '';
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
    if (country_id.value === "") {
        document.getElementById("country_idErrNotify").removeAttribute("hidden");
        country_id.style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("country_idErrNotify").setAttribute("hidden", "");
        country_id.style.borderColor = '';
    }

    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                var data = request.response;
                var output = JSON.parse(data);
                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true,
                        closeOnConfirm: true,
                        timer: 1000
                    });
                    field_clear();
                }

                if (output.status === 400) {

                    Swal.fire({
                        title: output.message,
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true,
                        closeOnConfirm: true,
                        timer: 1000
                    });
                }
            }
        }
    };

    request.open("POST", "../CreateUserProfile", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("epf_no=" + epf_no + "&organization_by=" + org_value + "&designation=" + designation_value + "&nic=" + nic + "&gender=" + genderId +
            "&first_name=" + first_name + "&last_name=" + last_name + "&dob=" + dob + "&address1=" + address1 + "&address2=" + address2 + "&address3=" + address3
            + "&mobile_no=" + mobile_no + "&home_no=" + home_no + "&country_id=" + country_text + "&email=" + email + "&emergencyContact=" + emergency_contact_no);

}

function field_clear() {

    var epfNo = $('#epf_num').val("");
    var nic = $('#nic').val("");
    var first_name = $('#first_name').val("");
    var last_name = $('#last_name').val("");
    var dob = $('#dob').val("");
    var address1 = $('#address1').val("");
    var address2 = $('#address2').val("");
    var address3 = $('#address3').val("");
    var mobile_no = $('#mobile_no').val("");
    var home_no = $('#home_no').val("");
    var email = $('#email').val("");
    var emergency_no = $('#emergency_no').val("");

    document.getElementById("branch").selectedIndex = 0;
    document.getElementById("designation").selectedIndex = 0;
    document.getElementById("gender").selectedIndex = 0;
    document.getElementById("country").selectedIndex = 0;
}







