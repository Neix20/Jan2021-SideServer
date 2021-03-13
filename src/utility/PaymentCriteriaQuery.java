package utility;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Order;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Root;

import domain.Payment;
import domain.PaymentPK;
import domain.Payment_;

/**
 * Class to construct payment criteria queries. This method allows 
 * more flexibility and customization as compared to NamedQuery or 
 * NamedNativeQuery. For this purpose, I create a custom CONCAT function
 * to allow concatenation between string and non-string attributes, which
 * is not supported by the default CONCAT function.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
public class PaymentCriteriaQuery {
	    
    private CriteriaBuilder cb;
    
    public PaymentCriteriaQuery() {
    }
    
    public PaymentCriteriaQuery(CriteriaBuilder cb) {
    	this.cb = cb;
    }
    
    public CriteriaQuery<Long> getNumberofPayment(String keyword) {
    	
    	// Specify the type of the query to create a type-safe query
    	CriteriaQuery<Long> query = cb.createQuery(Long.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query
    	Root<Payment> payment = query.from(Payment.class);
    	/* Call the select method of the query object, passing in the query root, to set the SELECT clause of the query
    	 * Perform `SELECT COUNT(p.id.customernumber) FROM Payment p`
    	 */
    	query.select(cb.count(payment.get(Payment_.id).get("customernumber")));
    	
    	// Perform `CONCAT(... ALL ATTRIBUTES) = '%keyword%'`
    	if (!keyword.equals("")) {
	    	List<Expression<String>> expressions = setAll(payment);
	    	Expression<String> stringConcat = CustomJPQLFunction.concat(cb, "", expressions);
	    	query.where(cb.like(stringConcat, "%"+keyword+"%"));
    	}

    	return query;
    }
    
    public CriteriaQuery<Payment> findPayment(String keyword, String sortItem, String sortType) {
    	
    	// Specify the type of the query to create a type-safe query
    	CriteriaQuery<Payment> cq = cb.createQuery(Payment.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query
    	Root<Payment> payment = cq.from(Payment.class);
    	/* Call the select method of the query object, passing in the query root, to set the SELECT clause of the query
    	 * Perform `SELECT p FROM Payment p`
    	 */
    	cq.select(payment);
    	
    	// Perform `CONCAT(... ALL ATTRIBUTES) = '%keyword%'`
    	if (!keyword.equals("")) {
        	List<Expression<String>> expressions = setAll(payment);
        	Expression<String> stringConcat = CustomJPQLFunction.concat(cb, "", expressions);
        	cq.where(cb.like(stringConcat, "%"+keyword+"%"));
    	}

    	// Perform `ORDER BY specific_column`
    	sortItem = validateColumnName(sortItem);
    	Order queryOrder = null;
    	if (!sortType.equals("")) {
    		// Handle special case
    		if (sortItem.equals("customernumber") || sortItem.equals("checknumber"))
    			queryOrder = cb.asc(payment.get("id").get(sortItem));
    		// Normal case
    		else if (sortItem.equals("paymentdate")) {
    			queryOrder = cb.asc(payment.get(Payment_.paymentdate).as(Date.class));
    		}
        	else
        		queryOrder = cb.asc(payment.get(sortItem));
    	}
    	if (sortType.equals("ASC")) {
    		cq.orderBy(queryOrder);
    	}
    	// Reverse the order if it is in DESC order
    	else if (sortType.equals("DESC")) {
    		queryOrder.reverse();
    		cq.orderBy(queryOrder);
    	}
    	    			
    	return cq;
    }
    
    /**
     * Ensure that only valid column is returned.
     */
    private String validateColumnName(String sortItem) {
  	
    	switch (sortItem) {
    	case "customernumber":
    		break;
    	case "checknumber":
    		break;
    	case "paymentdate":
    		break;
    	case "amount":
    		break;
    	case "paymentmethod":
    		break;
    	default:
    		sortItem = "customernumber";
    		break;
    	}
    	
    	return sortItem;
    }
    
    /**
     * Get all the attributes of the payment in String. Convert all 
     * non-string attribute into string attribute to perform concatenation.
     */
    private List<Expression<String>> setAll(Root<Payment> payment) {
    	List<Expression<String>> expressions = new ArrayList<Expression<String>>();
    	Path<PaymentPK> paymentId = payment.get(Payment_.id);
    	Path<Integer> customerNumber = paymentId.get("customernumber");
    	Path<String> checkNumber = paymentId.get("checknumber");
    	
    	Expression<String> customernumber = customerNumber.as(String.class);
    	Expression<String> checknumber = checkNumber;
    	Expression<String> paymentdate = payment.get(Payment_.paymentdate);
    	Expression<String> amount = payment.get(Payment_.amount).as(String.class);	
    	Expression<String> paymentmethod = payment.get(Payment_.paymentmethod);
    	
    	expressions.add(customernumber);
    	expressions.add(checknumber);
    	expressions.add(paymentdate);
    	expressions.add(amount);
    	expressions.add(paymentmethod);
    	
    	return expressions;
    }
}