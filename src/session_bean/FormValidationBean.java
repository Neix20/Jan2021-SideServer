package session_bean;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.Column;
import javax.servlet.http.HttpServletRequest;

import domain.Customer;
import domain.Employee;

/**
 * Form validation for billing form, customer form, and payment form.
 * The client's request object HttpServletRequest is passed into the
 * functions and input field values are validated. Specific error 
 * message will passed back to the client as JSON for those values 
 * that are not matched with the required format.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Stateless
@LocalBean
public class FormValidationBean implements FormValidationLocal {
	
	@EJB
	private CustomerLocal customerBean;
	
	@EJB
	private EmployeeSessionBeanLocal empBean;
	
	@EJB
	private PaymentLocal paymentBean;
	
	final private static double CREDIT_LIMIT_MIN = 0.0;
	final private static double CREDIT_LIMIT_MAX = 999999.99;
	final private static double AMOUNT_MIN = 0.0;
	final private static double AMOUNT_MAX = 999999.99;
	final private static int CARD_NO_MIN_LEN = 15;
	final private static int CARD_NO_MAX_LEN = 16;
	final private static int MONTH_MIN = 1;
	final private static int MONTH_MAX = 12;
	final private static int YEAR_MIN = 2000;
	final private static int YEAR_MAX = 2500;
	final private static int CARD_CVV_LEN = 3;
	final private static int BANK_ACC_NO_MAX_LEN = 34;
	
	final private static List<String> cardPaymentParameterNames = Arrays.asList(
		    "card_holder_name", 
		    "card_number",
		    "card_month", 
		    "card_year", 
		    "card_cvv" 
		);

	final private static List<String> bankPaymentParameterNames = Arrays.asList(
	    "bank_holder_name", 
	    "bank_name", 
	    "bank_account_number"
	);
	
	/**
	 * Validate each input fields in the payment form at the server side
	 * to move the business logics from presentation layer to middle layer.
	 *  
	 * @param request
	 * @return formValidationResult (to send back in JSON later)
	 */
	@Override
	public Map<String, String> validatePaymentForm(HttpServletRequest request) {
				
		Map<String, String> formValidationResult = new LinkedHashMap<>();
		
		List<String> paymentParameterNames = Arrays.asList(
		    "customernumber", 
		    "checknumber", 
		    "amount", 
		    "paymentdate", 
		    "paymentmethod"
		);
				
		String errorMessage;
		/*
		 * Validation for payment form's input fields
		 */
		for (String parameterName : paymentParameterNames) {
			String parameterValue = request.getParameter(parameterName);
			/* Check if mandatory input field is empty. Since all input fields are required,
			 * we can skip the hassle to write code that checks optionality.
			 */
		    if (parameterValue.equals("")) {
		    	errorMessage = printError("REQUIRED", parameterName, "");
		    	formValidationResult.put(parameterName, errorMessage);
		    }
		    // Check if text-based values exceed the maximum characters that can be stored
		    if (parameterName.equals("checknumber") && !parameterValue.equals("")) {
			    Column column = paymentBean.getColumnAnnotation(parameterName);
			    int inputLength = request.getParameter(parameterName).length();
			    String customernumber = request.getParameter("customernumber");
			    String action = request.getParameter("user_action");
			    if (column.length() < inputLength) {
			    	errorMessage = printError("TOO_LONG", parameterName, String.valueOf(column.length()));
			    	formValidationResult.put(parameterName, errorMessage);
			    }
			    /* Check if the check number in the input field clashes with any of
			       the check numbers in the database. As long as the check number
			       is unique for that customer, it is fine XD
			    */
			    else if (!customernumber.equals("") && action.equals("ADD")) {
			    	List<String> existedChecknumbers = paymentBean.getChecknumbers(customernumber);
			    	for (String existedCheckmumber : existedChecknumbers) {
			    		if (existedCheckmumber.equals(parameterValue)) {
			    			errorMessage = printError("NOT_UNIQUE", parameterName, "");
							formValidationResult.put(parameterName, errorMessage);
			    		}
			    	}
			    }
		    }
		}
		
		// Check if the customer number exists in the database
		String customernumber = request.getParameter("customernumber");
	    if (!customernumber.equals("")) {
	    	boolean errorExist = isDigit("customernumber", customernumber, formValidationResult);
	    	if (!errorExist) {
				Customer customer = customerBean.findCustomerById(customernumber);
				if (customer == null) {
					errorMessage = printError("NOT_EXIST", "customernumber", "");
					formValidationResult.put("customernumber", errorMessage);
				}
	    	}
	    }
		
	    String amount = request.getParameter("amount");
		/* Check if amount matches the pattern similar to "12345.99" 
		 * where ".99" is optional.
		 */
		if (!amount.equals("")) {
			Pattern amountPattern = Pattern.compile("^\\d+\\.?\\d{0,2}$");
			Matcher matcher = amountPattern.matcher(amount);
			boolean matchFound = matcher.find();
		    if(!matchFound) {
				errorMessage = printError("INVALID_FORMAT", "amount", "12345.99");
				formValidationResult.put("amount", errorMessage);
		    }
		    else {
		    	boolean errorExist = false;
		    	double amountFloat = new BigDecimal(amount).doubleValue();
		    	// Check if amount is within the valid range
		    	if (!errorExist) {
		    		if (amountFloat < AMOUNT_MIN) {
		    	    	errorMessage = printError("TOO_SMALL", "amount", String.valueOf(AMOUNT_MIN));
		    	    	formValidationResult.put("amount", errorMessage);
		    	    	errorExist = true;
		    		}
		    	} 
		    	if (!errorExist) {
		    		// Hardcode 999999.99 to make my life easier XD
		    		if (amountFloat > AMOUNT_MAX) {
		    	    	errorMessage = printError("TOO_BIG", "amount", String.valueOf(AMOUNT_MAX));
		    	    	formValidationResult.put("amount", errorMessage);
		    		}
		    	}
		    }
		}
		
		return formValidationResult;
	}
		
	/**
	 * Validate each input fields in the customer form at the server side
	 * to move the business logics from presentation layer to middle layer.
	 *  
	 * @param request
	 * @return formValidationResult (to send back in JSON later)
	 */
	@Override
	public Map<String, String> validateCustomerForm(HttpServletRequest request) {
				
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
		    "salesrepemployeenumber",
		    "creditlimit"
		);
				
		String errorMessage;
		/*
		 * Validation for customer form's input fields
		 */
		for (String customerParameterName : customerParameterNames) {
			String parameterValue = request.getParameter(customerParameterName);
			// Check if mandatory input field is empty
		    if (parameterValue.equals("") && isRequired(customerParameterName, request)) {
		    	errorMessage = printError("REQUIRED", customerParameterName, "");
		    	formValidationResult.put(customerParameterName, errorMessage);
		    }
		    // Ignore numerical values
		    else if (customerParameterName.equals("salesrepemployeenumber")) {
		        continue;
		    }
		    // Check if text-based values exceed the maximum characters that can be stored
		    if (!parameterValue.equals("")) {
			    Column column = customerBean.getColumnAnnotation(customerParameterName);
			    int inputLength = request.getParameter(customerParameterName).length();
			    if (column.length() == 255)
			    	continue;
			    else if (column.length() < inputLength) {
			    	errorMessage = printError("TOO_LONG", customerParameterName, String.valueOf(column.length()));
			    	formValidationResult.put(customerParameterName, errorMessage);
			    }
		    }
		}
		
		// Check if the customer's email is unique
		String email = request.getParameter("email");
		String user_action = request.getParameter("user_action");
		String customernumber = request.getParameter("customernumber");
		if (!email.equals("")) {
			Customer matchedCustomer = customerBean.findCustomerByEmail(email);
			if (matchedCustomer != null && user_action.equals("ADD")) {
				errorMessage = printError("NOT_UNIQUE", "email", "");
				formValidationResult.put("email", errorMessage);
			} 
			else if (user_action.equals("UPDATE")) {
				if (!Integer.valueOf(customernumber).equals(matchedCustomer.getCustomernumber())) {
					errorMessage = printError("NOT_UNIQUE", "email", "");
					formValidationResult.put("email", errorMessage);
				}
			}
		}
		
		// Check if the sales representative employee number exists in the database
		String salesrepemployeenumber = request.getParameter("salesrepemployeenumber");
	    if (!salesrepemployeenumber.equals("")) {
	    	boolean errorExist = isDigit("salesrepemployeenumber", salesrepemployeenumber, formValidationResult);
	    	if (!errorExist) {
				Employee employee = empBean.findEmployee(salesrepemployeenumber);
				if (employee == null) {
					errorMessage = printError("NOT_EXIST", "salesrepemployeenumber", "");
					formValidationResult.put("salesrepemployeenumber", errorMessage);
				}
	    	}
	    }
		
		String creditlimit = request.getParameter("creditlimit");
		/* Check if credit limit matches the pattern similar to "12345.99" 
		 * where ".99" is optional.
		 */
		if (!creditlimit.equals("")) {
			Pattern creditlimitPattern = Pattern.compile("^\\d+\\.?\\d{0,2}$");
			Matcher matcher = creditlimitPattern.matcher(creditlimit);
			boolean matchFound = matcher.find();
		    if(!matchFound) {
				errorMessage = printError("INVALID_FORMAT", "creditlimit", "12345.99");
				formValidationResult.put("creditlimit", errorMessage);
		    }
		    else {
		    	boolean errorExist = false;
		    	double creditlimitFloat = new BigDecimal(creditlimit).doubleValue();
		    	// Check if credit limit is within the valid range
		    	if (!errorExist) {
		    		if (creditlimitFloat < CREDIT_LIMIT_MIN) {
		    	    	errorMessage = printError("TOO_SMALL", "creditlimit", String.valueOf(CREDIT_LIMIT_MIN));
		    	    	formValidationResult.put("creditlimit", errorMessage);
		    	    	errorExist = true;
		    		}
		    	} 
		    	if (!errorExist) {
		    		// Hardcode 999999.99 to make my life easier XD
		    		if (creditlimitFloat > CREDIT_LIMIT_MAX) {
		    	    	errorMessage = printError("TOO_BIG", "creditlimit", String.valueOf(CREDIT_LIMIT_MAX));
		    	    	formValidationResult.put("creditlimit", errorMessage);
		    		}
		    	}
		    }
		}
		
		return formValidationResult;
	}

	/**
	 * Validate each input fields in the checkout form at the server side
	 * to move the business logics from presentation layer to middle layer.
	 *  
	 * @param request
	 * @return formValidationResult (to send back in JSON later)
	 */
	@Override
	public Map<String, String> validateCheckoutForm(HttpServletRequest request) {
				
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
				
		String errorMessage;
		/*
		 * Validation for order form's input fields
		 */
		for (String customerParameterName : customerParameterNames) {
			String parameterValue = request.getParameter(customerParameterName);
			// Check if mandatory input field is empty
		    if (parameterValue.equals("") && isRequired(customerParameterName, request)) {
				errorMessage = printError("REQUIRED", customerParameterName, "");
				formValidationResult.put(customerParameterName, errorMessage);
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
			    	errorMessage = printError("TOO_LONG", customerParameterName, String.valueOf(column.length()));
			    	formValidationResult.put(customerParameterName, errorMessage);
			    }
		    }
		}
		
		String paymentMethod = request.getParameter("payment_method");
	
		/*
		 * Validation for checkout form's input fields for "card payment"
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
		 * Validation for checkout form's input fields for "bank transfer"
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
	
	final private Hashtable<String, String> mapIdToColumnName = new Hashtable<String, String>();
	
	/**
	 * Lookup table to produce custom form error message
	 * based on the column name. 
	 * @return columnDesc
	 */
	public Hashtable<String, String> getMapIdToColumnName() {
		mapIdToColumnName.put("customername", "customer's name");
		mapIdToColumnName.put("contactfirstname", "contact's first name");
		mapIdToColumnName.put("contactlastname", "contact's last name");
		mapIdToColumnName.put("phone", "phone");
		mapIdToColumnName.put("email", "email");
		mapIdToColumnName.put("addressline1", "address line 1");
		mapIdToColumnName.put("addressline2", "address line 2");
		mapIdToColumnName.put("city", "city");
		mapIdToColumnName.put("state", "state");
		mapIdToColumnName.put("postalcode", "postal code");
		mapIdToColumnName.put("country", "country");
		mapIdToColumnName.put("salesrepemployeenumber", "sales person's number");
		mapIdToColumnName.put("creditlimit", "credit limit");
		mapIdToColumnName.put("sales_person_email", "sales person's email");
		mapIdToColumnName.put("required_date", "required date");
		mapIdToColumnName.put("card_holder_name", "card holder's name");
		mapIdToColumnName.put("card_number", "card number");
		mapIdToColumnName.put("card_month", "card month");
		mapIdToColumnName.put("card_year", "card year");
		mapIdToColumnName.put("card_cvv", "card cvv");
		mapIdToColumnName.put("bank_holder_name", "bank holder's name"); 
		mapIdToColumnName.put("bank_name", "bank name");
		mapIdToColumnName.put("bank_account_number", "bank account number");
	    mapIdToColumnName.put("customernumber", "customer number"); 
	    mapIdToColumnName.put("checknumber", "check number"); 
	    mapIdToColumnName.put("amount", "amount"); 
	    mapIdToColumnName.put("paymentdate", "payment date"); 
	    mapIdToColumnName.put("paymentmethod", "payment method");
	    
		return mapIdToColumnName;
	}
	
	/**
	 * Function to print a custom form error according to 
	 * the @param error_type.
	 * 
	 * @param error_type
	 * @param columnName
	 * @param parameter2
	 * @return columnDesc
	 */
	private String printError(String error_type, String columnName, String parameter2) {
		
		Hashtable<String, String> mapIdToColumnName = getMapIdToColumnName();
		String columnDesc = mapIdToColumnName.get(columnName);
		
		switch (error_type) {
		case "REQUIRED" :
		    return "Please provide a "+columnDesc+".";
		case "DIGIT_ONLY":
		    return "Only digits are allowed for "+columnDesc+".";
		case "TOO_SHORT":
		    String minChar = parameter2;
		    return "Minimum number of characters allowed for "+columnDesc+" is "+minChar+".";
		case "TOO_LONG":
		    String maxChar = parameter2;
		    return "Maximum number of characters allowed for "+columnDesc+" is "+maxChar+".";
		case "EXACT":
		    String exactChar = parameter2;
		    return "The exact number of characters allowed for "+columnDesc+" is "+exactChar+".";
		case "TOO_SMALL":
		    String minVal = parameter2;
		    return "Minimum value allowed for "+columnDesc+" is "+minVal+".";
		case "TOO_BIG":
		    String maxVal = parameter2;
		    return "Maximum value allowed for "+columnDesc+" is "+maxVal+".";
		case "NOT_UNIQUE":
		    return "The current value of "+columnDesc+" is already taken. Please try again.";
		case "NOT_EXIST":
		    return "The value of "+columnDesc+" does not exist. Please try again.";
		case "INVALID_FORMAT":
			String format = parameter2;
		    return "The value of "+columnDesc+" is not in correct format. The format should be in "+format+".";
		}
		return "Default error";
	}
	
	/**
	 * Determine if the given input field in the form should be 
	 * optional or not, based on the "@Column" annotation in the Customer 
	 * entity class.
	 * 
	 * @param customerParameterName
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isRequired(String customerParameterName, HttpServletRequest request) {
		/*
		 * Special case 1: Based on our documented business rules, the sales person email and
		 * required date are always required when making payment. This business rule will remain
		 * unchanged, thus eliminating the code to check the optionality of these columns.
		 */
		if (customerParameterName.equals("sales_person_email") || 
			customerParameterName.equals("required_date")) {
			return true;
		}
		/*
		 * Special case 2: Based on our documented business rules, the sales employee number are
		 * not required when adding new customers. This business rule will remain unchanged, thus
		 * eliminating the code to check the optionality of these columns.
		 */
		else if (customerParameterName.equals("salesrepemployeenumber")) {
			return false;
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
	 * Check if the value is empty.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isEmpty(String parameterName, String parameterValue, Map<String, String> formValidationResult) {
		
		String errorMessage = "";
		
	    if (parameterValue.equals("")) {
	    	errorMessage = printError("REQUIRED", parameterName, "");
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	/**
	 * Check if the value only contains digit characters.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isDigit(String parameterName, String parameterValue, Map<String, String> formValidationResult) {
		
		String errorMessage = "";
		
    	for (char character : parameterValue.toCharArray()) {
    		if (!Character.isDigit(character)) {
    			errorMessage = printError("DIGIT_ONLY", parameterName, "");
    			formValidationResult.put(parameterName, errorMessage);
    			return true;
    		}
    	}
    	
    	return false;
	}
	
	/**
	 * Check if the magnitude of the value is less than the required minimum.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param min_len
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isTooSmall(String parameterName, int parameterValue, int min_val, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (parameterValue < min_val) {
	    	errorMessage = printError("TOO_SMALL", parameterName, String.valueOf(min_val));
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	/**
	 * Check if the magnitude of the value is more than the required maximum.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param max_len
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isTooBig(String parameterName, int parameterValue, int max_val, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (parameterValue > max_val) {
	    	errorMessage = printError("TOO_BIG", parameterName, String.valueOf(max_val));
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	/**
	 * Check if the length of the value is equivalent to the required length.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param len
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isExact(String parameterName, int parameterValue, int len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (parameterValue != len) {
	    	errorMessage = printError("EXACT", parameterName, String.valueOf(len));
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	/**
	 * Check if the length of the value is less than the required minimum.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param min_len
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isTooShort(String parameterName, String parameterValue, int min_len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (!parameterValue.equals("") && parameterValue.length() < min_len) {
	    	errorMessage = printError("TOO_SHORT", parameterName, String.valueOf(min_len));
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
	
	/**
	 * Check if the length of the value is more than the required maximum.
	 * 
	 * @param parameterName
	 * @param parameterValue
	 * @param max_len
	 * @param formValidationResult
	 * @return true if the value is not valid and vice versa
	 */
	private boolean isTooLong(String parameterName, String parameterValue, int max_len, Map<String, String> formValidationResult) {
		String errorMessage = "";
		
	    if (!parameterValue.equals("") && parameterValue.length() > max_len) {
	    	errorMessage = printError("TOO_LONG", parameterName, String.valueOf(max_len));
	    	formValidationResult.put(parameterName, errorMessage);
	    	return true;
	    }

	    return false;
	}
}
