<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Projects</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "#0066cb";
	//String bckColor = "#b81b44";
	
	String showSkyzerPaymentImg = "display: none";
	String showSkyzerTechImg = "display: block";
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
                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold;">
                                            <div class="page-header-icon">
                                          		<i class="fas fa-project-diagram"></i>  
                                            </div>
                                            Projects
                                        </h1>
                                    </div>
                                    <div class="col-12 col-xl-auto mb-3">
                                        <button style="background-color:<%=bckColor %>;" 
                                        data-toggle="modal" data-target="#exampleModalLg"
                                        class="btn btn-sm btn-light active mr-2"><i class="fas fa-plus"></i>&nbsp;Create New Project</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container">
                        <div class="row">
                        
                        	<div class="modal fade" id="exampleModalLg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
							    <div class="modal-dialog modal-lg" role="document">
							        <div class="modal-content">
							            <div class="modal-header">
							                <h5 class="modal-title">Create a new project</h5>
							                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
							            </div>
							            <div class="modal-body">
							                <form>
											    <div class="form-group"><label for="exampleFormControlInput1">Email address</label><input class="form-control" id="exampleFormControlInput1" type="email" placeholder="name@example.com"></div>
											    <div class="form-group">
											        <label for="exampleFormControlSelect1">Example select</label><select class="form-control" id="exampleFormControlSelect1">
											            <option>1</option>
											            <option>2</option>
											            <option>3</option>
											            <option>4</option>
											            <option>5</option>
											        </select>
											    </div>
											    <div class="form-group">
											        <label for="exampleFormControlSelect2">Example multiple select</label><select class="form-control" id="exampleFormControlSelect2" multiple="">
											            <option>1</option>
											            <option>2</option>
											            <option>3</option>
											            <option>4</option>
											            <option>5</option>
											        </select>
											    </div>
											    <div class="form-group"><label for="exampleFormControlTextarea1">Example textarea</label><textarea class="form-control" id="exampleFormControlTextarea1" rows="3"></textarea></div>
											</form>
							            </div>
							            <div class="modal-footer"><button class="btn btn-sm btn-light active mr-2" style="background-color:<%=bckColor %>; " type="button" data-dismiss="modal">Close</button></div>
							        </div>
							    </div>
							</div>
                        	
                            
                            <!-- Project card -->
                            <div class="col-lg-4 mb-4">
                                <a class="card lift lift-sm h-100" href="knowledge-base-category.html">
                                    <div class="card-body py-5">
                                        <h5 class="card-title mb-2" style="color:<%=bckColor %>;">
                                            Project IKR
                                        </h5>
                                    </div>
                                    <div class="card-footer">
										<div class="small text-muted mb-2">
											12 tasks in this project
										</div>
										<div class="progress rounded-pill"
											style="height: 0.5rem">
											<div style="background-color:<%=bckColor %>;" class="progress-bar w-75 rounded-pill"
												role="progressbar" aria-valuenow="75" aria-valuemin="0"
												aria-valuemax="100"></div>
										</div>
									</div>
								</a>
                            </div>
                           <!-- End of project card -->
                           
                           <!-- New project card -->
                             <div class="col-lg-4 mb-4" data-toggle="tooltip" title="Create New Project">
                                <!-- Knowledge base category card 1-->
                                <a  class="card lift lift-sm h-100" data-toggle="modal" data-target="#exampleModalLg">
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

    

</body>
</html>