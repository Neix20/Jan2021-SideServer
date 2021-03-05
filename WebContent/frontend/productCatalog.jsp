<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="domain.Product"%>
<%@ page import="domain.Productline"%>
<%@ page import="utility.html_generator"%>
<%
	List<Product> Productlist = (List<Product>) request.getAttribute("List");
	List<Productline> ProductlineList = (List<Productline>) request.getAttribute("ProductlineList");
	int currentPage = (Integer) request.getAttribute("currentPage");
	int nOfPage = (Integer) request.getAttribute("nOfPage");
	String category = (String) request.getAttribute("category");
	String sort = (String) request.getAttribute("sort_keyword");
	String link;
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
<title>Product Catalog</title>
<link rel="stylesheet" type="text/css"
	href="frontend/assets/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="frontend/assets/css/font-awesome.css">
<link rel="stylesheet" href="frontend/assets/css/style.css">

<script src="frontend/assets/js/jquery-2.1.0.min.js"></script>
<script>
	$(function() {
		$('#category').change(function() {
			$("#query_form").submit();
		});

		$('#sort').change(function() {
			$("#query_form").submit();
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
						<a href="index.html" class="logo">Vehicle Models <em>Website</em></a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li><a href="index.html">Home</a></li>
							<li><a href="productCatalog">Vehicle Models</a></li>
							<li><a href="frontend/shoppingCart.jsp">Shopping Cart</a></li>
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
							Product <em>Catalog</em>
						</h2>
						<p>Ut consectetur, metus sit amet aliquet placerat, enim est
							ultricies ligula</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ***** Call to Action End ***** -->

	<!-- ***** Fleet Starts ***** -->
	<section class="section" id="trainers">
		<div class="container">
			<form action="ProductServlet" method="GET" id="query_form">
				<div class="row py-3">
					<div class="col-2 text-right">Category:</div>
					<div class="col-2">
						<select id="category" name="category">
							<option value="all"></option>
							<option value="all">All</option>
							<%
								for (Productline p : ProductlineList) {
							%>
							<option value="<%out.print(p.getProductline());%>">
								out.print(p.getProductline());</option>
							<%
								}
							%>
						</select>
					</div>
					<div class="col-4"></div>
					<div class="col-2 text-right">Sort By:</div>
					<div class="col-2">
						<select id="sort" name="sort_keyword">
							<option value="name_ASC"></option>
							<option value="name_ASC">Name &#9650;</option>
							<option value="name_DESC">Name &#9660;</option>
							<option value="price_ASC">Price &#9650;</option>
							<option value="price_DESC">Price &#9660;</option>
						</select>
					</div>
				</div>
			</form>

			<div class="row">
				<%
					HashMap<String, Integer> map = new HashMap<String, Integer>();
					for (Productline pl : ProductlineList)
						map.put(pl.getProductline().split(" ")[0], 1);
					for (Product p : Productlist) {
						String type = p.getProductline().split(" ")[0];
						int number = map.get(type);
						if (number > 6)
							number = 0;
						map.put(type, number + 1);
				%>
				<div class="col-lg-4">
					<div class="trainer-item">
						<div class="image-thumb">
							<img src="frontend/assets/images/<% out.print(type + "_" + number); %>.jpg" alt="" style="width: 100%;">
						</div>
						<div class="down-content">
							<span> <sup>RM</sup><% out.print(p.getMsrp().toString()); %>
							</span>

							<h4><% out.print(p.getProductname()); %></h4>

							<ul class="social-icons">
								<li><a href="productDetails?productCode=<% out.print(p.getProductcode()); %>&image_url=<% out.print(type + "_" + number + ".jpg"); %>">+ View Model</a></li>
							</ul>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>

			<br>

			<nav>
				<ul class="pagination pagination-lg justify-content-center">
					<li class="page-item">
						<%
							if (currentPage > 2) {
								link = "<a class=\"page-link\" href=\"ProductServlet?category=" + category + "&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage - 2)
										+ "\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span><span class=\"sr-only\">Previous</span></a>";
								out.println(link);
							}
						%>
					</li>
					<li class="page-item">
						<%
							if (currentPage > 1) {
								link = "<a class=\"page-link\" href=\"ProductServlet?category=" + category + "&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage - 1) + "\">" + (currentPage - 1) + "</a>";
								out.println(link);
							}
						%>
					</li>
					<li class="page-item">
						<%
							link = "<a class=\"page-link\" href=\"ProductServlet?category=" + category + "&sort_keyword=" + sort
									+ "&currentPage=" + currentPage + "\"><b>" + currentPage + "</b></a>";
							out.println(link);
						%>
					</li>
					<li class="page-item">
						<%
							if (currentPage < nOfPage) {
								link = "<a class=\"page-link\" href=\"ProductServlet?category=" + category + "&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage + 1) + "\">" + (currentPage + 1) + "</a>";
								out.println(link);
							}
						%>
					</li>
					<li class="page-item">
						<%
							if (currentPage < nOfPage - 1) {
								link = "<a class=\"page-link\" href=\"ProductServlet?category=" + category + "&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage + 2)
										+ "\" aria-label=\"Next\"><span aria-hidden=\"true\">&raquo;</span><span class=\"sr-only\">Next</span></a>";
								out.println(link);
							}
						%>
					</li>
				</ul>
			</nav>

		</div>
	</section>
	<!-- ***** Fleet Ends ***** -->


	<!-- ***** Footer Start ***** -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<p>
						Copyright 2020 Company Name - Template by: <a
							href="https://www.phpjabbers.com/">PHPJabbers.com</a>
					</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- jQuery -->
	<script src="frontend/assets/js/jquery-2.1.0.min.js"></script>

	<!-- Bootstrap -->
	<script src="frontend/assets/js/popper.js"></script>
	<script src="frontend/assets/js/bootstrap.min.js"></script>

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