package domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the offices database table.
 * 
 */
@Entity
@Table(name = "offices", schema = "classicmodels")
@NamedQueries({ @NamedQuery(name = "Office.findAll", query = "SELECT o FROM Office o"),
		@NamedQuery(name = "Office.findByOfficeCode", query = "SELECT f from Office f WHERE f.officecode = ?1") })

public class Office implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "officecode")
	private Integer officecode;

	@Column(name = "city", length = 13)
	private String city;

	@Column(name = "phone", length = 16)
	private String phone;

	@Column(name = "addressline1", length = 24)
	private String addressline1;

	@Column(name = "addressline2", length = 9)
	private String addressline2;

	@Column(name = "state", length = 10)
	private String state;

	@Column(name = "country", length = 9)
	private String country;

	@Column(name = "postalcode", length = 8)
	private String postalcode;

	@Column(name = "territory", length = 5)
	private String territory;

	// bi-directional many-to-one association to Employee
	@OneToMany(mappedBy = "office", cascade={CascadeType.REMOVE})
	private List<Employee> employees;

	public Office() {
	}

	public Office(Office f) {
		this.officecode = f.officecode;
		this.city = f.city;
		this.phone = f.phone;
		this.addressline1 = f.addressline1;
		this.addressline2 = f.addressline2;
		this.state = f.state;
		this.country = f.country;
		this.postalcode = f.postalcode;
		this.territory = f.territory;
	}

	public Integer getOfficecode() {
		return this.officecode;
	}

	public void setOfficecode(Integer officecode) {
		this.officecode = officecode;
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

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
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

	public String getTerritory() {
		return this.territory;
	}

	public void setTerritory(String territory) {
		this.territory = territory;
	}

	public List<Employee> getEmployees() {
		return this.employees;
	}

	public void setEmployees(List<Employee> employees) {
		this.employees = employees;
	}

	public Employee addEmployee(Employee employee) {
		getEmployees().add(employee);
		employee.setOffice(this);

		return employee;
	}

	public Employee removeEmployee(Employee employee) {
		getEmployees().remove(employee);
		employee.setOffice(null);

		return employee;
	}

	public void setEverything(String[] arr) {
		this.setOfficecode(Integer.valueOf(arr[0]));
		this.setCity(arr[1]);
		this.setAddressline1(arr[2]);
		this.setAddressline2(arr[3]);
		this.setPostalcode(arr[4]);
		this.setPhone("999");
		this.setTerritory("NA");
		this.setCountry("Malaysia");
	}


	public static String[] getParameter() {
		String[] s = { "officenumber", "city", "addressline1", "addressline2", "postalcode"};
		return s;
	}
}