$(document).ready(function () {
	$('#projectTeam').multiselect();
});

function validateProjectForm() {
	var projectName = document.getElementById("projectName").value;
	var projectTeam = document.getElementById("projectTeam").value;

	if (projectName.trim().length == 0) {
		$('#projectName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (projectTeam < 1) {
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
		$('#name').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (assignee < 1) {
		$('#teamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
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
		$('#editTaskName').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (assignee < 1) {
		$('#editTaskTeamMember').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (taskDueDate < todayDate && taskDueDate != "") {
		$('#editTaskDueDate').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("editTaskForm").submit();
	}
}

function validateUpdateTaskHoursForm() {
	var taskDetailHours = document.getElementById("taskDetailHours").value;
	var percentage = document.getElementById("percentage").value;

	if (taskDetailHours < 0 || taskDetailHours == "" || taskDetailHours > 12) {
		$('#taskDetailHours').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (percentage < 0 || percentage == "" || percentage > 100) {
		$('#percentage').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("updateTaskHoursForm").submit();
	}
}

function validateCustomTaskHoursForm() {
	var taskDetailHours = document.getElementById("customTaskDetailHours").value;
	var percentage = document.getElementById("customPercentage").value;

	if (taskDetailHours < 0 || taskDetailHours == "" || taskDetailHours > 12) {
		$('#customTaskDetailHours').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else if (percentage < 0 || percentage == "" || percentage > 100) {
		$('#customPercentage').attr('style', "border-radius: 5px; border:#FF0000 1px solid;");
	} else {
		document.getElementById("customTaskHoursForm").submit();
	}
}

