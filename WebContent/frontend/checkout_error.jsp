<%--
Author	  : Yap Jheng Khin
Page info : Display this page when the shopping cart is empty
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Checkout error</title>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<jsp:include page="header.jsp" />

    <!-- ***** Call to Action Start ***** -->
    <section class="section section-bg" id="call-to-action"
        style="background-image: url(${pageContext.request.contextPath}/frontend/assets/images/banner-image-1-1920x500.jpg)">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cta-content">
                        <br>
                        <br>
                        <h2><em>Checkout</em> error</h2>
                        	<div class="container text-left">
							    <div class="row mt-3" id="warning-container">
							         <div class="col-12">  
										<div class="alert alert-warning" role="alert">
											<h4 class="text-center alert-heading">Warning: Empty Shopping Cart</h4>
											<p class="mb-0" style="color:#856404;">You don't have any items in the shopping cart to proceed checkout.</p>
											<hr>
											<p class="mb-0" style="color:#856404;">Go to <a href="${pageContext.request.contextPath}/productCatalog" class="alert-link">this page</a> to browse our products.
											We will redirect you to this page in 8 seconds...</p>
										</div>
							         </div>
							    </div>
							</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ***** Call to Action End ***** -->

	<!-- Include Footer JSP -->
	<jsp:include page="footer.jsp" /> 

</body>

</html>