package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import model.UserDAO;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private boolean isUpdate;
    private UserDAO userDAO;
    private HttpSession sessionStatus;
	
    public UserServlet() {
        super();
        isUpdate = false;
        userDAO = new UserDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			sessionStatus = request.getSession();
			
			User user = new User();
			user.setId(Integer.valueOf(request.getParameter("userId").toString()));
			user.setName(request.getParameter("userName").toString());
			user.setEmail(request.getParameter("userEmail").toString());
			user.setTheme(request.getParameter("userTheme").toString());
			user.setPass(request.getParameter("userPassword").toString());
			
			isUpdate = userDAO.update(user);

			if(isUpdate) {
				sessionStatus.setAttribute("status", "update");
				response.sendRedirect("./");
			} else {
				sessionStatus.setAttribute("status", "error");
				response.sendRedirect("./Views/profile.jsp");
			}
			
		} catch (Exception e) {
			sessionStatus.setAttribute("status", "ko");
			response.sendRedirect("./Views/profile.jsp");
		}
		
		
	}
}
