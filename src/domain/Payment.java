package domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;


/**
 * The persistent class for the payments database table.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Entity
@Table(name="payments", schema="classicmodels")
@NamedQueries({
	@NamedQuery(
			name = "Payment.findbyPaymentId", 
			query = "SELECT p FROM Payment p "+
					"WHERE p.id.customernumber = ?1 AND p.id.checknumber = ?2"
	),
	@NamedQuery(
			name = "Payment.findCheckNumbers", 
			query = "SELECT p.id.checknumber FROM Payment p "+
					"WHERE p.id.customernumber = ?1"
	),
})
public class Payment implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
	private PaymentPK id;

	@Column(name="paymentdate", length=10, nullable=false)
	private String paymentdate;
	
	@Column(name="amount", precision=8, scale=2, nullable=false)
	private BigDecimal amount;

	@Column(name="paymentmethod", length=14, nullable=false)
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