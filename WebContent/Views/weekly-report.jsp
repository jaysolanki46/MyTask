<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPROJECTSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTASKPRIORITY"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@page import="javafx.util.Pair"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.Date" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.text.SimpleDateFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Weekly Report</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "", userdepartment = "";
	String reportStartDate = "", reportEndDate = "";
	Float taskColumnTotal = 0f, taskRowTotal = 0f;
	
	Connection dbConn = DBConfig.connection(); ;
	Statement st = null;
	ResultSet rs = null;
	st = dbConn.createStatement();
	
	Connection dbConnNested = DBConfig.connection(); ;
	Statement stNested = null;
	ResultSet rsNested = null;
	stNested = dbConnNested.createStatement();
	
	%><%@include  file="../session.jsp" %><% 
	
	if(usertheme.equals(SKYZERTECHNOLOGIES.ID.getValue())) {
		bckColor = SKYZERTECHNOLOGIES.COLOR.getValue();
		showSkyzerPaymentImg = SKYZERTECHNOLOGIES.LOGOSKYZERTECHNOLOGIES.getValue();
		showSkyzerTechImg = SKYZERTECHNOLOGIES.LOGOSKYZERPAYMENTS.getValue();
		
	} else if (usertheme.equals(SKYZERPAYMENTS.ID.getValue())) {
		bckColor = SKYZERPAYMENTS.COLOR.getValue();
		showSkyzerPaymentImg = SKYZERPAYMENTS.LOGOSKYZERTECHNOLOGIES.getValue();
		showSkyzerTechImg = SKYZERPAYMENTS.LOGOSKYZERPAYMENTS.getValue();
	}
	
	// Number of tasks
	Map<Integer, String> taskList = new HashMap<Integer, String>();
	taskList.put(1, "Task 1");
	taskList.put(2, "Task 2");
	taskList.put(3, "Task 3");
	//taskList.put(4, "Task 4");
	
	// 5 days
	Calendar currentWeek = Calendar.getInstance();
	Calendar now;
	
	// On prev next click
	int day, month, year;
	Date date = new Date();
	Date start_date = new Date(date.getYear(), date.getMonth(), date.getDate() - date.getDay());
	Date end_date = new Date(date.getYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
	String dateString = start_date.getDate() + "/" + (start_date.getMonth() + 1)  + "/" + (start_date.getYear() +1900)
						+ " - " + end_date.getDate() + "/" + (end_date.getMonth() + 1) + "/" + (end_date.getYear() +1900);
	//System.out.print(dateString);
	
	if (request.getParameter("week-picker-start-day") != null) {
		dateString = request.getParameter("week-picker-start-date");
		day = Integer.valueOf(request.getParameter("week-picker-start-day"));
		month = Integer.valueOf(request.getParameter("week-picker-start-month")) - 1;
		year = Integer.valueOf(request.getParameter("week-picker-start-year"));

		currentWeek.set(year, month, day);
	}

	SimpleDateFormat ddMMFormate = new SimpleDateFormat("dd/MM");
	SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ddMMMFormate = new SimpleDateFormat("ddMMM");
	SimpleDateFormat ddMMyyyyFormate = new SimpleDateFormat("dd-MM-yyyy");

	int delta = 0;
	String daysList[] = { "MON", "TUE", "WED", "THU", "FRI" };
%>
<style type="text/css">
.table100.ver1 .row100 td:hover  {
  background-color: <%=bckColor %>;
  color: #fff;
}
.table100.ver1 .hov-column-head-ver1 {
  background-color: <%=bckColor %>; !important;
  font-weight: bold;
}
.mytd i:hover {
	color: #fff;
}

#profileImage {
	width: 40px;
    height: 40px;
    border-radius: 50%;
    font-size: 21px;
    color: #fff;
    text-align: center;
    line-height: 40px;
}

#weeklyDataTable .sticky-col {
  position: -webkit-sticky;
  position: sticky;
  background-color: #eee;
}

#weeklyDataTable .first-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 0px;
}

#weeklyDataTable .second-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 100px;
}

#weeklyDataTable .third-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 200px;
}

