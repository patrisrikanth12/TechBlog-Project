package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.patrisrikanth.techblog.dao.BlogPostDao;
import com.patrisrikanth.techblog.entities.BlogPost;
import com.patrisrikanth.techblog.entities.Message;
import com.patrisrikanth.techblog.entities.User;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;

public class AddBlogPostServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		int categoryId = Integer.parseInt(request.getParameter("category"));
		User currentUser =  (User) request.getSession().getAttribute("current_user");
		int uid = currentUser.getId();
		
		BlogPost post = new BlogPost(categoryId, uid, title, body);
		BlogPostDao blogPostDao = new BlogPostDao(new ConnectionProvider().getConnection());
		boolean execStatus = blogPostDao.saveBlogPost(post);
		if(execStatus) {
			Message message = new Message("Successfully added the BlogPost", "info", "alert-success");
			HttpSession session = request.getSession();
			session.setAttribute("message", message);
		} else {
			Message message = new Message("Something went wrong... Please try again", "error", "alert-danger");
			HttpSession session = request.getSession();
			session.setAttribute("message", message);
		}
		
		response.sendRedirect("add-blogpost.jsp");
	}

}
