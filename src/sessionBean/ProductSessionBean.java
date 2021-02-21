package sessionBean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import domain.Product;

/**
 * Session Bean implementation class ProductSessionBean
 */
@Stateless
@LocalBean
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
		return em.createNamedQuery("Product.findAll").getResultList();
	}

	@Override
	public String test() {
		// TODO Auto-generated method stub
		return "Mommy Mommy";
	}

}
