<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="domain.ShoppingCart"%>
<%@ page import="domain.ShoppingCartItem"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.HashMap"%>
<%
	ShoppingCart scList = (ShoppingCart) session.getAttribute("ShoppingCart");
	if (scList == null) scList = new ShoppingCart();
 	BigDecimal temp = scList.getTotalPrice();
 	BigDecimal taxAmount = temp.multiply(new BigDecimal(0.06));
 	temp = temp.multiply(new BigDecimal(1.06));
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap"
	rel="stylesheet">
<title>Shopping Cart Page</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/frontend/assets/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/frontend/assets/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- jQuery -->

<script
	src="${pageContext.request.contextPath}/frontend/assets/js/jquery-2.1.0.min.js"></script>

<!-- Bootstrap -->
<script
	src="${pageContext.request.contextPath}/frontend/assets/js/popper.js"></script>
<script
	src="${pageContext.request.contextPath}/frontend/assets/js/bootstrap.min.js"></script>
<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

/* Firefox */
input[type=number] {
	-moz-appearance: textfield;
}
</style>

</head>

<body>
	<%@ include file="header.jsp"%>

	<!-- ***** Call to Action Start ***** -->
	<section class="section section-bg" id="call-to-action"
		style="background-image: url(${pageContext.request.contextPath}/frontend/assets/images/banner-image-1-1920x500.jpg)">
		<div class="container">
			<div class="row">
				<div class="col-lg-10 offset-lg-1">
					<div class="cta-content">
						<br> <br>
						<h2>
							Shopping <em>Cart</em>
						</h2>
						<p>Ut consectetur, metus sit amet aliquet placerat, enim est
							ultricies ligula</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ***** Call to Action End ***** -->

	<div class="container">
		<!--Section: Block Content-->
		<section>
			<!--Grid row-->
			<div class="row">

				<!--Grid column-->
				<div class="col-lg-8">

					<!-- Card -->
					<div class="mb-3">
						<div class="pt-4 wish-list">

							<h5 class="mb-4">
								Cart (<span> <%=scList.count()%>
								</span> items)
							</h5>

							<%
								for (ShoppingCartItem sc : scList.getList()) {
									String type = sc.getProductline().split(" ")[0];
							%>
							<form action="${pageContext.request.contextPath}/ShoppingCart" method="post">
								<div class="row mb-4">
									<div class="col-md-5 col-lg-3 col-xl-3">
										<img
											src="${pageContext.request.contextPath}/frontend/assets/images/<%=type%>.jpg"
											style="width: 100%;" />
									</div>
									<div class="col-md-7 col-lg-9 col-xl-9">
										<div>
											<div class="d-flex justify-content-between">
												<div>
													<h5>
														<%=sc.getProductname()%>
													</h5>
													<p class="mb-3 text-muted text-uppercase small">
														Model:
														<%=sc.getProductline()%>
													</p>
													<p class="mb-2 text-muted text-uppercase small">
														Vendor:
														<%=sc.getProductvendor()%>
													</p>
													<p class="mb-3 text-muted text-uppercase small">
														Scale:
														<%=sc.getProductscale()%>
													</p>
												</div>
												<div>
													<div
														class="def-number-input number-input safari_only mb-0 w-100">
														<button name="type" value="minus"
															class="btn btn-primary minus">&#9660;</button>
														<input name="productName" value="<%=sc.getProductname()%>"
															hidden /> <input class="text-right buy_quantity"
															style="width: 50px;" name="buy_quantity"
															value="<%=sc.getQuantity()%>" type="number" min="1"
															max="<%=sc.getQuantityinstock()%>" disabled />
														<button name="type" value="plus"
															class="btn btn-primary plus">&#9650;</button>
													</div>
													<small id="passwordHelpBlock"
														class="form-text text-muted text-center"> (Note, 1
														piece) </small>
												</div>
											</div>
											<div
												class="d-flex justify-content-between align-items-center">
												<div>
													<button name="type" value="remove"
														class="btn btn-primary text-uppercase mr-3">
														<i style="font-size: 24px" class="fa">&#xf014;</i> Remove
														item
													</button>
												</div>
												<p class="mb-0">
													<span><strong id="summary">RM <%=sc.getSubPriceString()%></strong></span>
												</p>
											</div>
										</div>
									</div>
								</div>
							</form>
							<%
								}
							%>
							<hr class="mb-4">
							<p class="text-primary mb-0">
								<i style="font-size: 24px" class="fa">&#xf059;</i> Do not delay
								the purchase, adding items to your cart does not mean booking
								them.
							</p>

						</div>
					</div>
					<!-- Card -->

					<!-- Card -->
					<div class="mb-3">
						<div class="pt-4">

							<h5 class="mb-4">Expected shipping delivery</h5>

							<p class="mb-0">Thu., 12.03. - Mon., 16.03.</p>
						</div>
					</div>
					<!-- Card -->

					<!-- Card -->
					<div class="mb-3">
						<div class="pt-4">

							<h5 class="mb-4">We accept</h5>

							<img class="mr-2" width="45px"
								src="https://mdbootstrap.com/wp-content/plugins/woocommerce-gateway-stripe/assets/images/visa.svg"
								alt="Visa"> <img class="mr-2" width="45px"
								src="https://mdbootstrap.com/wp-content/plugins/woocommerce-gateway-stripe/assets/images/amex.svg"
								alt="American Express"> <img class="mr-2" width="45px"
								src="https://mdbootstrap.com/wp-content/plugins/woocommerce-gateway-stripe/assets/images/mastercard.svg"
								alt="Mastercard"> <img class="mr-2" width="45px"
								src="https://mdbootstrap.com/wp-content/plugins/woocommerce/includes/gateways/paypal/assets/images/paypal.png"
								alt="PayPal acceptance mark">
						</div>
					</div>
					<!-- Card -->

				</div>
				<!--Grid column-->

				<!--Grid column-->
				<div class="col-lg-4">

					<!-- Card -->
					<div class="mb-3">
						<div class="pt-4">

							<h5 class="mb-3">The total amount of</h5>

							<ul class="list-group list-group-flush">
								<li
									class="list-group-item d-flex justify-content-between align-items-center px-0 pb-0">
									Temporary amount <span>RM<%=scList.getTotalPrice().toString()%></span>
								</li>
								<li
									class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 pb-0">
									Tax amount (6%) <span>RM<%=String.format("%.2f", taxAmount.doubleValue())%></span>
								</li>
								<li
									class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
									<div>
										<strong>The total amount of</strong> <strong>
											<p class="mb-0">(including SST)</p>
										</strong>
									</div> <span> <strong>RM <%=String.format("%.2f", temp.doubleValue())%>
									</strong>
								</span>
								</li>
							</ul>

							<a href="${pageContext.request.contextPath}/Checkout" type="submit"
								class="btn btn-primary btn-block">go to checkout</a>
						</div>
					</div>
					<!-- Card -->

				</div>
				<!--Grid column-->

			</div>
			<!-- Grid row -->

		</section>
		<!--Section: Block Content-->
	</div>

	<!-- ***** Footer Start ***** -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<p>
						Copyright � 2020 Company Name - Template by: <a
							href="https://www.phpjabbers.com/">PHPJabbers.com</a>
					</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- Plugins -->
	<script src="${pageContext.request.contextPath}/frontend/assets/js/scrollreveal.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/js/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/js/jquery.counterup.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/js/imgfix.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/js/mixitup.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/js/accordions.js"></script>

	<!-- Global Init -->
	<script src="${pageContext.request.contextPath}/frontend/assets/js/custom.js"></script>

</body>

</html>