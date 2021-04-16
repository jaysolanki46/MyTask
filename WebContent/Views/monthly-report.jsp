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
<title>Skyzer - My Task | Monthly Report</title>

<%@include  file="../header.html" %>
<%
	String bckColor = "";
	String showSkyzerPaymentImg = "";
	String showSkyzerTechImg = "";
	
	String userid = "";
	String username = "";
	String useremail = "";
	String usertheme = "";
	String userpass = "";
	String usertype = "";
	
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
	taskList.put(4, "Task 4");
	
	Calendar currentMonth = Calendar.getInstance();
	Calendar now;
	SimpleDateFormat dd_MMMFormate = new SimpleDateFormat("dd MMM");
	SimpleDateFormat yyyyMMddFormate = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat ddMMMFormate = new SimpleDateFormat("ddMMM");
	SimpleDateFormat mmFormate = new SimpleDateFormat("MM");
	SimpleDateFormat mmmmFormate = new SimpleDateFormat("MMMM");
	SimpleDateFormat yyyyFormate = new SimpleDateFormat("YYYY");
	
	String monthString;
	
	if (request.getParameter("datepicker") != null) {
		Date date = new SimpleDateFormat("MMMM-yyyy").parse(request.getParameter("datepicker")); // Gets int from month name
		currentMonth.setTime(date);
	}
	monthString =  mmmmFormate.format(currentMonth.getTime()) + "-" + yyyyFormate.format(currentMonth.getTime());
	System.out.println(monthString);
	int delta = 0;
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
                                    <a class="nav-link  ml-0" href="/MyTask/Views/weekly-report.jsp">Weekly</a>
                                    <a class="nav-link active ml-0" style="color: <%=bckColor %>; border-bottom-color: <%=bckColor %>;" href="/MyTask/Views/monthly-report.jsp">Monthly</a>
                                    <a class="nav-link  ml-0" href="/MyTask/Views/custom-report.jsp">Custom</a>
                                    
                                     <!-- Weekly datepicker -->
                                     
		                              <div class="form-group col-md-4 col-md-offset-2" id="week-picker-wrapper" style="margin: 0rem; margin-left: auto;">
											<div class="input-group">
											<form class="form-inline"  method="post" action="../Views/monthly-report.jsp">
												<label style="color: <%=bckColor %>">Select Month: </label>
												<input type="text" class="form-control" name="datepicker" id="datepicker" readonly="readonly" onchange="this.form.submit();"
													value="<%=monthString %>" placeholder="Select a Month" style="margin: 0.2rem; text-align: center; width: 18rem;"/>
												
												</form>
											</div>
										</div>
                                <!-- End of weekly datepicker -->
                                </nav>
                                
                               
                            </div>
                        </header>
                    <!-- Main page content-->
                    <div class="container">
                            <div style="overflow: auto;    height: 40rem;    width: 100%;">
                            <table id="weeklyDataTable" class="table table-bordered" style="border: hidden;">
						    <thead>
							      <tr>
							      	<th>Project</th>
							        <th style="text-align: center;">Task</th>
							        <th>Assignee</th>
							        <%
							        
								        now = currentMonth;
								        delta = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH); //number of days in month
							        
								        for (int i = 1; i <= delta; i++)
								        {
								        	%><th style="text-align: -webkit-center;"><%=i + "/" + mmFormate.format(now.getTime()) %></th><% 
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
											    	 now = currentMonth;
								       				 delta = currentMonth.getActualMaximum(GregorianCalendar.DAY_OF_MONTH); //number of days in month
										        
								       				for (int i = 1; i <= delta; i++)
											        {
											        	%>
											        		<td>
											        			<label>0</label>
													        </td>
											        	
											        	
											        	<% 
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
$("#datepicker").datepicker( {
    format: "MM-yyyy",
    startView: "months", 
    minViewMode: "months"
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
        .append('<td colspan="32" style="text-align: justify;">' + group + ' - ' + rows.count() + ' Task(s)</td>')
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