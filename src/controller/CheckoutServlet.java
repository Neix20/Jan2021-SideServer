package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Customer;
import domain.Employee;
import domain.Order;
import domain.Orderdetail;
import domain.ShoppingCart;
import domain.ShoppingCartItem;
import session_bean.CustomerSessionBeanLocal;
import session_bean.EmployeeSessionBeanLocal;
import session_bean.OrderDetailSessionBeanLocal;
import session_bean.OrderSessionBeanLocal;
import session_bean.PaymentSessionBeanLocal;
import utility.referenceNumberGenerator;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet({"frontend/Checkout", "/Checkout", "/checkout"})
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@EJB
	private EmployeeSessionBeanLocal empbean;
	
	@EJB
	private CustomerSessionBeanLocal customerbean;
	
	@EJB
	private PaymentSessionBeanLocal paymentbean;
	
	@EJB
	private OrderSessionBeanLocal orderbean;
	
	@EJB
	private OrderDetailSessionBeanLocal orderdetailbean;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckoutServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
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
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//Retrieve orders information
			ShoppingCart orderList = (ShoppingCart) request.getSession().getAttribute("order_product");
					
			BigDecimal totalOrderAmount = orderList.getTotalPrice();
			totalOrderAmount = totalOrderAmount.multiply(new BigDecimal(1.06));
		
		// Update customer information
			//Retrieve billing information a.k.a. customer information
			String customerName = request.getParameter("customername"); 
			String contactFirstname = request.getParameter("contact_firstname"); 
			String contactLastname = request.getParameter("contact_lastname"); 
			String phone = request.getParameter("phone"); 
			String email = request.getParameter("email"); 
			String addressLine1 = request.getParameter("addressline1"); 
			String addressLine2 = request.getParameter("addressline2");
			String city = request.getParameter("city"); 
			String state = request.getParameter("state");
			String postalCode = request.getParameter("postalcode");
			String country = request.getParameter("country"); 
			String salesPersonEmail = request.getParameter("sales_person_email");
			
			// Find employee's record by email
			Employee matchedEmployee = empbean.findEmployeeByEmail(salesPersonEmail);
			String salesEmployeeNumber = matchedEmployee.getEmployeenumber().toString();
			
			//Check if the customer's record exists in the database
			Customer customer = customerbean.findCustomerByEmail(email);
			String customerLimit = "0.0";
			
			// Update the credit limit
			if (customer == null) {
				customerLimit = String.format("%.2f", totalOrderAmount.doubleValue());
			} else {
				if (totalOrderAmount.doubleValue() > customer.getCreditlimit().doubleValue()) {
					customerLimit = String.format("%.2f", totalOrderAmount.doubleValue());
				}
			}
			
			String[] s1 = {
					customerName,
					contactFirstname,	
					contactLastname,
				    phone,
				    email,
				    addressLine1,
				    addressLine2,
				    city,
				    state,
				    postalCode,
				    country,
				    salesEmployeeNumber,
				    customerLimit,
			};
			
			// Update customer information
			String customerNumber = null;
			if (customer == null) {
				customerNumber = String.valueOf(customerbean.addCustomer(s1));
			} else {
				customerNumber = customer.getCustomernumber().toString();
				customerbean.updateCustomer(s1, customerNumber);
			}
		
		DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
		// Generate order and payment date
		Date orderPaymentDate = new Date();
		String orderPaymentDateStr = "";
		orderPaymentDateStr = dateFormat1.format(orderPaymentDate);
		
		// Generate required date
		String requiredDateStr = request.getParameter("required_date");
		
		// Update order information
			String[] s3 = {
				customerNumber,
				orderPaymentDateStr,
				requiredDateStr
			};
			Order order = new Order();
			order.setEverything2(s3);
			Integer ordernumber = orderbean.locateNextPK();
			orderbean.addOrder(order);
		
		// Update order detail information
			// The format of s4
			//s4 = {
			//	ordernumber,
			//	productcode,
			//	priceeach,
			//	quantityordered	
			//};
			String[] s4 = {"", "", "", "", ""};
			s4[0] = String.valueOf(ordernumber);
			int orderlineStartNumber = 0;
			
			for (ShoppingCartItem orderItem : orderList.getList()) {
				String productcode = orderItem.getProductcode();
				String priceeach = orderItem.getMsrp().toString();
				String quanityordered = String.valueOf(orderItem.getQuantity());
				String orderlinenumber = String.valueOf(++orderlineStartNumber);
				s4[1] = productcode;
				s4[2] = priceeach;
				s4[3] = quanityordered;
				s4[4] = orderlinenumber;
				Orderdetail orderdetail = new Orderdetail();
				orderdetail.setEverything(s4);
				orderdetailbean.addOrderdetail(orderdetail);
			}
		
		// Update payment information
			
			// Generate reference number
			int alphaNumericLength = 8;
			String refNo = new referenceNumberGenerator(alphaNumericLength).generate();
			refNo += customerNumber;
			// Rename reference number back to check number due to assignment constraint
			String checkNumber = refNo;
			String paymentMethod = request.getParameter("payment_method");
			String paymentType = null;
			String cardType = request.getParameter("card_type");
			if (paymentMethod.equals("card")) {
				if (cardType.equals("credit_card"))
					paymentType = "credit card";
				else
					paymentType = "debit card";
			} else {
				paymentType = "online banking";
			}
			
			String[] s2 = {
				customerNumber,
				checkNumber,
				String.format("%.2f", totalOrderAmount.doubleValue()),	
				orderPaymentDateStr,
				paymentType,
			};
		
		paymentbean.addPayment(s2);
		
		//Forward to print receipt
			//Retrieve payment method
			if (paymentMethod.equals("card")) {
				request.getParameter("card_type");
				request.getParameter("card_holder_name");
				request.getParameter("card_number");
				request.getParameter("card_month");
				request.getParameter("card_year");
				request.getParameter("card_cvv");
			}
			else if (paymentMethod.equals("bank")) {
				request.getParameter("bank_holder_name");
				request.getParameter("bank_number");
				request.getParameter("bank_account_number");
			}
			
			request.setAttribute("invoice_no", checkNumber);
			request.setAttribute("purchased_order_product", orderList);
			request.setAttribute("sales_representative", matchedEmployee);
		    RequestDispatcher req = request.getRequestDispatcher("${pageContext.request.contextPath}/frontend/Receipt");
		    req.forward(request, response);
	}
}
