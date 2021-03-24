package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
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
		TypedQuery<Employee> q = em.createNamedQuery("Employee.findbyId", Employee.class);
		q.setParameter("employee_id", Integer.valueOf(employee_id));
		List<Employee> employees = q.getResultList();
		if (employees.size() == 0)
			return null;
		return employees.get(0);
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
		/*
		 * Handle special case where jfirrelli@classicmodelcars.com is repeated twice in
		 * the database.
		 */
		List<Employee> matchedEmployees = (List<Employee>) query.getResultList();
		Employee trueEmployee = matchedEmployees.get(0);
		if (matchedEmployees.size() == 1)
			return trueEmployee;
		else {
			for (Employee employee : matchedEmployees) {
				if (employee.getJobtitle().equals("Sales Rep")) {
					trueEmployee = employee;
					break;
				}
			}
		}
		return trueEmployee;
	}

	@Override
	public List<Employee> getAllEmployee() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Employee.findAll", Employee.class).getResultList();
	}

	@Override
	public List<Employee> readEmployee(int currentPage, int recordsPerPage, String keyword) throws EJBException {

		int start = currentPage * recordsPerPage - recordsPerPage;
		return em.createNamedQuery("Employee.findByKeyword", Employee.class).setParameter(1, "%" + keyword + "%")
				.getResultList();
	}

	@Override
	public void updateEmployee(Employee e) throws EJBException {
		em.merge(e);
	}

	@Override
	public void deleteEmployee(Employee e) throws EJBException {
		em.remove(em.contains(e) ? e : em.merge(e));
	}

	@Override
	public void addEmployee(Employee e) throws EJBException {
		em.persist(e);
	}

	@Override
	public Employee getEmployee(String employee_id) throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Employee.findbyId", Employee.class).setParameter(1, Integer.valueOf(employee_id))
				.getSingleResult();
	}

}
