<%--
Author	  : Yap Jheng Khin
Page info : 'Order form' section of the checkout page
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%
List<String> employeeEmails = (List<String>) request.getAttribute("employee_emails");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Bill Information</title>
</head>
<body>
<div class="panel panel-default">
	<div class="panel-heading">
		<h4 class="panel-title">
			<a class="collapsed" data-toggle="collapse" data-parent="#accordion"
				href="#collapseTwo"><i class="fa icon-change" aria-hidden="true"></i>Order Information</a>
		</h4>
	</div>
	<!-- ============================================================== -->
	<!-- Order form (a.k.a. customer information) -->
	<!-- ============================================================== -->
	<div id="collapseTwo" class="panel-collapse collapse">
		<div class="panel-body">
			<div class="form-group">
				<label for="customername">Customer name:</label>
				<input class="form-control" type="text" id="customername" name="customername" required>
			</div>
			<div class="form-group">
				<label for="contact_firstname">Contact first name:</label>
				<input class="form-control" type="text" id="contact_firstname" name="contact_firstname" required>
			</div>
			<div class="form-group">
				<label for="contact_lastname">Contact last name:</label>
				<input class="form-control" type="text" id="contact_lastname" name="contact_lastname" required>
			</div>
			<div class="form-group">
				<label for="phone">Phone:</label>
				<input class="form-control" type="text" id="phone" name="phone" required>
			</div>
			<div class="form-group">
				<label for="email">Email:</label>
				<input class="form-control" type="email" id="email" name="email" required>
				<small id="emailHelp" class="form-text text-muted">
				Make sure that your email matches with the company's email. We will update the 
				customer information in the database accordingly.
				</small>
			</div>
			<div class="form-group">
				<label for="addressline1">Address line 1:</label>
				<input class="form-control" type="text" id="addressline1" name="addressline1" required>
			</div>
			<div class="form-group">
				<label for="addressline2">Address line 2:</label>
				<input class="form-control" type="text" id="addressline2" name="addressline2">
			</div>
			<div class="form-group">
				<label for="city">City:</label>
				<input class="form-control" type="text" id="city" name="city" required>
			</div>
			<div class="form-group">
				<label for="state">State:</label>
				<input class="form-control" type="text" id="state" name="state">
			</div>
			<div class="form-group">
				<label for="postalcode">Postal code:</label>
				<input class="form-control" type="text" id="postalcode" name="postalcode">
			</div>
			<div class="form-group">
				<label for="country">Country:</label>
				<input class="form-control" type="text" id="country" name="country" required>
			</div>
			<div class="form-group">
				<label for="sales_person_email">Sales person email address:</label>
				<select id="sales_person_email" class="form-control" class="sales_person_email" required>
					<option value="" selected>Select your sales representative</option>
					<%
					for (String employeeEmail : employeeEmails) {
						out.print("<option value='"+employeeEmail+"'>"+employeeEmail+"</option>");
					}
					%>
				</select>
			</div>
			<div class="form-group">
				<label for="required_date">Required date:</label>
				<input class="form-control" type="date" id="required_date" name="required_date" required>
				<small id="required_dateHelp" class="form-text text-muted">
				Make sure that your required date should be reasonable and agreed by your appointed sales person.
				</small>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- End order form -->
	<!-- ============================================================== -->
</div>
</body>
</html>