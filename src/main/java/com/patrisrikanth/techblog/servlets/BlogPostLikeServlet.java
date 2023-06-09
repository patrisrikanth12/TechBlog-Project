package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.patrisrikanth.techblog.dao.LikeDao;
import com.patrisrikanth.techblog.helpers.ConnectionProvider;


public class BlogPostLikeServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pid = Integer.parseInt(request.getParameter("pid"));
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		boolean execStatus = false;
		
		LikeDao likeDao = new LikeDao(new ConnectionProvider().getConnection());
		boolean isLiked = likeDao.isLikedByUser(pid, uid);
		if(isLiked) {
			execStatus = likeDao.deleteLike(pid, uid);
			isLiked = false;
		} else {
			 execStatus = likeDao.insertLike(pid, uid);
			 isLiked = true;
		}
		PrintWriter out = response.getWriter();
		if(execStatus) {
			response.setContentType("application/json");
			out.println("{ \"isLiked\": " + isLiked + " , \"count\": " + likeDao.countLikes(pid) + " }" );
		} else {
			response.setStatus(500);
			out.println("failed");
		}
	}

}
