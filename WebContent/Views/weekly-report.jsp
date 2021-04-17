<%@page import="config.EnumMyTask.SKYZERPAYMENTS"%>
<%@page import="config.EnumMyTask.SKYZERTECHNOLOGIES"%>
<%@page import="javafx.util.Pair"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.text.SimpleDateFormat" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skyzer - My Task | Weekly Report</title>

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
	
	// Number of tasks
	Map<Integer, String> taskList = new HashMap<Integer, String>();
	taskList.put(1, "Task 1");
	taskList.put(2, "Task 2");
	taskList.put(3, "Task 3");
	//taskList.put(4, "Task 4");
	
	
	// 5 days
	Calendar currentWeek = Calendar.getInstance();
	Calendar now;
	
	// On prev next click
	int day, month, year;
	Date date = new Date();
	Date start_date = new Date(date.getYear(), date.getMonth(), date.getDate() - date.getDay());
	Date end_date = new Date(date.getYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
	String dateString = start_date.getDate() + "/" + (start_date.getMonth() + 1)  + "/" + (start_date.getYear() +1900)
						+ " - " + end_date.getDate() + "/" + (end_date.getMonth() + 1) + "/" + (end_date.getYear() +1900);
	System.out.print(dateString);
	
	if (request.getParameter("week-picker-start-day") != null) {
		dateString = request.getParameter("week-picker-start-date");
		day = Integer.valueOf(request.getParameter("week-picker-start-day"));
		month = Integer.valueOf(request.getParameter("week-picker-start-month")) - 1;
		year = Integer.valueOf(request.getParameter("week-picker-start-year"));

		currentWeek.set(year, month, day);
	}

	SimpleDateFormat dd_MMMFormate = new SimpleDateFormat("dd MMM");
	SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ddMMMFormate = new SimpleDateFormat("ddMMM");

	int delta = 0;//-now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
	//now.add(Calendar.DAY_OF_MONTH, delta);
	String daysList[] = { "Mon", "Tue", "Wed", "Thurs", "Fri" };
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

#profileImage {
	width: 40px;
    height: 40px;
    border-radius: 50%;
    font-size: 21px;
    color: #fff;
    text-align: center;
    line-height: 40px;
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
                            <div class="card-body"  style="padding: 0px;">
                               <div class="container-fluid">
		                            <div class="page-header-content">
		                                <div class="row align-items-center justify-content-between pt-3">
		                                    <div class="col-auto mb-3">
		                                        <h1 class="page-header-title" style="color: <%=bckColor %>; font-weight: bold;font-size: x-large;">
		                                            <div class="page-header-icon">
		                                          		<i class="fas fa-clipboard-list"></i>
		                                            </div>
		                                            Reports
		                                        </h1>
		                                    </div>
		                                    
		                                </div>
		                            </div>
		                        </div>
		                        <hr style="margin: 0rem;">
                                <nav class="nav nav-borders nav-width">
                                    <a class="nav-link active ml-0" style="color: <%=bckColor %>; border-bottom-color: <%=bckColor %>;" href="/MyTask/Views/weekly-report.jsp">Weekly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/monthly-report.jsp">Monthly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/custom-report.jsp">Custom</a>
                                    
                                     <!-- Weekly datepicker -->
                                     
		                              <div class="form-group col-md-4 col-md-offset-2" id="week-picker-wrapper" style="margin: 0rem; margin-left: auto;">
											<div class="input-group">
											<form class="form-inline"  method="post" action="../Views/weekly-report.jsp">
												<label style="color: <%=bckColor %>;">Select Week: </label>
												<input type="text" id="week-picker-string" class="form-control week-picker" readonly="readonly" onchange="this.form.submit();"
													value="<%=dateString %>" placeholder="Select a Week" style="margin: 0.2rem; text-align: center; width: 18rem;">
												<input type="hidden"  id="week-picker-start-date" name="week-picker-start-date" value="">
												<input type="hidden" id="week-picker-start-day" name="week-picker-start-day" value="">
												<input type="hidden" id="week-picker-start-month" name="week-picker-start-month" value="">
												<input type="hidden" id="week-picker-start-year" name="week-picker-start-year" value="">
												
												</form>
											</div>
										</div>
                                <!-- End of weekly datepicker -->
                                </nav>
                                
                               
                            </div>
                        </header>
                    <!-- Main page content-->
                    <div class="container">
                            
                            <table id="weeklyDataTable" class="table table-bordered" style="border: hidden;">
						    <thead>
							      <tr>
							      	<th>Project</th>
							        <th style="text-align: center;">Task</th>
							        <th>Assignee</th>
							        <%
							        
								        now = currentWeek;
								        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
								        now.add(Calendar.DAY_OF_MONTH, delta );
							        
								        for (int i = 0; i < 5; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=dd_MMMFormate.format(now.getTime()) + " , " + daysList[i] %></th><% 
								        	now.add(Calendar.DAY_OF_MONTH, 1);
								        }
							        	
							        %>
							       
							        <th style="text-align: center;">Total hours</th>
							      </tr>
							    </thead>
						    
						    <tbody>
						      <% 
							    Integer key = 0;
						        String name = "";
						        String firstName =  "";
						        String lastName = "";
						        String profileColor = "green";
						        
								    for (Map.Entry<Integer, String> entry : taskList.entrySet()) {
								    	key = entry.getKey();
								        name = entry.getValue();
								        firstName = "Jay";
								        lastName = "Solanki";
								        %>
								        	<tr>
										        <td>
										        	Project IKR
										        </td>
										        <td style="text-align: inherit;">
										        	<%=name %> 
										        </td>
										        <td>
										        	<!-- will come from db -->
													<div id="profileImage" style="background: <%=profileColor %>" title="">
														<%=firstName.toUpperCase().charAt(0) + "" + lastName.toUpperCase().charAt(0) %>
													</div>
										        </td>
										        <%
										        
											     	// 5 days
											    	now = currentWeek;
											        delta = -now.get(GregorianCalendar.DAY_OF_WEEK) + 2; //add 2 if your week start on monday
											        now.add(Calendar.DAY_OF_MONTH, delta );
										        
											        for (int i = 0; i < 5; i++)
											        {
											        	%>
											        		<td>
											        			<input class="form-control form-control-sm hours-text" type="text" readonly="readonly" value="00.00"
											        			onclick="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" data-toggle="modal" data-target="#taskModel<%=key + ddMMMFormate.format(now.getTime()) %>">
													        	
													        	<!-- Model update task -->
									                        	<div class="modal fade" id="taskModel<%=key + ddMMMFormate.format(now.getTime()) %>" tabindex="-1" role="dialog" aria-labelledby="projectModelLglabel" aria-hidden="true">
																    <div class="modal-dialog modal-lg" role="document">
																        <div class="modal-content">
																            <div class="modal-header">
																                <h5 class="modal-title"><%=name %></h5>
																                <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
																            </div>
																            <div class="modal-body">
																                <form>
																                	<div class="row">
																                		<div class="col">
																						    <div class="form-group" style="text-align: start;">
																							    <label for="projectNameInput">Date <span style="color: red;">*</span></label>
																							    <input type="date" id="startDate" name="startDate" max="31-12-3000" min="01-01-1000" value="<%=yyyyMMddFormate.format(now.getTime()) %>" class="form-control">
																						    </div>
																					    </div>
																					    <div class="col">
																						    <div class="form-group" style="text-align: start;">
																						        <label for="departmentSelect">Hours <span style="color: red;">*</span></label>
																						        <input class="form-control" type="number" min="0" max="24" value="0" id="example-number-input">
																						    </div>
																					    </div>
																				    </div>
																				</form>
																            </div>
																            <div class="modal-footer">
																            <div style="margin-right: auto;margin-left: 0.5rem;">
																            	<input class="" id="customCheck1" type="checkbox">
																				<label class="" for="customCheck1">Complete</label>
																            </div>
																            	<button type="submit" title="Search"
																					class="btn btn-sm btn-light active mr-3 center_div card-button"
																					style="background-color:<%=bckColor %>; "
																					onclick="this.form.submit();">
																					<i class="fas fa-save"></i>&nbsp; Save</button>	
																            </div>
																        </div>
																    </div>
																</div>
									                        	<!-- End Model update task -->
													        </td>
											        	
											        	
											        	<% 
											            now.add(Calendar.DAY_OF_MONTH, 1);
											        }
										        
										        %>
										        <td>
										        	<input class="form-control form-control-sm total-hours-text" type="text" readonly="readonly" value="00.00">
										        </td>
										      </tr>
								        
								        
								        <%
								    }
							     %>	
						    </tbody>
						   
						  </table>
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
<% 
} catch (Exception e) {
	e.printStackTrace();
} %>
</html>


