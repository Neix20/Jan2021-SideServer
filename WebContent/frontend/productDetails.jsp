<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="domain.Product"%>
<%@ page import="domain.ShoppingCart"%>
<%@ page import="domain.ShoppingCartItem"%>
<%@ page import="utility.html_generator" %>
<%
	Product p = (Product) request.getAttribute("Product");
	String image_url = (String) request.getAttribute("image_url");
	String bought = request.getParameter("addBoolean");
	if(bought != null){
		int quantity = Integer.valueOf(request.getParameter("buy_quantity"));
		ShoppingCart scList = (ShoppingCart) session.getAttribute("ShoppingCart");
		if(scList == null) scList = new ShoppingCart();
		ShoppingCartItem sc = new ShoppingCartItem(p, quantity);
		scList.addItem(sc);
		session.setAttribute("ShoppingCart", scList);
	}
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

<title>Product Details</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/frontend/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/frontend/assets/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/style.css">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/frontend/assets/js/jquery-2.1.0.min.js"></script>

<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/frontend/assets/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/frontend/assets/js/bootstrap.min.js"></script>

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

<script>
    $(function () {
      $(".plus").on("click", e => {
        let num = $(e.target).siblings("input[type=number]").val(), 
          max_limit = parseInt($(e.target).siblings("input[type=number]").attr("max")),
          min_limit = parseInt($(e.target).siblings("input[type=number]").attr("min"));
        (num >= max_limit) ? $(e.target).prop("disabled", true) : $(e.target).siblings("input[type=number]").val(++num);
        if (num >= min_limit) $(e.target).siblings(".minus").prop("disabled", false);
      });

      $(".minus").on("click", e => {
        let num = $(e.target).siblings("input[type=number]").val(), 
          max_limit = parseInt($(e.target).siblings("input[type=number]").attr("max")),
          min_limit = parseInt($(e.target).siblings("input[type=number]").attr("min"));
        (num <= min_limit) ? $(e.target).prop("disabled", true) : $(e.target).siblings("input[type=number]").val(--num);
        if (num <= max_limit) $(e.target).siblings(".plus").prop("disabled", false);
      });

      $(".buy_quantity").on("keypress", e => {
        if (e.keyCode == 13) {
          let num = $(e.target).val(), max_limit = parseInt($(e.target).attr("max")), min_limit = parseInt($(e.target).attr("min"));
          if (num > max_limit) $(e.target).siblings(".plus").prop("disabled", true);
          if (num < min_limit) $(e.target).siblings(".minus").prop("disabled", true);
          if (num >= min_limit) $(e.target).siblings(".minus").prop("disabled", false);
          if (num <= max_limit) $(e.target).siblings(".plus").prop("disabled", false);
        }
      });

    });
    <%
    if(bought != null){
    	out.println(html_generator.add_Product_Shopping());
    }
    %>
  </script>
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
							Product<em> Details</em>
						</h2>
						<p>Ut consectetur, metus sit amet aliquet placerat, enim est
							ultricies ligula</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ***** Call to Action End ***** -->

	<!--Section: Block Content-->
	<div class="container pt-5">
		<div class="row">
			<!--Images-->
			<div class="col-md-6 mb-4 mb-md-0">
				<img src="${pageContext.request.contextPath}/frontend/assets/images/<%=image_url%>" style="width: 100%;" />
			</div>

			<!--Put into div class= container-->
			<div class="col-md-6">

				<h5><%=p.getProductname()%></h5>
				<p>
					<span class="mr-1"><strong>RM <%=p.getMsrp().toString()%></strong></span>
				</p>
				<p class="pt-1">
					<%=p.getProductdescription()%>
				</p>
				<div class="table-responsive">
					<table class="table table-sm table-borderless mb-0">
						<tbody>
							<tr>
								<th class="pl-0 w-25" scope="row"><strong>Model</strong></th>
								<td>
									<%=p.getProductline()%>
								</td>
							</tr>
							<tr>
								<th class="pl-0 w-25" scope="row"><strong>Scale</strong></th>
								<td>
									<%=p.getProductscale()%>
								</td>
							</tr>
							<tr>
								<th class="pl-0 w-25" scope="row"><strong>Vendor</strong></th>
								<td>
									<%=p.getProductvendor()%>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<hr>
				<form action="" method="post">
					<div class="mb-2">
						<table class="table table-sm table-borderless">
							<tbody>
								<tr>
									<td colspan="3">Quantity</td>
								</tr>
								<tr>
									<td>
										<button type="button" class="btn btn-primary minus">&#9660;</button>
										<input class="text-right buy_quantity" style="width: 100px;"
										name="buy_quantity" value="1" type="number" min="1"
										max="<%=p.getQuantityinstock()%>" />
										<button type="button" class="btn btn-primary plus">&#9650;</button>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<input name="addBoolean" value="true" hidden />
					<button type="submit" class="btn btn-primary btn-md mr-1 mb-2">
						<i style="font-size: 24px" class="fa">&#xf07a;</i>
						Add to cart
					</button>
				</form>
			</div>
		</div>
	</div>
	<!--Section: Block Content-->


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