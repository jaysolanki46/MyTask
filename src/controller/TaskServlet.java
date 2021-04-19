package controller;

import java.io.IOException;
import java.sql.Connection;
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
import bean.Task;
import bean.User;
import model.ProjectDAO;
import model.TaskDAO;

@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean isInsert;
	private TaskDAO taskDAO;
	private HttpSession session;
	
    public TaskServlet() {
        super();
        isInsert = false;
        taskDAO = new TaskDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			session = request.getSession();
			
			Task task = new Task();
			task.setName(request.getParameter("name"));
			task.setProject(new Project(Integer.valueOf(request.getParameter("hiddenProjectId").toString())));
			task.setTeam_member(new User(Integer.valueOf(request.getParameter("teamMember").toString())));
			task.setDescription(request.getParameter("description"));
			task.setCreatedOn(LocalDate.now().toString());
			task.setCreatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			task.setUpdatedOn(LocalDate.now().toString());
			task.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			
			isInsert = taskDAO.insert(task);
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
