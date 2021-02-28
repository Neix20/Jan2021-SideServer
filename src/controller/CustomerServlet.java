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
	
		    RequestDispatcher req = request.getRequestDispatcher("EmployeeUpdate.jsp");
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
		String addressline1 = request.getParameter("addressline1");
		String addressline2 = request.getParameter("addressline2");
		String city = request.getParameter("city");
		String contactfirstname = request.getParameter("contactfirstname");
		String contactlastname = request.getParameter("contactlastname");
		String country = request.getParameter("country");
		String creditlimit = request.getParameter("creditlimit");
		String customername = request.getParameter("customername");
		String phone = request.getParameter("phone");
		String postalcode = request.getParameter("postalcode");
		String state = request.getParameter("state");
		String salesrepemployeenumber = request.getParameter("salesrepemployeenumber");
		String payments_no = request.getParameter("payments");
	
		PrintWriter out = response.getWriter();
	
		String[] s = {
			customernumber,
			addressline1,
			addressline2,
			city,
			contactfirstname,
			contactlastname,
			country,
			creditlimit,
			customername,
			phone,
			postalcode,
			state,
			salesrepemployeenumber,
			payments_no,
		};
	
		try {
		    if (ValidateManageLogic.validateManager(request).equals("UPDATE")) {
		    	customerBean.updateCustomer(s);
		    } else if (ValidateManageLogic.validateManager(request).equals("DELETE")) {
		    	customerBean.deleteCustomer(customernumber);
		    } else {
		    	customerBean.addCustomer(s);
		    }
	
		    ValidateManageLogic.navigateJS(out);
	
		} catch (EJBException ex) {
			throw ex;
		}
    }

}
