package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Productline;
import session_bean.ProductlineSessionBeanLocal;
import utility.html_generator;
/**
 * Servlet implementation class ProductlineServlet
 */
@WebServlet("/ProductlineServlet")
public class ProductlineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	private ProductlineSessionBeanLocal productlineBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductlineServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Productline> list = productlineBean.getAllProductline();
		String keyword = request.getParameter("keyword");
		List<Productline> SearchResult = (keyword != null) ? productlineBean.getSearchResult(keyword) : new ArrayList<Productline>();
		request.setAttribute("List", list);
		request.setAttribute("SearchResult", SearchResult);
		RequestDispatcher req = request.getRequestDispatcher("productLine.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type = request.getParameter("type");
		String[] parameter = Productline.getParameter();
		String[] arr = new String[parameter.length];
		
		for(int i = 0; i < arr.length; i++) arr[i] = request.getParameter(parameter[i]);
		
		Productline pl;
		PrintWriter out = response.getWriter();
		
		switch(type) {
		case "ADD":
			pl = new Productline();
			pl.setEverything(arr);
			productlineBean.addProductline(pl);
			out.println(html_generator.operation_complete("added", "ProductlineServlet"));
			break;
		case "UPDATE":
			pl = productlineBean.getProductline(arr[0]);
			pl.setEverything(arr);
			productlineBean.updateProductline(pl);
			out.println(html_generator.operation_complete("updated", "ProductlineServlet"));
			break;
		case "DELETE":
			pl = productlineBean.getProductline(arr[0]);
			productlineBean.deleteProductline(pl);
			out.println(html_generator.operation_complete("deleted", "ProductlineServlet"));
			break;
		}
		
		
	}

}
