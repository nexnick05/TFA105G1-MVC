package com.order.order.model;

import java.time.LocalDateTime; 
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class OrderDAOHibernate implements OrderInterface {
	@Autowired
	private SessionFactory sessionFactory;
	//建立getSession()Factory建構值
	public OrderDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	
	//資料庫連線
	public Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}

//	public static void main(String[] args) {
//		getSession()Factory getSession()Factory = HibernateUtil.getgetSession()factory();
//		getSession() getSession() = getSession()Factory.getCurrentgetSession()();
//		Transaction transaction = getSession().beginTransaction();
//		
//		OrderDAO dao = new OrderDAOHibernate(getSession()Factory);
//		List<OrderBean> beans = dao.select();
//		System.out.println("bean="+beans);
//		
//		transaction.commit();
//		getSession().close();
//		getSession()Factory.close();
//	}

	@Override
	public OrderBean select(Integer id) {
		if(id!=null) { //如果id存在
			return getSession().get(OrderBean.class, id);
		}
		return null;
	}
	
	@Override
	public List<OrderBean> select() {
		return this.getSession().createQuery("FROM OrderBean", OrderBean.class).list();
	}
	
	@Override
	public OrderBean insert(OrderBean bean) {
		
		if(bean!=null) { //bean為要新增的資料
//			OrderBean temp = this.getSession().get(OrderBean.class, bean.getOrderid());//temp為資料庫裡的資料
//			if(temp==null) { //如果沒有資料要insert
			//因為我的addOrder.jsp並沒有輸入id的欄位，所以上方兩行不能寫
			
			getSession().save(bean);
				return bean;
			}
		
		return null;
	}
	
	@Override
	public OrderBean update(Integer orderid, Integer memberid,
			String orderdate, Integer orderpriceamount, Integer usedfunpoints) {
		if(orderid!=null) {
			OrderBean temp = getSession().get(OrderBean.class, orderid);//用id去取出VO
			if(temp!=null) {//temp代表整個VO物件
				temp.setMemberid(memberid); //修改PK以外其他欄位的值
				temp.setOrderdate(orderdate);
				temp.setOrderpriceamount(orderpriceamount);
				temp.setUsedfunpoints(usedfunpoints);
				return temp;
			}
		}
		return null;
	}
	
	@Override
	public boolean delete(Integer orderid) {
		if(orderid!=null) {//如果id存在，會用id去抓temp代表整個VO
			OrderBean temp = getSession().get(OrderBean.class, orderid);
			if(temp!=null) {
				getSession().delete(temp);
				return true;
			}
		}
		return false;
	}

	@Override
	public OrderBean findByPrimaryKey(Integer orderid) {
		if(orderid!=null) { //如果id存在
			return getSession().get(OrderBean.class, orderid);
		}
		return null;
	}
	
	@Override
	public OrderBean findByMemberid(Integer memberid) {
		if(memberid!=null) { //如果id存在
			return getSession().get(OrderBean.class, memberid);
		}
		return null;
	}
	
	public List<OrderBean> MemberOrderSelect(Integer memberid) {
		return this.getSession().createQuery("FROM OrderBean where memberid = "+ memberid, OrderBean.class).list();
	}

}
