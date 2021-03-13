package domain;

import java.math.BigDecimal;

import javax.persistence.metamodel.ListAttribute;
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
