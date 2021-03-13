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
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet({ "frontend/Receipt", "/Receipt", "/receipt" })
public class ReceiptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public ReceiptServlet() {
        super();
    }

    /**
     * Check if user has already done payment before proceed to display receipt. 
     * If the user hasn't done any payment, the servlet will forward to receipt_error.jsp
     * before redirecting to checkout page.
     * Else, the servlet will forward to receipt.jsp to proceed to display receipt.
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
