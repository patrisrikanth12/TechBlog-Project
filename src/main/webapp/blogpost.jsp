<%@page import="com.patrisrikanth.techblog.helpers.MdToHtmlConverter"%>
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
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
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
				<h4>Title: <%=post.getTitle()%></h4> 
				<div class="d-flex flex-row justify-content-between mb-3">
					<p class="text-muted"><%=post.getRegDate().toLocaleString()%></p>
					
					<% 
						Connection conn = new ConnectionProvider().getConnection();
						UserDao userDao = new UserDao(conn);
						LikeDao likeDao = new LikeDao(conn);
					%>
					<p> <%= userDao.getUserById(post.getUid()).getName() %> </p>
				</div>
				<hr>
				<p>
					<%= MdToHtmlConverter.convert(post.getBody()) %>
				</p>
				<div>
						<i id="like-btn" class="bi <%= likeDao.isLikedByUser(post.getId(), user.getId()) ? "bi-hand-thumbs-up-fill" : "bi-hand-thumbs-up" %>"></i>
						<span id="likes-count"><%= likeDao.countLikes(post.getId()) %></span>
				</div>
			</div>
		</div>
	</div>
	<script>
		const likeBtn = document.getElementById("like-btn");
		const likesCount = document.getElementById("likes-count");
		
		likeBtn.addEventListener("click", function() {
			console.log("clicked like btn");
			const xhr = new XMLHttpRequest();
			
			xhr.open("POST", "BlogPostLikeServlet" , true);
			
			
			xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			
			xhr.onprogress = function() {
				console.log("on progres ..");
			}
			
			xhr.onload = function() {
				console.log(this.responseText);
				const response = JSON.parse(this.responseText);
				const isLiked = response.isLiked;
				const count = response.count;
				console.log(response);
				
				if(isLiked) {
					likeBtn.classList.remove("bi-hand-thumbs-up");
					likeBtn.classList.add("bi-hand-thumbs-up-fill");
				} else {
					likeBtn.classList.remove("bi-hand-thumbs-up-fill");
					likeBtn.classList.add("bi-hand-thumbs-up");
				}
				
				likesCount.innerText = count;
			}
			
			const data = "pid=<%= post.getId() %>&uid=<%= user.getId() %>";
			
			xhr.send(data);
		})
		
	</script>
</body>
</html>


