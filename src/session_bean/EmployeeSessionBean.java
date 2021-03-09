package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import domain.Employee;

/**
 * Session Bean implementation class EmployeeSessionBean
 */
@Stateless
@LocalBean
public class EmployeeSessionBean implements EmployeeSessionBeanLocal {
    
    @PersistenceContext(unitName = "Jan2021-SideServer")
    EntityManager em;
    
    /**
     * Default constructor. 
     */
    public EmployeeSessionBean() {
    }

    @Override
    public Employee findEmployee(String employee_id) throws EJBException {
		Query q = em.createNamedQuery("Employee.findbyId");
		q.setParameter("employee_id", Long.valueOf(employee_id));
		return (Employee) q.getSingleResult();
    }
    
    @Override
    public List<String> getAllEmails() throws EJBException {
		TypedQuery<String> query = em.createNamedQuery("Employee.findAllEmail", String.class);
		List<String> emailList = query.getResultList();
    	return emailList;
    }

	@Override
	public Employee findEmployeeByEmail(String email) throws EJBException {
		TypedQuery<Employee> query = em.createNamedQuery("Employee.findbyEmail", Employee.class);
		query.setParameter("email", email);
		Employee matchedEmployee = (Employee) query.getSingleResult();
    	return matchedEmployee;
	}

}
