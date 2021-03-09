<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment</title>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a class="collapsed" data-toggle="collapse" data-parent="#accordion"
					href="#collapseThree">
					<i class="fa" aria-hidden="true"></i>
					Payment Information
				</a>
			</h4>
		</div>
		<div id="collapseThree" class="panel-collapse collapse">
			<div class="panel-body">
				<span class='payment-errors'></span>
				<fieldset>
				<legend>What method would you like to pay with today?</legend>
					<div class="container py-5">
						<div class="row">
							<div class="col-12 mx-auto">
								<div class="bg-white rounded-lg shadow-sm p-5">
									<input id="payment_method" name="payment_method" value="card" type="hidden">
									<!-- Credit card form tabs -->
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
									<!-- End -->
									<!-- Credit card form content -->
									<div class="tab-content">
									    <!-- credit card info-->
								    	<div id="nav-tab-card" class="tab-pane fade show active">
											<div class="form-group">
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="card_type" id="credit_card" value="credit_card" required>
													<label class="form-check-label" for="credit_card">Credit card</label>
												</div>
												<div class="form-check form-check-inline">
													<input class="form-check-input" type="radio" name="card_type" id="debit_card" value="debit_card" required>
													<label class="form-check-label" for="debit_card">Debit card</label>
												</div>
											</div>
											<div class="form-group">
												<label for="card_holder_name">Card Holder's name:</label>
												<input type="text" name="card_holder_name" placeholder="Jason Doe" class="form-control" required>
											</div>
											<div class="form-group">
												<label for="card_number">Card number</label>
												<div class="input-group">
													<input type="text" name="card_number" placeholder="Your card number" class="form-control" required>
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
														<label><span class="hidden-xs">Expiration</span></label>
														<div class="input-group">
															<input type="number" placeholder="MM" name="card_month" class="form-control" min="1" max="12" required>
															<input type="number" placeholder="YY" name="card_year" class="form-control" min="2000" max="2500" required>
														</div>
													</div>
												</div>
												<div class="col-sm-4">
													<div class="form-group mb-4">
														<label data-toggle="tooltip" title="Three-digits code on the back of your card">CVV
															<i class="fa fa-question-circle"></i>
														</label>
														<input type="text" name="card_cvv" class="form-control" pattern="[0-9]{3}" required>
													</div>
												</div>
											</div>
										</div>
									    <!-- End -->
										<!-- bank transfer info -->
										<div id="nav-tab-bank" class="tab-pane fade">
											<div class="form-group">
												<label for="bank_holder_name">Bank Account Holder's name</label>
												<input class="form-control" type="text" id="bank_holder_name" name="bank_holder_name" required>
											</div>
											<div class="form-group">
												<label for="bank_name">Bank name</label>
												<select class="form-control" name="bank_name" id="bank_name" required>
													<option value="affin_bank">Affin Bank</option>
													<option value="alliance_bank_malaysia_berhad">Alliance Bank Malaysia Berhad</option>
													<option value="al_rajhi_bank">Al_rajhi Bank</option>
													<option value="ambank_bhd">Ambank Bhd</option>
													<option value="bank_islam_malaysia_berhad">Bank Islam Malaysia Berhad</option>
													<option value="bank_kerjasama_rakyat_malaysia">Bank Kerjasama Rakyat Malaysia</option>
													<option value="bank_muamalat">Bank Muamalat</option>
													<option value="bank_of_china_(malaysia)_berhad">Bank Of China (Malaysia) Berhad</option>
													<option value="bank_pertanian_malaysia_berhad_(agrobank)">Bank Pertanian Malaysia Berhad (Agrobank)</option>
													<option value="bank_simpanan_nasional">Bank Simpanan Nasional</option>
													<option value="cimb_bank_bhd">Cimb Bank Bhd</option>
													<option value="citibank_bhd">Citibank Bhd</option>
													<option value="deutsche_bank">Deutsche Bank</option>
													<option value="hong_leong_bank_bhd">Hong Leong Bank Bhd</option>
													<option value="hsbc_bank_malaysia_bhd">Hsbc Bank Malaysia Bhd</option>
													<option value="industrial_and_commerical_bank_of_china">Industrial And Commerical Bank Of China</option>
													<option value="j_p__morgan_chase_bank_berhad">J.p. Morgan Chase Bank Berhad</option>
													<option value="kuwait_finance_house_(malaysia)_bhd">Kuwait Finance House (Malaysia) Bhd</option>
													<option value="malayan_banking_bhd_(maybank)">Malayan Banking Bhd (Maybank)</option>
													<option value="ocbc_bank_malaysia_bhd">Ocbc Bank Malaysia Bhd</option>
													<option value="public_bank_bhd">Public Bank Bhd</option>
													<option value="rhb_bank_bhd">Rhb Bank Bhd</option>
													<option value="standard_chartered_bank_bhd">Standard Chartered Bank Bhd</option>
													<option value="united_overseas_bank_malaysia_bhd">United Overseas Bank Malaysia Bhd</option>
												</select>
											</div>
											<div class="form-group">
												<label for="bank_account_number">Bank account number</label>
												<input class="form-control" type="text" id="bank_account_number" name="bank_account_number" required>
											</div>
											<p class="text-muted">
												Please ensure your bank details are correct.
											</p>
										</div>
										<!-- End -->
									</div>
									<!-- End -->	
					      </div>
					    </div>
					  </div>
					</div>
				</fieldset>
				<button id="pay-btn" type="button" class="btn btn-success btn-lg" style="width:100%;">
					Pay Now
				</button>
				<br>
				<div style="text-align: left;"><br />
					By submitting this order you are agreeing to our <a
						href="/legal/billing/">universal
						billing agreement</a>, and <a href="/legal/terms/">terms of
						service</a>.
					If you have any questions about our products or services please
					contact us
					before placing this order.
				</div>
			</div>
		</div>
	</div>
	<!-- Form Error HTML -->
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
</body>
</html>