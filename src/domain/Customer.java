package domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * The persistent class for the customers database table.
 * 
 */
@Entity
@Table(name = "customers", schema="classicmodels")
@NamedNativeQueries({
	@NamedNativeQuery(
			name = "Customer.findAll", 
			query = "SELECT * FROM classicmodels.customers",
			resultClass = Customer.class
	),
	@NamedNativeQuery(
			name="Customer.findAll2", 
			query="SELECT * FROM classicmodels.customers order by customernumber OFFSET ? LIMIT ?",
			resultClass = Customer.class	
	),
	@NamedNativeQuery(
			name="Customer.findTotalRows", 
			query="SELECT COUNT(*) AS totalrow FROM classicmodels.customers",
			resultClass = Customer.class
	),
	@NamedNativeQuery(
			name="Customer.findTotalRows2", 
			query="SELECT COUNT(*) AS totalrow from classicmodels.customers WHERE " +
				  "concat(customernumber ,customername, contactlastname, contactfirstname, " + 
				  "phone, addressline1, addressline2, city, state, postalCode, country, " + 
				  "salesrepemployeenumber, creditlimit) LIKE ?",
			resultClass = Customer.class
	),
	@NamedNativeQuery(
			name = "Customer.findbyCustomerNumber", 
			query = "SELECT * FROM classicmodels.customers c WHERE c.customernumber = ?",
			resultClass = Customer.class
	),
	@NamedNativeQuery(
			name = "Customer.findByKeyword", 
			query = "SELECT * from classicmodels.customers WHERE concat(customernumber ,customername, " +
				    "contactlastname, contactfirstname, phone, addressline1, addressline2, city, state, " +
				    "postalCode, country, salesrepemployeenumber, creditlimit) LIKE ? " +
				    "order by customernumber OFFSET ? LIMIT ?",
			resultClass = Customer.class
	),
})
public class Customer implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="customernumber")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer customernumber;

	@Column(name="addressline1")
	private String addressline1;

	@Column(name="addressline2")
	private String addressline2;

	@Column(name="city")
	private String city;

	@Column(name="contactfirstname")
	private String contactfirstname;

	@Column(name="contactlastname")
	private String contactlastname;

	@Column(name="country")
	private String country;

	@Column(name="creditlimit")
	private BigDecimal creditlimit;

	@Column(name="customername")
	private String customername;

	@Column(name="email")
	private String email;

	@Column(name="phone")
	private String phone;

	@Column(name="postalcode")
	private String postalcode;

	@Column(name="state")
	private String state;

	//bi-directional many-to-one association to Employee
	@ManyToOne
	@JoinColumn(name="salesrepemployeenumber",insertable=false, updatable=false)
	private Employee employee;
	
	//bi-directional many-to-one association to Payment
	@OneToMany(mappedBy="customer")
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