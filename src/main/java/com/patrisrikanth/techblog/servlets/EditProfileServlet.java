package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

import com.patrisrikanth.techblog.dao.UserDao;
import com.patrisrikanth.techblog.entities.User;
import com.patrisrikanth.techblog.entities.Message;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;

@MultipartConfig
public class EditProfileServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String about = request.getParameter("about");
		
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("current_user");
		
		user.setName(name);
		user.setEmail(email);
		user.setPassword(password);
		user.setGender(gender);
		user.setAbout(about);
		
		session.setAttribute("current_user", user);
		
		Connection con = new ConnectionProvider().getConnection();
		UserDao userDao = new UserDao(con);
		if(!userDao.updateUser(user)) {
			Message msg = new Message("Something went wrong... please try again!", "error", "alert-danger");
			session.setAttribute("message", msg);
			response.sendRedirect("edit-profile.jsp");
		} else {
			response.sendRedirect("profile.jsp");
		}
	}

}
