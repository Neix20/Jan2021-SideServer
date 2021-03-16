package session_bean;

import javax.ejb.Local;
import javax.servlet.http.HttpServletRequest;

/**
 * Session Bean interface class CheckoutServiceLocal
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Local
public interface CheckoutServiceLocal {
	public void run(HttpServletRequest request);
}
