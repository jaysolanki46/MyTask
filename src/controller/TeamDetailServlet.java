package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Department;
import bean.Project;
import bean.ProjectTeam;
import bean.TaskDetail;
import bean.User;
import model.ProjectDAO;
import model.TaskDetailDAO;

@WebServlet("/TeamDetailServlet")
public class TeamDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean isInsert;
	private TaskDetailDAO taskDetailDAO;
	private HttpSession session;
       
    public TeamDetailServlet() {
        super();
        isInsert = false;
        taskDetailDAO = new TaskDetailDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			session = request.getSession();
			
			TaskDetail taskDetail = new TaskDetail();
			taskDetail.setId(Integer.valueOf(request.getParameter("hiddenTaskId")));
			taskDetail.setTaskDetailDate(request.getParameter("taskDetailDate"));
			taskDetail.setHours(request.getParameter("taskDetailHours"));
			taskDetail.setDescription(request.getParameter("taskDetailDescription"));
			taskDetail.setCreatedOn(LocalDate.now().toString());
			taskDetail.setCreatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			taskDetail.setUpdatedOn(LocalDate.now().toString());
			taskDetail.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
				
			isInsert = taskDetailDAO.insert(taskDetail);
			if(isInsert) session.setAttribute("status", "insert");
			else session.setAttribute("status", "error");
			
			response.sendRedirect("./Views/tasks.jsp?project=" + Base64.getEncoder().encodeToString(request.getParameter("hiddenProjectId").getBytes()));
			
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("status", "ko");
			response.sendRedirect("./Views/tasks.jsp?project=" + Base64.getEncoder().encodeToString(request.getParameter("hiddenProjectId").getBytes()));
		}
	}

}
