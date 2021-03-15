package domain;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PaymentJson {

	private String customernumber;
	
	private String checknumber;
	
	private String amount;
	
	private String paymentdate;
	
	private String paymentmethod;
	
	private final static DateFormat dateFormat1 = new SimpleDateFormat("M/d/yyyy");
	
	private final static DateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
	
	public PaymentJson() {
	}
	
	public PaymentJson(Payment payment) {
		setCustomernumber(String.valueOf(payment.getId().getCustomernumber()));
		setChecknumber(payment.getId().getChecknumber());
		setAmount(payment.getAmount().toString());
		
		String paymentdateStr = payment.getPaymentdate();
        Date paymentDate = null;
		try {
			paymentDate = dateFormat1.parse(paymentdateStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
        paymentdateStr = dateFormat2.format(paymentDate);
		
		setPaymentdate(paymentdateStr);
		setPaymentmethod(payment.getPaymentmethod());
	}

	public String getCustomernumber() {
		return customernumber;
	}

	public void setCustomernumber(String customernumber) {
		this.customernumber = customernumber;
	}

	public String getChecknumber() {
		return checknumber;
	}

	public void setChecknumber(String checknumber) {
		this.checknumber = checknumber;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public String getPaymentdate() {        
		return paymentdate;
	}

	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}

	public String getPaymentmethod() {
		return paymentmethod;
	}

	public void setPaymentmethod(String paymentmethod) {
		this.paymentmethod = paymentmethod;
	}
}
