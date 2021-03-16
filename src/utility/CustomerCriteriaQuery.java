package utility;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Order;
import javax.persistence.criteria.Root;

import domain.Customer;
import domain.Customer_;

/**
 * Class to construct customer criteria queries. This method allows 
 * more flexibility and customization as compared to NamedQuery or 
 * NamedNativeQuery. For this purpose, I create a custom search function
 * to allow searching between string and non-string attributes, which
 * is not possible if NamedQuery or NamedNative Query is used.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
public class CustomerCriteriaQuery {
	    
    private CriteriaBuilder cb;
    
    public CustomerCriteriaQuery() {
    }
    
    public CustomerCriteriaQuery(CriteriaBuilder cb) {
    	this.cb = cb;
    }
    
    /**
     * Get the criteria query of customer's query
     * 
     * @param keyword
     * @return criteria query that returns number of rows
     */
    public CriteriaQuery<Long> getNumberofCustomer(String keyword) {
    	
    	// Specify the type of the query to create a type-safe query
    	CriteriaQuery<Long> query = cb.createQuery(Long.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query
    	Root<Customer> customer = query.from(Customer.class);
    	/* Call the select method of the query object, passing in the query root, to set the SELECT clause of the query
    	 * Perform `SELECT COUNT(c.customernumber) FROM Customer c`
    	 */
    	query.select(cb.count(customer.get(Customer_.customernumber)));
    	
    	// Perform ATTR1 like '%keyword%' or ATTR2 like '%keyword%' or...
    	if (!keyword.equals("")) {
	    	List<Expression<String>> expressions = setAll(customer);
	    	Expression<Boolean> stringConcat = CustomJPQLFunction.constructSearch(keyword.trim(), cb, expressions);
	    	query.where(stringConcat);
    	}

    	return query;
    }
    
    /**
     * Get the criteria query of customer's query
     * 
     * @param keyword
     * @param sortItem
     * @param sortType
     * @return criteria query that returns customer's records
     */
    public CriteriaQuery<Customer> findCustomer(String keyword, String sortItem, String sortType) {
    	
    	// Specify the type of the query to create a type-safe query
    	CriteriaQuery<Customer> query = cb.createQuery(Customer.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query
    	Root<Customer> customer = query.from(Customer.class);
    	/* Call the select method of the query object, passing in the query root, to set the SELECT clause of the query
    	 * Perform `SELECT c FROM Customer c`
    	 */
    	query.select(customer);
    	
    	// Perform ATTR1 like '%keyword%' or ATTR2 like '%keyword%' or...
    	if (!keyword.equals("")) {
	    	List<Expression<String>> expressions = setAll(customer);
	    	Expression<Boolean> stringConcat = CustomJPQLFunction.constructSearch(keyword.trim(), cb, expressions);
	    	query.where(stringConcat);
    	}
    	
    	// Perform `ORDER BY specific_column`
    	sortItem = validateColumnName(sortItem);
    	Order queryOrder = null;
    	if (!sortType.equals("")) {
    		// Handle special case
    		if (sortItem.equals("salesrepresentativeno"))
    			queryOrder = cb.asc(customer.get("employee").get("employeenumber"));
    		// Normal case
    		else
    			queryOrder = cb.asc(customer.get(sortItem));
    	}
    	if (sortType.equals("ASC")) {
    		query.orderBy(queryOrder);
    	}
    	// Reverse the order if it is in DESC order
    	else if (sortType.equals("DESC")) {
    		queryOrder.reverse();
    		query.orderBy(queryOrder);
    	}
    			
    	return query;
    }
    
    /**
     * Ensure that only valid column is returned.
     */
    private String validateColumnName(String sortItem) {
      	
    	switch (sortItem) {
    	case "customernumber":
    	    break;
    	case "customername":
    	    break;
    	case "contactfirstname":
    	    break;
    	case "contactlastname":
    	    break;
    	case "phone":
    	    break;
    	case "email":
    	    break;
    	case "addressline1":
    	    break;
    	case "addressline2":
    	    break;
    	case "city":
    	    break;
    	case "state":
    	    break;
    	case "postalcode":
    	    break;
    	case "country":
    	    break;
    	case "salesrepresentativeno":
    	    break;
    	case "creditlimit":
    	    break;
    	default:
    		sortItem = "customernumber";
    		break;
    	}
    	
    	return sortItem;
    }
    
    /**
     * Get all the attributes of the customer in String. Convert all 
     * non-string attribute into string attribute to perform searching.
     */
    private List<Expression<String>> setAll(Root<Customer> customer) {
    	List<Expression<String>> expressions = new ArrayList<Expression<String>>();
    	Expression<String> customerNo = customer.get(Customer_.customernumber).as(String.class);
    	Expression<String> customername = customer.get(Customer_.customername);
    	Expression<String> contactlastname = customer.get(Customer_.contactlastname);	
    	Expression<String> contactfirstname = customer.get(Customer_.contactfirstname);
    	Expression<String> phone = customer.get(Customer_.phone);
    	Expression<String> addressline1 = customer.get(Customer_.addressline1);
    	Expression<String> addressline2 = customer.get(Customer_.addressline2);
    	Expression<String> city = customer.get(Customer_.city);
    	Expression<String> state = customer.get(Customer_.state);
    	Expression<String> postalcode = customer.get(Customer_.postalcode);
    	Expression<String> country = customer.get(Customer_.country);
    	Expression<String> creditlimit = customer.get(Customer_.creditlimit).as(String.class);
    	Expression<String> email = customer.get(Customer_.email);
    	Expression<String> salesrepresentativeno = customer.get(Customer_.employee).get("employeenumber").as(String.class);
    	
    	expressions.add(customerNo);
    	expressions.add(customername);
    	expressions.add(contactlastname);
    	expressions.add(contactfirstname);
    	expressions.add(phone);
    	expressions.add(addressline1);
    	expressions.add(addressline2);
    	expressions.add(city);
    	expressions.add(state);
    	expressions.add(postalcode);
    	expressions.add(country);
    	expressions.add(creditlimit);
    	expressions.add(email);
    	expressions.add(salesrepresentativeno);
    	
    	return expressions;
    }
}
