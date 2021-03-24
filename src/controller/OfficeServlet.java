package controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
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

import domain.Employee;
import domain.Office;
import session_bean.EmployeeSessionBeanLocal;
import session_bean.OfficeSessionBeanLocal;
import utility.html_generator;


/**
 * Servlet implementation class OfficeServlet
 */
@WebServlet(name="Office Servlet", urlPatterns = {"/manageOffice"})	
public class OfficeServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
 
	@EJB
	private OfficeSessionBeanLocal officeBean;
	
	@EJB
	private EmployeeSessionBeanLocal employeeBean;
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public OfficeServlet() {
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
		List<Office> officeList = officeBean.getAllOffices();
		
		int recordsPerPage = 10, nOfPage = officeList.size() / recordsPerPage;
		nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > officeList.size()) ? officeList.size() : currentPage * recordsPerPage;

		officeList = (officeList.isEmpty()) ? officeList : officeList.subList(start_num, end_num);
		int nextOfficeCode = officeList.get(officeList.size() - 1).getOfficecode() + 1;
		
		List<Employee> employeeList = employeeBean.getAllEmployee();
		
		HashMap<Integer, String> employeeHashMap = new HashMap<Integer, String>();
		for(Employee e : employeeList)
			employeeHashMap.put(e.getEmployeenumber(), e.getLastname());
		
		String downloadFile = request.getParameter("type");
		if(downloadFile != null) downloadReport(request, response, employeeHashMap);
		
		request.setAttribute("servlet_name", "manageOffice");
		request.setAttribute("officeList", officeList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("employeeList", employeeList);
		request.setAttribute("employeeHashMap", employeeHashMap);
		request.setAttribute("nextOfficeNumber", nextOfficeCode);
		RequestDispatcher req = request.getRequestDispatcher("backend/manageOffice.jsp");
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
		String[] parameter = Office.getParameter();
		String[] arr = new String[parameter.length];
		
		for(int i = 0; i < arr.length; i++) arr[i] = request.getParameter(parameter[i]);
		
		Office f;
		PrintWriter out = response.getWriter();
		
		switch(type) {
		case "ADD":
			f = new Office();
			f.setEverything(arr);
			officeBean.addOffice(f);
			out.println(html_generator.operation_complete("added", "manageOffice"));
			break;
		case "UPDATE":
			f = officeBean.getOffice(arr[0]);
			f.setEverything(arr);
			officeBean.updateOffice(f);
			out.println(html_generator.operation_complete("updated", "manageOffice"));
			break;
		case "DELETE":
			f = officeBean.getOffice(arr[0]);
			officeBean.deleteOffice(f);
			out.println(html_generator.operation_complete("deleted", "manageOffice"));
			break;
		}
	}
	
	public void downloadReport(HttpServletRequest request, HttpServletResponse response, HashMap<Integer, String> employeeHashMap) throws IOException {
		List<Office> officeList = officeBean.getAllOffices();
		String file_dir = request.getServletContext().getRealPath("") + File.separator
				+ request.getServletContext().getInitParameter("report_save_dir");
		String fileName = "officeReport.xls";
		HSSFWorkbook wb = new HSSFWorkbook();
		//invoking creatSheet() method and passing the name of the sheet to be created   
		HSSFSheet sheet = wb.createSheet("Order Report");   
		//creating the 0th row using the createRow() method  
		HSSFRow rowhead = sheet.createRow((short)0);  
		//creating cell by using the createCell() method and setting the values to the cell by using the setCellValue() method
		rowhead.createCell(0).setCellValue("Office Number");  
		rowhead.createCell(1).setCellValue("City");  
		rowhead.createCell(2).setCellValue("Addressline 1");
		rowhead.createCell(3).setCellValue("Addressline 2"); 
		rowhead.createCell(4).setCellValue("Postal Code");
		rowhead.createCell(5).setCellValue("Employee ID");
		

		
		int num = 0;
		for(Office f : officeList) {
			//creating the 1st row  
			HSSFRow row = sheet.createRow((short) num);  
			//inserting data in the first row  
			row.createCell(0).setCellValue(f.getOfficecode());  
			row.createCell(1).setCellValue(f.getCity());  
			row.createCell(2).setCellValue(f.getAddressline1());
			row.createCell(3).setCellValue(f.getAddressline2());
			row.createCell(4).setCellValue(f.getPostalcode());
			row.createCell(5).setCellValue(employeeHashMap.get(f.getEmployees())); 
		
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

}
