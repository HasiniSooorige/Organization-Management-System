function saveNewinterfacesaveNewMenu() {
    var menu_name = $('#menu_name').val();
    var menu_icon = $('#menu_icon').val();
    if (menu_name !== "" && menu_icon !== "") {
        var confirmmsg = confirm("Do you want to continue ?");
        if (confirmmsg) {
            $.post('../CreateNewMenu', {
                menu_name: menu_name,
                menu_icon: menu_icon,

            }, function (data) {
                if (data === "1") {
                    alert("Successfuly Added");
                } else {
                    alert("Already Added This Menu");
                    $('#successMsg').css("display", "none");
                }
            });
        } else {

        }
    }
}
function saveNewinterface() {

//    var inmenu = $('#inmenu').val();
    var inmenu = document.getElementById("inmenu").value;
    var insmenu = document.getElementById("insmenu").value;
//    var insmenu = $('#insmenu').val();
    var inname = $('#inname').val();
    var indsname = $('#indsname').val();
    var inurl = $('#inurl').val();
    var inicon = $('#inicon').val();

    console.log("inmenu - " + inmenu);
    console.log("insmenu - " + insmenu);

    if (inmenu === "") {
        document.getElementById("inmenuErrNotify").removeAttribute("hidden");
        document.getElementById("inmenu").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("inmenuErrNotify").setAttribute("hidden", "");
        document.getElementById("inmenu").style.borderColor = '';
    }
    if (insmenu === "") {
        document.getElementById("insmenuErrNotify").removeAttribute("hidden");
        document.getElementById("insmenu").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("insmenuErrNotify").setAttribute("hidden", "");
        document.getElementById("insmenu").style.borderColor = '';
    }
    if (inname === "") {
        document.getElementById("innameErrNotify").removeAttribute("hidden");
        document.getElementById("inname").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("innameErrNotify").setAttribute("hidden", "");
        document.getElementById("inname").style.borderColor = '';
    }
    if (indsname === "") {
        document.getElementById("indsnameErrNotify").removeAttribute("hidden");
        document.getElementById("indsname").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("indsnameErrNotify").setAttribute("hidden", "");
        document.getElementById("indsname").style.borderColor = '';
    }
    if (inurl === "") {
        document.getElementById("inurlErrNotify").removeAttribute("hidden");
        document.getElementById("inurl").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("inurlErrNotify").setAttribute("hidden", "");
        document.getElementById("inurl").style.borderColor = '';
    }
    if (inicon === "") {
        document.getElementById("iniconErrNotify").removeAttribute("hidden");
        document.getElementById("inicon").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("iniconErrNotify").setAttribute("hidden", "");
        document.getElementById("inicon").style.borderColor = '';
    }

    $.post('../CreateNewInterface', {
        inmenu: $('#inmenu').val(),
        insmenu: $('#insmenu').val(),
        inname: $('#inname').val(),
        indsname: $('#indsname').val(),
        inurl: $('#inurl').val(),
        inicon: $('#inicon').val(),
        action: "createInterface"
    }, function (data) {
        if (data === "1") {
            Swal.fire({
                title: 'Successfully Created new interface !',
                icon: 'success',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true,
                closeOnConfirm: false,
                timer: 1500,
            }).then(function () {
                location.reload();
            });
            var row = '<tr>' +
                    '<td>' + $('#inname').val() + '</td>' +
                    '<td>' + $('#indsname').val() + '</td>' +
                    '<td>' + $('#inmenu').val() + '</td>' +
                    '<td>' + $('#insmenu').val() + '</td>' +
                    '<td>' + $('#inurl').val() + '</td>' +
                    '<td> <i class="fa ' + $('#inicon').val() + '"></i></td>' +
                    '<td><button class="btn-red btn-xs" onclick="removeInterface();">REMOVE</button></td>' +
                    '<td><button class="btn-green btn-xs" onclick="showUpdateForm();">UPDATE</button></td>' +
                    '</tr>';
            $('#tbody_data').append(row);
            $('#new_interface')[0].reset();

        } else {
            Swal.fire({
                title: 'Already Added This Interface !',
                icon: 'error',
                showConfirmButton: true,
                allowOutsideClick: true,
                allowEscapeKey: true,
                closeOnConfirm: false,
                timer: 1500,
            }).then(function () {
                location.reload();
            });
        }
    });

}

