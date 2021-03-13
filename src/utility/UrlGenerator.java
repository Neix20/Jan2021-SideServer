package utility;

/**
* URLGenerator simplifies management of URL across different
* HTML management by keeping changes of states in one class (place).
*
* @author  Yap Jheng Khin
* @version 1.0
* @since   2021-03-12 
*/
public class UrlGenerator {
	
	private String absoluteLink;
	private int nOfPages;
	private int currentPage;
	private int recordsPerPage;
	private String keyword;
	private String sortItem;
	private String sortType;
	
	public UrlGenerator(String absoluteLink,
						int nOfPages, 
						int currentPage, 
						int recordsPerPage, 
						String keyword, 
						String sortItem, 
						String sortType) {
		this.nOfPages =  nOfPages;
		this.currentPage =  currentPage;
		this.recordsPerPage =  recordsPerPage;
		this.keyword =  keyword;
		this.sortItem =  sortItem;
		this.sortType =  sortType;
	}
	
	// Custom clone constructor
	public UrlGenerator(UrlGenerator that) {
	    this(
		    that.getAbsoluteLink(),
		    that.getnOfPages(),
		    that.getCurrentPage(),
		    that.getRecordsPerPage(),
		    that.getKeyword(),
		    that.getSortItem(),
		    that.getSortType()
	    );
	}
	
	public String getAbsoluteLink() {
		return absoluteLink;
	}

	public void setAbsoluteLink(String absoluteLink) {
		this.absoluteLink = absoluteLink;
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
	
	// Combine all attributes into a working URL
	@Override
	public String toString() {
		StringBuilder url = new StringBuilder();
		
		url.append(absoluteLink);
		url.append("?nOfPages=");
		url.append(nOfPages);
		url.append("&currentPage=");
		url.append(currentPage);
		url.append("&recordsPerPage=");
		url.append(recordsPerPage);
		url.append("&keyword=");
		url.append(keyword);
		url.append("&sortItem=");
		url.append(sortItem);
		url.append("&sortType=");
		url.append(sortType);
		
		return url.toString();
	}
}
