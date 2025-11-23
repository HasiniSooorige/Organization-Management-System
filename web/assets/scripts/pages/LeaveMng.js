function leaveCheckk() {

// Get the Half Day Day Type AM or PM
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

    const reqDate = document.getElementById("reqDate").value;
    const nic = document.getElementById("empNic").value;

    var Reason = document.getElementById("leaveSelect");
    var ReasonLeave = Reason.value;
    const comment = document.getElementById("leaveComment").value;

    const startdate = document.getElementById("startdate1").value;
    const enddate = document.getElementById("enddate1").value;

    const halfDate = document.getElementById("halfDate").value;

    const shTimeFrom = document.getElementById("shTimeFrom").value;
    const shTimeTo = document.getElementById("shTimeTo").value;
    const shortLeaveDate = document.getElementById("shortLeaveDate").value;

    if (Reason.value === "") {
        document.getElementById("selectError").removeAttribute("hidden");
        document.getElementById("leaveSelect").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("selectError").setAttribute("hidden", "");
        document.getElementById("leaveSelect").style.borderColor = '';
    }
    if (comment === "") {
        document.getElementById("commentField").removeAttribute("hidden");
        document.getElementById("leaveComment").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("commentField").setAttribute("hidden", "");
        document.getElementById("leaveComment").style.borderColor = '';
    }
    if (leaveType === "FullDay" && (enddate === "" || startdate === "")) {
        document.getElementById("fulldayVali").removeAttribute("hidden");
        document.getElementById("startdate1").style.borderColor = 'red';
        document.getElementById("enddate1").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("fulldayVali").setAttribute("hidden", "");
        document.getElementById("startdate1").style.borderColor = '';
        document.getElementById("enddate1").style.borderColor = '';
    }

    if (leaveType === "Half Day" && (halfDate === "" || dayType === null)) {
        document.getElementById("halfdayVali").removeAttribute("hidden");
        document.getElementById("halfDate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("halfdayVali").setAttribute("hidden", "");
        document.getElementById("halfDate").style.borderColor = '';
    }

    if (leaveType === "Short Leave" && (shTimeFrom === "" || shTimeTo === "" || shortLeaveDate === "")) {
        document.getElementById("shortfdayVali").removeAttribute("hidden");
        document.getElementById("shTimeFrom").style.borderColor = 'red';
        document.getElementById("shTimeTo").style.borderColor = 'red';
        document.getElementById("shortLeaveDate").style.borderColor = 'red';
        return false;
    } else {
        document.getElementById("shortfdayVali").setAttribute("hidden", "");
        document.getElementById("shTimeFrom").style.borderColor = '';
        document.getElementById("shTimeTo").style.borderColor = '';
        document.getElementById("shortLeaveDate").style.borderColor = '';
    }

    $.post('../LeaveRequestHandle', {
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
                title: 'Full Day Leave Requested!',
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
                title: 'Half Day Leave Requested!',
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
                title: 'Short Leave Requested!',
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



function clearFelds() {
    location.reload();
}