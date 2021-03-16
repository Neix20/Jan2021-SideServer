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
import session_bean.CustomerLocal;
import utility.PaginationRequestProcessor;
import utility.UrlGenerator;

/**
 * Servlet implementation class CustomerPaginationServlet
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet(urlPatterns = {"/Customer", "/customer"})
public class CustomerPaginationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private CustomerLocal customerBean;

    public CustomerPaginationServlet() {
	super();
    }
	
	/**
	 * Perform pagination on customer dashboard.
	 * 
	 * Reference: UCCD3243 Practical Slide 
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		
		// Use custom class to process the request's parameter to reduce redundancy
		PaginationRequestProcessor requestProcessor = new PaginationRequestProcessor();
		requestProcessor.process(request);
		int nOfPages = requestProcessor.getnOfPages();
		int currentPage = requestProcessor.getCurrentPage();
		int recordsPerPage = requestProcessor.getRecordsPerPage();
		String keyword = requestProcessor.getKeyword();
		String sortItem = requestProcessor.getSortItem();
		String sortType = requestProcessor.getSortType();
	
		try {
	
		    int rows = customerBean.getNumberOfRows(keyword);
		    nOfPages = rows / recordsPerPage;
	
		    if (rows % recordsPerPage != 0) {
		    	nOfPages++;
		    }
	
		    if (currentPage > nOfPages && nOfPages != 0) {
		    	currentPage = nOfPages;
		    }
	
		    List<Customer> lists = customerBean.readCustomer(currentPage, recordsPerPage, keyword, sortItem, sortType);
		    request.setAttribute("customers", lists);
		} catch (EJBException ex) {
			throw ex;
		}
		
		/* Set the URL to the latest value of request's parameters 
		 * so that the user's preference can be saved between requests.
		 */
		String absoluteLink = request.getContextPath();
		absoluteLink += "/Customer";
		UrlGenerator urlGenerator = new UrlGenerator(absoluteLink, nOfPages, currentPage, 
													 recordsPerPage, keyword, sortItem, sortType);
		request.setAttribute("urlGenerator", urlGenerator);
	
		RequestDispatcher dispatcher = request.getRequestDispatcher("backend/manageCustomer.jsp");
		dispatcher.forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
    }
}
