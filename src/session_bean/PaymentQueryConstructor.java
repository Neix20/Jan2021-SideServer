package session_bean;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
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
    
    public CriteriaQuery<Payment> queryPayment(String keyword, String orderItem, String orderType) {
    	
    	// To create a typesafe query, specify the type of the query when you create the CriteriaQuery object.
    	CriteriaQuery<Payment> cq = cb.createQuery(Payment.class);
    	// Call the from method of the query object to set the FROM clause of the query and to specify the root of the query:
    	Root<Payment> customer = cq.from(Payment.class);
    	// Call the select method of the query object, passing in the query root, to set the SELECT clause of the query:
    	cq.select(customer);
    	
    	// CONCAT(... ALL ATTRIBUTES) = '%keyword%'
    	List<Expression<String>> expressions = setAll(customer);
    	Expression<String> stringConcat = concat("", expressions);
    	cq.where(cb.like(stringConcat, "%"+keyword+"%"));
    	
    	// ORDER BY specific_column
    	//TODO Specify specific column
    	if (orderType.equals("ASC")) {
    		// cq.orderBy(cb.asc(customer.get(Payment_.customernumber)));
    	} else if (orderType.equals("DESC")) {
    		// cq.orderBy(cb.desc(customer.get(Payment_.customernumber)));
    	}
    			
    	return cq;
    }
    
    private List<Expression<String>> setAll(Root<Payment> customer) {
    	List<Expression<String>> expressions = new ArrayList<Expression<String>>();
    	Path<PaymentPK> paymentId = customer.get(Payment_.id);
    	Path<Integer> customerNumber = paymentId.get("customernumber");
    	Path<String> checkNumber = paymentId.get("checknumber");
    	
    	// String checknumber = ;
    	Expression<String> customernumber = customerNumber.as(String.class);
    	Expression<String> checknumber = checkNumber;
    	Expression<String> paymentdate = customer.get(Payment_.paymentdate);
    	Expression<String> amount = customer.get(Payment_.amount).as(String.class);	
    	Expression<String> paymentmethod = customer.get(Payment_.paymentmethod);
    	
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
