package utility;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.Expression;

/**
 * Class for the custom CONCAT function that allows concatenation 
 * between string and non-string attributes, which is not supported 
 * by the default CONCAT function.
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
     * Concatenate multiple @parameter expressions together into one expression, 
     * separated by the @parameter delimiter.
     * Reference: https://stackoverflow.com/a/33916872
     */
    public static Expression<String> concat(CriteriaBuilder cb, String delimiter, List<Expression<String>> expressions) {
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
