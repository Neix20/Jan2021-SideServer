<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Orderdetail"%>
<%
	List<Orderdetail> orderdetailList = (List<Orderdetail>) request.getAttribute("orderdetailList");
	int orderNumber = orderdetailList.get(0).getId().getOrdernumber();
	String servlet_name = (String) request.getAttribute("servlet_name");
	int currentPage = (Integer) request.getAttribute("currentPage");
	int nOfPage = (Integer) request.getAttribute("nOfPage");
	int num;
	double sum = 0;
	String link;
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
	href="backend/assets/plugins/images/favicon.png">
<!-- Custom CSS -->
<link href="backend/assets/css/style.min.css" rel="stylesheet">
<title>Order Detail Page</title>
<link rel="stylesheet"
	href="backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script src="backend/assets/bootstrap/dist/js/jquery-3.5.1.min.js"></script>
<link href="backend/assets/css/def_table.css" rel="stylesheet">
<style>
table.table tr th:first-child {
	width: 50px;
}

.product-body {
	height: 360px;
}
</style>
<script>
	$(document).ready(function() {
		// Activate tooltip
		$('[data-toggle="tooltip"]').tooltip();
	});
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
						<h4 class="page-title text-uppercase font-medium font-14">MANAGE
							ORDER DETAIL</h4>
					</div>
				</div>
			</div>

			<div class="container-fluid">
				<div class="row">
					<div class="col-sm-12">
						<div class="white-box">
							<div class="container-xl">
								<div class="table-responsive">
									<div class="table-wrapper">
										<div class="table-title">
											<div class="row">
												<div class="col-sm-6">
													<h2>
														Manage <b>Order Detail</b>
													</h2>
												</div>
												<div class="col-sm-6">
													<a href="#addOrderDetailModal" class="btn btn-success"
														data-toggle="modal"><i class="fas fa-plus-circle"></i>
														<span>Add New Order Detail</span></a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-hover text-center">
											<thead>
												<tr>
													<th>No.</th>
													<th>Product Name</th>
													<th>Quantity</th>
													<th>Price Per Item</th>
													<th>Sub Price</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody>
												<%
													num = 1;
													for (Orderdetail od : orderdetailList) {
														sum += od.getPriceeach().doubleValue() * od.getQuantityordered();
												%>
												<tr>
													<td><%=od.getOrderlinenumber()%></td>
													<td><%=od.getProduct().getProductname()%></td>
													<td><%=od.getQuantityordered()%></td>
													<td><%=od.getPriceeach().toString()%></td>
													<td><%=String.format("%.2f", od.getPriceeach().doubleValue() * od.getQuantityordered())%></td>
													<td><a href="#editOrderDetailModal<%=num%>"
														class="edit" data-toggle="modal"><i
															class="fas fa-pen-square" data-toggle="tooltip"
															title="Edit"></i></a> <a
														href="#deleteOrderDetailModal<%=num%>" class="delete"
														data-toggle="modal"><i class="fas fa-trash-alt"
															data-toggle="tooltip" title="Delete"></i></a></td>
												</tr>
												<%
													num++;
													}
												%>
												<tr>
													<td></td>
													<td></td>
													<td></td>
													<th>Total Price:</th>
													<td>RM <%=String.format("%.2f", sum)%></td>
													<td></td>
												</tr>
											</tbody>
										</table>
										<div class="clearfix">
											<div class="hint-text">
												Showing <b><%=currentPage%></b> out of <b><%=nOfPage%></b>
												pages
											</div>
											<ul class="pagination">
												<%
													if (currentPage > 2) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?orderNumber=" + orderNumber
																+ "&currentPage=" + (currentPage - 2) + "\">Previous</a></li>";
														out.println(link);
													}
												%>
												<%
													if (currentPage > 1) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?orderNumber=" + orderNumber + "&currentPage=" + (currentPage - 1) + "\">"
																+ (currentPage - 1) + "</a></li>";
														out.println(link);
													}
												%>
												<li class="page-item active"><a
													href="<%=servlet_name%>?orderNumber=<%=orderNumber%>&currentPage=<%=currentPage%>"
													class="page-link"><%=currentPage%></a></li>
												<%
													if (currentPage < nOfPage) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?orderNumber=" + orderNumber + "&currentPage=" + (currentPage + 1) + "\">"
																+ (currentPage + 1) + "</a></li>";
														out.println(link);
													}
												%>
												<%
													if (currentPage < nOfPage - 1) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?orderNumber=" + orderNumber + "&currentPage=" + (currentPage + 2)
																+ "\">Next</a></li>";
														out.println(link);
													}
												%>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer class="footer text-center">
				2020 © Ample Admin brought to you by <a
					href="https://www.wrappixel.com/">wrappixel.com</a>
			</footer>
		</div>
	</div>

	<!-- Add Modal HTML -->
	<div id="addOrderDetailModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="add_form">
					<div class="modal-header">
						<h4 class="modal-title">Add Order Detail</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>PRODUCT NAME</label> <input name="product_name"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>PRODUCT QUANTITY</label> <input name="product_name"
								class="form-control input-md" required type="number">
						</div>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-success" name="type" value="ADD">
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Edit Modal HTML -->
	<div id="editOrderDetailModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="update_form">
					<div class="modal-header">
						<h4 class="modal-title">Edit Order Detail</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>PRODUCT NAME</label> <input name="product_name"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>PRODUCT QUANTITY</label> <input name="product_name"
								class="form-control input-md" required type="text">
						</div>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-success" name="type" value="UPDATE">
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- Delete Modal HTML -->
	<div id="deleteOrderDetailModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form>
					<div class="modal-header">
						<h4 class="modal-title">Delete Order Detail</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
					</div>
					<input name="productcode" hidden type="text">
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-danger" name="Type" value="DELETE">
					</div>
				</form>
			</div>
		</div>
	</div>

	<script
		src="backend/assets/plugins/bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Bootstrap tether Core JavaScript -->
	<script
		src="backend/assets/plugins/bower_components/popper.js/dist/umd/popper.min.js"></script>
	<script src="backend/assets/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="backend/assets/js/app-style-switcher.js"></script>
	<!--Wave Effects -->
	<script src="backend/assets/js/waves.js"></script>
	<!--Menu sidebar -->
	<script src="backend/assets/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script src="backend/assets/js/custom.js"></script>
</body>

</html>