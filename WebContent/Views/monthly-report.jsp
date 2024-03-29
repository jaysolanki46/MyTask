<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@page import="config.EnumMyTask.SKYZERPROJECTSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERTASKPRIORITY"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
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
<title>Skyzer - My Task | Monthly Report</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "", userdepartment = "";
	Float taskColumnTotal = 0f, taskRowTotal = 0f;
	String reportMonth = "", reportYear = "";
	
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
	taskList.put(4, "Task 4");
	
	Calendar currentMonth = Calendar.getInstance();
	Calendar now;
	SimpleDateFormat dd_MMMFormate = new SimpleDateFormat("dd MMM");
	SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ddMMMFormate = new SimpleDateFormat("ddMMM");
	SimpleDateFormat mmFormate = new SimpleDateFormat("MM");
	SimpleDateFormat mmmmFormate = new SimpleDateFormat("MMMM");
	SimpleDateFormat yyyyFormate = new SimpleDateFormat("YYYY");
	SimpleDateFormat yyyyMMFormate = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat ddMMyyyyFormate = new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat MMyyyyFormate = new SimpleDateFormat("MM-yyyy");
	
	String monthString;
	
	if (request.getParameter("datepicker") != null) {
		Date date = new SimpleDateFormat("MMMM-yyyy").parse(request.getParameter("datepicker")); // Gets int from month name
		currentMonth.setTime(date);
	}
	monthString =  mmmmFormate.format(currentMonth.getTime()) + "-" + yyyyFormate.format(currentMonth.getTime());
	System.out.println(monthString);
	int delta = 0;
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

#monthlyDataTable .sticky-col {
  position: -webkit-sticky;
  position: sticky;
  background-color: #eee;
}

#monthlyDataTable .first-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 0px;
}

#monthlyDataTable .second-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 100px;
}

#monthlyDataTable .third-col {
  width: 100px;
  min-width: 100px;
  max-width: 100px;
  left: 200px;
}

