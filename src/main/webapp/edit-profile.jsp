<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.patrisrikanth.techblog.entities.*" %>
    
<% 

	User user = null;

	if(session.getAttribute("current_user") != null) {
		user = (User)session.getAttribute("current_user");
	} else {
		response.sendRedirect("login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Profile Page</title>
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
</head>
<body>
	<%@ include file="navbar.jsp" %>
	
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-sm-12 col-md-6 col-lg-4 border p-4 rounded">
				<form id="form" action="EditProfileServlet" method="POST">
					<h1 class="text-center mb-2">Profile Edit Page</h1>
					<% 
					
					Message message =(Message)session.getAttribute("message");
						
					if(message != null) { %>
						<p class="alert <%= message.getCssClass() %>"><%= message.getData() %> </p>
					<% 
						session.removeAttribute("message");
					} 
					%>
					<div class="form-group mb-2" >
						<label for="name">User Name</label> <input name="name"
							type="text" class="form-control" id="name"
							aria-describedby="emailHelp" placeholder="Enter name" value="<%= user.getName() %>">
					</div>
					<div class="form-group mb-2">
						<label for="email">Email address</label> <input
							name="email" type="email" class="form-control"
							id="email" aria-describedby="emailHelp"
							placeholder="Enter email" value="<%= user.getEmail() %>"> 
					</div>
					<div class="form-group mb-2">
						<label for="password">Password</label> <input
							name="password" type="text" class="form-control"
							id="password" aria-describedby="emailHelp"
							placeholder="Enter new Password" value="<%= user.getPassword() %>"> 
					</div>
					<div class="form-group mb-2">
						<label for="gender">Select Gender</label> <br> 
						<input type="radio" name="gender" value="male" >Male 
						<input type="radio" name="gender" value="female">Female 
					</div>
					<div class="form-group mb-2">
						<textarea name="about" class="form-control" id="about" rows="5"
							placeholder="Enter something about yourself"><%= user.getAbout() %></textarea>
					</div>
					<br>
					<div class="container text-center mb-2" id="loader"
						style="display: none;">
						<div class="spinner-border" role="status">
							<span class="visually-hidden">Loading...</span>
						</div>
						<h4>Please wait..</h4>
					</div>
					<button id="sumbimt-btn" type="submit" class="btn btn-primary mb-2">Save</button>
				</form>
			</div>
		</div>
	</div>
	<script>
// 	$(document).ready(function() {
// 		$("#form").on("submit" , function(event) {
// 			event.preventDefault();
// 			let form = new FormData(this);
// 			$("#loader").show();
// 			$.ajax({
// 				url:"EditProfileServlet",
// 				type: "POST",
// 				data: form,
// 				success: function (data, statusText, jqXhr) {
// 					console.log(data);
// 					$("#loader").hide();
// 				},
// 				error: function (jqXhr, statusText, errorThrown) {
// 					$("#loader").hide();
// 					 console.log(jqXhr);
// 				},
// 				processData: false,
// 				contentType: false 
// 			})
// 		})
// 	})
	</script>
</body>
</html>