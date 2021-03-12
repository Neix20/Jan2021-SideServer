package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Payment;
import domain.PaymentPK;

@Local
public interface PaymentSessionBeanLocal {
	public List<Payment> getAllPayment() throws EJBException;

	public Payment findPayment(String customernumber, String checknumber) throws EJBException;

	public List<Payment> readPayment(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException;

	public int getNumberOfRows(String keyword) throws EJBException;

	public void updatePayment(String[] s, String customernumber, String checknumber) throws EJBException;

	public void deletePayment(String customernumber, String checknumber) throws EJBException;

	public void addPayment(String[] s) throws EJBException;
	
	public PaymentPK getPK(String customernumber, String checknumber) throws EJBException;
}
