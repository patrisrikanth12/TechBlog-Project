<%@page import="com.patrisrikanth.techblog.dao.UserDao"%>
<%@page import="com.patrisrikanth.techblog.entities.BlogPost"%>
<%@page import="com.patrisrikanth.techblog.helpers.ConnectionProvider"%>
<%@page import="com.patrisrikanth.techblog.dao.BlogPostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>

<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	response.sendRedirect("login.jsp");
}

BlogPostDao blogPostDao = new BlogPostDao(new ConnectionProvider().getConnection());
int postId = Integer.parseInt(request.getParameter("id"));
BlogPost post = blogPostDao.getPostById(postId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=post.getTitle()%></title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body>
	<%@include file="navbar.jsp"%>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-6 col-md-8 col-sm-12 mt-3">
				<h1><%=post.getTitle()%></h1> 
				<div class="d-flex flex-row justify-content-between mb-3">
					<p class="text-muted"><%=post.getRegDate().toLocaleString()%></p>
					
					<% UserDao userDao = new UserDao(new ConnectionProvider().getConnection());  %>
					<p> <%= userDao.getUserById(post.getUid()).getName() %> </p>
				</div>
				<p>
					<%= post.getBody() %>
				</p>
				<div class="d-flex flex-row">
					<i class="bi bi-hand-thumbs-up"></i>10 | <i class="bi bi-chat-left"></i>10
				</div>
			</div>
		</div>
	</div>
</body>
</html>