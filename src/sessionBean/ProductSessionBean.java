package sessionBean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import domain.Product;

/**
 * Session Bean implementation class ProductSessionBean
 */
@Stateless
@LocalBean
@Transactional
public class ProductSessionBean implements ProductSessionBeanLocal {

	@PersistenceContext(unitName = "Jan2021-SideServer")
	EntityManager em;
	 /**
     * Default constructor. 
     */
    public ProductSessionBean() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public List<Product> getAllProduct() throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Product.findAll")
				.getResultList();
	}

	@Override
	public Product getProduct(String productcode) throws EJBException {
		// TODO Auto-generated method stub
		return (Product) em.createNamedQuery("Product.findByProductcode")
				.setParameter(1, productcode)
				.getSingleResult();
	}

	@Override
	public List<Product> getSearchResult(String keyword) throws EJBException {
		// TODO Auto-generated method stub
		return em.createNamedQuery("Product.findByKeyword")
				.setParameter(1, "%" + keyword + "%")
				.getResultList();
	}

	@Override
	public void addProduct(Product p) throws EJBException {
		// TODO Auto-generated method stub
		em.persist(p);
	}

	@Override
	public void updateProduct(Product p) throws EJBException {
		// TODO Auto-generated method stub
		em.merge(p);
	}

	@Override
	public void deleteProduct(Product p) throws EJBException {
		// TODO Auto-generated method stub
		em.remove(em.contains(p) ? p : em.merge(p));
	}
}
