package utility;

import java.io.PrintWriter;

/**
* Notify the user that the record has been added, deleted or updated 
* before redirect back to the dashboard.
* 
* Reference: UCCD3243 Practical code
* 
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
*/
public class Redirect {

	/* this method is used to notify a user that a record has been updated and to
	 * redirect to another page.
	 */
    public static void navigateJS(PrintWriter out, String redirectPath, String action) {
    	String message = "";
    	
    	switch (action) {
    	case "UPDATE":
    		message = "updated";
    		break;
    	case "DELETE":
    		message = "deleted";
    		break;
    	default:
    		message = "added";
    		break;
    	}
		out.println("<SCRIPT type=\"text/javascript\">");
		out.println("alert(\"Record has been "+message+" and url will be redirected\")");
		out.println("window.location.assign(\""+redirectPath+"?currentPage=1&recordsPerPage=30&keyword=\")");
		out.println("</SCRIPT>");
    }
}