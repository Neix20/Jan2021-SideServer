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

/**
 * Servlet implementation class PaymentPaginationServlet
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
	
		int nOfPages = 0;
		int currentPage = 1;
		int recordsPerPage = 30;
		String keyword = ""; 
		String sortItem = "";
				
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.valueOf(request.getParameter("currentPage"));
		}
		
		if (request.getParameter("recordsPerPage") != null) {
			recordsPerPage = Integer.valueOf(request.getParameter("recordsPerPage"));
		}
		
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		
		if (request.getParameter("sort") != null) {
			sortItem = request.getParameter("sort");
		}
	
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
			String action = request.getParameter("user_action");
			lists = paymentBean.readPayment(currentPage, recordsPerPage, keyword);
		    
		    request.setAttribute("payments", lists);
		} catch (EJBException ex) {
			throw ex;
		}

		request.setAttribute("nOfPages", nOfPages);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("recordsPerPage", recordsPerPage);
		request.setAttribute("keyword", keyword);
	
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
