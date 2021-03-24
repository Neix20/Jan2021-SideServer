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

import domain.Customer;
import domain.Employee;
import session_bean.CustomerLocal;
import session_bean.EmployeeSessionBeanLocal;
import utility.html_generator;

/**
 * @Servlet implementation class EmployeeServlet
 */

@WebServlet(name = "Employee Servlet", urlPatterns = { "/manageEmployee" })
public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private EmployeeSessionBeanLocal employeeBean;

	@EJB
	private CustomerLocal customerBean;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EmployeeServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Employee> employeeList = employeeBean.getAllEmployee();

		int recordsPerPage = 10, nOfPage = employeeList.size() / recordsPerPage;
		if (employeeList.size() % recordsPerPage != 0)
			nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > employeeList.size()) ? employeeList.size()
				: currentPage * recordsPerPage;
		
		int nextEmployeeNumber = employeeList.get(employeeList.size() - 1).getEmployeenumber() + 1;

		employeeList = (employeeList.isEmpty()) ? employeeList : employeeList.subList(start_num, end_num);

		List<Customer> customerList = customerBean.getAllCustomer();

		HashMap<Integer, String> customerHashMap = new HashMap<Integer, String>();
		for (Customer c : customerList)
			customerHashMap.put(c.getCustomernumber(), c.getCustomername());

		String downloadFile = request.getParameter("type");
		if (downloadFile != null)
			downloadReport(request, response, customerHashMap);
		

		request.setAttribute("servlet_name", "manageEmployee");
		request.setAttribute("employeeList", employeeList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);
		request.setAttribute("customerList", customerList);
		request.setAttribute("customerHashMap", customerHashMap);
		request.setAttribute("nextEmployeeNumber", nextEmployeeNumber);

		RequestDispatcher req = request.getRequestDispatcher("backend/manageEmployee.jsp");
		req.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String type = request.getParameter("type");
		String[] parameter = Employee.getParameter();
		String[] arr = new String[parameter.length];

		for (int i = 0; i < arr.length; i++)
			arr[i] = request.getParameter(parameter[i]);

		Employee e;
		PrintWriter out = response.getWriter();

		switch (type) {
		case "ADD":
			e = new Employee();
			e.setEverything(arr);
			employeeBean.addEmployee(e);
			out.println(html_generator.operation_complete("added", "manageEmployee"));
			break;
		case "UPDATE":
			e = employeeBean.findEmployee(arr[0]);
			e.setEverything(arr);
			employeeBean.updateEmployee(e);
			out.println(html_generator.operation_complete("updated", "manageEmployee"));
			break;
		case "DELETE":
			e = employeeBean.findEmployee(arr[0]);
			employeeBean.deleteEmployee(e);
			out.println(html_generator.operation_complete("deleted", "manageEmployee"));
			break;

		}
	}

	public void downloadReport(HttpServletRequest request, HttpServletResponse response,
			HashMap<Integer, String> customerHashMap) throws IOException {
		List<Employee> employeeList = employeeBean.getAllEmployee();
		String file_dir = request.getServletContext().getRealPath("") + File.separator
				+ request.getServletContext().getInitParameter("report_save_dir");
		String fileName = "employeeReport.xls";
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("Employee Report");
		HSSFRow rowhead = sheet.createRow((short) 0);

		rowhead.createCell(0).setCellValue("Employee Number");
		rowhead.createCell(1).setCellValue("Last Name");
		rowhead.createCell(2).setCellValue("First Name");
		rowhead.createCell(3).setCellValue("Extension");
		rowhead.createCell(4).setCellValue("Office Code");
		rowhead.createCell(5).setCellValue("Reports to");
		rowhead.createCell(6).setCellValue("Jobtitle");

		int num = 0;
		for (Employee e : employeeList) {
			HSSFRow row = sheet.createRow((short) num);
			row.createCell(0).setCellValue(e.getEmployeenumber());
			row.createCell(1).setCellValue(e.getLastname());
			row.createCell(2).setCellValue(e.getFirstname());
			row.createCell(3).setCellValue(e.getExtension());
			row.createCell(4).setCellValue(e.getOfficecode());
			row.createCell(5).setCellValue(e.getReportsto());
			row.createCell(6).setCellValue(e.getJobtitle());
			num++;

		}
		FileOutputStream fileOut = new FileOutputStream(file_dir + File.separator + fileName);
		wb.write(fileOut);
		fileOut.close();
		wb.close();

		OutputStream ost = null;
		BufferedInputStream buffIn = null;
		try {
			response.setContentType("application/vnd.ms-excel");
			File reportFile = new File(file_dir + File.separator + fileName);
			ost = response.getOutputStream();
			response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
			buffIn = new BufferedInputStream(new FileInputStream(reportFile));
			int iBuf;
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
