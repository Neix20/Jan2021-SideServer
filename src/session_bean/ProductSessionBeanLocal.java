package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Product;

@Local
public interface ProductSessionBeanLocal {
	public List<Product> getAllProduct() throws EJBException;
	public Product getProduct(String productcode) throws EJBException;
	public List<Product> getSearchResult(String keyword) throws EJBException;
	public void addProduct(Product p) throws EJBException;
	public void updateProduct(Product p) throws EJBException;
	public void deleteProduct(Product p) throws EJBException;
}
