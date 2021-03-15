<%@page import="domain.Payment"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%
Payment payment = (Payment) request.getAttribute("payment");
Integer customernumber = payment.getId().getCustomernumber();
String checknumber = payment.getId().getChecknumber();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update payment</title>
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
	
	document.querySelector("#paymentmethod").value = '<%= payment.getPaymentmethod() %>';

	$('#confirm-delete-btn').click(function(){
		
	    /* when the submit button in the modal is clicked, submit the form */
	    $('#payment-form').append($('<input>', {
	            type: 'hidden',
	            name: 'user_action',
	            value: 'DELETE'
	    }));

		$('#payment-form').submit();	  
	});
})
</script>
</head>
<body>
	<div class="container mx-5 my-3 w-75">
		<h1 class="text-center">
			Payment Details
			<span class="page-text font-weight-light small"><%= customernumber %>/<%= checknumber %></span>
		</h1>
		<form id="payment-form" action="Payment" class="p-3" method="post">
				<div class="row">
					<div class="col-9 table-wrapper scroll-bar">
						<div class="form-group">
                            <label for="customernumber">Customer no:</label><br>
                            <input class="form-control" type="number" id="customernumber" name="customernumber" min="0" value=<%= customernumber %> readonly required><br>
                        </div>
                        <div class="form-group">
                            <label for="checknumber">Check no:</label><br>
                            <input class="form-control" type="text" id="checknumber" name="checknumber" value="<%= checknumber %>" readonly required><br>
                        </div>
                        <div class="form-group">
                            <label for="amount">Amount:</label><br>
                            <input class="form-control" type="number" id="amount" name="amount" step="0.01" min="0" value="${ payment.amount }" required><br>
                        </div>
                        <div class="form-group">
                            <label for="paymentdate">Payment date:</label><br>
                            <%
                                String paymentDateStr = payment.getPaymentdate();
                                DateFormat dateFormat1 = new SimpleDateFormat("M/d/yyyy");
                                Date paymentDate = dateFormat1.parse(paymentDateStr);
                                DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
                                paymentDateStr = dateFormat2.format(paymentDate);
                            %>
                            <input class="form-control" type="date" id="paymentdate" name="paymentdate" value=<%= paymentDateStr %> required><br>
                        </div>
                        <div class="form-group">
                            <label for="paymentmethod">Payment method:</label><br>
                            <select class="form-control" name="paymentmethod" id="paymentmethod" required>
                              <option value="check">Check</option>
                              <option value="cash">Cash</option>
                              <option value="debit card">Debit card</option>
                              <option value="credit card">Credit card</option>
                              <option value="online banking">Online banking</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <% //TODO How to link to customer? %>
                            <!-- 
                                    <label for="salesrepemployeenumber">Sales person representative:</label><br>
                                    <input type="text" id="salesrepemployeenumber" name="salesrepemployeenumber" value=${ customer.country }>
                             -->
                        </div>
					</div>
				<div class="col-3 d-flex flex-column justify-content-around align-items-center">
					<button type="submit" name="user_action" value="UPDATE" class="btn btn-success d-flex justify-content-center align-items-center">
						<i class="material-icons mr-2">&#xE254;</i> <span>Update Payment</span>
					</button>
					<button id="delete-btn" type="button" name="user_action" value="DELETE" class="btn btn-danger d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#deletePaymentModal">
						<i class="material-icons mr-2">&#xE872;</i>
						<span>Delete Payment</span>
					</button>
					<button id="cancel-btn" type="button" class="btn btn-secondary d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#quitPaymentModal">
						<i class="material-icons mr-2">&#xE5cd;</i>
						<span>Cancel</span>
					</button>
				</div>
			</div>	
		</form>
	</div>
	<!-- Confirm Modal HTML -->
	<div id="quitPaymentModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="Payment" method="post">
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
						<a href="${ pageContext.request.contextPath }/managePayment" id="confirm-btn" class="btn btn-danger">Confrim</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Delete Modal HTML -->
	<div id="deletePaymentModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header">						
						<h4 class="modal-title">Delete payment</h4>
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