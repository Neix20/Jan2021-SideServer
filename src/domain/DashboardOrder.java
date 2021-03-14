package domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DashboardOrder extends Order{
	
	private int weekRange;

	public DashboardOrder(Order o) throws ParseException {
		super(o);
		this.initWeekRange();
	}

	public int getWeekRange() {
		return weekRange;
	}

	public void initWeekRange() throws ParseException {
		SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat formatDay = new SimpleDateFormat("dd");
		Date date = formatDate.parse(this.getOrderdate());
		int day = Integer.valueOf(formatDay.format(date));
		this.weekRange = (day - 1)/7 + 1;
	}

	public void setWeekRange(int weekRange) {
		this.weekRange = weekRange;
	}
	
}
