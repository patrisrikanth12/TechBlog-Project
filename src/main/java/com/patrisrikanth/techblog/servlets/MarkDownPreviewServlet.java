package com.patrisrikanth.techblog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.patrisrikanth.techblog.helpers.MdToHtmlConverter;


public class MarkDownPreviewServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String markdown = request.getParameter("markdown");
		System.out.println(markdown);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		if(markdown != null) {
			String html = MdToHtmlConverter.convert(markdown);
			out.print(html);
		} else {
			out.print("<h4>No Preview</h4>");
		}
		
		out.flush();
		out.close();
	}
}
