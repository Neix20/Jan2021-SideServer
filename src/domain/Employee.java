package domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the employees database table.
 * 
 */
@Entity
@Table(name = "employees", schema = "classicmodels")
@NamedQueries({ 
	@NamedQuery(name = "Employee.findAll", query = "SELECT e FROM Employee e"),
	@NamedQuery(name = "Employee.findbyId", query = "SELECT e FROM Employee e WHERE e.employeenumber = :employee_id"),
	@NamedQuery(name = "Employee.findAllEmail", query = "SELECT e.email FROM Employee e"),
	@NamedQuery(name = "Employee.findbyEmail", query = "SELECT e FROM Employee e WHERE e.email = :email"),
	@NamedQuery(name = "Employee.findByKeyword", query = "SELECT e FROM Employee e where concat(e.lastname,e.firstname)" + "like ?1") 
})
public class Employee implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "employeenumber")
	private Integer employeenumber;

	@Column(name = "lastname", length = 9)
	private String lastname;

	@Column(name = "firstname", length = 8)
	private String firstname;

	@Column(name = "extension", length = 5)
	private String extension;

	@Column(name = "email", length = 31)
	private String email;

	// bi-directional many-to-one association to Office
	@ManyToOne
	@JoinColumn(name = "officecode", insertable = false, updatable = false)
	private Office office;

	@Column(name = "reportsto", length = 4)
	private String reportsto;

	@Column(name = "jobtitle", length = 20)
	private String jobtitle;

	// bi-directional many-to-one association to Customer
	@OneToMany(mappedBy = "employee")
	private List<Customer> customers;

	@Column(name = "officecode")
	private Integer officecode;

	public Employee() {
	}

	public Employee(Employee e) {
		this.employeenumber = e.employeenumber;
		this.lastname = e.lastname;
		this.firstname = e.firstname;
		this.extension = e.extension;
		this.email = e.email;
		this.officecode = e.officecode;
		this.reportsto = e.reportsto;
		this.jobtitle = e.jobtitle;

	}

	public Integer getEmployeenumber() {
		return this.employeenumber;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getExtension() {
		return this.extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public String getFirstname() {
		return this.firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getJobtitle() {
		return this.jobtitle;
	}

	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle;
	}

	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getReportsto() {
		return this.reportsto;
	}

	public void setReportsto(String reportsto) {
		this.reportsto = reportsto;
	}

	public List<Customer> getCustomers() {
		return this.customers;
	}

	public void setCustomers(List<Customer> customers) {
		this.customers = customers;
	}

	public Customer addCustomer(Customer customer) {
		getCustomers().add(customer);
		customer.setEmployee(this);

		return customer;
	}

	public Customer removeCustomer(Customer customer) {
		getCustomers().remove(customer);
		customer.setEmployee(null);

		return customer;
	}

	public Office getOffice() {
		return this.office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}

	public Integer getOfficecode() {
		return officecode;
	}

	public void setOfficecode(Integer officecode) {
		this.officecode = officecode;
	}

	public void setEmployeenumber(Integer employeenumber) {
		this.employeenumber = employeenumber;
	}

	public static String[] getParameter() {
		String[] s = { "employeenumber", "lastname", "firstname", "extension", "email", "officecode", "reportsto",
				"jobtitle" };
		return s;
	}

	public void setEverything(String[] arr) {
		this.setEmployeenumber(Integer.valueOf(arr[0]));
		this.setLastname(arr[1]);
		this.setFirstname(arr[2]);
		this.setExtension(arr[3]);
		this.setEmail(arr[4]);
		this.setOfficecode(Integer.valueOf(arr[5]));
		this.setReportsto(arr[6]);
		this.setJobtitle(arr[7]);
	}

}
