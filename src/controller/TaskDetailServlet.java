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
import bean.Task;
import bean.TaskDetail;
import bean.User;
import model.ProjectDAO;
import model.TaskDAO;
import model.TaskDetailDAO;

@WebServlet("/TaskDetailServlet")
public class TaskDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean isInsert;
	private boolean isUpdate;
	private TaskDetailDAO taskDetailDAO;
	private TaskDAO taskDAO;
	private HttpSession session;
       
    public TaskDetailServlet() {
        super();
        isInsert = false;
        isUpdate = false;
        taskDetailDAO = new TaskDetailDAO();
        taskDAO = new TaskDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			session = request.getSession();
			
			TaskDetail taskDetail = new TaskDetail();
			taskDetail.setTask(new Task(Integer.valueOf(request.getParameter("hiddenTaskId"))));
			taskDetail.setTaskDetailDate(request.getParameter("taskDetailDate"));
			taskDetail.setHours(request.getParameter("taskDetailHours"));
			taskDetail.setDescription(request.getParameter("taskDetailDescription"));
			taskDetail.setCreatedOn(LocalDate.now().toString());
			taskDetail.setCreatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			taskDetail.setUpdatedOn(LocalDate.now().toString());
			taskDetail.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
				
			isInsert = taskDetailDAO.insert(taskDetail);
			if(request.getParameterValues("taskIsCompleted") != null) { 
				
				Task task = new Task();
				task.setId(Integer.valueOf(request.getParameter("hiddenTaskId")));
				task.setIsCompleted(true);
				task.setUpdatedOn(LocalDate.now().toString());
				task.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
				
				isUpdate = taskDAO.isCompleted(task);
			}
			
			if(isInsert && isUpdate) session.setAttribute("status", "insert");
			else session.setAttribute("status", "error");
			
			response.sendRedirect("./Views/tasks.jsp?project=" + Base64.getEncoder().encodeToString(request.getParameter("hiddenProjectId").getBytes()));
			
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("status", "ko");
			response.sendRedirect("./Views/tasks.jsp?project=" + Base64.getEncoder().encodeToString(request.getParameter("hiddenProjectId").getBytes()));
		}
	}

}
