<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import = "domain.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Pagination</title>
</head>
<body>
<%
String test = (String) request.getAttribute("test");
out.println("<p>"+test+"</p>");

List<Product> list = (List<Product>) request.getAttribute("List");
for(Product p : list)
	out.println("<p>"+p.getProductname()+"</p>");
%>
</body>
</html>