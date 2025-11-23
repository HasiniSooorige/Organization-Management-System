// all credentials.js

   // add credentials
   
  //   Hide Inputs according to the Credtype
  $(document).ready(function(){
      
    var credType="";
    var credsubType="";
    var project="";
    var role="";
    var username="";
    var password="";
    var note="";
    


    if(document.getElementById("cred_type") != null){
      document.getElementById("cred_type").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       credType = inputValue;
       
    });
    
     document.getElementById("cred_subtype").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       credsubType = inputValue;
    });
    
    document.getElementById("cred_username").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       username = inputValue;
    });
    
    
    document.getElementById("cred_password").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       password = inputValue;
    });
   
   document.getElementById("cred_project").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       project = inputValue;
    });
    
    
     document.getElementById("cred_role").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       role = inputValue;
    });
    
    document.getElementById("cred_note").addEventListener("change", function(e) {
       var inputValue = e.target.value;
       note = inputValue;

    });  
    }
    
    
     $( "#cred_add_btn" ).on( "click", function(e) {
         e.preventDefault();
         
         // Validattion
         
         if(credType == ""|| credsubType == "" || project == "" || role =="" || username =="" || password =="" || note==""){
             console.log("Please Fill All Forms")
             

                swal("Empty Inputs", "Please Fill All Forms", "error");

             return
         }
         
         
         console.log(credType)
         console.log(credsubType)
         console.log(project)
         console.log(role)
         console.log(username)
         console.log(password)
         console.log(note)
     });
     
     
//     Delete Credential Confirmation
if(document.getElementById("delete_cred_btn") != null){
    document.getElementById("delete_cred_btn").addEventListener("click",function(e){
        e.preventDefault();
        
      swal({
        title: "Are you sure?",
        text: "The Credential Will Be Deleted",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Credential Deleted", {
            icon: "success",
          });
   
    
    } 
    });

    })   
}
 
    
    
    
//  Delete Credential Table Confirmation
if(document.querySelector(".cred_del_table_1") != null){
    
    document.querySelector(".cred_del_table_1").addEventListener("click",function(e){
        e.preventDefault();
        
      swal({
        title: "Are you sure?",
        text: "The Credential Will Be Deleted",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Credential Deleted", {
            icon: "success",
          });
   
    
    } 
    });

    })
    
}

    
    
    
//    Delete Password Access in the ModaL View
if(document.getElementById("delete_cred_access_btn") != null){
     document.getElementById("delete_cred_access_btn").addEventListener("click",function(e){
        e.preventDefault();
        
      swal({
        title: "Are you sure?",
        text: "The Access Will Be Deactived",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Access Deactived", {
            icon: "success",
          });
   
    
    } 
    });

  })
}

if(document.querySelector(".del_access_cred_1") != null){
      document.querySelector(".del_access_cred_1").addEventListener("click",function(e){
        e.preventDefault();
        
      swal({
        title: "Are you sure?",
        text: "The Access Will Be Deactivated",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Access Deactivated", {
            icon: "success",
          });
   
    
    } 
    });

    })
}



// Credential View Request Approve

if(document.querySelector(".approve_button_request_1") != null){
    document.querySelector(".approve_button_request_1").addEventListener("click",function(e){
    e.preventDefault();
    
    
    swal({
        title: "Are you sure?",
        text: "This action will approve the view of the credentials",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Credential View Approved !", {
            icon: "success",
          });
        }
      });

})

}

if(document.querySelector(".disapprove_button_request_1") != null){
    // Credential View Request Dispproved
document.querySelector(".disapprove_button_request_1").addEventListener("click",function(e){
    e.preventDefault();
    
      swal({
        title: "Are you sure?",
        text: "This action will disapprove the view of the credentials",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Credential View Disapproved !", {
            icon: "success",
          });
        }
      });

})
}


let count = 0;
$("#btn_view_cred_employee").click(function(){
    
    
    
    
    if(count == 0){
         $("#next_time_request").hide();
         $("#first_time_request").show();
         count +=1;
         
    }else{
        $("#next_time_request").show();
        $("#first_time_request").hide();
        count+=1;
    }
    
    
      
})

  
    
  })
  
  // My Claims
  $(document).ready(function() {
    $("#add_row").on("click", function() {
        // Dynamic Rows Code
        
        // Get max row id and set new id
        var newid = 0;
        $.each($("#tab_logic tr"), function() {
            if (parseInt($(this).data("id")) > newid) {
                newid = parseInt($(this).data("id"));
            }
        });
        newid++;
        
        var tr = $("<tr></tr>", {
            id: "addr"+newid,
            "data-id": newid
        });
        
        // loop through each td and create new elements with name of newid
        $.each($("#tab_logic tbody tr:nth(0) td"), function() {
            var td;
            var cur_td = $(this);
            
            var children = cur_td.children();
            
            // add new td and element if it has a nane
            if ($(this).data("name") !== undefined) {
                td = $("<td></td>", {
                    "data-name": $(cur_td).data("name")
                });
                
                var c = $(cur_td).find($(children[0]).prop('tagName')).clone().val("");
                c.attr("name", $(cur_td).data("name") + newid);
                c.appendTo($(td));
                td.appendTo($(tr));
            } else {
                td = $("<td></td>", {
                    'text': $('#tab_logic tr').length
                }).appendTo($(tr));
            }
        });
        
        // add delete button and td
        /*
        $("<td></td>").append(
            $("<button class='btn btn-danger glyphicon glyphicon-remove row-remove'></button>")
                .click(function() {
                    $(this).closest("tr").remove();
                })
        ).appendTo($(tr));
        */
        
        // add the new row
        $(tr).appendTo($('#tab_logic'));
        
        $(tr).find("td button.row-remove").on("click", function() {
             $(this).closest("tr").remove();
        });
});




    // Sortable Code
    var fixHelperModified = function(e, tr) {
        var $originals = tr.children();
        var $helper = tr.clone();
    
        $helper.children().each(function(index) {
            $(this).width($originals.eq(index).width())
        });
        
        return $helper;
    };
  
    $(".table-sortable tbody").sortable({
        helper: fixHelperModified      
    }).disableSelection();

    $(".table-sortable thead").disableSelection();



    $("#add_row").trigger("click");
    
    
 
    
});
    
  $(document).ready(function() {
        /// Approve Button
    $("#req_btn_approve_hac").on("click", function() {
        
        swal({
        title: "Are you sure?",
        text: "Once Approved, You cannot go Back",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Request Claim Approved", {
            icon: "success",
          });
        } 
        
      });
      
    })
    
    /// disapprove Button
       $("#req_btn_disapprove_hac").on("click", function() {
        
        swal({
        title: "Are you sure?",
        text: "Once Disapproved, You cannot go Back",
        icon: "warning",
        buttons: true,
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          swal("Request Claim Disapproved", {
            icon: "success",
          });
        } 
        
      });
        
    })
     
  });

