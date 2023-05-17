package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;

import com.patrisrikanth.techblog.dao.BlogPostDao;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;

public class DeletePostServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pid = Integer.parseInt(request.getParameter("pid"));
		BlogPostDao blogPostDao = new BlogPostDao(new ConnectionProvider().getConnection());
		boolean execStatus = blogPostDao.deletePostById(pid);
		if(execStatus) {
			response.sendRedirect("index.jsp");
		} else {
			response.sendError(400, "Something went wrong");
		}
	}
		
}
