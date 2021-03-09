<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Productline"%>
<%
	List<Productline> productlineList = (List<Productline>) request.getAttribute("ProductlineList");
	String servlet_name = (String) request.getAttribute("servlet_name");
	int currentPage = (Integer) request.getAttribute("currentPage");
	int nOfPage = (Integer) request.getAttribute("nOfPage");
	int num;
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
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<title>Productline Page</title>
<link rel="stylesheet"
	href="backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script src="backend/assets/bootstrap/dist/js/jquery-3.5.1.min.js"></script>
<link href="backend/assets/css/def_table.css" rel="stylesheet">
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
						<h4 class="page-title text-uppercase font-medium font-14">Manage
							Productline</h4>
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
														Manage <b>Productline</b>
													</h2>
												</div>
												<div class="col-sm-6">
													<a href="#addProductlineModal" class="btn btn-success"
														data-toggle="modal"><i class="fas fa-plus-circle"></i>
														<span>Add New Productline</span></a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-hover text-center">
											<thead>
												<tr>
													<th>Product Line Name</th>
													<th>Text Description</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody>
												<%
													num = 1;
													for (Productline pl : productlineList) {
												%>
												<tr>
													<td><%=pl.getProductline()%></td>
													<td><%=pl.getTextdescription()%></td>
													<td><a href="#editProductlineModal<%=num%>"
														class="edit" data-toggle="modal"><i
															class="fas fa-pen-square" data-toggle="tooltip"
															title="Edit"></i></a> <a
														href="#deleteProductlineModal<%=num%>" class="delete"
														data-toggle="modal"><i class="fas fa-trash-alt"
															data-toggle="tooltip" title="Delete"></i></a></td>
												</tr>
												<%
													num++;
													}
												%>
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
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?currentPage=" + (currentPage - 2)
																+ "\">Previous</a></li>";
														out.println(link);
													}
												%>
												<%
													if (currentPage > 1) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?currentPage=" + (currentPage - 1) + "\">"
																+ (currentPage - 1) + "</a></li>";
														out.println(link);
													}
												%>
												<li class="page-item active"><a
													href="<%=servlet_name%>?currentPage=<%=currentPage%>"
													class="page-link"><%=currentPage%></a></li>
												<%
													if (currentPage < nOfPage) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?currentPage=" + (currentPage + 1) + "\">"
																+ (currentPage + 1) + "</a></li>";
														out.println(link);
													}
												%>
												<%
													if (currentPage < nOfPage - 1) {
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?currentPage=" + (currentPage + 2)
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
	<div id="addProductlineModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="add_form" action="<%=servlet_name%>" method="POST"
					enctype="multipart/form-data">
					<div class="modal-header">
						<h4 class="modal-title">Add Productline</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>PRODUCTLINE</label> <input name="productline"
								placeholder="E.g. Motorcycles" class="form-control input-md"
								required type="text">
						</div>
						<div class="form-group">
							<label>TEXT DESCRIPTION</label>
							<textarea name="textdescription" placeholder="TEXT DESCRIPTION"
								class="form-control" form="add_form" required></textarea>
						</div>
						<div class="form-group">
							<label for="filebutton">IMAGE</label> <input name="imageFile"
								class="form-control input-file" type="file" required />
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

	<%
		num = 1;
		for (Productline pl : productlineList) {
	%>
	<!-- Edit Modal HTML -->
	<div id="editProductlineModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="update_form<%=num%>" action="<%=servlet_name%>"
					method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Edit Productline</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>PRODUCTLINE</label> <input name="productline"
								placeholder="E.g. Motorccles" class="form-control input-md"
								value="<%=pl.getProductline()%>" required type="text">
						</div>
						<div class="form-group">
							<label>TEXT DESCRIPTION</label>
							<textarea id="pL<%=num%>" name="textdescription"
								placeholder="PRODUCT DESCRIPTION" class="form-control"
								form="update_form<%=num%>" required></textarea>
							<script>
								document.querySelector("#pL<%=num%>").value = "<%=pl.getTextdescription()%>";
							</script>
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
	<%
		num++;
		}
	%>

	<%
		num = 1;
		for (Productline pl : productlineList) {
	%>
	<!-- Delete Modal HTML -->
	<div id="deleteProductlineModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="<%=servlet_name%>" method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Delete Product</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
					</div>
					<input name="productline" value="<%=pl.getProductline()%>" hidden type="text">
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal"
							value="Cancel"> <input type="submit"
							class="btn btn-danger" name="type" value="DELETE">
					</div>
				</form>
			</div>
		</div>
	</div>
	<%
		num++;
		}
	%>
	<!-- ============================================================== -->
	<!-- All Jquery -->
	<!-- ============================================================== -->
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