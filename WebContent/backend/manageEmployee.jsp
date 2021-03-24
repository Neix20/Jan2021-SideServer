<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="domain.Employee"%>
<%@ page import="domain.Customer"%>
<%
	List<Employee> employeeList = (List<Employee>) request.getAttribute("employeeList");
	List<Customer> customerList = (List<Customer>) request.getAttribute("customerList");
	HashMap<Integer, String> customerHashMap = (HashMap<Integer, String>) request
			.getAttribute("customerHashMap");
	int nextEmployeeNumber = (Integer) request.getAttribute("nextEmployeeNumber");
	String servlet_name = (String) request.getAttribute("servlet_name");
	int currentPage = (Integer) request.getAttribute("currentPage");
	int nOfPage = (Integer) request.getAttribute("nOfPage");
	int num;
	String link;
%>
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
<title>Manage Employee</title>
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
<script>
	$(document).ready(function() {
		// Activate tooltip
		$('[data-toggle="tooltip"]').tooltip();

		$('.search_select').selectize({
			sortField : 'text'
		});

	});
</script>
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
							EMPLOYEE</h4>
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
														Manage <b>Employee</b>
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
													<a href="#addEmployeeModal" class="btn btn-success"
														data-toggle="modal"><i class="fas fa-plus-circle"></i>
														<span>Add New Employee</span></a>
												</div>
											</div>
										</div>
										<table class="table table-striped table-hover text-center">
											<thead>
												<tr>
													<th>Employee Number</th>
													<th>Last Name</th>
													<th>First Name</th>
													<th>Email</th>
													<th>Extension</th>
													<th>Office Code</th>
													<th>Reports to</th>
													<th>Job Title</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
												<%
													num = 1;
													for (Employee e : employeeList) {
												%>
												<tr>
													<td><%=e.getEmployeenumber()%></td>
													<td><%=e.getLastname()%></td>
													<td><%=e.getFirstname()%></td>
													<td><%=e.getEmail()%></td>
													<td><%=e.getExtension()%></td>
													<td><%=e.getOfficecode()%></td>
													<td><%=e.getReportsto()%></td>
													<td><%=e.getJobtitle()%></td>
													<td><a href="#editEmployeeModal<%=num%>" class="edit"
														data-toggle="modal"><i class="fas fa-pen-square"
															data-toggle="tooltip" title="Edit"></i></a> <a
														href="#deleteEmployeeModal<%=num%>" class="delete"
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
	<div id="addEmployeeModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="add_form" action="<%=servlet_name%>" method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Add Employee</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>EMPLOYEE NUMBER</label> <input name="employeenumber"
								class="form-control input-md" readonly
								value="<%=nextEmployeeNumber%>" type="text">
						</div>
						<div class="form-group">
							<label>LAST NAME</label> <input name="lastname"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>FIRST NAME</label> <input name="firstname"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>EMAIL</label> <input name="email"
								class="form-control input-md" required type="text">
						</div>
						<div class="form-group">
							<label>EXTENSION</label> <input name="extension"
								class="form-control input-md" type="text">
						</div>
						<div class="form-group">
							<label>OFFICE CODE</label> <input name="officecode"
								class="form-control input-md" type="text">
						</div>
						<div class="form-group">
							<label>REPORTS TO</label> <input name="reportsto"
								class="form-control input-md" type="text">
						</div>
						<div class="form-group">
							<label>JOB TITLE</label> <input name="jobtitle"
								class="form-control input-md" type="text">
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
		for (Employee e : employeeList) {
	%>
	<!-- Edit Modal HTML -->
	<div id="editEmployeeModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="update_form<%=num%>" action="<%=servlet_name%>"
					method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Edit Existing Employee</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body product-body">
						<div class="form-group">
							<label>EMPLOYEE NUMBER</label> <input name="employeenumber"
								class="form-control input-md" readonly
								value="<%=e.getEmployeenumber()%>" type="text">
						</div>
						<div class="form-group">
							<label>LAST NAME</label> <input name="lastname"
								class="form-control input-md" value="<%=e.getLastname()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label>FIRST NAME</label> <input name="firstname"
								class="form-control input-md" value="<%=e.getFirstname()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label>EMAIL</label> <input name="email"
								class="form-control input-md" value="<%=e.getEmail()%>"
								required type="text">
						</div>
						<div class="form-group">
							<label>EXTENSION</label> <input name="extension"
								class="form-control input-md" value="<%=e.getExtension()%>"
								type="text">
						</div>
						<div class="form-group">
							<label>OFFICE NUMBER</label> <input name="officecode"
								class="form-control input-md" value="<%=e.getOfficecode()%>"
								type="text">
						</div>
						<div class="form-group">
							<label>REPORTS TO</label> <input name="reportsto"
								class="form-control input-md" value="<%=e.getReportsto()%>"
								type="text">
						</div>
						<div class="form-group">
							<label>JOB TITLE</label> <input name="jobtitle"
								class="form-control input-md" value="<%=e.getJobtitle()%>"
								type="text">
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
		for (Employee e : employeeList) {
	%>
	<!-- Delete Modal HTML -->
	<div id="deleteEmployeeModal<%=num%>" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form action="<%=servlet_name%>" method="POST">
					<div class="modal-header">
						<h4 class="modal-title">Delete Employee</h4>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>Are you sure you want to delete these Records?</p>
						<p class="text-warning">
							<small>This action cannot be undone.</small>
						</p>
					</div>
					<input name="employeenumber" value="<%=e.getEmployeenumber()%>" hidden
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
	<script
		src="${ pageContext.request.contextPath }/backend/assets/js/app-style-switcher.js"></script>
	<!--Wave Effects -->
	<script
		src="${ pageContext.request.contextPath }/backend/assets/js/waves.js"></script>
	<!--Menu sidebar -->
	<script
		src="${ pageContext.request.contextPath }/backend/assets/js/sidebarmenu.js"></script>
	<!--Custom JavaScript -->
	<script
		src="${ pageContext.request.contextPath }/backend/assets/js/custom.js"></script>
</body>

</html>