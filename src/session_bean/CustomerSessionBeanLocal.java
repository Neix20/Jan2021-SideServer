package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Customer;

@Local
public interface CustomerSessionBeanLocal {
	public List<Customer> getAllCustomer() throws EJBException;

	public Customer findCustomer(String customernumber) throws EJBException;

	public List<Customer> readCustomer(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException;

	public int getNumberOfRows(String keyword) throws EJBException;

	public void updateCustomer(String[] s, String customernumber) throws EJBException;

	public void deleteCustomer(String customernumber) throws EJBException;

	public Integer addCustomer(String[] s) throws EJBException;
	
	public Customer findCustomerByEmail(String email) throws EJBException;
	
}
