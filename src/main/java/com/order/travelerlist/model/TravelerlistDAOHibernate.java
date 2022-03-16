package com.order.travelerlist.model;

import java.sql.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class TravelerlistDAOHibernate implements TravelerlistInterface {
	@Autowired
	private SessionFactory sessionFactory;

	public TravelerlistDAOHibernate(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public List<TravelerlistBean> select() {
		return this.getSession().createQuery("FROM TravelerlistBean", TravelerlistBean.class).list();
	}

	@Override
	public TravelerlistBean insert(TravelerlistBean bean) {
		if (bean != null) {
			getSession().save(bean);
			return bean;
		}
		return null;
	}

	@Override
	public TravelerlistBean update(Integer travelerlistno, Integer orderdetailno,
			String firstname, String lastname, String gender,Date birthday ,String idno) {
		if (travelerlistno != null) {
			TravelerlistBean temp = this.getSession().get(TravelerlistBean.class, travelerlistno);
			if (temp != null) {
				temp.setTravelerlistno(travelerlistno);
				temp.setOrderdetailno(orderdetailno);
				temp.setFirstname(firstname);
				temp.setLastname(lastname);
				temp.setGender(gender);
				temp.setBirthday(birthday);
				temp.setIdno(idno);
				return temp;
				
			}
		}
		return null;
	}

	@Override
	public TravelerlistBean findByPrimaryKey(Integer orderdetailno) {
			return this.getSession().get(TravelerlistBean.class, orderdetailno);
		}
	


	@Override
	public boolean delete(Integer travelerlistno) {
		if(travelerlistno!=null) {
			TravelerlistBean temp = this.getSession().get(TravelerlistBean.class, travelerlistno);
			if(temp!=null) {
				this.getSession().delete(temp);
				return true;
			}
		}
		return false;
	}

}
