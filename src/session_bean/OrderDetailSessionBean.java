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
    }
    
    @Override
	public List<Orderdetail> getAllOrderDetails() throws EJBException {
		return em.createNamedQuery("Orderdetail.findAll", Orderdetail.class)
				.getResultList();
	}

	@Override
	public List<Orderdetail> getAllOrderDetails(String ordernumber) throws EJBException {
		return em.createNamedQuery("Orderdetail.findByOrderNumber", Orderdetail.class)
				.setParameter(1, ordernumber)
				.getResultList();
	}

	@Override
	public Orderdetail getOrderdetail(OrderdetailPK id) throws EJBException {
		return em.createNamedQuery("Orderdetail.findByOrderNumberAndProductCode", Orderdetail.class)
				.setParameter(1, id.getOrdernumber())
				.setParameter(2, id.getProductcode())
				.getSingleResult();
	}

	@Override
	public void addOrderdetail(Orderdetail od) throws EJBException {
		em.persist(od);
	}

	@Override
	public void updateOrderdetail(Orderdetail od) throws EJBException {
		em.merge(od);
	}

	@Override
	public void deleteOrderdetail(Orderdetail od) throws EJBException {
		em.remove(em.contains(od) ? od : em.merge(od));
	}

	@Override
	public Orderdetail getOrderdetail(int ordernumber, String productcode) throws EJBException {
		return em.createNamedQuery("Orderdetail.findByOrderNumberAndProductCode", Orderdetail.class)
				.setParameter(1, ordernumber)
				.setParameter(2, productcode)
				.getSingleResult();
	}
}
