<%--
Author	  : Yap Jheng Khin
Page info : Display this page when the checkout is completed
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="domain.ShoppingCart"%>
<%@page import="domain.ShoppingCartItem"%>
<%@page import="domain.Employee"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.HashMap"%>
<%@page import="utility.Bank"%>
<%
ShoppingCart purchasedOrderProduct = (ShoppingCart) request.getAttribute("purchased_order_product");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Receipt</title>
	<!-- ============================================================== -->
	<!-- Import dependencies & libraries -->
	<!-- ============================================================== -->
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" 
	      rel="stylesheet">
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
	<link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/receipt.css">
	<!-- ============================================================== -->
	<!-- End dependencies & libraries -->
	<!-- ============================================================== -->
	<!-- ============================================================== -->
	<!-- Custom JQuery script -->
	<!-- ============================================================== -->
	<script>
		$(document).ready(function () {
			$('#invoice-print').on('click', function() {
				// Use browser built-in print function to both print and download receipt.
				window.print();
			});
		});
	</script>
	<!-- ============================================================== -->
	<!-- End custom JQuery script -->
	<!-- ============================================================== -->
</head>
<body>
	<!-- Include Header JSP -->
	<div class="d-print-none">
		<jsp:include page="header.jsp" />
	</div>
	
	<!-- ***** Call to Action Start ***** -->
    <section class="section section-bg d-print-none" id="call-to-action"
        style="background-image: url(frontend/assets/images/banner-image-1-1920x500.jpg)">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cta-content">
                        <br>
                        <br>
                        <h2><em>Receipt</em></h2>
                        <p>Thank you for purchasing. Please save and print your receipt <b>before closing the browser</b>.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Call to Action End ***** -->

	<div class="container bootstrap snippets bootdeys">
		<div class="row">
		  <div class="col-sm-12">
			  	<div class="panel panel-default invoice" id="invoice">
				  <div class="panel-body">
		  			<!-- ============================================================== -->
					<!-- Receipt header: receipt number, payment date, & shipping date -->
					<!-- ============================================================== -->
				    <div class="row mt-5 d-flex justify-content-between align-items-center">
				    	<div class="col-7">
				    		<h3 class="marginright">RECEIPT - <%= request.getAttribute("receipt_no") %></h3>
				    	</div>
						<div class="col-5 d-flex flex-column justify-content-between align-items-end text-right">
							<table class="table table-borderless table-sm ml-auto">
								<%
								SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
								SimpleDateFormat dateFormat2 = new SimpleDateFormat("dd MMMM yyyy");
								
								Date paymentDate = dateFormat1.parse((String) request.getAttribute("payment_date"));
							    String paymentDateDisplay = dateFormat2.format(paymentDate);
							    
								Date requiredDate = dateFormat1.parse(request.getParameter("required_date"));
							    String requiredDateDisplay = dateFormat2.format(requiredDate);
								%>
								<tr>
									<td>
										Payment date:
									</td>
									<td>
										<%= paymentDateDisplay %>
									</td>
								</tr>
								<tr>
									<td>
										Shipped by:
									</td>
									<td>
										<%= requiredDateDisplay %>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<!-- ============================================================== -->
					<!-- End receipt header -->
					<!-- ============================================================== -->
					<hr>
					<div class="row d-flex justify-content-between align-items-start">
						<!-- ============================================================== -->
						<!-- Customer information -->
						<!-- ============================================================== -->
						<div class="col-6 to">
							<%
								//Retrieve billing information a.k.a. customer information
								String customerName = request.getParameter("customername"); 
								String contactFirstname = request.getParameter("contactfirstname"); 
								String contactLastname = request.getParameter("contactlastname"); 
								String phone = request.getParameter("phone"); 
								String email = request.getParameter("email"); 
								String addressLine1 = request.getParameter("addressline1"); 
								String addressLine2 = request.getParameter("addressline2");
								String city = request.getParameter("city"); 
								String state = request.getParameter("state");
								String postalCode = request.getParameter("postalcode");
								String country = request.getParameter("country"); 
								String salesPersonEmail = request.getParameter("sales_person_email");
								Employee salesRep = (Employee) request.getAttribute("sales_representative");
								String salesRepName = salesRep.getFirstname() + " " + salesRep.getLastname();
								
								String addressLine3 = "";
								if (!postalCode.equals(""))
									addressLine3 += postalCode + ", ";
								if (!city.equals(""))
									addressLine3 += city + ", ";
								if (!state.equals(""))
									addressLine3 += state + ", ";
								if (!country.equals(""))
									addressLine3 += country;
							%>
							<table class="table table-borderless table-sm small-table">
								<tbody>
									<tr>
								    	<th>To:</th>
										<td><%= customerName %></td>
								    </tr>
								    <tr>
								    	<td>Customer representative:</td>
										<td><%= contactFirstname + " " + contactLastname %></td>
								    </tr>
								    <tr>
								    	<td>Address:</td>
										<td>
											<%= addressLine1 %><hr class="mt-0 mb-1 border-top-0">
											<%= addressLine2 %><hr class="mt-0 mb-1 border-top-0">
											<%= addressLine3 %>
										</td>
								    </tr>
								    <tr>
								    	<td>Phone number:</td>
										<td><%= phone %></td>
								    </tr>
								    <tr>
								    	<td>Email:</td>
										<td><%= email %></td>
								    </tr>
								</tbody>
								<caption class="small">
									You can contact your sales representative, <%= salesRepName %>, 
									at <a href="mailto:<%= salesPersonEmail %>"><%= salesPersonEmail %></a> for any further inquiries.
								</caption>
							</table>
					    </div>
					    <!-- ============================================================== -->
						<!-- End customer information -->
						<!-- ============================================================== -->
						<!-- ============================================================== -->
						<!-- Payment information -->
						<!-- ============================================================== -->
					    <div class="col-6 text-right payment-details">
					    	<p class="lead marginbottom payment-info mb-3">Payment details</p>
					    	<%
					    	// If paymentType == "Credit card" or "Debit card"
				    		String paymentType = (String) request.getAttribute("payment_type");
							if (!paymentType.equals("Online banking")) {
							%>
							<table class="table table-borderless table-sm small-table ml-auto">
								<tbody>
									<tr>
								    	<td>Payment method:</td>
										<td>Card</td>
								    </tr>
								    <tr>
								    	<td>Card type:</td>
										<td><%= paymentType %></td>
								    </tr>
								    <tr>
								    	<td>Card holder's name:</td>
										<td><%= request.getParameter("card_holder_name") %></td>
								    </tr>
								    <tr>
								    	<td>Card number:</td>
										<td><%= request.getParameter("card_number") %></td>
								    </tr>
								    <tr>
								    	<td>Card expiration date:</td>
								    	<% 
								        String cardMonth = String.format("%02d", Integer.valueOf(request.getParameter("card_month")));
								        String cardCVV = String.format("%03d", Integer.valueOf(request.getParameter("card_cvv")));
								        %>
										<td><%= cardMonth %>/<%= request.getParameter("card_year") %></td>
								    </tr>
								    <tr>
								    	<td>Card CVV:</td>
										<td><%= cardCVV %></td>
								    </tr>
								</tbody>
							</table>
							<%
							}
							//Else if paymentType == "Online banking" 
							else {
							%>
							<table class="table table-borderless table-sm small-table ml-auto">
								<tbody>
									<tr>
								    	<td>Payment method:</td>
										<td>Bank transfer</td>
								    </tr>
								    <tr>
								    	<td>Bank holder name:</td>
										<td><%= request.getParameter("bank_holder_name") %></td>
								    </tr>
								    <tr>
								    	<td>Bank name:</td>
								    	<%
								    	Bank banks = new Bank();
										HashMap<String, String> bankList = banks.getList();
										String bankKey = request.getParameter("bank_name");
										String bankName = bankList.get(bankKey);
								    	%>
										<td><%= bankName %></td>
								    </tr>
								    <tr>
								    	<td>Bank account number:</td>
										<td><%= request.getParameter("bank_account_number") %></td>
								    </tr>
								</tbody>
							</table>
					    	<%
					    	}
					    	%>
					    </div>
						<!-- ============================================================== -->
						<!-- End payment information -->
						<!-- ============================================================== -->
					</div>
					<!-- ============================================================== -->
					<!-- Purchase information -->
					<!-- ============================================================== -->
					<div class="row table-row">
						<table class="table table-striped price-table">
							<thead>
								<tr>
									<th scope="row" class="text-center" style="width:5%">#</th>
									<th style="width:50%">Item</th>
									<th class="text-right" style="width:15%">Quantity</th>
									<th class="text-right" style="width:15%">Unit Price</th>
									<th class="text-right" style="width:15%">Total Price</th>
								</tr>
							</thead>
							<tbody>
								<%
								// Display each purchased product
								int orderLineNumber = 0;
								for (ShoppingCartItem purchasedOrderItem : purchasedOrderProduct.getList()) {
								 %>
									<tr>
										<td class="text-center"><%= ++orderLineNumber %></td>
										<td class="text-left"><%= purchasedOrderItem.getProductname() %></td>
										<td class="text-center"><%= purchasedOrderItem.getQuantity() %></td>
										<td class="text-right"><%= purchasedOrderItem.getMsrp().toString() %></td>
										<td class="text-right"><%= purchasedOrderItem.getSubPriceString() %></td>
									</tr>
								<%
								}
								%>
							</tbody>
							<% 
							// Display subtotal
							BigDecimal totalOrderAmount = purchasedOrderProduct.getTotalPrice();
							BigDecimal taxAmount = totalOrderAmount.multiply(new BigDecimal(0.06));
							BigDecimal finalOrderAmount = totalOrderAmount.add(taxAmount);
							%>
							<tfoot>
								<tr>
									<td scope="row" class="text-left" colspan="4">Sub-total</td>
									<td class="text-right"><%= String.format("%.2f", totalOrderAmount.doubleValue()) %></td>
								</tr>
								<tr>
									<td class="text-left" colspan="4">SST (6%) : </td>
									<td class="text-right" ><%= String.format("%.2f", taxAmount.doubleValue()) %></td>
								</tr>
								<tr class="border-bottom">
									<td class="text-left" colspan="4">Total</td>
									<td class="text-right"><%= String.format("%.2f", finalOrderAmount.doubleValue()) %></td>
								</tr>
							</tfoot>
					    </table>
					</div>
					<!-- ============================================================== -->
					<!-- End purchase information -->
					<!-- ============================================================== -->
					<!-- ============================================================== -->
					<!-- Download and print receipt -->
					<!-- ============================================================== -->
					<div class="row invoice-total d-print-none">
						<div class="col-5 mt-3 mx-auto d-flex justify-content-center">
							<button class="btn btn-success" id="invoice-print"><i class="fa fa-print"></i> Download and Print Invoice</button>
						</div>
					</div>
					<!-- ============================================================== -->
					<!-- End download and print receipt -->
					<!-- ============================================================== -->
				  </div>
				</div>
			</div>
		</div>
	</div>
	<div class="d-print-none">
		<!-- Include Footer JSP -->
		<jsp:include page="footer.jsp" />  
	</div>
</body>
</html>