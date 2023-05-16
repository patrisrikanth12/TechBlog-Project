<%@page import="com.patrisrikanth.techblog.entities.BlogPost"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.patrisrikanth.techblog.dao.BlogPostDao"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.patrisrikanth.techblog.helpers.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp"
	import="com.patrisrikanth.techblog.entities.User, 
				com.patrisrikanth.techblog.dao.UserDao, 
				java.sql.Connection, java.sql.Blob,
				java.io.File"%>
<%
User user = (User) session.getAttribute("current_user");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
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
</head>
<body>
	<%@ include file="navbar.jsp"%>

	<div class="container text-center">
		<div class="row">
			<div class="col-lg-5 col-md-6 col-sm-12 mt-3 ">
				<h2 class="mt-3">Profile Info</h2>
				<%
				Connection conn = new ConnectionProvider().getConnection();
				UserDao userDao = new UserDao(conn);
				Blob profilePhoto = userDao.getProfilePhoto(user.getId());
				if (profilePhoto != null) {
					byte[] bytes = profilePhoto.getBytes(1, (int) profilePhoto.length());
					try {
						var seperator = System.getProperty("file.separator");
						File imageFile = new File(session.getServletContext().getRealPath("/") + user.getId() + ".jpg");
						boolean isCreated = imageFile.createNewFile();
						if (isCreated) {
					FileOutputStream stream = new FileOutputStream(
							session.getServletContext().getRealPath("/") + user.getId() + ".jpg");
					stream.write(bytes);
					stream.close();
						} else {
					System.out.println("Profile photo already exists");
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					out.write("<h3> No profile photo available </h3>");
				}
				%>
				<img src="<%=user.getId()%>.jpg" alt="profile photo"
					style="max-width: 50%" />
				<table class="table mt-5">
					<tr>
						<td>name</td>
						<td><%=user.getName()%></td>
					</tr>
					<tr>
						<td>email</td>
						<td><%=user.getEmail()%></td>
					</tr>
					<tr>
						<td>Gender</td>
						<td><%=user.getGender()%></td>
					</tr>
					<tr>
						<td>About</td>
						<td><%=user.getAbout()%></td>
					</tr>
					<tr>
						<td>Registered on</td>
						<td><%=user.getRegDate()%></td>
					</tr>
				</table>
				<a href="edit-profile.jsp" class="btn btn-outline-primary">Edit
					Profile</a>
			</div>
			<div class="d-flex flex-column col-lg-7 col-md-6 col-sm-12 mt-3">
				<%
				ArrayList<BlogPost> posts = new ArrayList<BlogPost>();
				BlogPostDao blogPostDao = new BlogPostDao(new ConnectionProvider().getConnection());
				posts = blogPostDao.getPostsByUserId(user.getId());

				if (posts.size() != 0) {
					out.println("<h3 class=\"mt-1\"> Your Posts </h3> <p>" + posts.size() + " posts uploaded</p>");
					for (BlogPost post : posts) {
				%>
				<div class="card mb-1">
					<div
						class="card-body d-flex flex-row justify-content-between align-items-center ">
						<div class="d-flex flex-column align-items-start">
							<h3 class="card-title text-truncate"><%=post.getTitle()%></h3>
							<h6 class="card-subtitle text-muted mb-1 text-truncate"><%=post.getRegDate().toLocaleString()%></h6>
						</div>
						<a href="blogpost.jsp?id=<%=post.getId()%>"> <span
							class="material-symbols-outlined rounded border">
								chevron_right </span>
						</a>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<div class="d-flex flex-column my-3 align-items-center w-100">
					<img alt="no posts available" src="img/no-posts-available.svg"
						style="width: 60%">
					<h3 class="text-center my-3">No Posts Available</h3>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>