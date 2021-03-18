package controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import domain.Order;
import session_bean.OrderSessionBeanLocal;
import session_bean.ProductSessionBeanLocal;

/**
 * Servlet implementation class debugServlet
 */
@WebServlet(urlPatterns = { "/debugServlet", "/download" })
public class debugServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ProductSessionBeanLocal productBean;

	@EJB
	private OrderSessionBeanLocal orderBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public debugServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Order> orderList = orderBean.getAllOrders();
		String file_dir = request.getServletContext().getRealPath("") + File.separator
				+ request.getServletContext().getInitParameter("report_save_dir");
		String fileName = "orderReport.xls";
		HSSFWorkbook wb = new HSSFWorkbook();
		//invoking creatSheet() method and passing the name of the sheet to be created   
		HSSFSheet sheet = wb.createSheet("Order Report");   
		//creating the 0th row using the createRow() method  
		HSSFRow rowhead = sheet.createRow((short)0);  
		//creating cell by using the createCell() method and setting the values to the cell by using the setCellValue() method
		rowhead.createCell(0).setCellValue("Order Number");  
		rowhead.createCell(1).setCellValue("Order Date");  
		rowhead.createCell(2).setCellValue("Required Date");  
		rowhead.createCell(3).setCellValue("Shipped Date");
		rowhead.createCell(4).setCellValue("Comment");  
		rowhead.createCell(5).setCellValue("Customer ID");  
		rowhead.createCell(6).setCellValue("Status"); 
		
		int num = 0;
		for(Order o : orderList) {
			//creating the 1st row  
			HSSFRow row = sheet.createRow((short) num);  
			//inserting data in the first row  
			row.createCell(0).setCellValue(o.getOrdernumber());  
			row.createCell(1).setCellValue(o.getOrderdate());  
			row.createCell(2).setCellValue(o.getRequireddate());  
			row.createCell(3).setCellValue(o.getShippeddate());
			row.createCell(4).setCellValue(o.getComments());  
			row.createCell(5).setCellValue(o.getCustomernumber());  
			row.createCell(6).setCellValue(o.getStatus());
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
			//Write file for download
			while ((iBuf = buffIn.read()) != -1) {
				ost.write((byte) iBuf);
			}
			ost.flush();
		} finally {
			buffIn.close();
			ost.close();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
