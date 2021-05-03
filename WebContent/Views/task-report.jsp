<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@page import="javafx.util.Pair"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.time.LocalDate" %>
<%@ page language="java" import="java.text.SimpleDateFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Task Report</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "", userdepartment = "";
	String reportTask = "", taskCreatedOn = "", reportStartDate = "", reportEndDate = ""; 
	Integer taskColumnTotal = 0, taskRowTotal = 0;
	
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
	
	reportTask = request.getParameter("selectProject");
	
	System.out.println(reportTask);
	
	SimpleDateFormat dd_MMMFormate = new SimpleDateFormat("dd MMM");
	SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ddMMMFormate = new SimpleDateFormat("ddMMM");
	SimpleDateFormat mmFormate = new SimpleDateFormat("MM");
	SimpleDateFormat mmmmFormate = new SimpleDateFormat("MMMM");
	SimpleDateFormat yyyyFormate = new SimpleDateFormat("YYYY");
	
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
		                                <div class="row align-items-center justify-content-between pt-3">
		                                    <div class="col-auto mb-3">
		                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold;font-size: x-large;">
		                                            <div class="page-header-icon">
		                                          		<i class="fas fa-clipboard-list"></i>
		                                            </div>
		                                            Reports
		                                        </h1>
		                                    </div>
		                                    
		                                </div>
		                            </div>
		                        </div>
		                        <hr style="margin: 0rem;">
                                <nav class="nav nav-borders nav-width">
                                    <a class="nav-link  ml-0" href="/MyTask/Views/weekly-report.jsp">Weekly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/monthly-report.jsp">Monthly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/monthly-report.jsp">Custom</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/monthly-report.jsp">Project</a>
                                    <a class="nav-link active ml-0" style="color: <%=bckColor %>; border-bottom-color: <%=bckColor %>;"  href="/MyTask/Views/task-report.jsp">Task</a>
                                </nav>
                            </div>
                        </header>
                    <!-- Main page content-->
                    <div class="container">
                    	
                    	 <!--  Custom search -->
                            <div id="divCustom" class="card-body" style="padding: 0px;">
                            <div class="card mb-3">
				
									<div class="card-body" style="padding: 10px;">
										<form class="form-inline" action="#" method="post">
											<label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Select a Task:</label> 
											<select class="form-control col-sm-4" id="selectProject" name="selectProject">
												<option value="">Select a Task...</option>
												<%
													rs = st.executeQuery("select task.* from tasks task LEFT JOIN projects project ON project.id = task.project  where department = " + userdepartment + " OR department = " + SKYZERDEPARTMENTS.GENERAL.getValue() + "");
													
													while (rs.next()) {
													%>
														<option value="<%=rs.getInt("id")%>" 
														<%
															if(reportTask != null && reportTask.equals(rs.getString("id"))) {
																%>selected<%
															}	
														%>
														><%=rs.getString("name")%></option>
													<%
													}
													%>
											</select> 
										
											<button type="submit" title="Search"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="this.form.submit();">
											<i class="fas fa-search"></i>&nbsp; Search</button>	
										</form>
                            		</div>
                            </div>
                            </div>
                            <!--  End of custom search -->
                    		
                    		<%
                    		if(reportTask != null && !reportTask.isEmpty()) {
                    		%>
                            <div style="overflow: auto;    height: 40rem;    width: 100%;">
                             <button type="submit" title="Search"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="exportTableToCSV('Task-report.csv');">
											<i class="fas fa-file-csv"></i>&nbsp; Export</button>	
                            <table id="taskDataTable" class="table table-bordered" style="border: hidden;">
						    <thead>
							      <tr>
							      	<th>Project</th>
							        <th style="text-align: center;">Task</th>
							        <th>Assignee</th>
							        <%
							        	rs = st.executeQuery("SELECT * FROM tasks where id = " + reportTask + "");	
							        
							        	while(rs.next()){
							        		taskCreatedOn = rs.getString("created_on");
									        for (LocalDate date = LocalDate.parse(taskCreatedOn); date.isBefore(LocalDate.now().plusDays(1)); date = date.plusDays(1)) {
									        	%><th style="text-align: -webkit-center;"><%=date.getDayOfMonth() + "/" + date.getMonthValue() + "/" + date.getYear() %></th><% 
									        }
							        	}
							        
							        %>
							       
							        <th style="text-align: center;">Total hours</th>
							      </tr>
							    </thead>
						    
						    <tbody>
							     <% 
								    Integer key = 0;
							        String name = "";
							        String assignee =  "";
							        String profileColor = "green";
							        
									rs = st.executeQuery("select project.*, task.* from projects project " +  
											"LEFT JOIN tasks task ON project.id = task.project " +
											"LEFT JOIN task_details taskdetail ON taskdetail.task = task.id " +  
											"where (task.id = "+ reportTask +") AND " + 
											"taskdetail.task_detail_date between '"+ taskCreatedOn +"' and '"+ LocalDate.now() +"' group by task.name order by project.id DESC");

									while(rs.next()) {   
									   	key = rs.getInt("task.id");
									    name = rs.getString("task.name");
									    rsNested = stNested.executeQuery("SELECT * FROM users where id = "+ rs.getInt("task.team_member") +"");
									   	if(rsNested.next()) assignee = rsNested.getString("name");
								        	
								%>
								<tr>
									<td><%=rs.getString("project.name") %></td>
									<td style="text-align: inherit;"><%=name%>
									<div class="progress rounded-pill" title="<%=rs.getInt("task.percentage") %>% completed"
													style="height: 0.5rem; margin-top: 0.5rem;">
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
									<td><div id="profileImage" style="background: <%=profileColor %>" title="<%=assignee %>"><%=assignee.toUpperCase().substring(0, 2) %></div></td>
									<%
										 taskRowTotal = 0;
									
										for (LocalDate date = LocalDate.parse(taskCreatedOn); date.isBefore(LocalDate.now().plusDays(1)); date = date.plusDays(1)) {
								        	%><td><%
													// Getting hours from task_details
														Integer taskId = key;
														String tableDate = date.getYear() + "-" + String.format("%02d", date.getMonthValue()) + "-" + String.format("%02d", date.getDayOfMonth());
														Integer taskHours = 0;
														String taskDescription = "";
														
														rsNested = stNested.executeQuery("SELECT taskdetail.* FROM task_details taskdetail where taskdetail.task = "+ taskId +" AND " 
								        						+ "day(taskdetail.task_detail_date) = day('"+ tableDate + "') AND "
								        						+ "month(taskdetail.task_detail_date) = month('"+ tableDate + "') AND "
								        						+ "year(taskdetail.task_detail_date) = year('"+ tableDate + "');"
								        						);
								        				
								        				if(rsNested.next()){
								        					taskHours = rsNested.getInt("taskdetail.hours");
								        					taskDescription = rsNested.getString("taskdetail.description");
								        				}
														taskRowTotal += taskHours;
													%> 
													<label id="hoursLable" name="hoursLable"
														style="cursor: pointer;" class="">
														<%
											        		if(taskHours > 0)
											        			%><%=taskHours + ":00"%><%
											        		else
											        			%><%="-"%>
													</label></td><%
													
												
								        }
									%>
									<td><label class="total-hours-text"><%=taskRowTotal %>:00</label></td>
								</tr>
								 <%
								 		taskColumnTotal += taskRowTotal;
								   }
							     %>	
						    </tbody>
						    <tfoot>
							    	<tr>
							    		<th colspan="3"  style="text-align: inherit;">
							    			Total hours:
							    		</th>
							    		<%
							    		for (LocalDate date = LocalDate.parse(taskCreatedOn); date.isBefore(LocalDate.now().plusDays(1)); date = date.plusDays(1)) {
							    			%>
							    				<th></th>
							    			<%
							    		}
							    		%>
							    		<th><label class="total-hours-text"><%=taskColumnTotal %>:00</label></th>
							    	</tr>
							 </tfoot>
						  </table>
						  
						  <!-- Hidden table for export -->
						  <div style="display: none;">
						  <table id="exportTaskDataTable" class="table table-bordered" style="border: hidden;">
						    <thead>
							      <tr>
							      	<th>Project</th>
							        <th style="text-align: center;">Task</th>
							        <th>Assignee</th>
							        <%
							        	rs = st.executeQuery("SELECT * FROM tasks where id = " + reportTask + "");	
							        
							        	while(rs.next()){
							        		taskCreatedOn = rs.getString("created_on");
									        for (LocalDate date = LocalDate.parse(taskCreatedOn); date.isBefore(LocalDate.now().plusDays(1)); date = date.plusDays(1)) {
									        	%><th style="text-align: -webkit-center;"><%=date.getDayOfMonth() + "/" + date.getMonthValue() + "/" + date.getYear() %></th><% 
									        }
							        	}
							        
							        %><th style="text-align: center;">Total hours</th>
							      </tr>
							    </thead>
						    <tbody>
							     <% 
								    key = 0;
							        name = "";
							        assignee =  "";
							        taskColumnTotal = 0;
							        
									rs = st.executeQuery("select project.*, task.* from projects project " +  
											"LEFT JOIN tasks task ON project.id = task.project " +
											"LEFT JOIN task_details taskdetail ON taskdetail.task = task.id " +  
											"where (task.id = "+ reportTask +") AND " + 
											"taskdetail.task_detail_date between '"+ taskCreatedOn +"' and '"+ LocalDate.now() +"' group by task.name order by project.id DESC");

									while(rs.next()) {   
									   	key = rs.getInt("task.id");
									    name = rs.getString("task.name");
									    rsNested = stNested.executeQuery("SELECT * FROM users where id = "+ rs.getInt("task.team_member") +"");
									   	if(rsNested.next()) assignee = rsNested.getString("name");
								        	
								%>
								<tr>
									<td><%=rs.getString("project.name") %></td>
									<td style="text-align: inherit;"><%=name%></td>
									<td><%=assignee.toUpperCase()%></td>
									<%
										 taskRowTotal = 0;
									
										for (LocalDate date = LocalDate.parse(taskCreatedOn); date.isBefore(LocalDate.now().plusDays(1)); date = date.plusDays(1)) {
								        	%><td><%
													// Getting hours from task_details
														Integer taskId = key;
														String tableDate = date.getYear() + "-" + String.format("%02d", date.getMonthValue()) + "-" + String.format("%02d", date.getDayOfMonth());
														Integer taskHours = 0;
														String taskDescription = "";
														
														rsNested = stNested.executeQuery("SELECT taskdetail.* FROM task_details taskdetail where taskdetail.task = "+ taskId +" AND " 
								        						+ "day(taskdetail.task_detail_date) = day('"+ tableDate + "') AND "
								        						+ "month(taskdetail.task_detail_date) = month('"+ tableDate + "') AND "
								        						+ "year(taskdetail.task_detail_date) = year('"+ tableDate + "');"
								        						);
								        				
								        				if(rsNested.next()){
								        					taskHours = rsNested.getInt("taskdetail.hours");
								        					taskDescription = rsNested.getString("taskdetail.description");
								        				}
														taskRowTotal += taskHours;
													%><label id="hoursLable" name="hoursLable" style="cursor: pointer;" class=""><%
											        		if(taskHours > 0)
											        			%><%=taskHours + ":00"%><%
											        		else
											        			%><%="-"%></label></td><%
													}
									%><td><label class="total-hours-text"><%=taskRowTotal %>:00</label></td>
								</tr>
								 <%
								 		taskColumnTotal += taskRowTotal;
								   }
							     %>	
						    </tbody>
						    <tfoot>
							    	<tr>
							    		<th style="text-align: inherit;">Total hours:</th>
							    		<%
							    		for (LocalDate date = LocalDate.parse(taskCreatedOn); date.isBefore(LocalDate.now().plusDays(3)); date = date.plusDays(1)) {
							    			%>
							    				<th>-</th>
							    			<%
							    		}
							    		%>
							    		<th><label class="total-hours-text"><%=taskColumnTotal %>:00</label></th>
							    	</tr>
							 </tfoot>
						  </table>
						  </div>
						  <!-- End hidden table for export -->
						  
                    		</div>
                    		<%
                    		}
                    		%>
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

