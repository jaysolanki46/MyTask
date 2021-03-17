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
                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold;">
                                            <div class="page-header-icon">
                                          		<i class="far fa-calendar-plus"></i> 
                                            </div>
                                            Tasks - @Project IKR
                                        </h1>
                                    </div>
                                    <div class="col-12 col-xl-auto mb-3">
                                        <button style="background-color:<%=bckColor %>;" 
                                        data-toggle="modal" data-target="#projectModelLg"
                                        class="btn btn-sm btn-light active mr-2"><i class="fas fa-plus"></i>&nbsp;Create New Task</button>
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
											        <select style="height: fit-content;" class="form-control" id="teamMemberSelect" multiple="multiple">
											            <option>Christine Hogan</option>
											            <option>Alan Green</option>
											            <option>Jay Solanki</option>
											            <option>Kishan Rabari</option>
											            <option>Sukhwinder Kaur</option>
											        </select>
											    </div>
											    <div class="form-group">
												    <label for="descriptionTextarea">Description</label>
												    <textarea class="form-control" id="descriptionTextarea" rows="4"></textarea>
											    </div>
											</form>
							            </div>
							            <div class="modal-footer">
							            	<button class="btn btn-sm btn-light active mr-2" style="background-color:<%=bckColor %>; " type="button" data-dismiss="modal">
							            		Save
							            	</button>
							            </div>
							        </div>
							    </div>
							</div>
                        	<!-- End Model create a new task -->
                            
                            <!-- Task Table -->
                            <table class="table table-bordered">
						    <thead>
						      <tr>
						        <th style="text-align: inherit;">Tasks</th>
						        <th>Assignee</th>
						        <%
							     // 5 days
							    	Calendar headerNow = Calendar.getInstance();
							    	SimpleDateFormat tableHeaderFormat = new SimpleDateFormat("dd MMM");
							        
							        int headerDelta = -headerNow.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
							        headerNow.add(Calendar.DAY_OF_MONTH, headerDelta );
						        	String daysList[] = {"Mon", "Tue", "Wed",
						                "Thurs", "Fri"};
						        
							        for (int i = 0; i < 5; i++)
							        {
							        	%><th style="text-align: -webkit-center;"><%=tableHeaderFormat.format(headerNow.getTime()) + "," + daysList[i] %></th><% 
							        	headerNow.add(Calendar.DAY_OF_MONTH, 1);
							        }
						        	
						        %>
						       
						        <th style="text-align: -webkit-center;">Total hours</th>
						      </tr>
						    </thead>
						    <tbody>
						    	
						    <% 
						    Integer key = 0;
					        String name = "";
					        
							    for (Map.Entry<Integer, String> entry : taskList.entrySet()) {
							    	key = entry.getKey();
							        name = entry.getValue();
							        %>
							        	<tr>
									        <td style="text-align: inherit;">
									        	<i class="far fa-edit"></i>
									        	<%=name %> 
									        </td>
									        <td><%=name %></td>
									        <%
									        
										     	// 5 days
										    	Calendar now = Calendar.getInstance();
										    	SimpleDateFormat tableFormat = new SimpleDateFormat("dd MMM");
										    	SimpleDateFormat dbFrmat = new SimpleDateFormat("dd/MM/yyyy");
										    	SimpleDateFormat modelFormat = new SimpleDateFormat("ddMMM");
										        
										        int delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
										        now.add(Calendar.DAY_OF_MONTH, delta );
									        	
									        
										        for (int i = 0; i < 5; i++)
										        {
										        	%>
										        		<td>
												        	<input class="form-control form-control-sm" type="text" onclick="#taskModel<%=key + modelFormat.format(now.getTime()) %>" data-toggle="modal" data-target="#taskModel<%=key + modelFormat.format(now.getTime()) %>">
												        	<!-- Model update task -->
								                        	<div class="modal fade" id="taskModel<%=key + modelFormat.format(now.getTime()) %>" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
															    <div class="modal-dialog modal-lg" role="document">
															        <div class="modal-content">
															            <div class="modal-header">
															                <h5 class="modal-title">Update Task - <%=name + "-" + tableFormat.format(now.getTime()) %></h5>
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
																			</form>
															            </div>
															            <div class="modal-footer">
															            	<button class="btn btn-sm btn-light active mr-2" style="background-color:<%=bckColor %>; " type="button" data-dismiss="modal">
															            		Save
															            	</button>
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
									        	<input class="form-control form-control-sm" type="text">
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
						    			<input class="form-control form-control-sm" type="text">
						    		</th>
						    		<th>
						    			<input class="form-control form-control-sm" type="text">
						    		</th>
						    		<th>
						    			<input class="form-control form-control-sm" type="text">
						    		</th>
						    		<th>
						    			<input class="form-control form-control-sm" type="text">
						    		</th>
						    		<th>
						    			<input class="form-control form-control-sm" type="text">
						    		</th>
						    		<th>
						    			<input class="form-control form-control-sm" type="text">
						    		</th>
						    	</tr>
						    </tfoot>
						  </table>
                           <!-- End of Task Table -->
                           
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
    });
</script>