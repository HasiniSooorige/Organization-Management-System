
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

}

function validateEmail(email) {
    var re = /\S+@\S+\.\S+/;
    if (re.test(email)) {
        return true;
    } else {
        return false;
    }
}


function profileImageView() {

    let clientPic = document.getElementById("uploadedAvatar");
    let inputFileclient = document.getElementById("uploadProfile");

    inputFileclient.onchange = function () {
        clientPic.src = URL.createObjectURL(inputFileclient.files[0]);
        console.log("File: " + this.value);
        imagename = this.value.split('\\').pop().split('/').pop();
        console.log(imagename);
    }

}

function updateProfileData() {

    var gupid = $('#gupid').val();
    var firstName = $('#firstName').val();
    var lastName = $('#lastName').val();
    var adddress1 = $('#adddress1').val();
    var adddress2 = $('#adddress2').val();
    var adddress3 = $('#adddress3').val();
    var email = $('#email').val();
    var mobileno = $('#mobileno').val();
    var telephoneno = $('#telephoneno').val();

    if (firstName === "") {
        document.getElementById("firstNameError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("firstNameError").setAttribute("hidden", "");

    }

    if (lastName === "") {
        document.getElementById("lastNameError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("lastNameError").setAttribute("hidden", "");
    }

    if (adddress1 === "") {
        document.getElementById("address1Error").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("address1Error").setAttribute("hidden", "");
    }

    if (adddress2 === "") {
        document.getElementById("address2Error").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("address2Error").setAttribute("hidden", "");
    }

    if (adddress3 === "") {
        document.getElementById("address3Error").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("address3Error").setAttribute("hidden", "");
    }

    if (email === "") {
        document.getElementById("emailError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("emailError").setAttribute("hidden", "");
    }

    if (!validateEmail(email)) {
        document.getElementById("emailInvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("emailInvalidError").setAttribute("hidden", "");
    }

    if (mobileno === "") {
        document.getElementById("mobilenoError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("mobilenoError").setAttribute("hidden", "");
    }

    if (!validate_phone(mobileno)) {
        document.getElementById("mobilenoInvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("mobilenoInvalidError").setAttribute("hidden", "");
    }

    if (telephoneno === "") {
        document.getElementById("telephonenoError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("telephonenoError").setAttribute("hidden", "");
    }

    if (!validate_phone(telephoneno)) {
        document.getElementById("telephonenoInvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("telephonenoInvalidError").setAttribute("hidden", "");
    }

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {

                var data = request.response;


                var output = JSON.parse(data);
                if (output.status === 200) {
                    Swal.fire({
                        title: "Profile Details Updated Successfully!",
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });


                } else if (output.status === 400) {

                    Swal.fire({
                        title: output.message,
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }
            }
        }
    };
    request.open("POST", "../UpdateProfileData", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("gupid=" + gupid + "&firstName=" + firstName + "&lastName=" + lastName + "&adddress1=" +
            adddress1 + "&adddress2=" + adddress2 + "&adddress3=" + adddress3 + "&email=" + email + "&mobileno=" + mobileno + "&telephoneno=" + telephoneno);

    return true;


}

function loadProfilePhoto() {

    var userImage = document.getElementById("userImage").value;

    var img = document.getElementById("uploadedAvatar");
    var imageContainer = document.getElementById("ProfileImageView");

    if (userImage === "null" || userImage === "") {
        img.src = "../assets/img/avatars/userImage.jpg";
    } else {
        var imageUrl = "../ViewProfilePhoto?imageName=" + userImage;
        img.src = imageUrl;
    }

    img.height = 100;
    img.width = 100;
    imageContainer.appendChild(img);
    img.style.display = 'block';

}


