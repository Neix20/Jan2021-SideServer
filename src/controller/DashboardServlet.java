package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.DashboardOrder;
import domain.Order;
import domain.Orderdetail;
import domain.OrderdetailPK;
import domain.Product;
import domain.Productline;
import domain.ShoppingCart;
import domain.ShoppingCartItem;
import session_bean.OrderDetailSessionBeanLocal;
import session_bean.OrderSessionBeanLocal;
import session_bean.ProductSessionBeanLocal;
import session_bean.ProductlineSessionBeanLocal;

/**
 * Servlet implementation class DashboardServlet
 */
@WebServlet(name = "Dashboard Servlet", urlPatterns = { "/manageDashboard", "/dashboard", "/Dashboard" })
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private OrderSessionBeanLocal orderBean;

	@EJB
	private OrderDetailSessionBeanLocal orderDetailBean;

	@EJB
	private ProductlineSessionBeanLocal productlineBean;

	@EJB
	private ProductSessionBeanLocal productBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DashboardServlet() {
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

		String date_select = request.getParameter("date_select");
		if (date_select == null)
			date_select = "Apr 2003";

		List<Object[]> options = orderBean.getDashboardOrdersOption();
		List<String> date_options = new ArrayList<String>();

		for (Object[] a : options) {
			String str = a[0].toString() + " " + a[1].toString();
			date_options.add(str);
		}

		List<Order> orderList = orderBean.getOrderMonth(date_select);

		List<DashboardOrder> orderMonthList = new ArrayList<DashboardOrder>();

		for (Order o : orderList) {
			try {
				DashboardOrder tmp = new DashboardOrder(o);
				orderMonthList.add(tmp);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		PrintWriter out = response.getWriter();
		
		//Get Weekly Order
		//Use Stream Filter

		ShoppingCart scList = getShoppingCartList(orderList);
		List<ShoppingCartItem> tmpList = scList.getList().stream().sorted(Comparator.comparingInt(ShoppingCartItem::getQuantity)).collect(Collectors.toList());
		Collections.reverse(tmpList);
		
		for(ShoppingCartItem sc : tmpList) {
			out.println("<p>" + sc.getProductname() + " " + sc.getQuantity() + "</p>");
		}

		HashMap<String, Integer> productlineHashMap = getProductlineHashMap(scList);

		for (String s : productlineHashMap.keySet()) {
			out.println("<p>" + s + " " + productlineHashMap.get(s) + "</p>");
		}

//		request.setAttribute("servlet_name", "manageDashboard");
//		request.setAttribute("date_options", date_options);
//		request.setAttribute("orderMonthList", orderMonthList);
//		
//		RequestDispatcher req = request.getRequestDispatcher("backend/dashboardDebug.jsp");
//		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	public ShoppingCart getShoppingCartList(List<Order> orderList) {
		List<Orderdetail> orderdetailList = new ArrayList<Orderdetail>();
		ShoppingCart scList = new ShoppingCart();
		for (Order o : orderList) {
			List<Orderdetail> tmp = orderDetailBean.getAllOrderDetails(o.getOrdernumber());
			orderdetailList.addAll(tmp);
		}

		for (Orderdetail od : orderdetailList) {
			OrderdetailPK tmpId = od.getId();
			Product p = productBean.getProduct(tmpId.getProductcode());
			int quantity = od.getQuantityordered();
			ShoppingCartItem sc = new ShoppingCartItem(p, quantity);
			scList.addItem(sc);
		}

		return scList;
	}

	public HashMap<String, Integer> getProductlineHashMap(ShoppingCart scList) {
		List<Productline> productlineList = productlineBean.getAllProductline();
		HashMap<String, Integer> productlineHashMap = new HashMap<String, Integer>();
		for (Productline pl : productlineList)
			productlineHashMap.put(pl.getProductline(), 0);

		for (ShoppingCartItem sc : scList.getList()) {
			int x = productlineHashMap.get(sc.getProductline());
			for (int i = 0; i < sc.getQuantity(); i++)
				x++;
			productlineHashMap.put(sc.getProductline(), x);
		}

		return productlineHashMap;
	}

}
