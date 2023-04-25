package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import com.patrisrikanth.techblog.dao.UserDao;
import com.patrisrikanth.techblog.entities.User;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String about = request.getParameter("about");
		String check = request.getParameter("check");
		
		User user = new User(name, email, password, gender, about);
		
		Connection con = new ConnectionProvider().getConnection();
		
		UserDao userDao = new UserDao(con);
		
		boolean execStatus = userDao.saveUser(user);
		
		PrintWriter out = response.getWriter();
		
		if(!execStatus) {
			out.println("registation Failed");
		} else {
			out.println(name + " " + email + " " + password + " " + gender + " " + about + " " + check);
		}
	}

}
