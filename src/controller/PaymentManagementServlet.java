package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import domain.Payment;
import domain.PaymentJson;
import session_bean.FormValidationLocal;
import session_bean.PaymentLocal;
import utility.PaginationRequestProcessor;
import utility.UrlGenerator;
import utility.Redirect;

/**
 * Servlet implementation class PaymentManagement
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet({"/managePayment", "/managepayment"})
public class PaymentManagementServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    
    @EJB
    private PaymentLocal paymentBean;
    
	@EJB
	private FormValidationLocal formValidator;
	
    public PaymentManagementServlet() {
        super();
    }

	/**
	 * Find the payment's record that matches with the customernumber and checknumber
	 * from the client's request.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * Check if it is a AJAX request	
		 * Reference: https://stackoverflow.com/a/4113258
		 */
	    boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

		/*
		 * <JSON response>. 
		 * Use payment bean to retrieve record based on unique identifiers. The
		 * record is then converted to JSON compatible object, before passed back
		 * to the client.
		 */
		if (ajax) {
			String customernumber = request.getParameter("customernumber");
			String checknumber = request.getParameter("checknumber");
		    Payment payment = paymentBean.findPayment(customernumber, checknumber);
		    request.setAttribute("payment", payment);
			
			PaymentJson paymentJson = new PaymentJson(payment);
			String json = new Gson().toJson(paymentJson);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
		} else {
		    RequestDispatcher req = request.getRequestDispatcher("404Error.jsp");
		    req.forward(request, response);
		}
	}

	/**
	 * To perform add, update, delete operation on payment's record.
	 */
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
		 * Use payment form validation service to produce
		 * JSON. The JSON is then passed back to the client 
		 * to display the relevant form error message.
		 */
	    if (ajax) {
	    	Map<String, String> formValidationResult = new LinkedHashMap<>();
    		formValidationResult = formValidator.validatePaymentForm(request);
	        String json = new Gson().toJson(formValidationResult);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        out.write(json);
	    }
		
		/*
		 * <Regular JSP Response>
		 * Perform CREATE, UPDATE, DELETE on payment.
		 */
		else {
			try {
			    if (action.equals("UPDATE")) {
			    	paymentBean.updatePayment(request);
			    } else if (action.equals("DELETE")) {
			    	paymentBean.deletePayment(request);
			    } else {
			    	paymentBean.addPayment(request);
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
			absoluteLink += "/Payment";
			UrlGenerator urlGenerator = new UrlGenerator(absoluteLink, nOfPages, currentPage, 
														 recordsPerPage, keyword, sortItem, sortType);
			request.setAttribute("urlGenerator", urlGenerator);

		    Redirect.navigateJS(out, urlGenerator.toString(), action);
		}
	}
}
