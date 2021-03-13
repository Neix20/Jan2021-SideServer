<%--
Author	  : Yap Jheng Khin
Page info : 'Review order' section of the checkout page
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="domain.ShoppingCart"%>
<%@ page import="domain.ShoppingCartItem"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.HashMap"%>
<%
	ShoppingCart orderList = (ShoppingCart) session.getAttribute("order_product");
	BigDecimal total = orderList.getTotalPrice();
	total = total.multiply(new BigDecimal(1.06));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Review Order</title>
</head>
<body>
	<div class="panel-group" id="accordion">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title mb-3">			
					<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
					<i class="fa icon-change" aria-hidden="true"></i>
					Review Your Order
					</a>
				</h4>
			</div>
			<div id="collapseOne" class="panel-collapse collapse in">
				<div class="panel-body">
					<div class="items">
						<%
							for (ShoppingCartItem order : orderList.getList()) {
								String type = order.getProductline().split(" ")[0];
						%>
						<div class="row d-flex align-items-center">
							<div class="col-12 mb-2">
								<h5><%=order.getProductname()%></h5>
							</div>
							<div class="col-md-5 col-lg-3 col-xl-3">
								<img
									src="${pageContext.request.contextPath}/frontend/assets/images/<%=type%>.jpg"
									style="width: 100%;" />
							</div>
							<div class="col-md-7 col-lg-9 col-xl-9">
								<table class="table table-hover table-borderless table-sm ">
									<tr>
										<td>Model</td>
										<td><%=order.getProductline()%></td>
									</tr>
									<tr>
										<td>Vendor</td>
										<td><%=order.getProductvendor()%></td>
									</tr>
									<tr>
										<td>Scale</td>
										<td><%=order.getProductscale()%></td>
									</tr>
									<tr>
										<td>Order quantity</td>
										<td><%=order.getQuantity()%></td>
									</tr>
									<tr>
										<td><em>Sub-price</em></td>
										<td>RM<%=order.getSubPriceString()%></td>
									</tr>
								</table>
								<!--<div class="def-number-input number-input safari_only mb-0 w-100"> -->
								<%--<p class="text-right buy_quantity"><%out.print(order.getQuantity());%></p> --%>
								<%--<%//TODO Want to check quantity in stock when checkout?// out.print(order.getQuantityinstock());%>" --%>
								<!--</div> -->
							</div>
						</div>
						<%
							}
						%>
						<div style="text-align: center;"
							class="row d-flex justify-content-end align-items-center mb-3">
							<h4 class="ml-3">Order Total (Included 6% SST):</h4>
							<h4 class="ml-auto" style="color: green;">
								RM<%=String.format("%.2f", total.doubleValue())%>
							</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>