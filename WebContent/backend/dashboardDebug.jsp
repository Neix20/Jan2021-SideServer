<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.DashboardOrder"%>
<%
	List<String> date_options = (List<String>) request.getAttribute("date_options");
	List<DashboardOrder> orderMonthList = (List<DashboardOrder>) request.getAttribute("orderMonthList");
	String servlet_name = (String) request.getAttribute("servlet_name");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard Debug</title>
<script src="backend/assets/js/jquery-3.5.1.min.js"></script>
<script src="backend/assets/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="backend/assets/js/jquery.canvasjs.min.js"></script>
<link rel="stylesheet"
	href="backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script src="backend/assets/js/selectize.js"></script>
<link rel="stylesheet" href="backend/assets/css/selectize/selectize.css" />
<script>
	$(document).ready(function() {
		$(".search_select").selectize({
			sortField : 'text'
		});
	});
</script>
</head>
<body>
	<form id="date_select" action="<%=servlet_name%>" method="GET">
		<div class="p-3">
			<div class="row">
				<div class="col-2">
					<select class="search_select" form="date_select" name="date_select" onchange="this.form.submit()">
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
		</div>
	</form>

	<table class="table text-center" style="width: 200px;">
		<thead>
			<tr>
				<th>Order Date</th>
				<th>WWeek Range</th>
			</tr>
		</thead>
		<tbody>
			<%
				for (DashboardOrder dbo : orderMonthList) {
			%>
			<tr>
				<td><%=dbo.getOrderdate()%></td>
				<td><%=dbo.getWeekRange()%></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
</body>
</html>