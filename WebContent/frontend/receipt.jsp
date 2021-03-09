<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="domain.ShoppingCart" %>
<%@page import="domain.ShoppingCartItem" %>
<%@page import="domain.Employee" %>
<%@page import="java.math.BigDecimal" %>
<%
ShoppingCart purchasedOrderProduct = (ShoppingCart) request.getAttribute("purchased_order_product");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Receipt</title>
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
<style>
	body{
		margin-top:20px;
		background: white;
	}
	/*Invoice*/
	.invoice .top-left {
	    font-size:65px;
		color:#3ba0ff;
	}
	
	.invoice .top-right {
		text-align:right;
		padding-right:20px;
	}
	
	.invoice .table-row {
		margin-left:-15px;
		margin-right:-15px;
		margin-top:25px;
	}
	
	.invoice .payment-info {
		font-weight:500;
	}
	
	.invoice .table-row .table>thead {
		border-top:1px solid #ddd;
	}
	
	.invoice .table-row .table>thead>tr>th {
		border-bottom:none;
	}
	
	.invoice .price-table>tbody>tr>td {
		padding:8px 20px;
	}
	
	.invoice .invoice-total {
		margin-right:-10px;
		font-size:16px;
	}
	
	.invoice .last-row {
		border-bottom:1px solid #ddd;
	}
	
	.invoice-ribbon {
		width:85px;
		height:88px;
		overflow:hidden;
		position:absolute;
		top:-1px;
		right:14px;
	}
	
	.ribbon-inner {
		text-align:center;
		-webkit-transform:rotate(45deg);
		-moz-transform:rotate(45deg);
		-ms-transform:rotate(45deg);
		-o-transform:rotate(45deg);
		position:relative;
		padding:7px 0;
		left:-5px;
		top:11px;
		width:120px;
		background-color:#66c591;
		font-size:15px;
		color:#fff;
	}
	
	.ribbon-inner:before,.ribbon-inner:after {
		content:"";
		position:absolute;
	}
	
	.ribbon-inner:before {
		left:0;
	}
	
	.ribbon-inner:after {
		right:0;
	}
	
	@media(max-width:575px) {
		.invoice .top-left,.invoice .top-right,.invoice .payment-details {
			text-align:center;
		}
	
		.invoice .from,.invoice .to,.invoice .payment-details {
			float:none;
			width:100%;
			text-align:center;
			margin-bottom:25px;
		}
	
		.invoice p.lead,.invoice .from p.lead,.invoice .to p.lead,.invoice .payment-details p.lead {
			font-size:22px;
		}
	
		.invoice .btn {
			margin-top:10px;
		}
	}
	
	@media print {
		.invoice {
			width:900px;
			height:800px;
		}
	}
	
	.small-table {
		margin: 0;
	}
	
	.small-table td {
		margin: 0;
		font-size: 14px;
		color: black;
		line-height: 1.0;
	}
	
	p {
		color: black;
	}

</style>
</head>
<body>
	<!-- Include Header JSP -->
	<jsp:include page="header.jsp" />
	
	<!-- ***** Call to Action Start ***** -->
    <section class="section section-bg" id="call-to-action"
        style="background-image: url(frontend/assets/images/banner-image-1-1920x500.jpg)">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cta-content">
                        <br>
                        <br>
                        <h2><em>Receipt</em></h2>
                        <p>Thank you for purchasing. Please save and print your receipt before closing the browser.</p>
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
				    <div class="row mt-5 d-flex justify-content-between align-items-center">
<!-- 						<div class="col-sm-6"> -->
<!-- 							<i class="fa fa-rocket"></i> -->
<!-- 						</div> -->
						<h3 class="marginright">RECEIPT - <%= request.getAttribute("invoice_no") %></h3>
						<span class="marginright">14 April 2014</span>
					</div>
					<hr>
					<div class="row d-flex justify-content-between align-items-start">
				
						<div class="col-6 to">
							<%
								//Retrieve billing information a.k.a. customer information
								String customerName = request.getParameter("customername"); 
								String contactFirstname = request.getParameter("contact_firstname"); 
								String contactLastname = request.getParameter("contact_lastname"); 
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
								String salesRepName = salesRep.getFirstname() + salesRep.getLastname();
								
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
								    <tr>
								    	<td>Card CVV:</td>
										<td><%= request.getParameter("card_cvv") %></td>
								    </tr>
								</tbody>
								<caption class="small">
									You can contact your sales representative, <%= salesRepName %>, 
									at <%= salesPersonEmail %> for any further inquiries.
								</caption>
							</table>
					    </div>
		
					    <div class="col-6 text-right payment-details">
					    	<p class="lead marginbottom payment-info mb-3">Payment details</p>
					    	<%
				    		String paymentMethod = request.getParameter("payment_method");
							if (paymentMethod.equals("card")) {
								String cardType = request.getParameter("card_type");
								String cardTypeDisplay = "";
								if (cardType.equals("debit_card"))
									cardTypeDisplay = "Debit card";
								else
									cardTypeDisplay = "Credit card";
							%>
							<table class="table table-borderless table-sm small-table ml-auto">
								<tbody>
									<tr>
								    	<td>Payment method:</td>
										<td>Card</td>
								    </tr>
								    <tr>
								    	<td>Card type:</td>
										<td><%= cardTypeDisplay %></td>
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
										<td><%= request.getParameter("card_month") %>/<%= request.getParameter("card_year") %></td>
								    </tr>
								    <tr>
								    	<td>Card CVV:</td>
										<td><%= request.getParameter("card_cvv") %></td>
								    </tr>
								</tbody>
							</table>
							<%
								}
								else if (paymentMethod.equals("bank")) {
							%>
							<table class="table table-borderless table-sm small-table ml-auto">
								<tbody>
									<tr>
								    	<td>Payment method:</td>
										<td><%=request.getParameter("payment_method")%></td>
								    </tr>
								    <tr>
								    	<td>Bank holder name:</d>
										<td><%= request.getParameter("bank_holder_name") %></td>
								    </tr>
								    <tr>
								    	<td>Bank number:</td>
										<td><%= request.getParameter("bank_number") %></td>
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
		
					</div>
		
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
					<div class="row invoice-total">
						<div class="col-5 mt-3 mx-auto d-flex justify-content-center">
							<button class="btn btn-success" id="invoice-print"><i class="fa fa-print"></i> Print Invoice</button>
						</div>
					</div>
				  </div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Include Footer JSP -->
	<jsp:include page="footer.jsp" />  
</body>
</html>