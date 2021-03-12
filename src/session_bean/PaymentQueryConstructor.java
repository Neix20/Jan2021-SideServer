package session_bean;

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

public class PaymentQueryConstructor {
	    
    private CriteriaBuilder cb;
    // private CriteriaBuilder cb = em.getCriteriaBuilder();
    
    public PaymentQueryConstructor() {
    }
    
    public PaymentQueryConstructor(CriteriaBuilder cb) {
    	this.cb = cb;
    }
    
    public CriteriaQuery<Payment> queryPayment(String keyword, String sortItem, String sortType) {
    	
    	// To create a typesafe query, specify the type of the query when you create the CriteriaQuery object.
    	CriteriaQuery<Payment> cq = cb.createQuery(Payment.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query:
    	Root<Payment> payment = cq.from(Payment.class);
    	// Call the select method of the query object, passing in the query root, to set the SELECT clause of the query:
    	cq.select(payment);
    	
    	// CONCAT(... ALL ATTRIBUTES) = '%keyword%'
    	if (!keyword.equals("")) {
        	List<Expression<String>> expressions = setAll(payment);
        	Expression<String> stringConcat = concat("", expressions);
        	cq.where(cb.like(stringConcat, "%"+keyword+"%"));
    	}

    	// ORDER BY specific_column
    	sortItem = validateColumnName(sortItem);
    	Order queryOrder = null;
    	if (!sortType.equals("")) {
    		if (sortItem.equals("customernumber") || sortItem.equals("checknumber"))
    			queryOrder = cb.asc(payment.get("id").get(sortItem));
    		else if (sortItem.equals("paymentdate")) {
    			queryOrder = cb.asc(payment.get(Payment_.paymentdate).as(Date.class));
    		}
        	else
        		queryOrder = cb.asc(payment.get(sortItem));
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