var oTable = $('#taskDataTable').DataTable({
  paging: false,
  "language": {
    "search": "Table search: "
  },
  order: [
    [1, 'asc']
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
        .append('<td colspan="32" style="text-align: justify;">' + group + ' - ' + rows.count() + ' Task(s)</td>')
        .attr('data-name', group)
        .toggleClass('collapsed', collapsed);
    }
  }
});

$('#taskDataTable tbody').on('click', 'tr.group-start', function() {
  var name = $(this).data('name');
  collapsedGroups[name] = !collapsedGroups[name];
  oTable.draw(false);
});
function exportTableToCSV(filename) {
	
	var csv = [];
	var rows = document.getElementById('exportTaskDataTable').getElementsByTagName('tr');
	
	for(var i = 0; i < rows.length; i++) {
		var row = [];
		var cols = rows[i].querySelectorAll("td, th");
		
		for(var j = 0; j < cols.length; j++) {
			row.push(cols[j].innerText);
		}
		
		csv.push(row.join(","));
	}
	
	downloadCSV(csv.join("\n"), filename);
}

function downloadCSV(csv, filename) {
	
	var csvFile;
	var downloadLink;
	
	csvFile = new Blob([csv], {type: "text/csv"});
	
	downloadLink = document.createElement("a");
	downloadLink.download = filename;
	downloadLink.href = window.URL.createObjectURL(csvFile);
	downloadLink.style.display = "none";
	
	document.body.appendChild(downloadLink);
	
	downloadLink.click();
}
</script>