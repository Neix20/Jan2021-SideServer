<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="domain.Product"%>
<%
Product p = (Product) request.getAttribute("Product");
String image_url = (String) request.getAttribute("image_url");
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
	href="frontend/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="frontend/assets/css/font-awesome.css">
<link rel="stylesheet" href="frontend/assets/css/style.css">

<!-- jQuery -->
<script src="frontend/assets/js/jquery-2.1.0.min.js"></script>

<!-- Bootstrap -->
<script src="frontend/assets/js/popper.js"></script>
<script src="frontend/assets/js/bootstrap.min.js"></script>

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
      let num = 0;
      let max_limit = <% out.print(p.getQuantityinstock()); %>, min_limit = 1;

      $("#buy_quantity").attr("min", min_limit);
      $("#buy_quantity").attr("max", max_limit);

      $("#plus").on("click", _ => {
        num = $("#buy_quantity").val();
        (num >= max_limit) ? $("#plus").prop("disabled", true) : $("#buy_quantity").val(++num);
        if (num >= min_limit) $("#minus").prop("disabled", false);
      });

      $("#minus").on("click", _ => {
        num = $("#buy_quantity").val();
        (num <= min_limit) ? $("#minus").prop("disabled", true) : $("#buy_quantity").val(--num);
        if (num <= max_limit) $("#plus").prop("disabled", false);
      });

      $("#buy_quantity").on("keypress", e => {
        if (e.keyCode == 13) {
          num = $("#buy_quantity").val();
          if (num > max_limit) $("#plus").prop("disabled", true);
          if (num < min_limit) $("#minus").prop("disabled", true);
          if (num >= min_limit) $("#minus").prop("disabled", false);
          if (num <= max_limit) $("#plus").prop("disabled", false);
        }
      });

    });
  </script>
</head>

<body>

	<!-- ***** Preloader Start ***** -->
	<div id="js-preloader" class="js-preloader">
		<div class="preloader-inner">
			<span class="dot"></span>
			<div class="dots">
				<span></span> <span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- ***** Preloader End ***** -->

	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->
						<a href="index.html" class="logo">Vehicle Models<em>
								Website</em></a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li><a href="index.html">Home</a></li>
							<li><a href="ProductCatalog" class="active">Vehicle
									Models</a></li>
							<li><a href="contact.html">Contact</a></li>
						</ul>
						<a class='menu-trigger'> <span>Menu</span>
						</a>
						<!-- ***** Menu End ***** -->
					</nav>
				</div>
			</div>
		</div>
	</header>
	<!-- ***** Header Area End ***** -->

	<!-- ***** Call to Action Start ***** -->
	<section class="section section-bg" id="call-to-action"
		style="background-image: url(frontend/assets/images/banner-image-1-1920x500.jpg)">
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
				<img src="frontend/assets/images/<% out.print(image_url); %>" style="width: 100%;" />
			</div>

			<!--Put into div class= container-->
			<div class="col-md-6">

				<h5><% out.print(p.getProductname()); %></h5>
				<p><span class="mr-1"><strong>RM<% out.print(p.getMsrp().toString()); %></strong></span></p>
				<p class="pt-1"><% out.print(p.getProductdescription()); %></p>
				<div class="table-responsive">
					<table class="table table-sm table-borderless mb-0">
						<tbody>
							<tr>
								<th class="pl-0 w-25" scope="row"><strong>Model</strong></th>
								<td><% out.print(p.getProductline()); %></td>
							</tr>
							<tr>
								<th class="pl-0 w-25" scope="row"><strong>Scale</strong></th>
								<td><% out.print(p.getProductscale()); %></td>
							</tr>
							<tr>
								<th class="pl-0 w-25" scope="row"><strong>Vendor</strong></th>
								<td><% out.print(p.getProductvendor()); %></td>
							</tr>
						</tbody>
					</table>
				</div>
				<hr>

				<div class="mb-2">
					<table class="table table-sm table-borderless">
						<tbody>
							<tr>
								<td colspan="3">Quantity</td>
							</tr>
							<tr>
								<td>
									<button class="btn btn-primary" id="minus">&#9660;</button> <input
									class="text-right" id="buy_quantity" style="width: 100px;"
									name="buy_quantity" value="1" type="number" />
									<button class="btn btn-primary" id="plus">&#9650;</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<button type="button" class="btn btn-primary btn-md mr-1 mb-2">Add
					to cart</button>
			</div>
		</div>
	</div>
	<!--Section: Block Content-->


	<!-- Plugins -->
	<script src="frontend/assets/js/scrollreveal.min.js"></script>
	<script src="frontend/assets/js/waypoints.min.js"></script>
	<script src="frontend/assets/js/jquery.counterup.min.js"></script>
	<script src="frontend/assets/js/imgfix.min.js"></script>
	<script src="frontend/assets/js/mixitup.js"></script>
	<script src="frontend/assets/js/accordions.js"></script>

	<!-- Global Init -->
	<script src="frontend/assets/js/custom.js"></script>

</body>

</html>