#weeklyDataTable .fourth-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 300px;
}
</style>
</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <%@include  file="../sidebar.html" %>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <%@include  file="../topbar.html" %>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div id="layoutSidenav_content">
                <main>
                    <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
                            <div class="card-body"  style="padding: 0px;">
                               <div class="container-fluid">
		                            <div class="page-header-content">
		                                <div class="row align-items-center justify-content-between" style="height: 4rem;">
		                                    <div class="col-auto mb-3">
		                                        <h1 class="page-header-title center_div" style="color: <%=bckColor %>; font-weight: bold;font-size: x-large;">
		                                            <div class="page-header-icon">
		                                          		<i class="fas fa-clipboard-list"></i>
		                                            </div>
		                                            Reports
		                                        </h1>
		                                    </div>
		                                    <button
	                                        class="btn btn-sm btn-light active mr-3 center_div card-button popup-modal" 
	                                        	id="projectsTutorial"  title="Tutorial"  data-toggle="modal" data-target="#tutorialPopup"
												style="background-color:<%=bckColor %>; "><i class="fas fa-video"></i></button>
		                                </div>
		                                
		                                <div class="modal fade" id="tutorialPopup" tabindex="-1" role="dialog" aria-labelledby="tutorialPopupLbl" style="display: none;" aria-hidden="true">
										    <div class="modal-dialog modal-xl" role="document">
										        <div class="modal-content" style="height: 40rem;">
										            <div class="modal-header">
										                <h5 class="modal-title">Weekly Report Tutorial</h5>
										                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
										            </div>
										            <div class="modal-body">
										                <iframe id="tutorialiframe" height="100%" width="100%" src="https://www.youtube.com/embed/hqZoFbPb24I"></iframe>
										            </div>
										        </div>
										    </div>
										</div>
									    
		                            </div>
		                        </div>
		                        <hr style="margin: 0rem;">
                                <nav class="nav nav-borders nav-width">
                                    <a class="nav-link active ml-0" style="color: <%=bckColor %>; border-bottom-color: <%=bckColor %>;" href="/MyTask/Views/weekly-report.jsp">Weekly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/monthly-report.jsp">Monthly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/custom-report.jsp">Custom</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/project-report.jsp">Project</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/task-report.jsp">Task</a>
                                    
                                     <!-- Weekly datepicker -->
                                     
		                              <div class="form-group col-md-4 col-md-offset-2" id="week-picker-wrapper" style="margin: 0rem; margin-left: auto;">
											<div class="input-group">
											<form class="form-inline"  method="post" action="../Views/weekly-report.jsp">
												<label style="color: <%=bckColor %>;">Select Week: </label>
												<input type="text" id="week-picker-string" class="form-control week-picker" readonly="readonly" onchange="this.form.submit();"
													value="<%=dateString %>" placeholder="Select a Week" style="margin: 0.2rem; text-align: center; width: 18rem;">
												<input type="hidden"  id="week-picker-start-date" name="week-picker-start-date" value="">
												<input type="hidden" id="week-picker-start-day" name="week-picker-start-day" value="">
												<input type="hidden" id="week-picker-start-month" name="week-picker-start-month" value="">
												<input type="hidden" id="week-picker-start-year" name="week-picker-start-year" value="">
											</form>
											</div>
										</div>
                                <!-- End of weekly datepicker -->
                                </nav>
                            </div>
                        </header>
                    <!-- Main page content-->
                    <div class="container">
                            <div>
	                            <button type="submit" title="CSV Export"
												class="btn btn-sm btn-light active mr-3 center_div card-button"
												style="background-color:<%=bckColor %>; "
												onclick="exportTableToCSV('Weekly-report.csv', 'exportWeeklyDataTable');">
												<i class="fas fa-file-csv"></i>&nbsp; Export</button>	
							</div>
                            <table id="weeklyDataTable" class="table table-bordered" style="border: hidden; overflow-x: auto; display: block;">
						    <thead>
							      <tr>
							      	<th style="width: 10%;" class="sticky-col first-col">Project</th>
							        <th style="text-align: center;  width: 20%;" class="sticky-col second-col">Task</th>
							        <th class="sticky-col third-col">Priority</th>
							        <th class="sticky-col fourth-col">Assignee</th>
							        <%
							        
								        now = currentWeek;
								        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
								        now.add(Calendar.DAY_OF_MONTH, delta);
							        
								        for (int i = 0; i < 5; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=ddMMFormate.format(now.getTime()) + " , " + daysList[i] %></th><% 
								        	
								        			
									        // For report search query
											if (i == 0) reportStartDate = yyyyMMddFormate.format(now.getTime());
								        	if (i == 4) reportEndDate = yyyyMMddFormate.format(now.getTime());
								        			
								        	now.add(Calendar.DAY_OF_MONTH, 1);
								        }
							        	
							        %>
							       
							        <th style="text-align: center;">Total hours</th>
							      </tr>
							    </thead>
						    
						    <tbody>
						      <% 
							    Integer key = 0;
						        String name = "";
						        String priority = "";
						        String assignee =  "";
						        String profileColor = "green";
						        
								rs = st.executeQuery("select project.*, task.* from projects project " +  
										"LEFT JOIN project_team project_team ON project.id = project_team.project " +
										"LEFT JOIN tasks task ON project.id = task.project " +
										"where (project.status = "+ SKYZERPROJECTSTATUS.OPENED.getValue() +") AND (task.status = "+ SKYZERTASKSTATUS.OPENED.getValue() +") " +
										"AND (project.department = "+ userdepartment +" OR project.department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +") AND " + 
										"(project.created_on <= '"+ reportStartDate +"' OR project.created_on <= '"+ reportEndDate +"') AND (project_team.team_member = "+ userid +")  group by task.name order by project.id DESC");

								while(rs.next()) {   
									    	key = rs.getInt("task.id");
									        name = rs.getString("task.name");
									        rsNested = stNested.executeQuery("SELECT * FROM users where id = "+ rs.getInt("task.team_member") +"");
								        	if(rsNested.next()) assignee = rsNested.getString("name");
							        	
								        %>
								        	<tr>
										        <td style="text-align: left;" class="sticky-col first-col">
										        	<%=rs.getString("project.name") %> 
										        </td>
										        <td style="text-align: inherit;" class="sticky-col second-col">
										        	<%=name %>
										        	<div class="progress rounded-pill" title="<%=rs.getInt("task.percentage") %>% completed"
													style="height: 0.5rem; margin-top: 0.5rem; cursor: pointer;">
										        	<div style="
										        			<%
										        				if(rs.getInt("task.percentage") >= 0 && rs.getInt("task.percentage") <=50) {
										        					%>background-color: <%=bckColor %>;<%
										        				} else if(rs.getInt("task.percentage") >= 50 && rs.getInt("task.percentage") < 100) {
										        					%>background-color:#ebb20c;<%
										        				} else {
										        					%>background-color:#06794f;<%
										        				}
										        			%>width: <%=rs.getInt("task.percentage") %>%" class="progress-bar rounded-pill"
															role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100"></div>
													</div>
										        </td>
										        <td class="sticky-col third-col">
										        		<% if(rs.getInt("task.priority") == SKYZERTASKPRIORITY.LOW.getValue()) {
										        			%> <span class="badge" style="background-color:#00ac69; color: white; font-weight: bold; float: left;">LOW</span> <%	
										        		} else if (rs.getInt("task.priority") == SKYZERTASKPRIORITY.MEDIUM.getValue()) {
										        			%> <span class="badge" style="background-color:#f4a100; color: white; font-weight: bold; float: left;">MEDIUM</span> <%
										        		} else if (rs.getInt("task.priority") == SKYZERTASKPRIORITY.HIGH.getValue()) {
										        			%> <span class="badge" style="background-color:#e81500; color: white; font-weight: bold; float: left;">HIGH</span> <%
										        		}
										        		%> 
										        </td>
										        <td class="sticky-col fourth-col">
													<div id="profileImage" style="background: <%=profileColor %>" title="<%=assignee %>">
														<%=assignee.toUpperCase().substring(0, 2) %>
													</div>
										        </td>
										        <%
										        
											     	// 5 days
											    	now = currentWeek;
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
											        taskColumnTotal = 0f; taskRowTotal = 0f;
										        
											        for (int i = 0; i < 5; i++)
											        {
											        	%>
											        		<td>
													        	<% // Getting hours from task_details
											        				Integer taskId = key;
											        				String taskDate = yyyyMMddFormate.format(now.getTime());
											        				Float taskHours = 0f;
											        				String taskDescription = "";
											        				
											        				rsNested = stNested.executeQuery("SELECT taskdetail.* FROM task_details taskdetail where taskdetail.task = "+ taskId +" AND taskdetail.task_detail_date = '"+ taskDate +"'");
											        				if(rsNested.next()){
											        					taskHours = rsNested.getFloat("taskdetail.hours");
											        					taskDescription = rsNested.getString("taskdetail.description");
											        				}
								        							taskRowTotal += taskHours;
								        							
											        			%>
											        			
											        			<label id="hoursLable" name="hoursLable" style="cursor: pointer;" class=""><%if(taskHours > 0)%><%=taskHours%><%else%><%="-"%></label>
													        </td>
											        	<% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        }
										        %>
										        <td>
										        	<label class="total-hours-text"><%=taskRowTotal %></label>
										        </td>
										      </tr>
								        <%
								    }
							     %>	
						    </tbody>
						  </table>
						  
						  <!-- Hidden table for export -->
						  <div style="display: none;">
						  <table id="exportWeeklyDataTable" class="table table-bordered">
						    <thead>
							      <tr>
							      	<th style="width: 10%;">Project</th>
							        <th style="text-align: center;  width: 20%;">Task</th>
							        <th>Priority</th>
							        <th>Assignee</th>
							        <th>Comments / Description</th>
							        <th>Progress</th>
							        <%
							        
								        now = currentWeek;
								        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
								        now.add(Calendar.DAY_OF_MONTH, delta);
							        
								        for (int i = 0; i < 5; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%='\"'+ddMMFormate.format(now.getTime()) + " , " + daysList[i] + '\"' %></th><% 
								        	
								        			
									        // For report search query
											if (i == 0) reportStartDate = yyyyMMddFormate.format(now.getTime());
								        	if (i == 4) reportEndDate = yyyyMMddFormate.format(now.getTime());
								        			
								        	now.add(Calendar.DAY_OF_MONTH, 1);
								        }
							        	
							        %>
							       
							        <th style="text-align: center;">Total hours</th>
							      </tr>
							    </thead>
						    
						    <tbody>
						      <% 
							    key = 0;
						        name = "";
						        priority = "";
						        assignee =  "";
						        profileColor = "green";
						        
								rs = st.executeQuery("select project.*, task.* from projects project " +  
										"LEFT JOIN project_team project_team ON project.id = project_team.project " +
										"LEFT JOIN tasks task ON project.id = task.project " +
										"where (project.status = "+ SKYZERPROJECTSTATUS.OPENED.getValue() +") AND (task.status = "+ SKYZERTASKSTATUS.OPENED.getValue() +") " +
										"AND (project.department = "+ userdepartment +" OR project.department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +") AND " + 
										"(project.created_on <= '"+ reportStartDate +"' OR project.created_on <= '"+ reportEndDate +"') AND (project_team.team_member = "+ userid +")  group by task.name order by project.id DESC");

								while(rs.next()) {   
									    	key = rs.getInt("task.id");
									        name = rs.getString("task.name");
									        
									        if(rs.getInt("priority") == SKYZERTASKPRIORITY.LOW.getValue()) {
									        	priority = SKYZERTASKPRIORITY.LOW.name();
									        } else if (rs.getInt("priority") == SKYZERTASKPRIORITY.MEDIUM.getValue()) {
									        	priority = SKYZERTASKPRIORITY.MEDIUM.name();
									        } else if (rs.getInt("priority") == SKYZERTASKPRIORITY.HIGH.getValue()) {
									        	priority = SKYZERTASKPRIORITY.HIGH.name();
									        }
									        rsNested = stNested.executeQuery("SELECT * FROM users where id = "+ rs.getInt("task.team_member") +"");
								        	if(rsNested.next()) assignee = rsNested.getString("name");
							        	
								        %>
								        	<tr>
										        <td><%='\"'+rs.getString("project.name") + '\"'%></td>
										        <td style="text-align: inherit;"><%='\"'+name + '\"'%></td>
										        <td><%='\"'+ priority + '\"'%></td>
										        <td><%=assignee %></td>
										        <td><%='\"'+rs.getString("task.description") + '\"'%></td>
										        <td><%=rs.getInt("task.percentage") %>%</td>
										        <%
										        
											     	// 5 days
											    	now = currentWeek;
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
											        taskColumnTotal = 0f; taskRowTotal = 0f;
										        
											        for (int i = 0; i < 5; i++){
											        	%>
											        		<td><% // Getting hours from task_details
											        				Integer taskId = key;
											        				String taskDate = yyyyMMddFormate.format(now.getTime());
											        				Float taskHours = 0f;
											        				String taskDescription = "";
											        				
											        				rsNested = stNested.executeQuery("SELECT taskdetail.* FROM task_details taskdetail where taskdetail.task = "+ taskId +" AND taskdetail.task_detail_date = '"+ taskDate +"'");
											        				if(rsNested.next()){
											        					taskHours = rsNested.getFloat("taskdetail.hours");
											        					taskDescription = rsNested.getString("taskdetail.description");
											        				}
								        							taskRowTotal += taskHours;
								        							
											        			%><label id="hoursLable" name="hoursLable" style="cursor: pointer;" class=""><%
											        				if(taskHours > 0)
											        					%><%=taskHours%><%
											        				else
											        					%><%="-"%></label></td><% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        } %>
											        <td><label class="total-hours-text"><%=taskRowTotal %></label></td>
										      </tr>
								        <%
								    }
							     %>	
						    </tbody>
						   
						  </table>
						  </div>
						  <!-- End hidden table for export -->
						  
						  
						  
                    </div>
                </main>
            </div>
               
				<!-- End if Page Content -->
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
           
            <%@include  file="../footer.html" %>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
    <!-- CSV Export -->
	<script src="../js/csv.js"></script>
	<!-- Hide Empty Columns In Table -->
	<script src="../js/hideEmptyColumns.js"></script>
	
