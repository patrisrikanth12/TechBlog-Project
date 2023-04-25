package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import com.patrisrikanth.techblog.dao.UserDao;
import com.patrisrikanth.techblog.entities.User;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;

public class LoginServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		Connection con = new ConnectionProvider().getConnection();
		UserDao userDao = new UserDao(con);
		
		User user = userDao.getUserByEmailAndPassword(email, password);
		
		if(user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("current_user", user);
			response.sendRedirect("profile.jsp");
		} else {
			PrintWriter out = response.getWriter();
			out.println("Invalid Details... please try again");
		}
	}

}
