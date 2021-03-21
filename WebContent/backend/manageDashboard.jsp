<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="domain.DashboardOrder"%>
<%@ page import="domain.ShoppingCartItem"%>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%
	List<String> date_options = (List<String>) request.getAttribute("date_options");
	List<DashboardOrder> orderMonthList = (List<DashboardOrder>) request.getAttribute("orderMonthList");
	String servlet_name = (String) request.getAttribute("servlet_name");
	double[] default_info = (double[]) request.getAttribute("default_info");
	List<ShoppingCartItem> inventoryList = (List<ShoppingCartItem>) request.getAttribute("inventoryList");
	HashMap<String, Integer> productlineHashMap = (HashMap<String, Integer>) request.getAttribute("productlineHashMap");
	List<Integer> totalOrderWeekList = (List<Integer>) request.getAttribute("totalOrderWeekList");
	List<Integer> totalProductWeekList = (List<Integer>) request.getAttribute("totalProductWeekList");
	List<BigDecimal> totalBuyPriceWeekList = (List<BigDecimal>) request.getAttribute("totalBuyPriceWeekList");
	List<BigDecimal> totalMsrpWeekList = (List<BigDecimal>) request.getAttribute("totalMsrpWeekList");
	List<BigDecimal> totalSalesWeekList = (List<BigDecimal>) request.getAttribute("totalSalesWeekList");
	String str;
	int num = 0;
%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Tell the browser to be responsive to screen width -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="keywords"
	content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 4 admin, bootstrap 4, css3 dashboard, bootstrap 4 dashboard, Ample lite admin bootstrap 4 dashboard, frontend, responsive bootstrap 4 admin template, Ample admin lite dashboard bootstrap 4 dashboard template">
<meta name="description"
	content="Ample Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
