package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.ShoppingCart;

/**
 * Servlet implementation class Receipt
 */
@WebServlet({ "frontend/Receipt", "/Receipt", "/receipt" })
public class ReceiptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReceiptServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ShoppingCart purchasedOrderProduct = (ShoppingCart) request.getAttribute("purchased_order_product");
		
		if (purchasedOrderProduct == null) {
			response.setHeader("Refresh", "8; URL="+request.getContextPath()+"/Checkout");
			RequestDispatcher req = request.getRequestDispatcher("receipt_error.jsp");
			req.forward(request, response);
		}
		else {
			RequestDispatcher req = request.getRequestDispatcher("receipt.jsp");
			req.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
