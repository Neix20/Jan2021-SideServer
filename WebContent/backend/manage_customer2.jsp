<%--
Author	  : Yap Jheng Khin
Page      : Customer data table
References: (Bootstrap template) https://www.tutorialrepublic.com/snippets/preview.php?topic=bootstrap&file=elegant-table-design
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="java.util.List" %>
<%@page import="domain.Customer" %>
<%@page import="domain.Employee" %>
<%@page import="utility.UrlGenerator" %>
<%UrlGenerator urlGenerator = (UrlGenerator) request.getAttribute("urlGenerator");%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Bootstrap Elegant Table Design</title>
	<!-- ============================================================== -->
	<!-- Import dependencies & libraries -->
	<!-- ============================================================== -->
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
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/frontend/assets/css/font-awesome.css">
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/customer-page.css">
	<!-- ============================================================== -->
	<!-- End dependencies & libraries -->
	<!-- ============================================================== -->
	<!-- ============================================================== -->
	<!-- Custom JQuery script -->
	<!-- ============================================================== -->
	<script>
		$(document).ready(function () {

			// Check all the checkboxes once the document is loaded
			$('input[type="checkbox"]').attr('checked', 'checked');
			var checkboxes = $('input[name=filtercolumn]');
	
			// Use JQuery to hide and show specific columns based on checkboxes
			function filterColumn(checkbox) {
				let id = checkbox.attr("id");
				let columns = $('.'+id);
				
				if (checkbox.prop('checked')) {
					$.each(columns, function(index, column) {
						// Show column
						column.style.display= "";
					});
				} else {
					// Uncheck "Select all" checkbox if users uncheck one of the checkboxes
					$("#selectAll").prop("checked", false);
					$.each(columns, function(index, column) {
						// Hide column
						column.style.display= "none";
					});	
				}
			}
	
			/*
			Once the user click "Select all" checkbox, activate all 
			checkboxes programmatically.
			*/
			$("#selectAll").on("change", function(){
				let checkbox;			
				if($("#selectAll").prop("checked")){
					checkboxes.each(function(){
						checkbox = $(this)
						checkbox.prop("checked", true);
						filterColumn(checkbox);         
					});
				} else {
					checkboxes.each(function(){
						checkbox = $(this)
						checkbox.prop("checked", false);
						filterColumn(checkbox);              
					});
				} 
			});
	
			// Activate the filterColumn function on change.	 
			checkboxes.on("change", function(){
				let checkbox = $(this);
				filterColumn(checkbox);
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
	
			// Update the input values of "Select entries" based on url parameter
			document.querySelector("#selected_entries").value = '<%= urlGenerator.getRecordsPerPage() %>';
			
			// Redirect to get new resources when the user selects different number of entries
			$("#selected_entries").on('change', function() {
				  let numOfEntries = this.value;
				  location.href = <%= urlGenerator %>;
			});
	
			// Redirect to get new resources when the user activates the search function
			$('#search').on('click', function() {
				$('#search-form').submit();
			});
		});
	</script>
	<!-- ============================================================== -->
	<!-- End custom JQuery script -->
	<!-- ============================================================== -->
</head>

<body>
	<div class="container-fluid">
		<div class="row d-flex justify-content-start align-items-center">
			<!-- ============================================================== -->
			<!-- Add customer -->
			<!-- ============================================================== -->
			<div class="col-4">
				<button class="btn btn-success d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#addCustomerModal">
				<i class="material-icons mr-2">&#xE147;</i> <span>Add Customer</span>
				</button>
			</div>
			<!-- ============================================================== -->
			<!-- End add customer -->
			<!-- ============================================================== -->
			<!-- ============================================================== -->
			<!-- Page navigation -->
			<!-- ============================================================== -->
			<nav class="col-4 d-flex justify-content-center align-items-center" aria-label="Navigation for customers">
				<ul class="pagination m-4">
					<%
					// Use custom class to manage URL more effectively
					UrlGenerator urlGeneratorTemp;

					// Generate URLs to navigate between pages
					if (urlGenerator.getCurrentPage() != 1 && urlGenerator.getnOfPages() != 0) {
						
						urlGeneratorTemp = new UrlGenerator(urlGenerator);
						// Set to first page
						urlGeneratorTemp.setCurrentPage(1);
						out.println("<li class='page-item'>");
						out.println("<a class='page-link' href='"+urlGeneratorTemp+"'>First</a>");
						out.println("</li>");

						urlGeneratorTemp = new UrlGenerator(urlGenerator);
						// Set to previous page
						urlGeneratorTemp.setCurrentPage(urlGeneratorTemp.getCurrentPage()-1);
						out.println("<li class='page-item'>");
						out.println("<a class='page-link' href='"+urlGeneratorTemp+"'>Previous</a>");
						out.println("</li>");
						
					}
					
					// Generate URLs to navigate between pages
					if (urlGenerator.getCurrentPage() < urlGenerator.getnOfPages()) {
						
						urlGeneratorTemp = new UrlGenerator(urlGenerator);
						// Set to next page
						urlGeneratorTemp.setCurrentPage(urlGeneratorTemp.getCurrentPage()+1);
						out.println("<li class='page-item'>");
						out.println("<a class='page-link' href='"+urlGeneratorTemp+"'>Next</a>");
						out.println("</li>");
						
						urlGeneratorTemp = new UrlGenerator(urlGenerator);
						// Set to last page
						urlGeneratorTemp.setCurrentPage(urlGeneratorTemp.getnOfPages());
						out.println("<li class=\"page-item\">");
						out.println("<li class='page-item'>");
						out.println("<a class='page-link' href='"+urlGeneratorTemp+"'>Last</a>");
						out.println("</li>");
						
					}
					%>
				</ul>
			</nav>
			<!-- ============================================================== -->
			<!-- End page navigation -->
			<!-- ============================================================== -->
			<!-- ============================================================== -->
			<!-- Select number of entries -->
			<!-- ============================================================== -->
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
			<!-- ============================================================== -->
			<!-- End select number of entries -->
			<!-- ============================================================== -->
		</div>
		</div>
		<div class="row container-fluid">
			<!-- ============================================================== -->
			<!-- Customer data table -->
			<!-- ============================================================== -->
			<div class="col-9 table-responsive table-wrapper" style="min-width: 500px;">
				<table class="table table-striped table-hover table-light scroll-bar">
					<thead>
						<tr>
							<th scope="col">Action</th>
							<%
							UrlGenerator urlGeneratorNew;
							final int NUM_OF_COLUMNS = 14;
							String urls[] = new String[NUM_OF_COLUMNS];
							String[] sortIcons = new String[NUM_OF_COLUMNS];
							
							String[] sortItemsLookup = {
									"customernumber",
									"customername",
									"contactfirstname",
									"contactlastname",
									"phone",
									"email",
									"addressline1",
									"addressline2",
									"city",
									"state",
									"postalcode",
									"country",
									"salesrepresentativeno",
									"creditlimit",
							};
							
							String[] columnName = {
									"Customer no",
									"Name",
									"Contact first name",
									"Contact last name",
									"Phone",
									"Email",
									"Address line 1",
									"Address line 2",
									"City",
									"State",
									"Postal code",
									"Country",
									"Sales representative no",
									"Credit limit",
							};
							
							String[] columnTypes = {
									"number",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"alphabet",
									"number",
									"number",
							};
							
							// Generate URLs for each columns
							for (int idx = 0; idx < sortItemsLookup.length; idx++) {
								
								urlGeneratorNew = new UrlGenerator(urlGenerator);
								// Set to sort item based on the current column
								urlGeneratorNew.setSortItem(sortItemsLookup[idx]);
								
								urls[idx] = urlGeneratorNew.toString();
								// If the current column matches the URL parameter sortItem
								if (urlGenerator.getSortItem().equals(sortItemsLookup[idx])) {
									/* Change the icon to ascending icon if the user previously clicked
									   asceding, and vice versa
									*/
									if (urlGenerator.getSortType().equals("ASC")) {
										// Change the icon depending on the data type of the column
										if (columnTypes[idx].equals("number"))
											sortIcons[idx] = "fa fa-sort-numeric-asc";
										else
											sortIcons[idx] = "fa fa-sort-alpha-asc";
										urls[idx] += "&sortType=DESC";
									} else if (urlGenerator.getSortType().equals("DESC")){
										if (columnTypes[idx].equals("number"))
											sortIcons[idx] = "fa fa-sort-numeric-desc";
										else
											sortIcons[idx] = "fa fa-sort-alpha-desc";
										urls[idx] += "&sortType=ASC";
									}
								} 
								// Else if not match, use the default sort icon
								else {
									sortIcons[idx] = "fa fa-sort";
									urls[idx] += "&sortType=ASC";
								}
								// Print the HTML element respectively
								out.print("<th scope='col' class='"+sortItemsLookup[idx]+"'>");
								out.print("<a href='"+urls[idx]+"'>");
								out.print(columnName[idx]);
								out.print("<i class='"+sortIcons[idx]+"' aria-hidden='true'>");
								out.print("</a>");
								out.print("</th>");
							}
							%>
						</tr>
					</thead>
					<tbody>
						<%
						List<Customer> customers = (List<Customer>) request.getAttribute("customers");
						
						if (customers.size() != 0) {
						for (Customer customer : customers) {
							Integer customernumber = customer.getCustomernumber();
							
							out.println("<tr>");
							// TODO Switch to Customer with parameter
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
							
							out.println("<td scope='row' class='customernumber'>" + customernumber + "</td>");
							out.println("<td class='customername'>" + customer.getCustomername() + "</td>");
							out.println("<td class='contactfirstname'>" + customer.getContactfirstname() + "</td>");
							out.println("<td class='contactlastname'>" + customer.getContactlastname() + "</td>");
							out.println("<td class='phone'>" + customer.getPhone() + "</td>");
							out.println("<td class='email'>" + customer.getEmail() + "</td>");
							out.println("<td class='addressline1'>" + customer.getAddressline1() + "</td>");
							out.println("<td class='addressline2'>" + customer.getAddressline2() + "</td>");
							out.println("<td class='city'>" + customer.getCity() + "</td>");
							out.println("<td class='state'>" + customer.getState() + "</td>");
							out.println("<td class='postalcode'>" + customer.getPostalcode() + "</td>");
							out.println("<td class='country'>" + customer.getCountry() + "</td>");
							Employee salespersonrep = customer.getEmployee();
							String salespersonrepHTML = "";	
							if (salespersonrep == null) {
								salespersonrepHTML = "N/A";
							} else {
								salespersonrepHTML = String.valueOf(customer.getEmployee().getEmployeenumber());
							}	
							out.println("<td class='salesrepresentativeno'>" + salespersonrepHTML + "</td>");
							out.println("<td class='creditlimit'>" + customer.getCreditlimit().doubleValue() + "</td>");
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
			<!-- ============================================================== -->
			<!-- End customer data table -->
			<!-- ============================================================== -->
			<!-- ============================================================== -->
			<!-- Add customer form -->
			<!-- ============================================================== -->
			<div class="col-3">
				<div class="row d-flex flex-column">
					<div class="col d-flex mt-3 px-3 flex-column justify-content-start align-items-center">
						<h3>Filter by columns</h3>
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="selectAll" id="selectAll">
							<label for="selectAll">Select all</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="customernumber" id="customernumber">
							<label for="customernumber">Customer number</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="customername" id="customername">
							<label for="customername">Customer name</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="contactfirstname" id="contactfirstname">
							<label for="contactfirstname">Contact first name</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="contactlastname" id="contactlastname">
							<label for="contactlastname">Contact last name</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="phone" id="phone">
							<label for="phone">Phone</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="email" id="email">
							<label for="email">Email</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="addressline1" id="addressline1">
							<label for="addressline1">Address line 1</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="addressline2" id="addressline2">
							<label for="addressline2">Address line 2</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="city" id="city">
							<label for="city">City</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="state" id="state">
							<label for="state">State</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="postalcode" id="postalcode">
							<label for="postalcode">Postal code</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="country" id="country">
							<label for="country">Country</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="salesrepresentativeno" id="salesrepresentativeno">
							<label for="salesrepresentativeno">Sales person</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="creditlimit" id="creditlimit">
							<label for="creditlimit">Credit limit</label><br>
						</div>
					</div>
				</div>
			</div>
			<!-- ============================================================== -->
			<!-- End add customer form -->
			<!-- ============================================================== -->
		</div>
	<!-- ============================================================== -->
	<!-- Add customer pop up -->
	<!-- ============================================================== -->
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
						    <label for="contactfirstname">Contact first name:</label>
						    <input class="form-control" type="text" id="contactfirstname" name="contactfirstname" required>
						</div>
						<div class="form-group">
						    <label for="contactlastname">Contact last name:</label>
						    <input class="form-control" type="text" id="contactlastname" name="contactlastname" required>
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
	<!-- ============================================================== -->
	<!-- End customer pop up -->
	<!-- ============================================================== -->
	<!-- ============================================================== -->
	<!-- Delete customer pop up -->
	<!-- ============================================================== -->
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
	<!-- ============================================================== -->
	<!-- End delete customer pop up -->
	<!-- ============================================================== -->
</body>

</html>