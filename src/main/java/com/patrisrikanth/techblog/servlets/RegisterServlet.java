package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.Set;

import jakarta.validation.constraints.*;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

import com.patrisrikanth.techblog.dao.UserDao;
import com.patrisrikanth.techblog.entities.Message;
import com.patrisrikanth.techblog.entities.User;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name").toLowerCase();
		String email = request.getParameter("email").toLowerCase();
		String password = request.getParameter("password");
		String gender = request.getParameter("gender");
		String about = request.getParameter("about");
		String check = request.getParameter("check");
		Part profilePhoto = request.getPart("profile-photo");
		
		User user = new User(name, email, password, gender, about, profilePhoto);
		
		Connection con = new ConnectionProvider().getConnection();
		
		UserDao userDao = new UserDao(con);
		
		ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
		Validator validator = factory.getValidator();
		Set<ConstraintViolation<User>> constraintViolations = validator.validate(user); 
		
		if(constraintViolations.isEmpty()) {
			boolean execStatus = userDao.saveUser(user);
			if(execStatus) {
				Message msg = new Message("Registration Successful", "info", "alert-info");
				HttpSession session = request.getSession();
				session.setAttribute("message", msg);
				response.sendRedirect("login.jsp");
			} else {
				Message msg = new Message("Something went wrong... please try again!", "error", "alert-danger");
				HttpSession session = request.getSession();
				session.setAttribute("message", msg);
				response.sendRedirect("register.jsp");
			}
		} else {
			for(ConstraintViolation<User> cv: constraintViolations) {
				System.out.println(cv.getMessage());
			}
		}
	}

}
