package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.ShoppingCart;
import domain.ShoppingCartItem;

/**
 * Servlet implementation class ShoppingCartServlet
 */
@WebServlet(name="Shopping Cart Servlet", urlPatterns = {"/ShoppingCart", "/shoppingCart"})
public class ShoppingCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingCartServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ShoppingCart scList = (ShoppingCart) session.getAttribute("ShoppingCart");
		if(scList == null) scList = new ShoppingCart();
		String productName = request.getParameter("productName");
		if (productName != null) {
			ShoppingCartItem tmp = scList.getShoppingCartItem(productName);
			String type = request.getParameter("type");
			switch (type) {
				case "plus" :
					tmp.addItem();
					break;
				case "minus" :
					tmp.removeItem();
					break;
				case "remove" :
					scList.removeItem(tmp);
					break;
				default:
					break;
			}
			scList.countTotalPrice();
		}
		RequestDispatcher req = request.getRequestDispatcher("frontend/shoppingCart.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
