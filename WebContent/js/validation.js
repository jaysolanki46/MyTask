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

function validateNewTaskForm() {
	var name = document.getElementById("newTaskName").value;
	var assignee = document.getElementById("newTaskTeamMember").value;
	var taskDueDate = document.getElementById("newTaskDueDate").value;
	var todayDate = formatDate(new Date());

	if (name.trim().length == 0) {
		
		//Remove
		$('#newTaskTeamMember').removeAttr('style');
		$('#newTaskDueDate').removeAttr('style');
		
		$('#newTaskName').focus();
		$('#newTaskName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
		
	} else if (assignee < 1) {
		
		//Remove
		$('#newTaskName').removeAttr('style');
		$('#newTaskDueDate').removeAttr('style');
		
		$('#newTaskTeamMember').focus();
		$('#newTaskTeamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
		
		//Remove
		$('#newTaskTeamMember').removeAttr('style');
		$('#newTaskName').removeAttr('style');
		
		$('#newTaskDueDate').focus();
		$('#newTaskDueDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("newTaskForm").submit();
	}
}

function validateMyTaskEditTaskForm() {
	var name = document.getElementById("myTaskEditTaskName").value;
	var assignee = document.getElementById("myTaskEditTaskTeamMember").value;
	var taskDueDate = document.getElementById("myTaskEditTaskDueDate").value;
	var todayDate = formatDate(new Date());

	if (name.trim().length == 0) {
		
		//Remove
		$('#myTaskEditTaskTeamMember').removeAttr('style');
		$('#myTaskEditTaskDueDate').removeAttr('style');
		
		$('#myTaskEditTaskName').focus();
		$('#myTaskEditTaskName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (assignee < 1) {
		
		//Remove
		$('#myTaskEditTaskName').removeAttr('style');
		$('#myTaskEditTaskDueDate').removeAttr('style');
		
		$('#myTaskEditTaskTeamMember').focus();
		$('#myTaskEditTaskTeamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
		
		//Remove
		$('#myTaskEditTaskName').removeAttr('style');
		$('#myTaskEditTaskTeamMember').removeAttr('style');
		
		$('#myTaskEditTaskDueDate').focus();
		$('#myTaskEditTaskDueDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("myTaskEditTaskForm").submit();
	}
}

function validateMyTeamTaskEditTaskForm() {
	var name = document.getElementById("myTeamTaskEditTaskName").value;
	var assignee = document.getElementById("myTeamTaskEditTaskTeamMember").value;
	var taskDueDate = document.getElementById("myTeamTaskEditTaskDueDate").value;
	var todayDate = formatDate(new Date());

	if (name.trim().length == 0) {
		
		//Remove
		$('#myTeamTaskEditTaskTeamMember').removeAttr('style');
		$('#myTeamTaskEditTaskDueDate').removeAttr('style');
		
		$('#myTeamTaskEditTaskName').focus();
		$('#myTeamTaskEditTaskName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (assignee < 1) {
		
		//Remove
		$('#myTeamTaskEditTaskName').removeAttr('style');
		$('#myTeamTaskEditTaskDueDate').removeAttr('style');
		
		$('#myTeamTaskEditTaskTeamMember').focus();
		$('#myTeamTaskEditTaskTeamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
		
		//Remove
		$('#myTeamTaskEditTaskName').removeAttr('style');
		$('#myTeamTaskEditTaskTeamMember').removeAttr('style');
		
		$('#myTeamTaskEditTaskDueDate').focus();
		$('#myTeamTaskEditTaskDueDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("myTeamTaskEditTaskForm").submit();
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

