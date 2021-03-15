package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Customer;
import domain.Order;
import session_bean.CustomerLocal;
import session_bean.OrderSessionBeanLocal;
import utility.html_generator;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet(name = "Order Servlet", urlPatterns = { "/Order", "/order", "/manageOrders" })
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private OrderSessionBeanLocal orderBean;
	
	@EJB
	private CustomerLocal customerBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Order> orderList = orderBean.getAllOrders();
		
		int recordsPerPage = 10, nOfPage = orderList.size() / recordsPerPage;
		nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > orderList.size()) ? orderList.size() : currentPage * recordsPerPage;

		orderList = (orderList.isEmpty()) ? orderList : orderList.subList(start_num, end_num);
		int nextOrderNumber = orderBean.locateNextPK() + 1;
		
		List<Customer> customerList = customerBean.getAllCustomer();
		
		HashMap<Integer, String> customerHashMap = new HashMap<Integer, String>();
		for(Customer c : customerList)
			customerHashMap.put(c.getCustomernumber(), c.getCustomername());

		request.setAttribute("servlet_name", "manageOrders");
		request.setAttribute("orderList", orderList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("customerList", customerList);
		request.setAttribute("customerHashMap", customerHashMap);
		request.setAttribute("nextOrderNumber", nextOrderNumber);

		RequestDispatcher req = request.getRequestDispatcher("backend/manageOrder.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type = request.getParameter("type");
		String[] parameter = Order.getParameter();
		String[] arr = new String[parameter.length];
		
		for(int i = 0; i < arr.length; i++) arr[i] = request.getParameter(parameter[i]);
		
		Order o;
		PrintWriter out = response.getWriter();
		
		switch(type) {
		case "ADD":
			o = new Order();
			o.setEverything(arr);
			orderBean.addOrder(o);
			out.println(html_generator.operation_complete("added", "manageOrders"));
			break;
		case "UPDATE":
			o = orderBean.getOrder(arr[0]);
			o.setEverything(arr);
			orderBean.updateOrder(o);
			out.println(html_generator.operation_complete("updated", "manageOrders"));
			break;
		case "DELETE":
			o = orderBean.getOrder(arr[0]);
			orderBean.deleteOrder(o);
			out.println(html_generator.operation_complete("deleted", "manageOrders"));
			break;
		}
	}

}
