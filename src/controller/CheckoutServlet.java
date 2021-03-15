package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import domain.ShoppingCart;
import session_bean.FormValidationLocal;
import session_bean.CustomerLocal;
import session_bean.EmployeeSessionBeanLocal;
import session_bean.CheckoutServiceLocal;
/**
 * Servlet implementation class CheckoutServlet
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet({"/Checkout", "/checkout"})
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal empbean;
	
	@EJB
	private CheckoutServiceLocal paymentServiceBean;
	
	@EJB
	private CustomerLocal customerBean;
	
	@EJB
	private FormValidationLocal formValidator;
	
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
	    	Map<String, String> formValidationResult = formValidator.validateCustomerForm(request);
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
}