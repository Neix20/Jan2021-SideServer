package domain;

import java.math.BigDecimal;

public class CustomerJson {

	private Integer customernumber;

	private String customername;
	
	private String contactlastname;	

	private String contactfirstname;
	
	private String phone;

	private String addressline1;

	private String addressline2;

	private String city;
	
	private String state;
	
	private String postalcode;

	private String country;

	private BigDecimal creditlimit;

	private String email;
	
	private String salesrepresentativeno;
	
	public CustomerJson() {
	}
	
	public CustomerJson(Customer c) {
		setCustomernumber(c.getCustomernumber());
		setCustomername(c.getCustomername());	
		setContactlastname(c.getContactlastname());
		setContactfirstname(c.getContactfirstname());	
		setPhone(c.getPhone());
		setAddressline1(c.getAddressline1());
		setAddressline2(c.getAddressline2());
		setCity(c.getCity());	
		setState(c.getState());	
		setPostalcode(c.getPostalcode());
		setCountry(c.getCountry());
		setCreditlimit(c.getCreditlimit());
		setEmail(c.getEmail());
		Employee salesrepresentative = c.getEmployee();
		if (salesrepresentative == null)
			setSalesrepresentativeno(null);
		else
			setSalesrepresentativeno(String.valueOf(salesrepresentative.getEmployeenumber()));
	}

	public Integer getCustomernumber() {
		return customernumber;
	}

	public void setCustomernumber(Integer customernumber) {
		this.customernumber = customernumber;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getContactlastname() {
		return contactlastname;
	}

	public void setContactlastname(String contactlastname) {
		this.contactlastname = contactlastname;
	}

	public String getContactfirstname() {
		return contactfirstname;
	}

	public void setContactfirstname(String contactfirstname) {
		this.contactfirstname = contactfirstname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddressline1() {
		return addressline1;
	}

	public void setAddressline1(String addressline1) {
		this.addressline1 = addressline1;
	}

	public String getAddressline2() {
		return addressline2;
	}

	public void setAddressline2(String addressline2) {
		this.addressline2 = addressline2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public BigDecimal getCreditlimit() {
		return creditlimit;
	}

	public void setCreditlimit(BigDecimal creditlimit) {
		this.creditlimit = creditlimit;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSalesrepresentativeno() {
		return salesrepresentativeno;
	}

	public void setSalesrepresentativeno(String salesrepresentativeno) {
		this.salesrepresentativeno = salesrepresentativeno;
	}
}
