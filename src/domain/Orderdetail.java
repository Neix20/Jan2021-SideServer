package domain;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The persistent class for the orderdetails database table.
 * 
 */
@Entity
@Table(name="orderdetails")
@NamedQuery(name="Orderdetail.findAll", query="SELECT o FROM Orderdetail o")
public class Orderdetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private OrderdetailPK id;

	private Integer orderlinenumber;

	private BigDecimal priceeach;

	private Integer quantityordered;

	//bi-directional many-to-one association to Order
	@ManyToOne
	@JoinColumn(name="ordernumber")
	private Order order;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="productcode")
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

}