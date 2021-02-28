package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Productline;

@Local
public interface ProductlineSessionBeanLocal {
	public List<Productline> getAllProductline() throws EJBException;
	public Productline getProductline(String productline) throws EJBException;
	public List<Productline> getSearchResult(String keyword) throws EJBException;
	public void addProductline(Productline pl) throws EJBException;
	public void updateProductline(Productline pl) throws EJBException;
	public void deleteProductline(Productline pl) throws EJBException;
}
