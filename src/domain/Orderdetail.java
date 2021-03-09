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
 * The persistent class for the orderdetails database table.
 * 
 */
@Entity
@Table(name = "orderdetails", schema = "classicmodels")
@NamedQueries({ 
	@NamedQuery(
		name = "Orderdetail.findAll", 
		query = "SELECT o FROM Orderdetail o"
	),
	@NamedQuery(
		name="Orderdetail.findByOrderNumber", 
		query="SELECT o FROM Orderdetail o WHERE o.id.ordernumber = ?1 ORDER BY o.orderlinenumber ASC"
	),
	@NamedQuery(
		name="Orderdetail.findByOrderDetailPK", 
		query="SELECT o FROM Orderdetail o WHERE o.id = ?1"
	)
})
public class Orderdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private OrderdetailPK id;

	@Column(name = "orderlinenumber")
	private Integer orderlinenumber;

	@Column(name = "priceeach")
	private BigDecimal priceeach;

	@Column(name = "quantityordered")
	private Integer quantityordered;

	// bi-directional many-to-one association to Order
	@ManyToOne
	@JoinColumn(name = "ordernumber", insertable = false, updatable = false)
	private Order order;

	// bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name = "productcode", insertable = false, updatable = false)
	private Product product;

	public Orderdetail() {
	}

	public OrderdetailPK getId() {
		return this.id;
	}

	public void setId(OrderdetailPK id) {
		this.id = id;
	}

	public Integer getOrderlinenumber() {
		return this.orderlinenumber;
	}

	public void setOrderlinenumber(Integer orderlinenumber) {
		this.orderlinenumber = orderlinenumber;
	}

	public BigDecimal getPriceeach() {
		return this.priceeach;
	}

	public void setPriceeach(BigDecimal priceeach) {
		this.priceeach = priceeach;
	}

	public Integer getQuantityordered() {
		return this.quantityordered;
	}

	public void setQuantityordered(Integer quantityordered) {
		this.quantityordered = quantityordered;
	}

	public Order getOrder() {
		return this.order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	public static String[] getParameter() {
		String[] s = {"productname", "quantityordered"};
		return s;
	}
	
	public void setEverything(String[] arr) {
		OrderdetailPK tmp = new OrderdetailPK(Integer.valueOf(arr[0]), arr[1]);
		this.setId(tmp);
		this.setQuantityordered(Integer.valueOf(arr[2]));
		this.setOrderlinenumber(Integer.valueOf(arr[3]));
		this.setPriceeach(new BigDecimal(arr[4]));
	}

}