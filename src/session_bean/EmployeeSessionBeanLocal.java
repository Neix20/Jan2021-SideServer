package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Employee;

@Local
public interface EmployeeSessionBeanLocal {
	  public List<Employee> getAllEmployee() throws EJBException;
	
	  public Employee findEmployee(String employee_id) throws EJBException;
	  
	  public List<String> getAllEmails() throws EJBException;
	  
	  public Employee findEmployeeByEmail(String email) throws EJBException;
	  
	  public Employee getEmployee(String employee_id) throws EJBException;
	
	  public List<Employee> readEmployee(int currentPage, int recordsPerPage, String keyword) throws EJBException;
	
      public void updateEmployee(Employee e) throws EJBException;
	
	  public void deleteEmployee(Employee e) throws EJBException;
	
	  public void addEmployee(Employee e) throws EJBException;
}