<meta name="robots" content="noindex,nofollow">
<link rel="canonical"
	href="https://www.wrappixel.com/templates/ample-admin-lite/" />
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="${ pageContext.request.contextPath }/backend/assets/plugins/images/favicon.png">
<!-- Custom CSS -->
<link href="${ pageContext.request.contextPath }/backend/assets/css/style.min.css" rel="stylesheet">
<title>Dashboard</title>
<script src="${ pageContext.request.contextPath }/backend/assets/js/jquery-3.5.1.min.js"></script>
<script src="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script src="${ pageContext.request.contextPath }/backend/assets/js/jquery.canvasjs.min.js"></script>
<script src="${ pageContext.request.contextPath }/backend/assets/js/selectize.js"></script>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/backend/assets/css/selectize/selectize.css" />
<script>
$(document).ready(function () {
    $(".search_select").selectize();

    let inventory_pie_chart = new CanvasJS.Chart("inventory_pie_chart", {
        theme: "light2", // "light1", "light2", "dark1", "dark2"
        exportEnabled: true,
        animationEnabled: true,
        title: {
            text: "Product Inventory Chart"
        },
        data: [{
            type: "pie",
            startAngle: 25,
            toolTipContent: "<b>{label}</b>: {y}",
            showInLegend: "true",
            legendText: "{label}",
            indexLabelFontSize: 16,
            indexLabel: "{label} - {y}",
            dataPoints: [
                <%
                	str = "";
                	for (ShoppingCartItem sc : inventoryList) {
						String tmpArr[] = sc.getProductname().split(" ");
						str += "{ y: " + sc.getQuantity() + ", label: \"" + tmpArr[0] + " " + tmpArr[1] + "\" }, ";
                	}
                	str = str.substring(0, str.length()- 2);
				%>
				<%=str%>
            ]
        }]
    });

    let productline_bar_chart = new CanvasJS.Chart("productline_bar_chart", {
        animationEnabled: true,
        exportEnabled: true,
        title: {
            text: "Productline Chart"
        },
        axisY: {
            title: "Number of Sales Order",
            titleFontColor: "#4F81BC",
            lineColor: "#4F81BC",
            labelFontColor: "#4F81BC",
            tickColor: "#4F81BC"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "column",
            name: "Productline",
            dataPoints: [
            <%
            	str = "";
            	for(String key : productlineHashMap.keySet()) str += "{ y: " + productlineHashMap.get(key) + ", label: \"" + key + "\" }, ";
            	str = str.substring(0, str.length()-2);
			%>
			<%=str%>
            ]
        }]
    });

    let order_product_bar_chart = new CanvasJS.Chart("order_product_bar_chart", {
        animationEnabled: true,
        exportEnabled: true,
        title: {
            text: "Monthly Sales of Order and Products"
        },
        axisY: {
            title: "Number of Orders",
            titleFontColor: "#4F81BC",
            lineColor: "#4F81BC",
            labelFontColor: "#4F81BC",
            tickColor: "#4F81BC"
        },
        axisY2: {
            title: "Number of Products",
            titleFontColor: "#C0504E",
            lineColor: "#C0504E",
            labelFontColor: "#C0504E",
            tickColor: "#C0504E"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "column",
            name: "Orders",
            legendText: "Number of Orders",
            showInLegend: true,
            dataPoints: [
                <% 
                	num = 1;
                	for(int i : totalOrderWeekList) { 
                %>
                	{ label: "Week <%=num%>", y: <%=i%> },
                <%
                	num++;
                	} 
                %>
            ]
        },
        {
            type: "column",
            name: "Products",
            legendText: "Number of Products",
            axisYType: "secondary",
            showInLegend: true,
            dataPoints: [
            	<% 
            		num = 1;
            		for(int i : totalProductWeekList) { 
            	%>
            		{ label: "Week <%=num%>", y: <%=i%> },
            	<%
            			num++;
            		} 
                %>
            ]
        }]
    });

    let buyPrice_msrp_line_chart = new CanvasJS.Chart("buyPrice_msrp_line_chart", {
        title: {
            text: "Weekly Buy Price and MSRP Analysis"
        },
        exportEnabled: true,
        animationEnabled: true,
        axisY: {
            title: "Prices",
            lineColor: "#C24642",
            tickColor: "#C24642",
            labelFontColor: "#C24642",
            titleFontColor: "#C24642"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "line",
            name: "Buy Price",
            color: "#369EAD",
            showInLegend: true,
            axisYIndex: 1,
            dataPoints: [
            	<% 
            	num = 1;
            	for(BigDecimal bd: totalBuyPriceWeekList) { 
            %>
            	{ label: "Week <%=num%>", y: <%=bd.setScale(2, RoundingMode.HALF_UP)%> },
            <%
            	num++;
            	} 
            %>
            ]
        },
        {
            type: "line",
            name: "MSRP",
            color: "#C24642",
            axisYIndex: 0,
            showInLegend: true,
            dataPoints: [
            	<% 
            	num = 1;
            	for(BigDecimal bd: totalMsrpWeekList) { 
            %>
            	{ label: "Week <%=num%>", y: <%=bd.setScale(2, RoundingMode.HALF_UP)%> },
            <%
            	num++;
            	} 
            %>
            ]
        }]
    });

    let sales_revenue_line_chart = new CanvasJS.Chart("sales_revenue_line_chart", {
        title: {
            text: "Weekly Sales Revenue Analysis"
        },
        exportEnabled: true,
        animationEnabled: true,
        axisY: {
            title: "Prices",
            lineColor: "#006400",
            tickColor: "#006400",
            labelFontColor: "#006400",
            titleFontColor: "#006400"
        },
        toolTip: {
            shared: true
        },
        legend: {
            cursor: "pointer",
            itemclick: toggleDataSeries
        },
        data: [{
            type: "line",
            name: "Sales",
            color: "#006400",
            axisYIndex: 0,
            showInLegend: true,
            dataPoints: [
            	<% 
            	num = 1;
            	for(BigDecimal bd: totalSalesWeekList) { 
            %>
            	{ label: "Week <%=num%>", y: <%=bd.setScale(2, RoundingMode.HALF_UP)%> },
            <%
            	num++;
            	} 
            %>
            ]
        }]
    });

    inventory_pie_chart.render();
    productline_bar_chart.render();
    order_product_bar_chart.render();
    buyPrice_msrp_line_chart.render();
    sales_revenue_line_chart.render();
});

