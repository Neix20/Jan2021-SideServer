<%@page import="domain.Payment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%
Payment payment = (Payment) request.getAttribute("payment");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update payment</title>
<style>
	table {
		font-family: arial, sans-serif;
		border-collapse: collapse;
		width: 100%;
	}
	
	td, th {
		border: 1px solid #dddddd;
		text-align: left;
		padding: 8px;
	}
	
	tr:nth-child(even) {
		background-color: #dddddd;
	}
</style>
<script>
	function setDropDownValue() {
		document.querySelector("#paymentmethod").value = '<%= payment.getPaymentmethod() %>';
	}
</script>
</head>
<body onload="setDropDownValue()">
	<form action="PaymentServlet" method="post">
		<table>
			<tr>
			    <td>
			        <label for="customernumber">Customer no:</label><br>
			    </td>
			    <td>
			        <input type="number" id="customernumber" name="customernumber" min="0" value=<%= payment.getId().getCustomernumber() %> readonly required><br>
			    </td>
			</tr>
			<tr>
			    <td>
			        <label for="checknumber">Check no:</label><br>
			    </td>
			    <td>
			        <input type="text" id="checknumber" name="checknumber" value=<%= payment.getId().getChecknumber() %> readonly required><br>
			    </td>
			</tr>
			<tr>
			    <td>
			        <label for="amount">Amount:</label><br>
			    </td>
			    <td>
			        <input type="number" id="amount" name="amount" step="0.01" min="0" value=${ payment.amount } required><br>
			    </td>
			</tr>
			<tr>
			    <td>
			        <label for="paymentdate">Payment date:</label><br>
			    </td>
			    <td>
			    	<%
			    		String paymentDateStr = payment.getPaymentdate();
			    		DateFormat dateFormat1 = new SimpleDateFormat("M/d/yyyy");
			    		Date paymentDate = dateFormat1.parse(paymentDateStr);
			    		DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
			    		paymentDateStr = dateFormat2.format(paymentDate);
			    	%>
			        <input type="date" id="paymentdate" name="paymentdate" value=<%= paymentDateStr %> required><br>
			    </td>
			</tr>
			<tr>
			    <td>
			        <label for="paymentmethod">Payment method:</label><br>
			    </td>
			    <td>
			        <select name="paymentmethod" id="paymentmethod" required>
					  <option value="check">Check</option>
					  <option value="cash">Cash</option>
					  <option value="debit card">Debit card</option>
					  <option value="credit card">Credit card</option>
					  <option value="online banking">Online banking</option>
					</select>
			    </td>
			</tr>
			<% //TODO How to link to customer? %>
			<!-- 
			<tr>
			    <td>
			        <label for="salesrepemployeenumber">Sales person representative:</label><br>
			    </td>
			    <td>
			        <input type="text" id="salesrepemployeenumber" name="salesrepemployeenumber" value=${ customer.country }>
			    </td>
			</tr>
			 -->
		</table>
		<input type="submit" name="user_action" value="UPDATE">
		<input type="submit" name="user_action" value="DELETE">
	</form>
</body>
</html>