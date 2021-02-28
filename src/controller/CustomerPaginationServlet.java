package controller;

import java.io.IOException;
import java.util.List;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import domain.Customer;
import session_bean.CustomerSessionBeanLocal;

@WebServlet("/CustomerPagination")
public class CustomerPaginationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private CustomerSessionBeanLocal customerBean;

    public CustomerPaginationServlet() {
	super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
	
		int nOfPages = 0;
		int currentPage = 1;
		int recordsPerPage = 30;
		String keyword = ""; 
				
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.valueOf(request.getParameter("currentPage"));
		}
		
		if (request.getParameter("recordsPerPage") != null) {
			recordsPerPage = Integer.valueOf(request.getParameter("recordsPerPage"));
		}
		
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
	
		try {
	
		    int rows = customerBean.getNumberOfRows(keyword);
		    nOfPages = rows / recordsPerPage;
		    System.out.println("At servlet" + nOfPages);
	
		    if (rows % recordsPerPage != 0) {
		    	nOfPages++;
		    }
	
		    if (currentPage > nOfPages && nOfPages != 0) {
		    	currentPage = nOfPages;
		    }
	
		    List<Customer> lists = customerBean.readCustomer(currentPage, recordsPerPage, keyword);
		    request.setAttribute("customers", lists);
	
		} catch (EJBException ex) {
			throw ex;
		}
		
		request.setAttribute("nOfPages", nOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("recordsPerPage", recordsPerPage);
		request.setAttribute("keyword", keyword);
	
		RequestDispatcher dispatcher = request.getRequestDispatcher("manage_customer.jsp");
		dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
    	doGet(request, response);
    }
}
