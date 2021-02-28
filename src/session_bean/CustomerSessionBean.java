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
    public void updateCustomer(String[] s) throws EJBException {
		Customer customer = findCustomer(s[0]);
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
		Integer customernumber = Integer.parseInt(s[0]);
		String addressline1 = s[1];
		String addressline2 = s[2];
		String city = s[3];
		String contactfirstname = s[4];
		String contactlastname = s[5];
		String country = s[6];
		BigDecimal creditlimit = new BigDecimal(s[7]);
		String customername = s[8];
		String email = s[9];
		String phone = s[10];
		String postalcode = s[11];
		String state = s[12];
		
		//TODO Implement the find function from other members.
		String salesrepemployeenumber = s[13];
		String payments_no = s[14];
		
		Employee salesrepemployee = null;
		List<Payment> payments = null;
		
		customer.setCustomernumber(customernumber);
		customer.setAddressline1(addressline1);
		customer.setAddressline2(addressline2);
		customer.setCity(city);
		customer.setContactfirstname(contactfirstname);
		customer.setContactlastname(contactlastname);
		customer.setCountry(country);
		customer.setCreditlimit(creditlimit);
		customer.setCustomername(customername);
		customer.setEmail(email);
		customer.setPhone(phone);
		customer.setPostalcode(postalcode);
		customer.setState(state);
		customer.setEmployee(salesrepemployee);
		customer.setPayments(payments);
		
		return customer;
	}
    
}
