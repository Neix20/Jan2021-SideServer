package domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * The persistent class for the products database table.
 * 
 */
@Entity
@Table(name="products", schema="classicmodels")
@NamedNativeQueries({
	@NamedNativeQuery(
		name="Product.findAll", 
		query="SELECT * FROM classicmodels.products",
		resultClass = Product.class
	),
	@NamedNativeQuery(
		name="Product.findByProductcode", 
		query="SELECT * FROM classicmodels.products where productcode = ?",
		resultClass = Product.class
	),
	@NamedNativeQuery(
		name="Product.findByKeyword", 
		query="SELECT * FROM classicmodels.products where concat(productcode,productdescription,productname,productscale,productvendor,quantityinstock,buyprice,msrp) like ?",
		resultClass = Product.class
	)
})
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="productcode")
	private String productcode;

	@Column(name="buyprice")
	private BigDecimal buyprice;

	@Column(name="msrp")
	private BigDecimal msrp;

	@Column(name="productdescription")
	private String productdescription;

	@Column(name="productname")
	private String productname;

	@Column(name="productscale")
	private String productscale;

	@Column(name="productvendor")
	private String productvendor;

	@Column(name="quantityinstock")
	private Integer quantityinstock;

	//bi-directional many-to-one association to Orderdetail
	@OneToMany(mappedBy="product")
	private List<Orderdetail> orderdetails;

	//bi-directional many-to-one association to Productline
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="productline",insertable=false, updatable=false)
	private Productline productlineBean;
	
	@Column(nullable = true)
	private String productline;

	public Product() {
	}
	
	public String getProductline() {
		return this.productline;
	}
	
	public void setProductline(String productline) {
		this.productline = productline;
	}

	public String getProductcode() {
		return this.productcode;
	}

	public void setProductcode(String productcode) {
		this.productcode = productcode;
	}

	public BigDecimal getBuyprice() {
		return this.buyprice;
	}

	public void setBuyprice(BigDecimal buyprice) {
		this.buyprice = buyprice;
	}

	public BigDecimal getMsrp() {
		return this.msrp;
	}

	public void setMsrp(BigDecimal msrp) {
		this.msrp = msrp;
	}

	public String getProductdescription() {
		return this.productdescription;
	}

	public void setProductdescription(String productdescription) {
		this.productdescription = productdescription;
	}

	public String getProductname() {
		return this.productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getProductscale() {
		return this.productscale;
	}

	public void setProductscale(String productscale) {
		this.productscale = productscale;
	}

	public String getProductvendor() {
		return this.productvendor;
	}

	public void setProductvendor(String productvendor) {
		this.productvendor = productvendor;
	}

	public Integer getQuantityinstock() {
		return this.quantityinstock;
	}

	public void setQuantityinstock(Integer quantityinstock) {
		this.quantityinstock = quantityinstock;
	}

	public List<Orderdetail> getOrderdetails() {
		return this.orderdetails;
	}

	public void setOrderdetails(List<Orderdetail> orderdetails) {
		this.orderdetails = orderdetails;
	}

	public Orderdetail addOrderdetail(Orderdetail orderdetail) {
		getOrderdetails().add(orderdetail);
		orderdetail.setProduct(this);

		return orderdetail;
	}

	public Orderdetail removeOrderdetail(Orderdetail orderdetail) {
		getOrderdetails().remove(orderdetail);
		orderdetail.setProduct(null);

		return orderdetail;
	}

	@Override
	public String toString() {
		return "Product [productcode=" + productcode + ", buyprice=" + buyprice + ", msrp=" + msrp
				+ ", productdescription=" + productdescription + ", productname=" + productname + ", productscale="
				+ productscale + ", productvendor=" + productvendor + ", quantityinstock=" + quantityinstock
				+ ", productlineBean=" + productlineBean + "]";
	}

	public Productline getProductlineBean() {
		return this.productlineBean;
	}

	public void setProductlineBean(Productline productlineBean) {
		this.productlineBean = productlineBean;
	}
	
	public static String[] getParameter() {
		String[] s = {"quantityInStock", "buyprice", "msrp", "productcode", "productdescription", "productname", "productscale", "productvendor", "productline"};
		return s;
	}
	
	public void setEverything(String[] arr) {
		this.setQuantityinstock(Integer.valueOf(arr[0]));
		this.setBuyprice(new BigDecimal(arr[1]));
		this.setMsrp(new BigDecimal(arr[2]));
		this.setProductcode(arr[3]);
		this.setProductdescription(arr[4]);
		this.setProductname(arr[5]);
		this.setProductscale(arr[6]);
		this.setProductvendor(arr[7]);
		this.setProductline(arr[8]);
	}

}