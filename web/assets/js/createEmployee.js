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

function GeneratePassword() {

    let pass = '';
    let str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' +
            'abcdefghijklmnopqrstuvwxyz0123456789@#$';

    for (let i = 1; i <= 8; i++) {
        let char = Math.floor(Math.random()
                * str.length + 1);

        pass += str.charAt(char);
        document.getElementById("password").setAttribute("value", pass);

    }

    const dateInput = document.getElementById('regisered');
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0];

    dateInput.value = formattedDate;

}

function validate_Regstration() {

    var epf_no = $('#epf_num').val();

    var organization_by = document.getElementById("branch");
    var org_value = organization_by.value;

    var designation = document.getElementById("designation");
    var designation_text = designation.value;

    var nic = $('#nic').val();
    var gender = document.getElementById("gender");
    var gender_text = gender.value;

    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();
    var mobile_no = $('#mobile_no').val();
    var home_no = $('#home_no').val();
    var email = $('#email').val();

    var country_id = document.getElementById("country");
    var country_text = country_id.value;

    if (epf_no === "") {

        document.getElementById("epfErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("epfErrNotify").setAttribute("hidden", "");
    }

    if (organization_by.value === "") {
        document.getElementById("branchErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("branchErrNotify").setAttribute("hidden", "");
    }

    if (designation.value === "") {
        document.getElementById("DesignationErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("DesignationErrNotify").setAttribute("hidden", "");
    }

    if (nic === "") {
        document.getElementById("nicErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("nicErrNotify").setAttribute("hidden", "");
    }
    if (!validate_nic(nic)) {
        document.getElementById("nicErrNotify_wrg").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("nicErrNotify_wrg").setAttribute("hidden", "");
    }

    if (gender.value === "") {
        document.getElementById("genderErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("genderErrNotify").setAttribute("hidden", "");
    }
    if (first_name === "") {
        document.getElementById("first_nameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("first_nameErrNotify").setAttribute("hidden", "");
    }
    if (last_name === "") {
        document.getElementById("last_nameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("last_nameErrNotify").setAttribute("hidden", "");
    }
    if (email === "") {
        document.getElementById("emailErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("emailErrNotify").setAttribute("hidden", "");
    }

    if (!validateEmail(email)) {
        document.getElementById("emailErrNotify_valide").removeAttribute("hidden");
        return false;
    } else {

        document.getElementById("emailErrNotify_valide").setAttribute("hidden", "");
    }
    if (mobile_no === "") {
        document.getElementById("mobile_noErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("mobile_noErrNotify").setAttribute("hidden", "");
    }

    if (!validate_phone(mobile_no)) {
        document.getElementById("mobile_noErrNotify_valide").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("mobile_noErrNotify_valide").setAttribute("hidden", "");
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

    if (home_no === "") {
        document.getElementById("homenoErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("homenoErrNotify").setAttribute("hidden", "");
    }
    if (!validate_phone(home_no)) {
        document.getElementById("homenoformatErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("homenoformatErrNotify").setAttribute("hidden", "");
    }
    if (country_id.value === "") {
        document.getElementById("country_idErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("country_idErrNotify").setAttribute("hidden", "");
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

                    sendMail();
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
    request.send("nic=" + nic + "&first_name=" + first_name + "&last_name=" + last_name + "&address1=" + address1 + "&address2=" + address2 + "&address3=" + address3 + "&mobile_no=" + mobile_no + "&home_no=" + home_no + "&country_id=" + country_text + "&email=" + email + "&epf_no=" + epf_no + "&organization_by=" + org_value + "&designation=" + designation_text + "&username=" + nic + "&gender=" + gender_text);

}

function sendMail() {
    var nic = $('#nic').val();
    var name = $('#first_name').val();
    var psw = $('#password').val();
    var mail = $('#email').val();
    var request = new XMLHttpRequest();


    request.open("POST", "../SendEmail", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("username=" + nic + "&password=" + psw + "&email=" + mail + "&name=" + name);

}

function field_clear() {

    var nic = $('#nic').val("");
    var first_name = $('#first_name').val("");
    var last_name = $('#last_name').val("");
    var address1 = $('#address1').val("");
    var address2 = $('#address2').val("");
    var address3 = $('#address3').val("");
    var mobile_no = $('#mobile_no').val("");
    var home_no = $('#home_no').val("");
    var email = $('#email').val("");
    var username = $('#username').val("");//
    var password = $('#password').val("");
    var repassword = $('#repassword').val("");
    var epf_no = $('#epf_num').val("");
    var regisered = $('#regisered').val("");

    document.getElementById("branch").selectedIndex = 0;
    document.getElementById("designation").selectedIndex = 0;
    document.getElementById("gender").selectedIndex = 0;
    document.getElementById("country_id").selectedIndex = 0;
}