</body>
<% 
} catch (Exception e) {
	e.printStackTrace();
} %>
</html>


<script type="text/javascript">
var weekpicker, start_date, end_date, weekpickerstartdate, weekpickerstartday, weekpickerstartmonth, weekpickerstartyear;

function set_week_picker(date) {
    start_date = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
    end_date = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
    weekpicker.datepicker('update', start_date);
    weekpicker.val(start_date.getDate() + '/' + (start_date.getMonth() + 1)  + '/' + start_date.getFullYear() + ' - ' + end_date.getDate() + '/' + (end_date.getMonth() + 1) + '/' + end_date.getFullYear());
    weekpickerstartdate.val(start_date.getDate() + '/' + (start_date.getMonth() + 1)  + '/' + start_date.getFullYear() + ' - ' + end_date.getDate() + '/' + (end_date.getMonth() + 1) + '/' + end_date.getFullYear());
    weekpickerstartday.val(start_date.getDate());
    weekpickerstartmonth.val(start_date.getMonth() + 1);
    weekpickerstartyear.val(start_date.getFullYear());
    
}
$(document).ready(function() {
    weekpicker = $('.week-picker');
    weekpickerstartdate = $('#week-picker-start-date');
    weekpickerstartday = $('#week-picker-start-day');
    weekpickerstartmonth = $('#week-picker-start-month');
    weekpickerstartyear = $('#week-picker-start-year');
    weekpicker.val($('#week-picker-string').val());
    console.log(weekpicker);
    weekpicker.datepicker({
        autoclose: true,
        forceParse: false,
        container: '#week-picker-wrapper',
    }).on("changeDate", function(e) {
        set_week_picker(e.date);
    });
    $('.week-prev').on('click', function() {
        var prev = new Date(start_date.getTime());
        prev.setDate(prev.getDate() - 1);
        //set_week_picker(prev);
    });
    $('.week-next').on('click', function() {
        var next = new Date(end_date.getTime());
        next.setDate(next.getDate() + 1);
        //set_week_picker(next);
    });
    //set_week_picker(new Date);
});

var collapsedGroups = {};

var oTable = $('#weeklyDataTable').DataTable({
  paging: false,
  "language": {
    "search": "Table search: "
  },
  order: [
    [0, 'asc']
  ],
  rowGroup: {
    // Uses the 'row group' plugin
    dataSrc: 0,
    startRender: function(rows, group) {
      var collapsed = !!collapsedGroups[group];

      rows.nodes().each(function(r) {
        r.style.display = 'none';
        if (collapsed) {
          r.style.display = '';
        }
      });

      // Add category name to the <tr>. NOTE: Hardcoded colspan
      return $('<tr/>')
        .append('<td colspan="4" style="text-align: justify; cursor: pointer;" class="sticky-col first-col">' + group + ' - ' + rows.count() + ' Task(s)</td>')
        .attr('data-name', group)
        .toggleClass('collapsed', collapsed);
    }
  }
});

$('#weeklyDataTable tbody').on('click', 'tr.group-start', function() {
  var name = $(this).data('name');
  collapsedGroups[name] = !collapsedGroups[name];
  oTable.draw(false);
});

window.onload = function() {
	// Hide Empty Columns in Table
	hideEmptyCols('#weeklyDataTable', '#exportWeeklyDataTable');
};

</script>