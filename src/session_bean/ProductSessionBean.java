package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import domain.Product;
import utility.Sql_Statement_Generator;

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
    }

	@Override
	public List<Product> getAllProduct() throws EJBException {
		return em.createNamedQuery("Product.findAll", Product.class)
				.getResultList();
	}

	@Override
	public Product getProduct(String productcode) throws EJBException {
		return em.createNamedQuery("Product.findByProductcode", Product.class)
				.setParameter(1, productcode)
				.getSingleResult();
	}

	@Override
	public List<Product> getSearchResult(String keyword) throws EJBException {
		return em.createNamedQuery("Product.findByKeyword", Product.class)
				.setParameter(1, "%" + keyword + "%")
				.getResultList();
	}

	@Override
	public void addProduct(Product p) throws EJBException {
		em.persist(p);
	}

	@Override
	public void updateProduct(Product p) throws EJBException {
		em.merge(p);
	}

	@Override
	public void deleteProduct(Product p) throws EJBException {
		em.remove(em.contains(p) ? p : em.merge(p));
	}

	@Override
	public List<Product> getProductList(String[] category, String sort) throws EJBException {
		String text = "SELECT p FROM Product p " 
					+ Sql_Statement_Generator.productline_category(category)
					+ Sql_Statement_Generator.order_clause(sort);
		return em.createQuery(text, Product.class)
			.getResultList();
	}
}
