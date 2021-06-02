$(document).ready(function () {
	$('#projectTeam').multiselect();
	
	/** Youtube Video */
    var url = $("#tutorialiframe").attr('src');
    
    $("#tutorialPopup").on('hide.bs.modal', function(){
        $("#tutorialiframe").attr('src', '');
    });
    
    $("#tutorialPopup").on('show.bs.modal', function(){
        $("#tutorialiframe").attr('src', url);
    });
});