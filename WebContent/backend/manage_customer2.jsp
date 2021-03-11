<%@page import="java.util.List" %>
<%@page import="domain.Customer" %>
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
				  location.href = "CustomerPagination?currentPage=1&recordsPerPage="+numOfEntries+"&keyword="+"<%= keyword %>";
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

<body>
	<div class="container-fluid">
		<div class="row d-flex justify-content-start align-items-center">
			<div class="col-4">
				<button class="btn btn-success d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#addCustomerModal">
				<i class="material-icons mr-2">&#xE147;</i> <span>Add Customer</span>
				</button>
			</div>
			<nav class="col-4 d-flex justify-content-center align-items-center" aria-label="Navigation for customers">
				<ul class="pagination m-4">
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
			<div class="col-4 show-entries ml-auto d-flex justify-content-end align-items-center">
				<span class="mr-1">Show </span>
					<select id="selected_entries">
						<option value="10">10</option>
						<option value="30">30</option>
						<option value="70">70</option>
						<option value="120">120</option>
					</select>
				<span class="ml-1"> entries per page</span>
			</div>
		</div>
		</div>
		<div class="row container-fluid">
			<div class="col-9 table-responsive table-wrapper" style="min-width: 500px;">
				<table class="table table-striped table-hover table-light scroll-bar">
					<thead>
						<tr>
                            <th scope="col">Action</th>
                            <th scope="col">Customer no</th>
                            <th scope="col">Name</th>
                            <th scope="col">Contact first name</th>
                            <th scope="col">Contact last name</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Email</th>
                            <th scope="col">Address line 1</th>
                            <th scope="col">Address line 2</th>
                            <th scope="col">City</th>
                            <th scope="col">State</th>
                            <th scope="col">Postal code</th>
                            <th scope="col">Country</th>
                            <th scope="col">Sales representative no</th>
                            <th scope="col">Credit limit</th>
						</tr>
					</thead>
					<tbody>
						<%
						List<Customer> customers = (List<Customer>) request.getAttribute("customers");
						
						if (customers.size() != 0) {
						for (Customer customer : customers) {
							Integer customernumber = customer.getCustomernumber();
							
							out.println("<tr>");
							String href = "'Customer?customernumber="+customernumber+"'";

							out.println("<td><a title='View' class='view'"+
							" href="+href+">"+
							"<i class='material-icons'>&#xE417;</i></a>");
							out.println("<a class='edit' title='Edit' data-toggle='tooltip'"+
							" href="+href+">"+
							"<i class='material-icons'>&#xE254;</i></a>");
							out.println("<a class='delete' title='Delete' data-toggle='tooltip'"+
							" href="+href+">"+
							"<i class='material-icons'>&#xE872;</i></a></td>");
							
                            out.println("<td scope='row'>" + customernumber + "</td>");
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
                            //TODO Link this employee to another page
                            out.println("<td>" + customer.getEmployee() + "</td>");
                            out.println("<td>" + customer.getCreditlimit().doubleValue() + "</td>");
                            //TODO Display payment record
                            // out.println("<td>" + customer.getCustomers() + "</td>");
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
			<div class="col-3">
				<div class="row d-flex flex-column">
					<div class="col d-flex mt-3 px-3 flex-column justify-content-start align-items-center">
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
		</div>
	</div>
	<!-- Add Modal HTML -->
	<div id="addCustomerModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="Customer" method="post">
					<div class="modal-header">
						<h4 class="modal-title">Add customer</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">					
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
						    <label for="salesrepemployeenumber">Sales person representative:</label>
						    <input class="form-control" type="text" id="salesrepemployeenumber" name="salesrepemployeenumber">
						</div>
						<div class="form-group">
						    <label for="creditlimit">Credit limit:</label>
						    <input class="form-control" type="number" id="creditlimit" name="creditlimit" step="0.01" min="0" value="0">
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
	<div id="deleteCustomerModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header">						
						<h4 class="modal-title">Delete customer</h4>
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