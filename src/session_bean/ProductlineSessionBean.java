package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import domain.Productline;

/**
 * Session Bean implementation class ProductlineSessionBean
 */
@Stateless
@LocalBean
@Transactional
public class ProductlineSessionBean implements ProductlineSessionBeanLocal {

	@PersistenceContext(unitName = "Jan2021-SideServer")
	EntityManager em;
    /**
     * Default constructor. 
     */
    public ProductlineSessionBean() {
    }

	@Override
	public List<Productline> getAllProductline() throws EJBException {
		return em.createNamedQuery("Productline.findAll")
				.getResultList();
	}

	@Override
	public Productline getProductline(String productline) throws EJBException {
		return (Productline) em.createNamedQuery("Productline.findByProductline")
							.setParameter(1, productline)
							.getSingleResult();
	}

	@Override
	public void addProductline(Productline pl) throws EJBException {
		em.persist(pl);
	}

	@Override
	public void updateProductline(Productline pl) throws EJBException {
		em.merge(pl);
	}

	@Override
	public void deleteProductline(Productline pl) throws EJBException {
		em.remove(em.contains(pl) ? pl : em.merge(pl));
	}

	@Override
	public List<Productline> getSearchResult(String keyword) throws EJBException {
		return em.createNamedQuery("Productline.findByKeyword")
				.setParameter(1, "%" + keyword + "%")
				.getResultList();
	}

	

}
