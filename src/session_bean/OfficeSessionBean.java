package session_bean;

import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import domain.Office;

/**
 *Session Bean implementation class OfficeSessionBean
 */
@Stateless
@LocalBean
@Transactional
public class OfficeSessionBean implements OfficeSessionBeanLocal {
	
	@PersistenceContext (unitName="Jan2021-SideServer")
	EntityManager em;
	
	/**
	 * Default constructor.
	 */
	
	public OfficeSessionBean() {
		
	}
	
	@Override
	public List<Office> getAllOffices() throws EJBException{
		return em.createNamedQuery("Office.findAll", Office.class).getResultList();
	}

	@Override
	public List<Office> getAllOffices(String employeenumber) throws EJBException{
		return em.createNamedQuery("Office.findByEmployeenumber", Office.class).setParameter(1,employeenumber).getResultList();
		
	}
	
	@Override
	public Office getOffice(String officecode) throws EJBException{
		return em.createNamedQuery("Office.findByOfficeCode", Office.class).setParameter(1,Integer.valueOf(officecode)).getSingleResult();
	}
	
	@Override 
	public void addOffice(Office f) throws EJBException{
		em.persist(f);
	}
	
	@Override
	public void updateOffice(Office f) throws EJBException{
		em.merge(f);
	}
	
	@Override
	public void deleteOffice(Office f)throws EJBException{
		em.remove(em.contains(f)? f : em.merge(f));
	}
}
