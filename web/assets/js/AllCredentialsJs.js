function pageLoad(){
    location.reload();   
}
function show_modal() {

    $("#largeModal").modal('show')


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

function confirmDeactivate(){
     var id = $('#actioanid').val();
      document.getElementById("actioanConfirmid").setAttribute("value",id);
             
              $("#deactivateConfirmModel").modal('show');
              show_modal();
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


