package utility;

public class Sql_Statement_Generator {
	public static String in_clause(String text) {
		return "IN ('" + text + "')";
	}

	public static String in_clause(String[] text) {
		String statement = "";
		for (String s : text) {
			statement += "'" + s + "'" + ", ";
		}
		statement = statement.substring(0, statement.length() - 2);
		return "IN (" + statement + ")";
	}
	
	public static String productline_category(String[] text) {
		return text[0].equals("all") ? "" : "WHERE p.productline " + in_clause(text) + " ";
	}

	public static String order_clause(String text) {
		String[] tmp = text.split("_");
		String txt = tmp[0].equals("name") ? "p.productname " : "p.msrp ";
		return "ORDER BY " + txt + tmp[1];
	}
}
