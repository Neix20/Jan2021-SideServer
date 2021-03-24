<header class="topbar" data-navbarbg="skin5">
	<nav class="navbar top-navbar navbar-expand-md navbar-dark">
		<div class="navbar-header" data-logobg="skin6">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/manageDashboard"> <!-- Logo icon -->
				<b class="logo-icon"> <!-- Dark Logo icon --> <img
					src="${ pageContext.request.contextPath }/backend/assets/plugins/images/logo-icon.png"
					alt="homepage" />
			</b> <!--End Logo icon --> <!-- Logo text --> <span class="logo-text">
					<!-- dark Logo text --> <img
					src="${ pageContext.request.contextPath }/backend/assets/plugins/images/logo-text.png"
					alt="homepage" />
			</span>
			</a> <a
				class="nav-toggler waves-effect waves-light text-dark d-block d-md-none"
				href="javascript:void(0)"><i class="ti-menu ti-close"></i></a>
		</div>
		<div class="navbar-collapse collapse" id="navbarSupportedContent"
			data-navbarbg="skin5">
			<ul class="navbar-nav d-none d-md-block d-lg-none">
				<li class="nav-item"><a
					class="nav-toggler nav-link waves-effect waves-light text-white"
					href="javascript:void(0)"><i class="ti-menu ti-close"></i></a></li>
			</ul>
			<ul class="navbar-nav ml-auto d-flex align-items-center">
				<li><div class="profile-pic">
						<img
							src="${ pageContext.request.contextPath }/backend/assets/plugins/images/users/default_male.jpg"
							alt="user-img" width="36" class="img-circle"><span
							class="text-white font-medium">Admin</span>
					</div></li>
			</ul>
		</div>
	</nav>
</header>

<aside class="left-sidebar" data-sidebarbg="skin6">
	<!-- Sidebar scroll-->
	<div class="scroll-sidebar">
		<!-- Sidebar navigation-->
		<nav class="sidebar-nav">
			<ul id="sidebarnav">
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageDashboard"
					aria-expanded="false"><i class="fas fa-clock fa-fw"
						aria-hidden="true"></i><span class="hide-menu">Dashboard</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageProduct"
					aria-expanded="false"><i class="fab fa-product-hunt"
						aria-hidden="true"></i><span class="hide-menu">Product</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageProductline"
					aria-expanded="false"><i class="fas fa-truck"
						aria-hidden="true"></i><span class="hide-menu">Productline</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageOrders"
					aria-expanded="false"><i class="far fa-list-alt"
						aria-hidden="true"></i><span class="hide-menu">Order</span></a></li>
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
					href="${pageContext.request.contextPath}/manageEmployee"
					aria-expanded="false"><i class="fas fa-credit-card"
						aria-hidden="true"></i><span class="hide-menu">Employee</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/manageOffice"
					aria-expanded="false"><i class="fas fa-credit-card"
						aria-hidden="true"></i><span class="hide-menu">Office</span></a></li>
				<li class="sidebar-item"><a
					class="sidebar-link waves-effect waves-dark sidebar-link"
					href="${pageContext.request.contextPath}/logout"
					aria-expanded="false"><i class="fas fa-sign-out-alt"
						aria-hidden="true"></i><span class="hide-menu">Logout</span></a></li>
			</ul>

		</nav>
		<!-- End Sidebar navigation -->
	</div>
	<!-- End Sidebar scroll-->
</aside>