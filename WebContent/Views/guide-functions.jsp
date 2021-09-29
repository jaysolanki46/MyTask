<%@page import="bean.ReferenceGuideFunctions"%>
<%@page import="config.EnumGuide"%>
<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@page import="java.util.Base64"%>
<%@page import="config.EnumGuide.USERSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="config.EnumMyTask.SKYZERUSERSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPROJECTSTATUS"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="config.GuideDBConfig"%>
<%@ page language="java" import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
try {
%>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - Guide App | Functions</title>

<%@include file="../header.html"%>
<%
String bckColor = "", showSkyzerPaymentImg = "", showSkyzerTechImg = "";
	String userid = "", username = "", useremail = "", usertheme = "", userpass = "", usertype = "", userdepartment = "";
%><%@include file="../session.jsp"%>
<%
if(usertheme.equals(SKYZERTECHNOLOGIES.ID.getValue())) {
		bckColor = SKYZERTECHNOLOGIES.COLOR.getValue();
		showSkyzerPaymentImg = SKYZERTECHNOLOGIES.LOGOSKYZERTECHNOLOGIES.getValue();
		showSkyzerTechImg = SKYZERTECHNOLOGIES.LOGOSKYZERPAYMENTS.getValue();
		
	} else if (usertheme.equals(SKYZERPAYMENTS.ID.getValue())) {
		bckColor = SKYZERPAYMENTS.COLOR.getValue();
		showSkyzerPaymentImg = SKYZERPAYMENTS.LOGOSKYZERTECHNOLOGIES.getValue();
		showSkyzerTechImg = SKYZERPAYMENTS.LOGOSKYZERPAYMENTS.getValue();
	}

	Connection dbConn = GuideDBConfig.connection(); ;
	Statement st = null;
	ResultSet rs = null;
	st = dbConn.createStatement();
	
	// ON EDIT
	String editFunctionId = request.getParameter("editFunctionId");
	ReferenceGuideFunctions referenceGuideFunctions = null;
	if(editFunctionId != null) {
		referenceGuideFunctions = new ReferenceGuideFunctions();
		Statement stEdit = null;
		ResultSet rsEdit = null;
		stEdit = dbConn.createStatement();
		
		rsEdit = stEdit.executeQuery("select * from reference_guide_functions where id = "+ new String(Base64.getDecoder().decode(editFunctionId)) +"");
		while(rsEdit.next()){
			referenceGuideFunctions.setId(rsEdit.getInt("id"));
			referenceGuideFunctions.setName(rsEdit.getString("name"));
			referenceGuideFunctions.setShort_solution(rsEdit.getString("short_solution"));
			referenceGuideFunctions.setIs_telium(rsEdit.getBoolean("is_telium"));
			referenceGuideFunctions.setIs_tetra(rsEdit.getBoolean("is_tetra"));
			referenceGuideFunctions.setIs_function(rsEdit.getBoolean("is_function"));
			referenceGuideFunctions.setIs_menu(rsEdit.getBoolean("is_menu"));
		}
	}
	
%>
<style type="text/css">
.dataTables_filter {
	display: block;
}
</style>
</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<%@include file="../sidebar.html"%>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<%@include file="../topbar.html"%>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div id="layoutSidenav_content">
					<main> <header
						class="page-header page-header-compact page-header-light border-bottom bg-white mb-2">
					<div class="container-fluid">
						<div class="page-header-content">
							<div class="row align-items-center justify-content-between"
								style="height: 4rem;">
								<div class="col-auto mb-3">
									<h1 class="page-header-title"
										style="color: <%=bckColor%>; font-weight: bold; font-size: x-large;">
										<div class="page-header-icon">
											<i class="fas fa-project-diagram"></i>
										</div>
										Guide Functions
									</h1>
								</div>
							</div>
						</div>
					</div>
					</header> <!-- Main page content-->
					<div class="container">
						<div class="row">

							<div class="card col-xl-12 mb-12">
								<div class="card-header py-5">
									<h6 class="m-0 font-weight-bold text-primary">Add New Function</h6>
								</div>
								<div class="card-body">
								<form id="functionForm" action="<%=request.getContextPath()%>/ReferenceGuideFunctionServlet" method="post">
									<input type="hidden" id="hiddenId" name="hiddenId" value="<% if(referenceGuideFunctions != null) {%><%=referenceGuideFunctions.getId() %><%}%>">
									<div class="form-group row" style="align-items: center;">
										<label class="col-sm-1 col-form-label">Name:<span style="color: red;">*</span></label> 
										<input class="col-sm-4 form-control" id="name" name="name" placeholder="Ex. RKI Configuration" required pattern=".*\S+.*"
											value="<% if(referenceGuideFunctions != null) {%><%=referenceGuideFunctions.getName() %><%}%>">
									</div>
									
									<div class="form-group row" style="align-items: center;">
										<label class="col-sm-1 col-form-label">Solution:<span style="color: red;">*</span></label> 
										<textarea class="col-sm-4 form-control" placeholder="Solution..." rows="1" id="solution" name="solution" spellcheck="false" required pattern=".*\S+.*"><% if(referenceGuideFunctions != null) {%><%=referenceGuideFunctions.getShort_solution() %><%}%></textarea>
									</div>
									
									<div class="form-group row" style="align-items: center;">
										<label class="col-sm-1 col-form-label">Supported:<span style="color: red;">*</span></label> 
										<div class="form-check form-check-solid" style="align-items: center;">
										    <input class="form-check-input" id="isTelium" name="isTelium" type="checkbox" value="1"
										    <%
										    	if(referenceGuideFunctions != null) {
										    		if(referenceGuideFunctions.getIs_telium()) {
										    			%>checked="checked"<%
										    		}
										    	} else {
										    		%>checked="checked"<%
										    	}
										    %>>
										    <label class="form-check-label" for="flexCheckSolidDefault">Telium</label>
										</div>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<div class="form-check form-check-solid">
										    <input class="form-check-input" id="isTetra" name="isTetra" type="checkbox" value="1" 
										     <%
										    	if(referenceGuideFunctions != null) {
										    		if(referenceGuideFunctions.getIs_tetra()) {
										    			%>checked="checked"<%
										    		}
										    	}
										    %>>
										    <label class="form-check-label" for="isTetra">Tetra</label>
										</div>
									</div>
									
									<div class="form-group row" style="align-items: center;">
										<label class="col-sm-1 col-form-label">Type:<span style="color: red;">*</span></label> 
										<div class="custom-control custom-radio">
										  <input type="radio"class="custom-control-input" id="radioTypeFunction" name="radioType" value="FUNCTION"
										  <%
										    	if(referenceGuideFunctions != null) {
										    		if(referenceGuideFunctions.getIs_function()) {
										    			%>checked="checked"<%
										    		}
										    	} else {
										    		%>checked="checked"<%
										    	}	
										    %>>
										  <label class="custom-control-label" for="radioTypeFunction">Function</label>
										</div>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<div class="custom-control custom-radio">
										  <input type="radio" class="custom-control-input" id="radioTypeMenu" name="radioType" value="MENU"
										  <%
										    	if(referenceGuideFunctions != null) {
										    		if(referenceGuideFunctions.getIs_menu()) {
										    			%>checked="checked"<%
										    		}
										    	}
										    %>>
										  <label class="custom-control-label" for="radioTypeMenu">Menu</label>
										</div>
									</div>

									<div class="form-group row" style="align-items: center;">
										<label class="col-sm-1 col-form-label"></label> 
										<%
										    if(referenceGuideFunctions != null) {
										    	%>
										    		<button type="submit" title="Update" class="btn btn-sm btn-light active mr-3"
															style="background-color:<%=bckColor%>; font-size: medium; width: fit-content;">
										            		<i class="fas fa-pen-square"></i>&nbsp; Update
										            </button>
										            <a style="text-decoration: none" href="guide-functions.jsp">
										            <button type="button" title="Cancel" class="btn btn-sm btn-light active mr-3" 
										            	style="background-color:#e81500; font-size: medium; width: fit-content;">
														<i class="far fa-window-close"></i>&nbsp; Cancel
													</button>
													</a>
										    	<%
										    } else {
										    	%>
										    		<button type="submit" title="Save" class="btn btn-sm btn-light active mr-3"
															style="background-color:<%=bckColor%>; font-size: medium; width: fit-content;">
										            		<i class="fas fa-save"></i>&nbsp; Save
										            </button>
										            <button type="reset" title="Clear" class="btn btn-sm btn-light active mr-3" 
										            	style="background-color:#e81500; font-size: medium; width: fit-content;">
														<i class="fas fa-broom"></i>&nbsp; Clear
													</button>
									    		<%
										    }
										%>
									</div>
							</form>		
								</div>
							</div>
							
							
							<!-- DataTales Example -->
							<div class="card col-xl-12 mb-12" style="margin-top:  1rem;">
								<div class="card-header py-5">
									<h6 class="m-0 font-weight-bold text-primary">Functions</h6>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-bordered" id="dataTable"
											cellspacing="0">
											<thead>
												<tr>
													<th style="text-align: left;">#</th>
													<th style="text-align: left;">Function Name</th>
													<th style="text-align: left;">Solution</th>
													<th style="text-align: left;">Telium</th>
													<th style="text-align: left;">Tetra</th>
													<th style="text-align: left;">Function</th>
													<th style="text-align: left;">Menu</th>
													<th>Action</th>
												</tr>
											</thead>
											<tfoot>
												<tr>
													<th style="text-align: left;">#</th>
													<th style="text-align: left;">Function Name</th>
													<th style="text-align: left;">Solution</th>
													<th style="text-align: left;">Telium</th>
													<th style="text-align: left;">Tetra</th>
													<th style="text-align: left;">Function</th>
													<th style="text-align: left;">Menu</th>
													<th>Action</th>
												</tr>
											</tfoot>
											<tbody>

												<% 
                                    	
                                    		rs = st.executeQuery("SELECT * FROM reference_guide_functions");
                                    	
                                    		while (rs.next()) { 
                                    	%>
												<tr>
													<td style="text-align: left;"><%=rs.getString("id") %></td>
													<td style="text-align: left;"><%=rs.getString("name") %></td>
													<td style="text-align: left;"><%=rs.getString("short_solution") %></td>
													<td>
														<%
                                            	if(rs.getBoolean("is_telium")) {
                                            		%><i
														class="far fa-check-square"></i>
														<%
                                            	}
                                            %>
													</td>
													<td>
														<%
                                            	if(rs.getBoolean("is_tetra")) {
                                            		%><i
														class="far fa-check-square"></i>
														<%
                                            	}
                                            %>
													</td>
													<td>
														<%
                                            	if(rs.getBoolean("is_function")) {
                                            		%><i
														class="far fa-check-square"></i>
														<%
                                            	}
                                            %>
													</td>
													<td>
														<%
                                            	if(rs.getBoolean("is_menu")) {
                                            		%><i
														class="far fa-check-square"></i>
														<%
                                            	}
                                            %>
													</td>
													<td><a style="text-decoration: none"
														href="guide-functions.jsp?editFunctionId=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>">
															<i class="fas fa-edit"></i>
													</a></td>
												</tr>
												<% } %>
											</tbody>
										</table>
									</div>
								</div>
							</div>

						</div>
					</div>
					</main>
				</div>

				<!-- End if Page Content -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<%@include file="../footer.html"%>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Alert Status -->
	<%@include file="../alert.html"%>
	<!-- Alert Status -->
</body>
<% 
	dbConn.close();

} catch (Exception e) {
	e.printStackTrace();
} %>
<script type="text/javascript">
	$(document).ready( function () {
	    $('#dataTable').DataTable({
	    	"order": [[ 0, "desc" ]]
	    });
	} );
</script>
</html>
