package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import domain.Payment;
import domain.PaymentJson;
import session_bean.PaymentSessionBeanLocal;
import utility.PaginationRequestProcessor;
import utility.UrlGenerator;
import utility.Redirect;

/**
 * Servlet implementation class PaymentServlet
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@WebServlet({"/managePayment", "/managepayment"})
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    @EJB
    private PaymentSessionBeanLocal paymentBean;
	
    public PaymentServlet() {
        super();
    }

	/**
	 * Find the payment's record that matches with the customernumber and checknumber
	 * from the client's request.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String customernumber = request.getParameter("customernumber");
		String checknumber = request.getParameter("checknumber");
	    Payment payment = paymentBean.findPayment(customernumber, checknumber);
	    request.setAttribute("payment", payment);
	    
	    boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

		if (ajax) {
			PaymentJson paymentJson = new PaymentJson(payment);
			String json = new Gson().toJson(paymentJson);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
		} else {
			//TODO 404 Not found
		}
	}

	/**
	 * To perform add, update, delete operation on payment's record.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String customernumber = request.getParameter("customernumber");
		String checknumber = request.getParameter("checknumber");
		String amount = request.getParameter("amount");
		String paymentdate = request.getParameter("paymentdate");
		String paymentmethod = request.getParameter("paymentmethod");
			
		PrintWriter out = response.getWriter();
	
		String[] s = {
			customernumber,
			checknumber,
			amount,	
			paymentdate,
			paymentmethod,
		};
	
		String action = request.getParameter("user_action");
		
		try {
		    if (action.equals("UPDATE")) {
		    	paymentBean.updatePayment(s, customernumber, checknumber);
		    } else if (action.equals("DELETE")) {
		    	paymentBean.deletePayment(customernumber, checknumber);
		    } else {
		    	paymentBean.addPayment(s);
		    }	
		} catch (EJBException ex) {
			throw ex;
		}
		
		// Use custom class to process the request's parameter to reduce redundancy
		PaginationRequestProcessor requestProcessor = new PaginationRequestProcessor();
		requestProcessor.process(request);
		int nOfPages = requestProcessor.getnOfPages();
		int currentPage = requestProcessor.getCurrentPage();
		int recordsPerPage = requestProcessor.getRecordsPerPage();
		String keyword = requestProcessor.getKeyword();
		String sortItem = requestProcessor.getSortItem();
		String sortType = requestProcessor.getSortType();
		
		String absoluteLink = request.getContextPath();
		absoluteLink += "/Payment";
		UrlGenerator urlGenerator = new UrlGenerator(absoluteLink, nOfPages, currentPage, 
													 recordsPerPage, keyword, sortItem, sortType);
		request.setAttribute("urlGenerator", urlGenerator);

	    Redirect.navigateJS(out, urlGenerator.toString(), action);
	}

}