function removeInterface(id) {

    $.post('../CreateNewInterface', {
        id: id,
        action: "removeInterface"
    }, function (data) {
        alert("Successful removed this interface..!");
        $("#row" + id).remove();
    });

}
function showUpdateForm(id) {

    $.post('../model/update-interface.jsp', {
        interface_id: id
    }, function (data) {
        $('#ajaxviewselect').empty();
        $('#ajaxviewselect').html(data);
        $('#ajaxselect').show('show');

    });
}
function updateInterface(id) {
    var confirm_msg = confirm("Do you want to update this interface?");
    if (confirm_msg) {
        $.post('../UpdateInterface', {
            id: id,
            inmenu: $('#inmenu' + id).val(),
            insmenu: $('#insmenu' + id).val(),
            inname: $('#inname' + id).val(),
            indsname: $('#indsname' + id).val(),
            inurl: $('#inurl' + id).val(),
            inicon: $('#inicon' + id).val()
        }, function (data) {
            if (data === "1") {
                alert("Successful updated this interface..!");
                $('#ajaxselect').hide('hide');
                location.reload();
            }
        });
    }
}


function validateAddIntrfaceToUserRole() {
    interface_id = $('#interface').val();
    userrole_id = $('#userrole').val();
    if (interface_id === "0" && userrole_id === "0") {
        $('#interface_field').addClass("has-error");
        $('#userrole_field').addClass("has-error");
        return false;
    }
    if (interface_id === "0") {
        $('#interface_field').addClass("has-error");
        return false;
    } else {
        $('#interface_field').removeClass("has-error");
    }
    if (userrole_id === "0") {
        $('#userrole_field').addClass("has-error");
        return false;
    } else {
        $('#userrole_field').removeClass("has-error");
    }
    return true;
}
function addInterfaceToUserRole() {
    if (validateAddIntrfaceToUserRole()) {
        var confirmmsg = confirm("Do you want to continue ?");
        if (confirmmsg) {
            $.post('../AddInterfaceToUser', {
                action: "addInterfaceToUserRole",
                interface_id: $('#interface').val(),
                userrole_id: $('#userrole').val()
            }, function (data) {
                if (data === "1") {
                    alert("Successful Added..!");
                    location.reload();
                } else {
                    alert("Already Added");
                }
            });
        }
    }
}
function checkUsersToUserRole() {
    var userrole_id = $('#userrole').val();
    if (userrole_id === "0") {
        $('#userrole_field').addClass("has-error");
    } else {
        $('#userrole_field').removeClass("has-error");
        $.post('../model/load-users-in-user-roles.jsp', {
            userrole_id: userrole_id
        }, function (data) {
            $('#ajaxviewselect').empty();
            $('#ajaxviewselect').html(data);
            $("#ajaxselect").modal('show');
        });
    }
}
function Set_interfaceCheckedAll() {

    if (document.getElementById('checkbox').checked) {
        for (i = 1; i < 190; i++) {

            var s = "checkbox_interface" + (i);
            if (!$('#' + s).is(':disabled')) {
                $('#' + s).prop('checked', true);
            } else {
                $('#' + s).prop('checked', false);
            }
        }
    } else {
        for (i = 1; i < 190; i++) {

            var s = "checkbox_interface" + (i);

            $('#' + s).prop('checked', false);
        }
    }

}

