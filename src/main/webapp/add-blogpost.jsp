<%@page import="com.patrisrikanth.techblog.entities.Message"%>
<%@page import="com.patrisrikanth.techblog.entities.Category"%>
<%@page import="com.patrisrikanth.techblog.helpers.ConnectionProvider"%>
<%@page import="com.patrisrikanth.techblog.dao.BlogPostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New BlogPost</title>
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
	<%@ include file="navbar.jsp" %>
	
	<div class="container">
		<div class="row">
			<div class="col-lg-5 col-md-5 col-sm-12">
				<form action="AddBlogPostServlet" method="POST" class="my-5 p-3">
					<h1 class="text-center my-3">Add BlogPost</h1>
					<% 
						Message msg = (Message) session.getAttribute("message");
						if(msg != null) { 
					%>
						<div class="alert <%= msg.getCssClass() %>"><%= msg.getData() %></div>
					<%
						session.removeAttribute("message");
						}
					%>
					<div class="form-group mb-3">
						<select name="category" class="form-control">
							<option selected="selected">--- select category ---</option>
							<% 
								BlogPostDao blogPostDao = new BlogPostDao(new ConnectionProvider().getConnection());
								for(Category category: blogPostDao.getAllCategories()) {
							%>
								<option value="<%=category.getId()%>"><%= category.getCategory() %></option>
							<% } %>
						</select>
					</div>
					<div class="form-group mb-3">
						<label class="form-label" for="title">Enter Title</label>
						<input type="text" name="title" id="title" class="form-control" />
					</div>
					<div class="form-group mb-3">
						<label class="form-label" for="body">BlogPost Content Here (Write in <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet" target="_blank">MarkDown</a>)</label>
						<textarea name="body" id="body-text" class="form-control" rows="10"></textarea>
					</div>
					<div class="text-center mb-3">
						<button class="btn btn-primary">Add BlogPost</button>
					</div>
				</form>
			</div>
				<div class="col-lg-5 col-md-5 col-sm-12 my-5 p-3">
					<h3>Preview</h3>
					<div id="preview" class="card p-3">
						
					</div>
				</div>
		</div>
	</div>
</body>

<script>
	const previewEl = document.getElementById("preview");
	const bodyTextEl = document.getElementById("body-text");
	
	bodyTextEl.addEventListener("input" ,function(e) {
		console.log("text changed");
		const xhr = new XMLHttpRequest();
		
		xhr.open("POST", "MarkDownPreviewServlet", true);
		xhr.onload = function() {
			if(this.status == 200) {
				previewEl.innerHTML = this.responseText;
				console.log(this.responseText);
			} else {
				console.log(this.responseText);
			}
		} 
		
		const md = {
			markdown: bodyTextEl.value
		}
		
		let data = new URLSearchParams(Object.entries(md)).toString();
		
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		
		xhr.send(data);
	})
</script>

</html>