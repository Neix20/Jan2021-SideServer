package domain;

import java.math.BigDecimal;

import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@StaticMetamodel(Customer.class)
public class Customer_ {
	public static volatile SingularAttribute<Customer, Integer> customernumber;
	public static volatile SingularAttribute<Customer, String> customername;
	public static volatile SingularAttribute<Customer, String> contactlastname;	
	public static volatile SingularAttribute<Customer, String> contactfirstname;
	public static volatile SingularAttribute<Customer, String> phone;
	public static volatile SingularAttribute<Customer, String> addressline1;
	public static volatile SingularAttribute<Customer, String> addressline2;
	public static volatile SingularAttribute<Customer, String> city;
	public static volatile SingularAttribute<Customer, String> state;
	public static volatile SingularAttribute<Customer, String> postalcode;
	public static volatile SingularAttribute<Customer, String> country;
	public static volatile SingularAttribute<Customer, BigDecimal> creditlimit;
	public static volatile SingularAttribute<Customer, String> email;
	public static volatile SingularAttribute<Customer, Employee> employee;
	public static volatile ListAttribute<Customer, Payment> payments;
}
