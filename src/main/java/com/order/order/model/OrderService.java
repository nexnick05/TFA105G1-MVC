package com.order.order.model;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.order.orderdetail.model.OrderdetailBean;
import com.order.orderdetail.model.OrderdetailDAOHibernate;
import com.order.orderdetail.model.OrderdetailService;

@Service
@Transactional
public class OrderService { //給參數
	@Autowired
	private OrderDAOHibernate orderDao;
	@Autowired
	private OrderdetailDAOHibernate orderdetailDao;
	
	OrderdetailService orderdetailService = new OrderdetailService(orderdetailDao);
	
	public OrderService(OrderDAOHibernate orderDao) {
		this.orderDao = orderDao;
	}
	
//	public static void main(String[] args) {
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		OrderService orderService =
//				new OrderService(new OrderDAOHibernate(sessionFactory));
//		
//		OrderDAOHibernate orderdaohibernate =
//				new OrderDAOHibernate(sessionFactory);
		
		//查詢
//		List<OrderBean> selects = orderService.select(null);
//		System.out.println("selects="+selects);
		
//		OrderBean bean = new OrderBean();
		
//		新增
//		bean.setOrderid(8);
//		bean.setMemberid(10);
//		bean.setOrderdate(LocalDateTime.now());
//		bean.setOrderpriceamount(100);
//		bean.setUsedfunpoints(100);
		
//		OrderBean selects = orderdaohibernate.insert(bean);
//		System.out.println("selects="+selects);
		
//		刪除
//		bean.setOrderid(7);
//		
//		boolean selects = orderService.delete(bean);
//		System.out.println("selects="+selects);
//		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
//	}
	public List<OrderBean> select(OrderBean bean) {
		List<OrderBean> result = null;
		if(bean!=null && bean.getOrderid()!=null && !bean.getOrderid().equals(0)) {
			OrderBean temp = orderDao.select(bean.getOrderid());
			if(temp!=null) {
				result = new ArrayList<OrderBean>();
				result.add(temp);
			}
		} else {
			result = orderDao.select(); 
		}
		return orderDao.select();
	}
	public OrderBean insert(OrderBean bean) {
		OrderBean result = null;
		if(bean!=null) { // && bean.getOrderid()!=null
			result = orderDao.insert(bean);
		}
		return result;
	}
	public OrderBean update(OrderBean bean) {
		OrderBean result = null;
		if(bean!=null && bean.getOrderid()!=null) {
			result = orderDao.update(bean.getOrderid(), bean.getMemberid(),
					bean.getOrderdate(), bean.getOrderpriceamount(), bean.getUsedfunpoints());
		}
		return result;
	}
	public boolean delete(OrderBean bean) {
		boolean result = false;
		if(bean!=null && bean.getOrderid()!=null) {
			result = orderDao.delete(bean.getOrderid());
		}
		return result;
	}
	public OrderBean getOneOrder(Integer orderid) {
		return orderDao.findByPrimaryKey(orderid);
	}
	
	public List<OrderBean> getMemberOrder(Integer memberid) {
		return  (List<OrderBean>) orderDao.MemberOrderSelect(memberid);
		
//		System.out.println("time = "  );
	}
	
//	public List<OrderdetailBean> getMemberOrder(Integer memberid) {
//		List <OrderdetailBean> orderdetailBean = null;
//		List<OrderBean> orderBean = (List<OrderBean>)orderDao.findByMemberid(memberid);
//		for(int i=0;i<orderBean.size();i++) {
//			
//		 orderdetailBean = (List<OrderdetailBean>)orderdetailDao.findByPrimaryKey(orderBean.get(i).getOrderid());
//		}
//		
//		return orderdetailBean;
////		return orderDao.findByMemberid(memberid);
//	}

}
