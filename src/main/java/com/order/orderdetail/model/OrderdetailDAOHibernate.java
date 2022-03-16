package com.order.orderdetail.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.order.order.model.OrderBean;

@Repository
public class OrderdetailDAOHibernate implements OrderdetailInterface {
	@Autowired
	private SessionFactory sessionFactory;
	public OrderdetailDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	@Override
	public List<OrderdetailBean> select() {
		return getSession().createQuery(
				"FROM OrderdetailBean", OrderdetailBean.class).list();
	}

	@Override
	public OrderdetailBean insert(OrderdetailBean bean) {
		if(bean!=null) {
			getSession().save(bean);
			return bean;
		}
		return null;
	}

	@Override
	public OrderdetailBean update(Integer orderdetailno, Integer orderid, Integer productid, Integer numberoftraveler,
			Integer productprice, Integer orderrewardpoints, String specialneeds) {
		if(orderdetailno!=null) {
			OrderdetailBean temp = getSession().get(OrderdetailBean.class,orderdetailno);
			if(temp!=null) {
				temp.setOrderid(orderid);
				temp.setOrderrewardpoints(orderrewardpoints);
				temp.setProductid(productid);
				temp.setProductprice(productprice);
				temp.setNumberoftraveler(numberoftraveler);
				temp.setSpecialneeds(specialneeds);
				return temp;
			}
		}
		return null;
	}

	@Override
	public OrderdetailBean findByPrimaryKey(Integer orderid) {
		return getSession().get(
				OrderdetailBean.class, orderid);
		}

	@Override
	public boolean delete(Integer orderdetailno) {
		if(orderdetailno!=null) {
			OrderdetailBean temp = getSession().get(OrderdetailBean.class, orderdetailno);
			if(temp!=null) {
				getSession().delete(temp);
				return true;
			}
		}
		return false;
	}

	@Override
	public List<OrderdetailBean> ProductOrderdetailSelect(Integer productid) {
		return this.getSession().createQuery("FROM OrderdetailBean where productid = "+ productid, OrderdetailBean.class).list();
	}

}
