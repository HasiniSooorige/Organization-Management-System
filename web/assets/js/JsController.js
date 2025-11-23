/* global tinymce, URL, fetch, Swal */

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

function employee_registration() {

    var epf_no = $('#epf_num').val();
    var organization_by = $('#branch').val;
    var nic = $('#nic').val();
    var designation = $('#designation').val();
    var gender = $('#gender').val();
    var country_id = $('#country_id').val();
    var first_name = $('#first_name').val();
    var last_name = $('#last_name').val();
    var address1 = $('#address1').val();
    var address2 = $('#address2').val();
    var address3 = $('#address3').val();
    var mobile_no = $('#mobile_no').val();
    var home_no = $('#home_no').val();
    var email = $('#email').val();
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
    var confirmmsg = confirm("Do you want to continue ?");
    if (confirmmsg) {


        $.post('../CreateUserProfile', {
            'first_name': first_name,
            'nic': nic,
            'last_name': last_name,
            'address1': address1,
            'address2': address2,
            'address3': address3,
            'mobile_no': mobile_no,
            'home_no': home_no,
            'email': email,
            'country_id': country_id,
            'epf_no': epf_no,
            'designation': designation,
            'gender': gender

        }, function (data) {
            if (data.status === 200) {
                sendMail();
                field_clear();
            }
            alert(data.message);
        });
    }

}

