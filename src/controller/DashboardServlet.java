package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
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
import utility.html_generator;

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
		//Use Stream Filter Reduce to sum up all the buyPrice, Sell Price, Total Sales Revenue
		List<DashboardOrder> tmp = new ArrayList<DashboardOrder>();
		ArrayList<Integer> totalOrderWeekList = new ArrayList<Integer>(), totalProductWeekList = new ArrayList<Integer>();
		ArrayList<BigDecimal> totalBuyPriceWeekList = new ArrayList<BigDecimal>(), totalMsrpWeekList = new ArrayList<BigDecimal>(), totalSalesWeekList = new ArrayList<BigDecimal>();
		BigDecimal buyPriceWeekSum, msrpWeekSum, salesWeekSum;
		ShoppingCart weekCartList;
		int weekNum = 1;
		for(DashboardOrder dbo : orderMonthList) {
			if(weekNum == dbo.getWeekRange()) {
				tmp.add(dbo);
			}else {
				//Execute Last List
				weekCartList = getShoppingCartList(tmp);
				weekCartList.countTotalPrice();
				
				//Total Number of Orders for the Week
				totalOrderWeekList.add(tmp.size());
				
				//Total Number of Products
				totalProductWeekList.add(weekCartList.count());
				
				//Total Buy Price for the week
				buyPriceWeekSum = weekCartList.getList().stream().map(y -> y.getBuyprice().multiply(new BigDecimal(y.getQuantity()))).reduce(BigDecimal.ZERO, BigDecimal::add);
				totalBuyPriceWeekList.add(buyPriceWeekSum);
				
				//Total MSRP for the week
				msrpWeekSum = weekCartList.getTotalPrice();
				totalMsrpWeekList.add(msrpWeekSum);
				
				//Total Sales Revenue for the week
				salesWeekSum = msrpWeekSum.subtract(buyPriceWeekSum);
				totalSalesWeekList.add(salesWeekSum);
				
				weekNum = dbo.getWeekRange();
				
				//Init new List
				tmp = new ArrayList<DashboardOrder>();
				tmp.add(dbo);
			}
		}
		//Execute Last List
		weekCartList = getShoppingCartList(tmp);
		weekCartList.countTotalPrice();
		
		//Total Number of Orders for the Week
		totalOrderWeekList.add(tmp.size());
		
		//Total Number of Products
		totalProductWeekList.add(weekCartList.count());
		
		//Total Buy Price for the week
		buyPriceWeekSum = weekCartList.getList().stream().map(y -> y.getBuyprice().multiply(new BigDecimal(y.getQuantity()))).reduce(BigDecimal.ZERO, BigDecimal::add);
		totalBuyPriceWeekList.add(buyPriceWeekSum);
		
		//Total MSRP for the week
		msrpWeekSum = weekCartList.getTotalPrice();
		totalMsrpWeekList.add(msrpWeekSum);
		
		//Total Sales Revenue for the week
		salesWeekSum = msrpWeekSum.subtract(buyPriceWeekSum);
		totalSalesWeekList.add(salesWeekSum);
		
		out.println("<h1>Total Orders Week</h1>");
		for(int i : totalOrderWeekList) {
			out.println(html_generator.p_tag("Total Order Week: " + i));
		}
		
		out.println("<h1>Total Products Week</h1>");
		for(int i : totalProductWeekList) {
			out.println(html_generator.p_tag("Total Products Week: " + i));
		}
		
		out.println("<h1>Total Buy Price Week: </h1>");
		for(BigDecimal bd : totalBuyPriceWeekList) {
			out.println(html_generator.p_tag("Total Buy Price: " + bd.setScale(2, RoundingMode.HALF_UP)));
		}
		
		out.println("<h1>Total MSRP Week: </h1>");
		for(BigDecimal bd : totalMsrpWeekList) {
			out.println(html_generator.p_tag("Total MSRP Price: " + bd.setScale(2, RoundingMode.HALF_UP)));
		}
		
		out.println("<h1>Total Sales Revenue Week: </h1>");
		for(BigDecimal bd : totalSalesWeekList) {
			out.println(html_generator.p_tag("Total Sales Revenue: " + bd.setScale(2, RoundingMode.HALF_UP)));
		}
		

		ShoppingCart scList = getShoppingCartList(orderMonthList);
		List<ShoppingCartItem> tmpList = scList.getList().stream().sorted(Comparator.comparingInt(ShoppingCartItem::getQuantity)).collect(Collectors.toList());
		Collections.reverse(tmpList);
		
		int orderShipped = orderMonthList.stream().filter(y -> y.getStatus().equals("Shipped")).collect(Collectors.toList()).size();
		int orderHaventShipped = orderMonthList.size() - orderShipped;
		
		out.println(html_generator.p_tag("Total Quantity: " + scList.count()));
		out.println(html_generator.p_tag("Total Order Shipped: " + orderShipped));
		out.println(html_generator.p_tag("Total Order not shipped: " + orderHaventShipped));
		
		out.println(html_generator.p_tag("Mum"));
		
		
		BigDecimal totalBuyPriceMonth, totalSalesMonth, totalMsrpMonth = scList.getTotalPrice();
		totalBuyPriceMonth = scList.getList().stream().map(y -> y.getBuyprice().multiply(new BigDecimal(y.getQuantity()))).reduce(BigDecimal.ZERO, BigDecimal::add);
		totalSalesMonth = totalMsrpMonth.subtract(totalBuyPriceMonth);
		
		out.println(html_generator.p_tag("Total Sales Revenue: " + totalSalesMonth.doubleValue()));
		
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

	
	//Convert this to DashBoardOrder List Parameter and put it in Utilities
	public ShoppingCart getShoppingCartList(List<DashboardOrder> dboList) {
		List<Orderdetail> orderdetailList = new ArrayList<Orderdetail>();
		ShoppingCart scList = new ShoppingCart();
		for (DashboardOrder dbo : dboList) {
			List<Orderdetail> tmp = orderDetailBean.getAllOrderDetails(dbo.getOrdernumber());
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
	
	//Key => Productline, value => Count
	public HashMap<String, Integer> getProductlineHashMap(ShoppingCart scList) {
		List<Productline> productlineList = productlineBean.getAllProductline();
		HashMap<String, Integer> productlineHashMap = new HashMap<String, Integer>();
		
		for (Productline pl : productlineList) {
			int quantity = scList.getList().stream().filter(x -> x.getProductline().equals(pl.getProductline())).reduce(0, (sum, y) -> sum + y.getQuantity(), Integer::sum);
			productlineHashMap.put(pl.getProductline(), quantity);
		}

		return productlineHashMap;
	}

}
