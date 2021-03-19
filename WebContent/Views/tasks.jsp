<%@page import="javafx.util.Pair"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.text.SimpleDateFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Tasks</title>

<%@include  file="../header.html" %>
<%
String bckColor = "#0066cb";
	//String bckColor = "#b81b44";
	
	String showSkyzerPaymentImg = "display: none";
	String showSkyzerTechImg = "display: block";
	
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
                                            Tasks
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
							        <div class="modal-content">
							            <div class="modal-header">
							                <h5 class="modal-title">Create a new task</h5>
							                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
							            </div>
							            <div class="modal-body">
							                <form>
							                	<div class="row">
							                		<div class="col">
													    <div class="form-group">
														    <label for="projectNameInput">Task name <span style="color: red;">*</span></label>
														    <input style="height: fit-content;" class="form-control" id="projectNameInput" type="text" placeholder="Ex. IKR Project">
													    </div>
												    </div>
												    <div class="col">
													    <div class="form-group">
													        <label for="departmentSelect">Project <span style="color: red;">*</span></label>
													        <input style="height: fit-content;" class="form-control" id="projectNameInput" type="text" value="IKR Project" readonly="readonly">
													    </div>
												    </div>
											    </div>
											    <div class="form-group">
											        <label for="teamMemberSelect">Team members <span style="color: red;">*</span></label><br/>
											        <select class="form-control" id="exampleSelect1">
														<option>Select member...</option>
														<option>Christine Hogan</option>
											            <option>Alan Green</option>
											            <option>Jay Solanki</option>
											            <option>Kishan Rabari</option>
											            <option>Sukhwinder Kaur</option>												    </select>
											    </div>
											    <div class="form-group">
												    <label for="descriptionTextarea">Description</label>
												    <textarea class="form-control" id="descriptionTextarea" rows="4"></textarea>
											    </div>
											</form>
							            </div>
							            <div class="modal-footer">
							            	<button type="submit" title="Search"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="this.form.submit();">
											<i class="fas fa-save"></i>&nbsp; Save</button>	
							            </div>
							        </div>
							    </div>
							</div>
                        	<!-- End Model create a new task -->
                            
                            <!--  Custom edit -->
                            <div id="divCustom" class="card-body" style="width:66%; padding: 0px;">
                            <div class="card mb-3">
				
									<div class="card-body" style="padding: 10px;">
										<form class="form-inline" action="#" method="post">
											<label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Task:</label> 
											<select class="form-control col-sm-2" id="user" name="user">
												<option value="0" selected>Task 1</option>
												<option value="1" >Task 2</option>
											</select>
											
											<label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Date:</label> 
											<input type="date" id="followUpDate" name="followUpDate" max="31-12-3000" min="01-01-1000" class="form-control col-sm-2 center_div">
											
											<label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Hours:</label> 
											<input class="form-control col-sm-2 center_div" type="number" min="0" max="24" value="0" id="example-number-input">
											
											<input type="checkbox" class="form-check-input" id="exampleCheck1" style="margin-left: 0.5rem;margin-right: 0.5rem;"> 
											<label class="form-check-label" for="exampleCheck1">Complete</label>
											
											<button type="submit" title="Search"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="this.form.submit();">
											<i class="fas fa-save"></i>&nbsp; Save</button>	
										</form>
                            		</div>
                            </div>
                            </div>
                            <!--  End of custom edit -->
                            
                            <!-- My Task Table -->
                            <table class="table" style="border: hidden; margin-top: -1rem;">
                            	<tr>
	                            	<td class="td-center"  colspan="2">
		                            		<span class="span-large" style="color: <%=bckColor %>;">@ PROJECT IKR</span>
	                            	</td>
	                            </tr>
                            	<tr style="border-top: hidden;">
	                            	<td style="border-right: hidden;">
	                            		<h2>My Tasks</h2>
	                            	</td>
	                            	<td style="text-align: end;">
		                            		<input type="checkbox" class="form-check-input" id="checkboxCustom" name="checkboxCustom"> 
											<label class="form-check-label" for="checkboxCustom">Custom</label>
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
						        String firstName =  "";
						        String lastName = "";
						        String profileColor = "green";
						        
								    for (Map.Entry<Integer, String> entry : taskList.entrySet()) {
								    	key = entry.getKey();
								        name = entry.getValue();
								        firstName = "Jay";
								        lastName = "Solanki";
								        %>
								        	<tr>
										        <td style="text-align: inherit;">
										        	<%=name %> 
										        </td>
										        <td>
										        	<!-- will come from db -->
													<div id="profileImage" style="background: <%=profileColor %>" title="">
														<%=firstName.toUpperCase().charAt(0) + "" + lastName.toUpperCase().charAt(0) %>
													</div>
										        </td>
										        <%
										        
											     	// 5 days
											    	now = Calendar.getInstance();
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
										        
											        for (int i = 0; i < 5; i++)
											        {
											        	%>
											        		<td>
											        			<input class="form-control form-control-sm hours-text" type="text" readonly="readonly" value="00.00"
											        			onclick="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" data-toggle="modal" data-target="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>">
													        	
													        	<!-- Model update task -->
									                        	<div class="modal fade" id="taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
																    <div class="modal-dialog modal-lg" role="document">
																        <div class="modal-content">
																            <div class="modal-header">
																                <h5 class="modal-title"><%=name %></h5>
																                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
																            </div>
																            <div class="modal-body">
																                <form>
																                	<div class="row">
																                		<div class="col">
																						    <div class="form-group" style="text-align: start;">
																							    <label for="projectNameInput">Date <span style="color: red;">*</span></label>
																							    <input type="date" id="startDate" name="startDate" max="31-12-3000" min="01-01-1000" value="<%=yyyyMMddFormate.format(now.getTime()) %>" class="form-control">
																						    </div>
																					    </div>
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Hours <span style="color: red;">*</span></label>
																						        <input class="form-control" type="number" min="0" max="24" value="0" id="example-number-input">
																						    </div>
																					    </div>
																				    </div>
																				</form>
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
																    </div>
																</div>
									                        	<!-- End Model update task -->
													        </td>
											        	
											        	
											        	<% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        }
										        
										        %>
										        <td>
										        	<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
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
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
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
						        firstName =  "";
						        lastName = "";
						        profileColor = "green";
						        
								    for (Map.Entry<Integer, String> entry : taskList.entrySet()) {
								    	key = entry.getKey();
								        name = entry.getValue();
								        firstName = "Jay";
								        lastName = "Solanki";
								        %>
								        	<tr>
										        <td style="text-align: inherit;">
										        	<%=name %> 
										        </td>
										        <td>
										        	<!-- will come from db -->
													<div id="profileImage" style="background: <%=profileColor %>" title="">
														<%=firstName.toUpperCase().charAt(0) + "" + lastName.toUpperCase().charAt(0) %>
													</div>
										        </td>
										        <%
										        
											    	now = Calendar.getInstance();
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
										        
											        for (int i = 0; i < 5; i++)
											        {
											        	%>
											        		<td>
											        			<input class="form-control form-control-sm hours-text" type="text" readonly="readonly" value="00.00"
											        			onclick="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" data-toggle="modal" data-target="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>">
													        	
													        	<!-- Model update task -->
									                        	<div class="modal fade" id="taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
																    <div class="modal-dialog modal-lg" role="document">
																        <div class="modal-content">
																            <div class="modal-header">
																                <h5 class="modal-title"><%=name %></h5>
																                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
																            </div>
																            <div class="modal-body">
																                <form>
																                	<div class="row">
																                		<div class="col">
																						    <div class="form-group" style="text-align: start;">
																							    <label for="projectNameInput">Date <span style="color: red;">*</span></label>
																							    <input type="date" id="startDate" name="startDate" max="31-12-3000" min="01-01-1000" value="<%=yyyyMMddFormate.format(now.getTime()) %>" class="form-control">
																						    </div>
																					    </div>
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Hours <span style="color: red;">*</span></label>
																						        <input class="form-control" type="number" min="0" max="24" value="0" id="example-number-input">
																						    </div>
																					    </div>
																				    </div>
																				</form>
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
																    </div>
																</div>
									                        	<!-- End Model update task -->
													        </td>
											        	
											        	
											        	<% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        }
										        
										        %>
										        <td>
										        	<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
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
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
							    		</th>
							    		<th>
							    			<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
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
</html>


<script type="text/javascript">
    $(document).ready(function() {
        $('#teamMemberSelect').multiselect();
        
        // hidden
        document.getElementById("divCustom").style.display = "none";
        document.getElementById("tableMyTeamTasks").style.display = "none";
    });
    
	$("#checkboxCustom").change(function() {
		
		var isCustom = $('#checkboxCustom')[0].checked;
		var divCustom = document.getElementById("divCustom");
		
		if(isCustom) {
			divCustom.style.display = "block";
		} else {
			divCustom.style.display = "none";
		}
	})
	
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