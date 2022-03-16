package com.product.product.model;

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
public class ProductService {
	@Autowired
	private ProductDAO productDAO;
	
	public ProductService(ProductDAO productDAO) {		
		this.productDAO = productDAO;
	}
	
	public List<ProductBean> select(ProductBean bean) {
		
		List<ProductBean> result = null;
		if (bean != null && bean.getProductid() != null && !bean.getProductid().equals(0)) {
			ProductBean temp = productDAO.select(bean.getProductid());
			if (temp != null) {
				result = new ArrayList<ProductBean>();
				result.add(temp);
			}
		} else {
			result = productDAO.select();
		}
		return result;
		
		
	}
	
	
	public ProductBean insert(ProductBean bean) {
		ProductBean result = null;
		if (bean != null) {
			result = productDAO.insert(bean);
		}
		return result;
	}

	public ProductBean update(ProductBean bean) {
		ProductBean result = null;              
		if (bean != null && bean.getProductid() != null) {
			result = productDAO.update(bean.getProductid(), bean.getProductname(), bean.getProducttype(),
					bean.getProductprice(), bean.getTraveltime(), bean.getState(), 
					bean.getStartdate(), bean.getEnddate(), bean.getProductintro(), bean.getAttention(),
					bean.getMemberrequired());
		}
		return result;
	}

	public boolean delete(ProductBean bean) {
		boolean result = false;
		if (bean != null && bean.getProductid() != null) {
			result = productDAO.delete(bean.getProductid());
		}
		return result;
	}
	
	
public static void main(String[] args) {
		
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		ProductDAO productDAO = new ProductDAOHibernate(sessionFactory);
//		ProductService productService = new ProductService(productDAO);
//		List<ProductBean> selects = productService.select(null);
//		System.out.println("selects=" + selects);
		
//		ProductBean bean = new ProductBean();
//		bean.setProductid(11);
//		List<ProductBean> bean2 = productService.select(bean);
//		System.out.println("selects=" + bean2);
		
//		bean.setProductname("日本一日遊");
//		bean.setProducttype("日本");
//		bean.setProductprice(10);
//		bean.setTraveltime(10.0);
//		bean.setState(10);
//		bean.setStartdate(new Date(System.currentTimeMillis()));
//		bean.setEnddate(new Date(System.currentTimeMillis()));
//		bean.setProductintro("安安");
//		bean.setAttention("注意");
//		bean.setMemberrequired(4);
//		
//		productService.insert(bean);
		
//		productService.delete(bean);
		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
		
	}
	
	
}
