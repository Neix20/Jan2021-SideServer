<%@page import="java.util.List"%>
<%@page import="domain.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Management</title>
<style>
	body {
		font-family: Arial, Helvetica, sans-serif;
	}
	
	* {
		box-sizing: border-box;
	}
	/* Button used to open the contact form - fixed at the bottom of the page */
	.open-button {
		background-color: #555;
		color: white;
		padding: 16px 20px;
		border: none;
		cursor: pointer;
		opacity: 0.8;
		position: fixed;
		bottom: 23px;
		right: 28px;
		width: 280px;
	}
	/* The popup form - hidden by default */
	.form-popup {
		overflow-x: hidden;
		overflow-y: auto;
		height: 400px;
		display: none;
		position: fixed;
		top: 60%;
		left: 50%;
		-webkit-transform: translate(-50%, -50%);
		transform: translate(-50%, -50%);
	}
	/* Add styles to the form container */
	.form-container {
		max-width: 500px;
		padding: 10px;
		background-color: white;
	}
	/* Full-width input fields */
	.form-container input[type=text], .form-container input[type=password] {
		width: 100%;
		padding: 15px;
		margin: 5px 0 22px 0;
		border: none;
		background: #f1f1f1;
	}
	/* When the inputs get focus, do something */
	.form-container input[type=text]:focus, .form-container input[type=password]:focus
		{
		background-color: #ddd;
		outline: none;
	}
	/* Set a style for the submit button */
	.form-container .btn {
		background-color: #4CAF50;
		color: white;
		padding: 16px 20px;
		border: none;
		cursor: pointer;
		width: 100%;
		margin-bottom: 10px;
		opacity: 0.8;
	}
	/* Add a red background color to the cancel button */
	.form-container .cancel {
		background-color: red;
	}
	/* Add some hover effects to buttons */
	.form-container .btn:hover, .open-button:hover {
		opacity: 1;
	}
	
	.pageref {
		text-align: center;
		font-weight: bold;
	}
