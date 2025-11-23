
/* global tinymce */

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


let epfno = localStorage.getItem('epfno');
let id = localStorage.getItem('id');



function Load_Document() {

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                document.getElementById("document_load").innerHTML = request.response;
            }
        }
    };
    request.open("GET", "ReadDocType", true);
    request.send();
}



function validate_Employee_edit(frm) {
//    alert("validate_Employee_edit");


//                
    var nic = $('#nic').val();
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();
    var mobile_no = $('#mobile_no').val();
    var home_no = $('#home_no').val();
    var email = $('#email').val();
    var username = $('#username').val();//
    var gender = $('#gender').val();//
    var country_id = $('#country_id').val();
    var password = $('#password').val();
    var repassword = $('#repassword').val();
    var epf_no = $('#epf_no').val();
    var organization_by = $('#organization_by').val();
    var designation = $('#designation').val();

    if (epf_no === "") {

        document.getElementById("epfErrNotify").removeAttribute("hidden");

        return false;


    } else {
        document.getElementById("epfErrNotify").setAttribute("hidden", "");

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


    if (first_name === "") {

//        document.getElementById("first_nameErrNotify").style.visibility="visible";
        document.getElementById("first_nameErrNotify").removeAttribute("hidden");
        return false;



    } else {
//        document.getElementById("first_nameErrNotify").style.visibility="hidden";
        document.getElementById("first_nameErrNotify").setAttribute("hidden", "");

    }
    if (last_name === "") {
        document.getElementById("last_nameErrNotify").removeAttribute("hidden");
        return false;



    } else {
        document.getElementById("last_nameErrNotify").setAttribute("hidden", "");

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
    if (country_id === "") {
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
                        title: "Data Successfully Saved",
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

//                            alert(response);
                //   document.getElementById("brand_select").innerHTML = request.response;
            }
        }
    };
    request.open("POST", "../EditEmployeeDataSave", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("organization_by=" + organization_by + "&designation=" + designation + "&epf_no=" + epf_no + "&nic=" + nic + "&first_name=" + first_name + "&last_name=" + last_name + "&address1=" + address1 + "&address2=" + address2 + "&address3=" + address3 + "&mobile_no=" + mobile_no + "&home_no=" + home_no + "&country_id=" + country_id + "&email=" + email);
//                request.send("email=" + email + "&password=" + password + "&fname=" + fname + "&lname=" + lname);




    return true;
}




function loadusers_all() {


    $.get('.././ReadUsersAll', function (data) {

        //document.getElementById("nicColum").setAttribute("value", json["nic"]);
        $('#table_allusers').DataTable({

            columns: [

                {
                    title: 'Action',
                    data: null,
                    wrap: true,
                    render: function (item) {
                        return `<div class="col-3 text-end">
                                <div class="form-check form-switch">
                                  <input class="form-check-input float-end"  onclick="handleClick_action(this,'${item.nic}');" type="checkbox" role="switch" />
                                </div>
                              </div>`;

                    }
                },
                {
                    title: 'NIC',
                    data: 'nic'
                },

                {
                    title: 'email',
                    data: 'email'
                },
                {
                    title: 'firstname',
                    data: 'firstname'
                },
                {
                    title: 'lastname',
                    data: 'lastname'
                },

                {
                    title: 'mobileno',
                    data: 'mobileno'
                },

                {
                    title: 'View',
                    data: null,
                    wrap: true,
                    render: function (itemView) {
                        return`<i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewRowData('${itemView.id}');" >
                                
                                
</i>`;

                    }
                },
                {
                    title: 'Upload',
                    data: null,
                    wrap: true,
                    render: function (item) {
                        return `<button  class="btn rounded-pill btn-info" onclick="UploadRowData('${item.id}');" >Upload
                                
                                
</button>`;

                    }
                },
                {
                    title: 'Edit',
                    data: null,
                    wrap: true,
                    render: function (item) {
                        return `<button  class="btn rounded-pill btn-success" onclick="editRowData('${item.epfno}');" >Edit</button>`;
//                        return `<button  class="btn rounded-pill btn-success" onclick="viewResignation('${itemView.id}');" >Resignation</button>`;

                    }
                },
                {
                    title: 'Resignation',
                    data: null,
                    wrap: true,
                    render: function (item) {
//                        return `<button  class="btn rounded-pill btn-success" onclick="editRowData('${item.epfno}');" >Edit</button>`;

                        return `<button  class="btn rounded-pill btn-warning" onclick="viewResignation('${item.id}');" >Resignation</button>`;

                    }
                }


            ],
            data: data,
            pageLength: '10'
        });

    }, 'json');


}

function loademployees_all() {


    $.get('./ReadEmployeeAll', function (data) {



        $('#table_allemployees').DataTable({

            columns: [

                {
                    title: 'Action',
                    data: null,
                    wrap: true,
                    render: function (item) {
                        return `<div class="col-3 text-end">
                                <div class="form-check form-switch">
                                  <input class="form-check-input float-end"  onclick="handleClick_action(this,'${item.nic}');" type="checkbox" role="switch" />
                                </div>
                              </div>`;

                    }
                },

                {
                    title: 'Epf no',
                    data: 'epfNo'
                },
                {
                    title: 'Designation',
                    data: 'designation'
                },
                {
                    title: 'Registred Date',
                    data: 'registeredDate'
                },

                {
                    title: 'User Name',
                    data: 'generalUserProfile'
                },
                {
                    title: 'Organization By',
                    data: 'generalOrganizationProfile'
                },

                {
                    title: 'Edit',
                    data: null,
                    wrap: true,
                    render: function (item) {
                        return `<button  class="btn btn-danger" onclick="viewRowData('${item.epfno}');" >Edit
                                
                                
</button>`;

                    }
                }




            ],
            data: data,
            pageLength: '10'
        });

    }, 'json');



}

function UploadRowData(value) {
    localStorage.setItem('id', value);
    window.location = '../main-pages/employee-document-upload.jsp?id=' + value;


}

function handleClick_action(id1, status) {

    $.post('.././UpdateActiveStatus', {
        valuechecked: status,
        nic: id1


    }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 204) {
            alert("Employee Deactivated");


        } else if (value.status == 304) {
            alert("Employee Activated");


        } else {
            alert("Error");


        }



    });

    location.reload();


}


function viewRowData(value) {


    // location.reload();
    edit_data_load_view(value);

}
function edit_data_load_view(value) {
//    alert("edit_data_load");
    //ne



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
                var d = new Date(obj.registereddate);


                let dateL = d.toISOString();


                var now = new Date(dateL);

                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);

                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#datePicker').val(today);






//                document.getElementById("regisered").setAttribute("value", d.toLocaleDateString());

                $('#regisered1').val(today);

                document.getElementById("epf_no1").setAttribute("value", obj.epfno);
                //   document.getElementById("regisered1").setAttribute("value", obj.registereddate);
//                document.getElementById("organization_by").setAttribute("value", obj.generalorganizationname);
                document.getElementById("organization_by1").setAttribute("value", obj.generalorganizationname);
                document.getElementById("designation1").setAttribute("value", obj.designation);
                //          localStorage.setItem('designation', obj.designation);
//                alert("designationD");
//                alert(obj.designation);

                document.getElementById("nic1").setAttribute("value", obj.nic);
                document.getElementById("first_name1").setAttribute("value", obj.firstname);
                document.getElementById("last_name1").setAttribute("value", obj.lastname);
                document.getElementById("email1").setAttribute("value", obj.email);
                document.getElementById("mobile_no1").setAttribute("value", obj.mobileno);
                document.getElementById("address11").setAttribute("value", obj.address1);
                document.getElementById("address21").setAttribute("value", obj.address2);
                document.getElementById("address31").setAttribute("value", obj.address3);
                document.getElementById("home_no1").setAttribute("value", obj.homeno);
                document.getElementById("country_id1").setAttribute("value", obj.coutry);
                document.getElementById("gender1").setAttribute("value", obj.gender);
                show_modal();


            }
        }
    };
    request.open("POST", "../EmployeeDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + value);
}

function show_Resignation_modal() {

    $("#ResignationModal").modal('show')


}

function addClientModal() {
    $("#addClientModal").modal('show')
}

function closeclientData() {
    $("#addClientModal").modal('hide');
}

function addEmpModel() {
    $("#addEmpModel").modal('show')
}

function show_modal() {

    $("#largeModal").modal('show')


}

function viewResignation(value) {


    // location.reload();
//    alert(value);
    Resignation(value);
//               alert(value);
    document.getElementById("inputid").value = value;
}
function Resignation(value) {
//    alert("edit_data_load");
    //ne



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
                if (obj.resignationDate == null) {
                    $('#resignation').prop('disabled', false);
                    $('#resignation').val("");
                    $('#resbtn').show();
                } else {
                    var rd = new Date(obj.resignationDate);
                    let rdate = rd.toISOString();
                    var rnow = new Date(rdate);
                    var rday = ("0" + rnow.getDate()).slice(-2);
                    var rmonth = ("0" + (rnow.getMonth() + 1)).slice(-2);
                    var resignationdate = rnow.getFullYear() + "-" + (rmonth) + "-" + (rday);
                    $('#resignation').val(resignationdate);
                    $('#resignation').prop('disabled', true);
                    $('#resbtn').hide();
                }
                var d = new Date(obj.registereddate);

//                alert(rd.toISOString());

                let dateL = d.toISOString();


//                alert(dateL);
                var now = new Date(dateL);


                var day = ("0" + now.getDate()).slice(-2);


                var month = ("0" + (now.getMonth() + 1)).slice(-2);


                var today = now.getFullYear() + "-" + (month) + "-" + (day);




                $('#datePicker').val(today);

                $('#regisered1').val(today);
                $('#regisered1model2').val(today);

                show_Resignation_modal();
            }
        }
    };
    request.open("POST", "../EmployeeDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + value);
}






