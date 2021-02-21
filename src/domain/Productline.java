package domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the productlines database table.
 * 
 */
@Entity
@Table(name="productlines")
@NamedQuery(name="Productline.findAll", query="SELECT p FROM Productline p")
public class Productline implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private String productline;

	private String htmldescription;

	private String image;

	private String textdescription;

	//bi-directional many-to-one association to Product
	@OneToMany(mappedBy="productlineBean")
	private List<Product> products;

	public Productline() {
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

}