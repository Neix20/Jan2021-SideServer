<%--
Author	  : Yap Jheng Khin
Page info : 'Payment form' section of the checkout page
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="utility.Bank"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Payment</title>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a class="collapsed" data-toggle="collapse" data-parent="#accordion"
					href="#collapseThree">
					<i class="fa icon-change" aria-hidden="true"></i>
					Payment Information
				</a>
			</h4>
		</div>
		<div id="collapseThree" class="panel-collapse collapse">
			<div class="panel-body">
				<fieldset>
				<legend>What method would you like to pay with today?</legend>
					<div class="container py-5">
						<div class="row">
							<div class="col-12 mx-auto">
								<div class="bg-white rounded-lg shadow-sm p-5">
									<input id="payment_method" name="payment_method" value="card" type="hidden">
									<!-- ============================================================== -->
									<!-- Payment method toggle tab -->
									<!-- ============================================================== -->
									<ul role="tablist" class="nav bg-light nav-pills rounded-pill nav-fill mb-3">
										<li class="nav-item">
											<a id="card_payment_method" data-toggle="pill" href="#nav-tab-card" class="nav-link active rounded-pill">
											<i class="fa fa-credit-card" aria-hidden="true"></i> Card</a>
										<li>
										<li class="nav-item">
											<a id="bank_payment_method" data-toggle="pill" href="#nav-tab-bank" class="nav-link rounded-pill">
											<i class="fa fa-university" aria-hidden="true"></i> Bank Transfer</a>
										</li>
									</ul>
									<!-- ============================================================== -->
									<!-- End payment method toggle tab -->
									<!-- ============================================================== -->
									<!-- ============================================================== -->
									<!-- Credit/debit card payment form -->
									<!-- ============================================================== -->
									<div class="tab-content">
									    <!-- credit card info-->
								    	<div id="nav-tab-card" class="tab-pane fade show active">
											<div class="form-group">
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="card_type" id="credit_card" value="credit_card" required checked="checked">
													<label class="form-check-label" for="credit_card">Credit card</label>
												</div>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="card_type" id="debit_card" value="debit_card" required>
													<label class="form-check-label" for="debit_card">Debit card</label>
												</div>
											</div>
											<div class="form-group">
												<label for="card_holder_name">Card Holder's name:</label>
												<input type="text" id="card_holder_name" name="card_holder_name" placeholder="Jason Doe" class="form-control" required>
											</div>
											<div class="form-group">
												<label for="card_number">Card number</label>
												<div class="input-group">
													<!-- 
													Most credit/debit cards have 16 digits, while others like American Express have just 15 digits.
													Reference: https://www.experian.com/blogs/ask-experian/how-many-numbers-are-on-a-credit-card/#:~:text=Credit%20cards%20that%20are%20part,be%20used%20to%20authenticate%20transactions.
													 -->
													<input type="text" id="card_number" name="card_number" placeholder="Your card number" class="form-control" required>
												    <div class="input-group-append">
												    	<span class="input-group-text text-muted">
															<i class="fa fa-cc-visa mx-1"></i>
															<i class="fa fa-cc-amex mx-1"></i>
															<i class="fa fa-cc-mastercard mx-1"></i>
														 </span>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-8">
													<div class="form-group">
														<label data-toggle="tooltip" title="The expiration date of your card">
															<span class="hidden-xs">Expiration date</span>
															<i class="fa fa-question-circle"></i>
														</label>
														<div class="input-group">
															<input type="number" placeholder="MM" id="card_month" name="card_month" class="form-control" min="1" max="12" required>
															<input type="number" placeholder="YY" id="card_year" name="card_year" class="form-control" min="2000" max="2500" required>
														</div>
													</div>
												</div>
												<div class="col-sm-4">
													<div class="form-group mb-4">
														<label data-toggle="tooltip" title="Three-digits code on the back of your card">CVV
															<i class="fa fa-question-circle"></i>
														</label>
														<input type="text" id="card_cvv" name="card_cvv" class="form-control" pattern="[0-9]{3}" required>
													</div>
												</div>
											</div>
										</div>
									    <!-- ============================================================== -->
										<!-- End credit/debit card payment form -->
										<!-- ============================================================== -->
										<!-- ============================================================== -->
										<!-- Bank payment form -->
										<!-- ============================================================== -->
										<div id="nav-tab-bank" class="tab-pane fade">
											<div class="form-group">
												<label for="bank_holder_name">Bank Account Holder's name</label>
												<input class="form-control" type="text" id="bank_holder_name" name="bank_holder_name" required>
											</div>
											<div class="form-group">
												<label for="bank_name">Bank name</label>
												<select class="form-control" name="bank_name" id="bank_name" required>
													<option value="" selected>Select your bank</option>
													<%
													// Display list of available banks for user to choose from
													Bank banks = new Bank();
													HashMap<String, String> bankList = banks.getList();		
													for (Map.Entry<String, String> bank : bankList.entrySet())
													    out.println("<option value='"+bank.getKey()+"'>"+bank.getValue()+"</option>");
													%>
												</select>
											</div>
											<div class="form-group">
												<label for="bank_account_number">Bank account number</label>
												<!-- 
												The International Bank Account Number (IBAN) can consist up to 34 alphanumeric characters.
												Reference: https://en.wikipedia.org/wiki/International_Bank_Account_Number
												 -->
												<input class="form-control" type="text" id="bank_account_number" name="bank_account_number" required>
											</div>
											<p class="text-muted">
												Please ensure your bank details are correct.
											</p>
										</div>
										<!-- ============================================================== -->
										<!-- End bank payment form -->
										<!-- ============================================================== -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</fieldset>
				<!-- Submit the checkout form when user clicks "Pay Now"  -->
				<button id="pay-btn" type="submit" class="btn btn-success btn-lg" style="width:100%;">
					Pay Now
				</button>
				<br>
				<div style="text-align: left;"><br />
					By submitting this order you are agreeing to our <a
						href="/legal/billing/">universal
						billing agreement</a>, and <a href="/legal/terms/">terms of
						service</a>.
				</div>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- Form error pop up -->
	<!-- ============================================================== -->
	<div id="form_error_modal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">						
					<h4 class="modal-title">Warning! Form error</h4>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				</div>
				<div class="modal-body">					
					<p class="text-warning">Please ensure that your salesperson email is correct.</p>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" data-dismiss="modal" value="Okay">
				</div>
			</div>
		</div>
	</div>
	<!-- ============================================================== -->
	<!-- End form error pop up -->
	<!-- ============================================================== -->
</body>
</html>