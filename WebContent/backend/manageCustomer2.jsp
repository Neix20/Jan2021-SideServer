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
<%@page import="java.math.BigDecimal" %>
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

			$checkboxes = $('input[name=filtercolumn]');
			$columnCheckBoxes = $('input[type="checkbox"]').not("#selectAll");
			
			// Use JQuery to hide and show specific columns based on checkboxes
			function filterColumn(checkbox) {
				let id = checkbox.attr("id");
				let columns = $('.'+id);

				let cacheArr = JSON.parse(localStorage.getItem("customerFilterCache"));

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

				localStorage.setItem("customerFilterCache", JSON.stringify(cacheArr));
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
				if (localStorage.customerFilterCache) {
					// Reset the checkboxes
					$('input[type="checkbox"]').prop('checked', false);
					hideAllColumns2();
					// Get the user preference from JavaScript Storage API
					let cacheArr = JSON.parse(localStorage.customerFilterCache);
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
				} else {
					// Display all columns by default and create new cache
					$("#selectAll").prop('checked', true);
					let cacheArr = [];
					$('input[type="checkbox"]').not("#selectAll").each(function() {
						cacheArr.push($(this).val());
						$(this).prop('checked', true);
					});
					localStorage.setItem("customerFilterCache", JSON.stringify(cacheArr));
				}
			} else {
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
			$('#editCustomerModal .modal-footer button').click(function(){

			    /* when the submit button in the modal is clicked, submit the form */
			    $('#customer-form').append($('<input>', {
			            type: 'hidden',
			            name: 'user_action',
			            value: $(this).val()
			    }));
				
				$('#customer-form').submit();	  
			});

			// temporary variables to store detached DOM elements
			let addBtn = null;
			let updateBtn = null;
			let deleteBtn = null;
			let customerNoInput = null;

			$('td>a').on('click', function(e) {
			    // Prevent anchor tag from reloading the page
			    e.preventDefault();

			    $clickedElem = $(this);
			    // Execute Ajax GET request on URL
			    $.get($clickedElem.attr('id'), function(responseJson) {
			        $.each(responseJson, function (columnName, columnValue) {
			            $('#editCustomerModal input[name='+columnName+']').val(columnValue);
			        });

			        // Detach add button since the user only wants to update or delete customer
			        addBtn = $("#add-btn").detach();

			        // Manually trigger the customer form
			        $('#editCustomerModal').modal('show');
			    });
			});

			$('#activate-add-btn').on('click', function(e) {

			    $('#editCustomerModal input:not([type=hidden]').val("");

			 	/* Detach customer number input, update button, delete button 
			 	   since the user only wants to add new customer
			 	*/
			    customerNoInput = $('#editCustomerModal #customernumber').parent().detach();
			    updateBtn = $("#update-btn").detach();
			    deleteBtn = $("#delete-btn").detach();

				// Manually trigger the customer form
			    $('#editCustomerModal').modal('show');
			});

			$customerFormInputs = $('#editCustomerModal').find('select,input:not([type=radio],[type=button],[type=submit],[type=hidden])');

			/* 
				Once the user closes the payment form:
				1. Reattach the detached elements back to the payment form.
				2. Remove all input validation messages.
			*/
			$('#editCustomerModal').on('hidden.bs.modal', function (e) {
				// 1.
			    if (addBtn !== null) {
			        $('#editCustomerModal .modal-footer').append(addBtn);
			        addBtn = null;
			    }
			    if (updateBtn !== null) {
			        $('#editCustomerModal .modal-footer').append(updateBtn);
			        updateBtn = null;
			    }
			    if (deleteBtn !== null) {
			        $('#editCustomerModal .modal-footer').append(deleteBtn);
			        deleteBtn = null;
			    }
			    if (customerNoInput !== null) {
			        $('#editCustomerModal .modal-body').prepend(customerNoInput);
			        customerNoInput = null;
			    }
				// 2.
				$customerFormInputs.each(function(index, element){
			        $(element).removeClass("is-valid is-invalid");
			    });
			});
			
			// AJAX POST request to get form validation results form the server
			$(".needs-validation").on("submit", function(event) {

				event.preventDefault();
				
				let $form = $(".needs-validation");
				let returnResponseJSON;
				let inputIdentifiers = []

				$.post($form.attr("action"), $form.serialize(), function(responseJSON) {

					/* If the server returns an empty object, it means that all inputs are
					   are valid. Straight away submit the checkout form.
					*/
					if (jQuery.isEmptyObject(responseJSON)) {
					    $form.off("submit");
					    $form.submit();
					}
				    
				    returnResponseJSON = responseJSON;

				    let wrongInputs = Object.keys(responseJSON);

					/* Assign "is-valid" class to correct inputs and "is-invalid" class to
					   wrong inputs, respectively
					*/
					$customerFormInputs.each(function(index, element){
				        let $elem = $(element);
				        let $parent = $elem.parent();
				        /* Find all child elements with tag name "option" and remove them 
				         * (just to prevent duplicate options when button is pressed again).
				         */
				        $elem.removeClass("is-valid is-invalid");
				        $parent.children(".invalid-feedback").remove();
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
				        let $select = $("#editCustomerModal #"+inputIdentifier);
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
			<!-- Add customer -->
			<!-- ============================================================== -->
			<div class="col-4">
				<button id="activate-add-btn" class="btn btn-success d-flex justify-content-center align-items-center" >
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
						List<Customer> customers = (List<Customer>) request.getAttribute("customers");
						
						if (customers.size() != 0) {
						for (Customer customer : customers) {
							Integer customernumber = customer.getCustomernumber();
							
							out.println("<tr>");
							String href = "'manageCustomer?customernumber="+customernumber+"'";

							// Provide edit icons to user
							out.println("<td><a class='edit' title='Edit' data-toggle='tooltip' href id="+href+">"+
							"<i class='material-icons'>&#xE254;</i></a></span></td>");
				
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
							BigDecimal creditLimit = customer.getCreditlimit();
							String creditLimitHTML = "";
							if (creditLimit == null) {
								creditLimitHTML = "None";
							} else {
								creditLimitHTML = customer.getCreditlimit().toString();
							}
							out.println("<td class='creditlimit'>" + creditLimitHTML + "</td>");
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
			<!-- Filter customer checkboxes -->
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
			<!-- End filter customer checkboxes -->
			<!-- ============================================================== -->
		</div>
	<!-- ============================================================== -->
	<!-- Add & edit customer pop up -->
	<!-- ============================================================== -->
	<div id="editCustomerModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="customer-form" action="${ pageContext.request.contextPath }/manageCustomer" class="needs-validation" method="post" novalidate>
					<div class="modal-header">
						<h4 class="modal-title">Customer details</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<div class="form-group">
						    <label for="customernumber">Customer no:</label>
						    <input class="form-control" type="text" id="customernumber" name="customernumber" value="" readonly required>
						</div>				
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
	<!-- End add & edit customer pop up -->
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
						<input id="confirm-delete-btn" type="submit" class="btn btn-danger" value="Delete">
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