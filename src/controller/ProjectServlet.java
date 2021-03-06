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
import bean.User;
import model.ProjectDAO;
import model.ProjectTeamDAO;

/**
 * Servlet implementation class ProjectServlet
 */
@WebServlet("/ProjectServlet")
public class ProjectServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private boolean isInsert;
	private ProjectDAO projectDAO;
	private ProjectTeamDAO projectTeamDAO;
    private HttpSession session;
       
    public ProjectServlet() {
        super();
        isInsert = false;
        projectDAO = new ProjectDAO();
        projectTeamDAO = new ProjectTeamDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			System.err.println(request.getParameter("editProjectId"));
			if(request.getParameter("editProjectId") != null) {
				update(request, response);
			} else {
				insert(request, response);
			}
			
		} catch (Exception e) {
			session.setAttribute("status", "ko");
			response.sendRedirect("./Views/projects.jsp");
		}
	}
	
	private void insert(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
			session = request.getSession();
			
			Project project = new Project();
			project.setName(request.getParameter("projectName"));
			
			Department department = new Department();
			department.setId(Integer.valueOf(request.getParameter("projectDepartment").toString()));
			
			project.setDepartment(department);
			project.setDescription(request.getParameter("projectDescription"));
			project.setCreatedOn(LocalDate.now().toString());
			project.setCreatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			project.setUpdatedOn(LocalDate.now().toString());
			project.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			
			ResultSet projectRS = projectDAO.insert(project);
			if(projectRS != null && projectRS.next()) {
				
				project.setId(Integer.valueOf(projectRS.getString(1)));
				
				String[] team = {};
				/** Pick members upon department */
				if(department.getId() == 1)
					team = request.getParameterValues("projectGeneralTeam");
				else
					team = request.getParameterValues("projectDepartmentTeam");
					
				for (String member : team) {
					ProjectTeam projectTeam = new ProjectTeam();
					projectTeam.setProject(project);
					projectTeam.setTeamMember(new User(Integer.valueOf(member)));
					
					isInsert = projectTeamDAO.insert(projectTeam);
					if(isInsert) 
						session.setAttribute("status", "insert");
					else
						session.setAttribute("status", "error");
				}
			}
			
			response.sendRedirect("./Views/projects.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("status", "ko");
			response.sendRedirect("./Views/projects.jsp");
		}
	}

	private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		try {
			session = request.getSession();
			
			Project project = new Project();
			project.setId(Integer.valueOf(request.getParameter("editProjectId")));
			project.setName(request.getParameter("projectName"));
			
			Department department = new Department();
			department.setId(Integer.valueOf(request.getParameter("projectDepartment").toString()));
			
			project.setDepartment(department);
			project.setDescription(request.getParameter("projectDescription"));
			project.setUpdatedOn(LocalDate.now().toString());
			project.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
			
			ResultSet projectRS = projectDAO.update(project);
			projectTeamDAO.resetProjectTeam(project);
			
			if(projectRS != null) {
				
				String[] team = {};
				/** Pick members upon department */
				if(department.getId() == 1)
					team = request.getParameterValues("projectGeneralTeam");
				else
					team = request.getParameterValues("projectDepartmentTeam");
				
				for (String member : team) {
					ProjectTeam projectTeam = new ProjectTeam();
					projectTeam.setProject(project);
					projectTeam.setTeamMember(new User(Integer.valueOf(member)));
					
					isInsert = projectTeamDAO.insert(projectTeam);
					if(isInsert) 
						session.setAttribute("status", "insert");
					else
						session.setAttribute("status", "error");
				}
			}
			
			response.sendRedirect("./Views/tasks.jsp?project=" + Base64.getEncoder().encodeToString(request.getParameter("editProjectId").getBytes()));
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("status", "ko");
			response.sendRedirect("./Views/tasks.jsp?project=" + Base64.getEncoder().encodeToString(request.getParameter("editProjectId").getBytes()));
		}
	}
}