function editRowData(value) {

    localStorage.setItem('id', value);
    window.location = '../main-pages/employee-edit.jsp?id=' + value;


}

function Organization_by() {



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {
                var data = request.response;

//                  alert("generalorganizationname _load_my _way");


                let generalorganizationname = localStorage.getItem('generalorganizationname');
//                alert(generalorganizationname);


//document.querySelector('input[name = "' + prop + '"]').setAttribute('placeholder', data[prop]);



                var cuisines = JSON.parse(data);
                var sel = document.getElementById('organization_by');
                for (var i = 0; i < cuisines.length; i++) {
                    var opt = document.createElement('option');
                    opt.innerHTML = cuisines[i];
                    opt.value = cuisines[i];
                    sel.appendChild(opt);

                }
                document.querySelector('option[value="' + generalorganizationname + '"]').selected = true;



//                document.getElementById("organization_by").innerHTML = request.response;
            }
        }
    };
    request.open("GET", "../ReadOrganizationBy", true);
    request.send();
}

function Load_Designation() {



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                var data = request.response;

                let designation = localStorage.getItem('designation');
//                alert(designation);


//document.querySelector('input[name = "' + prop + '"]').setAttribute('placeholder', data[prop]);



                var cuisines = JSON.parse(data);
                var sel = document.getElementById('designation');
                for (var i = 0; i < cuisines.length; i++) {
                    var opt = document.createElement('option');
                    opt.innerHTML = cuisines[i];
                    opt.value = cuisines[i];
                    sel.appendChild(opt);

                }
                document.querySelector('option[value="' + designation + '"]').selected = true;

            }
        }
    };
    request.open("GET", "../ReadDesignation", true);
    request.send();
}


function LoadCoutry() {



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {
//                            alert("load country");
//                            alert(request.response);
                var data = request.response;

//            alert("country_load_my _way");


                let coutry = localStorage.getItem('coutry');
//                alert(coutry);


//document.querySelector('input[name = "' + prop + '"]').setAttribute('placeholder', data[prop]);



                var cuisines = JSON.parse(data);
                var sel = document.getElementById('country_id');
                for (var i = 0; i < cuisines.length; i++) {
                    var opt = document.createElement('option');
                    opt.innerHTML = cuisines[i];
                    opt.value = cuisines[i];
                    sel.appendChild(opt);

                }
                document.querySelector('option[value="' + coutry + '"]').selected = true;




//                document.getElementById("country_id").innerHTML = request.response;
            }
        }
    };
    request.open("GET", "../ReadCountry", true);
    request.send();
}




function validate_Login(frm) {


    var email = frm.email.value;
    var password = frm.password.value;
    // write client side form validation logic
    if (uuser == "") {
        document.getElementById("uuserErr").innerHTML =
                "<b>User name is required</b>";
//		frm.pname.focus();
        return false;
    }
    if (upassword == "") {
        document.getElementById("upasswordErr").innerHTML =
                "<b>Password is required</b>";
//		frm.page.focus();
        return false;
    }

    login(email, password);

    return true;
}

function login(uuser, upassword) {




    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === 4 && request.status === 200) {


        }
    };

    request.open("POST", "../SelectLogin", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
//                request.send("email=" + email + "&password=" + password + "&fname=" + fname + "&lname=" + lname+"&page=sign-up-form");
    request.send("uuser=" + uuser + "&upassword=" + upassword);


}



function validate_Regstration(frm) {
//    alert("validate_Regstration_call");


    var nic = $('#nic').val();
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();
    var mobile_no = $('#mobile_no').val();
    var home_no = $('#home_no').val();
    var email = $('#email').val();
    var reg_date = $('#regisered_date').val();

    var gender = $('#gender').val();//
    var country_id = $('#country_id').val();


    var epf_no = $('#epf_num').val();
    var organization_by = $('#organization_by').val();
    var designation = $('#designation').val();

    if (epf_no === "") {

        document.getElementById("epfErrNotify").removeAttribute("hidden");

        return false;


    } else {
        document.getElementById("epfErrNotify").setAttribute("hidden", "");

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


    if (first_name === "") {

//        document.getElementById("first_nameErrNotify").style.visibility="visible";
        document.getElementById("first_nameErrNotify").removeAttribute("hidden");
        return false;



    } else {
//        document.getElementById("first_nameErrNotify").style.visibility="hidden";
        document.getElementById("first_nameErrNotify").setAttribute("hidden", "");

    }
    if (last_name === "") {
        document.getElementById("last_nameErrNotify").removeAttribute("hidden");
        return false;



    } else {
        document.getElementById("last_nameErrNotify").setAttribute("hidden", "");

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
    if (home_no === "") {
        document.getElementById("homenoErrNotify").removeAttribute("hidden");
        return false;



    } else {
        document.getElementById("homenoErrNotify").setAttribute("hidden", "");

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
    if (country_id === "") {
        document.getElementById("country_idErrNotify").removeAttribute("hidden");
        return false;



    } else {
        document.getElementById("country_idErrNotify").setAttribute("hidden", "");

    }


    if (reg_date === "") {
        document.getElementById("passErrNotify").removeAttribute("hidden");
        return false;

    } else {
        document.getElementById("passErrNotify").setAttribute("hidden", "");



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
                        allowEscapeKey: true
                    });

//            window.location="auth-login-basic.jsp";


                    field_clear();


                }
//                            
//                            else 

                if (output.status === 400) {

                    Swal.fire({
                        title: output.message,
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }


//                            alert(response);
                //   document.getElementById("brand_select").innerHTML = request.response;
            }
        }
    };
    request.open("POST", "../CreateUserProfile", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("nic=" + nic + "&first_name=" + first_name + "&last_name=" + last_name + "&address1=" + address1 + "&address2=" + address2 + "&address3=" + address3 + "&mobile_no=" + mobile_no + "&home_no=" + home_no + "&country_id=" + country_id + "&email=" + email + "&epf_no=" + epf_no + "&organization_by=" + organization_by + "&designation=" + designation + "&gender=" + gender + "&reg_date=" + reg_date);
//                request.send("email=" + email + "&password=" + password + "&fname=" + fname + "&lname=" + lname);




    return true;
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
// function savePemployee(frm) {




//var nic = frm.nic.value;                
//var  first_name=frm.first_name.value;
//var  last_name=frm.last_name.value;
//var  address1=frm.address1.value;
//var  address2=frm.address2.value;
//var  address3=frm.address3.value;
//var  mobile_no=frm.mobile_no.value;
//var  home_no=frm.home_no.value;
//var  email=frm.email.value;
////var country_id = frm.country_id.value;
//
//var country_id = document.getElementById("country_id").value;
//
//
//    alert("country_id_savePemployee");
//    alert(country_id);
//
//
//                var request = new XMLHttpRequest();
//
//                request.onreadystatechange = function() {
//                    if (request.readyState === 4) {
//                        if (request.status === 200) {
//                            
////                            alert(response);
//                            //   document.getElementById("brand_select").innerHTML = request.response;
//                        }
//                    }
//                };
//                request.open("POST", "employee_save_Servlet", true);
//                 request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
//                request.send("nic="+nic+"&first_name="+first_name+"&last_name="+last_name+"&address1="+address1+"&address2="+address2+"&address3="+address3+"&mobile_no="+mobile_no+"&home_no="+home_no+"&country_id="+country_id+"&email="+email);
////                request.send("email=" + email + "&password=" + password + "&fname=" + fname + "&lname=" + lname);
//                
//                
//                  
//                
//            }



function login_validate(frm) {

    var uuser = frm.email.value;
    var upassword = frm.password.value;
    // write client side form validation logic
    if (uuser == "") {
        document.getElementById("uuserErr").innerHTML =
                "<b>User name is required</b>";

        return false;
    } else {
        document.getElementById('uuserErr').innerHTML = '';

    }
    if (upassword == "") {
        document.getElementById("upasswordErr").innerHTML =
                "<b>Password is required</b>";

        return false;
    } else {
        document.getElementById('upasswordErr').innerHTML = '';

    }
    
    
//        else if (isNaN(upassword)) {
//		document.getElementById("upasswordErr").innerHTML =
//			"<b>Pasword  must be numeric</b>";
//		frm.page.focus();
//		return false;
//	}
//        else {
//		if (age <= 0 || age > 125) {
//			document.getElementById("pageErr").innerHTML =
//				"<b>Person age must be between 1 to 125</b>";
//			frm.page.focus();
//			return false;
//		}
//	}
    login(uuser, upassword);

    return true;
}

function login(uuser, upassword) {


    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (request.readyState === 4 && request.status === 200) {
            var data = request.response;
            var output = JSON.parse(data);

            if (output[0].success & output[0].link !== null) {
                if (output[0].idURoll === 2) {
                    window.location = "main-pages/" + output[0].link;
                }
                if (output[0].idURoll === 1) {
                    window.location = "main-pages/" + output[0].link;
                }
                if (output[0].idURoll === 3) {
                    window.location = "main-pages/" + output[0].link;
                }

            }
        }
    };

    request.open("POST", "SelectLogin", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("uuser=" + uuser + "&upassword=" + upassword);


}




//pro

function Loaduser_Profiles() {



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {


                var data = request.response;
                var json = JSON.parse(data);



                const today = new Date(); // today's date
                const tomorrow = new Date(today.setDate(today.getDate() + 1)); // tomorrow's date

                document.getElementById('regisered').value = tomorrow.toISOString().split('T')[0];


//                            document.getElementById("epf_no").innerHTML = json["empid"];
                document.getElementById("epf_no").setAttribute("value", json["empid"]);

                document.getElementById("nic").setAttribute("value", json["nic"]);
                document.getElementById("first_name").setAttribute("value", json["firstName"]);
                document.getElementById("last_name").setAttribute("value", json["lastName"]);
                document.getElementById("address1").setAttribute("value", json["address1"]);
                document.getElementById("address2").setAttribute("value", json["address2"]);
                document.getElementById("address3").setAttribute("value", json["address3"]);
                document.getElementById("mobile_no").setAttribute("value", json["mobileNo"]);
                document.getElementById("home_no").setAttribute("value", json["homeNo"]);
                document.getElementById("email").setAttribute("value", json["email"]);













//                            String[] result = s.split("_");



            }
        }
    };
    request.open("POST", "../create_employee_regsitration", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("nic=" + nic);
//                request.send("nic="+nic+"&first_name="+first_name+"&last_name="+last_name+"&address1="+address1+"&address2="+address2+"&address3="+address3+"&mobile_no="+mobile_no+"&home_no="+home_no+"&country_id="+country_id+"&email="+email);
}


function Loadfk() {
//    alert("fk_methos");
    //ne



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;
//                            var jsonData = JSON.parse(str);  


//                            alert(jsonData.epfno);

//                            const jsonSSS = '{"result":true, "count":42}';
//
//                            const jsonSSS ='{"current_date":"123","success":false,"link":"","epfno":2325}';
//                            alert("fk_methos_line_fk");




//                alert(request.response);


                const obj = JSON.parse(str);

//                alert(obj.current_date);


//                alert(obj.epfno)







//                            document.getElementById("country_id").innerHTML = request.response;
                document.getElementById("epf_no").setAttribute("value", obj.epfno);
                const date = new Date();

                let day = date.getDate();
                let month = date.getMonth() + 1;
                let year = date.getFullYear();

// This arrangement can be altered based on how we want the date's format to appear.
                let currentDate = `${day}-${month}-${year}`;

                document.getElementById("regisered").setAttribute("value", currentDate);
            }
        }
    };
    request.open("POST", "../SelectEpfNo", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send();
}



