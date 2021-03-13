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

import domain.Payment;
import session_bean.PaymentSessionBeanLocal;
import utility.PaginationRequestProcessor;
import utility.UrlGenerator;

/**
 * Servlet implementation class PaymentPaginationServlet
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet({"backend/PaymentPagination", "backend/paymentpagination"})
public class PaymentPaginationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    @EJB
    private PaymentSessionBeanLocal paymentBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentPaginationServlet() {
        super();
    }

	/**
	 * Perform pagination on payment dashboard.
	 * 
	 * Reference: UCCD3243 Practical Slide 
	 */
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
		    int rows = paymentBean.getNumberOfRows(keyword);
		    nOfPages = rows / recordsPerPage;
		    System.out.println("At servlet" + nOfPages);

		    if (rows % recordsPerPage != 0) {
		    	nOfPages++;
		    }

		    if (currentPage > nOfPages && nOfPages != 0) {
		    	currentPage = nOfPages;
		    }
		    
		    List<Payment> lists;
			lists = paymentBean.readPayment(currentPage, recordsPerPage, keyword, sortItem, sortType);
		    
		    request.setAttribute("payments", lists);
		} catch (EJBException ex) {
			throw ex;
		}
		
		/* Set the URL to the latest value of request's parameters 
		 * so that the user's preference can be saved between requests.
		 */
		String absoluteLink = request.getContextPath();		
		UrlGenerator urlGenerator = new UrlGenerator(absoluteLink, nOfPages, currentPage, 
													 recordsPerPage, keyword, sortItem, sortType);
		request.setAttribute("urlGenerator", urlGenerator);
	
		RequestDispatcher dispatcher = request.getRequestDispatcher("manage_payment.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
