<%@page import="bean.User"%>
<%@page import="model.UserDAO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Skyzer - My Task | Login</title>

<!-- Declaring header file due to path issue -->
<!-- start header includes -->
	<link rel="icon" href="img/icons/favicon.ico">
	<%@include  file="../style.html" %>
	<!-- Custom fonts for this template-->
	<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	        rel="stylesheet">
	<link href="css/sb-admin-2.min.css" rel="stylesheet">
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- end header includes -->
<%
	session.invalidate();
	String username = request.getParameter("username");
	String pass = request.getParameter("password");
	String theme = "#0066cb";
	HttpSession user = request.getSession();
	ResultSet rs = null;
	
	if(username != null) {
		rs = UserDAO.authenticate(new User(username, pass));	
		
		System.err.print(rs);
		if (rs.next()) {
			response.sendRedirect("Views/projects.jsp");
			user.setAttribute("userId", rs.getString("id"));
			user.setAttribute("userName", rs.getString("name"));
			user.setAttribute("userEmail", rs.getString("email"));
			user.setAttribute("userDepartment", rs.getString("department"));
			user.setAttribute("userTheme", rs.getString("theme"));
			user.setAttribute("userPass", rs.getString("pass"));
			user.setAttribute("userType", rs.getString("user_type"));
		}  else {
			user.setAttribute("name", "error");
			%><script>
				alert("Invalid username or password!");
			</script>
			<% 
		}
	}
	
	System.out.println(username + pass);
%>
</head>
<body style="background: #0066cb; margin-top:10rem;">
	<div class="container register">
                <div class="row">
                    <div class="col-md-3 register-left">
						<img src="img/icons/favicon.png" alt=""/>
                        <h3>SKYZER - MY TASK</h3>
                        <p>MANAGES SKYZER TASKS <br/> V1.0</p>
                        <span>Designed & Hosted by <br/><a href="http://jaysolanki.tech/" target="_blank" style="color: white;">Jay Solanki</a></span>
                    </div>
                    <div class="col-md-9 register-right">
                        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="user-tab" data-toggle="tab" href="#user" role="tab" aria-controls="user" aria-selected="true">User</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="admin-tab" data-toggle="tab" href="#admin" role="tab" aria-controls="admin" aria-selected="false">Admin</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="user" role="tabpanel" aria-labelledby="user-tab">
                                <img alt="" loading="lazy" style="margin-top: 5rem; margin-left: 5rem;"  data-src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg" class="vc_single_image-img attachment-full lazyloaded" src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg">
                                <form action="" method="post">
                                <div class="row register-form">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="Username *" value=""  name="username"/>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder="Password *" value="" name="password"/>
                                        </div>
                                         <input type="submit" class="btnRegister"  value="Login"/>
                                    </div>
                                </div>
                                </form>
                            </div>
                            <div class="tab-pane fade show" id="admin" role="tabpanel" aria-labelledby="admin-tab">
                                 <img alt="" loading="lazy" style="margin-top: 5rem; margin-left: 5rem;"  data-src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg" class="vc_single_image-img attachment-full lazyloaded" src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg">
                                 <form action="<%=request.getContextPath()%>/UserServlet" method="post">
                                 <div class="row register-form">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="Username *" value="" name="username"/>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder="Password *" value="" name="password"/>
                                        </div>
                                          <input type="submit" class="btnRegister" value="Secure Login" />
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
	integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
	crossorigin="anonymous"></script>
</body>
</html>