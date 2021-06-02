<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@page import="java.util.Base64"%>
<%@page import="config.EnumMyTask.SKYZERTASKPROGESS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="config.EnumMyTask.SKYZERUSERACTIVE"%>
<%@page import="config.EnumMyTask.SKYZERPROJECTSTATUS"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
try {
%>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Projects</title>

<%@include  file="../header.html" %>
<%
String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "", userdepartment = "";
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
	
	Connection dbConn = DBConfig.connection(); ;
	Statement st = null;
	ResultSet rs = null;
	st = dbConn.createStatement();
	
	Statement stNested = null;
	ResultSet rsNested = null;
	stNested = dbConn.createStatement();
	
	String archiveProject = request.getParameter("archiveProject");
	String deleteProject = request.getParameter("deleteProject");
	Statement stProjectStatus = null;
	stProjectStatus = dbConn.createStatement();
	
	if(archiveProject != null){
		stProjectStatus.executeUpdate("UPDATE projects set status = '"+ SKYZERPROJECTSTATUS.ARCHIVED.getValue() +"', " +
												"updated_on = '"+ LocalDate.now().toString() +"', " +
												"updated_by = '"+ session.getAttribute("userId").toString() +"' " +
												"where id = '"+ new String(Base64.getDecoder().decode(archiveProject)) +"'");
		session.setAttribute("status", "update");
		
	} else if (deleteProject != null) {
		stProjectStatus.executeUpdate("UPDATE projects set status = '"+ SKYZERPROJECTSTATUS.DELETED.getValue() +"', " +
												"updated_on = '"+ LocalDate.now().toString() +"', " +
												"updated_by = '"+ session.getAttribute("userId").toString() +"' " +
												"where id = '"+ new String(Base64.getDecoder().decode(deleteProject)) +"'");
		session.setAttribute("status", "update");
	}
%>
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
                    <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-2">
                        <div class="container-fluid">
                            <div class="page-header-content">
                                 <div class="row align-items-center justify-content-between" style="height: 4rem;">
                                    <div class="col-auto mb-3">
                                        <h1 class="page-header-title" style="color: <%=bckColor%>; font-weight: bold; font-size: x-large;">
                                            <div class="page-header-icon">
                                          		<i class="fas fa-project-diagram"></i>  
                                            </div>
                                            Projects
                                        </h1>
                                    </div>
                                    <div class="col-12 col-xl-auto mb-3">
                                        <button
                                        data-toggle="modal" data-target="#projectModelLg"
                                        class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor%>; "><i class="fas fa-plus"></i>&nbsp;Create New Project</button>
										<button
                                        class="btn btn-sm btn-light active mr-3 center_div card-button popup-modal" 
                                        	id="projectsTutorial"  title="Tutorial"  data-toggle="modal" data-target="#tutorialPopup"
											style="background-color:<%=bckColor%>; "><i class="fas fa-video"></i></button>
											
                                    </div>
                                    
                                    <div class="modal fade" id="tutorialPopup" tabindex="-1" role="dialog" aria-labelledby="tutorialPopupLbl" style="display: none;" aria-hidden="true">
									    <div class="modal-dialog modal-xl" role="document">
									        <div class="modal-content" style="height: 40rem;">
									            <div class="modal-header">
									                <h5 class="modal-title">Project Tutorial</h5>
									                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
									            </div>
									            <div class="modal-body">
									                <iframe id="tutorialiframe" height="100%" width="100%" src="https://www.youtube.com/embed/tgbNymZ7vqY"></iframe>
									            </div>
									        </div>
									    </div>
									</div>
									
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container">
						<div class="row" style="place-content:  flex-end; margin-bottom: 1rem;">
							<a href="/MyTask/Views/projects-archived.jsp" style="text-decoration: none;">
							<div class="fw-500" style="color: <%=bckColor%>; cursor: pointer;">Archived &nbsp;<i class="fas fa-chevron-right"></i></div>
							</a>
						</div>
                        <div class="row">
                        	
                        
                        	<div class="modal fade" id="projectModelLg" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
							    <div class="modal-dialog modal-lg" role="document">
							        <div class="modal-content">
							            <div class="modal-header">
							                <h5 class="modal-title">Create new project</h5>
							                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
							            </div>
							            <form id="projectForm" action="<%=request.getContextPath()%>/ProjectServlet" method="post">
							            <div class="modal-body">
							                	<div class="row">
							                		<div class="col">
													    <div class="form-group">
														    <label for="projectNameInput">Project name <span style="color: red;">*</span></label>
														    <input style="height: fit-content;" class="form-control" id="projectName" name="projectName" 
														    type="text" placeholder="Ex. IKR Project" required pattern=".*\S+.*" title="This field is required">
													    </div>
												    </div>
												    <div class="col">
													    <div class="form-group">
													        <label for="departmentSelect">Department</label>
													        <select style="height: fit-content;" class="form-control" id="projectDepartment" name="projectDepartment">
													        <%
													        rs = st.executeQuery("SELECT * FROM departments where id = "+ userdepartment +" OR id = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +"");
													        											        											        
													        											        												        while(rs.next())
													        											        													    {
													        %>
															    		<option value="<%=rs.getString("id")%>">
															    		<%=rs.getString("name")%></option>
															    	<%
															    	}
															    	%>
													        </select>
													    </div>
												    </div>
											    </div>
												<div class="row">
													<div class="col">
														<div class="form-group">
															<label for="teamMemberSelect">Team members <span
																style="color: red;">*</span></label><br /> <select
																style="height: fit-content;" class="form-control"
																id="projectTeam" name="projectTeam" multiple="multiple" required>
																<%
																rs = st.executeQuery("SELECT * FROM users where department = " + userdepartment + " and active = "
																																														+ SKYZERUSERACTIVE.TRUE.getValue() + "");

																																												while (rs.next()) {
																%>
																<option value="<%=rs.getString("id")%>">
																	<%=rs.getString("name")%></option>
																<%
																}
																%>
															</select>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col">
														<div class="form-group">
															<label for="descriptionTextarea">Description</label>
															<textarea class="form-control" id="projectDescription"
																name="projectDescription" rows="4"></textarea>
														</div>
													</div>
												</div>
											</div>
							            <div class="modal-footer">
							            	<button type="submit" title="Save" class="btn btn-sm btn-light active mr-3 center_div card-button"
												style="background-color:<%=bckColor%>;">
							            		<i class="fas fa-save"></i>&nbsp; Save
							            	</button>
							            </div>
							            </form>
							        </div>
							    </div>
							</div>
                            
                            <!-- Project card -->
                            <%
                            rs = st.executeQuery("SELECT * FROM projects where (status = "+ SKYZERPROJECTSTATUS.OPENED.getValue() +") AND (department = "+ userdepartment +" OR " +
                                                                                    						" department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +") order by id DESC");
                                                        	                            while(rs.next())
                                                        					    {
                            %>
							    		<div class="col-lg-3 mb-3">
		                                <div class="card lift lift-sm h-100">
		                                    <div class="card-body py-5" style="display: flex;">
		                                        <a href="../Views/tasks.jsp?project=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" style="text-decoration: none;">
		                                        <h5 class="card-title mb-2" style="color:<%=bckColor%>;">
		                                           <%=rs.getString("name")%>
		                                        </h5>
		                                        </a>
												<h5 style="margin-left: auto;"><span class="badge" style="background-color:<%=bckColor%>; color: white;">
													<%
													rsNested = stNested.executeQuery("SELECT * FROM departments where id = " + rs.getString("department"));
																									while(rsNested.next()) {
													%><%=rsNested.getString("name")%><%
													}
													%>
												</span>
												</h5>   
												<div class="dropdown dropleft" style="margin-left: 0.7rem; color: <%=bckColor%>; cursor: pointer;">
													<i class="fas fa-ellipsis-v" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
													<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
													
														<a class="dropdown-item" 
															href="projects.jsp?archiveProject=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" 
															onclick="return confirm('Are you sure, you want to archive this project?')"
															style="color: green; font-weight: bold;">
                                                    		<div class="dropdown-item-icon">
                                                    		<i class="fas fa-file-archive"></i></div>
		                                                    Archive
		                                                </a>
		                                                <div class="dropdown-divider"></div>
		                                                <a class="dropdown-item" 
		                                                	href="projects.jsp?deleteProject=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" 
		                                                	onclick="return confirm('Are you sure, you want to delete this project?')"
		                                                	style="color: red; font-weight: bold;">
                                                    		<div class="dropdown-item-icon">
                                                    		<i class="fas fa-trash"></i></div>
		                                                    Delete
		                                                </a>
													</div>
												</div>  
												
		                                    </div>
		                                    <a href="../Views/tasks.jsp?project=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" style="text-decoration: none;">
		                                    <div class="card-footer">
												<div class="small text-muted mb-2">
													<%
													rsNested = stNested.executeQuery("SELECT count(*) FROM tasks where status = "+ SKYZERTASKSTATUS.OPENED.getValue() +" AND project = " + rs.getString("id"));
																									Integer totalTask = 0;
																									while(rsNested.next()) {
																										
																										totalTask = rsNested.getInt(1);
													%><%=totalTask%> tasks in this project<%
													}
													%>
												</div>
												<div class="progress rounded-pill"
													style="height: 0.5rem">
													<%
													rsNested = stNested.executeQuery("select count(id) from tasks where status = "+ SKYZERTASKSTATUS.OPENED.getValue() +" AND project = "+ rs.getString("id") +"" 
																																			+" and percentage = " + SKYZERTASKPROGESS.COMPLETED.getValue());
																									Integer completedTasks = 0;
																									double avgOfCompletedTasks = 0;
																									
																									while(rsNested.next()) {
																										
																										completedTasks = rsNested.getInt(1);
																										avgOfCompletedTasks = ((double)completedTasks/(double)totalTask) * 100;
																										System.out.println(avgOfCompletedTasks) ;
													%>
																<div style="background-color:<%=bckColor %>; width: <%=avgOfCompletedTasks %>%" title="<%=rsNested.getInt(1) %> task(s) completed" class="progress-bar rounded-pill"
																	role="progressbar" aria-valuenow="75" aria-valuemin="0" 
																		aria-valuemax="100"></div>															
															<%															
														}
													%>
												</div>
											</div>
											</a>
											</div>
		                            </div>
							    	<%
							    } 
                            %>
                           <!-- End of project card -->
                           
                           <!-- New project card -->
                             <div class="col-lg-3 mb-3" data-toggle="tooltip" title="Create New Project">
                                <!-- Knowledge base category card 1-->
                                <a  class="card lift lift-sm h-100" data-toggle="modal" data-target="#projectModelLg">
                                	<!-- add new for tech -->
                                    <img style="<%=showSkyzerTechImg %>; height: 8rem; padding: 2rem;" class="card-img-top" src="../img/icons/add-new-skyzer-tech.svg" alt="...">
                               		<!-- add new for payment -->
                               		<img style="<%=showSkyzerPaymentImg %>; height: 8rem; padding: 2rem;" class="card-img-top" src="../img/icons/add-new-skyzer-payment.svg" alt="...">
                                </a>
                            </div>
                           <!-- End of new project card -->
                         
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

<!-- Alert Status -->
<%@include  file="../alert.html" %>
<!-- Alert Status -->
</body>
<% 
} catch (Exception e) {
	e.printStackTrace();
} %>
</html>
