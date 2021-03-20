<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Backend Header</title>
<link rel="canonical"
	href="https://www.wrappixel.com/templates/ample-admin-lite/" />
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="${ pageContext.request.contextPath }/backend/assets/plugins/images/favicon.png">
<!-- Custom CSS -->
<link
	href="${ pageContext.request.contextPath }/backend/assets/css/style.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script
	src="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<header class="topbar" data-navbarbg="skin5">
		<nav class="navbar top-navbar navbar-expand-md navbar-dark">
			<div class="navbar-header" data-logobg="skin6">
				<!-- ============================================================== -->
				<!-- Logo -->
				<!-- ============================================================== -->
				<a class="navbar-brand" href="dashboard.html"> <!-- Logo icon -->
					<b class="logo-icon"> <!-- Dark Logo icon --> <img
						src="${ pageContext.request.contextPath }/backend/assets/plugins/images/logo-icon.png"
						alt="homepage" />
				</b> <!--End Logo icon --> <!-- Logo text --> <span class="logo-text">
						<!-- dark Logo text --> <img
						src="${ pageContext.request.contextPath }/backend/assets/plugins/images/logo-text.png"
						alt="homepage" />
				</span>
				</a>
				<!-- ============================================================== -->
				<!-- End Logo -->
				<!-- ============================================================== -->
				<!-- ============================================================== -->
				<!-- toggle and nav items -->
				<!-- ============================================================== -->
				<a
					class="nav-toggler waves-effect waves-light text-dark d-block d-md-none"
					href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
			</div>
			<!-- ============================================================== -->
			<!-- End Logo -->
			<!-- ============================================================== -->
			<div class="navbar-collapse collapse" id="navbarSupportedContent"
				data-navbarbg="skin5">
				<ul class="navbar-nav d-none d-md-block d-lg-none">
					<li class="nav-item"><a
						class="nav-toggler nav-link waves-effect waves-light text-white"
						href="javascript:void(0)"><i class="ti-menu ti-close"></i></a></li>
				</ul>
				<!-- ============================================================== -->
				<!-- Right side toggle and nav items -->
				<!-- ============================================================== -->
				<ul class="navbar-nav ml-auto d-flex align-items-center">
					<!-- ============================================================== -->
					<!-- User profile-->
					<!-- ============================================================== -->
					<li><a class="profile-pic" href="#"> <img
							src="${ pageContext.request.contextPath }/backend/assets/plugins/images/users/default_male.jpg"
							alt="user-img" width="36" class="img-circle"><span
							class="text-white font-medium">Admin</span></a></li>
					<!-- ============================================================== -->
					<!-- User profile-->
					<!-- ============================================================== -->
				</ul>
			</div>
		</nav>
	</header>
	<!-- ============================================================== -->
	<!-- End Topbar header -->
	<!-- ============================================================== -->
	<!-- ============================================================== -->
	<!-- Left Sidebar - style you can find in sidebar.scss  -->
	<!-- ============================================================== -->
	<aside class="left-sidebar" data-sidebarbg="skin6">
		<!-- Sidebar scroll-->
		<div class="scroll-sidebar">
			<!-- Sidebar navigation-->
			<nav class="sidebar-nav">
				<ul id="sidebarnav">
					<!-- User Profile-->
					<!-- User Profile-->
					<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageDashboard" aria-expanded="false"><i
						class="fas fa-clock fa-fw" aria-hidden="true"></i><span
						class="hide-menu">Dashboard</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageProduct" aria-expanded="false"><i
						class="fab fa-product-hunt" aria-hidden="true"></i><span
						class="hide-menu">Product</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageProductline" aria-expanded="false"><i
						class="fas fa-truck" aria-hidden="true"></i><span
						class="hide-menu">Productline</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageOrders" aria-expanded="false"><i
						class="far fa-list-alt" aria-hidden="true"></i><span
						class="hide-menu">Order</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/Customer"
					aria-expanded="false"><i class="fas fa-users"
						aria-hidden="true"></i><span class="hide-menu">Customer</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/Payment"
					aria-expanded="false"><i class="fas fa-credit-card"
						aria-hidden="true"></i><span class="hide-menu">Payment</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/logout" aria-expanded="false"><i
						class="fas fa-sign-out-alt" aria-hidden="true"></i><span
						class="hide-menu">Logout</span></a></li>
				</ul>

			</nav>
			<!-- End Sidebar navigation -->
		</div>
		<!-- End Sidebar scroll-->
	</aside>
</body>
</html>