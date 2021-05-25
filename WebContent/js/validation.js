$(document).ready(function () {
	$('#projectTeam').multiselect();
});

function validateProjectForm() {
	var projectName = document.getElementById("projectName").value;
	var projectTeam = document.getElementById("projectTeam").value;

	if (projectName.trim().length == 0) {
		// Remove old style
		$('.multiselect').removeAttr('style');
		
		$('#projectName').focus();
		$('#projectName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	
	} else if (projectTeam < 1) {
		// Remove old style
		$('#projectName').removeAttr('style');
		
		$('.multiselect').focus();
		$('.multiselect').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("projectForm").submit();
	}
}

function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;

    return [year, month, day].join('-');
}

function validateTaskForm() {
	var name = document.getElementById("name").value;
	var assignee = document.getElementById("teamMember").value;
	var taskDueDate = document.getElementById("taskDueDate").value;
	var todayDate = formatDate(new Date());

	if (name.trim().length == 0) {
		
		//Remove
		$('#teamMember').removeAttr('style');
		$('#taskDueDate').removeAttr('style');
		
		$('#name').focus();
		$('#name').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
		
	} else if (assignee < 1) {
		
		//Remove
		$('#name').removeAttr('style');
		$('#taskDueDate').removeAttr('style');
		
		$('#teamMember').focus();
		$('#teamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
		
		//Remove
		$('#teamMember').removeAttr('style');
		$('#name').removeAttr('style');
		
		$('#taskDueDate').focus();
		$('#taskDueDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("taskForm").submit();
	}
}

function validateEditTaskForm() {
	var name = document.getElementById("editTaskName").value;
	var assignee = document.getElementById("editTaskTeamMember").value;
	var taskDueDate = document.getElementById("editTaskDueDate").value;
	var todayDate = formatDate(new Date());

	if (name.trim().length == 0) {
		
		//Remove
		$('#editTaskTeamMember').removeAttr('style');
		$('#editTaskDueDate').removeAttr('style');
		
		$('#editTaskName').focus();
		$('#editTaskName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (assignee < 1) {
		
		//Remove
		$('#editTaskName').removeAttr('style');
		$('#editTaskDueDate').removeAttr('style');
		
		$('#editTaskTeamMember').focus();
		$('#editTaskTeamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
		
		//Remove
		$('#editTaskName').removeAttr('style');
		$('#editTaskTeamMember').removeAttr('style');
		
		$('#editTaskDueDate').focus();
		$('#editTaskDueDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("editTaskForm").submit();
	}
}

function validateUpdateTaskHoursForm() {
	var taskDetailHours = document.getElementById("inlineTaskDetailHours").value;
	var percentage = document.getElementById("inlinePercentage").value;

	if (taskDetailHours < 0 || taskDetailHours == "" || taskDetailHours > 12) {
		
		//Remove
		$('#inlinePercentage').removeAttr('style');
		
		$('#inlineTaskDetailHours').focus();
		$('#inlineTaskDetailHours').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (percentage < 0 || percentage == "" || percentage > 100) {
		
		//Remove
		$('#inlineTaskDetailHours').removeAttr('style');
		
		$('#inlinePercentage').focus();
		$('#inlinePercentage').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("inlineTaskHoursForm").submit();
	}
}

function validateCustomTaskHoursForm() {
	var hiddenTaskId = document.getElementById("hiddenTaskId").value;
	var taskDetailHours = document.getElementById("customTaskDetailHours").value;
	var percentage = document.getElementById("customPercentage").value;
	var taskDetailDate = document.getElementById("taskDetailDate").value;

	if (hiddenTaskId == 0) {
		
		//Remove
		$('#customTaskDetailHours').removeAttr('style');
		$('#customPercentage').removeAttr('style');
		$('#taskDetailDate').removeAttr('style');
		
		$('#hiddenTaskId').focus();
		$('#hiddenTaskId').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDetailHours < 0 || taskDetailHours == "" || taskDetailHours > 12) {
		
		//Remove
		$('#hiddenTaskId').removeAttr('style');
		$('#customPercentage').removeAttr('style');
		$('#taskDetailDate').removeAttr('style');
		
		$('#customTaskDetailHours').focus();
		$('#customTaskDetailHours').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (percentage < 0 || percentage == "" || percentage > 100) {
		
		//Remove
		$('#hiddenTaskId').removeAttr('style');
		$('#customTaskDetailHours').removeAttr('style');
		$('#taskDetailDate').removeAttr('style');
		
		$('#customPercentage').focus();
		$('#customPercentage').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDetailDate == "") {
		
		//Remove
		$('#hiddenTaskId').removeAttr('style');
		$('#customTaskDetailHours').removeAttr('style');
		$('#customPercentage').removeAttr('style');
		
		$('#taskDetailDate').focus();
		$('#taskDetailDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("customTaskHoursForm").submit();
	}
}

