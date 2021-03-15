package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;
import javax.persistence.Column;

import domain.Customer;

/**
 * Session Bean interface class CustomerSessionBeanLocal
 * 
 *
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Local
public interface CustomerLocal {
	public Customer findCustomerById(String customernumber) throws EJBException;
	public Customer findCustomerByEmail(String email) throws EJBException;
	public List<Customer> readCustomer(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException;
	public int getNumberOfRows(String keyword) throws EJBException;
	public Integer addCustomer(String[] s) throws EJBException;
	public void updateCustomer(String[] s, String customernumber) throws EJBException;
	public void deleteCustomer(String customernumber) throws EJBException;
	public Column getColumnAnnotation(String columnName);
	public List<Customer> getAllCustomer() throws EJBException;
}
