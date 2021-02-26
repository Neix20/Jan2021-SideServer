package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utilities.html_generator;
import domain.Product;
import sessionBean.ProductSessionBeanLocal;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	private ProductSessionBeanLocal productBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String keyword = request.getParameter("keyword");
		List<Product> list = productBean.getAllProduct();
		List<Product> SearchResult = (keyword != null) ? productBean.getSearchResult(keyword) : new ArrayList<Product>();	
		request.setAttribute("List", list);
		request.setAttribute("SearchResult", SearchResult);
		RequestDispatcher req = request.getRequestDispatcher("productDebug.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String type = request.getParameter("type");
		
		//Convert this shit to array
		String productcode = request.getParameter("productcode");
		String productname = request.getParameter("productname");
		String productdescription = request.getParameter("productdescription");   
		String productscale = request.getParameter("productscale");
		String productvendor = request.getParameter("productvendor");
		String productline = request.getParameter("productline");
		String quantity = request.getParameter("quantity");
		String buyprice = request.getParameter("buyprice");
		String msrp = request.getParameter("msrp");
		String description = request.getParameter("description");
		Product p;
		PrintWriter out = response.getWriter();
		switch(type) {
		case "ADD":
			p = new Product();
			p.setBuyprice(new BigDecimal(buyprice));
			p.setMsrp(new BigDecimal(msrp));
			p.setProductcode(productcode);
			p.setProductdescription(productdescription);
			p.setProductname(productname);
			p.setProductscale(productscale);
			p.setProductvendor(productvendor);
			p.setQuantityinstock(Integer.valueOf(quantity));
			p.setProductline(productline);
			productBean.addProduct(p);
			out.println(html_generator.operation_complete("added", "ProductServlet"));
			break;
		case "UPDATE":
			p = productBean.getProduct(productcode);
			p.setBuyprice(new BigDecimal(buyprice));
			p.setMsrp(new BigDecimal(msrp));
			p.setProductcode(productcode);
			p.setProductdescription(productdescription);
			p.setProductname(productname);
			p.setProductscale(productscale);
			p.setProductvendor(productvendor);
			p.setQuantityinstock(Integer.valueOf(quantity));
			p.setProductline(productline);
			productBean.updateProduct(p);
			out.println(html_generator.operation_complete("updated", "ProductServlet"));
			break;
		case "DELETE":
			p = productBean.getProduct(productcode);
			productBean.deleteProduct(p);
			out.println(html_generator.operation_complete("deleted", "ProductServlet"));
			break;
		}
	}

}
