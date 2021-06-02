<%@ page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
<%@ page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@ page import="java.util.*"%>
<%@ page language="java" import="java.text.SimpleDateFormat"%>
<%@ page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@ page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@ page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@ page import="config.EnumMyTask.SKYZERUSERACTIVE"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.util.Arrays"%>
<%@ page language="java" import="config.DBConfig"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Dashboard</title>

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
	
	Connection dbConnNested = DBConfig.connection(); ;
	Statement stNested = null;
	ResultSet rsNested = null;
	stNested = dbConnNested.createStatement();
	
	// Pie Chart
	String pieProject = request.getParameter("pieProject");
	ArrayList<String> tasks = new ArrayList<String>();
	ArrayList<String> taskHours = new ArrayList<String>();
	rs = st.executeQuery("SELECT * FROM projects where department = "+ userdepartment +" OR department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +" order by id DESC LIMIT 1");
	if(rs.next()){
		
		if(pieProject == null) 
			pieProject = rs.getString(1);
		
		rsNested = stNested.executeQuery("select tasks.id, tasks.name, COALESCE(sum(task_details.hours), 0) as total_hours from tasks "+
											"LEFT JOIN task_details ON tasks.id = task_details.task " +
											"where tasks.project = "+ pieProject +" group by tasks.name ");

		while(rsNested.next()){
				tasks.add(rsNested.getString("tasks.name"));
				taskHours.add(rsNested.getString("total_hours"));
		}
	}
	
	// Bar Chart
	String barUser = request.getParameter("barUser");
	ArrayList<String> xList = new ArrayList<String>();
	ArrayList<String> yListProgress = new ArrayList<String>();
	ArrayList<String> yListHoursSpent = new ArrayList<String>();

	if(barUser == null)
		barUser = userid;
	
	rs = st.executeQuery("SELECT tasks.*, COALESCE(sum(task_details.hours), 0) as total_hours FROM tasks LEFT JOIN task_details ON tasks.id = task_details.task where tasks.team_member = "+ barUser +" group by tasks.name");
	
	while(rs.next()){
		xList.add(rs.getString("tasks.name"));
		yListProgress.add(rs.getString("tasks.percentage"));
		yListHoursSpent.add(rs.getString("total_hours"));
	}
	
	// Line Chart
	String lineProject = request.getParameter("lineProject");
	String project = "No Projects";
	String projectCreatedOn = "";
	ArrayList<String> monthlyProjectHoursList = new ArrayList<String>();
	
	rs = st.executeQuery("SELECT * FROM projects where department = "+ userdepartment +" OR department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +" order by id DESC LIMIT 1");
	if(rs.next()){
		
		if(lineProject == null) 
			lineProject = rs.getString(1);
		
			rsNested = stNested.executeQuery("select * from projects WHERE id = "+ lineProject +"");
			if(rsNested.next()) {	
				project = rsNested.getString("projects.name");
				projectCreatedOn = rsNested.getString("projects.created_on");
			}
		
			// Get monthly hours
			Calendar createdOnCalendar = Calendar.getInstance();
			Calendar nowCalendar = Calendar.getInstance(); // Get cuurent date
			SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
			createdOnCalendar.setTime(yyyyMMddFormate.parse(projectCreatedOn));
			
			while (createdOnCalendar.before(nowCalendar)) {
	            String date = yyyyMMddFormate.format(createdOnCalendar.getTime()).toUpperCase();
	            System.out.println(date);
	            
	            rsNested = stNested.executeQuery("select projects.id, projects.name, projects.created_on, task_details.id, task_details.task_detail_date, "
	    				+ "concat(month(task_details.task_detail_date), '-', year(task_details.task_detail_date)) as months, "
	    				+ "sum(task_details.hours) as hours  from projects "
	    				+ "LEFT JOIN tasks ON projects.id = tasks.project "
	    				+ "LEFT JOIN task_details ON tasks.id = task_details.task "
	    				+ "WHERE projects.id = "+ lineProject +" and month(task_details.task_detail_date) = month('"+ date +"') group by months order by task_details.task_detail_date");
	            
	            if(rsNested.next()) {	
					monthlyProjectHoursList.add(rsNested.getString("hours"));
	            } else {
	            	monthlyProjectHoursList.add("0");
	            }
	            createdOnCalendar.add(Calendar.MONTH, 1);
	        }
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
                    <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
                        <div class="container-fluid">
                            <div class="page-header-content">
                                <div class="row align-items-center justify-content-between" style="height: 4rem;">
                                    <div class="col-auto mb-3">
                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold; font-size: x-large;">
                                            <div class="page-header-icon">
                                          		<i class="fas fa-chart-pie"></i>
                                            </div>
                                            Dashboard
                                        </h1>
                                    </div>
                                    <div class="col-12 col-xl-auto mb-3">
										<button
                                        class="btn btn-sm btn-light active mr-3 center_div card-button popup-modal" 
                                        	id="dashboardTutorial"  title="Tutorial"  data-toggle="modal" data-target="#tutorialPopup"
											style="background-color:<%=bckColor %>; "><i class="fas fa-video"></i></button>
                                    </div>
                                    
                                   <div class="modal fade" id="tutorialPopup" tabindex="-1" role="dialog" aria-labelledby="tutorialPopupLbl" style="display: none;" aria-hidden="true">
									    <div class="modal-dialog modal-xl" role="document">
									        <div class="modal-content" style="height: 40rem;">
									            <div class="modal-header">
									                <h5 class="modal-title">Dashboard Tutorial</h5>
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
                    <form action="<%=request.getContextPath()%>/Views/dashboard.jsp" method="post">
                        <div class="row">
                        	<!-- Begin Pie Chart -->
                        	<div class="col-xl-4 mb-4">
                                <div class="card card-header-actions h-70">
                                    <div class="card-header" style="color: <%=bckColor %>;">
                                        Hours Per Project
                                        <div class="dropdown no-caret" style="margin-left: auto; margin-right: 1rem;">
                                        	<select class="form-control" id="pieProject" name="pieProject" onchange="form.submit()">
												<%
													rs = st.executeQuery("SELECT id, name FROM projects where department = "+ userdepartment +" OR department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +" order by id DESC");
	
													while (rs.next()) {
														%>
														<option value="<%=rs.getString("id")%>"
															<%
															if (pieProject.equals(rs.getString("id"))) {%>
																selected
															<%}
															%>
														>
														<%=rs.getString("name")%></option>
													<%
													}
												%>
											</select>
                                        </div>
                                        <i class="fas fa-question-circle" title="Select project to see how much time each task took to complete"></i>
                                    </div>
                                    <div class="card-body">
	                                    <%
			                        		String pieTasks = tasks.toString().replace("[", "").replace("]", "").trim();
			                        		String pieTaskHours = taskHours.toString().replace("[", "").replace("]", "").trim();
			                        		if(pieTasks.isEmpty()) pieTasks = "No Tasks";
			                        	%>
			                        	<input type="hidden" id="pieTasks" value="<%=pieTasks %>">
                            			<input type="hidden" id="pieTaskHours" value="<%=pieTaskHours %>">
                                        <canvas id="projectHours" width="400" height="400"></canvas>
                                    </div>
                                </div>
                            </div>
                        	<!-- End Pie Chart -->
                        	
                        	<!-- Begin Bar Chart -->
                        	<div class="col-xl-8 mb-8">
                                <div class="card card-header-actions h-70">
                                    <div class="card-header" style="color: <%=bckColor %>;">
                                        Member Task Achievement
                                        <div class="dropdown no-caret" style="margin-left: auto; margin-right: 1rem;">
                                        	<select class="form-control" id="barUser" name="barUser" onchange="form.submit()">
												<%
													rs = st.executeQuery("SELECT * FROM users where department = "+ userdepartment +" and active = "+ SKYZERUSERACTIVE.TRUE.getValue() +"");
	
													while (rs.next()) {
														%>
														<option value="<%=rs.getString("id")%>"
																<%
																if (barUser.equals(rs.getString("id"))) {%>
																	selected
																<%}
															%>
														><%=rs.getString("name")%></option>
													<%
													}
												%>
											</select>
                                        </div>
                                        <i class="fas fa-question-circle" title="Select a user to see their task achievement"></i>
                                    </div>
                                    <div class="card-body">
			                        	<%
			                        		String barX = xList.toString().replace("[", "").replace("]", "").trim();
			                        		String barYListProgress = yListProgress.toString().replace("[", "").replace("]", "").trim();
			                        		String barYListHoursSpent = yListHoursSpent.toString().replace("[", "").replace("]", "").trim();
				                        	if(barX.equals("null")) barX = "No Tasks";
				                        	
			                        	%>
			                        	<input type="hidden" id="barX" value="<%=barX %>">
			                        	<input type="hidden" id="barYListProgress" value="<%=barYListProgress %>">
			                        	<input type="hidden" id="barYListHoursSpent" value="<%=barYListHoursSpent %>">
                                        <canvas id="teamMember" width="800" height="400"></canvas>
                                    </div>
                                </div>
                            </div>
                            <!-- End Bar Chart -->
                        </div>
                        
                        <div class="row">
                    	<!-- Begin Line Chart -->
                        	<div class="col-xl-12 mb-12">
                                <div class="card card-header-actions h-70">
                                    <div class="card-header" style="color: <%=bckColor %>;">
                                        Project Overview
                                        <div class="dropdown no-caret" style="margin-left: auto; margin-right: 1rem;">
                                        	<select class="form-control" id="lineProject" name="lineProject" onchange="form.submit()">
												<%
													rs = st.executeQuery("SELECT id, name FROM projects where department = "+ userdepartment +" OR department = "+ SKYZERDEPARTMENTS.GENERAL.getValue() +" order by id DESC");
	
													while (rs.next()) {
														%>
														<option value="<%=rs.getString("id")%>"
															<%
															if (lineProject.equals(rs.getString("id"))) {%>
																selected
															<%}
															%>
														>
														<%=rs.getString("name")%></option>
													<%
													}
												%>
											</select>
                                        </div>
                                        <i class="fas fa-question-circle" title="Select project to see, how much time the team has spent on this project since it started"></i>
                                    </div>
                                    <div class="card-body">
                                   		<%
			                        		String monthlyProjectHours = monthlyProjectHoursList.toString().replace("[", "").replace("]", "").trim();
				                        	
			                        	%>
	                                    <input type="hidden" id="project" value="<%=project %>">
	                                    <input type="hidden" id="projectCreatedOn" value="<%=projectCreatedOn %>">
	                                    <input type="hidden" id="monthlyProjectHours" value="<%=monthlyProjectHours %>">
                                        <canvas id="annualProjectOverview" width="800" height="200"></canvas>
                                    </div>
                                </div>
                            </div>
                            <!-- End Line Chart -->
                    	</div>
                    	</form>
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
<!-- Charts -->
<script src="../vendor/charts/pie-chart.js"></script>
<script src="../vendor/charts/bar-chart.js"></script>
<script src="../vendor/charts/line-chart.js"></script>

</body>
<% 
} catch (Exception e) {
	e.printStackTrace();
} %>

</html>


