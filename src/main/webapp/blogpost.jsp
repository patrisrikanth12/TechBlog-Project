<%@page import="java.sql.Connection"%>
<%@page import="com.patrisrikanth.techblog.dao.LikeDao"%>
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
	<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
	crossorigin="anonymous"></script>
</head>
<body>
	<%@include file="navbar.jsp"%>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-6 col-md-8 col-sm-12 mt-3">
				<h1><%=post.getTitle()%></h1> 
				<div class="d-flex flex-row justify-content-between mb-3">
					<p class="text-muted"><%=post.getRegDate().toLocaleString()%></p>
					
					<% 
						Connection conn = new ConnectionProvider().getConnection();
						UserDao userDao = new UserDao(conn);
						LikeDao likeDao = new LikeDao(conn);
					%>
					<p> <%= userDao.getUserById(post.getUid()).getName() %> </p>
				</div>
				<p>
					<%= post.getBody() %>
				</p>
				<div>
					<a href="" onclick="doLike(<%= post.getId()%>, <%= user.getId() %>)">
						<i class="bi <%= likeDao.isLikedByUser(post.getId(), user.getId()) ? "bi-hand-thumbs-up-fill" : "bi-hand-thumbs-up" %>"></i>
					</a><%= likeDao.countLikes(post.getId()) %>
				</div>
			</div>
		</div>
	</div>
	
	<script>
	function doLike(pid, uid) {
		 
		 const likeData = {
			 pid: pid,
			 uid: uid
		 }
		 
		 $.ajax({
				url:"BlogPostLikeServlet",
				type: "POST",
				data: likeData,
				success: function (data, statusText, jqXhr) {
					console.log(data);
				},
				error: function (jqXhr, statusText, errorThrown) {
					 console.log(jqXhr);
				},
			})
	 }  
	</script>
</body>
</html>