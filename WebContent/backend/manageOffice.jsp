<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="domain.Office"%>
<%@ page import="domain.Employee"%>
<%
	List<Office> officeList = (List<Office>) request.getAttribute("officeList");
	List<Employee> employeeList = (List<Employee>) request.getAttribute("employeeList");
	HashMap<Integer, String> employeeHashMap = (HashMap<Integer, String>) request.getAttribute("employeeHashMap");
	int nextOfficeNumber = (Integer) request.getAttribute("nextOfficeNumber");
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
	href="${ pageContext.request.contextPath }/backend/assets/plugins/images/favicon.png">
<!-- Custom CSS -->
<link href="${ pageContext.request.contextPath }/backend/assets/css/style.min.css" rel="stylesheet">
<title>Manage Order</title>
<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/css/bootstrap.min.css" />
<script src="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/js/jquery-3.5.1.min.js"></script>
<script src="${ pageContext.request.contextPath }/backend/assets/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<link href="${ pageContext.request.contextPath }/backend/assets/css/def_table.css" rel="stylesheet">
<script src="${ pageContext.request.contextPath }/backend/assets/js/selectize.js"></script>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/backend/assets/css/selectize/selectize.css" />
<style>
table.table tr th:first-child {
	width: 100px;
}
</style>
<script>
        $(document).ready(function () {
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
						<h4 class="page-title text-uppercase font-medium font-14">MANAGE
							OFFICES</h4>
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
														Manage <b>Office</b>
													</h2>
												</div>
												<div class="col-sm-6">
													<form action="<%=servlet_name%>" method="get">
														<button class="btn btn-danger" name="type"
															value="DOWNLOAD">
															<i class="fas fa-file-excel"></i> <span>Download
																Report</span>
														</button>
													</form>
													<a href="#addOfficeModal" class="btn btn-success"
														data-toggle="modal"><i class="fas fa-plus-circle"></i>
														<span>Add New Office</span></a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-hover text-center">
											<thead>
												<tr>
													<th>Office Number</th>
													<th>City</th>
													<th>Addressline 1</th>
													<th>Addressline 2</th>
													<th>Postal Code</th>
													<th>Action</th>
												
												</tr>
											</thead>
											<tbody>
												<%
													num = 1;
													for (Office f : officeList) {
												%>
												<tr>
													<td><%=f.getOfficecode()%></td>
													<td><%=f.getCity()%></td>
													<td><%=f.getAddressline1()%></td>
													<td><%=f.getAddressline2()%></td>
													<td><%=f.getPostalcode()%></td>
													<td><a href="#editOfficeModal<%=num%>" class="edit"
														data-toggle="modal"><i class="fas fa-pen-square"
															data-toggle="tooltip" title="Edit"></i></a> <a
														href="#deleteOfficeModal<%=num%>" class="delete"
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

	<!-- Add Modal HTML -->
	<div id="addOfficeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="add_form" action="<%=servlet_name%>" method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Add Office</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>OFFICE NUMBER</label> <input name="officenumber"
								class="form-control input-md" readonly
								value="<%=nextOfficeNumber%>" type="text">
						</div>
						<div class="form-group">
							<label>CITY</label> <input name="city"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>ADDRESSLINE 1</label> <input name="addressline1"
								class="form-control input-md" required type="text">
						</div>
					<div class="form-group">
							<label>ADDRESSLINE 2</label> <input name="addressline2"
								class="form-control input-md" type="text">
						</div>
						
					<div class="form-group">
							<label>POSTAL CODE</label> <input name="postalcode"
								class="form-control input-md" type="number">
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
		for (Office f : officeList) {
	%>
	<!-- Edit Modal HTML -->
	<div id="editOfficeModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="update_form<%=num%>" action="<%=servlet_name%>"
					method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Edit Existing Office</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>OFFICE NUMBER</label> <input name="officenumber"
								class="form-control input-md" readonly
								value="<%=f.getOfficecode()%>" type="text">
						</div>
						<div class="form-group">
							<label>CITY</label> <input name="city"
								class="form-control input-md" value="<%=f.getCity()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label>ADDRESSLINE 1</label> <input name="addressline1"
								class="form-control input-md" value="<%=f.getAddressline1()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label>ADDRESLSINE 2</label> <input name="addressline2"
								class="form-control input-md" value="<%=f.getAddressline2()%>"
								type="text">
						</div>
							<div class="form-group">
							<label>POSTAL CODE</label> <input name="postalcode"
								class="form-control input-md" value="<%=f.getPostalcode()%>"
								type="text">
						</div>
					
					
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
		for (Office f : officeList) {
	%>
	<!-- Delete Modal HTML -->
	<div id="deleteOfficeModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="<%=servlet_name%>" method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Delete Office</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
					</div>
					<input name="officenumber" value="<%=f.getOfficecode()%>" hidden
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