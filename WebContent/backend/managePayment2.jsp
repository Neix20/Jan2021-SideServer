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

			$checkboxes = $('input[name=filtercolumn]');
			$columnCheckBoxes = $('input[type="checkbox"]').not("#selectAll");

			// Use JQuery to hide and show specific columns based on checkboxes
			function filterColumn(checkbox) {
				let id = checkbox.attr("id");
				let columns = $('.'+id);

				let cacheArr = JSON.parse(localStorage.getItem("paymentFilterCache"));

				if (checkbox.prop('checked')) {
					// Update the preference
					if (!cacheArr.includes(id))
						cacheArr.push(id);
					if (cacheArr.length === $checkboxes.length)
						$("#selectAll").prop("checked", true);
					displaySpecificColumn(columns);
				} else {
					// Update the preference
					if (cacheArr.includes(id))
						cacheArr = cacheArr.filter(function(value, index, arr) {return value != id});
					// Uncheck "Select all" checkbox if users uncheck one of the checkboxes
					$("#selectAll").prop("checked", false);
					hideSpecificColumn(columns);
				}
				// Save the preference
				localStorage.setItem("paymentFilterCache", JSON.stringify(cacheArr));
			}
			
			function displayAllColumns() {
				$checkboxes.each(function(){
					checkbox = $(this)
					checkbox.prop("checked", true);
					filterColumn(checkbox);         
				});
			}

			// This function hide all columns "with" updating the cache
			function hideAllColumns() {
				$checkboxes.each(function(){
					checkbox = $(this)
					checkbox.prop("checked", false);
					filterColumn(checkbox);     
				});
			}

			// This function hide all columns "without" updating the cache
			function hideAllColumns2() {
				$checkboxes.each(function(){
					checkbox = $(this);
					let id = checkbox.attr("id");
					let columns = $('.'+id);
					checkbox.prop("checked", false);
					hideSpecificColumn(columns);
				});
			}

			function displaySpecificColumn(columns) {
				$.each(columns, function(index, column) {
					// Show column
					column.style.display= "";
				});
			}

			function hideSpecificColumn(columns) {
				$.each(columns, function(index, column) {
					// Hide column
					column.style.display= "none";
				});	
			}
			
			if (typeof(Storage) !== "undefined") {
				// If user preference is available in cache
				if (localStorage.paymentFilterCache) {
					// Reset the checkboxes
					$('input[type="checkbox"]').prop('checked', false);
					hideAllColumns2();
					// Get the user preference from JavaScript Storage API
					let cacheArr = JSON.parse(localStorage.paymentFilterCache);
					/* If the user preference is to display all columns, then
					   display all columns.
					*/
					if (cacheArr.length === $columnCheckBoxes.length)
						$("#selectAll").prop('checked', true);
					cacheArr.forEach(function (elem, index) {
						let columns = $('.'+elem);
						$('input[name=filtercolumn]').filter('#'+elem).prop('checked', true);
						displaySpecificColumn(columns);
					});
				}
				// If user preference is not available in cache
				else {
					// Display all columns by default and create new cache
					$("#selectAll").prop('checked', true);
					let cacheArr = [];
					$('input[type="checkbox"]').not("#selectAll").each(function() {
						cacheArr.push($(this).val());
						$(this).prop('checked', true);
					});
					localStorage.setItem("paymentFilterCache", JSON.stringify(cacheArr));
				}
			} 
			else {
				// Check all the checkboxes once the document is loaded if no Web Storage support.
				$('input[type="checkbox"]').prop('checked', true);
			}
			
			/*
			Once the user click "Select all" checkbox, activate all 
			checkboxes programmatically.
			*/
			$("#selectAll").on("change", function(){
				let checkbox;			
				if($("#selectAll").prop("checked")){
					displayAllColumns();
				} else {
					hideAllColumns();
				} 
			});

			// Activate the filterColumn function on change.	 
			$checkboxes.on("change", function(){
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
				  location.href = '<%= urlGenerator.toCustomURL(false) %>&recordsPerPage='+numOfEntries;
			});

			// Redirect to get new resources when the user activates the search function
			$('#search').on('click', function() {
				$('#search-form').submit();
			});

			// when the submit button in the modal is clicked, submit the form
			$('#editPaymentModal .modal-footer button').click(function(){

			    /* when the submit button in the modal is clicked, submit the form */
			    $('#payment-form').append($('<input>', {
			            type: 'hidden',
			            name: 'user_action',
			            value: $(this).val()
			    }));
				
				$('#payment-form').submit();	  
			});

			// temporary variables to store detached DOM elements
			let addBtn = null;
			let updateBtn = null;
			let deleteBtn = null;

			$('td>a').on('click', function(e) {
			    // Prevent anchor tag from reloading the page
			    e.preventDefault();

			    $clickedElem = $(this);
			    // Execute Ajax GET request on URL
			    $.get($clickedElem.attr('id'), function(responseJson) {
			        $.each(responseJson, function (columnName, columnValue) {
			            $('#editPaymentModal #'+columnName).val(columnValue);
			        });

			     // Detach add button since the user only wants to update or delete payment
			        addBtn = $("#add-btn").detach();

			     	// Manually trigger the payment form
			        $('#editPaymentModal').modal('show');
			    });
			});

			$('#activate-add-btn').on('click', function(e) {
			    $('#editPaymentModal input:not([type=hidden]').val("");

			 	/* Detach update button, delete button since 
			 	   the user only wants to add new payment
			 	*/
			    updateBtn = $("#update-btn").detach();
			    deleteBtn = $("#delete-btn").detach();

			 // Manually trigger the payment form
			    $('#editPaymentModal').modal('show');
			});

			$paymentFormInputs = $('#editPaymentModal').find('select,input:not([type=radio],[type=button],[type=submit],[type=hidden])');

			/* 
				Once the user closes the payment form:
				1. Reattach the detached elements back to the payment form.
				2. Remove all input validation messages.
			*/
			$('#editPaymentModal').on('hidden.bs.modal', function (e) {
				// 1.
			    if (addBtn !== null) {
			        $('#editPaymentModal .modal-footer').append(addBtn);
			        addBtn = null;
			    }
			    if (updateBtn !== null) {
			        $('#editPaymentModal .modal-footer').append(updateBtn);
			        updateBtn = null;
			    }
			    if (deleteBtn !== null) {
			        $('#editPaymentModal .modal-footer').append(deleteBtn);
			        deleteBtn = null;
			    }
				// 2.
				$paymentFormInputs.each(function(index, element){
			        $(element).removeClass("is-valid is-invalid");
			    });
			});

			// AJAX POST request to get form validation results form the server
			$(".needs-validation").on("submit", function(event) {

				event.preventDefault();
				
				let $form = $(".needs-validation");
				let inputIdentifiers = []

				$.post($form.attr("action"), $form.serialize(), function(responseJSON) {

					/* If the server returns an empty object, it means that all inputs are
					   are valid. Straight away submit the checkout form.
					*/
					if (jQuery.isEmptyObject(responseJSON)) {
					    $form.off("submit");
					    $form.submit();
					}
				   
					let wrongInputs = Object.keys(responseJSON);

					/* Assign "is-valid" class to correct inputs and "is-invalid" class to
					   wrong inputs, respectively
					*/
					$paymentFormInputs.each(function(index, element){
				        let $elem = $(element);
				        let $parent = $elem.parent();
						// Remove all previous input validation messages
				        $elem.removeClass("is-valid is-invalid");
				        $parent.children(".invalid-feedback").remove();
				        // Assign new input validation messages based on incoming JSON
				        if (!wrongInputs.includes($elem.attr("id"))) {
				            $elem.addClass("is-valid");
				        } else {
				            $elem.addClass("is-invalid")
				        }
				    });
				    
				    // Iterate over the JSON object.                      
				    $.each(responseJSON, function(inputIdentifier, errorMessage) {
				        inputIdentifiers.push(inputIdentifier);
				        // Locate HTML DOM element with ID "inputIdentifier".
				        let $select = $("#editPaymentModal #"+inputIdentifier);
				        let $parent = $select.parent();
				        // Append the constructed error message in the parent div of the wrong input
				        $parent.append("<div class='invalid-feedback'>"+errorMessage+"</div>");
				    });
				});
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
				<button id="activate-add-btn" class="btn btn-success d-flex justify-content-center align-items-center" data-toggle="modal" data-target="#addPaymentModal">
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
										urlGeneratorNew.setSortType("DESC");
									} else if (urlGenerator.getSortType().equals("DESC")){
										if (columnTypes[idx].equals("number"))
											sortIcons[idx] = "fa fa-sort-numeric-desc";
										else
											sortIcons[idx] = "fa fa-sort-alpha-desc";
										urlGeneratorNew.setSortType("ASC");
									}
								} 
								// Else if not match, use the default sort icon
								else {
									sortIcons[idx] = "fa fa-sort";
									urlGeneratorNew.setSortType("ASC");
								}
								// Print the HTML element respectively
								out.print("<th scope='col' class='"+sortItemsLookup[idx]+"'>");
								out.print("<a href='"+urlGeneratorNew.toString()+"'>");
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
							String href = "'managePayment?customernumber="+customernumber+"&checknumber="+checknumber+"'";

							// Provide edit icons to user
							out.println("<td><a class='edit' title='Edit' data-toggle='tooltip' href id="+href+">"+
							"<i class='material-icons'>&#xE254;</i></a></span></td>");
							
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
			<!-- Filter payment checkboxes -->
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
			<!-- End filter payment checkboxes -->
			<!-- ============================================================== -->
	</div>
	<!-- ============================================================== -->
	<!-- Add & edit payment pop up -->
	<!-- ============================================================== -->
	<div id="editPaymentModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="payment-form" class="needs-validation" action="${ pageContext.request.contextPath }/managePayment" method="post" novalidate>
					<div class="modal-header">
						<h4 class="modal-title">Payment details</h4>
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
						    	<option value="" selected>Select your payment method</option>
						        <option value="check">Check</option>
						        <option value="cash">Cash</option>
						        <option value="debit card">Debit card</option>
						        <option value="credit card">Credit card</option>
						        <option value="online banking">Online banking</option>
						    </select>
						</div>
						<input type="hidden" name="nOfPages" value="<%= urlGenerator.getnOfPages() %>">
						<input type="hidden" name="currentPage" value="<%= urlGenerator.getCurrentPage() %>">
						<input type="hidden" name="recordsPerPage" value="<%= urlGenerator.getRecordsPerPage() %>">
						<input type="hidden" name="keyword" value="<%= urlGenerator.getKeyword() %>">
						<input type="hidden" name="sortItem" value="<%= urlGenerator.getSortItem() %>">
						<input type="hidden" name="sortType" value="<%= urlGenerator.getSortType() %>">	
					</div>
					<div class="modal-footer">
						<button id="cancel-btn" type="button" class="btn btn-default d-flex justify-content-center align-items-center" data-dismiss="modal">
							<span>Cancel</span>
						</button>
						<button id="add-btn" type="button" name="user_action" value="ADD" class="btn btn-success d-flex justify-content-center align-items-center">
							<i class="material-icons mr-2">&#xE147;</i> <span>Add</span>
						</button>
						<button id="update-btn" type="button" name="user_action" value="UPDATE" class="btn btn-success d-flex justify-content-center align-items-center">
							<i class="material-icons mr-2">&#xE254;</i> <span>Update</span>
						</button>
						<button id="delete-btn" type="button" name="user_action" value="DELETE" class="btn btn-danger d-flex justify-content-center align-items-center">
							<i class="material-icons mr-2">&#xE872;</i>
							<span>Delete</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- End add & edit payment pop up -->
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
						<input id="confirm-delete-btn" type="submit" class="btn btn-danger" value="Delete">
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