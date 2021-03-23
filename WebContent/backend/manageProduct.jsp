<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="domain.Product"%>
<%@ page import="domain.Productline"%>
<%@ page import="utility.html_generator"%>
<%
	List<Product> Productlist = (List<Product>) request.getAttribute("ProductList");
	List<Productline> productlineList = (List<Productline>) request.getAttribute("ProductlineList");
	String servlet_name = (String) request.getAttribute("servlet_name");
	String lastId = (String) request.getAttribute("lastId");
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
	href="${ pageContext.request.contextPath }/backend/assets/plugins/images/favicon.png">
<!-- Custom CSS -->
<link href="${ pageContext.request.contextPath }/backend/assets/css/style.min.css" rel="stylesheet">
<title>Product Page</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script src="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/js/jquery-3.5.1.min.js"></script>
<script src="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<link href="${ pageContext.request.contextPath }/backend/assets/css/def_table.css" rel="stylesheet">
<script src="${ pageContext.request.contextPath }/backend/assets/js/selectize.js"></script>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/backend/assets/css/selectize/selectize.css" />
<script>
$(document).ready(function(){
	// Activate tooltip
	$('[data-toggle="tooltip"]').tooltip();

	$('.search_select').selectize({
        sortField: 'text'
    });
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
						<h4 class="page-title text-uppercase font-medium font-14">Product
							Table</h4>
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
														Manage <b>Product</b>
													</h2>
												</div>
												<div class="col-sm-6">
													<form action="<%=servlet_name%>" method="get">
														<button class="btn btn-danger" name="type" value="DOWNLOAD">
															<i class="fas fa-file-excel"></i> <span>Download
																Report</span>
														</button>
													</form>
													<a href="#addProductModal" class="btn btn-success"
														data-toggle="modal"><i class="fas fa-plus-circle"></i>
														<span>Add New Product</span></a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-hover text-center">
											<thead>
												<tr>
													<th>Product Name</th>
													<th>Product Vendor</th>
													<th>Product Scale</th>
													<th>Product Line</th>
													<th>Quantity</th>
													<th>Buy Price</th>
													<th>MSRP</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody>
												<%
													num = 1;
													for (Product p : Productlist) {
												%>
												<tr>
													<td><%=p.getProductname()%></td>
													<td><%=p.getProductvendor()%></td>
													<td><%=p.getProductscale()%></td>
													<td><%=p.getProductline()%></td>
													<td><%=p.getQuantityinstock()%></td>
													<td><%=p.getBuyprice()%></td>
													<td><%=p.getMsrp()%></td>
													<td><a href="#editProductModal<%=num%>" class="edit"
														data-toggle="modal"><i class="fas fa-pen-square"
															data-toggle="tooltip" title="Edit"></i></a> <a
														href="#deleteProductModal<%=num%>" class="delete"
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
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?currentPage=1\">First</a></li>";
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
														link = "<li class=\"page-item\"><a href=\"" + servlet_name + "?currentPage=" + nOfPage
																+ "\">Last</a></li>";
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

	<!-- ============================================================== -->
	<!-- Add Modal HTML -->
	<div id="addProductModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="<%=servlet_name%>" method="POST" id="add_form">
					<div class="modal-header">
						<h4 class="modal-title">Add Product</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>PRODUCT CODE</label> <input id="productcode"
								name="productcode" value="<%=lastId%>"
								class="form-control input-md" readonly type="text">
						</div>
						<div class="form-group">
							<label>PRODUCT NAME</label> <input id="productname"
								name="productname"
								placeholder="E.g. 1969 Harley Davidson Ultimate Chopper"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>PRODUCT DESCRIPTION</label>
							<textarea name="productdescription"
								placeholder="PRODUCT DESCRIPTION" class="form-control"
								form="add_form" required></textarea>
						</div>
						<div class="form-group">
							<label for="productline">productline</label>
							<select class="search_select" id="productline"
								name="productline" form="add_form">
								<option value="">Enter a Product Line...</option>
								<%
									for (Productline pl : productlineList) {
								%>
								<option value="<%=pl.getProductline()%>"><%=pl.getProductline()%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="productscale">PRODUCT SCALE</label> <input
								id="productscale" name="productscale" placeholder="E.g. 1:10"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label for="productvendor">PRODUCT VENDOR</label> <input
								id="productvendor" name="productvendor"
								placeholder="E.g. Min Lin Diecast" class="form-control input-md"
								required type="text">
						</div>
						<div class="form-group">
							<label for="quantityInStock">QUANTIY IN STOCK</label> <input
								id="quantityInStock" name="quantityInStock"
								placeholder="E.g. 5000" class="form-control input-md" required
								type="number">
						</div>
						<div class="form-group">
							<label for="buyprice">BUY PRICE</label> <input id="buyprice"
								name="buyprice" placeholder="E.g. 8.18"
								class="form-control input-md" required type="number">
						</div>
						<div class="form-group">
							<label for="msrp">MSRP</label> <input id="msrp" name="msrp"
								placeholder="E.g. 9.04" class="form-control input-md" required
								type="number">
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
		for (Product p : Productlist) {
	%>
	<!-- Edit Modal HTML -->
	<div id="editProductModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="<%=servlet_name%>" method="POST" id="update_form<%=num%>">
					<div class="modal-header">
						<h4 class="modal-title">Update Product</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>PRODUCT CODE</label> <input id="productcode"
								name="productcode" value="<%=p.getProductcode()%>"
								class="form-control input-md" readonly type="text">
						</div>
						<div class="form-group">
							<label>PRODUCT NAME</label> <input id="productname"
								name="productname"
								placeholder="E.g. 1969 Harley Davidson Ultimate Chopper"
								class="form-control input-md" value="<%=p.getProductname()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label>PRODUCT DESCRIPTION</label>
							<textarea id="pD<%=num%>" name="productdescription"
								placeholder="PRODUCT DESCRIPTION" class="form-control"
								form="update_form<%=num%>" required></textarea>
							<script>
								document.querySelector("#pD<%=num%>").value = `<%=p.getProductdescription()%>`;
							</script>
						</div>
						<div class="form-group">
							<label for="productline">PRODUCT LINE</label> <select class="search_select" id="productline"
								name="productline" form="update_form<%=num%>">
								<option value="<%=p.getProductline()%>"><%=p.getProductline()%></option>
								<%
									for (Productline pl : productlineList) {
								%>
								<option value="<%=pl.getProductline()%>"><%=pl.getProductline()%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="productscale">PRODUCT SCALE</label> <input
								id="productscale" name="productscale" placeholder="E.g. 1:10"
								class="form-control input-md" value="<%=p.getProductscale()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label for="productvendor">PRODUCT VENDOR</label> <input
								id="productvendor" name="productvendor"
								placeholder="E.g. Min Lin Diecast"
								value="<%=p.getProductvendor()%>" class="form-control input-md"
								required type="text">
						</div>
						<div class="form-group">
							<label for="quantityInStock">QUANTIY IN STOCK</label> <input
								id="quantityInStock" name="quantityInStock"
								placeholder="E.g. 5000" class="form-control input-md"
								value="<%=p.getQuantityinstock()%>" required type="number">
						</div>
						<div class="form-group">
							<label for="buyprice">BUY PRICE</label> <input id="buyprice"
								name="buyprice" placeholder="E.g. 8.18"
								class="form-control input-md" required
								value="<%=p.getBuyprice()%>" type="number">
						</div>
						<div class="form-group">
							<label for="msrp">MSRP</label> <input id="msrp" name="msrp"
								placeholder="E.g. 9.04" class="form-control input-md" required
								value="<%=p.getMsrp()%>" type="number">
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
		for (Product p : Productlist) {
	%>
	<!-- Delete Modal HTML -->
	<div id="deleteProductModal<%=num%>" class="modal fade">
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
					<input name="productcode" value="<%=p.getProductcode()%>" hidden
						type="text">
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