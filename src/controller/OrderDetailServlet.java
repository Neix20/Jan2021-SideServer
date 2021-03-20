package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Orderdetail;
import domain.OrderdetailPK;
import domain.Product;
import session_bean.OrderDetailSessionBeanLocal;
import session_bean.ProductSessionBeanLocal;
import utility.html_generator;

/**
 * Servlet implementation class OrderDetailServlet
 */
@WebServlet(name = "Order Detail Servlet", urlPatterns = { "/manageOrderDetail"})
public class OrderDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private OrderDetailSessionBeanLocal orderDetailBean;
	
	@EJB
	private ProductSessionBeanLocal productBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OrderDetailServlet() {
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
		int orderNumber = Integer.valueOf(request.getParameter("orderNumber"));
		List<Orderdetail> orderdetailList = orderDetailBean.getAllOrderDetails(orderNumber);
		
		for(Orderdetail od : orderdetailList) {
			Product p = productBean.getProduct(od.getId().getProductcode());
			od.setProduct(p);
		}

		int recordsPerPage = 10, nOfPage = orderdetailList.size() / recordsPerPage;
		nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > orderdetailList.size()) ? orderdetailList.size() : currentPage * recordsPerPage;

		orderdetailList = (orderdetailList.isEmpty()) ? orderdetailList : orderdetailList.subList(start_num, end_num);
		
		List<Product> productList = productBean.getAllProduct();

		request.setAttribute("servlet_name", "manageOrderDetail");
		request.setAttribute("orderdetailList", orderdetailList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("orderNumber", orderNumber);
		request.setAttribute("productList", productList);

		RequestDispatcher req = request.getRequestDispatcher("backend/manageOrderDetail.jsp");
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
		String[] parameter = Orderdetail.getParameter();
		String[] arr = new String[parameter.length];
		
		for(int i = 0; i < arr.length; i++) arr[i] = request.getParameter(parameter[i]);
		
		Orderdetail od;
		Product p;
		OrderdetailPK tmp;
		PrintWriter out = response.getWriter();
		
		switch(type) {
		case "ADD":
			od = new Orderdetail();
			p = productBean.getProduct(arr[1]);
			arr[4] = p.getMsrp().toString();
			od.setEverything2(arr);
			orderDetailBean.addOrderdetail(od);
			out.println(html_generator.operation_complete("added", "manageOrderDetail?orderNumber=" + arr[0]));
			break;
		case "UPDATE":
			tmp = new OrderdetailPK(Integer.valueOf(arr[0]), arr[1]);
			od = orderDetailBean.getOrderdetail(tmp);
			p = productBean.getProduct(arr[1]);
			arr[4] = p.getMsrp().toString();
			od.setEverything2(arr);
			orderDetailBean.updateOrderdetail(od);
			out.println(html_generator.operation_complete("updated", "manageOrderDetail?orderNumber=" + arr[0]));
			break;
		case "DELETE":
			tmp = new OrderdetailPK(Integer.valueOf(arr[0]), arr[1]);
			od = orderDetailBean.getOrderdetail(tmp);
			orderDetailBean.deleteOrderdetail(od);
			out.println(html_generator.operation_complete("deleted", "manageOrderDetail?orderNumber=" + arr[0]));
			break;
		}
	}

}
