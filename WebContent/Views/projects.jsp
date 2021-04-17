<%@page import="java.util.Base64"%>
<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Projects</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "";
	
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
                    <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
                        <div class="container-fluid">
                            <div class="page-header-content">
                                <div class="row align-items-center justify-content-between pt-3">
                                    <div class="col-auto mb-3">
                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold; font-size: x-large;">
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
											style="background-color:<%=bckColor %>; "><i class="fas fa-plus"></i>&nbsp;Create New Project</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container">
                        <div class="row">
                        
                        	<div class="modal fade" id="projectModelLg" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
							    <div class="modal-dialog modal-lg" role="document">
							        <div class="modal-content">
							            <div class="modal-header">
							                <h5 class="modal-title">Create a new project</h5>
							                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
							            </div>
							            <form action="<%=request.getContextPath()%>/ProjectServlet" method="post">
							            <div class="modal-body">
							                	<div class="row">
							                		<div class="col">
													    <div class="form-group">
														    <label for="projectNameInput">Project name <span style="color: red;">*</span></label>
														    <input style="height: fit-content;" class="form-control" id="projectName" name="projectName" type="text" placeholder="Ex. IKR Project">
													    </div>
												    </div>
												    <div class="col">
													    <div class="form-group">
													        <label for="departmentSelect">Department <span style="color: red;">*</span></label>
													        <select style="height: fit-content;" class="form-control" id="projectDepartment" name="projectDepartment">
													        <%
													        	rs = st.executeQuery("SELECT * FROM departments");
													        
														        while(rs.next())
															    {   
																	%>
															    		<option value="<%=rs.getString("id") %>">
															    		<%=rs.getString("name") %></option>
															    	<%
															    }  
													        %>
													        </select>
													    </div>
												    </div>
											    </div>
											    <div class="form-group">
											        <label for="teamMemberSelect">Team members <span style="color: red;">*</span></label><br/>
											        <select style="height: fit-content;" class="form-control" id="projectTeam" name="projectTeam" multiple="multiple">
											           <%
													        	rs = st.executeQuery("SELECT * FROM users");
													        
														        while(rs.next())
															    {   
																	%>
															    		<option value="<%=rs.getString("id") %>">
															    		<%=rs.getString("name") %></option>
															    	<%
															    }  
													       %>
											        </select>
											    </div>
											    <div class="form-group">
												    <label for="descriptionTextarea">Description</label>
												    <textarea class="form-control" id="projectDescription" name="projectDescription" rows="4"></textarea>
											    </div>
							            </div>
							            <div class="modal-footer">
							            	<button type="submit" title="Save"
											class="btn btn-sm btn-light active mr-3 center_div card-button"
											style="background-color:<%=bckColor %>; "
											onclick="this.form.submit();">
											<i class="fas fa-save"></i>&nbsp; Save</button>	
							            </div>
							            </form>
							        </div>
							    </div>
							</div>
                        	
                            
                            <!-- Project card -->
                            <% 
                            	rs = st.executeQuery("SELECT * FROM mytask.projects order by id DESC");
	                            while(rs.next())
							    {   
									%>
							    		<div class="col-lg-3 mb-3">
		                                <a class="card lift lift-sm h-100" href="../Views/tasks.jsp?project=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes()) %>">
		                                    <div class="card-body py-5" style="display: flex;">
		                                        <h5 class="card-title mb-2" style="color:<%=bckColor %>;">
		                                           <%=rs.getString("name") %>
		                                        </h5>
												<h5 style="margin-left: auto;"><span class="badge" style="background-color:<%=bckColor %>; color: white;">
													<%
														rsNested = stNested.executeQuery("SELECT * FROM departments where id = " + rs.getString("department"));
														while(rsNested.next()) {
															%><%=rsNested.getString("name") %><%
														}
													%>
												</span>
												</h5>                                        
		                                    </div>
		                                    <div class="card-footer">
												<div class="small text-muted mb-2">
													<%
														rsNested = stNested.executeQuery("SELECT count(*) FROM tasks where project = " + rs.getString("id"));
														Integer totalTask = 0;
														while(rsNested.next()) {
															
															totalTask = rsNested.getInt(1); 
															
															%><%=totalTask %> tasks in this project<%
														}
													%>
												</div>
												<div class="progress rounded-pill"
													style="height: 0.5rem">
													<%
														rsNested = stNested.executeQuery("select count(is_completed)  from mytask.tasks where project = "+ rs.getString("id") +" and is_completed = " + SKYZERTASKSTATUS.COMPLETED.getValue());
														Integer completedTasks = 0;
														double avgOfCompletedTasks = 0;
														
														while(rsNested.next()) {
															
															completedTasks = rsNested.getInt(1);
															avgOfCompletedTasks = ((double)completedTasks/(double)totalTask) * 100;
															System.out.println(avgOfCompletedTasks) ;
															%>
																<div style="background-color:<%=bckColor %>; width: <%=avgOfCompletedTasks %>%" class="progress-bar rounded-pill"
																	role="progressbar" aria-valuenow="75" aria-valuemin="0" 
																		aria-valuemax="100"></div>															
															<%															
														}
													%>
												</div>
											</div>
											</a>
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


<script type="text/javascript">
    $(document).ready(function() {
        $('#projectTeam').multiselect();
    });
</script>