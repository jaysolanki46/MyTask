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
<title>Skyzer - My Task | Profile</title>

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
                                <div class="row align-items-center justify-content-between " style="height: 4rem;">
                                    <div class="col-auto mb-3">
                                        <h1 class="page-header-title center_div" style="color: <%=bckColor %>; font-weight: bold; font-size: x-large;">
                                            <div class="page-header-icon">
                                          		<i class="fas fa-user"></i>  
                                            </div>
                                            Profile
                                        </h1>
                                    </div>
                                    <button
                                        class="btn btn-sm btn-light active mr-3 center_div card-button popup-modal" 
                                        	id="projectsTutorial"  title="Tutorial"  data-toggle="modal" data-target="#tutorialPopup"
											style="background-color:<%=bckColor %>; "><i class="fas fa-video"></i></button>

                                </div>
                                
                                <div class="modal fade" id="tutorialPopup" tabindex="-1" role="dialog" aria-labelledby="tutorialPopupLbl" style="display: none;" aria-hidden="true">
									    <div class="modal-dialog modal-xl" role="document">
									        <div class="modal-content" style="height: 40rem;">
									            <div class="modal-header">
									                <h5 class="modal-title">Project Tutorial</h5>
									                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
									            </div>
									            <div class="modal-body">
									                <iframe height="100%" width="100%" src="https://www.youtube.com/embed/tgbNymZ7vqY"></iframe>
									            </div>
									        </div>
									    </div>
									</div>
                                
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <!-- Basic registration form-->
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header justify-content-center"><h3 class="font-weight-light my-4">My Profile</h3></div>
                                    <div class="card-body">
                                        <!-- Registration form-->
                                        <form action="<%=request.getContextPath()%>/UserServlet" method="post">
                                        	<input type="hidden" name="userId" value="<%=userid%>"/>
                                            <!-- Form Row-->
                                            <div class="form-row">
                                                <div class="col-md-6">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="userName">Name</label>
                                                        <input class="form-control" id="userName" name="userName" type="text" placeholder="Name" value="<%=username%>">
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                <div class="form-group">
	                                                <label class="small mb-1" for="userEmail">Email</label>
	                                                <input class="form-control" id="userEmail" name="userEmail" type="email" aria-describedby="emailHelp" placeholder="Email" value="<%=useremail%>">
	                                            </div>
	                                            </div>
                                            </div>
                                            <!-- Form Row    -->
                                            <div class="form-row">
                                            <div class="col-md-6">
                                            		<div class="form-group">
                                                        <label class="small mb-1" for="userName">Department</label>
                                                        <%
															rs = st.executeQuery("SELECT * FROM departments where id = " + userdepartment);
															while(rs.next()) {
																%><input class="form-control" type="text" placeholder="Name" value="<%=rs.getString("name")%>" readonly="readonly"><%
															}
														%>
                                                    </div>
                                            	</div>
											 <div class="col-md-6">
	                                            <div class="col-md-13">
                                                    <div class="form-group">
                                                        <label class="small mb-1" for="userPassword">Password</label>
                                                        <input class="form-control" id="userPassword" name="userPassword" type="password" 
                                                        value="<%=userpass%>" data-toggle="password">
                                                    </div>
                                                </div>
											</div>
											</div>
											
											<div class="form-row">
                                            	 <div class="col-md-6">
                                            	<label class="small mb-1" for="name">Theme</label>
	                                            	<div class="col-md-12" style="margin-left: -1rem;">
		                                                <div class="custom-control custom-radio custom-control-inline">
														  <input type="radio" id="techRadio" name="userTheme" class="custom-control-input" value="0" 
														  <%
														  	if(usertheme.equals("0")) {
														  		%>checked<%
														  	}
														  %>>
														  <label class="custom-control-label" for="techRadio">Skyzer Technologies</label>
														</div>
														<div class="custom-control custom-radio custom-control-inline">
														  <input type="radio" id="payRadio"  name="userTheme" class="custom-control-input" value="1"
														  <%
															if(usertheme.equals("1")) {
														  		%>checked<%
														  	}
														  %>>
														  <label class="custom-control-label" for="payRadio">Skyzer Payments</label>
														</div>
													</div>
													
											</div>
                                            	<div class="col-md-6">
                                            		<div class="custom-control custom-control-inline">
													  <input type="checkbox" class="custom-control-input" id="showCheck" onclick="showPassword()">
													  <label class="custom-control-label" for="showCheck">Show password</label>
													</div>
                                            	</div>
                                            </div>
                                            
											
                                            
                                            <br/>
                                            <button class="btn-block btn btn-light active" style="background-color:<%=bckColor %>;" 
                                            type="button" data-dismiss="modal" onclick="form.submit()">
							            		Save
							            	</button>
                                        </form>
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
    function showPassword() {
    	  var inputPassword = document.getElementById("userPassword");
    	  if (inputPassword.type === "password") {
    		  inputPassword.type = "text";
    	  } else {
    		  inputPassword.type = "password";
    	  }
    	}
</script>
</html>


