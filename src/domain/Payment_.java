package domain;

import java.math.BigDecimal;

import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(Payment.class)
public class Payment_ {
	public static volatile SingularAttribute<Payment, PaymentPK> id;
	public static volatile SingularAttribute<Payment, String> paymentdate;
	public static volatile SingularAttribute<Payment, BigDecimal> amount;
	public static volatile SingularAttribute<Payment, String> paymentmethod;
	public static volatile SingularAttribute<Payment, Customer> customer;
}
