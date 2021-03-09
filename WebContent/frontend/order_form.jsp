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
<title>Bill Information</title>
<script>
// $(document).ready(function() {
// 		$('#payment_form').submit(function() {
// 				let chosenEmail = $("#sales_person_email").val();
// 				let obj = $("#sales_person_emails").find("option[value='" + modelname + "']");
// 				return obj != null && obj.length > 0;
// 		});
// });
</script>
</head>
<body>
<div class="panel panel-default">
	<div class="panel-heading">
		<h4 class="panel-title">
			<a class="collapsed" data-toggle="collapse" data-parent="#accordion"
				href="#collapseTwo"><i class="fa" aria-hidden="true"></i>Order Information</a>
		</h4>
	</div>
	<div id="collapseTwo" class="panel-collapse collapse">
		<div class="panel-body">
			<b>Help us keep your account safe and secure, please verify your billing
				information.</b>
			<br /><br />
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
				<input class="form-control" list="sales_person_emails" type="text" id="sales_person_email" name="sales_person_email">
				<datalist id="sales_person_emails">
					<%
					for (String employeeEmail : employeeEmails) {
						out.print("<option value='"+employeeEmail+"'>");
					}
					%>
				</datalist>
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
</div>
</body>
</html>