<%@page import="com.patrisrikanth.techblog.entities.BlogPost"%>
<%@page import="com.patrisrikanth.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.patrisrikanth.techblog.helpers.ConnectionProvider"%>
<%@page import="com.patrisrikanth.techblog.dao.BlogPostDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TechBlog</title>
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
<script src="https://code.jquery.com/jquery-3.6.4.js"
	integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="css/styles.css" />
<script type="text/javascript" src="js/script.js" defer></script>
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<main>
		<div class="container">
			<%
			if (session.getAttribute("current_user") == null) {
			%>
			<section class="hero-section py-5 m-0">
				<h1 class="text-center mb-3">Welcome to TechBlog</h1>
				<p class="text-center">The hassle-free blogging platform for
					engineers, thought-leaders, and the dev community!</p>
				<div class="d-flex flex-row justify-content-center mb-5">
					<a href="register.jsp" class="btn btn-outline-primary mx-3">Start
						for Free</a> <a href="login.jsp" class="btn btn-outline-primary">Login</a>
				</div>
			</section>
			<%
			} else {
			%>
			<section class="blogs-section row py-1 mt-3">
				<div class="col-lg-3 col-md-4 col-sm-12">
					<ul class="list-group">
						<li class="list-group-item  <%= (request.getParameter("cid") == null) ? "active" : " " %>">
							<a class="text-decoration-none <%= (request.getParameter("cid") == null) ? "text-white" : " " %>" href="index.jsp">All Posts</a>
						</li>
						<% 
							BlogPostDao blogPostDao = new BlogPostDao(new ConnectionProvider().getConnection());
							ArrayList<Category> categories = blogPostDao.getAllCategories();
							for(Category cat: categories) {
								int current_cid = 0;
								if(request.getParameter("cid") != null) {
									current_cid = Integer.parseInt(request.getParameter("cid"));
								}
						%>
						<li class="list-group-item <%= (current_cid == cat.getId()) ? "active" : " " %>">
							<a 
								class="text-decoration-none <%= (current_cid == cat.getId()) ? "text-white" : " " %>" 
								href="index.jsp?cid=<%= cat.getId() %>" > 
								<%= cat.getCategory() %> 
							</a>
						</li>
						<%
							}
						%>
					</ul>
				</div>
				<div class="col-lg-9 col-md-8 col-sm-12">
					<%	
						ArrayList<BlogPost> posts;
						 if(request.getParameter("cid") == null) {
							 posts = blogPostDao.getAllPosts();
						 } else {
							 int cid = Integer.parseInt(request.getParameter("cid"));
							 posts = blogPostDao.getPostsByCategory(cid);
						 }
						 
						 for(BlogPost post: posts) {
					%>
					<div class="card mb-1">
						<div class="card-body">
							<h3 class="card-title text-truncate"><%= post.getTitle() %></h3>
							<h6 class="card-subtitle text-muted mb-1 text-truncate"><%= post.getRegDate() %></h6> 
							<p class="card-text text-truncate"><%= post.getBody() %></p>
						</div>
					</div>
					<% 
						 }
					%>
				</div>
			</section>
			<% } %>
		</div>
	</main>
</body>
</html>