package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Office;

@Local
public interface OfficeSessionBeanLocal {
public List<Office> getAllOffices() throws EJBException;
public List<Office> getAllOffices(String employeenumber) throws EJBException;
public Office getOffice(String officecode) throws EJBException;
public void addOffice(Office f) throws EJBException;
public void updateOffice(Office f)throws EJBException;
public void deleteOffice(Office f) throws EJBException;

}
