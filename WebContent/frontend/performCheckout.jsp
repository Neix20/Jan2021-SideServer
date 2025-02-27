<%--
Author	  : Yap Jheng Khin
Page info : Display this page when the user proceeds to checkout
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Checkout</title>
	<!-- ============================================================== -->
	<!-- CSS styling -->
	<!-- ============================================================== -->
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
		
		[data-toggle="collapse"] .fa.icon-change:before {  
		  content: "\f139";
		}
		
		[data-toggle="collapse"].collapsed .fa.icon-change:before {
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
	<!-- ============================================================== -->
	<!-- End CSS styling -->
	<!-- ============================================================== -->
</head>

<body>
	
	<jsp:include page="header.jsp" />
	
	<!-- ***** Call to Action Start ***** -->
    <section class="section section-bg" id="call-to-action"
        style="background-image: url(frontend/assets/images/banner-image-1-1920x500.jpg)">
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
							<form class="form-horizontal needs-validation" role="form" action="Checkout" method="post" id="payment_form" novalidate>
								<!-- ============================================================== -->
								<!-- Review order -->
								<!-- ============================================================== -->
								<jsp:include page="reviewOrder.jsp" /> 
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<span style="text-align: center; width:100%;">
												<a id="continue_billing" style="width:100%;"
														data-toggle="collapse" data-parent="#accordion"
														href="#collapseTwo" class=" btn btn-success">
														Continue to Billing Information 
														<i class="fa fa-angle-double-right" aria-hidden="true"></i>
												</a>
											</span>
										</h4>
									</div>
								</div>
								<!-- ============================================================== -->
								<!-- End review order -->
								<!-- ============================================================== -->
								<!-- ============================================================== -->
								<!-- Order form (a.k.a. customer information) -->
								<!-- ============================================================== -->
								<jsp:include page="fillBillingForm.jsp" />  
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title">
											<span style="text-align: center;">
												<a id="continue_payment" data-toggle="collapse"
														data-parent="#accordion" href="#collapseThree"
														class=" btn   btn-success"
														style="width:100%;display: none;">
														Enter Payment Information
														<i class="fa fa-angle-double-right" aria-hidden="true"></i>
												</a>
											</span>
										</h4>
									</div>
								</div>
								<!-- ============================================================== -->
								<!-- End order form -->
								<!-- ============================================================== -->
								<!-- ============================================================== -->
								<!-- Payment form -->
								<!-- ============================================================== -->
								<jsp:include page="performPayment.jsp" />
								<!-- ============================================================== -->
								<!-- End payment form -->
								<!-- ============================================================== -->
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
	<!-- ============================================================== -->
	<!-- Custom JQuery script -->
	<!-- ============================================================== -->
	<script>
		$(document).ready(function () {
			/* Expand "Review order" section on page load
			*/ 
			$('#collapseOne').collapse('show');

			/* Expand "Billing information/order information" section and 
			   collpase "Review order" section when user clicks "Continue 
			   to Billing Information"
			*/
			$('#continue_billing').on('click', function() {
				$('#continue_billing').fadeOut();
				$('#continue_payment').fadeIn();
				$('#collapseOne').collapse('hide');
			});

			/* Expand "Payment form" section and collpase "Billing information"
			   section when user clicks "Enter Payment Information"
			*/
			$('#continue_payment').on('click', function() {
				$('#continue_payment').fadeOut();
				$('#collapseTwo').collapse('hide');
			});

			/* Switch the payment method between 'bank' and 'card' depending 
			   on user's interaction
			*/
			$('#bank_payment_method').on('click', function() {
				$("#bank_holder_name").removeClass("is-valid is-invalid");
				$("#bank_name").removeClass("is-valid is-invalid");
				$("#bank_account_number").removeClass("is-valid is-invalid");
				$('#payment_method').val('bank');
			});
	
			$('#card_payment_method').on('click', function() {
				$("#card_holder_name").removeClass("is-valid is-invalid");
				$("#card_number").removeClass("is-valid is-invalid");
				$("#card_month").removeClass("is-valid is-invalid");
				$("#card_year").removeClass("is-valid is-invalid");
				$("#card_cvv").removeClass("is-valid is-invalid");
				$('#payment_method').val('card');
			});

			/* Set the minimum date of "required date" to today's date
			*/
			let today = new Date();
			let day = String(today.getDate()).padStart(2, '0');
			let month = String(today.getMonth() + 1).padStart(2, '0');
			let year = today.getFullYear();
			today = year + '-' + month + '-' + day;

			$('#required_date').attr('min', today);

			// AJAX POST request to get form validation results form the server
			$(".needs-validation").on("submit", function(event) {

				event.preventDefault();
				
				let $form = $(".needs-validation");
				let returnResponseJSON;
				let inputIdentifiers = []

				$.post($form.attr("action"), $form.serialize(), function(responseJSON) {

					/* If the server returns an empty object, it means that all inputs are
					   are valid. Straight away submit the checkout form.
					*/
					if (jQuery.isEmptyObject(responseJSON)) {
					    $form.off("submit");
					    $form.submit();
					}
				    
				    returnResponseJSON = responseJSON;

				    let wrongInputs = Object.keys(responseJSON);
				    let customSelector = ".needs-validation select,input:not([type=radio],[type=button],[type=submit],[type=hidden])";

					/* Assign "is-valid" class to correct inputs and "is-invalid" class to
					   wrong inputs, respectively
					*/
				    $(customSelector).each(function(index, element){
				        let $elem = $(element);
				        let $parent = $elem.parent();
				        /* Find all child elements with tag name "option" and remove them 
				         * (just to prevent duplicate options when button is pressed again).
				         */
				        $elem.removeClass("is-valid is-invalid");
				        $parent.children(".invalid-feedback").remove();
				        if (!wrongInputs.includes($elem.attr("id"))) {
				            $elem.addClass("is-valid");
				        } else {
				            $elem.addClass("is-invalid")
				        }
				    });
				    
				    // Iterate over the JSON object.                      
				    $.each(responseJSON, function(inputIdentifier, errorMessage) {
				        inputIdentifiers.push(inputIdentifier);
				        // Locate HTML DOM element with ID "inputIdentifier".
				        let $select = $("#"+inputIdentifier);
				        let $parent = $select.parent();						
				        // Append the constructed error message in the parent div of the wrong input
				        $parent.append("<div class='invalid-feedback'>"+errorMessage+"</div>");
				    });

					/* Open the form to show the errors.
					*/
					$('#collapseTwo').collapse('show');
					$('#collapseThree').collapse('show');
				});
			});
		});
	</script>
	<!-- ============================================================== -->
	<!-- End custom JQuery script -->
	<!-- ============================================================== -->
</html>