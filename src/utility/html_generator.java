package utility;

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
	
	public static String add_Product_Shopping() {
		return "function notifyMe() {\r\n" + 
				"        if (!('Notification' in window)) {\r\n" + 
				"            alert('This browser does not support desktop notification');\r\n" + 
				"        }\r\n" + 
				"        else if (Notification.permission === 'granted') {\r\n" + 
				"            let notification = new Notification('Product has been successfully added to shopping cart!');\r\n" + 
				"        }\r\n" + 
				"        else if (Notification.permission !== 'denied') {\r\n" + 
				"            Notification.requestPermission().then(function (permission) {\r\n" + 
				"                if (permission === 'granted') {\r\n" + 
				"                    let notification = new Notification('Product has been successfully added to shopping cart!');\r\n" + 
				"                }\r\n" + 
				"            });\r\n" + 
				"        }\r\n" + 
				"    }\r\n" + 
				"    notifyMe();";
	}
	
	public static String productItem_html(String name, String type, int number, String price, String code) {
		return "<div class=\"col-lg-4\"><div class=\"trainer-item\"><div class=\"image-thumb\">"
				+ "<img src=\"frontend/assets/images/" + type + "_" + number + ".jpg"
				+ "\" alt=\"\"></div><div class=\"down-content\"><span><sup>RM</sup>" + price
				+ "</span><h3>" + name
				+ "</h3><ul class=\"social-icons\"><li><a href=\"productDetails?"
				+ "productCode=" + code + "&image_url=" + type + "_" + number + ".jpg"
				+"\">+ View Model</a></li></ul></div></div></div>";
	}
}
