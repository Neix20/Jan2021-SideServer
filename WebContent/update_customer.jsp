<%@page import="domain.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update customer</title>
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
</head>
<body>
	<%
	Customer customer = (Customer) request.getAttribute("customer");
	%>
	<form action="CustomerServlet" method="post">
		<table>
			<tr>
				<td>
					<label for="customernumber">Customer number:</label><br>
				</td>
				<td>
					<input type="text" id="customernumber" name="customernumber" value=${ customer.customernumber } readonly required><br>
				</td>
			</tr>
			<tr>
		        <td>
		            <label for="customername">Customer name:</label><br>
		        </td>
		        <td>
		            <input type="text" id="customername" name="customername" value=${ customer.customername } required><br>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="contact_firstname">Contact first name:</label><br>
		        </td>
		        <td>
		            <input type="text" id="contact_firstname" name="contact_firstname" value=${ customer.contactfirstname } required><br>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="contact_lastname">Contact last name:</label><br>
		        </td>
		        <td>
		            <input type="text" id="contact_lastname" name="contact_lastname" value=${ customer.contactlastname } required>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="phone">Phone:</label><br>
		        </td>
		        <td>
		            <input type="text" id="phone" name="phone" value=${ customer.phone } required>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="email">Email:</label><br>
		        </td>
		        <td>
		            <input type="text" id="email" name="email" value=${ customer.email } required>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="addressline1">Address line 1:</label><br>
		        </td>
		        <td>
		            <input type="text" id="addressline1" name="addressline1" value=${ customer.addressline1 } required>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="addressline2">Address line 2:</label><br>
		        </td>
		        <td>
		            <input type="text" id="addressline2" name="addressline2" value=${ customer.addressline2 }>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="city">City:</label><br>
		        </td>
		        <td>
		            <input type="text" id="city" name="city" value=${ customer.city } required>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="state">State:</label><br>
		        </td>
		        <td>
		            <input type="text" id="state" name="state" value=${ customer.state }>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="postalcode">Postal code:</label><br>
		        </td>
		        <td>
		            <input type="text" id="postalcode" name="postalcode" value=${ customer.postalcode }>
		        </td>
		    </tr>
		    <tr>
		        <td>
		            <label for="country">Country:</label><br>
		        </td>
		        <td>
		            <input type="text" id="country" name="country" value=${ customer.country } required>
		        </td>
		    </tr>
		    <% //TODO How to link to employee? %>
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
		    <tr>
		        <td>
		            <label for="creditlimit">Credit limit:</label><br>
		        </td>
		        <td>
		            <input type="number" id="creditlimit" name="creditlimit" step="0.01" value=${ customer.creditlimit } min="0">
		        </td>
		    </tr>
		</table>
		<input type="submit" name="user_action" value="UPDATE">
		<input type="submit" name="user_action" value="DELETE">
	</form>
</body>
</html>