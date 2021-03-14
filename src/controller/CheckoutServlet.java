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
	 * Determine if the given input field should be optional or not
	 * based on the "@Column" annotation in the Customer entity class.
	 * @param customerParameterName
	 * @return true/false
	 */
	private boolean isRequired(String customerParameterName, HttpServletRequest request) {
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
		    "contact_firstname", 
		    "contact_lastname", 
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
		//TODO Match parameter with column name
		/*
		 * Validation for order form's input fields
		 */
		for (String customerParameterName : customerParameterNames) {
			String parameterValue = request.getParameter(customerParameterName);
			// Check if mandatory input field is empty
		    if (parameterValue == null && isRequired(customerParameterName, request)) {
		    	formValidationResult.put(customerParameterName, "REQUIRED");
		    }
		    // Ignore numerical values
		    else if (customerParameterName.equals("sales_person_email") || 
		    		 customerParameterName.equals("required_date")) {
		        continue;
		    }
		    // Check if text-based values exceed the maximum characters that can be stored
		    if (parameterValue != null) {
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
		final int BANK_ACC_NO_MAX_LEN = 34;
	
		/*
		 * Validation for payment form's input fields for "card payment"
		 */
		if (paymentMethod.equals("card")) {
			// Check if mandatory input field is empty
		    for (String cardPaymentParameterName : cardPaymentParameterNames) {
		    	String parameterValue = request.getParameter(cardPaymentParameterName);
		        if (parameterValue == null && isRequired(cardPaymentParameterName, request))
		        	formValidationResult.put(cardPaymentParameterName, "REQUIRED");
		    }
		    // Check if card CVV only contains numerical values
		    String cardCVV = request.getParameter("card_cvv");
		    if (cardCVV != null) {
		    	for (char character : cardCVV.toCharArray()) {
		    		if (!Character.isDigit(character)) {
		    			formValidationResult.put("card_cvv", "DIGIT_ONLY");
		    			break;
		    		}
		    	}
		    }
		    // Check the card number
		    String cardNumber = request.getParameter("card_number");
		    if (cardNumber != null) {
		    	boolean errorExist = false;
		    	// Check if card number only contains numerical values
		    	for (char character : cardNumber.toCharArray()) {
		    		if (!Character.isDigit(character)) {
		    			formValidationResult.put("card_number", "DIGIT_ONLY");
		    			errorExist = !errorExist;
		    			break;
		    		}
		    	}
		    	// Check if the length of the card number is 15 or 16
		    	if (!errorExist && cardNumber.length() < CARD_NO_MIN_LEN) {
		    		errorMessage = "TOO_SHORT;" + CARD_NO_MIN_LEN;
		    		formValidationResult.put("card_number", errorMessage);
		    	} else if (!errorExist && cardNumber.length() > CARD_NO_MAX_LEN) {
		    		errorMessage = "TOO_LONG;" + CARD_NO_MAX_LEN;
		    		formValidationResult.put("card_number", errorMessage);
		    	}
		    }
		}
		
		/*
		 * Validation for payment form's input fields for "bank transfer"
		 */
		else {
			// Check if mandatory input field is empty
		    for (String bankPaymentParameterName : bankPaymentParameterNames) {
		    	String parameterValue = request.getParameter(bankPaymentParameterName);
		        if (parameterValue == null && isRequired(bankPaymentParameterName, request))
		        	formValidationResult.put(bankPaymentParameterName, "REQUIRED");
		    }
		    // Check if the bank account number exceed the maximum characters
		    String bankAccountNo = request.getParameter("bank_account_number");
		    if (bankAccountNo != null && bankAccountNo.length() > BANK_ACC_NO_MAX_LEN) {
		    	errorMessage = "TOO_LONG;" + BANK_ACC_NO_MAX_LEN;
		    	formValidationResult.put("bank_account_number", errorMessage);
		    }
		}
		
		return formValidationResult;
	}
}
