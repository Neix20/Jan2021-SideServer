package session_bean;

import java.math.BigDecimal;

import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.servlet.http.HttpServletRequest;

import domain.Customer;
import domain.Employee;
import domain.Order;
import domain.Orderdetail;
import domain.Product;
import domain.ShoppingCart;
import domain.ShoppingCartItem;

/**
 * Fascade implementation class PurchaseServiceProvider
 * PurchaseServiceProvider delegates client requests to appropriate subsystems, some
 * of the subsystems are payment system, order placing system, inventory system, and
 * so on.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@Stateless
@LocalBean
public class CheckoutServiceBean implements CheckoutServiceLocal {

	@EJB
	private EmployeeSessionBeanLocal empbean;
	
	@EJB
	private CustomerLocal customerbean;
	
	@EJB
	private PaymentLocal paymentbean;
	
	@EJB
	private OrderSessionBeanLocal orderbean;
	
	@EJB
	private OrderDetailSessionBeanLocal orderdetailbean;
	
	@EJB
	private ProductSessionBeanLocal productbean;
	
    public CheckoutServiceBean() {
    }
	
    @Override
	public void run(HttpServletRequest request) {
		/* =================================================================================================
		   <Manage purchase information>
		   1) Retrieve order item
		   2) Use `computeTotal` service to compute the sum of the orders of the customer
		   3) Use `findEmployeeByEmail` service to find sales rep of the customer
		   4) Use `updateCustomerInfo` service to update customer information a.k.a billing information
		   ================================================================================================= */
		// 1)
		ShoppingCart orderList = (ShoppingCart) request.getSession().getAttribute("order_product");
		// 2)
		BigDecimal totalOrderAmount = orderList.getTotalPrice();
		totalOrderAmount = computeTotal(totalOrderAmount);
		// 3)
		Employee salesEmployee = findEmployeeByEmail(request);
		String salesEmployeeNumber = salesEmployee.getEmployeenumber().toString();
		// 4) 
		String customerNumber = updateCustomerInfo(request, totalOrderAmount, salesEmployeeNumber);
		/* ==================================================================================================
		   <Manage payment>
		   Use `makePayment` service to make payment
		   ================================================================================================== */
		String[] paymentServiceOutput = makePayment(request, customerNumber, totalOrderAmount.toString());
		String checkNumber = paymentServiceOutput[0];
		String paymentType = paymentServiceOutput[1]; //TODO set payment type?
		String paymentDate = paymentServiceOutput[2];
		/* ==================================================================================================
		   <Manage order>
		   Use `placeOrder` service to put order
		   ================================================================================================== */
		placeOrder(request, customerNumber, orderList, paymentDate);
		/* ==================================================================================================
		   <Finishing purchase process>
		   1) Clear shopping cart
		   2) Clear ordered/purchased product
		   3) Save some important information to be displayed in the receipt later.
		   ================================================================================================== */
		// 1)
		request.getSession().removeAttribute("ShoppingCart");
		// 2)
		request.getSession().removeAttribute("order_product");
		// 3)
		/* ==================================================================================================
		   <Update inventory>
		   Use `updateInventory` service to deduct the inventory after a successful purchase.
		   ================================================================================================== */
		updateInventory(orderList);
		
		request.setAttribute("receipt_no", checkNumber);
		request.setAttribute("payment_type", paymentType);
		request.setAttribute("payment_date", paymentDate);
		request.setAttribute("purchased_order_product", orderList);
		request.setAttribute("sales_representative", salesEmployee);
	}
		
	/**
	 * 6% Sales & service tax (SST) included in the payment amount XD
	 * @param totalOrderAmount
	 * @return totalOrderAmount * 1.06
	 */
	private BigDecimal computeTotal(BigDecimal totalOrderAmount) {
		totalOrderAmount = totalOrderAmount.multiply(new BigDecimal(1.06));
		return totalOrderAmount;
	}
	
	/**
	 * Find employee's record by email
	 * @param request
	 * @return salesEmployee
	 */
	private Employee findEmployeeByEmail(HttpServletRequest request) {
		String salesPersonEmail = request.getParameter("sales_person_email");
		Employee salesEmployee = empbean.findEmployeeByEmail(salesPersonEmail);
		return salesEmployee;
	}
	
	/**
	 * Update customer information a.k.a billing information
	 * 
	 * <Update the credit limit.>
	 * ASSUMPTION: The customer already agreed on a price from his/her sales representative beforehand.
	 * Nevertheless, the salesperson later can still edit the order information or customer limit 
	 * by themselves if needed.
	 * 
	 * <Update customer information based on the email address.>
	 * ASSUMPTION: When the customer input his/her email address in the order form,
	 * the servlet will check if the email address already exists in the database.
	 * If the email address already exists, then the matched customer's record will
	 * be updated in the database accordingly.
	 * Else if the email address does not exist, then the customer's record will be
	 * added to the database.
	 * 
	 * @param request
	 * @param totalOrderAmount
	 * @param salesEmployeeNumber
	 * @return customerNumber
	 */
	private String updateCustomerInfo(HttpServletRequest request, BigDecimal totalOrderAmount, String salesEmployeeNumber) {
		//Retrieve billing information a.k.a. customer information
		
		// Get customer information from request's parameter
		String customerName = request.getParameter("customername"); 
		String contactFirstname = request.getParameter("contactfirstname"); 
		String contactLastname = request.getParameter("contactlastname"); 
		String phone = request.getParameter("phone"); 
		String email = request.getParameter("email"); 
		String addressLine1 = request.getParameter("addressline1"); 
		String addressLine2 = request.getParameter("addressline2");
		String city = request.getParameter("city"); 
		String state = request.getParameter("state");
		String postalCode = request.getParameter("postalcode");
		String country = request.getParameter("country"); 
		
		//Check if the customer's record already exists in the database
		Customer customer = customerbean.findCustomerByEmail(email);
		String customerLimit = "0.0";
		if (customer == null) {
			customerLimit = String.format("%.2f", totalOrderAmount.doubleValue());
		} else {
			/* Update the credit limit of existing customer if the customer current order amount 
			 * exceeds the current credit limit. Since the customer manages to pay, why not 
			 * automatically update the credit limit straight away?
			 */
			if (totalOrderAmount.doubleValue() > customer.getCreditlimit().doubleValue()) {
				customerLimit = String.format("%.2f", totalOrderAmount.doubleValue());
			}
		}
		
		// Package customer information into a single array
		String[] customerAttributes = {
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
		
		String customerNumber = null;
		if (customer == null) {
			customerNumber = String.valueOf(customerbean.addCustomer(customerAttributes));
		} else {
			customerNumber = customer.getCustomernumber().toString();
			customerbean.updateCustomer(customerAttributes, customerNumber);
		}
		
		return customerNumber;
	}
	
	/**
	 * Make payment a.k.a add payment's record to the database
	 * @param request
	 * @param customerNumber
	 * @param totalOrderAmount
	 * @return paymentServiceOutput, consists of checkNumber, paymentType, orderPaymentDateStr
	 */
	private String[] makePayment(HttpServletRequest request, String customerNumber, String totalOrderAmount) {		
		String paymentMethod = request.getParameter("payment_method");
		String cardType = request.getParameter("card_type");
		
		String[] paymentDetails = {
			customerNumber,
			paymentMethod,
			cardType,
			totalOrderAmount,
		};
		
		String[] paymentServiceOutput = paymentbean.performPayment(paymentDetails);
		
		return paymentServiceOutput;
	}
	
	/**
	 * Place order a.k.a add order's and order details' record to the database
	 * @param request
	 * @param customerNumber
	 * @param orderList
	 * @param orderDate
	 */
	private void placeOrder(HttpServletRequest request, String customerNumber, ShoppingCart orderList, String orderDate) {
		String requiredDate = request.getParameter("required_date");
		
		// Update `order` information
		String[] orderAttributes = {
			customerNumber,
			orderDate,
			requiredDate
		};
		Order order = new Order();
		/*
		 * Using my fellow teammate, Tan Xi En's module function.
		 */
		order.setEverything2(orderAttributes);
		Integer ordernumber = orderbean.locateNextPK();
		orderbean.addOrder(order);
		
		/* Update `order detail` information
		 * The format of orderDetailAttributes
		 *	orderDetailAttributes = {
		 *		ordernumber,
		 *		productcode,
		 *		priceeach,
		 *		quantityordered	
		 *	};
		 */

		/*
		 * Add the ordered items to the orderdetails one by one.
		 */
		String[] orderDetailAttributes = {"", "", "", "", ""};
		orderDetailAttributes[0] = String.valueOf(ordernumber);
		int orderlineStartNumber = 0;
		
		for (ShoppingCartItem orderItem : orderList.getList()) {
			String productcode = orderItem.getProductcode();
			String priceeach = orderItem.getMsrp().toString();
			String quanityordered = String.valueOf(orderItem.getQuantity());
			String orderlinenumber = String.valueOf(++orderlineStartNumber);
			orderDetailAttributes[1] = productcode;
			orderDetailAttributes[2] = priceeach;
			orderDetailAttributes[3] = quanityordered;
			orderDetailAttributes[4] = orderlinenumber;
			Orderdetail orderdetail = new Orderdetail();
			orderdetail.setEverything(orderDetailAttributes);
			orderdetailbean.addOrderdetail(orderdetail);
		}
	}
	
	/**
	 * Update inventory after a successful purchase.
	 * @param orderList
	 */
	private void updateInventory(ShoppingCart orderList) {
		for (ShoppingCartItem orderItem : orderList.getList()) {
			String productcode = orderItem.getProductcode();
			Integer quanityordered = orderItem.getQuantity();
			Product product = productbean.getProduct(productcode);
			product.setQuantityinstock(product.getQuantityinstock()-quanityordered);
			productbean.updateProduct(product);
		}
	}
}
