<%--
Author	  : Yap Jheng Khin
Page      : Customer dashboard
Reminder  : Please enable Internet connection to load third party libraries: Thank you
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="utility.UrlGenerator" %>
<%
	UrlGenerator urlGenerator = (UrlGenerator) request.getAttribute("urlGenerator");
	int nOfPages = urlGenerator.getnOfPages();
	int currentPage = urlGenerator.getCurrentPage();
	int recordsPerPage = urlGenerator.getRecordsPerPage();
	String keyword = urlGenerator.getKeyword();
	String sortItem = urlGenerator.getSortItem();
	String sortType = urlGenerator.getSortType();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Manage Customer</title>
</head>
<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-layout="vertical" data-navbarbg="skin5" data-sidebartype="full"
        data-sidebar-position="absolute" data-header-position="absolute" data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar Header and Left Sidebar - style you can find in pages.scss -->
        <!-- ============================================================== -->	
		<jsp:include page="header.jsp"/>
        <!-- ============================================================== -->
        <!-- End Topbar Header and Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb bg-white">
                <div class="row align-items-center">
                    <div class="col-sm-8">
                    	<%
                    	String pageDisplay = "";
						if (nOfPages !=0) { pageDisplay=currentPage + " of " + nOfPages; }
						%>
                        <h2 class="page-title text-uppercase font-medium">
							Customer <b>Details</b> 
							<span class="page-text font-weight-light small"><%= pageDisplay %></span>
						</h2>
                    </div>
					<div class="col-sm-4 d-flex justify-content-end search-box">
						<form id="search-form" action="${ pageContext.request.contextPath }/Customer" method="GET">
							<div class="input-group mr-3">
								<span class="input-group-addon"><a id="search" href="#" type="submit"><i class="material-icons">&#xE8B6;</i></a></span>
								<input type="text" name="keyword" class="form-control" placeholder="Search&hellip;">
								<input type="hidden" name="nOfPages" value="<%= urlGenerator.getnOfPages() %>">
								<input type="hidden" name="currentPage" value="<%= urlGenerator.getCurrentPage() %>">
								<input type="hidden" name="recordsPerPage" value="<%= urlGenerator.getRecordsPerPage() %>">
								<input type="hidden" name="sortItem" value="<%= urlGenerator.getSortItem() %>">
								<input type="hidden" name="sortType" value="<%= urlGenerator.getSortType() %>">
							</div>
						</form>
					</div>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid p-0" style="background-color:white;">
                <!-- ============================================================== -->
                <!-- Start Page Content -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="white-box p-0">
                            <jsp:include page="manage_customer2.jsp"/>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End PAge Content -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Right sidebar -->
                <!-- ============================================================== -->
                <!-- .right-sidebar -->
                <!-- ============================================================== -->
                <!-- End Right sidebar -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <jsp:include page="footer.jsp"/>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
</body>
</html>