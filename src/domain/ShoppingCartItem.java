package domain;

import java.io.Serializable;
import java.math.BigDecimal;

public class ShoppingCartItem extends Product implements Serializable {

	private static final long serialVersionUID = 1L;

	private int quantity;
	private BigDecimal subPrice;

	public ShoppingCartItem(Product p, int quantity) {
		super(p);
		this.quantity = quantity;
		this.countPrice();
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getSubPrice() {
		return subPrice;
	}

	public void setSubPrice(BigDecimal subPrice) {
		this.subPrice = subPrice;
	}
	
	public String getSubPriceString() {
		return String.format("%.2f", this.subPrice.doubleValue());
	}

	public void countPrice() {
		BigDecimal temp = this.getMsrp();
		this.subPrice = temp.multiply(new BigDecimal(quantity));
	}
	
	public void addItem() {
		this.quantity++;
		this.countPrice();
	}
	
	public void removeItem() {
		this.quantity--;
		this.countPrice();
	}

	public boolean equals(Object obj) {
		boolean res = false;
		if (obj instanceof ShoppingCartItem) {
			ShoppingCartItem sc = (ShoppingCartItem) obj;
			res = this.getProductcode().equals(sc.getProductcode());
		}
		return res;
	}
}
