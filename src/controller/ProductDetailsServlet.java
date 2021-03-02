package controller;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Product;
import session_bean.ProductSessionBeanLocal;

/**
 * Servlet implementation class ProductDetailsServlet
 */
@WebServlet(name="Product Details Servlet", urlPatterns = {"/ProductDetailsServlet", "/productDetails"})
public class ProductDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	private ProductSessionBeanLocal productBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String productCode = request.getParameter("productCode");
		String image_url = request.getParameter("image_url");
		
		Product p = productBean.getProduct(productCode);
		
		request.setAttribute("Product", p);
		request.setAttribute("image_url", image_url);
		RequestDispatcher req = request.getRequestDispatcher("frontend/productDetails.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
