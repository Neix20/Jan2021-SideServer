package sessionBean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Product;

@Local
public interface ProductSessionBeanLocal {
	public List<Product> getAllProduct() throws EJBException;

//	public Product findProduct(String id) throws EJBException;
//
//	public int getNumberOfRows(String keyword) throws EJBException;
//
//	public void updateEmployee(String[] s) throws EJBException;
//
//	public void deleteEmployee(String id) throws EJBException;
//
//	public void addEmployee(String[] s) throws EJBException;
	
	public String test();
}
