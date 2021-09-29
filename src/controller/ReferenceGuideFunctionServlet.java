package controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.ReferenceGuideFunctions;
import bean.User;
import model.ReferenceGuideFunctionDAO;

@WebServlet("/ReferenceGuideFunctionServlet")
public class ReferenceGuideFunctionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private boolean isInsert;
	private boolean isUpdate;
	private ReferenceGuideFunctionDAO referenceGuideFunctionDAO;
	private HttpSession session;
       
    public ReferenceGuideFunctionServlet() {
        super();
        isInsert = false;
        isUpdate = false;
        referenceGuideFunctionDAO = new ReferenceGuideFunctionDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		try {
			session = request.getSession();
			String functionId = request.getParameter("hiddenId");
			String isTelium = request.getParameter("isTelium");
			String isTetra = request.getParameter("isTetra");
			String type = request.getParameter("radioType");

			if(functionId == "") {
				// INSERT
				
				ReferenceGuideFunctions referenceGuideFunctions = new ReferenceGuideFunctions();
				referenceGuideFunctions.setName(request.getParameter("name"));
				referenceGuideFunctions.setShort_solution(request.getParameter("solution"));
				if(isTelium != null) referenceGuideFunctions.setIs_telium(true); else referenceGuideFunctions.setIs_telium(false);
				if(isTetra != null) referenceGuideFunctions.setIs_tetra(true); else referenceGuideFunctions.setIs_tetra(false); 
				if(type.equals("FUNCTION")) referenceGuideFunctions.setIs_function(true); else referenceGuideFunctions.setIs_function(false);
				if(type.equals("MENU")) referenceGuideFunctions.setIs_menu(true); else referenceGuideFunctions.setIs_menu(false);
				referenceGuideFunctions.setCreatedOn(LocalDate.now().toString());
				referenceGuideFunctions.setCreatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
				isInsert = referenceGuideFunctionDAO.insert(referenceGuideFunctions);
				
				if(isInsert) session.setAttribute("status", "insert");
				else session.setAttribute("status", "error");
			} else {
				// UPDATE
				
				ReferenceGuideFunctions referenceGuideFunctions = new ReferenceGuideFunctions();
				referenceGuideFunctions.setId(Integer.valueOf(functionId));
				referenceGuideFunctions.setName(request.getParameter("name"));
				referenceGuideFunctions.setShort_solution(request.getParameter("solution"));
				if(isTelium != null) referenceGuideFunctions.setIs_telium(true); else referenceGuideFunctions.setIs_telium(false);
				if(isTetra != null) referenceGuideFunctions.setIs_tetra(true); else referenceGuideFunctions.setIs_tetra(false); 
				if(type.equals("FUNCTION")) referenceGuideFunctions.setIs_function(true); else referenceGuideFunctions.setIs_function(false);
				if(type.equals("MENU")) referenceGuideFunctions.setIs_menu(true); else referenceGuideFunctions.setIs_menu(false);
				referenceGuideFunctions.setUpdatedOn(LocalDate.now().toString());
				referenceGuideFunctions.setUpdatedBy(new User(Integer.valueOf(session.getAttribute("userId").toString())));
				isUpdate = referenceGuideFunctionDAO.update(referenceGuideFunctions);
				
				if(isUpdate) session.setAttribute("status", "update");
				else session.setAttribute("status", "error");
				
			}
			
			response.sendRedirect("./Views/guide-functions.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("status", "ko");
			response.sendRedirect("./Views/guide-functions.jsp");
		}
	}

}
