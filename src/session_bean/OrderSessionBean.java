package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import domain.Order;

/**
 * Session Bean implementation class OrderSessionBean
 */
@Stateless
@LocalBean
@Transactional
public class OrderSessionBean implements OrderSessionBeanLocal {

	@PersistenceContext(unitName = "Jan2021-SideServer")
	EntityManager em;

	/**
	 * Default constructor.
	 */
	public OrderSessionBean() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<Order> getAllOrders() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Order.findAll", Order.class).getResultList();
	}

	@Override
	public List<Order> getAllOrders(String customernumber) throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Order.findByCustomernumber", Order.class).setParameter(1, customernumber)
				.getResultList();
	}

	@Override
	public Order getOrder(String ordernumber) throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Order.findByOrderNumber", Order.class).setParameter(1, ordernumber)
				.getSingleResult();
	}

	@Override
	public void addOrder(Order o) throws EJBException {
		// TODO Auto-generated method stub
		em.persist(o);
	}

	@Override
	public void updateOrder(Order o) throws EJBException {
		// TODO Auto-generated method stub
		em.merge(o);
	}

	@Override
	public void deleteOrder(Order o) throws EJBException {
		// TODO Auto-generated method stub
		em.remove(em.contains(o) ? o : em.merge(o));
	}

}
