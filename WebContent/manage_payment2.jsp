<%@page import="java.util.List" %>
<%@page import="domain.Payment" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<% 
	String pageDisplay= "";
	int currentPage=(int) request.getAttribute("currentPage");
	int recordsPerPage=(int) request.getAttribute("recordsPerPage");
	int nOfPages=(int) request.getAttribute("nOfPages");
	String keyword=(String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Bootstrap Elegant Table Design</title>
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
	<script>
		$(document).ready(function () {

			// Activate tooltip
			// $('[data-toggle="tooltip"]').tooltip();
			
			// Select/Deselect checkboxes
			var checkbox = $('table tbody input[type="checkbox"]');
			$("#selectAll").click(function(){
				if(this.checked){
					checkbox.each(function(){
						this.checked = true;                        
					});
				} else{
					checkbox.each(function(){
						this.checked = false;                        
					});
				} 
			});
			
			checkbox.click(function(){
				if(!this.checked){
					$("#selectAll").prop("checked", false);
				}
			});
			
			// Animate select box length
			var searchInput = $(".search-box input");
			var inputGroup = $(".search-box .input-group");
			var boxWidth = inputGroup.width();
			searchInput.focus(function () {
				inputGroup.animate({
					width: "300"
				});
			}).blur(function () {
				inputGroup.animate({
					width: boxWidth
				});
			});

			$("#selected_entries").on('change', function() {
				  let numOfEntries = this.value;
				  location.href = "PaymentPagination?currentPage=1&recordsPerPage="+numOfEntries+"&keyword="+"<%= keyword %>";
			});

			document.querySelector("#selected_entries").value = '<%= recordsPerPage %>';

			$('#search').on('click', function() {
				$('#search-form').submit();
			});
			
// 			$('.scroll-bar').DataTable({
// 				"scrollX": true,
// 				"scrollY": 200,
// 			});

// 			$('.dataTables_length').addClass('bs-select');
		});
	</script>
</head>

<body class="m-4">
	<div class="table-title m-4 pb-2">
			<div class="row">
				<div class="col-sm-4 d-flex justify-content-start align-items-center">
					<button class="btn btn-success d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#addPaymentModal">
						<i class="material-icons mr-2">&#xE147;</i> <span>Add Payment</span>
					</button>
					<a href="#" class="btn btn-danger d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#deletePaymentModal">
						<i class="material-icons mr-2">&#xE15C;</i>
					<span>Delete Payment</span></a>
				</div>
				<div class="col-sm-5 d-flex justify-content-start align-items-center">
					<%
					if (nOfPages !=0) { pageDisplay=currentPage + " of " + nOfPages; }
					%>
					<h1 class="text-center">
						Payment <b>Details</b> 
						<span class="page-text font-weight-light small"><%= pageDisplay %></span>
					</h1>
				</div>
				<div class="col-sm-3 d-flex justify-content-start align-items-center">
					<div class="search-box">
						<form id="search-form" action="PaymentPagination" method="GET">
							<div class="input-group mr-3">
								<span class="input-group-addon"><a id="search" href="#" type="submit"><i class="material-icons">&#xE8B6;</i></a></span>
								<input type="text" name="keyword" class="form-control" placeholder="Search&hellip;">
								<input type="hidden" name="currentPage" value="<%= currentPage %>">
								<input type="hidden" name="recordsPerPage" value="<%= recordsPerPage %>">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid ml-4">
			<div class="row">
				<div class="col-9 table-responsive table-wrapper">
					<table class="table table-striped table-hover table-light scroll-bar">
						<thead>
							<tr>
								<th scope="col">
									<span class="custom-checkbox">
										<input type="checkbox" id="selectAll">
										<label for="selectAll"></label>
									</span>
								</th>
								<th scope="col">Customer no</th>
								<th scope="col">Check no</th>
								<th scope="col">Amount</th>
								<th scope="col">Payment date</th>
								<th scope="col">Payment method</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<Payment> payments = (List<Payment>) request.getAttribute("payments");
							
							if (payments.size() != 0) {
							for (Payment payment : payments) {
								Integer customernumber = payment.getId().getCustomernumber();
								String checknumber = payment.getId().getChecknumber();
								
								out.println("<tr>");		
								out.println("<td><span class='custom-checkbox'>"+
								"<input type='checkbox' id='"+customernumber+"' name='selected_customers' "+
								"value='"+customernumber+"'><label for='"+customernumber+"'></label></span></td>");
								String href = "'PaymentServlet?customernumber="+customernumber+"&checknumber="+checknumber+"'";

								out.println("<td><a title='Edit' class='view'"+
								" href="+href+">"+
								"<i class='material-icons'>&#xE417;</i></a>");
								out.println("<a class='edit' title='Edit' data-toggle='tooltip'"+
								" href="+href+">"+
								"<i class='material-icons'>&#xE254;</i></a>");
								out.println("<a class='delete' title='Delete' data-toggle='tooltip'"+
								" href="+href+">"+
								"<i class='material-icons'>&#xE872;</i></a></td>");
								
							    out.println("<td scope='row'>" + customernumber + "</td>");
							    out.println("<td scope='row'>" + checknumber + "</td>");
							    out.println("<td>" + payment.getAmount() + "</td>");
							    out.println("<td>" + payment.getPaymentdate() + "</td>");
							    out.println("<td>" + payment.getPaymentmethod() + "</td>");	
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
						</tbody>
					</table>
				</div>
				<div class="col-3 m-auto px-5">
					<h3>Filter by columns</h3>
					<div class="form-check">
							<input class="form-check-input" type="checkbox" value="customernumber" id="customernumber">
							<label for="customernumber">Customer number</label><br>
							<input class="form-check-input" type="checkbox" value="customername" id="customername">
							<label for="customername">Customer name</label><br>
							<input class="form-check-input" type="checkbox" value="contact_firstname" id="contact_firstname">
							<label for="contact_firstname">Contact first name</label><br>
							<input class="form-check-input" type="checkbox" value="contact_lastname" id="contact_lastname">
							<label for="contact_lastname">Contact last name</label><br>
							<input class="form-check-input" type="checkbox" value="phone" id="phone">
							<label for="phone">Phone</label><br>
							<input class="form-check-input" type="checkbox" value="email" id="email">
							<label for="email">Email</label><br>
							<input class="form-check-input" type="checkbox" value="addressline1" id="addressline1">
							<label for="addressline1">Address line 1</label><br>
							<input class="form-check-input" type="checkbox" value="addressline2" id="addressline2">
							<label for="addressline2">Address line 2</label><br>
							<input class="form-check-input" type="checkbox" value="city" id="city">
							<label for="city">City</label><br>
							<input class="form-check-input" type="checkbox" value="state" id="state">
							<label for="state">State</label><br>
							<input class="form-check-input" type="checkbox" value="postalcode" id="postalcode">
							<label for="postalcode">Postal code</label><br>
							<input class="form-check-input" type="checkbox" value="country" id="country">
							<label for="country">Country</label><br>
					</div>
				</div>
			</div>
		</div>
	<div class="container m-0">
		<div class="row">
			<div class="col-6">
				<nav aria-label="Navigation for customers">
					<ul class="pagination m-4">
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
			</div>
			<div class="col-6 my-auto d-flex">
				<div class="show-entries ml-auto">
						<span>Show</span>
						<select id="selected_entries">
							<option value="10">10</option>
							<option value="30">30</option>
							<option value="70">70</option>
							<option value="120">120</option>
						</select>
						<span>entries per page</span>
				</div>
			</div>
		</div>
	</div>
	<!-- Add Modal HTML -->
	<div id="addPaymentModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="PaymentServlet" method="post">
					<div class="modal-header">
						<h4 class="modal-title">Add payment</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
						<div class="form-group">
						    <label for="customernumber">Customer no:</label><br>
						    <input class="form-control" type="number" id="customernumber" name="customernumber" min="0" required><br>
						</div>
						<div class="form-group">
						    <label for="checknumber">Check no:</label><br>
						    <input class="form-control" type="text" id="checknumber" name="checknumber" required><br>
						</div>
						<div class="form-group">
						    <label for="amount">Amount:</label><br>
						    <input class="form-control" type="number" id="amount" name="amount" step="0.01" min="0" required><br>
						</div>
						<div class="form-group">
						    <label for="paymentdate">Payment date:</label><br>
						    <input class="form-control" type="date" id="paymentdate" name="paymentdate" required><br>
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
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="submit" class="btn btn-success" value="Add">
						<input type="hidden" id="user_action" name="user_action" value="ADD">
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
						<p>Are you sure you want to delete these records?</p>
						<p class="text-warning"><small>This action cannot be undone.</small></p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
						<input type="submit" class="btn btn-danger" value="Delete">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

</html>