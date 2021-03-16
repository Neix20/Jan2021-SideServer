package session_bean;

import java.util.Map;

import javax.ejb.Local;
import javax.servlet.http.HttpServletRequest;

/**
 * Session Bean interface class FormValidationLocal
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Local
public interface FormValidationLocal {
	public Map<String, String> validateCheckoutForm(HttpServletRequest request);
	public Map<String, String> validateCustomerForm(HttpServletRequest request);
//	private boolean isRequired(String customerParameterName, HttpServletRequest request);
//	private boolean isExact(String parameterName, int parameterValue, int len, Map<String, String> formValidationResult);
//	private boolean isDigit(String parameterName, String parameterValue, Map<String, String> formValidationResult);
//	private boolean isEmpty(String parameterName, String parameterValue, Map<String, String> formValidationResult);
//	private boolean isTooBig(String parameterName, int parameterValue, int max_len, Map<String, String> formValidationResult);
//	private boolean isTooSmall(String parameterName, int parameterValue, int min_len, Map<String, String> formValidationResult);
//	private boolean isTooLong(String parameterName, String parameterValue, int max_len, Map<String, String> formValidationResult);
//	private boolean isTooShort(String parameterName, String parameterValue, int min_len, Map<String, String> formValidationResult);
}