#monthlyDataTable .fourth-col {
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
										                <h5 class="modal-title">Monthly Report Tutorial</h5>
										                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">�</span></button>
										            </div>
										            <div class="modal-body">
										                <iframe id="tutorialiframe" height="100%" width="100%" src="https://www.youtube.com/embed/C8HOmHPc3cA"></iframe>
										            </div>
										        </div>
										    </div>
										</div>
		                                
		                            </div>
		                        </div>
		                        <hr style="margin: 0rem;">
                                <nav class="nav nav-borders nav-width">
                                    <a class="nav-link  ml-0" href="/MyTask/Views/weekly-report.jsp">Weekly</a>
                                    <a class="nav-link active ml-0" style="color: <%=bckColor %>; border-bottom-color: <%=bckColor %>;" href="/MyTask/Views/monthly-report.jsp">Monthly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/custom-report.jsp">Custom</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/project-report.jsp">Project</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/task-report.jsp">Task</a>
                                    
                                     <!-- Weekly datepicker -->
                                     
		                              <div class="form-group col-md-4 col-md-offset-2" id="week-picker-wrapper" style="margin: 0rem; margin-left: auto;">
											<div class="input-group">
											<form class="form-inline"  method="post" action="../Views/monthly-report.jsp">
												<label style="color: <%=bckColor %>">Select Month: </label>
												<input type="text" class="form-control" name="datepicker" id="datepicker" readonly="readonly" onchange="this.form.submit();"
													value="<%=monthString %>" placeholder="Select a Month" style="margin: 0.2rem; text-align: center; width: 17rem;"/>
												
												</form>
											</div>
										</div>
                                <!-- End of weekly datepicker -->
                                </nav>
                                
                               
                            </div>
                        </header>
                    <!-- Main page content-->
                    <div class="container">
                            <button type="submit" title="CSV Export"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="exportTableToCSV('Monthly-report.csv', 'exportMonthlyDataTable');">
											<i class="fas fa-file-csv"></i>&nbsp; Export</button>	
                            <table id="monthlyDataTable" class="table table-bordered" style="border: hidden; overflow-x: auto; display: block;">
						    <thead>
							      <tr>
							      	<th style="width: 10%;" class="sticky-col first-col">Project</th>
							        <th style="text-align: center;  width: 30%;"  class="sticky-col second-col">Task</th>
							        <th class="sticky-col third-col">Priority</th>
							        <th class="sticky-col fourth-col">Assignee</th>
							        <%
							        
								        now = currentMonth;
								        delta = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH); //number of days in month
							        
								        for (int i = 1; i <= delta; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=i + "/" + mmFormate.format(now.getTime()) %></th><% 
								        	reportMonth = mmFormate.format(now.getTime());
								        	reportYear = yyyyFormate.format(now.getTime());
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
										"(MONTH(project.created_on) <= '"+ reportMonth +"' AND YEAR(project.created_on) <= '"+ reportYear +"') AND (project_team.team_member = "+ userid +") group by task.name order by project.id DESC");
						        
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
											    	now = currentMonth;
								       				delta = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH); //number of days in month
								       				taskColumnTotal = 0f; taskRowTotal = 0f;
								       				
								       				for (int i = 1; i <= delta; i++)
											        {
											        	%>
											        		<td>
											        			<% // Getting hours from task_details
											        				Integer taskId = key;
											        				String tableDate = yyyyMMddFormate.format(now.getTime()); 
											        				Float taskHours = 0f;
											        				String taskDescription = "";
											        				
											        				rsNested = stNested.executeQuery("SELECT taskdetail.* FROM task_details taskdetail where taskdetail.task = "+ taskId +" AND " 
											        						+ "day(taskdetail.task_detail_date) = "+ String.format("%02d", i) + " AND "
											        						+ "month(taskdetail.task_detail_date) = month('"+ tableDate + "') AND "
											        						+ "year(taskdetail.task_detail_date) = year('"+ tableDate + "');"
											        						);
											        				
											        				if(rsNested.next()){
											        					taskHours = rsNested.getFloat("taskdetail.hours");
											        					taskDescription = rsNested.getString("taskdetail.description");
											        				}
								        							taskRowTotal += taskHours;
											        			%>
											        			
											        			<label id="hoursLable" name="hoursLable" style="cursor: pointer;" class=""
											        			><%if(taskHours > 0)%><%=taskHours%><%else%><%="-"%></label>
											        			
													        </td>
											        	<% 
											        }
										        %>
										        <td>
										        	<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=taskRowTotal  %>">
										        </td>
										      </tr>
								        
								        
								        <%
								    }
							     %>	
						    </tbody>
						   
						  </table>
						  
						   <!-- Hidden table for export -->
						  <div style="display: none;">
						  <table id="exportMonthlyDataTable" class="table table-bordered" style="border: hidden;">
						    <thead>
							      <tr>
							      	<th style="width: 10%;">Project</th>
							        <th style="text-align: center;  width: 30%;">Task</th>
							        <th>Priority</th>
							        <th>Assignee</th>
							        <th>Comments / Description</th>
							        <th>Progress</th>
							        <%
							        
								        now = currentMonth;
								        delta = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH); //number of days in month
							        
								        for (int i = 1; i <= delta; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=i + "/" + mmFormate.format(now.getTime()) + "/" + yyyyFormate.format(now.getTime()) %></th><% 
								        	reportMonth = mmFormate.format(now.getTime());
								        	reportYear = yyyyFormate.format(now.getTime());
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
						        
						        rs = st.executeQuery("select project.*, task.* from projects project " +  
						        		"LEFT JOIN project_team project_team ON project.id = project_team.project " +
						        		"LEFT JOIN tasks task ON project.id = task.project " +
										"where (project.status = "+ SKYZERPROJECTSTATUS.OPENED.getValue() +") AND (task.status = "+ SKYZERTASKSTATUS.OPENED.getValue() +") " +
										"AND (project.department = "+ userdepartment +" OR project.department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +") AND " + 
										"(MONTH(project.created_on) <= '"+ reportMonth +"' AND YEAR(project.created_on) <= '"+ reportYear +"') AND (project_team.team_member = "+ userid +") group by task.name order by project.id DESC");
						        
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
										        <td><%=rs.getString("project.name") %></td>
										        <td style="text-align: inherit;"><%=name %></td>
										        <td><%='\"'+ priority + '\"'%></td>
										        <td><%=assignee.toUpperCase() %></td>
										        <td><%='\"'+rs.getString("task.description") + '\"'%></td>
										        <td><%=rs.getInt("task.percentage") %>%</td>
										        <%
											     	// 5 days
											    	now = currentMonth;
								       				delta = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH); //number of days in month
								       				taskColumnTotal = 0f; taskRowTotal = 0f;
								       				
								       				for (int i = 1; i <= delta; i++)
											        {
											        	%>
											        		<td><% // Getting hours from task_details
											        				Integer taskId = key;
											        				String tableDate = yyyyMMddFormate.format(now.getTime()); 
											        				Float taskHours = 0f;
											        				String taskDescription = "";
											        				
											        				rsNested = stNested.executeQuery("SELECT taskdetail.* FROM task_details taskdetail where taskdetail.task = "+ taskId +" AND " 
											        						+ "day(taskdetail.task_detail_date) = "+ String.format("%02d", i) + " AND "
											        						+ "month(taskdetail.task_detail_date) = month('"+ tableDate + "') AND "
											        						+ "year(taskdetail.task_detail_date) = year('"+ tableDate + "');"
											        						);
											        				
											        				if(rsNested.next()){
											        					taskHours = rsNested.getFloat("taskdetail.hours");
											        					taskDescription = rsNested.getString("taskdetail.description");
											        				}
								        							taskRowTotal += taskHours;
											        			%><label id="hoursLable" name="hoursLable" 
											        			style="cursor: pointer;" class=""><%if(taskHours > 0)%><%=taskHours %><%else%><%="-"%></label></td>
											        	<% 
											        }
										        %>
										        <td><%=taskRowTotal  %></td>
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
$("#datepicker").datepicker( {
    format: "MM-yyyy",
    startView: "months", 
    minViewMode: "months"
});

var collapsedGroups = {};

var oTable = $('#monthlyDataTable').DataTable({
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
        .append('<td colspan="4" style="text-align: justify; cursor: pointer;" class="sticky-col first-col"">' + group + ' - ' + rows.count() + ' Task(s)</td>')
        .attr('data-name', group)
        .toggleClass('collapsed', collapsed);
    }
  }
});

$('#monthlyDataTable tbody').on('click', 'tr.group-start', function() {
  var name = $(this).data('name');
  collapsedGroups[name] = !collapsedGroups[name];
  oTable.draw(false);
});

window.onload = function() {
	// Hide Empty Columns in Table
	hideEmptyCols('#monthlyDataTable', '#exportMonthlyDataTable');
};
</script>