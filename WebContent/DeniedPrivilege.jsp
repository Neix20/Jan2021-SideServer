<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	session.invalidate();
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
<title>Denied Privilege</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/frontend/assets/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/frontend/assets/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/frontend/assets/css/login-form.css">

<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/frontend/assets/js/jquery-2.1.0.min.js"></script>

<!-- Bootstrap -->
<script
	src="${pageContext.request.contextPath}/frontend/assets/js/popper.js"></script>
<script
	src="${pageContext.request.contextPath}/frontend/assets/js/bootstrap.min.js"></script>

</head>

<body>
	<!-- ***** Preloader Start ***** -->
	<div id="js-preloader" class="js-preloader loaded">
		<div class="preloader-inner">
			<span class="dot"></span>
			<div class="dots">
				<span></span> <span></span> <span></span>
			</div>
		</div>
	</div>
	<!-- ***** Preloader End ***** -->

	<!-- ***** Header Area Start ***** -->
	<header class="header-area header-sticky background-header">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<nav class="main-nav">
						<!-- ***** Logo Start ***** -->
						<a href="${pageContext.request.contextPath}" class="logo">Vehicle
							Models <em>Website</em>
						</a>
						<!-- ***** Logo End ***** -->
						<!-- ***** Menu Start ***** -->
						<ul class="nav">
							<li><a href="${pageContext.request.contextPath}">Home</a></li>
							<li><a
								href="${pageContext.request.contextPath}/productCatalog">Vehicle
									Models</a></li>
							<li><a
								href="${pageContext.request.contextPath}/shoppingCart">Shopping
									Cart</a></li>
							<li><a href="${pageContext.request.contextPath}/manageDashboard">Login</a></li>
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

	<!--Login Form-->
	<div style="height: 80px"></div>
	<section
		style="background-color: #772f1a; background-image: linear-gradient(315deg, #772f1a 0%, #f2a65a 74%); height: 560px;">
		<div style="height: 80px;"></div>
		<div class="d-flex justify-content-center align-items-center">
			<div>
				<div class="account-wall p-3" style="width: 400px;">
					<div class="h1 text-center">Oops!</div>
					<img class="profile-img"
						src="${pageContext.request.contextPath}/frontend/assets/images/warning.jpg"
						alt="">
					<div class="h3 text-center">You are not allowed the privilege</div>
					<div class="d-flex justify-content-center align-items-center">
						<a class="btn btn-primary"
							href="${pageContext.request.contextPath}/manageDashboard">Back to
							Login Page</a>
					</div>
				</div>
			</div>
		</div>
	</section>

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
	<script
		src="${pageContext.request.contextPath}/frontend/assets/js/scrollreveal.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/frontend/assets/js/waypoints.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/frontend/assets/js/jquery.counterup.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/frontend/assets/js/imgfix.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/frontend/assets/js/mixitup.js"></script>
	<script
		src="${pageContext.request.contextPath}/frontend/assets/js/accordions.js"></script>


</body>

</html>