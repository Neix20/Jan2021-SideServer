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

import domain.Customer;
import domain.CustomerJson;
import session_bean.CustomerLocal;
import utility.PaginationRequestProcessor;
import utility.UrlGenerator;
import utility.Redirect;

/**
 * Servlet implementation class CustomerServlet
 * 
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
 */
@WebServlet({"/manageCustomer", "/managecustomer"})
public class CustomerManagementServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @EJB
    private CustomerLocal customerBean;

    public CustomerManagementServlet() {
    	super();
    }

	/**
	 * Find the customer's record that matches with the customernumber
	 * from the client's request.
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
		String id = request.getParameter("customernumber");
	    Customer customer = customerBean.findCustomerById(id);
	    request.setAttribute("customer", customer);
	
		boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		
		if (ajax) {
			CustomerJson customJson = new CustomerJson(customer);
			String json = new Gson().toJson(customJson);
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        response.getWriter().write(json);
		} else {
			//TODO 404 Not found
		}
    }

	/**
	 * To perform add, update, delete operation on customer's record.
	 */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {

    	String customernumber = request.getParameter("customernumber");
        String customername = request.getParameter("customername");
        String contactfirstname = request.getParameter("contactfirstname");
        String contactlastname = request.getParameter("contactlastname");
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
		absoluteLink += "/Customer";
		UrlGenerator urlGenerator = new UrlGenerator(absoluteLink, nOfPages, currentPage, 
													 recordsPerPage, keyword, sortItem, sortType);
		request.setAttribute("urlGenerator", urlGenerator);

	    Redirect.navigateJS(out, urlGenerator.toString(), action);
    }

}
