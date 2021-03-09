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
	String[] category = (String[]) request.getAttribute("category");
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
        $(function(){
            $(".btnDropDown").on("click", e => {
                let str = $(e.target).siblings(".detail_board").css("display");
                (str == "none") ? $(e.target).siblings(".detail_board").css("display", "hidden") : $(e.target).siblings(".detail_board").css("display", "none");
            });
        });
    </script>

</head>

<body>
	<%@ include file="header.jsp"%>

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
			<form action="ProductCatalog" method="GET">
				<div class="row py-3">
					<div class="col-2">
						<button type="button" class="btn btn-primary btnDropDown">Category
							&#9660;</button>
						<div class="detail_board p-1"
							style="height: 240px; width: 100%; background-color: rgb(211, 211, 211); display: none; position: absolute; z-index: 2; right: -12px;">
							<%
								for (Productline pl : ProductlineList) {
							%>
							<input type="checkbox" name="category"
								value="<%out.print(pl.getProductline());%>" /> <label
								for="all"> <% out.print(pl.getProductline()); %>
							</label><br />
							<%
								}
							%>
						</div>
					</div>
					<div class="col-2">
						<button type="button" class="btn btn-primary btnDropDown">Sort
							By &#9660;</button>
						<div class="detail_board p-1"
							style="height: 135px; width: 100px; background-color: rgb(211, 211, 211); display: none; position: absolute; z-index: 2; right: 75px;">
							<input type="radio" name="sort_keyword" value="name_asc" /> <label
								for="name_asc">Name &#9650;</label><br /> <input type="radio"
								name="sort_keyword" value="name_desc" /> <label for="name_desc">Name
								&#9660;</label><br /> <input type="radio" name="sort_keyword"
								value="price_asc" /> <label for="price_asc">Price
								&#9650;</label><br /> <input type="radio" name="sort_keyword"
								value="price_desc" /> <label for="price_desc">Price
								&#9660;</label>
						</div>
					</div>
					<div class="col-7"></div>
					<div class="col-1">
						<button class="btn btn-primary">Submit</button>
					</div>
				</div>
			</form>

			<div class="row">
				<%
					for (Product p : Productlist) {
						String type = p.getProductline().split(" ")[0];
				%>
				<div class="col-lg-4">
					<div class="trainer-item">
						<div class="image-thumb">
							<img
								src="frontend/assets/images/<%=type%>.jpg"
								alt="" style="width: 100%;">
						</div>
						<div class="down-content">
							<span> <sup>RM</sup> <%
 	out.print(p.getMsrp().toString());
 %>
							</span>

							<h4>
								<%
									out.print(p.getProductname());
								%>
							</h4>

							<ul class="social-icons">
								<li><a
									href="productDetails?productCode=<%out.print(p.getProductcode());%>&image_url=<%=type%>.jpg">+
										View Model</a></li>
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
								link = "<a class=\"page-link\" href=\"ProductCatalog?"+html_generator.getParameterArrayValues("category", category)+"&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage - 2)
										+ "\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span><span class=\"sr-only\">Previous</span></a>";
								out.println(link);
							}
						%>
					</li>
					<li class="page-item">
						<%
							if (currentPage > 1) {
								link = "<a class=\"page-link\" href=\"ProductCatalog?"+html_generator.getParameterArrayValues("category", category)+"&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage - 1) + "\">" + (currentPage - 1) + "</a>";
								out.println(link);
							}
						%>
					</li>
					<li class="page-item">
						<%
							link = "<a class=\"page-link\" href=\"ProductCatalog?"+html_generator.getParameterArrayValues("category", category)+"&sort_keyword=" + sort
									+ "&currentPage=" + currentPage + "\"><b>" + currentPage + "</b></a>";
							out.println(link);
						%>
					</li>
					<li class="page-item">
						<%
							if (currentPage < nOfPage) {
								link = "<a class=\"page-link\" href=\"ProductCatalog?"+html_generator.getParameterArrayValues("category", category)+"&sort_keyword=" + sort
										+ "&currentPage=" + (currentPage + 1) + "\">" + (currentPage + 1) + "</a>";
								out.println(link);
							}
						%>
					</li>
					<li class="page-item">
						<%
							if (currentPage < nOfPage - 1) {
								link = "<a class=\"page-link\" href=\"ProductCatalog?"+html_generator.getParameterArrayValues("category", category)+"&sort_keyword=" + sort
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