function edit_data_load() {
//    alert("edit_data_load");
    //ne



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);



                var d = new Date(obj.registereddate);


                let dateL = d.toISOString();


                var now = new Date(dateL);

                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);

                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#datePicker').val(today);






//                document.getElementById("regisered").setAttribute("value", d.toLocaleDateString());

                $('#regisered').val(today);

                document.getElementById("epf_no").setAttribute("value", obj.epfno);

//                document.getElementById("organization_by").setAttribute("value", obj.generalorganizationname);
                localStorage.setItem('generalorganizationname', obj.generalorganizationname);
//                document.getElementById("designation").setAttribute("value", obj.designation);
                localStorage.setItem('designation', obj.designation);
                localStorage.setItem('gender', obj.gender);
//                alert("designationD");
//                alert(obj.designation);

                document.getElementById("nic").setAttribute("value", obj.nic);
                document.getElementById("first_name").setAttribute("value", obj.firstname);
                document.getElementById("last_name").setAttribute("value", obj.lastname);
                document.getElementById("email").setAttribute("value", obj.email);
                document.getElementById("mobile_no").setAttribute("value", obj.mobileno);
                document.getElementById("address1").setAttribute("value", obj.address1);
                document.getElementById("address2").setAttribute("value", obj.address2);
                document.getElementById("address3").setAttribute("value", obj.address3);
                document.getElementById("home_no").setAttribute("value", obj.homeno);
//                document.getElementById("country_id").setAttribute("value", obj.coutry);

                localStorage.setItem('coutry', obj.coutry);

                let gender = localStorage.getItem('gender');
//                alert(designation);


//document.querySelector('input[name = "' + prop + '"]').setAttribute('placeholder', data[prop]);



                document.querySelector('option[value="' + gender + '"]').selected = true;





            }
        }
    };
    request.open("POST", "../EditEmployeeData", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);
}

function edit_data_load_g() {
//    alert("edit_data_load_g");
    //ne



    //                                                                var cat_select=document.getElementById("cat_select").value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);



                var d = new Date(obj.registereddate);


                let dateL = d.toISOString();


                var now = new Date(dateL);

                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);

                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#datePicker').val(today);






//                document.getElementById("regisered").setAttribute("value", d.toLocaleDateString());

                $('#regisered').val(today);

                document.getElementById("epf_no").setAttribute("value", obj.epfno);

                document.getElementById("organization_by").setAttribute("value", obj.generalorganizationname);
                document.getElementById("designation").setAttribute("value", obj.designation);
                document.getElementById("nic").setAttribute("value", obj.nic);
                document.getElementById("first_name").setAttribute("value", obj.firstname);
                document.getElementById("last_name").setAttribute("value", obj.lastname);
                document.getElementById("email").setAttribute("value", obj.email);
                document.getElementById("mobile_no").setAttribute("value", obj.mobileno);
                document.getElementById("address1").setAttribute("value", obj.address1);
                document.getElementById("address2").setAttribute("value", obj.address2);
                document.getElementById("address3").setAttribute("value", obj.address3);
                document.getElementById("home_no").setAttribute("value", obj.homeno);
                document.getElementById("country_id").setAttribute("value", obj.coutry);



            }
        }
    };
    request.open("POST", "EditEmployeeDataG", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send();
}




function loadEmployeeHistory_all() {


    $.get('./ReadEmployeeAllHistory', function (data) {


        $('#table_allemployee_history').DataTable({

            columns: [

                {
                    title: 'EPF NO',
                    data: 'epfno'
                },
                {
                    title: 'DESIGNATION',
                    data: 'deignation'
                },

                {
                    title: 'NIC',
                    data: 'nic'
                },

                {
                    title: 'MOBILE NO',
                    data: 'mobileno'
                },

                {
                    title: 'DATE FROM',
                    data: 'datefrom'
                },
                {
                    title: 'DATE TO',
                    data: 'dateto'
                },
                {
                    title: 'DESIGNATIO TO',
                    data: 'designationto'
                },
                {
                    title: 'DESIGNATIO FROM',
                    data: 'designationfrom'
                }



            ],
            data: data,
            pageLength: '10'
        });

    }, 'json');



}

function loadEmployeeHistory_all_g() {

    $.get('./ReadEmployeeAllHistoryG', function (data) {


        $('#table_allemployee_history').DataTable({

            columns: [

                {
                    title: 'EPF NO',
                    data: 'epfno'
                },
                {
                    title: 'DESIGNATION',
                    data: 'deignation'
                },

                {
                    title: 'NIC',
                    data: 'nic'
                },

                {
                    title: 'MOBILE NO',
                    data: 'mobileno'
                },

                {
                    title: 'DATE FROM',
                    data: 'datefrom'
                },
                {
                    title: 'DATE TO',
                    data: 'dateto'
                },
                {
                    title: 'DESIGNATIO TO',
                    data: 'designationto'
                },
                {
                    title: 'DESIGNATIO FROM',
                    data: 'designationfrom'
                }



            ],
            data: data,
            pageLength: '10'
        });

    }, 'json');



}

function field_clear() {


//    $('#nic').val("");


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
    var epf_no = $('#epf_no').val("");



//    


//    nic='';
//nic



}

function close_employee_edit() {
//    alert("close_employee_edit");

    window.location.href = 'page-all-user-profiles.jsp';
}

function change_password(frm) {
//    alert("change_password");


    var password = $('#password').val();
    var repassword = $('#repassword').val();







    if (password === "") {
        document.getElementById("passErrNotify").removeAttribute("hidden");
        return false;

    } else {
        document.getElementById("passErrNotify").setAttribute("hidden", "");



    }

    if (repassword === "") {


        document.getElementById("passErrNotify_newpass_requireed").removeAttribute("hidden");
        return false;




    } else {
        document.getElementById("passErrNotify_newpass_requireed").setAttribute("hidden", "");

    }


    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {

                var data = request.response;


                var output = JSON.parse(data);
//                alert("output_ch");
//                alert(request.response);


                if (output[0].success === false) {
                    Swal.fire({
                        type: "error",
                        title: output[0].message + "!",
                        icon: 'error',
                        showConfirmButton: false,
                        allowOutsideClick: true,
                        allowEscapeKey: true,
                        closeOnConfirm: false,
                        timer: 1000,

                    });



//                    window.location = "page-mng_dash_bord.jsp";
                }


                if (output[0].success === true) {
                    Swal.fire({
                        type: "success",
                        title: output[0].message,
                        icon: 'success',
                        showConfirmButton: false,
                        allowOutsideClick: true,
                        allowEscapeKey: true,
                        closeOnConfirm: false,
                        timer: 1000,

                    });

                }
                if (output[0].success & output[0].link !== null) {
                    if (output[0].idURoll === 2) {
                        window.location = "main-pages/" + output[0].link;
                    }
                    if (output[0].idURoll === 1) {
                        window.location = "main-pages/" + output[0].link;
                    }
                    if (output[0].idURoll === 3) {
                        window.location = "../main-pages/" + output[0].link;
                    }

                }


            }
        }
    };
    request.open("POST", "../ChangePassword", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("currentpassword=" + password + "&chpassword=" + repassword);
//                request.send("email=" + email + "&password=" + password + "&fname=" + fname + "&lname=" + lname);




    return true;
}

function selectElement(id, valueToSelect) {
    let element = document.getElementById(id);
    element.value = valueToSelect;
}


function document_load() {
    var request = new XMLHttpRequest();
    let div = null;

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);



                var b = (obj[0].url).replace(/^.*[\\\/]/, '');

                document.getElementById("naSize").innerHTML = obj[obj.length - 1].docSizeN;
                document.getElementById("baSize").innerHTML = obj[obj.length - 1].docSizeB;
                document.getElementById("euSize").innerHTML = obj[obj.length - 1].docSizeE;

                let list = document.getElementById("galleryUL");
                let listx = document.getElementById("gallery");

                listx.appendChild(list);

                for (i = 0; i < obj.length; ++i) {
                    //  var li = document.createElement('li');
                    var img = document.createElement("img");
                    //  li.appendChild(img);
                    img.src = "../Product/" + (obj[i].url).replace(/^.*[\\\/]/, '');
                    img.width = 600;
                    // document.getElementById('image_templateloadIdantity').appendChild(img);
                    list.appendChild(img);
                }

            }
        }

    };
    request.open("POST", "../DocumentDataLoad", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

}

