package domain;

import java.math.BigDecimal;

import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

/**
 * Based on Java EE 6 documentation (https://docs.oracle.com/javaee/6/tutorial/doc/gjivm.html),
 * Criteria queries use the metamodel class and its attributes to refer to the managed 
 * entity classes and their persistent state and relationships.
 * 
 * @author  Yap Jheng Khin
 * @version 1.0
 * @since   2021-03-12 
 */
@StaticMetamodel(Payment.class)
public class Payment_ {
	public static volatile SingularAttribute<Payment, PaymentPK> id;
	public static volatile SingularAttribute<Payment, String> paymentdate;
	public static volatile SingularAttribute<Payment, BigDecimal> amount;
	public static volatile SingularAttribute<Payment, String> paymentmethod;
	public static volatile SingularAttribute<Payment, Customer> customer;
}
