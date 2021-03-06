<%@page import="domain.Customer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update customer</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/fontawesome.min.css" 
	  	  integrity="sha512-shT5e46zNSD6lt4dlJHb+7LoUko9QZXTGlmWWx0qjI9UhQrElRb+Q5DM7SVte9G9ZNmovz2qIaV7IWv0xQkBkw=="
	  	  crossorigin="anonymous" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
		  integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
		  crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
			integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
			crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js" 
			integrity="sha512-hCP3piYGSBPqnXypdKxKPSOzBHF75oU8wQ81a6OiGXHFMeKs9/8ChbgYl7pUvwImXJb03N4bs1o1DzmbokeeFw==" 
			crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
			integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
			crossorigin="anonymous"></script>
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/customer-page.css">
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
	
	.scroll-bar {
	    max-height: 500px;
	    overflow-y: scroll;
	}
	
	button.btn, a.btn {
		box-sizing: border-box;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		min-width: 160px;
	}
</style>
<script>
$(document).ready(function () {
	


	$('#confirm-delete-btn').click(function(){
		
	    /* when the submit button in the modal is clicked, submit the form */
	    $('#customer-form').append($('<input>', {
	            type: 'hidden',
	            name: 'user_action',
	            value: 'DELETE'
	    }));

		$('#customer-form').submit();	  
	});
})
</script>
</head>
<body>
	<%
	Customer customer = (Customer) request.getAttribute("customer");
	%>
	<div class="container mx-5 my-3 w-75">
		<h1 class="text-center">
			Customer Details
			<span class="page-text font-weight-light small">${ customer.customernumber }</span>
		</h1>
		<form id="customer-form" action="CustomerServlet" class="p-3" method="post">
				<div class="row">
					<div class="col-9 table-wrapper scroll-bar">
						<div class="form-group">
						    <label for="customernumber">Customer no:</label>
						    <input class="form-control" type="text" id="customernumber" name="customernumber" value=${ customer.customernumber } readonly required>
						</div>
						<div class="form-group">
						    <label for="customername">Customer name:</label>
						    <input class="form-control" type="text" id="customername" name="customername" value=${ customer.customername } required>
						</div>
						<div class="form-group">
						    <label for="contact_firstname">Contact first name:</label>
						    <input class="form-control" type="text" id="contact_firstname" name="contact_firstname" value=${ customer.contactfirstname } required>
						</div>
						<div class="form-group">
						    <label for="contact_lastname">Contact last name:</label>
						    <input class="form-control" type="text" id="contact_lastname" name="contact_lastname" value=${ customer.contactlastname } required>
						</div>
						<div class="form-group">
						    <label for="phone">Phone:</label>
						    <input class="form-control" type="text" id="phone" name="phone" value=${ customer.phone } required>
						</div>
						<div class="form-group">
						    <label for="email">Email:</label>
						    <input class="form-control" type="email" id="email" name="email" value=${ customer.email } required>
						</div>
						<div class="form-group">
						    <label for="addressline1">Address line 1:</label>
						    <input class="form-control" type="text" id="addressline1" name="addressline1" value=${ customer.addressline1 } required>
						</div>
						<div class="form-group">
						    <label for="addressline2">Address line 2:</label>
						    <input class="form-control" type="text" id="addressline2" name="addressline2" value=${ customer.addressline2 }>
						</div>
						<div class="form-group">
						    <label for="city">City:</label>
						    <input class="form-control" type="text" id="city" name="city" value=${ customer.city } required>
						</div>
						<div class="form-group">
						    <label for="state">State:</label>
						    <input class="form-control" type="text" id="state" name="state" value=${ customer.state }>
						</div>
						<div class="form-group">
						    <label for="postalcode">Postal code:</label>
						    <input class="form-control" type="text" id="postalcode" name="postalcode" value=${ customer.postalcode }>
						</div>
						<div class="form-group">
						    <label for="country">Country:</label>
						    <input class="form-control" type="text" id="country" name="country" value=${ customer.country } required>
						</div>
						<!-- 
						<%//TODO Link sales person to Hui Kei's part%>
						<tr>
						    <td>
						        <label for="salesrepemployeenumber">Sales person representative:</label><br>
						    </td>
						    <td>
						        <input type="text" id="salesrepemployeenumber" name="salesrepemployeenumber" value=${ customer.country }>
						    </td>
						</tr>
						 -->
						<div class="form-group">
						    <label for="creditlimit">Credit limit:</label>
						    <input class="form-control" type="number" id="creditlimit" name="creditlimit" step="0.01" min="0" value="0" value=${ customer.creditlimit } >
					</div>
				</div>
				<div class="col-3 d-flex flex-column justify-content-around align-items-center">
					<button type="submit" name="user_action" value="UPDATE" class="btn btn-success d-flex justify-content-center align-items-center">
						<i class="material-icons mr-2">&#xE254;</i> <span>Update Customer</span>
					</button>
					<button id="delete-btn" type="button" name="user_action" value="DELETE" class="btn btn-danger d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#deleteCustomerModal">
						<i class="material-icons mr-2">&#xE872;</i>
						<span>Delete Customer</span>
					</button>
					<button id="cancel-btn" type="button" class="btn btn-secondary d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#quitCustomerModal">
						<i class="material-icons mr-2">&#xE5cd;</i>
						<span>Cancel</span>
					</button>
				</div>
			</div>	
		</form>
	</div>
	<!-- Confirm Modal HTML -->
	<div id="quitCustomerModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="CustomerServlet" method="post">
					<div class="modal-header">						
						<h4 class="modal-title">Confirm quit</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<p>Are you sure you want to discard these changes?</p>
						<p class="text-warning"><small>This action cannot be undone.</small></p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<a href="${ pageContext.request.contextPath }/CustomerPagination" id="confirm-quit-btn" class="btn btn-danger">Quit</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Delete Modal HTML -->
	<div id="deleteCustomerModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header">						
						<h4 class="modal-title">Delete customer</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<p>Are you sure you want to delete this record?</p>
						<p class="text-warning"><small>This action cannot be undone.</small></p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<a href="#" id="confirm-delete-btn" class="btn btn-danger">Delete</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>