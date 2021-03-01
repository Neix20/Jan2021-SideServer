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
    	return em.createNamedQuery("Customer.findAll").getResultList();
    }

    @Override
    public Customer findCustomer(String customernumber) throws EJBException {
		Query q = em.createNamedQuery("Customer.findbyCustomerNumber");
		q.setParameter(1, Integer.valueOf(customernumber));
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
			//TODO Check why native query is not working
//		    q = em.createNativeQuery("Customer.findTotalRows");
			q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.customers");
		} else {
		    q = em.createNativeQuery("Customer.findTotalRows2");
		    q.setParameter(1, "%" + keyword + "%");
		}
	
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		
		return i;
    }

    @Override
    public void updateCustomer(String[] s, String customernumber) throws EJBException {
		Customer customer = findCustomer(customernumber);
		customer = setValues(s, customer);
		em.merge(customer);
    }
	
	@Override
	public void deleteCustomer(String customernumber) throws EJBException {
		Customer customer = findCustomer(customernumber);
		em.remove(customer);
	}
	
    @Override
    public void addCustomer(String[] s) throws EJBException {
		Customer customer = new Customer();
		customer = setValues(s, customer);	
		em.merge(customer);
    }
	    
	private Customer setValues(String s[], Customer customer) {
				
		String customername = s[0];
		String contactfirstname = s[1];
		String contactlastname = s[2];
		String phone = s[3];
		String email = s[4];
		String addressline1 = s[5];
		String addressline2 = s[6];
		String city = s[7];
		String state = s[8];
		String postalcode = s[9];
		String country = s[10];
		String salesrepemployeenumber = s[11];
		BigDecimal creditlimit = new BigDecimal(s[12]);
		
		//TODO Implement the find function from other members.
		Employee salesrepemployee = null;
		
		customer.setCustomername(customername);
		customer.setContactfirstname(contactfirstname);
		customer.setContactlastname(contactlastname);
		customer.setPhone(phone);
		customer.setEmail(email);
		customer.setAddressline1(addressline1);
		customer.setAddressline2(addressline2);
		customer.setCity(city);
		customer.setState(state);
		customer.setPostalcode(postalcode);
		customer.setCountry(country);
		customer.setCreditlimit(creditlimit);
		// TODO: Add find by employee id
		// customer.setEmployee(salesrepemployee);
		
		return customer;
	}
    
}
