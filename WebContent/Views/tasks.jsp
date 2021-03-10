<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Tasks</title>

<!-- Following css/styles just for table -->
<link rel="stylesheet" type="text/css" href="../fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="../vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="../vendor/perfect-scrollbar/perfect-scrollbar.css">
<link rel="stylesheet" type="text/css" href="../css/util.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<%@include  file="../header.html" %>
<%
	String bckColor = "#0066cb";
	//String bckColor = "#b81b44";
	
	String showSkyzerPaymentImg = "display: none";
	String showSkyzerTechImg = "display: block";
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
                                          		<i class="fas fa-project-diagram"></i>  
                                            </div>
                                            @Project IKR - Tasks
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
                        	
                        	<!-- Models -->
                        	<div class="modal fade" id="projectModelLg" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
							    <div class="modal-dialog modal-lg" role="document">
							        <div class="modal-content">
							            <div class="modal-header">
							                <h5 class="modal-title">Create a new project</h5>
							                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
							            </div>
							            <div class="modal-body">
							                <form>
							                	<div class="row">
							                		<div class="col">
													    <div class="form-group">
														    <label for="projectNameInput">Project name <span style="color: red;">*</span></label>
														    <input style="height: fit-content;" class="form-control" id="projectNameInput" type="text" placeholder="Ex. IKR Project">
													    </div>
												    </div>
												    <div class="col">
													    <div class="form-group">
													        <label for="departmentSelect">Department <span style="color: red;">*</span></label>
													        <select style="height: fit-content;" class="form-control" id="departmentSelect">
													            <option>GENERAL</option>
													            <option>SUPPORT</option>
													            <option>SALES</option>
													            <option>COOPERATE</option>
													            <option>PRODUCTION</option>
													        </select>
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
                        	<!-- End Models -->
                            
                            <!-- Task Table -->
                            <div class="limiter">
							<div class="container-table100">
								<div class="wrap-table100">
									<div class="table100 ver1 m-b-110">
										<table data-vertable="ver1">
											<thead>
												<tr class="row100 head">
													<th style="background-color: <%=bckColor %>;" class="column100 column1" data-column="column1">Task / Dates</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column2" data-column="column2">Sunday</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column3" data-column="column3">Monday</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column4" data-column="column4">Tuesday</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column5" data-column="column5">Wednesday</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column6" data-column="column6">Thursday</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column7" data-column="column7">Friday</th>
													<th style="background-color: <%=bckColor %>;" class="column100 column8" data-column="column8">Saturday</th>
												</tr>
											</thead>
											<tbody>
												<tr class="row100">
													<td class="column100 column1" data-column="column1">
													<button href="#" title="Add time">
														<span style="font-size: 1em;">
														  <i style="margin-left: 10px;" class="far fa-calendar-plus"></i>
														</span>
													</button>	| 												
													Lawrence Scott 
													</td>
													
													<td class="column100 column2" data-column="column2">8:00 AM</td>
													<td class="column100 column3" data-column="column3">--</td>
													<td class="column100 column4" data-column="column4">--</td>
													<td class="column100 column5" data-column="column5">8:00 AM</td>
													<td class="column100 column6" data-column="column6">--</td>
													<td class="column100 column7" data-column="column7">5:00 PM</td>
													<td class="column100 column8" data-column="column8">8:00 AM</td>
												</tr>
												
												 <!-- New task row -->
												<tr class="row100">
													<td class="column100 column1" data-column="column1">
													<button href="#" title="Add time">
														<span style="font-size: 1em;">
														  <i style="margin-left: 10px;" class="far fa-calendar-plus"></i>
														</span>
													</button>	| 												
													Add New Task <b>@Project IKR</b> 
													</td>
													
													<td class="column100 column2" data-column="column2">8:00 AM</td>
													<td class="column100 column3" data-column="column3">--</td>
													<td class="column100 column4" data-column="column4">--</td>
													<td class="column100 column5" data-column="column5">8:00 AM</td>
													<td class="column100 column6" data-column="column6">--</td>
													<td class="column100 column7" data-column="column7">5:00 PM</td>
													<td class="column100 column8" data-column="column8">8:00 AM</td>
												</tr>
												<!-- End of new task row -->
												
											</tbody>
										</table>
									</div>
					
									
									
									</div>
								</div>
							</div>
                           <!-- End of Task Table -->
                           
                        </div>
                    </div>
                </main>
            </div>
               
				<!-- End if Page Content -->
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <!-- Following css/styles just for table -->
			<script src="../vendor/bootstrap/js/popper.js"></script>
			<script src="../vendor/select2/select2.min.js"></script>
			<script src="../js/main.js"></script>
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