function validate_Employee_edit(frm) {

    var epf_no = $('#epf_no').val();
    var nic = $('#nic_edit').val();
    var first_name = $('#first_name_edit').val();
    var last_name = $('#last_name_edit').val();
    var email = $('#email_edit').val();
    var mobile_no = $('#mobile_no_edit').val();
    var address1 = $('#address1_edit').val();
    var address2 = $('#address2_edit').val();
    var address3 = $('#address3_edit').val();
    var home_no = $('#home_no_edit').val();
    var designation = $('#designation').val();


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
        document.getElementById("homeno_correctErrNotify").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("homeno_correctErrNotify").setAttribute("hidden", "");
    }

    $("#EmpEditModel").modal('hide');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {

                var data = request.response;


                var output = JSON.parse(data);
                if (output.status === 200) {
                    Swal.fire({
                        title: "Employee Details Updated Successfully!",
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
    request.open("POST", "../EditEmployeeDataSave", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("designation=" + designation + "&epf_no=" + epf_no + "&nic=" + nic + "&first_name=" + first_name + "&last_name=" + last_name + "&address1=" + address1 + "&address2=" + address2 + "&address3=" + address3 + "&mobile_no=" + mobile_no + "&home_no=" + home_no + "&email=" + email);




    return true;
}

function loadusers_all() {

    $.get('../ReadUsersAll', function (data) {

        $('#table_allusers').DataTable({

            columns: [

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
                        return`<i id="viewBtnOnclick"  type="button" class="far fa-eye" onclick="viewRowData('${itemView.id}');" ></i>`;
                    }
                },
                {
                    title: 'Action',
                    data: null,
                    wrap: true,
                    render: function (data) {
                        var buttonText = "";
                        if (data.isactive === 0) {
                            buttonText = 'Inactive';
                        } else {
                            buttonText = 'Active';
                        }

                        return `<button class="btn rounded-pill btn-danger" id="Isactive" onclick="handleClick_action('${data.epfno}', '${data.isactive}');">${buttonText}</button>`;
                    }


                }
                ,
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

    $("#EmpDocUploadModel").modal('show');

    document.getElementById("empId").setAttribute("value", value);

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        console.log("_____g");

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("empDocumentTableBody");

                tbody.innerHTML = "";

                for (var i = 0; i < data.length; i++) {
                    var empDocument = data[i];

                    console.log(empDocument);

                    var tr = document.createElement("tr");

                    var tdDocType = document.createElement("td");
                    tdDocType.textContent = empDocument.documenttypename;
                    tr.appendChild(tdDocType);

                    var tdDocName = document.createElement("td");
                    tdDocName.textContent = empDocument.name;
                    tr.appendChild(tdDocName);

                    var tdDocument = document.createElement("td");
                    tdDocument.textContent = empDocument.url;
                    tr.appendChild(tdDocument);

                    var tdView = document.createElement("td");
                    tdView.innerHTML = `<button class="btn rounded-pill btn-outline-info" onclick="openDocument('${empDocument.url}');">View</button>`;
                    tr.appendChild(tdView);

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };

    req.open("POST", "../EmployeeDocumentHistoryView", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + value);


}

function handleClick_action(id1, status) {

    console.log("Id  :" + id1);
    console.log("Status  :" + status);

    $.post('.././UpdateActiveStatus', {
        valuechecked: status,
        nic: id1


    }, function (data) {
        const value = JSON.parse(data);
        if (value.status === 204) {
            alert("Do you want to Activate this Employee Account?");
            location.reload();
        } else if (value.status === 304) {
            alert("Do you want to Deactivate this Employee Account?");
            location.reload();
        } else {
            alert("Error");
        }
    });
}

function viewRowData(value) {

    edit_data_load_view(value);
}

function edit_data_load_view(value) {

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
                document.getElementById("organization_by1").setAttribute("value", obj.generalorganizationname);
                document.getElementById("designation1").setAttribute("value", obj.designation);
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
    Resignation(value);
    document.getElementById("inputid").value = value;
}

function Resignation(value) {

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

    $("#EmpEditModel").modal('show');

    var epf_no = value;
    edit_data_load(epf_no);

    Load_Designation();
}

function Organization_by() {

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
// var list1 = document.getElementById('designation');
//var newOp1 = document.createElement("option");
//newOp1.text = ""+obj.designation;
////newOp.value = "1";
//list1.options.add(newOp1);



//                document.getElementById("designation").innerHTML = request.response;
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
    request.send("uuser=" + uuser + "&upassword=" + upassword);

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

    var country_id = document.getElementById("country_id");
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

function login_validate() {

    $("#btn-log").hide();
    $("#spinning-loading").show();

    var uuser = document.getElementById("email").value;
    var upassword = document.getElementById("password").value;

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
                if (output[0].idURoll === 4) {
                    window.location = "main-pages/" + output[0].link;
                }
            } else {
                alert(output[0].message)
            }
        }
        $("#btn-log").show();
        $("#spinning-loading").hide();
    };

    request.open("POST", "SelectLogin", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("uuser=" + uuser + "&upassword=" + upassword);


}

function Loaduser_Profiles() {

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                var data = request.response;
                var json = JSON.parse(data);

                const today = new Date(); // today's date
                const tomorrow = new Date(today.setDate(today.getDate() + 1)); // tomorrow's date

                document.getElementById('regisered').value = tomorrow.toISOString().split('T')[0];

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

            }
        }
    };
    request.open("POST", "../create_employee_regsitration", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("nic=" + nic);
}

function Loadfk() {

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
    request.open("POST", "SelectEpfNo", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send();
}



function edit_data_load(epf_no) {
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

                $('#regisered').val(today);


                document.getElementById("epf_no").setAttribute("value", obj.epfno);
                document.getElementById("generalorganizationname").setAttribute("value", obj.generalorganizationname);
                document.getElementById("gender_edit").setAttribute("value", obj.gender);
                document.getElementById("nic_edit").setAttribute("value", obj.nic);
                document.getElementById("first_name_edit").setAttribute("value", obj.firstname);
                document.getElementById("last_name_edit").setAttribute("value", obj.lastname);
                document.getElementById("email_edit").setAttribute("value", obj.email);
                document.getElementById("mobile_no_edit").setAttribute("value", obj.mobileno);
                document.getElementById("address1_edit").setAttribute("value", obj.address1);
                document.getElementById("address2_edit").setAttribute("value", obj.address2);
                document.getElementById("address3_edit").setAttribute("value", obj.address3);
                document.getElementById("home_no_edit").setAttribute("value", obj.homeno);
                document.getElementById("coutry").setAttribute("value", obj.coutry);

            }
        }
    };
    request.open("POST", "../EditEmployeeData", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("epfno=" + epf_no);
}

function edit_data_load_g() {
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

function close_employee_edit() {
    $("#EmpEditModel").modal('hide');
}

function change_password(frm) {

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

    if (minDate === "") {
        document.getElementById("startdateErrNotify").removeAttribute("hidden");
        document.getElementById("startdate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("startdateErrNotify").setAttribute("hidden", "");
        document.getElementById("startdate").style.borderColor = '';
    }
    
    if (maxDate === "") {
        document.getElementById("enddateErrNotify").removeAttribute("hidden");
        document.getElementById("enddate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("enddateErrNotify").setAttribute("hidden", "");
        document.getElementById("enddate").style.borderColor = '';
    }

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

function ResignationSave() {

    var resignation = document.getElementById("resignation").value;
    var id = document.getElementById("inputid").value;

    if (resignation === "") {
        document.getElementById("resignationDateError").removeAttribute("hidden");
        return false;

    } else {
        document.getElementById("resignationDateError").setAttribute("hidden", "");

    }

    $("#ResignationModal").modal('hide');
    let jsonObject = {
        "res": resignation,
        "id": id
    }

    let jsonString = JSON.stringify(jsonObject);
    let request = new XMLHttpRequest();
    request.onreadystatechange = function () {
        if (this.readyState === 4) {
            if (this.status === 200) {
                let data = this.response;
                let resp = JSON.parse(data);
                if (resp.status === 200) {
                    Swal.fire({
                        title: resp.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });


                } else if (resp.status === 500) {

                    Swal.fire({
                        title: resp.message,
                        icon: 'warning',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    });
                }

            }
        }
    };

    request.open("POST", "../SaveResignation", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send(jsonString);
    return true;

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
        if (r.readyState === 4 && r.status === 200) {
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
//                var tdAction = document.createElement("td");
//                tdAction.innerHTML = `<div class="col-3 text-end">
//                                    <div class="form-check form-switch">
//                                        <input class="form-check-input float-end" onclick="handleClick_action(this,'${employee.nic}');" type="checkbox" role="switch" />
//                                    </div>
//                                </div>`;

                var tdView = document.createElement("td");
                tdView.innerHTML = `<i id="viewBtnOnclick" type="button" class="far fa-eye" onclick="viewRowData('${employee.id}');"></i>`;
                tr.appendChild(tdView);
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

function saveNewProject() {
    alert(1);

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

                var proName = document.getElementById("viewProName1");
                proName.value = obj.name;

                var proDescription = document.getElementById("viewProDes1");
                proDescription.value = obj.description;

                document.getElementById("status1").setAttribute("value", obj.statusName);
                document.getElementById("viewProDocument").setAttribute("value", obj.projectDocuments);

                if (obj.projectDocuments === null || "") {
                    $('#proDocumentName').css('display', 'none');
                    $('#proDocumentDiv').css('display', 'none');
                } else {
                    $('#proDocumentName').css('display', 'block');
                    $('#proDocumentDiv').css('display', 'block');
                }

                var proClient = document.getElementById("clientView1");
                proClient.value = obj.generalOrganizationProfileName;

                document.getElementById("clientEmailView").setAttribute("value", obj.email);
                document.getElementById("clientMoNoView").setAttribute("value", obj.contactNo);
                document.getElementById("clientFaxNoView").setAttribute("value", obj.faxNo);
                document.getElementById("countryName1").setAttribute("value", obj.countryName);

                var imageNamePro = obj.logoUrl;
                console.log(imageNamePro);

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

function leaveCheck() {

    //Leave Reason
    const LeaveReasonRadio = document.querySelectorAll('input[type="radio"][name="reasonLeave"]');

//    let ReasonLeave = null;

    const selectElement = document.getElementById('leaveSelect');

// Get the selected value
    const ReasonLeave = selectElement.value;


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



    document.getElementById("selectError").setAttribute("hidden", "");
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

    if (ReasonLeave === "Select") {
        alert("OK")
        document.getElementById("selectError").removeAttribute("hidden");
    } else if (comment === "") {
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

function editProjectDetails(id) {
    $("#editProjectDetails").modal('show');

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

            }
        }
    };
    request.open("POST", "../ProjectDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + id);
}

function ProjectTeamDetails(id) {
    $("#projectTeamtDetails").modal('show');
    document.getElementById("rowIdProTeam").setAttribute("value", id);
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

                    if (employee.IsActive === true) {
                        var tdProjectIsActive = document.createElement("td");
                        tdProjectIsActive.textContent = "Active";
                        tdProjectIsActive.style.color = "green";
                        tr.appendChild(tdProjectIsActive);

                        var tdProjecRemoveButton = document.createElement("td");
                        tdProjecRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-danger" style="width: 100px;" onclick="activeEmp('${id}', '${employee.EmpId}', '${employee.ProEmpRoleId}', '${employee.IsActive}');">Remove</button>`;
                        tr.appendChild(tdProjecRemoveButton);
                    } else {
                        var tdProjectIsActive = document.createElement("td");
                        tdProjectIsActive.textContent = "Inactive";
                        tdProjectIsActive.style.color = "red";
                        tr.appendChild(tdProjectIsActive);

                        var tdProjecRemoveButton = document.createElement("td");
                        tdProjecRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-success" style="width: 100px;" onclick="activeEmp('${id}', '${employee.EmpId}', '${employee.ProEmpRoleId}', '${employee.IsActive}');">Add</button>`;
                        tr.appendChild(tdProjecRemoveButton);
                    }


                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ProjectEmpRoleListEdit", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);

}

function activeEmp(projectId, empId, roleId, status) {

    $("#projectTeamtDetails").modal('hide');

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
    request.open("POST", "../ProjectTeamStatusUpdate", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("projectId=" + projectId + "&empId=" + empId + "&roleId=" + roleId + "&status=" + status);
    return true;
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

    document.getElementById("empNameEditForm").selectedIndex = 0;
    document.getElementById("projectroleEditForm").selectedIndex = 0;

}

function deleteProjectDetails(id, isActive) {

    console.log("__id__ " + id + "__is active__ " + isActive);

    $.post('.././UpdateProjectStatus', {
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
            button.disabled = true;
            var button = document.getElementById("saveTime");
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

    $.get('.././checkAttendance', {
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


    $.get('.././AttendanceClockCheck', {
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


//           
            document.getElementById("AttendMarked").removeAttribute("hidden", "");

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
    if (!validate_nic(clientNic)) {
        document.getElementById("clientNicinvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientNicinvalidError").setAttribute("hidden", "");
    }
    if (clientemail === "") {
        document.getElementById("clientemailError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientemailError").setAttribute("hidden", "");
    }
    if (!validateEmail(clientemail)) {
        document.getElementById("clientemailInvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientemailInvalidError").setAttribute("hidden", "");
    }
    if (companycontactNo === "") {
        document.getElementById("companycontactNoError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("companycontactNoError").setAttribute("hidden", "");
    }
    if (!validate_phone(companycontactNo)) {
        document.getElementById("companycontactNoinValidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("companycontactNoinValidError").setAttribute("hidden", "");
    }
    if (clientMobileNo === "") {
        document.getElementById("clientMobileNoErrr").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientMobileNoErrr").setAttribute("hidden", "");
    }
    if (!validate_phone(clientMobileNo)) {
        document.getElementById("clientMobileNoinValidErrr").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("clientMobileNoinValidErrr").setAttribute("hidden", "");
    }

    $("#addNewClientEmployee").modal('hide');
    var clientIdClear = $('#clientId').val('');
    var clientFirstNameClear = $('#clientFirstName').val('');
    var clientLastNameClear = $('#clientLastName').val('');
    var clientNicClear = $('#clientNic').val('');
    var clientemailClear = $('#clientemail').val('');
    var companycontactNoClear = $('#companycontactNo').val('');
    var clientMobileNoClear = $('#clientMobileNo').val('');


    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;
                const  output = JSON.parse(data);
                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true
                    }).then(function () {
                        location.reload();
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

function closeProjectTeam() {
    $("#projectTeamtDetails").modal('hide');
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

function clientTeamDetails(id) {
    $("#clientEmpDetails").modal('show');

    var req = new XMLHttpRequest();

    req.onreadystatechange = function () {

        if (req.readyState === 4) {
            if (req.status === 200) {

                const   str = req.response;

                const data = JSON.parse(str);

                var tbody = document.getElementById("ClientTeamEmpTableBody");

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

                    if (client_employee.gupGopStatus === true) {
                        var tdStatus = document.createElement("td");
                        tdStatus.textContent = "Active";
                        tdStatus.style.color = "green";
                        tr.appendChild(tdStatus);

                        var tdEmpRemoveButton = document.createElement("td");
                        tdEmpRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-danger" style="width: 100px;" onclick="activeClientEmployee('${id}', '${client_employee.gupId}' , '${client_employee.gupGopStatus}');">Remove</button>`;
                        tr.appendChild(tdEmpRemoveButton);
                    } else {
                        var tdStatus = document.createElement("td");
                        tdStatus.textContent = "Inactive";
                        tdStatus.style.color = "red";
                        tr.appendChild(tdStatus);

                        var tdEmpRemoveButton = document.createElement("td");
                        tdEmpRemoveButton.innerHTML = `<button class="btn rounded-pill btn-outline-success" style="width: 100px;" onclick="activeClientEmployee('${id}', '${client_employee.gupId}' , '${client_employee.gupGopStatus}');">Add</button>`;
                        tr.appendChild(tdEmpRemoveButton);
                    }

                    tbody.appendChild(tr);
                }

                return true;
            }

        }

    };
    req.open("POST", "../ClientTeamListStatus", true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    req.send("id=" + id);
}

function activeClientEmployee(OrgId, EmpId, ActiveStatus) {

    $("#clientEmpDetails").modal('hide');

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
    request.open("POST", "../ClientTeamListStatusUpdate", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("OrgId=" + OrgId + "&EmpId=" + EmpId + "&ActiveStatus=" + ActiveStatus);

    return true;
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

    var editClientId = $('#editClientId').val();
    var editCliAdd1 = $('#editCliAdd1').val();
    var editCliAdd2 = $('#editCliAdd2').val();
    var editCliAdd3 = $('#editCliAdd3').val();
    var editCliEmail = $('#editCliEmail').val();
    var editCliContact = $('#editCliContact').val();
    var editCliFaxNo = $('#editCliFaxNo').val();

    if (editCliAdd1 === "") {
        document.getElementById("EditAddress1Error").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("EditAddress1Error").setAttribute("hidden", "");
    }
    if (editCliAdd2 === "") {
        document.getElementById("EditAddress2Error").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("EditAddress2Error").setAttribute("hidden", "");
    }
    if (editCliAdd3 === "") {
        document.getElementById("editAddress3Error").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editAddress3Error").setAttribute("hidden", "");
    }
    if (editCliEmail === "") {
        document.getElementById("editEmailError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editEmailError").setAttribute("hidden", "");
    }
    if (!validateEmail(editCliEmail)) {
        document.getElementById("editEmailinvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editEmailinvalidError").setAttribute("hidden", "");
    }
    if (editCliContact === "") {
        document.getElementById("editContactError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editContactError").setAttribute("hidden", "");
    }
    if (!validate_phone(editCliContact)) {
        document.getElementById("editcontactInvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editcontactInvalidError").setAttribute("hidden", "");
    }
    if (editCliFaxNo === "") {
        document.getElementById("editFaxError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editFaxError").setAttribute("hidden", "");
    }
    if (!validate_phone(editCliFaxNo)) {
        document.getElementById("editFaxInvalidError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("editFaxInvalidError").setAttribute("hidden", "");
    }

    $("#editClient").modal('hide');

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {
        if (request.readyState === 4) {
            if (request.status === 200) {
                const  data = request.response;
                const  output = JSON.parse(data);
                if (output.status === 200) {
                    Swal.fire({
                        title: output.message,
                        icon: 'success',
                        showConfirmButton: true,
                        allowOutsideClick: true,
                        allowEscapeKey: true,
                        closeOnConfirm: false,
                        timer: 1000
                    }).then(function () {
                        location.reload();
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

    var allCheckbox = document.getElementById("all");
    var pendingCheckbox = document.getElementById("pending");
    var ongoingCheckbox = document.getElementById("ongoing");
    var completedCheckbox = document.getElementById("completed");

    var tableBody = document.getElementById("tableempbody");
    var rows = tableBody.getElementsByTagName("tr");

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var statusCell = row.cells[3];

        if (allCheckbox.checked) {
            row.style.display = "";
        } else {
            var status = statusCell.textContent.trim();

            if ((pendingCheckbox.checked && status === "Pending") ||
                    (ongoingCheckbox.checked && status === "Ongoing") ||
                    (completedCheckbox.checked && status === "Completed")) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        }
    }
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

function resignationClose() {
    $("#ResignationModal").modal('hide');
}

function empDocUploader() {

    let docPreview = document.getElementById("imagePreview");
    let empDocument = document.getElementById("empDocPreview");
    let inputFile = document.getElementById("empDoc");

    inputFile.onchange = function () {
        const imagename = this.value.split('\\').pop().split('/').pop();
        const fileExtension = imagename.split('.').pop().toLowerCase();

        if (fileExtension === 'jpeg' || fileExtension === 'png' || fileExtension === 'jpg') {
            console.log("image");
            empDocument.src = URL.createObjectURL(inputFile.files[0]);

            docPreview.style.display = 'block';
            empDocument.style.display = 'block';
            empDocument.style.width = '500px';
            empDocument.style.height = '300px';
        } else {
            console.log("pdf");
        }
    };


}

function closeEmpDocModel() {
    $("#EmpDocUploadModel").modal('hide');
}

function empDocumentUpload() {

    var documentType = document.getElementById("docType");
    var documentName = $('#docName').val();

    if (documentType.value === "") {
        document.getElementById("typeError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("typeError").setAttribute("hidden", "");
    }
    if (documentName === "") {
        document.getElementById("nameError").removeAttribute("hidden");
        return false;
    } else {
        document.getElementById("nameError").setAttribute("hidden", "");
    }
    return true;
}

function openDocument(documentName) {

    const fileName = documentName;
    console.log(fileName);

    var servletURL = '../EmployeeDocumentOpen';
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

function setTodayDate() {
    const dateInput = document.getElementById('regisered');
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0];

    dateInput.value = formattedDate;
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
