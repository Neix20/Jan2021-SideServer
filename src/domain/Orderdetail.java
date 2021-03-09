package domain;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.MathContext;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
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
@Table(name="orderdetails", schema="classicmodels")
@NamedQueries({ 
	@NamedQuery(
		name = "Orderdetail.findAll", 
		query = "SELECT o FROM Orderdetail o"
	),
	@NamedQuery(
		name="Orderdetail.findByOrderNumber", 
		query="SELECT o FROM Orderdetail o WHERE o.id.ordernumber = ?1"
	),
	@NamedQuery(
		name="Orderdetail.findByOrderNumberAndProductCode", 
		query="SELECT o FROM Orderdetail o WHERE o.id.ordernumber = ?1 AND o.id.productcode = ?2"
	)
})
public class Orderdetail implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
	private OrderdetailPK id;

	@Column(name="orderlinenumber")
	private Integer orderlinenumber;

	@Column(name="priceeach", precision=5, scale=2)
	private BigDecimal priceeach;

	@Column(name="quantityordered")
	private Integer quantityordered;

	//bi-directional many-to-one association to Order
	@ManyToOne
	@JoinColumn(name="ordernumber",insertable=false, updatable=false)
	private Order order;

	//bi-directional many-to-one association to Product
	@ManyToOne
	@JoinColumn(name="productcode",insertable=false, updatable=false)
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
	
	public void setEverything(String[] arr) {
		/*
		 s4 = {
			ordernumber,
			productcode,
			priceeach,
			quantityordered	
		};
		 */

		// Get Order number
		String ordernumber = arr[0];
		// Order order = orderBean.findOrder(ordernumber);
		// Get Product code
		String productcode = arr[1];
		// Product product = productBean.getProduct(productcode);
		// Get Price each 
		
		int scale = 0;
		int precision = 0;
		Field f = null;
		try {
			f = this.getClass().getDeclaredField("priceeach");
		} catch (NoSuchFieldException | SecurityException e) {
			e.printStackTrace();
		}
		Column priceeachColumn = f.getAnnotation(Column.class);
		if (priceeachColumn != null){
			precision = priceeachColumn.precision();
			scale = priceeachColumn.scale();
		}
		
		MathContext priceeachMc = new MathContext(precision);
		BigDecimal priceeach = new BigDecimal(arr[2], priceeachMc);
		priceeach.setScale(scale);
		
		// Get Quantity ordered
		Integer quantityordered = Integer.valueOf(arr[3]);
		// Get Order line number
		Integer orderLineNumber = Integer.valueOf(arr[4]);
		
		// Set primary key
		OrderdetailPK pk = new OrderdetailPK();
		pk.setOrdernumber(Integer.valueOf(ordernumber));
		pk.setProductcode(productcode);
		this.setId(pk);
		
		// Set attributes
		this.setPriceeach(priceeach);
		this.setQuantityordered(quantityordered);
		this.setProduct(product);
		this.setOrder(order);
		this.setOrderlinenumber(orderLineNumber);
	}
}