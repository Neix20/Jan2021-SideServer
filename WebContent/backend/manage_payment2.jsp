<%--
Author	  : Yap Jheng Khin
Page      : Payment data table
References: (Bootstrap template) https://www.tutorialrepublic.com/snippets/preview.php?topic=bootstrap&file=elegant-table-design
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="java.util.List" %>
<%@page import="domain.Payment" %>
<%@page import="utility.UrlGenerator" %>
<%UrlGenerator urlGenerator = (UrlGenerator) request.getAttribute("urlGenerator");%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Manage Payment</title>
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
			<!-- Add payment -->
			<!-- ============================================================== -->
			<div class="col-4">
				<button class="btn btn-success d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#addPaymentModal">
				<i class="material-icons mr-2">&#xE147;</i> <span>Add Payment</span>
				</button>
			</div>
			<!-- ============================================================== -->
			<!-- End add payment -->
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
			<!-- Payment data table -->
			<!-- ============================================================== -->
			<div class="col-9 table-responsive table-wrapper" style="min-width: 500px;">
				<table class="table table-striped table-hover table-light scroll-bar" id="table-container">
					<thead>
						<tr>
							<th scope="col">Action</th>
							<%
							UrlGenerator urlGeneratorNew;
							final int NUM_OF_COLUMNS = 5;
							String urls[] = new String[NUM_OF_COLUMNS];
							String[] sortIcons = new String[NUM_OF_COLUMNS];
							
							String[] sortItemsLookup = {
								"customernumber", 
								"checknumber", 
								"amount", 
								"paymentdate", 
								"paymentmethod",
							};
							
							String[] columnName = {
								"Customer no", 
								"Check no", 
								"Amount",
								"Payment date",
								"Payment method",
							};
							
							String[] columnTypes = {
								"number",
								"alphabet",
								"number",
								"number",
								"alphabet"
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
						List<Payment> payments = (List<Payment>) request.getAttribute("payments");
						
						if (payments.size() != 0) {
						for (Payment payment : payments) {
							Integer customernumber = payment.getId().getCustomernumber();
							String checknumber = payment.getId().getChecknumber();
							
							out.println("<tr>");
							// TODO Switch to Payment with parameter
							String href = "'Payment?customernumber="+customernumber+"&checknumber="+checknumber+"'";

							// Provide view, edit, and delete icons to user
							out.println("<td><a title='View' class='view'"+
							" href="+href+">"+
							"<i class='material-icons'>&#xE417;</i></a>");
							out.println("<a class='edit' title='Edit' data-toggle='tooltip'"+
							" href="+href+">"+
							"<i class='material-icons'>&#xE254;</i></a>");
							out.println("<a class='delete' title='Delete' data-toggle='tooltip'"+
							" href="+href+">"+
							"<i class='material-icons'>&#xE872;</i></a></td>");
							
							// Get and display the data
						    out.println("<td scope='row' class='customernumber'>" + customernumber + "</td>");
						    out.println("<td scope='row' class='checknumber'>" + checknumber + "</td>");
						    out.println("<td class='amount'>" + payment.getAmount() + "</td>");
						    out.println("<td class='paymentdate'>" + payment.getPaymentdate() + "</td>");
						    out.println("<td class='paymentmethod'>" + payment.getPaymentmethod() + "</td>");	
							out.println("</tr>");
						}
						} 
						// Special case when record not found
						else {
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
			<!-- End payment data table -->
			<!-- ============================================================== -->
			<!-- ============================================================== -->
			<!-- Add payment form -->
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
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="checknumber" id="checknumber">
							<label for="checknumber">Check number</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="amount" id="amount">
							<label for="amount">Amount</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="paymentdate" id="paymentdate">
							<label for="paymentdate">Payment date</label><br>
							<input class="form-check-input" type="checkbox" name="filtercolumn" value="paymentmethod" id="paymentmethod">
							<label for="paymentmethod">Payment method</label><br>
						</div>
					</div>
				</div>
			</div>
			<!-- ============================================================== -->
			<!-- End add payment form -->
			<!-- ============================================================== -->
	</div>
	<!-- ============================================================== -->
	<!-- Add payment pop up -->
	<!-- ============================================================== -->
	<div id="addPaymentModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="Payment" method="post">
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
	<!-- ============================================================== -->
	<!-- End add payment pop up -->
	<!-- ============================================================== -->
	<!-- ============================================================== -->
	<!-- Delete payment pop up -->
	<!-- ============================================================== -->
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
	<!-- ============================================================== -->
	<!-- End delete payment pop up -->
	<!-- ============================================================== -->
</body>

</html>