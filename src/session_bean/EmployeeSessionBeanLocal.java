package session_bean;

import javax.ejb.EJBException;

import domain.Employee;

public interface EmployeeSessionBeanLocal {
//    public List<Employee> getAllEmployee() throws EJBException;

    public Employee findEmployee(String employee_id) throws EJBException;

//    public List<Employee> readEmployee(int currentPage, int recordsPerPage, String keyword) throws EJBException;
//
//    public int getNumberOfRows(String keyword) throws EJBException;

//    public void updateEmployee(String[] s) throws EJBException;
//
//    public void deleteEmployee(String employee_id) throws EJBException;
//
//    public void addEmployee(String[] s) throws EJBException;
}
