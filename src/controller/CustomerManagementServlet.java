package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import domain.Customer;
import domain.CustomerJson;
import session_bean.CustomerLocal;
import session_bean.FormValidationLocal;
import utility.PaginationRequestProcessor;
import utility.UrlGenerator;
import utility.Redirect;

/**
 * Servlet implementation class CustomerManagement
 * 
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
 */
@WebServlet({"/manageCustomer", "/managecustomer"})
public class CustomerManagementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private CustomerLocal customerBean;
    
	@EJB
	private FormValidationLocal formValidator;

    public CustomerManagementServlet() {
    	super();
    }

	/**
	 * Find the customer's record that matches with the customernumber
	 * from the client's request.
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("customernumber");
	    Customer customer = customerBean.findCustomerById(id);
	    request.setAttribute("customer", customer);
	
		/*
		 * Check if it is a AJAX request	
		 * Reference: https://stackoverflow.com/a/4113258
		 */
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		/*
		 * <JSON response>. 
		 * Use customer bean to retrieve record based on unique identifier. The
		 * record is then converted to JSON compatible object, before passed back
		 * to the client.
		 */
		if (ajax) {
			CustomerJson customJson = new CustomerJson(customer);
			String json = new Gson().toJson(customJson);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
		} else {
			//TODO 404 Not found
		}
    }

	/**
	 * To perform add, update, delete operation on customer's record.
	 */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	PrintWriter out = response.getWriter();
    	String action = request.getParameter("user_action");
    	
		/*
		 * Check if it is a AJAX request	
		 * Reference: https://stackoverflow.com/a/4113258
		 */
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

		/*
		 * <JSON response>. 
		 * Use customer form validation service to produce
		 * JSON. The JSON is then passed back to the client 
		 * to display the relevant form error message.
		 */
	    if (ajax) {
	    	Map<String, String> formValidationResult = new LinkedHashMap<>();
	    	// Only validate form if user wants to add or update record
	    	if (!action.equals("DELETE")) {
	    		formValidationResult = formValidator.validateCustomerForm(request);
	    	}
	        String json = new Gson().toJson(formValidationResult);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        out.write(json);
	    } 
	    
		/*
		 * <Regular JSP Response>
		 * Perform CREATE, UPDATE, DELETE on customer.
		 */
	    else {
			try {
			    if (action.equals("UPDATE")) {
			    	customerBean.updateCustomer(request);
			    } else if (action.equals("DELETE")) {
			    	customerBean.deleteCustomer(request);
			    } else {
			    	customerBean.addCustomer(request);
			    }	
			} catch (EJBException ex) {
				throw ex;
			}
			
			// Use custom class to process the request's parameter to reduce redundancy
			PaginationRequestProcessor requestProcessor = new PaginationRequestProcessor();
			requestProcessor.process(request);
			int nOfPages = requestProcessor.getnOfPages();
			int currentPage = requestProcessor.getCurrentPage();
			int recordsPerPage = requestProcessor.getRecordsPerPage();
			String keyword = requestProcessor.getKeyword();
			String sortItem = requestProcessor.getSortItem();
			String sortType = requestProcessor.getSortType();
			
			String absoluteLink = request.getContextPath();
			absoluteLink += "/Customer";
			UrlGenerator urlGenerator = new UrlGenerator(absoluteLink, nOfPages, currentPage, 
														 recordsPerPage, keyword, sortItem, sortType);
			request.setAttribute("urlGenerator", urlGenerator);
			
		    Redirect.navigateJS(out, urlGenerator.toString(), action);
	    }
    }
}
