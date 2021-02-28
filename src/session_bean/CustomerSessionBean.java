package session_bean;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Customer;
import domain.Employee;
import domain.Payment;

/**
 * Session Bean implementation class CustomerSessionBean
 */
@Stateless
@LocalBean
public class CustomerSessionBean implements CustomerSessionBeanLocal {
	
    @PersistenceContext(unitName = "Jan2021-SideServer")
    EntityManager em;

    /**
     * Default constructor. 
     */
    public CustomerSessionBean() {
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Customer> getAllCustomer() throws EJBException {
    	return em.createNamedQuery("EmployeeEntity.findAll").getResultList();
    }

    @Override
    public Customer findCustomer(String customernumber) throws EJBException {
		Query q = em.createNamedQuery("Customer.findbyCustomerNumber");
		q.setParameter(1, Long.valueOf(customernumber));
		return (Customer) q.getSingleResult();
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Customer> readCustomer(int currentPage, int recordsPerPage, String keyword) throws EJBException {
		Query q = null;
	
		if (keyword.isEmpty()) {
			
			q = em.createNamedQuery("Customer.findAll2");

		    int start = currentPage * recordsPerPage - recordsPerPage;
		    q.setParameter(1, Integer.valueOf(start));
		    q.setParameter(2, Integer.valueOf(recordsPerPage));
	
		} else {
	
		    q = em.createNamedQuery("Customer.findByKeyword");
	
		    int start = currentPage * recordsPerPage - recordsPerPage;
		    q.setParameter(1, "%" + keyword + "%");
		    q.setParameter(2, Integer.valueOf(start));
		    q.setParameter(3, Integer.valueOf(recordsPerPage));
	
		}
	
		List<Customer> results = q.getResultList();

		return results;
    }

    @Override
    public int getNumberOfRows(String keyword) throws EJBException {
		Query q = null;

		if (keyword.isEmpty()) {
	
		    q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM Customer");
	
		} else {
	
		    q = em.createNativeQuery("SELECT COUNT(*) AS totalrow from Customer "
			    + "WHERE concat(id,first_name,last_name,gender) LIKE ?");
		    q.setParameter(1, "%" + keyword + "%");

	}

	BigInteger results = (BigInteger) q.getSingleResult();
	int i = results.intValue();
	return i;
    }

    @Override
    public void updateCustomer(String[] s) throws EJBException {
		
		Integer customernumber = Integer.parseInt(s[0]);
		String addressline1 = s[1];
		String addressline2 = s[2];
		String city = s[3];
		String contactfirstname = s[4];
		String contactlastname = s[5];
		String country = s[6];
		BigDecimal creditlimit = new BigDecimal(s[7]);
		String customername = s[8];
		String phone = s[9];
		String postalcode = s[10];
		String state = s[11];
		String salesrepemployeenumber = s[12];
		String payments_no = s[13];
		Employee salesrepemployee = null;
		List<Payment> payments = null;
	
		Customer customer = findCustomer(s[0]);
	
		customer.setCustomernumber(customernumber);
		customer.setAddressline1(addressline1);
		customer.setAddressline2(addressline2);
		customer.setCity(city);
		customer.setContactfirstname(contactfirstname);
		customer.setContactlastname(contactlastname);
		customer.setCountry(country);
		customer.setCreditlimit(creditlimit);
		customer.setCustomername(customername);
		customer.setPhone(phone);
		customer.setPostalcode(postalcode);
		customer.setState(state);
		customer.setEmployee(salesrepemployee);
		customer.setPayments(payments);
	
		em.merge(customer);
	    }
	
	    @Override
	    public void deleteCustomer(String customernumber) throws EJBException {
		Customer customer = findCustomer(customernumber);
		em.remove(customer);
	    }
	
	    @Override
	    public void addCustomer(String[] s) throws EJBException {
		Integer customernumber = null;
		String addressline1 = null;
		String addressline2 = null;
		String city = null;
		String contactfirstname = null;
		String contactlastname = null;
		String country = null;
		BigDecimal creditlimit = null;
		String customername = null;
		String phone = null;
		String postalcode = null;
		String state = null;
		Employee employee = null;
		List<Payment> payments = null;
	
		Customer customer = new Customer();
	
		customer.setCustomernumber(customernumber);
		customer.setAddressline1(addressline1);
		customer.setAddressline2(addressline2);
		customer.setCity(city);
		customer.setContactfirstname(contactfirstname);
		customer.setContactlastname(contactlastname);
		customer.setCountry(country);
		customer.setCreditlimit(creditlimit);
		customer.setCustomername(customername);
		customer.setPhone(phone);
		customer.setPostalcode(postalcode);
		customer.setState(state);
		customer.setEmployee(employee);
		customer.setPayments(payments);
	
		em.merge(customer);
    }
    
}
