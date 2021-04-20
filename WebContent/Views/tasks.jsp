<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="javafx.util.Pair"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.text.SimpleDateFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Tasks</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "", userdepartment = "";
	String projectId = "";
	Integer taskColumnTotal = 0, taskRowTotal = 0;
	Integer myTaskColumnTotalMon = 0, myTaskColumnTotalTue = 0, myTaskColumnTotalWed = 0, myTaskColumnTotalThu = 0, myTaskColumnTotalFri = 0;
	Integer myTeamTaskColumnTotalMon = 0, myTeamTaskColumnTotalTue = 0, myTeamTaskColumnTotalWed = 0, myTeamTaskColumnTotalThu = 0, myTeamTaskColumnTotalFri = 0;
	
	Connection dbConn = DBConfig.connection(); ;
	Statement st = null;
	ResultSet rs = null;
	st = dbConn.createStatement();
	
	Connection dbConnTask = DBConfig.connection(); ;
	Statement stTask = null;
	ResultSet rsTask = null;
	stTask = dbConnTask.createStatement();
	
	Connection dbConnNested = DBConfig.connection(); ;
	Statement stNested = null;
	ResultSet rsNested = null;
	stNested = dbConnNested.createStatement();
	
	Connection dbConnHours= DBConfig.connection(); ;
	Statement stHours = null;
	ResultSet rsHours = null;
	stHours = dbConnNested.createStatement();

	
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
	
	try{
		projectId =  new String(Base64.getDecoder().decode(request.getParameter("project")));
		
		
	} catch (Exception e) {
		session.setAttribute("status", "info");
		RequestDispatcher dispatcher = request.getRequestDispatcher("./projects.jsp");
		dispatcher.forward(request, response);
	}
	
	// Number of tasks
	Map<Integer, String> taskList = new HashMap<Integer, String>();
	taskList.put(1, "Task 1");
	taskList.put(2, "Task 2");
	taskList.put(3, "Task 3");
	//taskList.put(4, "Task 4");
	
	// 5 days
	Calendar now = Calendar.getInstance();
	SimpleDateFormat dd_MMMFormate = new SimpleDateFormat("dd MMM");
	SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ddMMMFormate = new SimpleDateFormat("ddMMM");
	SimpleDateFormat ddMMyyyyFormate = new SimpleDateFormat("dd-MM-yyyy");

	int delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
	now.add(Calendar.DAY_OF_MONTH, delta);
	String daysList[] = { "Mon", "Tue", "Wed", "Thurs", "Fri" };
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
                <%
					rs = st.executeQuery("SELECT * FROM projects where id = "+ projectId +"");
                    while(rs.next()) {   
				%>	
                <main>
                    <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
                        <div class="container-fluid">
                            <div class="page-header-content">
                                <div class="row align-items-center justify-content-between pt-3">
                                    <div class="col-auto mb-3">
                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold;font-size: x-large;">
                                            <div class="page-header-icon">
                                          		<i class="far fa-calendar-plus"></i> 
                                            </div>
                                            <%=rs.getString("name") %>
                                        </h1>
                                    </div>
                                    <div class="col-12 col-xl-auto mb-3">
                                        <button 
                                        data-toggle="modal" data-target="#projectModelLg"
                                        class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "><i class="fas fa-plus"></i>&nbsp;Create New Task</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container">
                        <div class="row">
                        	
                        	<!-- Model create a new task -->
                        	<div class="modal fade" id="projectModelLg" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
							    <div class="modal-dialog modal-lg" role="document">
							    	<form action="<%=request.getContextPath()%>/TaskServlet" method="post">
							        <div class="modal-content">
							            <div class="modal-header">
							                <h5 class="modal-title">Create a new task</h5>
							                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
							            </div>
							            <div class="modal-body">
							                	<div class="row">
							                		<div class="col">
													    <div class="form-group">
														    <label for="projectNameInput">Task name <span style="color: red;">*</span></label>
														    <input style="height: fit-content;" class="form-control" id="name" name="name" type="text" placeholder="Ex. IKR Project">
													    </div>
												    </div>
												    <div class="col">
													    <div class="form-group">
													        <label for="departmentSelect">Project <span style="color: red;">*</span></label>
													        <input style="height: fit-content;" class="form-control" type="text" value="<%=rs.getString("name") %>" readonly="readonly">
													        <input style="height: fit-content;" class="form-control" id="hiddenProjectId" name="hiddenProjectId" type="hidden" value="<%=projectId %>">
													    </div>
												    </div>
											    </div>
											    <div class="form-group">
											        <label for="teamMemberSelect">Team members <span style="color: red;">*</span></label><br/>
											        <select class="form-control" id="teamMember" name="teamMember">
											        	<option>Select member...</option>
											        <%
											        	rsNested = stNested.executeQuery("SELECT * FROM project_team where project = "+ projectId +"");
											        	List<Integer> projectTeamMemberList = new ArrayList<Integer>();
											        	String projectTeamStr = "";
										        		while(rsNested.next()) {
										        			projectTeamMemberList.add(rsNested.getInt("team_member"));		
										        		}
										        		
										        		projectTeamStr = projectTeamMemberList.toString().replace("[", "").replace("]", "").replace(" ", "");
										        		
										        		rsNested = stNested.executeQuery("SELECT * FROM users where id IN ("+ projectTeamStr +")");
										        		while(rsNested.next()) {
										        			%><option value="<%=rsNested.getInt("id") %>"><%=rsNested.getString("name") %></option><%		
										        		}
											        %>
											        </select>
											    </div>
											    <div class="form-group">
												    <label for="descriptionTextarea">Description</label>
												    <textarea class="form-control" id="description" name="description" rows="4"></textarea>
											    </div>
							            </div>
							            <div class="modal-footer">
							            	<button type="submit" title="Search"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="this.form.submit();">
											<i class="fas fa-save"></i>&nbsp; Save</button>	
							            </div>
							        </div>
							        </form>
							    </div>
							</div>
                        	<!-- End Model create a new task -->
                            
                            <!--  Custom edit -->
                            <div class="modal fade" id="customTaskDetailModel" tabindex="-1" role="dialog" aria-labelledby="customTaskDetailModelLbl" aria-hidden="true">
                            	<div class="modal-dialog modal-md" role="document">
										<form action="<%=request.getContextPath()%>/TaskDetailServlet"
											method="post">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title">Custom Task Details Update</h5>
													<button class="close" type="button" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">×</span>
													</button>
												</div>
												<div class="modal-body">
													<div class="row">
													<div class="col-md-12">
														<label for="userEmail">Task</label>
														<!-- To make use same insert method gave select name="hiddenTaskId", however, it is not hidden at all-->
														<input type="hidden" id="hiddenProjectId" name="hiddenProjectId" value=<%=projectId %> class="form-control">
														<select class="form-control" id="hiddenTaskId" name="hiddenTaskId">
														        <%
														        	rsNested = stNested.executeQuery("SELECT * FROM tasks where project = "+ projectId +"  AND team_member = "+ userid +"");
													        		while(rsNested.next()) {
													        			%><option value="<%=rsNested.getInt("id") %>"><%=rsNested.getString("name") %></option><%		
													        		}
														        %>
														 </select>
													</div>
													</div>
													<div class="row">
														<div class="col-md-6">
															<label for="taskDetailDate">Date</label>
															<input type="date" id="taskDetailDate" name="taskDetailDate" 
																max="31-12-3000" min="01-01-1000" class="form-control">
														</div>
														<div class="col-md-6">
															<label for="departmentSelect">Hours <span
																	style="color: red;">*</span></label> 
																<input class="form-control" type="number" min="0" max="12"
																	value="0" id="taskDetailHours"
																	name="taskDetailHours">
														</div>
													</div>	
													<div class="row">
														<div class="col">
															<div class="form-group" style="text-align: start;">
																<label for="departmentSelect">Description<span
																	style="color: red;">*</span></label>
																<textarea class="form-control"
																	id="taskDetailDescription" name="taskDetailDescription"
																	rows="4"></textarea>
															</div>
														</div>
													</div>
												</div>
												<div class="modal-footer">
													<div style="margin-right: auto; margin-left: 0.5rem;">
														<input class="" id="taskIsCompleted"
															name="taskIsCompleted" type="checkbox">
														<label class="" for="customCheck1">Complete</label>
													</div>
													<button type="submit" title="Search"
														class="btn btn-sm btn-light active mr-3 center_div card-button"
														style="background-color:<%=bckColor%>; "
														onclick="this.form.submit();">
														<i class="fas fa-save"></i>&nbsp; Save
													</button>
												</div>
											</div>
										</form>
									</div>
                            </div>
                            <!--  End of custom edit -->
                           
                            <!-- My Task Table -->
                            <table class="table" style="border: hidden; margin-top: -1rem;">
                            	<tr style="border-top: hidden;">
	                            	<td style="border-right: hidden;">
	                            		<h2>My Tasks</h2>
	                            	</td>
	                            	<td style="text-align: end;">
											<label class="form-check-label" for="checkboxCustom" style="color: blue; font-style: italic; text-decoration: underline; cursor: pointer;"
											onclick="#customTaskDetailModel" data-toggle="modal" data-target="#customTaskDetailModel">Custom Update?</label>
	                            	</td>
	                            </tr>
	                            <tr style="border-top: hidden;">
                            	<td style="padding: 0rem; vertical-align: middle; border-left: hidden;"  colspan="2">
                            	<!-- Task Table -->
	                            <table class="table table-bordered">
							    <thead>
							      <tr>
							        <th style="text-align: center;">Tasks</th>
							        <th>Assignee</th>
							        <%
							        
								        now = Calendar.getInstance();
								        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
								        now.add(Calendar.DAY_OF_MONTH, delta );
							        
								        for (int i = 0; i < 5; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=dd_MMMFormate.format(now.getTime()) + " , " + daysList[i] %></th><% 
								        	now.add(Calendar.DAY_OF_MONTH, 1);
								        }
							        	
							        %>
							       
							        <th style="text-align: -webkit-center;">Total hours</th>
							      </tr>
							    </thead>
							    <tbody>
							    	
							    <% 
							    Integer key = 0;
						        String name = "";
						        String assignee =  "";
						        String profileColor = "green";
						        Boolean isCompleted = false;
						        
						        	rsTask = stTask.executeQuery("SELECT * FROM tasks where project = "+ projectId +"  AND team_member = "+ userid +"");
						        
								    while(rsTask.next()) {
								    	key = rsTask.getInt("id");
								        name = rsTask.getString("name");
								        isCompleted = rsTask.getBoolean("is_completed");
								        System.out.print(isCompleted);
								        
								        	rsNested = stNested.executeQuery("SELECT * FROM users where id = "+ rsTask.getInt("team_member") +"");
								        	if(rsNested.next()) assignee = rsNested.getString("name");
								        
								        %>
								        	<tr>
										        <td style="text-align: inherit;">
										        	<%=name %> 
										        </td>
										        <td>
										        	<!-- will come from db -->
													<div id="profileImage" style="background: <%=profileColor %>" title=<%=assignee %>>
														<%=assignee.toUpperCase().substring(0, 2) %>
													</div>
										        </td>
										        <%
										        
											     	// 5 days
											    	now = Calendar.getInstance();
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
											        taskColumnTotal = 0; taskRowTotal = 0;

											        for (int i = 0; i < 5; i++)
											        {
											        	%>
											        		<td>
											        			<% // Getting hours from task_details
											        				Integer taskId = key;
											        				String taskDate = yyyyMMddFormate.format(now.getTime());
											        				Integer taskHours = 0;
											        				String taskDescription = "";
											        				
											        				rsHours = stHours.executeQuery("SELECT * FROM task_details where task = "+ taskId +" AND task_detail_date = '"+ taskDate +"' order by id DESC");
								        							if(rsHours.next()) {
								        								taskHours = rsHours.getInt("hours");
								        								taskDescription = rsHours.getString("description");
								        							}
								        							taskRowTotal += taskHours;
								        							
								        							switch (i){
								        								case 0: myTaskColumnTotalMon += taskHours; taskColumnTotal += myTaskColumnTotalMon; break;
								        								case 1: myTaskColumnTotalTue += taskHours; taskColumnTotal += myTaskColumnTotalTue; break;
								        								case 2: myTaskColumnTotalWed += taskHours; taskColumnTotal += myTaskColumnTotalWed; break;
								        								case 3: myTaskColumnTotalThu += taskHours; taskColumnTotal += myTaskColumnTotalThu; break;
								        								case 4: myTaskColumnTotalFri += taskHours; taskColumnTotal += myTaskColumnTotalFri; break;
								        							}
											        			%>
											        			<input class="form-control form-control-sm hours-text" type="text" readonly="readonly"
											        			onclick="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" data-toggle="modal" 
											        			data-target="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" 
											        			value="<%=taskHours %>:00">
													        	
													        	<!-- Model update task -->
									                        	<div class="modal fade" id="taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
																    <div class="modal-dialog modal-sm" role="document">
																    	<form action="<%=request.getContextPath()%>/TaskDetailServlet" method="post">
																        <div class="modal-content">
																            <div class="modal-header">
																                <h5 class="modal-title"><%=name %> - <%=ddMMyyyyFormate.format(now.getTime()) %></h5>
																                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
																            </div>
																            <div class="modal-body">
																                	<div class="row">
																                		<div class="col" style="display: none;">
																						    <div class="form-group" style="text-align: start;">
																							    <label for="projectNameInput">Date <span style="color: red;">*</span></label>
																							    <input type="text" id="hiddenProjectId" name="hiddenProjectId"
																							    value=<%=rs.getInt("id") %> class="form-control">
																							    <input type="text" id="hiddenTaskId" name="hiddenTaskId"
																							    value=<%=rsTask.getInt("id") %> class="form-control">
																							    <input type="date" id="taskDetailDate" name="taskDetailDate" max="31-12-3000" min="01-01-1000" 
																							    value="<%=yyyyMMddFormate.format(now.getTime()) %>" class="form-control">
																						    </div>
																					    </div>
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Hours <span style="color: red;">*</span></label>
																						        <input class="form-control" type="number" min="0" max="12" value=<%=taskHours %> id="taskDetailHours" name="taskDetailHours">
																						    </div>
																					    </div>
																				    </div>
																				    <div class="row">
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Description<span style="color: red;">*</span></label>
																						        <textarea class="form-control" id="taskDetailDescription" name="taskDetailDescription" rows="4"><%=taskDescription %></textarea>
																						    </div>
																					    </div>
																				    </div>
																            </div>
																            <div class="modal-footer">
																            <div style="margin-right: auto;margin-left: 0.5rem;">
																            	<input class="" id="taskIsCompleted" name="taskIsCompleted" type="checkbox"  
																            	<% if(isCompleted) { %>checked="checked"<%  } %>>
																				<label class="" for="customCheck1">Complete</label>
																            </div>
																            	<button type="submit" title="Search"
																					class="btn btn-sm btn-light active mr-3 center_div card-button"
																					style="background-color:<%=bckColor %>; "
																					onclick="this.form.submit();">
																					<i class="fas fa-save"></i>&nbsp; Save</button>	
																            </div>
																        </div>
																        </form>
																    </div>
																</div>
									                        	<!-- End Model update task -->
													        </td>
											        	<% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        }
										        
										        %>
										        <td>
										        	<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=taskRowTotal %>:00">
										        </td>
										      </tr>
								        <%
								    }
							     %>	
							    
							      
							    </tbody>
							    <tfoot>
							    	<tr>
							    		<th colspan="2"  style="text-align: inherit;">
							    			Total hours:
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTaskColumnTotalMon %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTaskColumnTotalTue %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTaskColumnTotalWed %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTaskColumnTotalThu %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTaskColumnTotalFri %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=taskColumnTotal %>:00">
							    		</th>
							    	</tr>
							    </tfoot>
							  </table>
	                           <!-- End of Task Table -->
	                           </td>
	                           </tr>
                            </table>
                            <!-- End of My Task Table -->
                           
                           	<!-- My Team Task Table -->
                            <table class="table" style="border: hidden; margin-top: -1rem;">
                            	<tr style="border-top: hidden;">
	                            	<td style="border-right: hidden;">
	                            		<h2>My Team Tasks</h2>
	                            	</td>
	                            	<td style="text-align: end;">
		                            		<input type="checkbox" class="form-check-input" id="checkboxMyTeamTaskShow" name="checkboxMyTeamTaskShow"> 
											<label class="form-check-label" for="checkboxMyTeamTaskShow">Show</label>
	                            	</td>
	                            </tr>
	                            <tr style="border-top: hidden;">
                            	<td style="padding: 0rem; vertical-align: middle; border-left: hidden;"  colspan="2">
                            	<!-- Task Table -->
	                            <table class="table table-bordered" id="tableMyTeamTasks">
							    <thead>
							      <tr>
							        <th style="text-align: center;">Tasks</th>
							        <th>Assignee</th>
							        <%
							        
							        	now = Calendar.getInstance();
								        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
								        now.add(Calendar.DAY_OF_MONTH, delta );
							        
								        for (int i = 0; i < 5; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=dd_MMMFormate.format(now.getTime()) + " , " + daysList[i] %></th><% 
								        	now.add(Calendar.DAY_OF_MONTH, 1);
								        }
							        	
							        %>
							       
							        <th style="text-align: -webkit-center;">Total hours</th>
							      </tr>
							    </thead>
							    <tbody>
							    	
							    <% 
								  	key = 0;
							        name = "";
							        assignee = "";
							        profileColor = "purple";
						        
								        rsTask = stTask.executeQuery("SELECT * FROM tasks where project = "+ projectId +"  AND team_member != "+ userid +"");
								        
									    while(rsTask.next()) {
									    	key = rsTask.getInt("id");
									        name = rsTask.getString("name");
									        
									        	rsNested = stNested.executeQuery("SELECT * FROM users where id = "+ rsTask.getInt("team_member") +"");
									        	if(rsNested.next()) assignee = rsNested.getString("name");
								        
								        %>
								        	<tr>
										        <td style="text-align: inherit;">
										        	<%=name %> 
										        </td>
										        <td>
													<div id="profileImage" style="background: <%=profileColor %>" title=<%=assignee %>>
														<%=assignee.toUpperCase().substring(0, 2) %>
													</div>
										        </td>
										        <%
										        
											    	now = Calendar.getInstance();
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
											        taskColumnTotal = 0; taskRowTotal = 0;
										        
											        for (int i = 0; i < 5; i++)
											        {
											        	%>
											        		<td>
											        			<% // Getting hours from task_details
											        				Integer taskId = key;
											        				String taskDate = yyyyMMddFormate.format(now.getTime());
											        				Integer taskHours = 0;
											        				String taskDescription = "";
											        				
											        				rsHours = stHours.executeQuery("SELECT * FROM task_details where task = "+ taskId +" AND task_detail_date = '"+ taskDate +"' order by id DESC");
								        							if(rsHours.next()) {
								        								taskHours = rsHours.getInt("hours");
								        								taskDescription = rsHours.getString("description");
								        							}
								        							taskRowTotal += taskHours;
								        							
								        							switch (i){
								        								case 0: myTeamTaskColumnTotalMon += taskHours; taskColumnTotal += myTeamTaskColumnTotalMon; break;
								        								case 1: myTeamTaskColumnTotalTue += taskHours; taskColumnTotal += myTeamTaskColumnTotalTue; break;
								        								case 2: myTeamTaskColumnTotalWed += taskHours; taskColumnTotal += myTeamTaskColumnTotalWed; break;
								        								case 3: myTeamTaskColumnTotalThu += taskHours; taskColumnTotal += myTeamTaskColumnTotalThu; break;
								        								case 4: myTeamTaskColumnTotalFri += taskHours; taskColumnTotal += myTeamTaskColumnTotalFri; break;
								        							}
											        			%>
											        			<input class="form-control form-control-sm hours-text" type="text" readonly="readonly"
											        			onclick="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" data-toggle="modal" 
											        			data-target="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" 
											        			value="<%=taskHours %>:00">
													        </td>
											        		
											        		<!-- Model update task -->
									                        	<div class="modal fade" id="taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
																    <div class="modal-dialog modal-sm" role="document">
																    	<form action="<%=request.getContextPath()%>/TaskDetailServlet" method="post">
																    	<fieldset disabled="disabled">
																        <div class="modal-content">
																            <div class="modal-header">
																                <h5 class="modal-title"><%=name %> - <%=ddMMyyyyFormate.format(now.getTime()) %></h5>
																                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
																            </div>
																            <div class="modal-body">
																                	<div class="row">
																                		<div class="col" style="display: none;">
																						    <div class="form-group" style="text-align: start;">
																							    <label for="projectNameInput">Date <span style="color: red;">*</span></label>
																							    <input type="text" id="hiddenProjectId" name="hiddenProjectId"
																							    value=<%=rs.getInt("id") %> class="form-control">
																							    <input type="text" id="hiddenTaskId" name="hiddenTaskId"
																							    value=<%=rsTask.getInt("id") %> class="form-control">
																							    <input type="date" id="taskDetailDate" name="taskDetailDate" max="31-12-3000" min="01-01-1000" 
																							    value="<%=yyyyMMddFormate.format(now.getTime()) %>" class="form-control">
																						    </div>
																					    </div>
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Hours <span style="color: red;">*</span></label>
																						        <input class="form-control" type="number" min="0" max="12" value=<%=taskHours %> id="taskDetailHours" name="taskDetailHours">
																						    </div>
																					    </div>
																				    </div>
																				    <div class="row">
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Description<span style="color: red;">*</span></label>
																						        <textarea class="form-control" id="taskDetailDescription" name="taskDetailDescription" rows="4"><%=taskDescription %></textarea>
																						    </div>
																					    </div>
																				    </div>
																            </div>
																            <div class="modal-footer">
																            <div style="margin-right: auto;margin-left: 0.5rem;">
																            	<input class="" id="customCheck1" type="checkbox">
																				<label class="" for="customCheck1">Complete</label>
																            </div>
																            	<button type="submit" title="Search"
																					class="btn btn-sm btn-light active mr-3 center_div card-button"
																					style="background-color:<%=bckColor %>; "
																					onclick="this.form.submit();">
																					<i class="fas fa-save"></i>&nbsp; Save</button>	
																            </div>
																        </div>
																        </form>
																        </fieldset>
																    </div>
																</div>
									                        	<!-- End Model update task -->
											        	
											        	<% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        }
										        
										        %>
										        <td>
										        	<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=taskRowTotal %>:00">
										        </td>
										      </tr>
								        
								        
								        <%
								    }
							     %>	
							    
							      
							    </tbody>
							    <tfoot>
							    	<tr>
							    		<th colspan="2"  style="text-align: inherit;">
							    			Total hours:
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTeamTaskColumnTotalMon %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTeamTaskColumnTotalTue %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTeamTaskColumnTotalWed %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTeamTaskColumnTotalThu %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=myTeamTaskColumnTotalFri %>:00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="<%=taskColumnTotal %>:00">
							    		</th>
							    	</tr>
							    </tfoot>
							  </table>
	                           <!-- End of Task Table -->
	                           </td>
	                           </tr>
                            </table>
                            <!-- End of My Team Task Table -->
                        </div>
                    </div>
                   
                </main>
                 <% 
				    }
                 %>
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

<!-- Alert Status -->
<%@include  file="../alert.html" %>
<!-- Alert Status -->
</body>
<% 
} catch (Exception e) {
	e.printStackTrace();
} %>
</html>


<script type="text/javascript">
    $(document).ready(function() {
        $('#teamMemberSelect').multiselect();
        
        // hidden
        document.getElementById("tableMyTeamTasks").style.display = "none";
    });
    
	$("#checkboxMyTeamTaskShow").change(function() {
		
		var isMyTeamTaskShow = $('#checkboxMyTeamTaskShow')[0].checked;
		var tableMyTeamTasks = document.getElementById("tableMyTeamTasks");
		
		if(isMyTeamTaskShow) {
			tableMyTeamTasks.style.display = "";
		} else {
			tableMyTeamTasks.style.display = "none";
		}
	})
    
</script>