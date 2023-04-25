<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" import="com.patrisrikanth.techblog.entities.User"%>
<% 

	User user = (User) session.getAttribute("current_user");
	if(user == null) {
		response.sendRedirect("login.jsp");
	} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile Page</title>
</head>
<body>
	<h1><%= user.getName() %></h1>
	<p><%= user.getEmail() %></p>
</body>
</html>