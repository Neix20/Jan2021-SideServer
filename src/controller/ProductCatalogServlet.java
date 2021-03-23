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

import domain.Product;
import domain.Productline;
import session_bean.ProductSessionBeanLocal;
import session_bean.ProductlineSessionBeanLocal;

/**
 * Servlet implementation class ProductCatalogServlet
 */
@WebServlet(name = "Product Catalog Servlet", urlPatterns = { "/ProductCatalog", "/productCatalog" })
public class ProductCatalogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ProductSessionBeanLocal productBean;

	@EJB
	private ProductlineSessionBeanLocal productlineBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductCatalogServlet() {
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
		List<Productline> productlineList = productlineBean.getAllProductline();
		String[] category = request.getParameterValues("category");
		String sort = request.getParameter("sort_keyword");
		String[] tmp = { "all" };

		category = (category == null) ? tmp : category;
		sort = (sort == null) ? "name_ASC" : sort;

		List<Product> productList = productBean.getProductList(category, sort);

		int recordsPerPage = 6, nOfPage = productList.size() / recordsPerPage;
		if (productList.size() % recordsPerPage != 0)
			nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > productList.size()) ? productList.size()
				: currentPage * recordsPerPage;

		productList = productList.subList(start_num, end_num);

		request.setAttribute("currentPage", currentPage);
		request.setAttribute("category", category);
		request.setAttribute("sort_keyword", sort);
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("List", productList);
		request.setAttribute("ProductlineList", productlineList);
		request.setAttribute("servlet_name", "ProductCatalog");

		RequestDispatcher req = request.getRequestDispatcher("frontend/productCatalog.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
