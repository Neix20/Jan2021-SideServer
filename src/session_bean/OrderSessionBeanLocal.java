package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Order;

@Local
public interface OrderSessionBeanLocal {
	public List<Order> getAllOrders() throws EJBException;
	public List<Order> getAllOrders(String customernumber) throws EJBException;
	public Order getOrder(String ordernumber) throws EJBException;
	public void addOrder(Order o) throws EJBException;
	public void updateOrder(Order o) throws EJBException;
	public void deleteOrder(Order o) throws EJBException;
	public Integer locateNextPK() throws EJBException;
}
