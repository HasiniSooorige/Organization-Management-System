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
function pageLoad(){
    location.reload();   
}
function show_modal() {

    $("#largeModal").modal('show')


}


