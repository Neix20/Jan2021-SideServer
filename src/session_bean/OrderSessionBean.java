package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import domain.Order;

/**
 * Session Bean implementation class OrderSessionBean
 */
@Stateless
@LocalBean
public class OrderSessionBean implements OrderSessionBeanLocal {

    @PersistenceContext(unitName = "Jan2021-SideServer")
    EntityManager em;
	
    /**
     * Default constructor. 
     */
    public OrderSessionBean() {
    }
    
	@Override
	public List<Order> getAllOrders() throws EJBException {
		return em.createNamedQuery("Order.findAll", Order.class).getResultList();
	}

	@Override
	public List<Order> getAllOrders(String customernumber) throws EJBException {
		return em.createNamedQuery("Order.findByCustomernumber", Order.class).setParameter(1, customernumber)
				.getResultList();
	}
    
	@Override
	public Order getOrder(String ordernumber) throws EJBException {
		return em.createNamedQuery("Order.findByOrderNumber", Order.class).setParameter(1, ordernumber)
				.getSingleResult();
	}

	@Override
	public void addOrder(Order o) throws EJBException {		
		em.persist(o);
	}
	
	@Override
	public Integer locateNextPK() throws EJBException {
		TypedQuery<Integer> query = em.createNamedQuery("Order.locateNextPK", Integer.class);
		Integer ordernumber = (Integer) query.getSingleResult();
		return ordernumber;
	}
	
	@Override
	public void updateOrder(Order o) throws EJBException {
		em.merge(o);
	}

	@Override
	public void deleteOrder(Order o) throws EJBException {
		em.remove(em.contains(o) ? o : em.merge(o));
	}
}
