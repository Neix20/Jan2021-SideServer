package utility;

import javax.servlet.http.HttpServletRequest;

/**
* Custom class to process the request's parameter to reduce code redundancy.
* 
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
*/
public class PaginationRequestProcessor {
	
	private int nOfPages;
	private int currentPage;
	private int recordsPerPage;
	private String keyword;
	private String sortItem;
	private String sortType;
	
	public PaginationRequestProcessor() {
		nOfPages = 0;
		currentPage = 1;
		recordsPerPage = 30;
		keyword = "";
		sortItem = "";
		sortType = "";
	}

	/**
	 * Process the client's request and set the values accordingly for pagination.
	 * 
	 * Reference: UCCD3243 Practical slide
	 * 
	 * @param request
	 */
	public void process(HttpServletRequest request) {

		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.valueOf(request.getParameter("currentPage"));
		} 
		
		if (request.getParameter("recordsPerPage") != null) {
			recordsPerPage = Integer.valueOf(request.getParameter("recordsPerPage"));
		}
		
		if (request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		
		// Additional parameter sortItem and sortType to provide sorting functionality
		if (request.getParameter("sortItem") != null) {
			sortItem = request.getParameter("sortItem");
			if (request.getParameter("sortType") != null) {
				if (request.getParameter("sortType").equals("DESC"))
					sortType = "DESC";	
				else
					sortType = "ASC";
			}
		}
	}
	
	public int getnOfPages() {
		return nOfPages;
	}

	public void setnOfPages(int nOfPages) {
		this.nOfPages = nOfPages;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getRecordsPerPage() {
		return recordsPerPage;
	}

	public void setRecordsPerPage(int recordsPerPage) {
		this.recordsPerPage = recordsPerPage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getSortItem() {
		return sortItem;
	}

	public void setSortItem(String sortItem) {
		this.sortItem = sortItem;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}
}
