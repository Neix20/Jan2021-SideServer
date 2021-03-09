<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
	<title>Receipt error</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
                        <h2><em>Receipt</em> error</h2>
                        	<div class="container text-left">
							    <div class="row mt-3" id="warning-container">
							         <div class="col-12">  
										<div class="alert alert-warning" role="alert">
											<h4 class="text-center alert-heading">Warning: No payment</h4>
											<p class="mb-0" style="color:#856404;">You haven't make any payment yet to generate any receipt for you.</p>
											<hr>
											<p class="mb-0" style="color:#856404;">Go to <a href="${pageContext.request.contextPath}/Checkout" class="alert-link">this page</a> to proceed with checkout.
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