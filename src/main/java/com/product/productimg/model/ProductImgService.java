package com.product.productimg.model;

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
public class ProductImgService {
	@Autowired
	private ProductImgDAO productImgDAO;
	
	public ProductImgService(ProductImgDAO productImgDAO) {		
		this.productImgDAO = productImgDAO;
	}
	
	public List<ProductImgBean> select(ProductImgBean bean) {
		
		List<ProductImgBean> result = null;
		if (bean != null && bean.getImgid() != null && !bean.getImgid().equals(0)) {
			ProductImgBean temp = productImgDAO.select(bean.getImgid());
			if (temp != null) {
				result = new ArrayList<ProductImgBean>();
				result.add(temp);
			}
		} else {
			result = productImgDAO.select();
		}
		return result;
		
		
	}
	
	
	public ProductImgBean insert(ProductImgBean bean) {
		ProductImgBean result = null;
		if (bean != null) {
			result = productImgDAO.insert(bean);
		}
		return result;
	}

	public ProductImgBean update(ProductImgBean bean) {
		ProductImgBean result = null;              
		if (bean != null && bean.getImgid() != null) {
			result = productImgDAO.update(bean.getImgid(), bean.getProductid(), bean.getProductimg(),
					bean.getImgname());
		}
		return result;
	}

	public boolean delete(ProductImgBean bean) {
		boolean result = false;
		if (bean != null && bean.getImgid() != null) {
			result = productImgDAO.delete(bean.getImgid());
		}
		return result;
	}
	
	
public static void main(String[] args) {
		
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		ProductImgDAO productImgDAO = new ProductImgDAOHibernate(sessionFactory);
//		ProductImgService productImgService = new ProductImgService(productImgDAO);
//		List<ProductImgBean> selects = productImgService.select(null);
//		System.out.println("selects=" + selects);
//		
//		ProductImgBean bean = new ProductImgBean();
//		bean.setImgid(6);
//		List<ProductImgBean> bean2 = productImgService.select(bean);
//		System.out.println("selects=" + bean2);
		
//		bean.setProductid(1);
//		bean.setImgname("aaaa");
//		productImgService.insert(bean);
		
//		productImgService.update(bean);
		
//		productImgService.delete(bean);
//		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
		
	}
	
	
}