function addInterfaceToUserRoleNew() {
    var interface_count = $('#count').val();
    var role_count = $('#role_count').val();
    var confirmmsg = confirm("Do you Want to Continue ?");
    if (confirmmsg) {
        var jsn_object_interface = {jsn: []};
        var jsn_object_role = {jsn: []};
        for (i = 1; i < parseInt(interface_count); i++) {
            var is_transfer = false;
            var id = $('#checkbox_interface' + i).val();
            if (document.getElementById('checkbox_interface' + i).checked == true) {
                is_transfer = true;
            }

            if (is_transfer === true) {
                jsn_object_interface.jsn.push({"id": id, "is_transfer": is_transfer});
            }
        }
        for (i = 1; i < parseInt(role_count); i++) {
            var is_transfer = false;
            var id = $('#checkbox_role' + i).val();
            if (document.getElementById('checkbox_role' + i).checked == true) {
                is_transfer = true;
            }

            if (is_transfer === true) {
                jsn_object_role.jsn.push({"id": id, "is_transfer": is_transfer});
            }

        }

        var jsn_array_interface = JSON.stringify(jsn_object_interface);
        var jsn_array_role = JSON.stringify(jsn_object_role);

        $.post('../AddInterfacesToUserRoles', {
            jsnobj_interface: jsn_array_interface,
            jsnobj_role: jsn_array_role
        }, function (data) {
            alert(data.message);
            if (data.success) {
                location.reload();
            }
        });
    }
}
function loadInterfaceTouserRole() {

    $('#preloader1').css('display', 'block');
    interface_id = $('#interface').val();
    $.post('../LoadInterfaceTouserRole', {
        interface_id: interface_id
    }, function (data) {

        $('#preloader1').css('display', 'none');
        $('#in_to_userrole').empty();
        if (JSON.stringify(data) !== JSON.stringify({})) {
            var index = 1;
            $.each(data, function (key, value) {
                var newRow = '<tr id=row_role' + key + '>' +
                        '<td>' + index + '</td>' +
                        '<td>' + value + '</td>' +
                        '<td><button class="btn btn-danger btn-sm" onclick="removeInterfaceToUserRole(' + key + ');"><i class="fa fa-close"></i>REMOVE</button></td>' +
                        '</tr>';
                $('#in_to_userrole').append(newRow);
                index++;
            });
        } else {
            $('#in_to_userrole').append('<tr><td colspan="3">No records found.</td></tr>');
        }
    });
}
function removeInterfaceToUserRole(id) {
    var confirm_msg = confirm("Do you want to remove this Record?");
    if (confirm_msg) {
        $.post('../RemoveInterfaceToUserRole', {
            id: id
        }, function (data) {
            alert("Successful removed..!");
            $('#row_role' + id).remove();
        });
    }
}
function loadUserRoleToInterface() {
    $('#preloader2').css('display', 'block');
    userrole = $('#userrole').val();
    $.post('../LoadUserRoleToInterface', {
        userrole: userrole
    }, function (data) {
        $('#preloader2').css('display', 'none');
        $('#in_to_userinterfaces').empty();
        console.log("data " + data);
        if (data !== "null") {
            var index = 1;
            $.each(data, function (key, value) {
                var newRow = '<tr id=row_interface' + key + '>' +
                        '<td>' + index + '</td>' +
                        '<td>' + value + '</td>' +
                        '<td><button class="btn btn-danger btn-sm" onclick="removeUserRoleToInterface(' + key + ');"><i class="fa fa-close"></i>REMOVE</button></td>' +
                        '</tr>';
                $('#in_to_userinterfaces').append(newRow);
                index++;
            });
        } else {
            console.log("else");
            $('#in_to_userinterfaces').append('<tr><td colspan="3">No records found.</td></tr>');
        }
    });
}
function removeUserRoleToInterface(id) {
    var confirm_msg = confirm("Do you want to remove this Record?");
    if (confirm_msg) {
        $.post('../RemoveInterfaceToUserRole', {
            id: id
        }, function (data) {
            alert("Successful removed..!");
            $('#row_interface' + id).remove();
        });
    }
}
function saveNewMenu() {
    var menu_name = $('#menu_name').val();
    var menu_icon = $('#menu_icon').val();

    if (menu_name === "") {
        document.getElementById("menuNameErrNotify").removeAttribute("hidden");
        document.getElementById("menu_name").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("menuNameErrNotify").setAttribute("hidden", "");
        document.getElementById("menu_name").style.borderColor = '';
    }
    if (menu_icon === "") {
        document.getElementById("menuIconErrNotify").removeAttribute("hidden");
        document.getElementById("menu_icon").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("menuIconErrNotify").setAttribute("hidden", "");
        document.getElementById("menu_icon").style.borderColor = '';
    }

    if (menu_name !== "" && menu_icon !== "") {

        $.post('../CreateNewMenu', {
            menu_name: menu_name,
            menu_icon: menu_icon
        }, function (data) {
            if (data === "1") {
                Swal.fire({
                    title: 'Successfully Added Menu !',
                    icon: 'success',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    location.reload();
                });
            } else {
                Swal.fire({
                    title: 'Already Added This Menu !',
                    icon: 'warning',
                    showConfirmButton: true,
                    allowOutsideClick: true,
                    allowEscapeKey: true,
                    closeOnConfirm: false,
                    timer: 1500,
                }).then(function () {
                    location.reload();
                });
            }
        });
    }
}