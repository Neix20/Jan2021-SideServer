package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;
import javax.persistence.Column;
import javax.servlet.http.HttpServletRequest;

import domain.Payment;

/**
 * Session Bean interface class PaymentLocal
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Local
public interface PaymentLocal {
	public Payment findPayment(String customernumber, String checknumber) throws EJBException;
	public List<Payment> readPayment(int currentPage, int recordsPerPage, String keyword, String sortItem, String sortType) throws EJBException;
	public int getNumberOfRows(String keyword) throws EJBException;
	public void addPayment(HttpServletRequest request) throws EJBException;
	public void addPayment(String[] s) throws EJBException;
	public void updatePayment(HttpServletRequest request) throws EJBException;
	public void updatePayment(String[] s, String customernumber, String checknumber) throws EJBException;
	public void deletePayment(HttpServletRequest request) throws EJBException;
	public void deletePayment(String customernumber, String checknumber) throws EJBException;
	public String[] performPayment(String[] paymentDetails) throws EJBException;
	public Column getColumnAnnotation(String columnName) throws EJBException;
	public List<String> getChecknumbers(String customernumber) throws EJBException;
}