</style>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
>
</head>
<body class="m-3">
	<form class="form-inline md-form mr-auto mb-4"
		action="PaginationServlet" method="get"
	>
		<input class="form-control mr-sm-2" type="text" aria-label="Search"
			name="keyword"
		/>
		<button class="btn aqua-gradient btn-rounded btn-sm my-0 btn btn-info"
			type="submit"
		>Search</button>
		<input type="hidden" name="currentPage" value="<%=currentPage%>" /> <input
			type="hidden" name="recordsPerPage" value="<%=recordsPerPage%>"
		/>
	</form>
	<div class="row col-md-6">
		<table class="table table-striped table-bordered table-sm">
			<tr>
				<th>Customer no</th>
				<th>Name</th>
				<th>Contact first name</th>
				<th>Contact last name</th>
				<th>Phone</th>
				<th>Email</th>
				<th>Address line 1</th>
				<th>Address line 2</th>
				<th>City</th>
				<th>State</th>
				<th>Postal code</th>
				<th>Country</th>
				<th>Sales representative no</th>
				<th>Credit limit</th>
			</tr>
			<%
			int currentPage = (int) request.getAttribute("currentPage");
			int recordsPerPage = (int) request.getAttribute("recordsPerPage");
			int nOfPages = (int) request.getAttribute("nOfPages");
			String keyword = (String) request.getAttribute("keyword");

			List<Customer> customers = (List<Customer>) request.getAttribute("customers");
			
			if (customers.size() != 0) {
			for (Customer customer : customers) {
				out.println("<tr>");
			    out.println("<td>" + customer.getCustomernumber() + "</td>");
			    out.println("<td>" + customer.getCustomername() + "</td>");
			    out.println("<td>" + customer.getContactfirstname() + "</td>");
			    out.println("<td>" + customer.getContactlastname() + "</td>");
			    out.println("<td>" + customer.getPhone() + "</td>");
			    out.println("<td>" + customer.getEmail() + "</td>");
			    out.println("<td>" + customer.getAddressline1() + "</td>");
			    out.println("<td>" + customer.getAddressline2() + "</td>");
			    out.println("<td>" + customer.getCity() + "</td>");
			    out.println("<td>" + customer.getState() + "</td>");
			    out.println("<td>" + customer.getPostalcode() + "</td>");
			    out.println("<td>" + customer.getCountry() + "</td>");
			    //TODO  Link this employee to another page
			    out.println("<td>" + customer.getEmployee() + "</td>");
			    out.println("<td>" + customer.getCreditlimit() + "</td>");
			    //TODO Display payment record
			    // out.println("<td>" + customer.getPayments() + "</td>");
				out.println("<td><a href=\"CustomerServlet?id=" + customer.getCustomernumber() + "\">Update</a></td>");
				out.println("<td><a href=\"CustomerServlet?id=" + customer.getCustomernumber() + "\">Delete</a></td>");
				out.println("</tr>");
			}
			} else {
				out.println("<tr>");
				String status = "No records";
				for (int i = 0; i < 8; i++) {
					out.println("<td>" + status + "</td>");
				}
				out.println("</tr>");
			}
			%>
		</table>
	</div>
	<nav aria-label="Navigation for customers">
		<ul class="pagination">
			<%
			if (currentPage != 1 && nOfPages != 0) {
			%>
			<%
			out.println("<li class=\"page-item\">");
			out.println("<a class=\"page-link\" href=\"" + "CustomerPagination?recordsPerPage=" + recordsPerPage
					+ "&currentPage=1" + "&keyword=" + keyword +
					"\">First</a>");
			out.println("</li>");
			%>
			<li class="page-item">
				<%
				out.println("<a class=\"page-link\" href=\"" + "CustomerPagination?recordsPerPage=" + recordsPerPage
						+ "&currentPage=" + (currentPage - 1) +
						"&keyword=" + keyword + "\">Previous</a>");
				%>
			</li>
			<%
			}
			%>
			<%
			if (currentPage < nOfPages) {
				out.println("<li class=\"page-item\">");
				out.println("<a class=\"page-link\" href=\"" + "CustomerPagination?recordsPerPage=" + recordsPerPage
				+ "&currentPage=" + (currentPage + 1) +
				"&keyword=" + keyword + "\">Next</a>");
				out.println("</li>");
				out.println("<li class=\"page-item\">");
				out.println("<a class=\"page-link\" href=\"" + "CustomerPagination?recordsPerPage=" + recordsPerPage
				+ "&currentPage=" + nOfPages + "&keyword=" +
				keyword + "\">Last</a>");
				out.println("</li>");
			}
			%>
		</ul>
	</nav>
	<%
	if (nOfPages != 0) {
		out.println("<p class=\"pageref\">");
		out.println(currentPage + " of " + nOfPages);
		out.println("</p>");
	}
	%>
	<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
	></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"
	></script>
	<button class="open-button" onclick="openForm()">Open Form</button>
	<div class="form-popup" id="myForm">
		<form action="CustomerServlet" class="form-container" method="post">
			<h1>Add Customer Details</h1>
			<label for="customername">Contact first name:</label><br>
	        <input type="text" id="customername" name="customername" required><br>
	        <label for="contact_firstname">Contact first name:</label><br>
	        <input type="text" id="contact_firstname" name="contact_firstname" required><br>
	        <label for="contact_lastname">Contact last name:</label><br>
	        <input type="text" id="contact_lastname" name="contact_lastname" required>
	        <label for="phone">Phone:</label><br>
	        <input type="text" id="phone" name="phone" required>
	        <label for="email">Email:</label><br>
	        <input type="email" id="email" name="email" required><br>
	        <label for="addressline1">Address line 1:</label><br>
	        <input type="text" id="addressline1" name="addressline1" required>
	        <label for="addressline2">Address line 2:</label><br>
	        <input type="text" id="addressline2" name="addressline2">
	        <label for="city">City:</label><br>
	        <input type="text" id="city" name="city" required>
	        <label for="state">State:</label><br>
	        <input type="text" id="state" name="state">
	        <label for="postalcode">Postal code:</label><br>
	        <input type="text" id="postalcode" name="postalcode">
	        <label for="country">Country:</label><br>
	        <input type="text" id="country" name="country" required>
	        <label for="salesrepemployeenumber">Sales person representative:</label><br>
	        <input type="text" id="salesrepemployeenumber" name="salesrepemployeenumber">
	        <label for="creditlimit">Credit limit:</label><br>
	        <input type="number" id="creditlimit" name="creditlimit" step="0.01" min="0">
			<button type="submit" class="btn">Submit Test</button>
			<button type="button" class="btn cancel" onclick="closeForm()">Close</button>
			<button type="reset" class="btn">Reset</button>
			<input type="hidden" id="user_action" name="user_action" value="ADD">
		</form>
	</div>
	<script>
		function openForm() {
			document.getElementById("myForm").style.display = "block";
		}
		function closeForm() {
			document.getElementById("myForm").style.display = "none";
		}
	</script>
</body>
</html>