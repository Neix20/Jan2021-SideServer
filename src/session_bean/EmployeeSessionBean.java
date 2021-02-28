package session_bean;

import javax.ejb.EJBException;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import domain.Employee;

public class EmployeeSessionBean implements EmployeeSessionBeanLocal {

    @PersistenceContext(unitName = "Jan2021-SideServer")
    EntityManager em;

    @Override
    public Employee findEmployee(String employee_id) throws EJBException {
	Query q = em.createNamedQuery("Employee.findbyId");
	q.setParameter("employee_id", Long.valueOf(employee_id));
	return (Employee) q.getSingleResult();
    }

}
