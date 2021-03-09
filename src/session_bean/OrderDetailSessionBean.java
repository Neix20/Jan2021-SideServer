package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import domain.Orderdetail;
import domain.OrderdetailPK;

/**
 * Session Bean implementation class OrderDetailSessionBean
 */
@Stateless
@LocalBean
@Transactional
public class OrderDetailSessionBean implements OrderDetailSessionBeanLocal {
	
	@PersistenceContext(unitName = "Jan2021-SideServer")
	EntityManager em;

    /**
     * Default constructor. 
     */
    public OrderDetailSessionBean() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<Orderdetail> getAllOrderDetails() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Orderdetail.findAll", Orderdetail.class)
				.getResultList();
	}

	@Override
	public List<Orderdetail> getAllOrderDetails(int ordernumber) throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Orderdetail.findByOrderNumber", Orderdetail.class)
				.setParameter(1, ordernumber)
				.getResultList();
	}

	@Override
	public Orderdetail getOrderdetail(OrderdetailPK id) throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Orderdetail.findByOrderDetailPK", Orderdetail.class)
				.setParameter(1, id)
				.getSingleResult();
	}

	@Override
	public void addOrderdetail(Orderdetail od) throws EJBException {
		// TODO Auto-generated method stub
		em.persist(od);
	}

	@Override
	public void updateOrderdetail(Orderdetail od) throws EJBException {
		// TODO Auto-generated method stub
		em.merge(od);
	}

	@Override
	public void deleteOrderdetail(Orderdetail od) throws EJBException {
		// TODO Auto-generated method stub
		em.remove(em.contains(od) ? od : em.merge(od));
	}

}
