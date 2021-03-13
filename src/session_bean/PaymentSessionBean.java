package session_bean;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;

import domain.Customer;
import domain.Payment;
import domain.PaymentPK;
import utility.PaymentCriteriaQuery;
import utility.RefNoGenerator;

/**
 * Session Bean implementation class PaymentSessionBean
 * 
 *
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Stateless
@LocalBean
public class PaymentSessionBean implements PaymentSessionBeanLocal {

    @PersistenceContext(unitName = "Jan2021-SideServer")
    EntityManager em;
    
    @EJB
    private CustomerSessionBeanLocal customerBean;
    
	final private static DateFormat dateFormatHTML = new SimpleDateFormat("yyyy-MM-dd");
	final private static DateFormat dateFormatSQL = new SimpleDateFormat("M/d/yyyy");
	
    public PaymentSessionBean() {
    }
    
    /**
     * Get a payment'attributes record based on customer number and check number.
     */
	@Override
	public Payment findPayment(String customernumber, String checknumber) throws EJBException {
		TypedQuery<Payment> q = em.createNamedQuery("Payment.findbyPaymentId", Payment.class);
		q.setParameter(1, Integer.valueOf(customernumber));
		q.setParameter(2, checknumber);
		return (Payment) q.getSingleResult();
	}

    /**
     * Get payments' record sorted by @param sortItem in @param order.
     * Pagination for manage_payment.jsp.
     */
	@Override
	public List<Payment> readPayment(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException {
		TypedQuery<Payment> q = null;
		PaymentCriteriaQuery queryConstructor = new PaymentCriteriaQuery(em.getCriteriaBuilder());
	    CriteriaQuery<Payment> cq = queryConstructor.findPayment(keyword, sortItem, sortType);
	    q = em.createQuery(cq);
	    
	    int start = currentPage * recordsPerPage - recordsPerPage;
	    q.setFirstResult(start);
	    q.setMaxResults(recordsPerPage);
	    
		List<Payment> results = q.getResultList();
		return results;
	}

   /**
    * Return the total number of rows of the query.
    * Pagination for manage_payment.jsp.
    */
	@Override
	public int getNumberOfRows(String keyword) throws EJBException {	
		TypedQuery<Long> q = null;
		PaymentCriteriaQuery queryConstructor = new PaymentCriteriaQuery(em.getCriteriaBuilder());
	    CriteriaQuery<Long> cq = queryConstructor.getNumberofPayment(keyword);
	    q = em.createQuery(cq);
	    Long totalRows = q.getSingleResult();
	    return totalRows.intValue();
	}
	
	@Override
	public void addPayment(String[] attributes) throws EJBException {
		Payment payment = new Payment();
		payment = setValues(attributes, payment);	
		em.persist(payment);
	}

	@Override
	public void updatePayment(String[] attributes, String customernumber, String checknumber) throws EJBException {
		Payment payment = findPayment(customernumber, checknumber);
		payment = setValues(attributes, payment);	
		em.merge(payment);
	}

	@Override
	public void deletePayment(String customernumber, String checknumber) throws EJBException {
		Payment payment = findPayment(customernumber, checknumber);
		em.remove(payment);
	}

    /**
     * Set all the attributes of the payment based on the 
     * @param attributes passed from the servlet.
     */
	public Payment setValues(String[] attributes, Payment payment) throws EJBException {
		
		// Get the attributes
		String customernumber = attributes[0];
		Customer customer = customerBean.findCustomerById(customernumber);
		
		String checknumber = attributes[1];
		PaymentPK paymentId = new PaymentPK(customernumber, checknumber);
		
		/*
		 * Get the scale and precision from the amount'attributes @Column annotation. 
		 * Scale and precision are used to update the value properly.
		 */
		int scale = 0;
		int precision = 0;
		Field f = null;
		try {
			f = Payment.class.getDeclaredField("amount");
		} catch (NoSuchFieldException | SecurityException e) {
			e.printStackTrace();
		}
		Column amountColumn = f.getAnnotation(Column.class);
		if (amountColumn != null){
			precision = amountColumn.precision();
			scale = amountColumn.scale();
		}
		
		MathContext amountMc = new MathContext(precision);
		BigDecimal amount = new BigDecimal(attributes[2], amountMc);
		amount.setScale(scale, RoundingMode.HALF_UP);
		
		/*
		 * Change the format of the payment date to be consistent
		 * with the format stored in the database.
		 */
		Date paymentdate = null;
		
		try {
			paymentdate = dateFormatHTML.parse(attributes[3]);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		String paymentdateStr = "";
		paymentdateStr = dateFormatSQL.format(paymentdate);
		
		String paymentmethod = attributes[4];
		
		// Set the attributes
		payment.setId(paymentId);
		payment.setCustomer(customer);
		payment.setAmount(amount);
		payment.setPaymentdate(paymentdateStr);
		payment.setPaymentmethod(paymentmethod);
		
		return payment;
	}
	
	/**
	 * Perform payment service.
	 * @return receipt number, payment type, payment date
	 */
	@Override
	public String[] performPayment(String[] paymentDetails) throws EJBException {
		
		// Fetch payment and order date as of the server's configured time.
		DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
		Date orderPaymentDate = new Date();
		String orderPaymentDateStr = dateFormat1.format(orderPaymentDate);
		
		String customerNumber = paymentDetails[0];
		String paymentMethod = paymentDetails[1];
		String cardType = paymentDetails[2];
		String totalOrderAmount = paymentDetails[3];
		 
		// Generate reference number a.k.a receipt number
		int alphaNumericLength = 8;
		String refNo = new RefNoGenerator(alphaNumericLength).generate();
		// Append customer number behind the generated ref No to increase chance of uniquesness
		refNo += customerNumber;
		// Rename reference number back to check number due to assignment constraint
		String checkNumber = refNo;
		// Retrieve the payment method
		String paymentType = null;
		
		if (paymentMethod.equals("card")) {
			if (cardType.equals("credit_card"))
				paymentType = "Credit card";
			else
				paymentType = "Debit card";
		} else {
			paymentType = "Online banking";
		}
		
		// Add payment information
		String[] paymentAttributes = {
			customerNumber,
			checkNumber,
			totalOrderAmount,	
			orderPaymentDateStr,
			paymentType.toLowerCase(),
		};
		
		addPayment(paymentAttributes);
		
		String[] paymentServiceOutput = {
				checkNumber,
				paymentType,
				orderPaymentDateStr
		};
		
		return paymentServiceOutput;
	}
}
