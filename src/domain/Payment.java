package domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.math.BigInteger;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.Table;


/**
 * The persistent class for the payments database table.
 * 
 */
@Entity
@Table(name="payments", schema="classicmodels")
@NamedNativeQueries({
	@NamedNativeQuery(
			name = "Payment.findAll", 
			query = "SELECT * FROM classicmodels.payments",
			resultClass = Payment.class
	),
	@NamedNativeQuery(
			name="Payment.findAll2", 
			query="SELECT * FROM classicmodels.payments order by customernumber, checknumber OFFSET ? LIMIT ?",
			resultClass = Payment.class	
	),
	@NamedNativeQuery(
			name="Payment.findTotalRows", 
			query="SELECT COUNT(*) AS totalrow FROM classicmodels.payments",
			resultClass = Payment.class
	),
	@NamedNativeQuery(
			name="Payment.findTotalRows2", 
			query="SELECT COUNT(*) AS totalrow from classicmodels.payments" +
				  " WHERE concat(customernumber ,checknumber, paymentdate, " + 
				  "amount, paymentmethod) LIKE ? ",
			resultClass = Payment.class
	),
	@NamedNativeQuery(
			name = "Payment.findbyPaymentId", 
			query = "SELECT * FROM classicmodels.payments p "+
			"WHERE p.customernumber = ? AND p.checknumber = ?",
			resultClass = Payment.class
	),
	@NamedNativeQuery(
			name = "Payment.findByKeyword", 
			query = "SELECT * from classicmodels.payments WHERE concat(customernumber ,checknumber, " +
				    "paymentdate, amount, paymentmethod) LIKE ? " +
				    "order by customernumber, checknumber OFFSET ? LIMIT ?",
			resultClass = Payment.class
	),
})
public class Payment implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PaymentPK id;

	@Column(name="amount")
	private BigDecimal amount;

	@Column(name="paymentdate")
	private String paymentdate;

	@Column(name="paymentmethod")
	private String paymentmethod;

	//bi-directional many-to-one association to Customer
	@ManyToOne
	@JoinColumn(name="customernumber",insertable=false, updatable=false)
	private Customer customer;

	public Payment() {
	}

	public PaymentPK getId() {
		return this.id;
	}

	public void setId(PaymentPK id) {
		this.id = id;
	}

	public BigDecimal getAmount() {
		return this.amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getPaymentdate() {
		return this.paymentdate;
	}

	public void setPaymentdate(String paymentdate) {
		this.paymentdate = paymentdate;
	}

	public String getPaymentmethod() {
		return this.paymentmethod;
	}

	public void setPaymentmethod(String paymentmethod) {
		this.paymentmethod = paymentmethod;
	}

	public Customer getCustomer() {
		return this.customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

}