package controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.math.RoundingMode;
import java.util.Collections;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import domain.Product;
import domain.Productline;
import session_bean.ProductSessionBeanLocal;
import session_bean.ProductlineSessionBeanLocal;
import utility.html_generator;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet(name = "Product Servlet", urlPatterns = { "/manageProduct"})
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ProductSessionBeanLocal productBean;

	@EJB
	private ProductlineSessionBeanLocal productlineBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Product> productList = productBean.getAllProduct();
		List<Productline> productlineList = productlineBean.getAllProductline();

		int recordsPerPage = 10, nOfPage = productList.size() / recordsPerPage;
		nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > productList.size()) ? productList.size()
				: currentPage * recordsPerPage;

		productList = productList.subList(start_num, end_num);

		String lastCode = productBean.getLastId().get(0).getProductcode();
		String lastId = (lastCode.equals("S72_3212")) ? "S904_0001" : getProductCode(lastCode);
		
		String downloadFile = request.getParameter("type");
		if(downloadFile != null) downloadReport(request, response);

		request.setAttribute("servlet_name", "manageProduct");
		request.setAttribute("lastId", lastId);
		request.setAttribute("ProductList", productList);
		request.setAttribute("ProductlineList", productlineList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		RequestDispatcher req = request.getRequestDispatcher("backend/manageProduct.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type = request.getParameter("type");
		String[] parameter = Product.getParameter();
		String[] arr = new String[parameter.length];

		for (int i = 0; i < arr.length; i++)
			arr[i] = request.getParameter(parameter[i]);

		Product p;
		PrintWriter out = response.getWriter();

		switch (type) {
		case "ADD":
			p = new Product();
			p.setEverything(arr);
			productBean.addProduct(p);
			out.println(html_generator.operation_complete("added", "manageProduct"));
			break;
		case "UPDATE":
			p = productBean.getProduct(arr[3]);
			p.setEverything(arr);
			productBean.updateProduct(p);
			out.println(html_generator.operation_complete("updated", "manageProduct"));
			break;
		case "DELETE":
			p = productBean.getProduct(arr[3]);
			productBean.deleteProduct(p);
			out.println(html_generator.operation_complete("deleted", "manageProduct"));
			break;
		}
	}

	public String getProductCode(String test) {
		String[] s = test.split("_");
		int x = Integer.valueOf(s[1]) + 1;
		int len = (int) (4 - 1 - Math.floor(Math.log10(x)));
		return s[0] + "_" + String.join("", Collections.nCopies(len, "0")) + x;
	}

	public void downloadReport(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<Product> productList = productBean.getAllProduct();
		String file_dir = request.getServletContext().getRealPath("") + File.separator
				+ request.getServletContext().getInitParameter("report_save_dir");
		String fileName = "productReport.xls";
		HSSFWorkbook wb = new HSSFWorkbook();
		// invoking creatSheet() method and passing the name of the sheet to be created
		HSSFSheet sheet = wb.createSheet("Product Report");
		// creating the 0th row using the createRow() method
		HSSFRow rowhead = sheet.createRow((short) 0);
		// creating cell by using the createCell() method and setting the values to the
		// cell by using the setCellValue() method
		rowhead.createCell(0).setCellValue("Product Code");
		rowhead.createCell(1).setCellValue("Product Name");
		rowhead.createCell(2).setCellValue("Product Description");
		rowhead.createCell(3).setCellValue("Product Vendor");
		rowhead.createCell(4).setCellValue("Product Line");
		rowhead.createCell(5).setCellValue("Product Scale");
		rowhead.createCell(6).setCellValue("Product Quantity");
		rowhead.createCell(7).setCellValue("Product Buy Price");
		rowhead.createCell(8).setCellValue("Product MSRP");

		int num = 0;
		for (Product p1 : productList) {
			// creating the 1st row
			HSSFRow row = sheet.createRow((short) num);
			// inserting data in the first row
			row.createCell(0).setCellValue(p1.getProductcode());
			row.createCell(1).setCellValue(p1.getProductname());
			row.createCell(2).setCellValue(p1.getProductdescription());
			row.createCell(3).setCellValue(p1.getProductvendor());
			row.createCell(4).setCellValue(p1.getProductline());
			row.createCell(5).setCellValue(p1.getProductscale());
			row.createCell(6).setCellValue(p1.getQuantityinstock());
			row.createCell(7).setCellValue(p1.getBuyprice().setScale(2, RoundingMode.HALF_UP).toString());
			row.createCell(8).setCellValue(p1.getMsrp().setScale(2, RoundingMode.HALF_UP).toString());
			num++;
		}

		FileOutputStream fileOut = new FileOutputStream(file_dir + File.separator + fileName);
		wb.write(fileOut);
		fileOut.close();
		wb.close();

		OutputStream ost = null;
		BufferedInputStream buffIn = null;
		try {
			// Write some codes here for file type word and excel….
			response.setContentType("application/vnd.ms-excel");
			File reportFile = new File(file_dir + File.separator + fileName);
			ost = response.getOutputStream();
			response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
			buffIn = new BufferedInputStream(new FileInputStream(reportFile));
			int iBuf;
			// Write file for download
			while ((iBuf = buffIn.read()) != -1) {
				ost.write((byte) iBuf);
			}
			ost.flush();
		} finally {
			buffIn.close();
			ost.close();
		}
	}

}
