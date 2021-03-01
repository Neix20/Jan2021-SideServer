package utility;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

public class ValidateManageLogic {
    public static String validateManager(HttpServletRequest request) {
	if (request.getParameter("UPDATE") != null && request.getParameter("UPDATE").equals("UPDATE")) {
	    return "UPDATE";
	} else if (request.getParameter("DELETE") != null && request.getParameter("DELETE").equals("DELETE")) {
	    return "DELETE";
	}
	return "ADD";
    }

//this method is used to notify a user that a record has been updated and to
//redirect to another page
    public static void navigateJS(PrintWriter out) {
	out.println("<SCRIPT type=\"text/javascript\">");
	out.println("alert(\"Record has been updated and url will be redirected\")");
	out.println("window.location.assign(\"CustomerPagination?currentPage=1&recordsPerPage=30&keyword=\")");
	out.println("</SCRIPT>");
    }
}