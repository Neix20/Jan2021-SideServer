package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
import domain.Employee;
import domain.Payment;
import session_bean.CustomerSessionBeanLocal;
import utility.ValidateManageLogic;

/**
 * Servlet implementation class CustomerController
 */
@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private CustomerSessionBeanLocal customerBean;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CustomerServlet() {
    	super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
		String id = request.getParameter("id");
	
		try {
		    Customer customer = customerBean.findCustomer(id);
		    request.setAttribute("customer", customer);
	
		    RequestDispatcher req = request.getRequestDispatcher("update_customer.jsp");
		    req.forward(request, response);
		} catch (EJBException ex) {
		}
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {

    	String customernumber = request.getParameter("customernumber");
        String customername = request.getParameter("customername");
        String contactfirstname = request.getParameter("contact_firstname");
        String contactlastname = request.getParameter("contact_lastname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String addressline1 = request.getParameter("addressline1");
        String addressline2 = request.getParameter("addressline2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalcode = request.getParameter("postalcode");
        String country = request.getParameter("country");
        String salesrepemployeenumber = request.getParameter("salesrepemployeenumber");
        String creditlimit = request.getParameter("creditlimit");
	
		PrintWriter out = response.getWriter();
	
		String[] s = {
		    customername,
		    contactfirstname,	
		    contactlastname,
		    phone,
		    email,
		    addressline1,
		    addressline2,
		    city,
		    state,
		    postalcode,
		    country,
		    salesrepemployeenumber,
		    creditlimit,
		};
	
		String action = request.getParameter("user_action");
		
		try {
		    if (action.equals("UPDATE")) {
		    	customerBean.updateCustomer(s, customernumber);
		    } else if (action.equals("DELETE")) {
		    	customerBean.deleteCustomer(customernumber);
		    } else {
		    	customerBean.addCustomer(s);
		    }
	
		    //TODO: Redirect to a page, Have a pop up?
		    ValidateManageLogic.navigateJS(out);
	
		} catch (EJBException ex) {
			throw ex;
		}
    }

}
