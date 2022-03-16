package com.product.productloc.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class ProductLocService {
	@Autowired
	private ProductLocDAO productLocDAO;
	
	public ProductLocService(ProductLocDAO productLocDAO) {		
		this.productLocDAO = productLocDAO;
	}
	
	public List<ProductLocBean> select(ProductLocBean bean) {
		
		List<ProductLocBean> result = null;
		if (bean != null && bean.getLocid() != null && !bean.getLocid().equals(0)) {
			ProductLocBean temp = productLocDAO.select(bean.getLocid());
			if (temp != null) {
				result = new ArrayList<ProductLocBean>();
				result.add(temp);
			}
		} else {
			result = productLocDAO.select();
		}
		return result;
		
		
	}
	
	
	public ProductLocBean insert(ProductLocBean bean) {
		ProductLocBean result = null;
		if (bean != null) {
			result = productLocDAO.insert(bean);
		}
		return result;
	}

	public ProductLocBean update(ProductLocBean bean) {
		ProductLocBean result = null;              
		if (bean != null && bean.getLocid() != null) {
			result = productLocDAO.update(bean.getLocid(), bean.getProductid(), bean.getCityid());
		}
		return result;
	}

	public boolean delete(ProductLocBean bean) {
		boolean result = false;
		if (bean != null && bean.getLocid() != null) {
			result = productLocDAO.delete(bean.getLocid());
		}
		return result;
	}
	
	
public static void main(String[] args) {
		
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		ProductLocDAO productLocDAO = new ProductLocDAOHibernate(sessionFactory);
//		ProductLocService productLocService = new ProductLocService(productLocDAO);
//		List<ProductLocBean> selects = productLocService.select(null);
//		System.out.println("selects=" + selects);
		
//		ProductLocBean bean = new ProductLocBean();
//		bean.setLocid(8080);
//		List<ProductLocBean> bean2 = productLocService.select(bean);
//		System.out.println("selects=" + bean2);
		
//		bean.setProductid(1);
//		bean.setCityid(1);
//		productLocService.insert(bean);
		
//		productLocService.update(bean);
		
//		productLocService.delete(bean);
//		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
		
	}
	
	
}
