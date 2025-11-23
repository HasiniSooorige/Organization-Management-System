function approveCedentialViewRequest(id){
 
    


   $.post('.././ApproveCedentialViewRequest', {
       
        id: id


  }, function (data) {
        const value = JSON.parse(data);
        if (value.status == 200) {
          
  location.reload();   
 pageLoad();
        }  else {
            alert("Error");
  location.reload();   
 pageLoad();
        }



    });    
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

function deleteCedentialViewRequestData(id){
 
   


  $.post('.././DeleteCedentialViewRequestData', {
       
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
function show_modal() {

    $("#largeModal").modal('show')


}

