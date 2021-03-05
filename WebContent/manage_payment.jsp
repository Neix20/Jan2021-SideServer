<%@page import="java.util.List"%>
<%@page import="domain.Payment"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment Management</title>
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
	<%
	int currentPage = (int) request.getAttribute("currentPage");
	int recordsPerPage = (int) request.getAttribute("recordsPerPage");
	int nOfPages = (int) request.getAttribute("nOfPages");
	String keyword = (String) request.getAttribute("keyword");
	%>
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
				<th>Check no</th>
				<th>Amount</th>
				<th>Payment date</th>
				<th>Payment method</th>
			</tr>
			<%
			List<Payment> payments = (List<Payment>) request.getAttribute("payments");
			
			if (payments.size() != 0) {
			for (Payment payment : payments) {
				
				out.println("<tr>");
				
				Integer customernumber = payment.getId().getCustomernumber();
				String checknumber = payment.getId().getChecknumber();
				
			    out.println("<td>" + customernumber + "</td>");
			    out.println("<td>" + checknumber + "</td>");
			    out.println("<td>" + payment.getAmount() + "</td>");
			    out.println("<td>" + payment.getPaymentdate() + "</td>");
			    out.println("<td>" + payment.getPaymentmethod() + "</td>");
			    
			    String href = "'PaymentServlet?customernumber="+customernumber+"&checknumber="+checknumber+"'";
				out.println("<td><a href="+href+">Update</a></td>");
				out.println("<td><a href="+href+">Delete</a></td>");
				
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
	<nav aria-label="Navigation for payments">
		<ul class="pagination">
			<%
			if (currentPage != 1 && nOfPages != 0) {
			%>
			<%
			out.println("<li class=\"page-item\">");
			out.println("<a class=\"page-link\" href=\"" + "PaymentPagination?recordsPerPage=" + recordsPerPage
					+ "&currentPage=1" + "&keyword=" + keyword +
					"\">First</a>");
			out.println("</li>");
			%>
			<li class="page-item">
				<%
				out.println("<a class=\"page-link\" href=\"" + "PaymentPagination?recordsPerPage=" + recordsPerPage
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
				out.println("<a class=\"page-link\" href=\"" + "PaymentPagination?recordsPerPage=" + recordsPerPage
				+ "&currentPage=" + (currentPage + 1) +
				"&keyword=" + keyword + "\">Next</a>");
				out.println("</li>");
				out.println("<li class=\"page-item\">");
				out.println("<a class=\"page-link\" href=\"" + "PaymentPagination?recordsPerPage=" + recordsPerPage
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
		<form action="PaymentServlet" class="form-container" method="post">
			<h1>Add Payment Details</h1>
			<label for="customernumber">Customer no:</label><br>
			<input type="number" id="customernumber" name="customernumber" min="0" required><br>
	        <label for="checknumber">Check no:</label><br>
	        <input type="text" id="checknumber" name="checknumber" required><br>
			<label for="amount">Amount:</label><br>
			<input type="number" id="amount" name="amount" step="0.01" min="0" required><br>
			<label for="paymentdate">Payment date:</label><br>
			<input type="date" id="paymentdate" name="paymentdate" required><br>
			<label for="paymentmethod">Payment method:</label><br>
	        <select name="paymentmethod" id="paymentmethod" required>
			  <option value="check">Check</option>
			  <option value="cash">Cash</option>
			  <option value="debit card">Debit card</option>
			  <option value="credit card">Credit card</option>
			  <option value="online banking">Online banking</option>
			</select>
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