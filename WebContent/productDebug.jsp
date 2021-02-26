<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="domain.Product"%>
<%@ page import="Utilities.html_generator" %>
<%
List<Product> list = (List<Product>) request.getAttribute("List");
List<Product> SearchResult = (List<Product>) request.getAttribute("SearchResult");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Debug Website</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<script src="js/bootstrap.bundle.js"></script>
<script src="js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<div class="h1">Product Debugging</div>
	<hr />

	<!--Implement Basic CURDS Function-->
	<div class="h3">View All Product</div>
	<div class="d-flex align-items-center justify-content-center">
		<table class="table table-striped table-bordered text-center">
			<thead>
				<tr class="bg-dark">
					<th colspan="9" style="color: white;">Product</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>Product Code</td>
					<td>Product Name</td>
					<td>Product Description</td>
					<td>Product Scale</td>
					<td>Product Vendor</td>
					<td>Product Line</td>
					<td>Quantity</td>
					<td>Buy Price</td>
					<td>MSRP</td>
				</tr>
				<%
				String table_row_html;
//             	for(Product p : list){
//             		table_row_html = "<tr>";
//             		table_row_html += html_generator.table_column(p.getProductcode());
//             		table_row_html += html_generator.table_column(p.getProductname());
//             		table_row_html += html_generator.table_column(p.getProductdescription());
//             		table_row_html += html_generator.table_column(p.getProductscale());
//             		table_row_html += html_generator.table_column(p.getProductvendor());
//             		table_row_html += html_generator.table_column(p.getProductlineBean().getProductline());
//             		table_row_html += html_generator.table_column(p.getQuantityinstock() + "");
//             		table_row_html += html_generator.table_column(p.getBuyprice() + "");
//             		table_row_html += html_generator.table_column(p.getMsrp() + "");
//             		table_row_html += "</tr>";
//             		out.println(table_row_html);
//             	}
				%>
			</tbody>
		</table>
	</div>

	<div class="h3">Search Product</div>
    <form action="ProductServlet" method="get">
        <input type="text" name="keyword" />
        <input type="submit" value="Submit" />
    </form>
    <div id="search_table">
    <%
    String table_html = "<table class=\"table table-striped table-bordered text-center\"><thead><tr class=\"bg-dark\"><th colspan=\"9\" style=\"color:white;\">Product</th></tr></thead><tbody><tr><td>Product Code</td><td>Product Name</td><td>Product Description</td><td>Product Scale</td><td>Product Vendor</td><td>Product Line</td><td>Quantity</td><td>Buy Price</td><td>MSRP</td></tr>";
    for(Product p : SearchResult){
		table_row_html = "<tr>";
		table_row_html += html_generator.table_column(p.getProductcode());
		table_row_html += html_generator.table_column(p.getProductname());
		table_row_html += html_generator.table_column(p.getProductdescription());
		table_row_html += html_generator.table_column(p.getProductscale());
		table_row_html += html_generator.table_column(p.getProductvendor());
		table_row_html += html_generator.table_column(p.getProductlineBean().getProductline());
		table_row_html += html_generator.table_column(p.getQuantityinstock() + "");
		table_row_html += html_generator.table_column(p.getBuyprice() + "");
		table_row_html += html_generator.table_column(p.getMsrp() + "");
		table_row_html += "</tr>";
		table_html += table_row_html;
	}
    table_html += "</tbody></table>";
    if(!SearchResult.isEmpty()) out.println("<script> $(function() { $(\"#search_table\").append(`" + table_html + "`); }); </script>");
    %>
    </div>
    <div class="h3">Add Product</div>
    <form action="ProductServlet" method="post">
        <table class="table text-center" style="width: 600px;">
            <tbody>
                <tr>
                    <td><label for="productcode">Product Code: </label></td>
                    <td><input type="text" name="productcode" /></td>
                </tr>
                <tr>
                    <td><label for="productname">Product Name: </label></td>
                    <td><input type="text" name="productname" /></td>
                </tr>
                <tr>
                    <td><label for="productdescription">Product Description: </label></td>
                    <td><input type="text" name="productdescription" /></td>
                </tr>
                <tr>
                    <td><label for="productscale">Product Scale: </label></td>
                    <td><input type="text" name="productscale" /></td>
                </tr>
                <tr>
                    <td><label for="productvendor">Product Vendor: </label></td>
                    <td><input type="text" name="productvendor" /></td>
                </tr>
                <tr>
                    <td><label for="productline">Product Line: </label></td>
                    <td><input type="text" name="productline" /></td>
                </tr>
                <tr>
                    <td><label for="quantityInStock">Quantity: </label></td>
                    <td><input type="text" name="quantityInStock" /></td>
                </tr>
                <tr>
                    <td><label for="buyprice">Buy Price: </label></td>
                    <td><input type="text" name="buyprice" /></td>
                </tr>
                <tr>
                    <td><label for="msrp">MSRP: </label></td>
                    <td><input type="text" name="msrp" /></td>
                </tr>
            </tbody>
        </table>
        <input type="submit" name="type" value="ADD" />
    </form>
    <div class="h3">Update Product</div>
    <form action="ProductServlet" method="post">
        <table class="table text-center" style="width: 600px;">
            <tbody>
                <tr>
                    <td><label for="productcode">Product Code: </label></td>
                    <td><input type="text" name="productcode" /></td>
                </tr>
                <tr>
                    <td><label for="productname">Product Name: </label></td>
                    <td><input type="text" name="productname" /></td>
                </tr>
                <tr>
                    <td><label for="productdescription">Product Description: </label></td>
                    <td><input type="text" name="productdescription" /></td>
                </tr>
                <tr>
                    <td><label for="productscale">Product Scale: </label></td>
                    <td><input type="text" name="productscale" /></td>
                </tr>
                <tr>
                    <td><label for="productvendor">Product Vendor: </label></td>
                    <td><input type="text" name="productvendor" /></td>
                </tr>
                <tr>
                    <td><label for="productline">Product Line: </label></td>
                    <td><input type="text" name="productline" /></td>
                </tr>
                <tr>
                    <td><label for="quantityInStock">Quantity: </label></td>
                    <td><input type="text" name="quantityInStock" /></td>
                </tr>
                <tr>
                    <td><label for="buyprice">Buy Price: </label></td>
                    <td><input type="text" name="buyprice" /></td>
                </tr>
                <tr>
                    <td><label for="msrp">MSRP: </label></td>
                    <td><input type="text" name="msrp" /></td>
                </tr>
            </tbody>
        </table>
        <input type="submit" name="type" value="UPDATE" />
    </form>
    <div class="h3">Delete Product</div>
    <form action="ProductServlet" method="post">
        <table class="table text-center" style="width: 600px;">
            <tbody>
                <tr>
					<td><label for="productcode">Name: </label></td>
					<td><select name="productcode">
							<% for(Product p : list) out.println("<option value=\"" + p.getProductcode() + "\">"+p.getProductname()+"</option>"); %>
					</select></td>
				</tr>
            </tbody>
        </table>
        <input type="submit" name="type" value="DELETE" />
    </form>
</body>
</html>