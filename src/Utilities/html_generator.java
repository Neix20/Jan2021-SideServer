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
}
