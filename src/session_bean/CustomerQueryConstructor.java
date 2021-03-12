package session_bean;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Order;
import javax.persistence.criteria.Root;

import domain.Customer;
import domain.Customer_;

public class CustomerQueryConstructor {
	    
    private CriteriaBuilder cb;
    // private CriteriaBuilder cb = em.getCriteriaBuilder();
    
    public CustomerQueryConstructor() {
    }
    
    public CustomerQueryConstructor(CriteriaBuilder cb) {
    	this.cb = cb;
    }
    
    public CriteriaQuery<Customer> queryCustomer(String keyword, String sortItem, String sortType) {
    	
    	// To create a typesafe query, specify the type of the query when you create the CriteriaQuery object.
    	CriteriaQuery<Customer> cq = cb.createQuery(Customer.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query:
    	Root<Customer> customer = cq.from(Customer.class);
    	// Call the select method of the query object, passing in the query root, to set the SELECT clause of the query:
    	cq.select(customer);
    	
    	// CONCAT(... ALL ATTRIBUTES) = '%keyword%'
    	if (!keyword.equals("")) {
	    	List<Expression<String>> expressions = setAll(customer);
	    	Expression<String> stringConcat = concat("", expressions);
	    	cq.where(cb.like(stringConcat, "%"+keyword+"%"));
    	}
    	
    	// ORDER BY specific_column
    	sortItem = validateColumnName(sortItem);
    	Order queryOrder = null;
    	if (!sortType.equals("")) {
    		if (sortItem.equals("salesrepresentativeno"))
    			queryOrder = cb.asc(customer.get("employee").get("employeenumber"));
    		else
    			queryOrder = cb.asc(customer.get(sortItem));
    	}
    	if (sortType.equals("ASC")) {
    		cq.orderBy(queryOrder);
    	} else if (sortType.equals("DESC")) {
    		queryOrder.reverse();
    		cq.orderBy(queryOrder);
    	}
    			
    	return cq;
    }
    
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
    	Expression<String> salesrepresentativeno = customer.get(Customer_.employee).get("employeenumber");
    	
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
    
    private Expression<String> concat(String delimiter, List<Expression<String>> expressions) {
        Expression<String> result = null;
        for (int i = 0; i < expressions.size(); i++) {
            final boolean first = i == 0, last = i == (expressions.size() - 1);
            final Expression<String> expression = expressions.get(i);
            if (first && last) {
                result = expression;
            } else if (first) {
                result = cb.concat(expression, delimiter);
            } else {
                result = cb.concat(result, expression);
                if (!last) {
                    result = cb.concat(result, delimiter);
                }
            }
        }
        return result;
    }
}
