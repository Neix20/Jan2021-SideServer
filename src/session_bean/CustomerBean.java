package session_bean;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;

import domain.Customer;
import domain.Employee;
import utility.CustomerCriteriaQuery;

/**
 * Session Bean implementation class CustomerBean
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Stateless
@LocalBean
public class CustomerBean implements CustomerLocal {
	
    @PersistenceContext(unitName = "Jan2021-SideServer")
    private EntityManager em;
    
	@EJB
	private EmployeeSessionBeanLocal empBean;
	
    public CustomerBean() {
    }

    /**
     * Get a customer's record based on customer number.
     */
    @Override
    public Customer findCustomerById(String customernumber) throws EJBException {
		TypedQuery<Customer> q = em.createNamedQuery("Customer.findbyCustomerNumber", Customer.class);
		q.setParameter(1, Integer.valueOf(customernumber));
		return (Customer) q.getSingleResult();
    }
    
    //TODO Check the uniques of the email
    /**
     * Get a customer's record based on email address.
     */
	@Override
	public Customer findCustomerByEmail(String email) throws EJBException {
		TypedQuery<Customer> query = em.createNamedQuery("Customer.findByEmail", Customer.class);
		query.setParameter("email", email);
		List<Customer> matchCustomer = (List<Customer>) query.getResultList();
		if (matchCustomer.isEmpty()) return null;
        else if (matchCustomer.size() == 1) return matchCustomer.get(0);
        throw new NonUniqueResultException();
	}

    /**
     * Get customers' record sorted by @param sortItem in @param order.
     * Pagination for manageCustomer.jsp.
     */
    @Override
    public List<Customer> readCustomer(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException {
		TypedQuery<Customer> q = null;
		CustomerCriteriaQuery queryConstructor= new CustomerCriteriaQuery(em.getCriteriaBuilder());
	    CriteriaQuery<Customer> cq = queryConstructor.findCustomer(keyword, sortItem, sortType);
	    
	    q = em.createQuery(cq);
	    
	    int start = currentPage * recordsPerPage - recordsPerPage;
	    q.setFirstResult(start);
	    q.setMaxResults(recordsPerPage);
	    
		List<Customer> results = q.getResultList();
		return results;
    }

   /**
    * Return the total number of rows of the query.
    * Pagination for manageCustomer.jsp.
    */
    @Override
    public int getNumberOfRows(String keyword) throws EJBException {
		TypedQuery<Long> q = null;
		CustomerCriteriaQuery queryConstructor= new CustomerCriteriaQuery(em.getCriteriaBuilder());
	    CriteriaQuery<Long> cq = queryConstructor.getNumberofCustomer(keyword);
	    q = em.createQuery(cq);
	    Long totalRows = q.getSingleResult();
	    return totalRows.intValue();
    }

    @Override
    public Integer addCustomer(String[] s) throws EJBException {
		Customer customer = new Customer();
		customer = setValues(s, customer);	
		
		// Return the primary key of the new customer
		TypedQuery<Integer> query = em.createNamedQuery("Customer.locateNextPK", Integer.class);
		Integer customernumber = (Integer) query.getSingleResult();
		
		em.persist(customer);
		
		return customernumber;
    }
    
    @Override
    public void updateCustomer(String[] s, String customernumber) throws EJBException {
		Customer customer = findCustomerById(customernumber);
		customer = setValues(s, customer);
		em.merge(customer);
    }
	
	@Override
	public void deleteCustomer(String customernumber) throws EJBException {
		Customer customer = findCustomerById(customernumber);
		em.remove(customer);
	}
		
    /**
     * Set all the attributes of the customer based on the 
     * @param attributes passed from the servlet.
     */
	private Customer setValues(String attributes[], Customer customer) {
		
		// Get the attributes
		String customername = attributes[0];
		String contactfirstname = attributes[1];
		String contactlastname = attributes[2];
		String phone = attributes[3];
		String email = attributes[4];
		String addressline1 = attributes[5];
		String addressline2 = attributes[6];
		String city = attributes[7];
		String state = attributes[8];
		String postalcode = attributes[9];
		String country = attributes[10];
		String salesrepemployeenumber = attributes[11];
		
		
		/*
		 * Get the scale and precision from the credit limit's
		 * @Column annotation. 
		 * Scale and precision are used to update the value properly.
		 */
		int scale = 0;
		int precision = 0;	
		Column creditlimitColumn = getColumnAnnotation("creditlimit");
		if (creditlimitColumn != null){
			precision = creditlimitColumn.precision();
			scale = creditlimitColumn.scale();
		}
		
		MathContext creditlimitMc = new MathContext(precision);
		BigDecimal creditlimit = new BigDecimal(attributes[12], creditlimitMc);
		creditlimit.setScale(scale, RoundingMode.HALF_UP);
		
		Employee salesrepemployee = null;
		if (!salesrepemployeenumber.equals(""))
			salesrepemployee = empBean.findEmployee(salesrepemployeenumber);
		
		// Set the attributes
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
		customer.setEmployee(salesrepemployee);
		
		return customer;
	}
	
	/**
	 * Get the column of the entity class to retrieve 
	 * scale, precision and length, respectively. Used
	 * in dynamic form validation.
	 */
	public Column getColumnAnnotation(String columnName) {
		Field f = null;
		try {
			f = Customer.class.getDeclaredField(columnName);
		} catch (NoSuchFieldException | SecurityException e) {
			e.printStackTrace();
		}
		Column column = f.getAnnotation(Column.class);
		
		return column;
	}

	/**
	 * Get all customers.
	 */
	@Override
	public List<Customer> getAllCustomer() throws EJBException {
		return em.createQuery("SELECT c FROM Customer c", Customer.class)
				.getResultList();
	}
}
