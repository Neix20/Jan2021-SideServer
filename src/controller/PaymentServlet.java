package controller;

import java.io.IOException;
import java.io.PrintWriter;

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
import utility.ValidateManageLogic;

/**
 * Servlet implementation class PaymentServlet
 */
@WebServlet({"backend/Payment", "backend/payment"})
public class PaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    @EJB
    private PaymentSessionBeanLocal paymentBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaymentServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String customernumber = request.getParameter("customernumber");
		String checknumber = request.getParameter("checknumber");
		
		
		try {
		    Payment payment = paymentBean.findPayment(customernumber, checknumber);
		    request.setAttribute("payment", payment);
	
		    RequestDispatcher req = request.getRequestDispatcher("update_payment.jsp");
		    req.forward(request, response);
		} catch (EJBException ex) {
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
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
	
		    //TODO: Redirect to a page, Have a pop up?
		    ValidateManageLogic.navigateJS(out, "PaymentPagination");
	
		} catch (EJBException ex) {
			throw ex;
		}
	}

}
