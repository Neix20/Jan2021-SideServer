package domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * The persistent class for the productlines database table.
 * 
 */
@Entity(name = "Productline")
@Table(name="productlines", schema="classicmodels")
@NamedNativeQueries({
	@NamedNativeQuery(
		name="Productline.findAll", 
		query="SELECT * FROM classicmodels.productlines",
		resultClass = Productline.class
	),
	@NamedNativeQuery(
		name="Productline.findByProductline", 
		query="SELECT * FROM classicmodels.productlines where productline = ?",
		resultClass = Productline.class
	),
	@NamedNativeQuery(
		name="Productline.findByKeyword", 
		query="SELECT * FROM classicmodels.productlines where concat(productline,textdescription) like ?",
		resultClass = Productline.class
	)
})
public class Productline implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "productline")
	private String productline;

	@Column(name = "htmldescription")
	private String htmldescription;

	@Column(name = "image")
	private String image;

	@Column(name = "textdescription")
	private String textdescription;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="productlineBean")
	private List<Product> products;

	public Productline() {
	}
	
	public Productline(String productline, String htmldescription, String image, String textdescription) {
		this.productline = productline;
		this.htmldescription = htmldescription;
		this.image = image;
		this.textdescription = textdescription;
	}

	public String getProductline() {
		return this.productline;
	}

	public void setProductline(String productline) {
		this.productline = productline;
	}

	public String getHtmldescription() {
		return this.htmldescription;
	}

	public void setHtmldescription(String htmldescription) {
		this.htmldescription = htmldescription;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getTextdescription() {
		return this.textdescription;
	}

	public void setTextdescription(String textdescription) {
		this.textdescription = textdescription;
	}

	public List<Product> getProducts() {
		return this.products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Product addProduct(Product product) {
		getProducts().add(product);
		product.setProductlineBean(this);

		return product;
	}

	public Product removeProduct(Product product) {
		getProducts().remove(product);
		product.setProductlineBean(null);

		return product;
	}

	@Override
	public String toString() {
		return "Productline [productline=" + productline + ", htmldescription=" + htmldescription + ", image=" + image
				+ ", textdescription=" + textdescription + "]";
	}

}