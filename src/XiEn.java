import utility.html_generator;

public class XiEn {
	
	public static void main(String[] args) {
		String[] category = {"get", "Mum"};
//		String sort = "name_asc";
//		String text = "SELECT p FROM Product p " 
//				+ Sql_Statement_Generator.productline_category(category)
//				+ Sql_Statement_Generator.order_clause(sort);
//		System.out.println(text);
		System.out.println(html_generator.getParameterArrayValues("category", category));
	}
}
