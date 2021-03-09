package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Product;
import domain.Productline;
import session_bean.ProductSessionBeanLocal;
import session_bean.ProductlineSessionBeanLocal;
import utility.html_generator;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet(name="Product Servlet", urlPatterns = {"/manageProduct", "/product", "/Product"})
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	private ProductSessionBeanLocal productBean;
	
	@EJB
	private ProductlineSessionBeanLocal productlineBean;
	
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
		List<Product> productList = productBean.getAllProduct();
		List<Productline> productlineList = productlineBean.getAllProductline();
		
		int recordsPerPage = 10, nOfPage = productList.size() / recordsPerPage;
		nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > productList.size()) ? productList.size() : currentPage * recordsPerPage;
		
		productList = productList.subList(start_num, end_num);
		
		String lastCode = productBean.getLastId().get(0).getProductcode();
		String lastId = (lastCode.equals("S72_3212")) ? "S904_0001" : getProductCode(lastCode);
		
		request.setAttribute("servlet_name", "manageProduct");
		request.setAttribute("lastId", lastId);
		request.setAttribute("ProductList", productList);
		request.setAttribute("ProductlineList", productlineList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		RequestDispatcher req = request.getRequestDispatcher("backend/manageProduct.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type = request.getParameter("type");
		String[] parameter = Product.getParameter();
		String[] arr = new String[parameter.length];
		
		for(int i = 0; i < arr.length; i++) arr[i] = request.getParameter(parameter[i]);
		
		Product p;
		PrintWriter out = response.getWriter();
		
		switch(type) {
		case "ADD":
			p = new Product();
			p.setEverything(arr);
			productBean.addProduct(p);
			out.println(html_generator.operation_complete("added", "manageProduct"));
			break;
		case "UPDATE":
			p = productBean.getProduct(arr[3]);
			p.setEverything(arr);
			productBean.updateProduct(p);
			out.println(html_generator.operation_complete("updated", "manageProduct"));
			break;
		case "DELETE":
			p = productBean.getProduct(arr[3]);
			productBean.deleteProduct(p);
			out.println(html_generator.operation_complete("deleted", "manageProduct"));
			break;
		}
	}
	
	public String getProductCode(String test) {
		String[] s = test.split("_");
		int x = Integer.valueOf(s[1]) + 1;
		int len = (int) (4 - 1 - Math.floor(Math.log10(x)));
		return s[0] + "_" + String.join("", Collections.nCopies(len, "0")) + x;
	}

}
