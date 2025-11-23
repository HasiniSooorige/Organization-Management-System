
function  viewCedentialHistoryData(idc) {
    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);

                var dateObj = new Date(obj.updateddate);
                var year = dateObj.getFullYear();
                var month = ("0" + (dateObj.getMonth() + 1)).slice(-2);
                var day = ("0" + dateObj.getDate()).slice(-2);
                var hours = ("0" + dateObj.getHours()).slice(-2);
                var minutes = ("0" + dateObj.getMinutes()).slice(-2);
                var seconds = ("0" + dateObj.getSeconds()).slice(-2);
                var updateddate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;

                document.getElementById("credHistoryProjectSpan").setAttribute("value", obj.project);
                document.getElementById("credHistoryRoleSpan").setAttribute("value", obj.roll);
                document.getElementById("credUpdatedByEmp").setAttribute("value", obj.updatedby);
                document.getElementById("credUsernameHistorySpan").setAttribute("value", obj.username);
                document.getElementById("credCatHistorySpan").setAttribute("value", obj.category);
                document.getElementById("credTypeHistorySpan").setAttribute("value", obj.type);
                document.getElementById("creUpdatedHistorySpan").setAttribute("value", updateddate);
                document.getElementById("credPasswordHistorySpan").setAttribute("value", obj.password);
                var Description = document.getElementById("credReasonHistory");
                Description.value = obj.reason;

                $("#viewCredHistoryM").modal('show');
            }
        }
    };
    request.open("POST", "../CredentialHistoryDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);
}

function filterHistory_function() {
    $('.tabletrfilterHistory').hide(); //hide all rows


    var companyFlagsec = 0;
    var companyValuesec = $('#filter-type').val();
    var contactFlagsec = 0;
    var contactValuesec = $('#filter-cat').val();
    var rangeFlagsec = 0;
    var rangeValuesec = $('#filter-pro').val();

    //setting intial values and flags needed
    if (companyValuesec == 0 && contactValuesec == 0 && rangeValuesec == 0) {
        document.getElementById("filterEmptyErrNotify").removeAttribute("hidden");
        document.getElementById("filter-type").style.borderColor = 'red';
        document.getElementById("filter-cat").style.borderColor = 'red';
        document.getElementById("filter-pro").style.borderColor = 'red';

    } else {
        document.getElementById("filterEmptyErrNotify").setAttribute("hidden", "");
        document.getElementById("filter-type").style.borderColor = '';
        document.getElementById("filter-cat").style.borderColor = '';
        document.getElementById("filter-pro").style.borderColor = '';
    }

    //traversing each row one by one
    $('.tabletrfilterHistory').each(function () {

        if (companyValuesec == 0) {   //if no value then display row
            companyFlagsec = 1;
        } else if (companyValuesec == $(this).find('td.type').data('type')) {
            companyFlagsec = 1;       //if value is same display row
        } else {
            companyFlagsec = 0;
        }


        if (contactValuesec == 0) {
            contactFlagsec = 1;
        } else if (contactValuesec == $(this).find('td.cat').data('cat')) {
            contactFlagsec = 1;
        } else {
            contactFlagsec = 0;
        }



        if (rangeValuesec == 0) {
            rangeFlagsec = 1;
        } else if (rangeValuesec == $(this).find('td.pro').data('pro')) {
            rangeFlagsec = 1;
        } else {
            rangeFlagsec = 0;
        }



        if (companyFlagsec && contactFlagsec && rangeFlagsec) {
            $(this).show();  //displaying row which satisfies all conditions
        }

    });
}

