package session_bean;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Customer;
import domain.Payment;
import domain.PaymentPK;

/**
 * Session Bean implementation class PaymentSessionBean
 */
@Stateless
@LocalBean
public class PaymentSessionBean implements PaymentSessionBeanLocal {

    @PersistenceContext(unitName = "Jan2021-SideServer")
    EntityManager em;
    
    @EJB
    private CustomerSessionBeanLocal customerBean;
	
    /**
     * Default constructor. 
     */
    public PaymentSessionBean() {
    }

	@SuppressWarnings("unchecked")
	@Override
	public List<Payment> getAllPayment() throws EJBException {
		return em.createNamedQuery("Payment.findAll").getResultList();
	}

	@Override
	public Payment findPayment(String customernumber, String checknumber) throws EJBException {
		Query q = em.createNamedQuery("Payment.findbyPaymentId");
		q.setParameter(1, Integer.valueOf(customernumber));
		q.setParameter(2, checknumber);
		return (Payment) q.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Payment> readPayment(int currentPage, int recordsPerPage, String keyword) throws EJBException {
		Query q = null;
		
		if (keyword.isEmpty()) {
			
			q = em.createNamedQuery("Payment.findAll2");

		    int start = currentPage * recordsPerPage - recordsPerPage;
		    q.setParameter(1, Integer.valueOf(start));
		    q.setParameter(2, Integer.valueOf(recordsPerPage));
	
		} else {
	
		    q = em.createNamedQuery("Payment.findByKeyword");
	
		    int start = currentPage * recordsPerPage - recordsPerPage;
		    q.setParameter(1, "%" + keyword + "%");
		    q.setParameter(2, Integer.valueOf(start));
		    q.setParameter(3, Integer.valueOf(recordsPerPage));
	
		}
	
		List<Payment> results = q.getResultList();

		return results;
	}

	@Override
	public int getNumberOfRows(String keyword) throws EJBException {
		Query q = null;

		if (keyword.isEmpty()) {
		    // q = em.createNamedQuery("Payment.findTotalRows");
		    q = em.createNativeQuery("SELECT COUNT(*) AS totalrow FROM classicmodels.payments");
		    
		} else {
		    // q = em.createNamedQuery("Payment.findTotalRows2");
		    q = em.createNativeQuery(
		    		"SELECT COUNT(*) AS totalrow from classicmodels.payments" +
					" WHERE concat(customernumber ,checknumber, paymentdate, " + 
					"amount, paymentmethod) LIKE ? "
		    	);
		    q.setParameter(1, "%" + keyword + "%");
		}
	
		BigInteger results = (BigInteger) q.getSingleResult();
		int i = results.intValue();
		
		return i;
	}

	@Override
	public void updatePayment(String[] s, String customernumber, String checknumber) throws EJBException {
		Payment payment = findPayment(customernumber, checknumber);
		payment = setValues(s, payment);	
		em.merge(payment);
	}

	@Override
	public void deletePayment(String customernumber, String checknumber) throws EJBException {
		Payment payment = findPayment(customernumber, checknumber);
		em.remove(payment);
	}

	@Override
	public void addPayment(String[] s) throws EJBException {
		Payment payment = new Payment();
		payment = setValues(s, payment);	
		em.merge(payment);
	}
	
	public Payment setValues(String[] s, Payment payment) throws EJBException {
		String customernumber = s[0];
		Customer customer = customerBean.findCustomer(customernumber);
		
		String amount = s[1];
		
		DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat dateFormat2 = new SimpleDateFormat("M/d/yyyy");
		Date paymentdate = null;
		
		try {
			paymentdate = dateFormat1.parse(s[2]);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		String paymentdateStr = "";
		paymentdateStr = dateFormat2.format(paymentdate);
		
		String paymentmethod = s[3];
		
		
		payment.setCustomer(customer);
		payment.setAmount(new BigDecimal(amount));
		payment.setPaymentdate(paymentdateStr);
		payment.setPaymentmethod(paymentmethod);
		
		return payment;
	}

	@Override
	public PaymentPK getPK(String customernumber, String checknumber) throws EJBException {
		PaymentPK paymentpk = new PaymentPK();
		paymentpk.setCustomernumber(Integer.valueOf(customernumber));
		paymentpk.setChecknumber(checknumber);
		return paymentpk;
	}

}
