package session_bean;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;

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
		TypedQuery<Customer> q = em.createNamedQuery("Customer.findbyCustomerNumber", Customer.class);
		q.setParameter(1, Integer.valueOf(customernumber));
		return (Customer) q.getSingleResult();
    }

    @Override
    public List<Customer> readCustomer(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException {
		TypedQuery<Customer> q = null;
		
		CustomerQueryConstructor queryConstructor = new CustomerQueryConstructor(em.getCriteriaBuilder());
	    CriteriaQuery<Customer> cq = queryConstructor.queryCustomer(keyword, sortItem, sortType);
	    q = em.createQuery(cq);
	    
	    int start = currentPage * recordsPerPage - recordsPerPage;
	    q.setFirstResult(start);
	    q.setMaxResults(recordsPerPage);
	    
		List<Customer> results = q.getResultList();

		return results;
    }

    @Override
    public int getNumberOfRows(String keyword) throws EJBException {
		int i = 0;
		
		if (keyword.isEmpty()) {
			TypedQuery<Long> q = (TypedQuery<Long>) em.createNamedQuery("Customer.findTotalRows", Long.class);
			Long results = q.getSingleResult();
			i = results.intValue();
		} 
		
		else {
		    Query q = em.createNamedQuery("Customer.getTotalRowsByKeyword");
		    q.setParameter(1, "%" + keyword + "%");
		    BigInteger results = (BigInteger) q.getSingleResult();
		    i = results.intValue();
		}
		
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
    public Integer addCustomer(String[] s) throws EJBException {
		Customer customer = new Customer();
		customer = setValues(s, customer);	
		
		TypedQuery<Integer> query = em.createNamedQuery("Customer.locateNextPK", Integer.class);
		Integer customernumber = (Integer) query.getSingleResult();
		
		em.persist(customer);
		
		return customernumber;
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
		
		
		int scale = 0;
		int precision = 0;	
		Field f = null;
		try {
			f = Customer.class.getDeclaredField("creditlimit");
		} catch (NoSuchFieldException | SecurityException e) {
			e.printStackTrace();
		}
		Column creditlimitColumn = f.getAnnotation(Column.class);
		if (creditlimitColumn != null){
			precision = creditlimitColumn.precision();
			scale = creditlimitColumn.scale();
		}
		
		MathContext creditlimitMc = new MathContext(precision);
		BigDecimal creditlimit = new BigDecimal(s[12], creditlimitMc);
		creditlimit.setScale(scale);
		
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

	@Override
	public Customer findCustomerByEmail(String email) throws EJBException {
		TypedQuery<Customer> query = em.createNamedQuery("Customer.findByEmail", Customer.class);
		query.setParameter("email", email);
		List<Customer> matchCustomer = (List<Customer>) query.getResultList();
		if (matchCustomer.isEmpty()) return null;
        else if (matchCustomer.size() == 1) return matchCustomer.get(0);
        throw new NonUniqueResultException();
	}
    
}
