package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.ejb.EJB;
import javax.persistence.Column;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import domain.ShoppingCart;
import session_bean.CustomerSessionBeanLocal;
import session_bean.EmployeeSessionBeanLocal;
import session_bean.PaymentServiceSessionBeanLocal;
/**
 * Servlet implementation class CheckoutServlet
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet({"frontend/Checkout", "/Checkout", "/checkout"})
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal empbean;
	
	@EJB
	private PaymentServiceSessionBeanLocal paymentServiceBean;
	
	@EJB
	private CustomerSessionBeanLocal customerBean;
	
    public CheckoutServlet() {
        super();
    }

	/**
     * Check if user has items in the shopping cart before proceed to checkout. 
     * If the shopping cart is empty, the servlet will forward to checkout_error.jsp
     * before redirect to product catalog page.
     * Else, the servlet will forward to checkout.jsp to perform checkout.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ShoppingCart scList = (ShoppingCart) request.getSession().getAttribute("ShoppingCart");
		request.getSession().setAttribute("order_product", scList);
		
		if (scList == null || scList.count() < 1) {
			response.setHeader("Refresh", "8; URL="+request.getContextPath()+"/productCatalog");
			RequestDispatcher req = request.getRequestDispatcher("frontend/checkout_error.jsp");
			req.forward(request, response);
		}
		else {
			List<String> allEmployeeEmails = empbean.getAllEmails();
			RequestDispatcher req = request.getRequestDispatcher("frontend/checkout.jsp");
			request.setAttribute("employee_emails", allEmployeeEmails);
			req.forward(request, response);
		}
	}

	/**
	 * Process checkout information.
	 * STEP 0: Review order.
	 * STEP 1: Fill up an order form.
	 * STEP 2: Choose a payment method.
	 * STEP 3: Fill up payment method information.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/*
		 * Check if it is a AJAX request	
		 * Reference: https://stackoverflow.com/a/4113258
		 */
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

		/*
		 * Handle ajax (JSON or XML) response. Use customer form validation service to produce
		 * JSON. The JSON is then passed back to the client to display the relevant form error 
		 * message.
		 */
	    if (ajax) {	    	
	    	Map<String, String> formValidationResult =  validateCustomerForm(request);
	        String json = new Gson().toJson(formValidationResult);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
	    } 
	    
		/*
		 * <Regular JSP Response>
		 * Process checkout information.
		 * STEP 0: Review order.
		 * STEP 1: Fill up an order form.
		 * STEP 2: Choose a payment method.
		 * STEP 3: Fill up payment method information.
		 */
	    else {
	        
			paymentServiceBean.run(request);
			
			// Forward to Receipt servlet to print receipt.
		    RequestDispatcher req = request.getRequestDispatcher("frontend/Receipt");
		    req.forward(request, response);
	    }
		

	}
	
	/**
	 * Determine if the given input field in the order form should be 
	 * optional or not, based on the "@Column" annotation in the Customer 
	 * entity class.
	 * 
	 * @param customerParameterName
	 * @return true/false
	 */
	private boolean isRequired(String customerParameterName, HttpServletRequest request) {
		/*
		 * Special case: Based on our documented business rules, the sales person email and
		 * required date are always required when making payment. This business rule will remain
		 * unchanged, thus eliminating the code to check the optionality of these columns.
		 */
		if (customerParameterName.equals("sales_person_email") || 
			customerParameterName.equals("required_date")) {
			return true;
		}
		Column column = customerBean.getColumnAnnotation(customerParameterName);
		// return false if the input field value is OPTIONAL
		if (column.nullable())
			return false;
		// return true if the input field value is REQUIRED
		else
			return true;
	}
	
	/**
	 * Validate each input fields in the customer form at the server side
	 * to move the business logics from presentation layer to middle layer.
	 *  
	 * @param request
	 * @return validateCustomerForm (to send back in JSON later)
	 */
	private Map<String, String> validateCustomerForm(HttpServletRequest request) {
				
		Map<String, String> formValidationResult = new LinkedHashMap<>();
		
		List<String> customerParameterNames = Arrays.asList(
		    "customername", 
		    "contactfirstname", 
		    "contactlastname", 
		    "phone", 
		    "email", 
		    "addressline1", 
		    "addressline2",
		    "city", 
		    "state",
		    "postalcode",
		    "country", 
		    "sales_person_email",
		    "required_date"
		);
		
		List<String> cardPaymentParameterNames = Arrays.asList(
		    "card_holder_name", 
		    "card_number",
		    "card_month", 
		    "card_year", 
		    "card_cvv" 
		);

		List<String> bankPaymentParameterNames = Arrays.asList(
		    "bank_holder_name", 
		    "bank_name", 
		    "bank_account_number"
		);
		
		String errorMessage;
		/*
		 * Validation for order form's input fields
		 */
		for (String customerParameterName : customerParameterNames) {
			String parameterValue = request.getParameter(customerParameterName);
			// Check if mandatory input field is empty
		    if (parameterValue.equals("") && isRequired(customerParameterName, request)) {
		    	formValidationResult.put(customerParameterName, "REQUIRED");
		    }
		    // Ignore numerical values
		    else if (customerParameterName.equals("sales_person_email") || 
		    		 customerParameterName.equals("required_date")) {
		        continue;
		    }
		    // Check if text-based values exceed the maximum characters that can be stored
		    if (!parameterValue.equals("")) {
			    Column column = customerBean.getColumnAnnotation(customerParameterName);
			    int inputLength = request.getParameter(customerParameterName).length();
			    if (column.length() == 255)
			    	continue;
			    else if (column.length() < inputLength) {
			    	errorMessage = "TOO_LONG;" + column.length();
			    	formValidationResult.put(customerParameterName, errorMessage);
			    }
		    }
		}
		
		String paymentMethod = request.getParameter("payment_method");
		final int CARD_NO_MIN_LEN = 15;
		final int CARD_NO_MAX_LEN = 16;
    	final int MONTH_MIN = 1;
    	final int MONTH_MAX = 12;
    	final int YEAR_MIN = 2000;
    	final int YEAR_MAX = 2500;
		final int CARD_CVV_LEN = 3;
		final int BANK_ACC_NO_MAX_LEN = 34;
	
		/*
		 * Validation for payment form's input fields for "card payment"
		 */
		if (paymentMethod.equals("card")) {
			// Check if mandatory input field is empty
		    for (String parameterName : cardPaymentParameterNames) {
		    	String parameterValue = request.getParameter(parameterName);
		    	isEmpty(parameterName, parameterValue, formValidationResult);
		    }
		    boolean errorExist = false;
		    
		    // Check the card number
		    String cardNumber = request.getParameter("card_number");
		    if (!cardNumber.equals("")) {
		    	errorExist = isDigit("card_number", cardNumber, formValidationResult);
		    	// Check if the length of the card number is 15 or 16
		    	if (!errorExist) {
		    		errorExist = isTooShort("card_number", cardNumber, CARD_NO_MIN_LEN, formValidationResult);
		    	}
		    	if (!errorExist) {
		    		isTooLong("card_number", cardNumber, CARD_NO_MAX_LEN, formValidationResult);
		    	}
		    }
	    	
		    String cardCVV = request.getParameter("card_cvv");
		    if (!cardCVV.equals("")) {
		    	// Check if card CVV only contains numerical values
		    	errorExist = isDigit("card_cvv", cardCVV, formValidationResult);
		    	// Check if the length of the CVV only contains 3 digits
		    	if (!errorExist) {
		    		int cvvLength = String.valueOf(cardCVV).length();
		    		isExact("card_cvv", Integer.valueOf(cvvLength), CARD_CVV_LEN, formValidationResult);
		    	}
		    }
    
		    // Check if card month only contains numerical values
		    String cardMonth = request.getParameter("card_month");
		    if (!cardMonth.equals("")) {
		    	errorExist = isDigit("card_month", cardMonth, formValidationResult);	    	
		    	// Check if card month is within the valid range
		    	if (!errorExist) {
		    		int cardMonthInt = Integer.valueOf(cardMonth);
		    		errorExist = isTooSmall("card_month", cardMonthInt, MONTH_MIN, formValidationResult);
		    	} 
		    	if (!errorExist) {
		    		int cardMonthInt = Integer.valueOf(cardMonth);
		    		isTooBig("card_month", cardMonthInt, MONTH_MAX, formValidationResult);
		    	}
		    }
	
	    	// Check if card year only contains numerical values
	    	String cardYear = request.getParameter("card_year");
	    	if (!cardYear.equals("")) {
		    	errorExist = isDigit("card_year", cardYear, formValidationResult);	    	
		    	// Check if card year is within the valid range
		    	if (!errorExist) {
		    		int cardYearInt = Integer.valueOf(cardYear);
		    		errorExist = isTooSmall("card_year", cardYearInt, YEAR_MIN, formValidationResult);
		    	}
		    	if (!errorExist) {
		    		int cardYearInt = Integer.valueOf(cardYear);
		    		isTooBig("card_year", cardYearInt, YEAR_MAX, formValidationResult);
		    	}
	    	}
		}
		
		/*
		 * Validation for payment form's input fields for "bank transfer"
		 */
		else {
			// Check if mandatory input field is empty
		    for (String parameterName : bankPaymentParameterNames) {
		    	String parameterValue = request.getParameter(parameterName);
		    	isEmpty(parameterName, parameterValue, formValidationResult);
		    }
		    // Check if the bank account number exceed the maximum characters
		    String bankAccountNo = request.getParameter("bank_account_number");
		    if (!bankAccountNo.equals(""))
		    	isTooLong("bank_account_number", bankAccountNo, BANK_ACC_NO_MAX_LEN, formValidationResult);
		}
		
		return formValidationResult;
	}
	
	private boolean isExact(String parameterName, int parameterValue, int len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (parameterValue != len) {
	    	errorMessage = "EXACT;" + len;
	    	formValidationResult.put(parameterName, errorMessage);
	    	return false;
	    }

	    return true;
	}
	
	private boolean isDigit(String parameterName, String parameterValue, Map<String, String> formValidationResult) {
				
    	for (char character : parameterValue.toCharArray()) {
    		if (!Character.isDigit(character)) {
    			formValidationResult.put(parameterName, "DIGIT_ONLY");
    			return true;
    		}
    	}
    	
    	return false;
	}
	
	private boolean isEmpty(String parameterName, String parameterValue, Map<String, String> formValidationResult) {
		
	    if (parameterValue.equals("")) {
	    	formValidationResult.put(parameterName, "REQUIRED");
	    	return true;
	    }

	    return false;
	}
	
	private boolean isTooBig(String parameterName, int parameterValue, int max_len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (parameterValue > max_len) {
	    	errorMessage = "TOO_BIG;" + max_len;
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	private boolean isTooSmall(String parameterName, int parameterValue, int min_len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (parameterValue < min_len) {
	    	errorMessage = "TOO_SMALL;" + min_len;
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	private boolean isTooLong(String parameterName, String parameterValue, int max_len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (!parameterValue.equals("") && parameterValue.length() > max_len) {
	    	errorMessage = "TOO_LONG;" + max_len;
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	private boolean isTooShort(String parameterName, String parameterValue, int min_len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (!parameterValue.equals("") && parameterValue.length() < min_len) {
	    	errorMessage = "TOO_SHORT;" + min_len;
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
}
