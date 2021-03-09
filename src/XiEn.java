import java.util.Collections;

public class XiEn {
	
	public static void main(String[] args) {
		String[] category = {"get", "Mum"};
//		String sort = "name_asc";
//		String text = "SELECT p FROM Product p " 
//				+ Sql_Statement_Generator.productline_category(category)
//				+ Sql_Statement_Generator.order_clause(sort);
//		System.out.println(text);
//		System.out.println(html_generator.getParameterArrayValues("category", category));
		String test = "S904_0001";
		String[] s = test.split("_");
		int x = Integer.valueOf(s[1]) + 1;
		int len = (int) (4 - 1 - Math.floor(Math.log10(x)));
		String res = s[0] + "_" + String.join("", Collections.nCopies(len, "0")) + x;
		System.out.println(res);
	}
}
