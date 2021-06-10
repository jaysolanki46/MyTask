$(document).ready(function () {
	$('#projectGeneralTeam').multiselect();
	$('#projectDepartmentTeam').multiselect();
	$('#barProjects').multiselect({
		buttonClass:'custom-select-multi'
	});
	
	/** Show user upon department selections */
	
    if ($('#projectDepartment').val() == 1) {
    	$("#group-general").show();
		$("#projectGeneralTeam").prop('required',true);
		$("#group-department").hide();
		$("#projectDepartmentTeam").prop('required',false);
	} else {
		$("#group-department").show();
		$("#projectDepartmentTeam").prop('required',true);
		$("#group-general").hide();
		$("#projectGeneralTeam").prop('required',false);
	}

	$('#projectDepartment').on('change', function() {
      if (this.value == 1) {
       	$("#group-general").show();
		$("#projectGeneralTeam").prop('required',true);
		$("#group-department").hide();
		$("#projectDepartmentTeam").prop('required',false);
      } else {
		$("#group-department").show();
		$("#projectDepartmentTeam").prop('required',true);
		$("#group-general").hide();
		$("#projectGeneralTeam").prop('required',false);
      }
    });
	
	/** Youtube Video */
    var url = $("#tutorialiframe").attr('src');
    
    $("#tutorialPopup").on('hide.bs.modal', function(){
        $("#tutorialiframe").attr('src', '');
    });
    
    $("#tutorialPopup").on('show.bs.modal', function(){
        $("#tutorialiframe").attr('src', url);
    });
});