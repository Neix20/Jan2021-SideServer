<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Productline"%>
<%@ page import="Utilities.html_generator"%>
<%  
List<Productline> list = (List<Productline>) request.getAttribute("List");
List<Productline> SearchResult = (List<Productline>) request.getAttribute("SearchResult");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Line Debug Website</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<script src="js/bootstrap.bundle.js"></script>
<script src="js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<div class="h1">Product Line Debugging</div>
	<hr />

	<!--Implement Basic CURDS Function-->
	<div class="h3">View All Product Line</div>

	<div class="d-flex align-items-center justify-content-center">
		<table class="table table-striped table-bordered text-center">
			<thead>
				<tr class="bg-dark">
					<th colspan="2" style="color: white;">Product Line</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Product Line Name</td>
					<td>Text Description</td>
				</tr>
				<%
            	String table_row_html;
            	for(Productline pl : list){
            		table_row_html = "<tr>";
            		table_row_html += html_generator.table_column(pl.getProductline());
            		table_row_html += html_generator.table_column(pl.getTextdescription());
            		table_row_html += "</tr>";
            		out.println(table_row_html);
            	}
            %>
			</tbody>
		</table>
	</div>
	<div class="h3">Search Product Line</div>
	<form action="ProductlineServlet" method="get">
		<input type="text" name="keyword" />
		<input type="submit" value="Submit" />
	</form>
	<div id="search_table">
		<%
	String table_html = "<table class=\"table table-striped table-bordered text-center\" width=\"800px;\"><thead><tr class=\"bg-dark\"><th colspan=\"2\" style=\"color:white;\">Product Line</th></tr></thead><tbody><tr><td>Product Line Name</td><td>Text Description</td></tr>";
	for(Productline pl : SearchResult){
		table_row_html = "<tr>";
		table_row_html += html_generator.table_column(pl.getProductline());
		table_row_html += html_generator.table_column(pl.getTextdescription());
		table_row_html += "</tr>";
		table_html += table_row_html;
	}
	table_html += "</tbody></table>";
	if(!SearchResult.isEmpty()) out.println("<script> $(function() { $(\"#search_table\").append(`" + table_html + "`); }); </script>");
	%>
	</div>
	<div class="h3">Add New Product Line</div>
	<form action="ProductlineServlet" method="post">
		<table class="table" style="width: 400px;">
			<tbody>
				<tr>
					<td><label for="productline">Name: </label></td>
					<td><input type="text" name="productline" /></td>
				</tr>
				<tr>
					<td><label for="textdescription">Description: </label></td>
					<td><input type="text" name="textdescription" /></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" name="type" value="ADD" />
	</form>
	<div class="h3">Update Existing Product Line</div>
	<form action="ProductlineServlet" method="post">
		<table class="table" style="width: 400px;">
			<tbody>
				<tr>
					<td><label for="productline">Name: </label></td>
					<td><select name="productline">
							<% for(Productline pl : list) out.println("<option value=\"" + pl.getProductline() + "\">"+pl.getProductline()+"</option>"); %>
					</select></td>
				</tr>
				<tr>
					<td><label for="textdescription">Description: </label></td>
					<td><input type="text" name="textdescription" /></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" name="type" value="UPDATE" />
	</form>
	<div class="h3">Delete Existing Product Line</div>
	<form action="ProductlineServlet" method="post">
		<table class="table" style="width: 400px;">
			<tbody>
				<tr>
					<td><label for="productline">Name: </label></td>
					<td><select name="productline">
							<% for(Productline pl : list) out.println("<option value=\"" + pl.getProductline() + "\">"+pl.getProductline()+"</option>"); %>
					</select></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" name="type" value="DELETE" />
	</form>
</body>
</html>