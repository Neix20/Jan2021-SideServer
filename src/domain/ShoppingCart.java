package domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ShoppingCart {
	private List<ShoppingCartItem> list;
	private HashMap<String, ShoppingCartItem> hashMap;
	private BigDecimal totalPrice;
	
	public ShoppingCart() {
		this.list = new ArrayList<ShoppingCartItem>();
		this.hashMap = new HashMap<String, ShoppingCartItem>();
		this.totalPrice = new BigDecimal(0.0);
	}
	
	public ShoppingCart(ShoppingCart scList) {
		this.list = scList.list;
		this.hashMap = new HashMap<String, ShoppingCartItem>();
		this.totalPrice = scList.totalPrice;
	}
	
	public void addItem(ShoppingCartItem sc) {
		//Check for duplicates
		if(hashMap.containsKey(sc.getProductname())) {
			ShoppingCartItem tmp = getShoppingCartItem(sc.getProductname());
			tmp.setQuantity(tmp.getQuantity() + sc.getQuantity());
			tmp.countPrice();
		}else {
			list.add(sc);
			hashMap.put(sc.getProductname(), sc);
		}
		this.setTotalPrice(totalPrice.add(sc.getSubPrice()));
	}
	
	public boolean removeItem(ShoppingCartItem sc) {
		if(hashMap.containsKey(sc.getProductname())) {
			this.list.remove(sc);
			hashMap.remove(sc.getProductname());
			return true;
		}
		
		return false;
	}
	
	public int count() {
		return this.list.size();
	}
	
	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public void countTotalPrice() {
		BigDecimal tmp = new BigDecimal(0);
		for(ShoppingCartItem sc : list) { tmp = tmp.add(sc.getSubPrice()); }
		this.totalPrice = tmp;
	}
	
	public List<ShoppingCartItem> getList() {
		return this.list;
	}
	
	public ShoppingCartItem getShoppingCartItem(String name) {
		return hashMap.get(name);
	}
}