<script type="text/javascript">
var weekpicker, start_date, end_date, weekpickerstartdate, weekpickerstartday, weekpickerstartmonth, weekpickerstartyear;

function set_week_picker(date) {
    start_date = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay());
    end_date = new Date(date.getFullYear(), date.getMonth(), date.getDate() - date.getDay() + 6);
    weekpicker.datepicker('update', start_date);
    weekpicker.val(start_date.getDate() + '/' + (start_date.getMonth() + 1)  + '/' + start_date.getFullYear() + ' - ' + end_date.getDate() + '/' + (end_date.getMonth() + 1) + '/' + end_date.getFullYear());
    weekpickerstartdate.val(start_date.getDate() + '/' + (start_date.getMonth() + 1)  + '/' + start_date.getFullYear() + ' - ' + end_date.getDate() + '/' + (end_date.getMonth() + 1) + '/' + end_date.getFullYear());
    weekpickerstartday.val(start_date.getDate());
    weekpickerstartmonth.val(start_date.getMonth() + 1);
    weekpickerstartyear.val(start_date.getFullYear());
    
}
$(document).ready(function() {
    weekpicker = $('.week-picker');
    weekpickerstartdate = $('#week-picker-start-date');
    weekpickerstartday = $('#week-picker-start-day');
    weekpickerstartmonth = $('#week-picker-start-month');
    weekpickerstartyear = $('#week-picker-start-year');
    weekpicker.val($('#week-picker-string').val());
    console.log(weekpicker);
    weekpicker.datepicker({
        autoclose: true,
        forceParse: false,
        container: '#week-picker-wrapper',
    }).on("changeDate", function(e) {
        set_week_picker(e.date);
    });
    $('.week-prev').on('click', function() {
        var prev = new Date(start_date.getTime());
        prev.setDate(prev.getDate() - 1);
        //set_week_picker(prev);
    });
    $('.week-next').on('click', function() {
        var next = new Date(end_date.getTime());
        next.setDate(next.getDate() + 1);
        //set_week_picker(next);
    });
    //set_week_picker(new Date);
});

var collapsedGroups = {};

var oTable = $('#weeklyDataTable').DataTable({
  paging: false,
  "language": {
    "search": "Table search: "
  },
  order: [
    [2, 'asc']
  ],
  rowGroup: {
    // Uses the 'row group' plugin
    dataSrc: 0,
    startRender: function(rows, group) {
      var collapsed = !!collapsedGroups[group];

      rows.nodes().each(function(r) {
        r.style.display = 'none';
        if (collapsed) {
          r.style.display = '';
        }
      });

      // Add category name to the <tr>. NOTE: Hardcoded colspan
      return $('<tr/>')
        .append('<td colspan="9" style="text-align: justify;">' + group + ' - ' + rows.count() + ' Task(s)</td>')
        .attr('data-name', group)
        .toggleClass('collapsed', collapsed);
    }
  }
});

$('#weeklyDataTable tbody').on('click', 'tr.group-start', function() {
  var name = $(this).data('name');
  collapsedGroups[name] = !collapsedGroups[name];
  oTable.draw(false);
});

</script>