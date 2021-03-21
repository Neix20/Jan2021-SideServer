package domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * The persistent class for the customers database table.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Entity
@Table(name = "customers", schema="classicmodels")
@NamedQueries({
	@NamedQuery(
			name = "Customer.findbyCustomerNumber", 
			query = "SELECT c FROM Customer c WHERE c.customernumber = ?1"
	),
	@NamedQuery(
			name="Customer.findByEmail",
			query="SELECT c FROM Customer c WHERE c.email = :email"
	),
	@NamedQuery(
			name="Customer.locateNextPK", 
			query="SELECT MAX(c.customernumber)+1 FROM Customer c"
	),
})
public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="customernumber", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer customernumber;
	
	@Column(name="customername", length=34, nullable=false)
	private String customername;
	
	@Column(name="contactlastname", length=15, nullable=false)
	private String contactlastname;	

	@Column(name="contactfirstname", length=11, nullable=false)
	private String contactfirstname;
	
	@Column(name="phone", length=18, nullable=false)
	private String phone;

	@Column(name="addressline1", length=32, nullable=false)
	private String addressline1;

	@Column(name="addressline2", length=24, nullable=true)
	private String addressline2;

	@Column(name="city", length=17, nullable=false)
	private String city;
	
	@Column(name="state", length=13, nullable=true)
	private String state;
	
	@Column(name="postalcode", length=9, nullable=true)
	private String postalcode;

	@Column(name="country", length=12, nullable=false)
	private String country;

	@Column(name="creditlimit", precision=8, scale=2, nullable=true)
	private BigDecimal creditlimit;

	@Column(name="email", length=50, nullable=false)
	private String email;

	//bi-directional many-to-one association to Employee
	@ManyToOne
	@JoinColumn(name="salesrepemployeenumber",insertable=false, updatable=false, nullable=true)
	private Employee employee;
	
	//bi-directional many-to-one association to Payment
	@OneToMany(mappedBy="customer", cascade={CascadeType.REMOVE})
	private List<Payment> payments;

	public Customer() {
	}
	
	public Integer getCustomernumber() {
		return this.customernumber;
	}

	public void setCustomernumber(Integer customernumber) {
		this.customernumber = customernumber;
	}

	public String getAddressline1() {
		return this.addressline1;
	}

	public void setAddressline1(String addressline1) {
		this.addressline1 = addressline1;
	}

	public String getAddressline2() {
		return this.addressline2;
	}

	public void setAddressline2(String addressline2) {
		this.addressline2 = addressline2;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getContactfirstname() {
		return this.contactfirstname;
	}

	public void setContactfirstname(String contactfirstname) {
		this.contactfirstname = contactfirstname;
	}

	public String getContactlastname() {
		return this.contactlastname;
	}

	public void setContactlastname(String contactlastname) {
		this.contactlastname = contactlastname;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public BigDecimal getCreditlimit() {
		return this.creditlimit;
	}

	public void setCreditlimit(BigDecimal creditlimit) {
		this.creditlimit = creditlimit;
	}

	public String getCustomername() {
		return this.customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPostalcode() {
		return this.postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Employee getEmployee() {
		return this.employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public List<Payment> getPayments() {
		return this.payments;
	}

	public void setPayments(List<Payment> payments) {
		this.payments = payments;
	}

	public Payment addPayment(Payment payment) {
		getPayments().add(payment);
		payment.setCustomer(this);

		return payment;
	}

	public Payment removePayment(Payment payment) {
		getPayments().remove(payment);
		payment.setCustomer(null);

		return payment;
	}

}