package controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import domain.Productline;
import session_bean.ProductlineSessionBeanLocal;
import utility.html_generator;

/**
 * Servlet implementation class ProductlineServlet
 */
@WebServlet(name = "Product Line Servlet", urlPatterns = { "/manageProductline"})
@MultipartConfig
public class ProductlineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ProductlineSessionBeanLocal productlineBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductlineServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		List<Productline> productlineList = productlineBean.getAllProductline();

		int recordsPerPage = 4, nOfPage = productlineList.size() / recordsPerPage;
		nOfPage += 1;
		String temp = request.getParameter("currentPage");
		int currentPage = (temp != null) ? Integer.valueOf(temp) : 1;
		int start_num = (currentPage - 1) * recordsPerPage;
		int end_num = (currentPage * recordsPerPage > productlineList.size()) ? productlineList.size()
				: currentPage * recordsPerPage;

		productlineList = productlineList.subList(start_num, end_num);

		request.setAttribute("servlet_name", "manageProductline");
		request.setAttribute("ProductlineList", productlineList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("nOfPage", nOfPage);

		RequestDispatcher req = request.getRequestDispatcher("backend/manageProductline.jsp");
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
		String[] parameter = Productline.getParameter();
		String[] arr = new String[parameter.length];

		for (int i = 0; i < arr.length; i++)
			arr[i] = request.getParameter(parameter[i]);

		Productline pl;
		PrintWriter outWrite = response.getWriter();

		switch (type) {
		case "ADD":
			String file_dir = request.getServletContext().getRealPath("") + File.separator
					+ request.getServletContext().getInitParameter("image_save_dir");
			final Part filePart = request.getPart("imageFile");
			final String fileName = request.getParameter("productline").split(" ")[0] + ".jpg";
			OutputStream out = null;
			InputStream filecontent = null;
			try {
				out = new FileOutputStream(new File(file_dir + File.separator + fileName));
				filecontent = filePart.getInputStream();
				int read = 0;
				final byte[] bytes = new byte[1024];
				while ((read = filecontent.read(bytes)) != -1) {
					out.write(bytes, 0, read);
				}
			} catch (FileNotFoundException fne) {
				System.out.println("Error: " + fne.getMessage());
			} finally {
				if (out != null) {
					out.close();
				}
				if (filecontent != null) {
					filecontent.close();
				}
			}
			pl = new Productline();
			pl.setEverything(arr);
			productlineBean.addProductline(pl);
			outWrite.println(html_generator.operation_complete("added", "manageProductline"));
			break;
		case "UPDATE":
			pl = productlineBean.getProductline(arr[0]);
			pl.setEverything(arr);
			productlineBean.updateProductline(pl);
			outWrite.println(html_generator.operation_complete("updated", "manageProductline"));
			break;
		case "DELETE":
			pl = productlineBean.getProductline(arr[0]);
			productlineBean.deleteProductline(pl);
			outWrite.println(html_generator.operation_complete("deleted", "manageProductline"));
			break;
		}

	}

	private String getFileName(final Part part) {
		final String partHeader = part.getHeader("content-disposition");
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}

}