function document_data_check() {
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);


                document.getElementById("progessBar").style.width = obj + "%";


            }
        }
    };
    request.open("POST", "../DocumentDataCheck", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

}
function loadPortalPayment(frm) {
    var minDate = frm.startdate.value;
    var maxDate = frm.enddate.value;
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
                if (obj.length < 1) {
                    $("#loadPortalPayment_table tr").remove();
                    document.getElementById("divDes").innerHTML =
                            "<b>No data available in hare</b>";
                } else {
                    document.getElementById("divDes").innerHTML =
                            "<b></b>";
                    // Extract value from table header. 

                    let col = [];
                    for (let i = 0; i < obj.length; i++) {
                        for (let key in obj[i]) {
                            if (col.indexOf(key) === -1) {
                                col.push(key);
                            }
                        }
                    }

                    // Create table.
                    const table = document.getElementById("loadPortalPayment_table");
                    $("#loadPortalPayment_table tr").remove();
                    // Create table header row using the extracted headers above.
                    let tr = table.insertRow(-1);                   // table row.

                    for (let i = 0; i < col.length; i++) {
                        let th = document.createElement("th");      // table header.
                        th.innerHTML = col[i];
                        tr.appendChild(th);
                    }

                    // add json data to the table as rows.
                    for (let i = 0; i < obj.length; i++) {

                        tr = table.insertRow(-1);

                        for (let j = 0; j < col.length; j++) {
                            let tabCell = tr.insertCell(-1);
                            tabCell.innerHTML = obj[i][col[j]];
                        }
                    }

                    // Now, add the newly created table with json data, to a container.
                    const divShowData = document.getElementById('showData');
                    divShowData.innerHTML = "";
                    divShowData.appendChild(table);


                }






            }
        }
    };
    request.open("POST", "../ReadPortalPayment", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("dateMin=" + minDate + "&dateMax=" + maxDate);


}
function ResignationSave(id) {
    var resignation = document.getElementById("resignation").value;
    var id = document.getElementById("inputid").value;
    if (resignation == "") {
        alert("Please Add Resignation Date");
    } else {
        let jsonObject = {
            "res": resignation,
            "id": id
        }

        let jsonString = JSON.stringify(jsonObject);
        let request = new XMLHttpRequest();
        request.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                let response = this.responseText;
                let resp = JSON.parse(response);
                if (resp.status == "Resignation Successfully completed") {
                    alert(resp.status);
                }
                alert("ok");
            }
        };
        request.open("POST", "../SaveResignation", true);
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        request.send(jsonString);
    }
}

function getType() {
    let all = document.getElementById("all");
    let currentemployee = document.getElementById("currentemployee");
    let resignemployee = document.getElementById("resignemployee");
    let is_active;
    if (all.checked) {
        currentemployee.checked = true;
        currentemployee.disabled = true;
        resignemployee.checked = true;
        resignemployee.disabled = true;
        is_active = 2;
    } else {
        currentemployee.disabled = false;
        resignemployee.disabled = false;
        if (currentemployee.checked && !resignemployee.checked) {
            is_active = 1;
        } else if (!currentemployee.checked && resignemployee.checked) {
            is_active = 0;
        } else if (currentemployee.checked && resignemployee.checked) {
            is_active = 2;
        } else {
            is_active = 3;
        }
    }
    let jsonObject = {
        "is_active": is_active,
    }
    let jsonString = JSON.stringify(jsonObject);
    var r = new XMLHttpRequest();
    r.onreadystatechange = function () {
        if (r.readyState == 4 && r.status == 200) {
            var t = r.responseText;

            // Parse the JSON response from the servlet
            var data = JSON.parse(t);

            // Get the table body element
            var tbody = document.getElementById("tablebody");

            // Clear existing table rows, if any
            tbody.innerHTML = "";

            // Iterate through the data and create table rows
            for (var i = 0; i < data.length; i++) {
                var employee = data[i];
                var tr = document.createElement("tr");

                // Create table cells and populate them with data
                var tdAction = document.createElement("td");
                tdAction.innerHTML = `<div class="col-3 text-end">
                                    <div class="form-check form-switch">
                                        <input class="form-check-input float-end" onclick="handleClick_action(this,'${employee.nic}');" type="checkbox" role="switch" />
                                    </div>
                                </div>`;
                tr.appendChild(tdAction);

                var tdNic = document.createElement("td");
                tdNic.textContent = employee.nic;
                tr.appendChild(tdNic);

                var tdEmail = document.createElement("td");
                tdEmail.textContent = employee.email;
                tr.appendChild(tdEmail);

                var tdFirstName = document.createElement("td");
                tdFirstName.textContent = employee.firstname;
                tr.appendChild(tdFirstName);

                var tdLastName = document.createElement("td");
                tdLastName.textContent = employee.lastname;
                tr.appendChild(tdLastName);

                var tdMobileNo = document.createElement("td");
                tdMobileNo.textContent = employee.mobileno;
                tr.appendChild(tdMobileNo);

                var tdView = document.createElement("td");
                tdView.innerHTML = `<i id="viewBtnOnclick" type="button" class="far fa-eye" onclick="viewRowData('${employee.id}');"></i>`;
                tr.appendChild(tdView);

                var tdUpload = document.createElement("td");
                tdUpload.innerHTML = `<button class="btn rounded-pill btn-info" onclick="UploadRowData('${employee.id}');">Upload</button>`;
                tr.appendChild(tdUpload);

                var tdEdit = document.createElement("td");
                tdEdit.innerHTML = `<button class="btn rounded-pill btn-success" onclick="editRowData('${employee.epfno}');">Edit</button>`;
                tr.appendChild(tdEdit);

                var tdResignation = document.createElement("td");
                tdResignation.innerHTML = `<button class="btn rounded-pill btn-warning" onclick="viewResignation('${employee.id}');">Resignation</button>`;
                tr.appendChild(tdResignation);

                // Append the row to the table body
                tbody.appendChild(tr);
            }
        }
    };
    r.open("POST", "../FilterEmployee", true);
    r.send(jsonString);

}

//https://stackoverflow.com/questions/29945646/sweet-alert-timer-done-function
//https://stackoverflow.com/questions/48877076/how-to-make-sweet-alert-auto-close-after-ajax-complete
//https://stackoverflow.com/questions/29945646/sweet-alert-timer-done-function


function clientValidation() {

    var cname = $('#cname').val();
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();
    var country_id = $('#country_id').val();

    if (cname === "") {
        document.getElementById("nameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("nameErrNotify").setAttribute("hidden", "");
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
    if (country_id === "") {
        document.getElementById("country_idErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("country_idErrNotify").setAttribute("hidden", "");
    }

    console.log(cname, address1, address2, address3, country_id)

    var form = $('#projectDetails')[0];
    var data = new FormData(form);

    $.ajax({
        type: "POST",
        url: "../CreateNewClient",
        enctype: 'multipart/form-data',
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        success: function (data) {
            alert(data)
        }

    });

}

function autoFill() {
    var input1Value = document.getElementById("cname").value;
    document.getElementById("client_name").value = input1Value;
}

function LoadProjectRole() {

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                var data = request.response;

                let projectRole = localStorage.getItem('project_role');

                var cuisines = JSON.parse(data);
                var sel = document.getElementById('project_role');
                for (var i = 0; i < cuisines.length; i++) {
                    var opt = document.createElement('option');
                    opt.innerHTML = cuisines[i];
                    opt.value = cuisines[i];
                    sel.appendChild(opt);

                }
                document.querySelector('option[value="' + projectRole + '"]').selected = true;

            }
        }
    };
    request.open("GET", "../ReadProjectRole", true);
    request.send();
}

