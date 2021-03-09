<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/fontawesome.min.css"
		integrity="sha512-shT5e46zNSD6lt4dlJHb+7LoUko9QZXTGlmWWx0qjI9UhQrElRb+Q5DM7SVte9G9ZNmovz2qIaV7IWv0xQkBkw=="
		crossorigin="anonymous" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"
		integrity="sha512-hCP3piYGSBPqnXypdKxKPSOzBHF75oU8wQ81a6OiGXHFMeKs9/8ChbgYl7pUvwImXJb03N4bs1o1DzmbokeeFw=="
		crossorigin="anonymous"></script>
	<link 
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap"
    rel="stylesheet">
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<!--     jQuery -->
	<script src="assets/js/jquery-2.1.0.min.js"></script>
	<!--     Bootstrap -->
	<script src="assets/js/popper.js"></script>
	<script src="assets/js/bootstrap.min.js"></script>
	<!-- Plugins -->
	<script src="assets/js/scrollreveal.min.js"></script>
	<script src="assets/js/waypoints.min.js"></script>
	<script src="assets/js/jquery.counterup.min.js"></script>
	<script src="assets/js/imgfix.min.js"></script>
	<script src="assets/js/mixitup.js"></script>
	<script src="assets/js/accordions.js"></script>
	<!-- Global Init -->
	<script src="assets/js/custom.js"></script>
<style>
    .panel-heading {
		padding: 0;
		border:0;
	}
	.panel-title>a, .panel-title>a:active{
		display:block;
		padding:15px;
		color:#555;
		font-size:16px;
		font-weight:bold;
		text-transform:uppercase;
		letter-spacing:1px;
		 word-spacing:3px;
		text-decoration:none;
	}
	
	[data-toggle="collapse"] .fa:before {  
	  content: "\f139";
	}
	
	[data-toggle="collapse"].collapsed .fa:before {
	  content: "\f13a";
	}
	
	body {
	  background: #f5f5f5;
	}
	
	.rounded-lg {
	  border-radius: 1rem;
	}
	
	.nav-pills .nav-link {
	  color: #555;
	}
	
	.nav-pills .nav-link.active {
	  color: #fff;
	}
</style>
<script>
	$(document).ready(function () {
		$('#collapseOne').collapse('toggle');

		$('#continue_billing').on('click', function() {
			$('#continue_billing').fadeOut();
			$('#continue_payment').fadeIn();
			$('#collapseOne').collapse('toggle');
			// $('#collapseOne').collapse('toggle');
		});

		$('#continue_payment').on('click', function() {
			$('#continue_payment').fadeOut();
			// document.getElementById('collapseThree').scrollIntoView();
			$('#collapseTwo').collapse('toggle');
		});

		$('#pay-btn').on('click', function() {
			let chosenEmail = $("#sales_person_email").val();
			let obj = $("#sales_person_emails").find("option[value='" + chosenEmail + "']");
			if (obj != null && obj.length > 0) {
				$('#payment_form').submit();
			}
			else {
				$('#form_error_modal').modal();
			}
		});

		$('#bank_payment_method').on('click', function() {
			$('#payment_method').val('bank');
		});

		$('#card_payment_method').on('click', function() {
			$('#payment_method').val('card');
		});

		let today = new Date();
		let day = String(today.getDate()).padStart(2, '0');
		let month = String(today.getMonth() + 1).padStart(2, '0');
		let year = today.getFullYear();
		today = year + '-' + month + '-' + day;

		$('#required_date').attr('min', today);

		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
</head>

<body>
	
	<jsp:include page="header.jsp" />
	
	<!-- ***** Call to Action Start ***** -->
    <section class="section section-bg" id="call-to-action"
        style="background-image: url(assets/images/banner-image-1-1920x500.jpg)">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cta-content">
                        <br>
                        <br>
                        <h2><em>Checkout</em></h2>
                        <p>Ut consectetur, metus sit amet aliquet placerat, enim est ultricies ligula</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Call to Action End ***** -->
	
	<div class='container'>
		<div class='row' style='padding-top:25px; padding-bottom:25px;'>
			<div class='col-md-12'>
				<div id='mainContentWrapper'>
					<div class="col-md-8 col-md-offset-2">
						<h2 style="text-align: center;">
							Review Your Order &amp; Complete Checkout
						</h2>
						<hr>
						<a href="${pageContext.request.contextPath}/ShoppingCart" class="btn btn-info" style="width: 100%;">Edit Cart Items</a>
						<hr>
						<div class="shopping_cart">
							<form class="form-horizontal" role="form" action="Checkout" method="post" id="payment_form">
								<!-- Include Review Order JSP -->
								<jsp:include page="review_order.jsp" /> 
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<span style="text-align: center; width:100%;"><a id="continue_billing" style="width:100%;"
													data-toggle="collapse" data-parent="#accordion"
													href="#collapseTwo" class=" btn btn-success">
													Continue to Billing Information»</a></span>
										</h4>
									</div>
								</div>
								<!-- Include Bill Information JSP -->
								<jsp:include page="order_form.jsp" />  
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<span style="text-align: center;"><a id="continue_payment" data-toggle="collapse"
													data-parent="#accordion" href="#collapseThree"
													class=" btn   btn-success"
													style="width:100%;display: none;">Enter Payment Information »</a>
											</span>
										</h4>
									</div>
								</div>
								<!-- Include Payment JSP -->
								<jsp:include page="payment.jsp" />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Include Footer JSP -->
	<jsp:include page="footer.jsp" />  
</body>

</html>