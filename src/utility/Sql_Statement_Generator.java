package utility;

public class Sql_Statement_Generator {
	public static String in_clause(String text) {
		return "IN ('" + text + "')";
	}
	
	public static String productline_category(String text) {
		return text.equals("all") ? "" : "WHERE p.productline = '" + text + "'";
	}

	public static String order_clause(String text) {
		String[] tmp = text.split("_");
		String txt =  tmp[0].equals("name") ? "p.productname " : "p.msrp ";
		return "ORDER BY " + txt + tmp[1];
	}
}
