<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>Login page</title>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-sm-12 col-md-6 col-lg-4 border p-4 rounded">
				<form action="LoginServlet" method="POST">
					<h1 class="text-center mb-2">Login Page</h1>
					<p id="display-msg"></p>
					<div class="p-1 mb-2">
						<label for="email" class="form-label">Email</label><br> <input
							type="text" class="form-control" id="email" name="email"
							placeholder="Enter Email Address" />
					</div>
					<div class="p-1 mb-3">
						<label for="password" class="form-label">Password</label><br>
						<input type="password" class="form-control" id="password"
							name="password" placeholder="Enter Password" />
					</div>
					<div class="d-flex flex-column justify-content-center">
						<button class="btn btn-primary" type="submit">Login</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>