package com.product.productcomment.model;

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
public class ProductCommentService {
	@Autowired
	private ProductCommentDAO productCommentDAO;
	
	public ProductCommentService(ProductCommentDAO productCommentDAO) {		
		this.productCommentDAO = productCommentDAO;
	}
	
	public List<ProductCommentBean> select(ProductCommentBean bean) {
		
		List<ProductCommentBean> result = null;
		if (bean != null && bean.getCommentid() != null && !bean.getCommentid().equals(0)) {
			ProductCommentBean temp = productCommentDAO.select(bean.getCommentid());
			if (temp != null) {
				result = new ArrayList<ProductCommentBean>();
				result.add(temp);
			}
		} else {
			result = productCommentDAO.select();
		}
		return result;
		
		
	}
	
	
	public ProductCommentBean insert(ProductCommentBean bean) {
		ProductCommentBean result = null;
		if (bean != null) {
			result = productCommentDAO.insert(bean);
		}
		return result;
	}

	public ProductCommentBean update(ProductCommentBean bean) {
		ProductCommentBean result = null;              
		if (bean != null && bean.getCommentid() != null) {
			result = productCommentDAO.update(bean.getCommentid(), bean.getProductid(), bean.getMemberid(),
					bean.getCommentcontext(), bean.getCommenttime(), bean.getScore(), 
					bean.getCommentrewardpoints());
		}
		return result;
	}

	public boolean delete(ProductCommentBean bean) {
		boolean result = false;
		if (bean != null && bean.getCommentid() != null) {
			result = productCommentDAO.delete(bean.getCommentid());
		}
		return result;
	}
	
	
public static void main(String[] args) {
		
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		ProductCommentDAO productCommentDAO = new ProductCommentDAOHibernate(sessionFactory);
//		ProductCommentService productCommentService = new ProductCommentService(productCommentDAO);
//		List<ProductCommentBean> selects = productCommentService.select(null);
//		System.out.println("selects=" + selects);
		
		ProductCommentBean bean = new ProductCommentBean();
		bean.setCommentid(4);
//		List<ProductCommentBean> bean2 = productCommentService.select(bean);
//		System.out.println("selects=" + bean2);
		
//		bean.setProductid(2);
//		bean.setMemberid(2);
//		bean.setCommentcontext("我我我");
//		bean.setCommenttime(new Timestamp(System.currentTimeMillis()));
//		bean.setScore(10);
//		bean.setCommentrewardpoints(22);
//		bean.setEnddate(new Date(System.currentTimeMillis()));
//		bean.setProductintro("安安");
//		bean.setAttention("注意");
//		bean.setMemberrequired(4);
//		
//		productCommentService.insert(bean);
		
//		productCommentService.update(bean);
		
//		productCommentService.delete(bean);
//		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
//		
	}
	
	
}