function addNewRowEmpRole() {

    event.preventDefault();

    var emp = document.getElementById("empName");
    var valueEmp = emp.value;
    var textEmp = emp.options[emp.selectedIndex].text;

    var role = document.getElementById("projectrole");
    var valueRole = role.value;
    var textRole = role.options[role.selectedIndex].text;

    if (emp.value == "") {
        document.getElementById("empNameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("empNameErrNotify").setAttribute("hidden", "");
    }

    if (role.value == "") {
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

function checkDuplicateEmp() {

    var emp = document.getElementById("empName");
    var valueEmp = emp.value;

    const table = document.getElementById("allEmpTable");
    const columnIndex = 0;
    const columnValues = [];

    for (let i = 1; i < table.rows.length; i++) {
        const cell = table.rows[i].cells[columnIndex];
        const cellValue = cell.textContent || cell.innerText;
        columnValues.push(cellValue);
    }
    console.log("ABC  --- " + columnValues);

    const dropdowneEmp = document.getElementById("projectrole");
    const buttonEmp = document.getElementById("saveEmpRole");

    if (columnValues.indexOf(valueEmp) !== -1) {
        document.getElementById("empalreadyexist").removeAttribute("hidden");

        dropdowneEmp.disabled = true;
        buttonEmp.disabled = true;


        return false;
    } else {
        document.getElementById("empalreadyexist").setAttribute("hidden", "");

        dropdowneEmp.disabled = false;
        buttonEmp.disabled = false;

        return true;


    }
}



function saveNewProject() {

    var tableBody = document.getElementById('empTableBody');
    var rows = tableBody.getElementsByTagName('tr');

    var proName = $('#projectname').val();
    var proDesc = document.getElementById("projectDescription").value;
    var orgName = document.getElementById("organization_by");


    if (proName === "") {
        document.getElementById("proNameErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("proNameErrNotify").setAttribute("hidden", "");
    }

    if (proDesc == "") {
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

    if (orgName.value == "") {
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


function saveNewClients() {

    var cname = $('#cname').val();
    var country = document.getElementById("country_id");
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
    if (country.value == "") {
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
    if (cMobile === "") {
        document.getElementById("cMobileErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("cMobileErrNotify").setAttribute("hidden", "");
    }
    if (cFaxNo === "") {
        document.getElementById("faxdataErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("faxdataErrNotify").setAttribute("hidden", "");
    }
    return true;
}

function  viewProjectDetails(id) {
    $("#viewProjectData").modal('show')

    console.log(id);

    var request = new XMLHttpRequest();

    console.log("_____a");

    request.onreadystatechange = function () {

        console.log("_____b");

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.startedDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#viewstartDate1').val(today);

                var dE = new Date(obj.completedDate);
                let dateLE = dE.toISOString();
                var nowE = new Date(dateLE);
                var dayE = ("0" + nowE.getDate()).slice(-2);
                var monthE = ("0" + (nowE.getMonth() + 1)).slice(-2);
                var todayE = nowE.getFullYear() + "-" + (monthE) + "-" + (dayE);

                $('#viewendDate1').val(todayE);

                document.getElementById("viewProName1").setAttribute("value", obj.name);
                document.getElementById("viewProDes1").setAttribute("value", obj.description);
                document.getElementById("status1").setAttribute("value", obj.statusName);
                document.getElementById("viewProDocument").setAttribute("value", obj.projectDocuments);


                document.getElementById("clientView1").setAttribute("value", obj.generalOrganizationProfileName);
                document.getElementById("clientEmailView").setAttribute("value", obj.email);
                document.getElementById("clientMoNoView").setAttribute("value", obj.contactNo);
                document.getElementById("clientFaxNoView").setAttribute("value", obj.faxNo);
                document.getElementById("countryName1").setAttribute("value", obj.countryName);

                var imageNamePro = obj.logoUrl;
                console.log(imageNamePro);
                show_modal();

                viewProjectLogo(imageNamePro);

            }
        }
    };
    request.open("POST", "../ProjectDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

    viewProjectEmpList(id);

}

function viewProjectLogo(imageNamePro) {
    var imagename = imageNamePro;
    var imageUrl = "../ViewProjectLogo?imageName=" + imagename;

    var img = document.getElementById("imgProject");
    img.src = imageUrl;
    img.height = 250;
    img.width = 250;

    var imageContainer = document.getElementById("projectLogoView");
    imageContainer.appendChild(img);
    img.style.display = 'block';
}

function viewProjectEmpList(id) {

    console.log("Emp List :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____c");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("empTableBodyView");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var employee = data[i];

                    console.log(employee);

                    var name = employee.FirstName + " " + employee.LastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = name;
                    tr.appendChild(tdName);

                    var tdDesignation = document.createElement("td");
                    tdDesignation.textContent = employee.Designation;
                    tr.appendChild(tdDesignation);

                    var tdProjectRole = document.createElement("td");
                    tdProjectRole.textContent = employee.ProjectEmpRole;
                    tr.appendChild(tdProjectRole);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectEmpRoleListView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function  uploadClientDocument(id) {
    $("#uploadClientDocument").modal('show')

    document.getElementById("rowId").setAttribute("value", id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____g");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("agreementTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var proAgreement = data[i];

                    console.log(proAgreement);

                    var tr = document.createElement("tr");

                    var tdAgreement = document.createElement("td");
                    tdAgreement.textContent = proAgreement.document;
                    tr.appendChild(tdAgreement);

                    var tdUploadDate = document.createElement("td");
                    tdUploadDate.textContent = proAgreement.uploadedDate;
                    tr.appendChild(tdUploadDate);

                    var tdView = document.createElement("td");
                    tdView.innerHTML = `<button class="btn rounded-pill btn-outline-info" onclick="openPdf('${proAgreement.document}');">View</button>`;
                    tr.appendChild(tdView);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../ProjectAgreementHistoryView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);
}

function editProjectDetails(id) {
    $("#editProjectDetails").modal('show')

    document.getElementById("rowIdEdit").setAttribute("value", id);

    var request = new XMLHttpRequest();

    console.log("_____a");

    request.onreadystatechange = function () {

        console.log("_____b");

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.startedDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#startDate').val(today);

                var dE = new Date(obj.completedDate);
                let dateLE = dE.toISOString();
                var nowE = new Date(dateLE);
                var dayE = ("0" + nowE.getDate()).slice(-2);
                var monthE = ("0" + (nowE.getMonth() + 1)).slice(-2);
                var todayE = nowE.getFullYear() + "-" + (monthE) + "-" + (dayE);

                $('#endDate').val(todayE);


                document.getElementById("editProName1").setAttribute("value", obj.name);
                document.getElementById("editProDes1").setAttribute("value", obj.description);
                document.getElementById("editstatus1").setAttribute("value", obj.statusId);

                show_modal();

            }
        }
    };
    request.open("POST", "../ProjectDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

    editProjectEmpList(id);
}

function editProjectEmpList(id) {

    console.log("Emp List :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____c");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("empTableBodyEdit");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var employee = data[i];

                    console.log(employee);

                    var name = employee.FirstName + " " + employee.LastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = name;
                    tr.appendChild(tdName);

                    var tdDesignation = document.createElement("td");
                    tdDesignation.textContent = employee.Designation;
                    tr.appendChild(tdDesignation);

                    var tdProjectRole = document.createElement("td");
                    tdProjectRole.textContent = employee.ProjectEmpRole;
                    tr.appendChild(tdProjectRole);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectEmpRoleListView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

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




    $('#allEmpTableEditForm').show();




}

function deleteProjectDetails(id, isActive) {

    console.log("__id__ " + id + "__is active__ " + isActive);

    $.post('../UpdateProjectStatus', {
        status: isActive,
        id: id

    }, function (data) {
        const value = JSON.parse(data);

        console.log(value);

        if (value.status === 204) {
            alert("Do you want to Deactivate this project?");
            location.reload();

        } else if (value.status === 304) {
            alert("Do you want to Activate this project?");
            location.reload();


        } else {
            alert("Error");
        }
    });
}


function markIntime() {
    const nic = document.getElementById("employeeNic").value;
    const date = document.getElementById("date").value;
    const inTime = document.getElementById("inTime").value;
    const outTime = document.getElementById("outTime").value;
    $.post('../AttendanceMark', {
        nic: nic,
        date: date,
        inTime: inTime,
        outTime: outTime,
    }, function (data) {
        const value = JSON.parse(data);
        if (value.status === 200) {

            // Get a reference to the button element by its ID
            var button = document.getElementById("saveInTime");
            // Enable the button
            button.disabled = true;
            var button = document.getElementById("saveTime");
            // Enable the button
            button.disabled = false;
            var field = document.getElementById("inTime");
            field.value = inTime;

            Swal.fire({
                title: 'Save in time Marked',
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            });

            setTimeout(function () {
                location.reload();
            }, 10000);


        } else if (value.status === 300) {
            var button = document.getElementById("saveInTime");
            button.disabled = true;
            var button = document.getElementById("saveTime");
            button.disabled = true;
            var button = document.getElementById("markAttendance");
            button.disabled = false;



            setTimeout(function () {
                location.reload();
            }, 10000);

        } else if (value.status === 301) {
            var button = document.getElementById("saveInTime");
            button.disabled = true;
            var button = document.getElementById("saveTime");
            button.disabled = true;
            var button = document.getElementById("markAttendance");
            button.disabled = true;


            Swal.fire({
                title: 'Save in time Marked',
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true
            });
            alert("Attendance Marked Successfull !");
        }
    });
}


function checkAttendance() {
    const nic = document.getElementById("employeeNic").value;
    const date = document.getElementById("date").value;
    $.get('../checkAttendance', {
        nic: nic,
        date: date

    }, function (data) {
        const value = JSON.parse(data);
        if (value.status === 200) {
            var button = document.getElementById("saveInTime");
            button.disabled = false;
            var button = document.getElementById("saveTime");
            button.disabled = true;
            var button = document.getElementById("markAttendance");
            button.disabled = true;
        } else if (value.status === 300) {
            var button = document.getElementById("saveInTime");
            button.disabled = true;
            var button = document.getElementById("saveTime");
            button.disabled = false;
            var button = document.getElementById("markAttendance");
            button.disabled = true;
        } else if (value.status === 301) {
            var button = document.getElementById("saveInTime");
            button.disabled = true;
            var button = document.getElementById("saveTime");
            button.disabled = true;
            var button = document.getElementById("markAttendance");
            button.disabled = false;
        } else if (value.status === 302) {
            var button = document.getElementById("saveInTime");
            button.disabled = true;
            var button = document.getElementById("saveTime");
            button.disabled = true;
            var button = document.getElementById("markAttendance");
            button.disabled = true;
        } else {
            alert("Error");
        }
    });
}


function updateClock() {

    const inTimeclock = document.getElementById("inTime");
    const outTimeclock = document.getElementById("outTime");
    const nic = document.getElementById("employeeNic").value;
    const date = document.getElementById("date").value;
    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    const seconds = now.getSeconds().toString().padStart(2, '0');
    const clockString = `${hours}:${minutes}:${seconds}`;


    $.get('../AttendanceClockCheck', {
        nic: nic,
        date: date

    }, function (data) {
        const value = JSON.parse(data);
        if (value.status === 200) {
            inTimeclock.value = clockString;
            outTimeclock.value = clockString;

        } else if (value.status === 201) {
            inTimeclock.value = value.message;
            outTimeclock.value = clockString;

        } else if (value.status === 202) {
            inTimeclock.value = value.message;
            outTimeclock.value = value.message2;

        } else if (value.status === 203) {
            inTimeclock.value = value.message;
            outTimeclock.value = value.message2;





//           
            document.getElementById("AttendMarked").removeAttribute("hidden", "");

            //            Swal.fire({
//                title: 'Attendance have been Marked Successfully',
//                icon: 'success',
//                showConfirmButton: true,
//                allowOutsideClick: true,
//                allowEscapeKey: true
//            });

//            checkAttendance();


        } else {
            alert("Error");
        }
    });




}

function addClientEmployee(id) {
    $("#addNewClientEmployee").modal('show');

    document.getElementById("clientId").setAttribute("value", id);
}

function addNewRowNewClient() {
    event.preventDefault();

    var clientId = $('#clientId').val();
    var clientFirstName = $('#clientFirstName').val();
    var clientLastName = $('#clientLastName').val();
    var clientNic = $('#clientNic').val();
    var clientemail = $('#clientemail').val();
    var companycontactNo = $('#companycontactNo').val();
    var clientMobileNo = $('#clientMobileNo').val();

    if (clientFirstName === "") {
        document.getElementById("clientFirstNameError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientFirstNameError").setAttribute("hidden", "");
    }
    if (clientLastName === "") {
        document.getElementById("clientLastNameError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientLastNameError").setAttribute("hidden", "");
    }
    if (clientNic === "") {
        document.getElementById("clientNicError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientNicError").setAttribute("hidden", "");
    }
    if (clientemail === "") {
        document.getElementById("clientemailError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientemailError").setAttribute("hidden", "");
    }
    if (companycontactNo === "") {
        document.getElementById("companycontactNoError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("companycontactNoError").setAttribute("hidden", "");
    }
    if (clientMobileNo === "") {
        document.getElementById("clientMobileNoErrr").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientMobileNoErrr").setAttribute("hidden", "");
    }

    $("#addNewClientEmployee").modal('hide');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;

                console.log(data);

                const  output = JSON.parse(data);


                console.log(output);

                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }
                if (output.status === 400) {

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
    request.open("POST", "../CreateNewClient", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("clientId=" + clientId + "&clientFirstName=" + clientFirstName + "&clientLastName=" + clientLastName + "&clientNic=" + clientNic + "&clientemail=" + clientemail + "&companycontactNo=" + companycontactNo + "&clientMobileNo=" + clientMobileNo);
    return true;

}

function closeClientUpload() {
    $("#uploadClientDocument").modal('hide');
}

function closeEditProject() {
    $("#editProjectDetails").modal('hide');
}

function closeAddNewClient() {
    $("#addNewClientEmployee").modal('hide');
}

function viewClientDetails(id) {
    $("#viewClientData").modal('show')

    console.log(id);

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.createdDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#viewCliCreateDate').val(today);

                document.getElementById("viewCliName").setAttribute("value", obj.name);
                document.getElementById("viewCliAdd1").setAttribute("value", obj.address1);
                document.getElementById("viewCliAdd2").setAttribute("value", obj.address2);
                document.getElementById("viewCliAdd3").setAttribute("value", obj.address3);
                document.getElementById("CliEmail").setAttribute("value", obj.email);
                document.getElementById("viewCliContact").setAttribute("value", obj.contactNo);
                document.getElementById("viewCliFaxNo").setAttribute("value", obj.faxNo);
                document.getElementById("viewCliCountry").setAttribute("value", obj.country);

                var imageName = obj.logo;
                console.log(imageName);
                show_modal();


                viewClientLogo(imageName);

            }
        }
    };
    request.open("POST", "../ClientDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);

    viewClientTeamList(id);
    viewProjectListbyClient(id);
}


function viewClientTeamList(id) {

    console.log("Client Team List :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("ClientTeamTableBodyView");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var client_employee = data[i];

                    console.log(client_employee);

                    var cli_emp_name = client_employee.gupFirstName + " " + client_employee.gupLastName;

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = cli_emp_name;
                    tr.appendChild(tdName);

                    var tdNIC = document.createElement("td");
                    tdNIC.textContent = client_employee.gupNic;
                    tr.appendChild(tdNIC);

                    var tdEmail = document.createElement("td");
                    tdEmail.textContent = client_employee.gupEmail;
                    tr.appendChild(tdEmail);

                    var tdMobileNo = document.createElement("td");
                    tdMobileNo.textContent = client_employee.gupMobileNo;
                    tr.appendChild(tdMobileNo);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ClientTeamListView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function viewProjectListbyClient(id) {

    console.log("Project List by Client :" + id);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("ClientProListTableBodyView");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var projectList = data[i];

                    console.log(projectList);

                    var tr = document.createElement("tr");

                    var tdName = document.createElement("td");
                    tdName.textContent = projectList.proName;
                    tr.appendChild(tdName);

                    var tdStatus = document.createElement("td");
                    tdStatus.textContent = projectList.proStatus;
                    tr.appendChild(tdStatus);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectListbyClientView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function openPdf(docName) {
    const name = docName;

    const servletUrl = `../ViewPdfDocument?name=${encodeURIComponent(name)}`;

    // Call the servlet to retrieve the PDF
    fetch(servletUrl, {
        method: "GET",
        // You can add other headers or parameters as needed
    })
            .then(response => response.blob())
            .then(blob => {
                // Create a blob URL for the PDF data
                const pdfUrl = URL.createObjectURL(blob);

                // Open the PDF in a new tab/window
                window.open(pdfUrl, "_blank");
            })
            .catch(error => {
                console.error("Error fetching PDF:", error);
            });

}
function addNewRowEmpRoleEditForm() {

    event.preventDefault();

    var empEdit = document.getElementById("empNameEditForm");
    var valueEmpEdit = empEdit.value;
    var textEmpEdit = empEdit.options[empEdit.selectedIndex].text;

    var roleEdit = document.getElementById("projectroleEditForm");
    var valueRoleEdit = roleEdit.value;
    var textRoleEdit = roleEdit.options[roleEdit.selectedIndex].text;

    if (empEdit.value === "") {
        document.getElementById("empNameErrNotifyEditForm").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("empNameErrNotifyEditForm").setAttribute("hidden", "");
    }

    if (roleEdit.value === "") {
        document.getElementById("proRoleErrNotifyEditForm").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("proRoleErrNotifyEditForm").setAttribute("hidden", "");
    }

    $('#allEmpTableEditForm').show();

    var newRow = '<tr>' +
            '<td hidden><input type="hidden" name="valueEmpEdit[]" value="' + valueEmpEdit + '">' + valueEmpEdit + '</td>' +
            '<td><input type="hidden" name="textEmpEdit[]" value="' + textEmpEdit + '">' + textEmpEdit + '</td>' +
            '<td hidden><input type="hidden" name="valueRoleEdit[]" value="' + valueRoleEdit + '">' + valueRoleEdit + '</td>' +
            '<td><input type="hidden" name="textRoleEdit[]" value="' + textRoleEdit + '">' + textRoleEdit + '</td>' +
            '</tr>';

    $('#empTableBodyEditForm').append(newRow);

    $('#tableIntakeRowEditForm').css('display', 'block');


}


function editClientDetails(id) {

    $("#editClient").modal('show');

    document.getElementById("editClientId").setAttribute("value", id);

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var d = new Date(obj.createdDate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

                $('#editCliCreateDate').val(today);

                document.getElementById("editCliName").setAttribute("value", obj.name);
                document.getElementById("editCliAdd1").setAttribute("value", obj.address1);
                document.getElementById("editCliAdd2").setAttribute("value", obj.address2);
                document.getElementById("editCliAdd3").setAttribute("value", obj.address3);
                document.getElementById("editCliEmail").setAttribute("value", obj.email);
                document.getElementById("editCliContact").setAttribute("value", obj.contactNo);
                document.getElementById("editCliFaxNo").setAttribute("value", obj.faxNo);
                document.getElementById("editCliCountry").setAttribute("value", obj.country);
                show_modal();

            }
        }
    };
    request.open("POST", "../ClientDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);
}

function closeEditClient() {
    $("#editClient").modal('hide');
}

function editClientData() {
    event.preventDefault();

    var editClientId = $('#editClientId').val();
    var editCliAdd1 = $('#editCliAdd1').val();
    var editCliAdd2 = $('#editCliAdd2').val();
    var editCliAdd3 = $('#editCliAdd3').val();
    var editCliEmail = $('#editCliEmail').val();
    var editCliContact = $('#editCliContact').val();
    var editCliFaxNo = $('#editCliFaxNo').val();

    $("#editClient").modal('hide');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;

                console.log(data);

                const  output = JSON.parse(data);


                console.log(output);

                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }
                if (output.status === 400) {

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
    request.open("POST", "../EditClientDetails", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("editClientId=" + editClientId + "&editCliAdd1=" + editCliAdd1 + "&editCliAdd2=" + editCliAdd2 + "&editCliAdd3=" + editCliAdd3 + "&editCliEmail=" + editCliEmail + "&editCliContact=" + editCliContact + "&editCliFaxNo=" + editCliFaxNo);
}

function viewClientLogo(image) {
    var imagename = image;
    var imageUrl = "../ViewClientLogo?imageName=" + imagename;

    var img = document.getElementById("imgClient");
//    var img = document.createElement("img");
    img.src = imageUrl;
    img.height = 250;
    img.width = 250;

    var imageContainer = document.getElementById("clientLogoView");
    imageContainer.appendChild(img);
    img.style.display = 'block';
}


function openProjectDocument() {

    const projectDoc = $('#viewProDocument').val();

    const servlet = `../ViewProjectDocs?projectDoc=${encodeURIComponent(projectDoc)}`;

    fetch(servlet, {
        method: "GET",
    })
            .then(response => response.blob())
            .then(blob => {
                const pdfUrl = URL.createObjectURL(blob);

                window.open(pdfUrl, "_blank");
            })
            .catch(error => {
                console.error("Error fetching PDF:", error);
            });
}

function filterTable() {

    const allCheckbox = document.getElementById("all");

    const pendingCheckbox = document.getElementById("pending");
    const ongoingCheckbox = document.getElementById("ongoing");
    const completedCheckbox = document.getElementById("completed");

    // Get all table rows
    const rows = document.querySelectorAll("#table_projects tbody tr");

    // Iterate through rows and apply filtering
    rows.forEach(row => {
        const statusCell = row.querySelector('td:nth-child(3)');
        const status = statusCell.textContent.trim();

        // Check the Leave Approval Status and toggle row visibility
        if ((allCheckbox.checked || (pendingCheckbox.checked && status === 'Pending') ||
                (ongoingCheckbox.checked && status === 'Ongoing') ||
                (completedCheckbox.checked && status === 'Completed'))) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
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


function leaveCheck() {

    //Leave Reason
    const LeaveReasonRadio = document.querySelectorAll('input[type="radio"][name="reasonLeave"]');

    let ReasonLeave = null;

    LeaveReasonRadio.forEach(radioButton => {
        if (radioButton.checked) {
            ReasonLeave = radioButton.value;
        }
    });



    if (ReasonLeave !== null) {
        console.log("Selected value:", ReasonLeave);

    } else {
        console.log("No radio button is selected.");
    }

    //Leave Type

    const LeaveTypeRadio = document.querySelectorAll('input[type="radio"][name="LeaveType"]');

    let selectedLeaveButtonValue = null;

    LeaveTypeRadio.forEach(radioButton => {
        if (radioButton.checked) {
            selectedLeaveButtonValue = radioButton.value;
        }
    });

    if (selectedLeaveButtonValue !== null) {
        console.log("Selected radio button value:", selectedLeaveButtonValue);

    } else {
        console.log("No radio button is selected.");
    }

    const leaveType = selectedLeaveButtonValue;

    console.log("Selected leagve button value:", leaveType);



    //AM OR PM

    var dayType = null;

    if (leaveType === "Half Day") {

        const ampm = document.querySelectorAll('input[type="radio"][name="dayTime"]');

        let selectedDayTypeButtonValue = null;

        ampm.forEach(radioButton => {
            if (radioButton.checked) {
                selectedDayTypeButtonValue = radioButton.value;
            }
        });

        var dayType = selectedDayTypeButtonValue;
        console.log("Selected daytype button value:", dayType);
    }



    document.getElementById("commentField").setAttribute("hidden", "");
    document.getElementById("fulldayVali").setAttribute("hidden", "");
    document.getElementById("halfdayVali").setAttribute("hidden", "");
    document.getElementById("shortfdayVali").setAttribute("hidden", "");

    const reqDate = document.getElementById("reqDate").value;
    const nic = document.getElementById("empNic").value;
    const comment = document.getElementById("leaveComment").value;
    const startdate = document.getElementById("startdate1").value;
    const enddate = document.getElementById("enddate1").value;
    const halfDate = document.getElementById("halfDate").value;
    const shTimeFrom = document.getElementById("shTimeFrom").value;
    const shTimeTo = document.getElementById("shTimeTo").value;
    const shortLeaveDate = document.getElementById("shortLeaveDate").value;



    if (comment === "") {
        document.getElementById("commentField").removeAttribute("hidden");
    } else if (leaveType === "FullDay" && (enddate === "" || startdate === "")) {
        alert(startdate + enddate);
        document.getElementById("fulldayVali").removeAttribute("hidden");
    } else if (leaveType === "Half Day" && halfDate === "") {
        document.getElementById("halfdayVali").removeAttribute("hidden");
    } else if (leaveType === "Short Leave" && (shTimeFrom === "" || shTimeTo === "" || shortLeaveDate === "")) {
        document.getElementById("shortfdayVali").removeAttribute("hidden");
        alert("asacs");
    } else {
        $.post('.././LeaveRequestHandle', {
            reqdate: reqDate,
            nic: nic,
            reasonLeave: ReasonLeave,
            comment: comment,
            leaveType: leaveType,
            startdate: startdate,
            enddate: enddate,
            dayType: dayType,
            halfDate: halfDate,
            shTimeFrom: shTimeFrom,
            shTimeTo: shTimeTo,
            shortLeaveDate: shortLeaveDate


        }, function (data) {
            const value = JSON.parse(data);
            if (value.status === 201) {
                Swal.fire({
                    title: 'Full Day Leave Requested',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });
                setTimeout(function () {
                    location.reload();
                }, 2000);


            } else if (value.status === 202) {
                Swal.fire({
                    title: 'Half Day Leave Requested',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });
                setTimeout(function () {
                    location.reload();
                }, 2000);


            } else if (value.status === 203) {
                Swal.fire({
                    title: 'Short Leaave Requested',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });

                setTimeout(function () {
                    location.reload();
                }, 2000);



            } else if (value.status === 300) {
                Swal.fire({
                    title: 'Leave Request is not successfull',
                    icon: 'error',
                    showConfirmButton: false,
                    allowOutsideClick: true,
                    allowEscapeKey: true

                });
                setTimeout(function () {
                    location.reload();
                }, 10000);

            } else {
                alert("Error");
            }
        });

    }
}




function clearFelds() {

    Swal.fire({
        title: 'Fields Cleared Successfully',
        icon: 'success',
        showConfirmButton: false,
        allowOutsideClick: true,
        allowEscapeKey: true

    });
    setTimeout(function () {
        location.reload();
    }, 1000);

}



function performSearch() {
    const searchInput = document.getElementById('searchInput');
    const searchTerm = searchInput.value.toLowerCase();
    const tableRows = document.querySelectorAll('#table_projects tbody tr');

    tableRows.forEach(row => {
        const rowData = row.getAttribute('data-search').toLowerCase();
        if (rowData.includes(searchTerm)) {
            row.style.display = ''; // Show the row
        } else {
            row.style.display = 'none'; // Hide the row
        }
    });
}

function performFiltering() {
    const allCheckbox = document.getElementById('all');
    const pendingCheckbox = document.getElementById('pending');
    const approvedCheckbox = document.getElementById('approved');
    const declinedCheckbox = document.getElementById('declined');

    // Get all table rows
    const rows = document.querySelectorAll('#table_projects tbody tr');

    // Iterate through rows and apply filtering
    rows.forEach(row => {
        const statusCell = row.querySelector('td:last-child');
        const status = statusCell.textContent.trim();

        // Check the Leave Approval Status and toggle row visibility
        if ((allCheckbox.checked || (pendingCheckbox.checked && status === 'Pending') ||
                (approvedCheckbox.checked && status === 'Approved') ||
                (declinedCheckbox.checked && status === 'Decline'))) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}


function performSearchByDate() {
    // Get the start and end date inputs
    var startDateInput = document.getElementById("startdate");
    var endDateInput = document.getElementById("enddate");

    // Get the table body where the data is displayed
    var tableBody = document.getElementById("tableempbody");

    // Get all table rows
    var rows = tableBody.getElementsByTagName("tr");

    // Get the start and end dates from the input fields
    var startDate = new Date(startDateInput.value);
    var endDate = new Date(endDateInput.value);

    // Loop through each row in the table
    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var dateCell = row.getElementsByTagName("td")[2]; // Assuming the date is in the third column (index 2)

        if (dateCell) {
            var rowDate = new Date(dateCell.textContent);

            // Check if the row's date is within the specified range
            if (rowDate >= startDate && rowDate <= endDate) {
                row.style.display = ""; // Show the row
            } else {
                row.style.display = "none"; // Hide the row
            }
        }
    }
}


function editApproval(id, appID) {

    var id;
    var appID;



    $("#ViewApprovalStatus").modal('show')

    const myButton = document.getElementById('approveLeave');
    const myButton1 = document.getElementById('DeclineLeave');


    const myButton2 = document.getElementById('CancelApproval');

    myButton2.addEventListener('click', function () {
        $("#ViewApprovalStatus").modal('hide')


    });

    myButton.addEventListener('click', function () {



        $.post('.././LeaveApprovalHandle', {
            id: id,
            approve: "Approved",
            approveby: appID

        }, function (data) {
            const value = JSON.parse(data);
            if (value.status === 201) {

                $("#ViewApprovalStatus").modal('hide')

                Swal.fire({

                    title: 'Leave Request Approved',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });
                setTimeout(function () {
                    location.reload();
                }, 2000);


            } else if (value.status === 202) {

                $("#ViewApprovalStatus").modal('hide')

                Swal.fire({

                    title: 'Error Occured',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });
                setTimeout(function () {
                    location.reload();
                }, 2000);

            } else {
                alert("Error");
            }
        });

    });

    myButton1.addEventListener('click', function () {



        $.post('.././LeaveApprovalHandle', {
            id: id,
            approve: "Decline",
            approveby: appID

        }, function (data) {
            const value = JSON.parse(data);
            if (value.status === 201) {

                $("#ViewApprovalStatus").modal('hide')

                Swal.fire({

                    title: 'Leave Requested Declined',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });
                setTimeout(function () {
                    location.reload();
                }, 2000);


            } else if (value.status === 202) {
                $("#ViewApprovalStatus").modal('hide')

                Swal.fire({

                    title: 'Error Occured',
                    icon: 'error',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true
                });
                setTimeout(function () {
                    location.reload();
                }, 2000);

            } else {
                alert("Error");
            }
        });

    });




    console.log('Button clicked!');


}









function  viewCedentialData(idc) {
 //var id = $('#viewCred').val();
   
    console.log(idc);

    var request = new XMLHttpRequest();

    

    request.onreadystatechange = function () {

      
        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
  document.getElementById("credentialType").innerHTML = obj.type;
  document.getElementById("actioanid").setAttribute("value",obj.id);
                document.getElementById("credentialRole").innerHTML=obj.roll;
                document.getElementById("credentialstatus").innerHTML =obj.status;
                
                   var d = new Date(obj.createddate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

              
document.getElementById("credentialCreateDate").innerHTML =today;
                document.getElementById("credentialCategory").innerHTML =obj.category;
                document.getElementById("credentialProject").innerHTML = obj.project;
                document.getElementById("credentiaLastEditBy").innerHTML = obj.employeename;
                document.getElementById("credentialUsername").innerHTML = obj.username;
          
                       document.getElementById("credentialNote").innerHTML =obj.note;
             
              $("#viewCedentialData").modal('show');
   show_modal();
               

            }
        }
    };
    request.open("POST", "../CredentialDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

    

}
function editCredentials(idc) {
  
    $("#editCredModel").modal('show');

   
    var request = new XMLHttpRequest();


    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                
      document.getElementById("credIdEdit").setAttribute("value", obj.id);
       
                document.getElementById("credUsernameEdit").setAttribute("value", obj.username);
       
  

    show_modal();

            }
        }
    };
    request.open("POST", "../CredentialDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

}



function validate_Credential_edit(){
    var credId = $('#credIdEdit').val();               
   var credUsername = $('#credUsernameEdit').val();
    var password = $('#passwordEdit').val();
    var note = $('#credNoteEdit').val();
     var emp = $('#credEmpinptEdit').val();
    
    
  
   if (credUsername === "") {
        document.getElementById("cerdUsernameErrorNotify").removeAttribute("hidden");
            $("#validateEditCredModel").modal('show');
    } else if (password === "") {
        document.getElementById("credPasswordErrorNotify").removeAttribute("hidden");
            $("#validateEditCredModel").modal('show');
    }else if (note === "") {
            document.getElementById("credReasonErrorNotify").removeAttribute("hidden");
                $("#validateEditCredModel").modal('show');
     
    }else{
      $.post('.././EditUserCredential', {
       
        id: credId,
        username:credUsername,
        password:password,
note : note,
emp :emp

  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });     
    }

 
}



function  viewCedentialAccessData(idc) {
 //var id = $('#viewCred').val();
   
    console.log(idc);

    var request = new XMLHttpRequest();

    

    request.onreadystatechange = function () {

      
        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
                document.getElementById("actioanidforinactive").setAttribute("value",idc);
  document.getElementById("projectSpanAc").innerHTML = obj.project;
                document.getElementById("employeeSpanAc").innerHTML=obj.employeename;
                document.getElementById("roleSpanAc").innerHTML =obj.roll;
                
                   var d = new Date(obj.lastchangeddate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var lastCDate = now.getFullYear() + "-" + (month) + "-" + (day);

              
document.getElementById("lastDateSpanAc").innerHTML =lastCDate;
                document.getElementById("statusSpanAc").innerHTML =obj.status;
                document.getElementById("empStatusSpanAc").innerHTML = obj.assigned;
                document.getElementById("credCatSpanAc").innerHTML = obj.category;
                document.getElementById("typeSpanAc").innerHTML = obj.type;
                               var dx = new Date(obj.assigndate);
                let dateLx = dx.toISOString();
                var nowx = new Date(dateLx);
                var dayx = ("0" + nowx.getDate()).slice(-2);
                var monthx = ("0" + (nowx.getMonth() + 1)).slice(-2);
                var assingDate = nowx.getFullYear() + "-" + (monthx) + "-" + (dayx);
                
                document.getElementById("assignedSpanAc").innerHTML = assingDate;
                       document.getElementById("viewedSpanAc").innerHTML =obj.viewed;
                 document.getElementById("idSpanAc").innerHTML =obj.id;
              $("#viewCredAccessModel").modal('show');
   show_modal();
               

            }
        }
    };
    request.open("POST", "../CredentialDataAccessView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

    

}

function  viewCedentialEmployeeAccessData(idc) {
 //var id = $('#viewCred').val();
   
    console.log(idc);

    var request = new XMLHttpRequest();

    

    request.onreadystatechange = function () {

      
        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
                if(obj===null){
                  document.getElementById("first_time_request").style.display= "none"; 
                      document.getElementById("next_time_request").style.display=""; 
                                       document.getElementById("forcredentialId").setAttribute("value",idc) ;
                    $("#viewCedentialEmployeeAccessData").modal('show');
   show_modal();
                }else{
                      document.getElementById("first_time_request").style.display= ""; 
                         document.getElementById("next_time_request").style.display="none";  
               
                 document.getElementById("typeSpanEmp").innerHTML = obj.type;
                document.getElementById("roleSpanEmp").innerHTML=obj.roll;
                document.getElementById("catSpanEmp").innerHTML =obj.category;
                
                   var d = new Date(obj.assigndate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var today = now.getFullYear() + "-" + (month) + "-" + (day);

              
document.getElementById("createDateSpanEmp").innerHTML =today;
                document.getElementById("projectSpanEmp").innerHTML =obj.category;
                document.getElementById("projectSpanEmp").innerHTML = obj.project;
                document.getElementById("usernameSpanEmp").innerHTML = obj.username;
                document.getElementById("passwordSpanEmp").innerHTML = obj.password;
                document.getElementById("noteSpanEmp").innerHTML = obj.note;
                    
              $("#viewCedentialEmployeeAccessData").modal('show');
   show_modal();
             update_view_Credential(idc) ;    
                }
  

            }
        }
    };
    request.open("POST", "../CredentialEmployeeDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

    

}

function update_view_Credential(id){
   
   



 $.post('.././EditEmployeeCredentialView', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });    
}



function approveCedentialViewRequest(id){
 
    


   $.post('.././ApproveCedentialViewRequest', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });    
}


function deleteCredentials(id){
 


   $.post('.././DeleteCredentials', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });    
}

function assignIsActiveCredential(id){
  


    $.post('.././ActivateCredential', {
       
        id: id


     }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
           
 pageLoad();

        }  else {
            alert("Error");
 pageLoad();

        }



    });

   
 
}
function pageLoad(){
    location.reload();   
}


function activateEmployeeCredAccess(){
      var id = $('#actioanConfirmidforinactive').val();
  
   


    
         
    $.post('.././CreateAccessEmployeeCredential', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
         document.getElementById('credIdInactiveEdit').setAttribute("value",id) ;
      $('#inactiveConfirmModel').hide();
         $('#viewCredAccessModel').hide();
         $("#editCredAfterInactiveModel").modal('show');    
            show_modal();
        }  else {
            alert("Error");

 pageLoad();
        }



    });    
}




function assignDeactivateCredential(){
  
 var id = $('#actioanConfirmid').val();
    $.post('.././DeactivateCredential', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          
location.reload();
 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });
   

}

function  viewCedentialNotificationData(idc) {
 //var id = $('#viewCred').val();
   
    console.log(idc);

    var request = new XMLHttpRequest();

    

    request.onreadystatechange = function () {

      
        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
  document.getElementById("credNotificationNumberSpan").innerHTML = obj.id;
                document.getElementById("credNotificationtypeSpan").innerHTML=obj.notificationtypeid;
                document.getElementById("credNotificationDescriptionSpan").innerHTML =obj.description;
                
                   var d = new Date(obj.notifydate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var date = now.getFullYear() + "-" + (month) + "-" + (day);
        document.getElementById("credNotificationDateSpan").innerHTML = date;
              
             
             
              $("#viewCredNotificationModel").modal('show');
   show_modal();
           update_view_Cred_Notification(idc) ;   
  
            }
        }
    };
    request.open("POST", "../CredentialNotificationDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

    

}


function deleteCedentialNotificationData(id){
 
   


  $.post('.././DeleteCedentialNotificationData', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });     
}





function update_view_Cred_Notification(id){
   
   



 $.post('.././EditCredentialNotificationManager', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 
        }  else {
            alert("Error");

 pageLoad();
        }



    });    
}

function confirmDeactivate(){
     var id = $('#actioanid').val();
      document.getElementById("actioanConfirmid").setAttribute("value",id);
             
              $("#deactivateConfirmModel").modal('show');
              show_modal();
}

     
function confirmInactive(){
     var id = $('#actioanidforinactive').val();
      document.getElementById("actioanConfirmidforinactive").setAttribute("value",id);
             
              $("#inactiveConfirmModel").modal('show');
              show_modal();
} 
function validate_Credential_edit_after_inactive(){
    var credId = $('#credIdInactiveEdit').val();               
   var credUsername = $('#credUsernameEditIn').val();
    var password = $('#passwordEditIn').val();
    var note = $('#credNoteEditIn').val();
     var emp = $('#credEmpinptEditIn').val();
    
    
  
   if (credUsername === "") {
        document.getElementById("cerdUsernameErrorNotify").removeAttribute("hidden");
            $("#validateEditCredAfterInaciteEditModel").modal('show');
    } else if (password === "") {
        document.getElementById("credPasswordErrorNotify").removeAttribute("hidden");
            $("#validateEditCredAfterInaciteEditModel").modal('show');
    }else if (note === "") {
            document.getElementById("credReasonErrorNotify").removeAttribute("hidden");
                $("#validateEditCredAfterInaciteEditModel").modal('show');
     
    }else{
      $.post('.././EditUserCredentialAfterInactive', {
       
        id: credId,
        username:credUsername,
        password:password,
note : note,
emp :emp

  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });     
    }

 
}
function sendEmailCred() {
     var credIssuId = $('#credIdInactiveEdit').val();               
   var username = $('#credUsernameEditIn').val();
    var password = $('#passwordEditIn').val();
    var reason = $('#credNoteEditIn').val();
     var editby = $('#credEmpinptEditIn').val();
    var request = new XMLHttpRequest();


    request.open("POST", "../SendCredentialsEmail", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("username=" + username + "&password=" + password + "&reason=" + reason + "&editby=" + editby+"&id="+credIssuId);


}

function updateRequest(id){
 
    


   $.post('.././ApproveCedentialViewRequestUpdate', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          

 pageLoad();
        }  else {
            alert("Error");

 pageLoad();
        }



    });    
}