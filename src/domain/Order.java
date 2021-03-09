package domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the orders database table.
 * 
 */
@Entity
@Table(name="orders", schema="classicmodels")
@NamedQueries({ 
	@NamedQuery(
		name = "Order.findAll", 
		query = "SELECT o FROM Order o"
	),
	@NamedQuery(
		name = "Order.findByOrderNumber",
		query = "SELECT o FROM Order o WHERE o.ordernumber = ?1"
	),
	@NamedQuery(
		name = "Order.findByCustomernumber",
		query = "SELECT o FROM Order o WHERE o.customernumber = ?1"
	),
	@NamedQuery(
			name="Order.locateNextPK", 
			query="SELECT MAX(o.ordernumber) FROM Order o"
	)
})
public class Order implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ordernumber")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer ordernumber;

	@Column(name="orderdate", length=10)
	private String orderdate;

	@Column(name="requireddate", length=10)
	private String requireddate;

	@Column(name="shippeddate", length=10)
	private String shippeddate;

	@Column(name="status", length=10)
	private String status;
	
	@Column(name="comments", length=189)
	private String comments;
	
	@Column(name="customernumber")
	private Integer customernumber;

	//bi-directional many-to-one association to Orderdetail
	@OneToMany(mappedBy="order", cascade={CascadeType.REMOVE})
	private List<Orderdetail> orderdetails;

	public Order() {
	}

	public Integer getOrdernumber() {
		return this.ordernumber;
	}

	public void setOrdernumber(Integer ordernumber) {
		this.ordernumber = ordernumber;
	}

	public String getComments() {
		return this.comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public Integer getCustomernumber() {
		return this.customernumber;
	}

	public void setCustomernumber(Integer customernumber) {
		this.customernumber = customernumber;
	}

	public String getOrderdate() {
		return this.orderdate;
	}

	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}

	public String getRequireddate() {
		return this.requireddate;
	}

	public void setRequireddate(String requireddate) {
		this.requireddate = requireddate;
	}

	public String getShippeddate() {
		return this.shippeddate;
	}

	public void setShippeddate(String shippeddate) {
		this.shippeddate = shippeddate;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public List<Orderdetail> getOrderdetails() {
		return this.orderdetails;
	}

	public void setOrderdetails(List<Orderdetail> orderdetails) {
		this.orderdetails = orderdetails;
	}

	public Orderdetail addOrderdetail(Orderdetail orderdetail) {
		getOrderdetails().add(orderdetail);
		orderdetail.setOrder(this);

		return orderdetail;
	}

	public Orderdetail removeOrderdetail(Orderdetail orderdetail) {
		getOrderdetails().remove(orderdetail);
		orderdetail.setOrder(null);

		return orderdetail;
	}
	
	public static String[] getParameter() {
		String[] s = {"orderDate", "requiredDate", "shippedDate", "comment", "customerId"};
		return s;
	}
	
	public void setEverything(String[] arr) {
		this.setOrderdate(arr[0]);
		this.setRequireddate(arr[1]);
		this.setShippeddate(arr[2]);
		this.setComments(arr[3]);
		this.setCustomernumber(Integer.valueOf(arr[4]));
		this.setStatus("Shipped");
	}

	public void setEverything2(String[] arr) {
		String comments = null;
		Integer customernumber = Integer.valueOf(arr[0]);
		String orderdate = arr[1];
		String requireddate = arr[2];
		String shippeddate = null;
		String status = "In Process";
		
		this.setComments(comments);
		this.setCustomernumber(customernumber);
		this.setOrderdate(orderdate);
		this.setRequireddate(requireddate);
		this.setShippeddate(shippeddate);
		this.setStatus(status);
	}
	
}