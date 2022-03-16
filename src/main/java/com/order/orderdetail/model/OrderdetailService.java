package com.order.orderdetail.model;

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
public class OrderdetailService {
	@Autowired
	private OrderdetailDAOHibernate orderdetailDao;

	public OrderdetailService(OrderdetailDAOHibernate orderdetailDao) {
		this.orderdetailDao = orderdetailDao;
	}
	
//	public static void main(String[] args) {
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		OrderdetailService svc = new OrderdetailService(new OrderdetailDAOHibernate(sessionFactory));
//		
//		OrderdetailBean bean = new OrderdetailBean();
//		bean.setOrderdetailno(4);
//		boolean delete = svc.delete(bean);
//		System.out.println("測試成功");
//		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
//	}

	public List<OrderdetailBean> select(OrderdetailBean bean) {
		List<OrderdetailBean> result = null;
		if (bean != null && bean.getOrderdetailno() != null && !bean.getOrderdetailno().equals(0)) {
			OrderdetailBean temp = orderdetailDao.findByPrimaryKey(bean.getOrderdetailno());//getOrderdetailno更改
			if (temp != null) {
				result = new ArrayList<OrderdetailBean>();
				result.add(temp);
			}
		} else {
			result = orderdetailDao.select();
		}
		return result;
	}
	
	public OrderdetailBean insert(OrderdetailBean bean) {
		OrderdetailBean result = null;
		if(bean!=null) {
			result = orderdetailDao.insert(bean);
		}
		return result;
	}
	
	public OrderdetailBean update(OrderdetailBean bean) {
		OrderdetailBean result = null;
		if(bean!=null && bean.getOrderdetailno()!=null) {
			result = orderdetailDao.update(bean.getOrderdetailno(), bean.getOrderid(), bean.getProductid(), bean.getNumberoftraveler(), bean.getProductprice(), bean.getOrderrewardpoints(), bean.getSpecialneeds());
		}
		return result;
	}
	
	public boolean delete(OrderdetailBean bean) {
		boolean result = false;
		if(bean!=null && bean.getOrderdetailno()!=null) {
			result = orderdetailDao.delete(bean.getOrderdetailno());
		}
		return false;
	}
	
	public OrderdetailBean getOneOrderdetail(Integer orderid) {
		return orderdetailDao.findByPrimaryKey(orderid);
	}
	
	public List<OrderdetailBean> getProductOrderdetail(Integer productid){
		return (List<OrderdetailBean>) orderdetailDao.ProductOrderdetailSelect(productid);
	}

}
