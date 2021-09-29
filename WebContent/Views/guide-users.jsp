<%@page import="config.EnumGuide"%>
<%@page import="config.EnumMyTask.SKYZERTASKSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERDEPARTMENTS"%>
<%@page import="java.util.Base64"%>
<%@page import="config.EnumGuide.USERSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="config.EnumMyTask.SKYZERUSERSTATUS"%>
<%@page import="config.EnumMyTask.SKYZERPROJECTSTATUS"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.GuideDBConfig" %>
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
<title>Skyzer - Guide App | Users</title>

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

	Connection dbConn = GuideDBConfig.connection(); ;
	Statement st = null;
	ResultSet rs = null;
	st = dbConn.createStatement();
	
	String activeUser = request.getParameter("activeUser");
	String deactiveUser = request.getParameter("deactiveUser");
	Statement stUserStatus = null;
	stUserStatus = dbConn.createStatement();
	
	if(activeUser != null){
		stUserStatus.executeUpdate("UPDATE users set is_active = '"+ EnumGuide.USERSTATUS.ACTIVE.getValue() +"', " +
										"updated_on = '"+ LocalDate.now().toString() +"' " +
										"where id = '"+ new String(Base64.getDecoder().decode(activeUser)) +"'");
		session.setAttribute("status", "update");
		
	} else if (deactiveUser != null) {
		stUserStatus.executeUpdate("UPDATE users set is_active = '"+ EnumGuide.USERSTATUS.DEACTIVE.getValue() +"', " +
										"updated_on = '"+ LocalDate.now().toString() +"' " +
										"where id = '"+ new String(Base64.getDecoder().decode(deactiveUser)) +"'");
		session.setAttribute("status", "update");
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
                                            Guide Users
                                        </h1>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container">
                        <div class="row">
                        	
                        	 <!-- DataTales Example -->
                    <div class="card col-xl-12 mb-12">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">App Users</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" 
                                cellspacing="0" >
                                    <thead>
                                        <tr>
                                            <th style="text-align: left;">#</th>
                                            <th style="text-align: left;">Username</th>
                                            <th style="text-align: left;">Email</th>
                                            <th style="text-align: left;">Division</th>
                                            <th style="text-align: left;">Status</th>
                                            <th >Action</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                          <th style="text-align: left;">#</th>
                                          <th style="text-align: left;">Username</th>
                                          <th style="text-align: left;">Email</th>
                                          <th style="text-align: left;">Division</th>
                                          <th style="text-align: left;">Status</th>
                                          <th >Action</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    
                                    	<% 
                                    	
                                    		rs = st.executeQuery("select users.*, divisions.division, divisions.dealer_name from users "
                                    			+ "LEFT JOIN divisions on users.division = divisions.id");
                                    	
                                    		while (rs.next()) { 
                                    	%>
                                        <tr>
                                            <td style="text-align: left;"><%=rs.getString("id") %></td>
                                            <td style="text-align: left;"><%=rs.getString("username") %></td>
                                            <td style="text-align: left;"><%=rs.getString("email") %></td>
                                            <td style="text-align: left;"><%=rs.getString("divisions.division") + "-" + rs.getString("dealer_name") %></td>
                                            <td style="text-align: left;">
                                            	<%
                                            	if(!rs.getBoolean("is_active")) {
                                            		%>
														<span class="badge badge-danger">NOT ACTIVE</span>
                                            		<%
                                            	} else {
                                            		%>
                                    					<span class="badge badge-success">ACTIVE</span>
                                    				<%
                                            	}
                                            	%>
                                            </td>
                                            <td>
                                            	<%
                                            	if(!rs.getBoolean("is_active")) {
                                            		%>
	                                            		<a 	style="text-decoration: none" href="guide-users.jsp?activeUser=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>">
	                                            				<button type="button" class="btn btn-success">
																<i class="fas fa-check-square"></i>&nbsp; ACTIVE</button>
														</a>
                                            		<%
                                            	} else {
                                            		%>
	                                            		<a 	style="text-decoration: none" href="guide-users.jsp?deactiveUser=<%=Base64.getEncoder().encodeToString(rs.getString("id").getBytes())%>">
	                                    						<button type="button" class="btn btn-danger">
																<i class="fas fa-window-close"></i>&nbsp; DEACTIVE</button>
														</a>
                                    				<%
                                            	}
                                            	%>
                                            </td>
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
<script type="text/javascript">
	$(document).ready( function () {
	    $('#dataTable').DataTable({
	    	"order": [[ 0, "desc" ]]
	    });
	} );
</script>
</html>
