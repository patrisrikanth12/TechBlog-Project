<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.patrisrikanth.techblog.entities.User" %>
<% 
	User nb_user = null;
	if(session.getAttribute("current_user") != null) {
		nb_user = (User)session.getAttribute("current_user");
	}
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container">
		<a class="navbar-brand" href="index.jsp"><span
			class="material-symbols-outlined">computer</span> TechBlog</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Categories </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">Programming
								Languages</a></li>
						<li><a class="dropdown-item" href="#">Data Structures and
								Algorithms</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#">Development</a></li>
					</ul></li>
			</ul>
		</div>
		<ul class="navbar-nav mr-right">
				<% if (nb_user == null) { %>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="login.jsp">Login</a></li>
				<% } else { 
				%>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="profile.jsp"><%= nb_user.getName() %></a></li>
				<li class="nav-item"><a class="nav-link active"
					aria-current="page" href="LogoutServlet">Logout</a></li>
				<% } %>
			</ul>
	</div>
</nav>