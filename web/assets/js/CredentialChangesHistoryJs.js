function  viewCedentialHistoryData(idc) {
    console.log(idc);

    var request = new XMLHttpRequest();

    request.onreadystatechange = function () {

        if (request.readyState === 4) {
            if (request.status === 200) {

                const   str = request.response;

                const obj = JSON.parse(str);
                document.getElementById("credHistoryIdSpan").innerHTML = idc;
                document.getElementById("credHistoryProjectSpan").innerHTML = obj.project;
                document.getElementById("credHistoryRoleSpan").innerHTML = obj.roll;

                var d = new Date(obj.updateddate);
                let dateL = d.toISOString();
                var now = new Date(dateL);
                var day = ("0" + now.getDate()).slice(-2);
                var month = ("0" + (now.getMonth() + 1)).slice(-2);
                var updateddate = now.getFullYear() + "-" + (month) + "-" + (day);


                document.getElementById("credUpdatedByEmp").innerHTML = obj.updatedby;
                document.getElementById("credUsernameHistorySpan").innerHTML = obj.username;
                document.getElementById("credCatHistorySpan").innerHTML = obj.category;
                document.getElementById("credTypeHistorySpan").innerHTML = obj.type;
                document.getElementById("creUpdatedHistorySpan").innerHTML = updateddate;
                document.getElementById("credPasswordHistorySpan").innerHTML = obj.password;
                document.getElementById("credReasonHistory").innerHTML = obj.reason;

                $("#viewCredHistoryM").modal('show');
                show_modal();


            }
        }
    };
    request.open("POST", "../CredentialHistoryDataView", true);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    request.send("id=" + idc);

}


function pageLoad() {
    location.reload();
}
function show_modal() {

    $("#largeModal").modal('show')


}


