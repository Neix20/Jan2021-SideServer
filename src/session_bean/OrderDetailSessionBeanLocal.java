package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Local;

import domain.Orderdetail;
import domain.OrderdetailPK;

@Local
public interface OrderDetailSessionBeanLocal {
	public List<Orderdetail> getAllOrderDetails() throws EJBException;
	public List<Orderdetail> getAllOrderDetails(String ordernumber) throws EJBException;
	public Orderdetail getOrderdetail(OrderdetailPK id) throws EJBException;
	public Orderdetail getOrderdetail(int ordernumber, String productcode) throws EJBException;
	public void addOrderdetail(Orderdetail od) throws EJBException;
	public void updateOrderdetail(Orderdetail od) throws EJBException;
	public void deleteOrderdetail(Orderdetail od) throws EJBException;
}
