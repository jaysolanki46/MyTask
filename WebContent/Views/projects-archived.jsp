<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@page import="java.util.Base64"%>
<%@page import="config.EnumMyTask.SKYZERTASKPROGESS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
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
<title>Skyzer - My Task | Projects (Archived)</title>

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
	
	String openProject = request.getParameter("openProject");
	String deleteProject = request.getParameter("deleteProject");
	Statement stProjectStatus = null;
	stProjectStatus = dbConn.createStatement();
	
	if(openProject != null){
		stProjectStatus.executeUpdate("UPDATE projects set status = '"+ SKYZERPROJECTSTATUS.OPENED.getValue() +"', " +
												"updated_on = '"+ LocalDate.now().toString() +"', " +
												"updated_by = '"+ session.getAttribute("userId").toString() +"' " +
												"where id = '"+ new String(Base64.getDecoder().decode(request.getParameter("openProject"))) +"'");
		session.setAttribute("status", "update");
		
	} else if (deleteProject != null) {
		stProjectStatus.executeUpdate("UPDATE projects set status = '"+ SKYZERPROJECTSTATUS.DELETED.getValue() +"', " +
												"updated_on = '"+ LocalDate.now().toString() +"', " +
												"updated_by = '"+ session.getAttribute("userId").toString() +"' " +
												"where id = '"+ new String(Base64.getDecoder().decode(request.getParameter("deleteProject"))) +"'");
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
                                            Projects (Archived)
                                        </h1>
                                    </div>
                                    <div class="col-12 col-xl-auto mb-3">
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
									                <iframe id="tutorialiframe" height="100%" width="100%" src="https://www.youtube.com/embed/VLQECcLKUsE"></iframe>
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
						<div class="row" style="margin-bottom: 1rem;">
							<a href="/MyTask/Views/projects.jsp" style="text-decoration: none;">
							<div class="fw-500" style="color: <%=bckColor%>; cursor: pointer;"><i class="fas fa-chevron-left"></i>&nbsp;Opened</div>
							</a>
						</div>
                        <div class="row">
                            
                            <!-- Project card -->
                            <%
                            rs = st.executeQuery("SELECT projects.* FROM projects "
													+ "LEFT JOIN project_team ON project_team.project = projects.id "
													+ "where (projects.status = "+ SKYZERPROJECTSTATUS.ARCHIVED.getValue() +") AND (projects.department = "+ userdepartment +" OR projects.department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +") " 
													+ "AND (project_team.team_member = "+ userid +") "
													+ "order by projects.id DESC");	
                            
                                                   while(rs.next()) {
						                            %>
													    		<div class="col-lg-3 mb-3">
								                                <div class="card lift lift-sm h-100" style="background-color:<%=bckColor%>;">
								                                    <div class="card-body py-5" style="display: flex;">
								                                        <a href="../Views/tasks.jsp?project=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" style="text-decoration: none;">
								                                        <h5 class="card-title mb-2" style="color:white;">
								                                           <%=rs.getString("name")%>
								                                        </h5>
								                                        </a>
																		<h5 style="margin-left: auto;"><span class="badge" style="background-color:white; color: <%=bckColor%>;">
																			<%
																			rsNested = stNested.executeQuery("SELECT * FROM departments where id = " + rs.getString("department"));
																															while(rsNested.next()) {
																			%><%=rsNested.getString("name")%><%
																			}
																			%>
																		</span>
																		</h5>   
																		<div class="dropdown dropleft" style="margin-left: 0.7rem; color: white; cursor: pointer;">
																			<i class="fas fa-ellipsis-v" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
																			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
																			
																				<a class="dropdown-item" 
																				href="projects-archived.jsp?openProject=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" 
																				onclick="return confirm('Are you sure, you want to open this project?')"
																				style="color: green; font-weight: bold;">
						                                                    		<div class="dropdown-item-icon">
						                                                    		<i class="fas fa-file-archive"></i></div>
								                                                    Open
								                                                </a>
								                                                <div class="dropdown-divider"></div>
								                                                <a class="dropdown-item" 
								                                                href="projects-archived.jsp?deleteProject=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" 
								                                                <%
								                                                		if(rs.getInt("created_by") != Integer.parseInt(userid)) {
								                                                			%>onclick="alert('You are not authorized user to delete this project');return false;"<%		                                                			
								                                                		} else {
								                                                			%>onclick="return confirm('Are you sure, you want to delete this project?')"<%
								                                                		}
								                                                %>
								                                                style="color: red; font-weight: bold;">
						                                                    		<div class="dropdown-item-icon">
						                                                    		<i class="fas fa-trash"></i></div>
								                                                    Delete
								                                                </a>
																			</div>
																		</div>  
																		
								                                    </div>
								                                    <a href="../Views/tasks.jsp?project=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>" 
								                                    						style="text-decoration: none;">
								                                    <div class="card-footer">
																		<div class="small mb-2" style="color:white;">
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
																						<div style="background-color:#00ac69; width: <%=avgOfCompletedTasks %>%" title="<%=rsNested.getInt(1) %> task(s) completed" class="progress-bar rounded-pill"
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
