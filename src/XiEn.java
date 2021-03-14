import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class XiEn {
	
	public static void main(String[] args) {
		String[] category = {"get", "Mum"};
//		String sort = "name_asc";
//		String text = "SELECT p FROM Product p " 
//				+ Sql_Statement_Generator.productline_category(category)
//				+ Sql_Statement_Generator.order_clause(sort);
//		System.out.println(text);
//		System.out.println(html_generator.getParameterArrayValues("category", category));
//		String test = "S904_0001";
//		String[] s = test.split("_");
//		int x = Integer.valueOf(s[1]) + 1;
//		int len = (int) (4 - 1 - Math.floor(Math.log10(x)));
//		String res = s[0] + "_" + String.join("", Collections.nCopies(len, "0")) + x;
//		System.out.println(res);
//		List<Integer> test = new ArrayList<Integer>();
//		for(int s : test) {System.out.println(s);}
//		System.out.println(test.isEmpty());
		BigDecimal test = new BigDecimal("72.45");
		String date[] = {"2004-04-02", "2004-04-13", "2004-04-20"};
		for(String s : date) {
			System.out.println(s);
			try {
				SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
//				SimpleDateFormat formatDay = new SimpleDateFormat("dd");
//				int day = Integer.valueOf(formatDay.format(temp));
//				System.out.println((day - 1)/7 + 1);
				Date temp = formatDate.parse(s);
				SimpleDateFormat formatMonth = new SimpleDateFormat("MMM");
				SimpleDateFormat formatYear = new SimpleDateFormat("yyyy");
				System.out.println(formatMonth.format(temp));
				System.out.println(formatYear.format(temp));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
