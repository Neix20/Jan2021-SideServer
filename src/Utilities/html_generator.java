package Utilities;

public class html_generator {
	public static String table_column(String text) {
		return "<td>" + text + "</td>";
	}

	public static String p_tag(String text) {
		return "<p>" + text + "</p>";
	}

	public static String operation_complete(String operation, String servletURL) {
		return "<script>" + "alert('Record has been " + operation + " and url will be redirected');"
				+ "window.location.assign('\\"+servletURL+"');" + "</script>";
	}
	
	public static String productItem_html(String name, String image, String price) {
		return "<div class=\"col-lg-4\"><div class=\"trainer-item\"><div class=\"image-thumb\">"
				+ "<img src=\"frontend/assets/images/" + image
				+ "\" alt=\"\"></div><div class=\"down-content\"><span><sup>RM</sup>" + price
				+ "</span><h3>" + name
				+ "</h3><ul class=\"social-icons\"><li><a href=\"car-details.html\">+ View Model</a></li></ul></div></div></div>";
	}
}
