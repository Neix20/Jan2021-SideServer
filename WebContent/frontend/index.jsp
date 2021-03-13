<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>Vehicle Model Website</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/frontend/assets/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/assets/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/frontend/assets/jquery-2.1.0.min.js"></script>

<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/frontend/assets/popper.js"></script>
<script src="${pageContext.request.contextPath}/frontend/assets/bootstrap.min.js"></script>
</head>
<body>

	<%@ include file="header.jsp"%>

	<!-- ***** Main Banner Area Start ***** -->
	<div class="main-banner" id="top">
		<video autoplay muted loop id="bg-video">
			<source src="${pageContext.request.contextPath}/frontend/assets/images/video.mp4" type="video/mp4" />
		</video>

		<div class="video-overlay header-text">
			<div class="caption">
				<h6>Lorem ipsum dolor sit amet</h6>
				<h2>
					Best <em>toy model</em> in town!
				</h2>
			</div>
		</div>
	</div>
	<!-- ***** Main Banner Area End ***** -->

	<!-- ***** Cars Starts ***** -->
	<section class="section" id="trainers">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3">
					<div class="section-heading">
						<h2>
							Featured <em>Vehicle Model</em>
						</h2>
						<img src="${pageContext.request.contextPath}/frontend/assets/images/line-dec.png" alt="">
						<p>Nunc urna sem, laoreet ut metus id, aliquet consequat
							magna. Sed viverra ipsum dolor, ultricies fermentum massa
							consequat eu.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4">
					<div class="trainer-item">
						<div class="image-thumb">
							<img src="${pageContext.request.contextPath}/frontend/assets/images/Vintage_4.jpg" alt=""
								style="width: 100%;">
						</div>
						<div class="down-content">
							<span> <sup>RM</sup> 60.54
							</span>

							<h4>1911 Ford Town Car</h4>

							<ul class="social-icons">
								<li><a
									href="productDetails?productCode=S18_2248&image_url=Vintage_4.jpg">+
										View Model</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="trainer-item">
						<div class="image-thumb">
							<img src="${pageContext.request.contextPath}/frontend/assets/images/Motorcycles_4.jpg" alt=""
								style="width: 100%;">
						</div>
						<div class="down-content">
							<span> <sup>RM</sup> 95.70
							</span>

							<h4>1969 Harley Davidson Ultimate Chopper</h4>

							<ul class="social-icons">
								<li><a
									href="productDetails?productCode=S10_1678&image_url=Motorcycles_4.jpg">+
										View Model</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="trainer-item">
						<div class="image-thumb">
							<img src="${pageContext.request.contextPath}/frontend/assets/images/Planes_3.jpg" alt=""
								style="width: 100%;">
						</div>
						<div class="down-content">
							<span> <sup>RM</sup> 109.42
							</span>

							<h4>1928 British Royal Navy Airplane</h4>

							<ul class="social-icons">
								<li><a
									href="productDetails?productCode=S24_1785&image_url=Planes_3.jpg">+
										View Model</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<br>

			<div class="main-button text-center">
				<a href="/SideServerAssignment/productCatalog">View Vehicle Models</a>
			</div>
		</div>
	</section>
	<!-- ***** Cars Ends ***** -->

	<section class="section section-bg" id="schedule"

		style="background-image: url(${pageContext.request.contextPath}/frontend/assets/images/about-fullscreen-1-1920x700.jpg)">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3">
					<div class="section-heading dark-bg">
						<h2>
							Read <em>About Us</em>
						</h2>
						<img src="${pageContext.request.contextPath}/frontend/assets/images/line-dec.png" alt="">
						<p>Nunc urna sem, laoreet ut metus id, aliquet consequat
							magna. Sed viverra ipsum dolor, ultricies fermentum massa
							consequat eu.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="cta-content text-center">
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Labore deleniti voluptas enim! Provident consectetur id earum
							ducimus facilis, aspernatur hic, alias, harum rerum velit
							voluptas, voluptate enim! Eos, sunt, quidem.</p>

						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Iusto nulla quo cum officia laboriosam. Amet tempore, aliquid
							quia eius commodi, doloremque omnis delectus laudantium dolor
							reiciendis non nulla! Doloremque maxime quo eum in culpa mollitia
							similique eius doloribus voluptatem facilis! Voluptatibus,
							eligendi, illum. Distinctio, non!</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- ***** Testimonials Item Start ***** -->
	<section class="section" id="features">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 offset-lg-3">
					<div class="section-heading">
						<h2>
							Read our <em>Testimonials</em>
						</h2>
						<img src="${pageContext.request.contextPath}/frontend/assets/images/line-dec.png" alt="waves">
						<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
							Voluptatem incidunt alias minima tenetur nemo necessitatibus?</p>
					</div>
				</div>
				<div class="col-lg-6">
					<ul class="features-items">
						<li class="feature-item">
							<div class="left-icon">
								<img src="${pageContext.request.contextPath}/frontend/assets/images/features-first-icon.png"
									alt="First One">
							</div>
							<div class="right-content">
								<h4>John Doe</h4>
								<p>
									<em>"Lorem ipsum dolor sit amet, consectetur adipisicing
										elit. Dicta numquam maxime voluptatibus, impedit sed!
										Necessitatibus repellendus sed deleniti id et!"</em>
								</p>
							</div>
						</li>
						<li class="feature-item">
							<div class="left-icon">
								<img src="${pageContext.request.contextPath}/frontend/assets/images/features-first-icon.png"
									alt="second one">
							</div>
							<div class="right-content">
								<h4>John Doe</h4>
								<p>
									<em>"Lorem ipsum dolor sit amet, consectetur adipisicing
										elit. Dicta numquam maxime voluptatibus, impedit sed!
										Necessitatibus repellendus sed deleniti id et!"</em>
								</p>
							</div>
						</li>
					</ul>
				</div>
				<div class="col-lg-6">
					<ul class="features-items">
						<li class="feature-item">
							<div class="left-icon">
								<img src="${pageContext.request.contextPath}/frontend/assets/images/features-first-icon.png"
									alt="fourth muscle">
							</div>
							<div class="right-content">
								<h4>John Doe</h4>
								<p>
									<em>"Lorem ipsum dolor sit amet, consectetur adipisicing
										elit. Dicta numquam maxime voluptatibus, impedit sed!
										Necessitatibus repellendus sed deleniti id et!"</em>
								</p>
							</div>
						</li>
						<li class="feature-item">
							<div class="left-icon">
								<img src="${pageContext.request.contextPath}/frontend/assets/images/features-first-icon.png"
									alt="training fifth">
							</div>
							<div class="right-content">
								<h4>John Doe</h4>
								<p>
									<em>"Lorem ipsum dolor sit amet, consectetur adipisicing
										elit. Dicta numquam maxime voluptatibus, impedit sed!
										Necessitatibus repellendus sed deleniti id et!"</em>
								</p>
							</div>
						</li>
					</ul>
				</div>
			</div>

			<br>
		</div>
	</section>
	<!-- ***** Testimonials Item End ***** -->

	<!-- ***** Footer Start ***** -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<p>
						Copyright © 2020 Company Name - Template by: <a
							href="https://www.phpjabbers.com/">PHPJabbers.com</a>
					</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- jQuery -->

	<script src="${pageContext.request.contextPath}/frontend/assets/jquery-2.1.0.min.js"></script>

	<!-- Bootstrap -->
	<script src="${pageContext.request.contextPath}/frontend/assets/popper.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/bootstrap.min.js"></script>

	<!-- Plugins -->
	<script src="${pageContext.request.contextPath}/frontend/assets/scrollreveal.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/waypoints.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/jquery.counterup.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/imgfix.min.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/mixitup.js"></script>
	<script src="${pageContext.request.contextPath}/frontend/assets/accordions.js"></script>

	<!-- Global Init -->
	<script src="${pageContext.request.contextPath}/frontend/assets/custom.js"></script>
</body>

</html>