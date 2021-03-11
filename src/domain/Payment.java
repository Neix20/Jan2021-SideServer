package domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;


/**
 * The persistent class for the payments database table.
 * 
 */
@Entity
@Table(name="payments", schema="classicmodels")
@NamedQueries({
	@NamedQuery(
			name = "Payment.findAll", 
			query = "SELECT p FROM Payment p ORDER BY p.id.customernumber, p.id.checknumber"
	),
	@NamedQuery(
			name="Payment.findTotalRows", 
			query="SELECT COUNT(p) AS totalrow FROM Payment p"
	),

	@NamedQuery(
			name = "Payment.findbyPaymentId", 
			query = "SELECT p FROM Payment p "+
			"WHERE p.id.customernumber = ?1 AND p.id.checknumber = ?2"
	),
})
@NamedNativeQueries({
	// Native Queries are used
	// Since both implicit and explicit CAST to String is not supported in current version of JPQL
	// Also CONCAT between integer attribute and string attribute is not allowed in JPQL
	@NamedNativeQuery(
			name="getTotalRowsByKeyword", 
			query="SELECT COUNT(*) AS totalrow from classicmodels.payments" +
				  " WHERE concat(customernumber ,checknumber, paymentdate, " + 
				  "amount, paymentmethod) LIKE ? "
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

	@Column(name="paymentdate", length=10)
	private String paymentdate;
	
	@Column(name="amount", precision=8, scale=2)
	private BigDecimal amount;

	@Column(name="paymentmethod", length=14)
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