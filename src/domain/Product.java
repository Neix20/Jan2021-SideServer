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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * The persistent class for the products database table.
 * 
 */
@Entity
@Table(name="products", schema="classicmodels")
@NamedQueries({
	@NamedQuery(
		name="Product.findAll", 
		query="Select p From Product p"
	),
	@NamedQuery(
		name="Product.findByProductcode", 
		query="Select p From Product p where p.productcode = ?1"
	),
	@NamedQuery(
		name="Product.findByKeyword", 
		query="SELECT p FROM Product p where concat(p.productcode,p.productdescription,p.productname,p.productscale,p.productvendor)" +
				"like ?1"
	),
	@NamedQuery(
			name="Product.getLastId",
			query="Select p FROM Product p ORDER BY p.productcode DESC"
	)
})
public class Product implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="productcode", length=9)
	private String productcode;
	
	@Column(name="productname", length=43)
	private String productname;
	
	//Foreign Key
	@Column(name="productline", nullable = true, length=16)
	private String productline;

	@Column(name="productscale", length=5)
	private String productscale;
	
	@Column(name="productvendor", length=25)
	private String productvendor;

	@Column(name="productdescription", length=495)
	private String productdescription;
	
	@Column(name="quantityinstock")
	private Integer quantityinstock;
	
	@Column(name="buyprice", precision=5, scale=2)
	private BigDecimal buyprice;

	@Column(name="msrp", precision=5, scale=2)
	private BigDecimal msrp;
	
	//bi-directional many-to-one association to Orderdetail
	@OneToMany(mappedBy="product")
	private List<Orderdetail> orderdetails;

	//bi-directional many-to-one association to Productline
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="productline",insertable=false, updatable=false)
	private Productline productlineBean;
	

			
	public Product() {
	}
	
	public Product(Product p) {
		this.productcode = p.productcode;
		this.buyprice = p.buyprice;
		this.msrp = p.msrp;
		this.productdescription = p.productdescription;
		this.productname = p.productname;
		this.productscale = p.productscale;
		this.productvendor = p.productvendor;
		this.quantityinstock = p.quantityinstock;
		this.orderdetails = p.orderdetails;
		this.productlineBean = p.productlineBean;
		this.productline = p.productline;
	}
	
	public Product(ShoppingCartItem sc) {
		this.productcode = sc.getProductcode();
		this.buyprice = sc.getBuyprice();
		this.msrp = sc.getMsrp();
		this.productdescription = sc.getProductdescription();
		this.productname = sc.getProductname();
		this.productscale = sc.getProductscale();
		this.productvendor = sc.getProductvendor();
		this.quantityinstock = sc.getQuantityinstock();
		this.orderdetails = sc.getOrderdetails();
		this.productlineBean = sc.getProductlineBean();
		this.productline = sc.getProductline();
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
				+ "]";
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