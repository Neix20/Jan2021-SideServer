package controller;

import java.io.IOException;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Orderdetail;
import domain.Product;
import session_bean.OrderDetailSessionBeanLocal;
import session_bean.ProductSessionBeanLocal;

/**
 * Servlet implementation class OrderDetailServlet
 */
@WebServlet(name = "Order Detail Servlet", urlPatterns = { "/manageOrderDetail", "/orderDetail", "/OrderDetail" })
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
		int end_num = (currentPage * recordsPerPage > orderdetailList.size()) ? orderdetailList.size()
				: currentPage * recordsPerPage;

		orderdetailList = orderdetailList.subList(start_num, end_num);

		request.setAttribute("servlet_name", "manageOrderDetail");
		request.setAttribute("orderdetailList", orderdetailList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);

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
		doGet(request, response);
	}

}
