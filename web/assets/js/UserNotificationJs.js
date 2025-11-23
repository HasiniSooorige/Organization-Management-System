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