function toggleDataSeries(e) {
    if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
        e.dataSeries.visible = false;
    } else {
        e.dataSeries.visible = true;
    }
    e.chart.render();
}
</script>
</head>

<body>

	<div class="preloader">
		<div class="lds-ripple">
			<div class="lds-pos"></div>
			<div class="lds-pos"></div>
		</div>
	</div>

	<div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5"
		data-sidebartype="full" data-sidebar-position="absolute"
		data-header-position="absolute" data-boxed-layout="full">

		<%@ include file="template_top.jsp"%>

		<div class="page-wrapper">
			<div class="page-breadcrumb bg-white">
				<div class="row align-items-center">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h4 class="page-title text-uppercase font-medium font-14">Dashboard</h4>
					</div>
				</div>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-12">
						<div class="white-box">
							<form id="date_select" class="px-3" action="<%=servlet_name%>" method="get">
								<div class="row">
									<div class="col-2">
										<select class="search_select" form="date_select"
											name="date_select" onchange="this.form.submit()">
											<option value="">Search for period...</option>
											<%
												for (String s : date_options) {
											%>
											<option value="<%=s%>"><%=s%></option>
											<%
												}
											%>
										</select>
									</div>
									<div class="col-10"></div>
								</div>
							</form>
							<div class="p-3">
								<table class="table table-bordered text-center mt-2">
									<tr>
										<td><b>Number of Orders Haven't Shipped: </b><%=(int) default_info[0]%></td>
										<td><b>Total Number of Orders: </b><%=(int) default_info[1]%></td>
										<td><b>Number of Orders Already Shipped: </b><%=(int) default_info[2]%></td>
										<td><b>Total Sales Revenue: </b>RM <%=default_info[3]%></td>
									</tr>
								</table>
								<div class="row">
									<div class="col-6 p-3">
										<table class="table text-center">
											<thead>
												<tr class="table-danger">
													<th>Name</th>
													<th>Type</th>
													<th>Inventory</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody class="border border-dark">
												<%
													for (ShoppingCartItem sc : inventoryList) {
												%>
												<tr>
													<td><%=sc.getProductname()%></td>
													<td><%=sc.getProductline()%></td>
													<td><%=sc.getQuantityinstock()%></td>
													<td><%=sc.getMsrp()%></td>
												</tr>
												<%
													}
												%>
											</tbody>
										</table>
									</div>
									<div class="col-6 p-3">
										<div id="inventory_pie_chart" style="height: 370px;"></div>
									</div>
								</div>

								<div class="row mt-3">
									<div class="col p-3">
										<div id="productline_bar_chart" style="height: 370px;"></div>
									</div>
								</div>

								<div class="row mt-3">
									<div class="col p-3">
										<div id="order_product_bar_chart" style="height: 370px;"></div>
									</div>
								</div>

								<div class="row">
									<div class="col-6 p-3">
										<div id="buyPrice_msrp_line_chart" style="height: 370px;"></div>
									</div>
									<div class="col-6 p-3">
										<div id="sales_revenue_line_chart" style="height: 370px;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer class="footer text-center">
				2020 � Ample Admin brought to you by <a
					href="https://www.wrappixel.com/">wrappixel.com</a>
			</footer>
		</div>
	</div>

	<!-- Bootstrap tether Core JavaScript -->
	<script
		src="${ pageContext.request.contextPath }/backend/assets/plugins/bower_components/popper.js/dist/umd/popper.min.js"></script>
	<script src="${ pageContext.request.contextPath }/backend/assets/js/app-style-switcher.js"></script>
	<!--Wave Effects -->
	<script src="${ pageContext.request.contextPath }/backend/assets/js/waves.js"></script>
	<!--Menu sidebar -->
	<script src="${ pageContext.request.contextPath }/backend/assets/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script src="${ pageContext.request.contextPath }/backend/assets/js/custom.js"></script>
</body>

</html>