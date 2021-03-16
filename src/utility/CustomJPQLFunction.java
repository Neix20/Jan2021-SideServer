package utility;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Expression;

/**
 * Class for the custom search function that allows searching 
 * between string and non-string attributes, which is not
 * possible if NamedQuery or NamedNative Query is used.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 * 
 * Reference: https://stackoverflow.com/a/33916872
 */
public class CustomJPQLFunction {
	
	public CustomJPQLFunction() {
	}
	
    /**
     * Concatenate multiple LIKE expressions together into one expression, 
     * separated by the OR operator.
     */
    public static Expression<Boolean> constructSearch(String keyword, CriteriaBuilder cb, List<Expression<String>> expressions) {
        Expression<Boolean> result = null;
        for (int i = 0; i < expressions.size(); i++) {
        	if (i == 0)
        		result = cb.like(expressions.get(i), "%"+keyword+"%");
        	result = cb.or(result, cb.like(expressions.get(i), "%"+keyword+"%"));
        }
        return result;
    }
}
