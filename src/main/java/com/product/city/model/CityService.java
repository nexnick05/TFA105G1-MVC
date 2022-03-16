package com.product.city.model;

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
public class CityService {
	@Autowired
	private CityDAO cityDAO;
	
	public CityService(CityDAO cityDAO) {		
		this.cityDAO = cityDAO;
	}
	
	public List<CityBean> select(CityBean bean) {
		
		List<CityBean> result = null;
		if (bean != null && bean.getCityid() != null && !bean.getCityid().equals(0)) {
			CityBean temp = cityDAO.select(bean.getCityid());
			if (temp != null) {
				result = new ArrayList<CityBean>();
				result.add(temp);
			}
		} else {
			result = cityDAO.select();
		}
		return result;
		
		
	}
	
	
	public CityBean insert(CityBean bean) {
		CityBean result = null;
		if (bean != null) {
			result = cityDAO.insert(bean);
		}
		return result;
	}

	public CityBean update(CityBean bean) {
		CityBean result = null;              
		if (bean != null && bean.getCityid() != null) {
			result = cityDAO.update(bean.getCityid(), bean.getCity(), bean.getArea());
		}
		return result;
	}

	public boolean delete(CityBean bean) {
		boolean result = false;
		if (bean != null && bean.getCityid() != null) {
			result = cityDAO.delete(bean.getCityid());
		}
		return result;
	}
	
	
public static void main(String[] args) {
		
//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
//		
//		CityDAO cityDAO = new CityDAOHibernate(sessionFactory);
//		CityService cityService = new CityService(cityDAO);
//		List<CityBean> selects = cityService.select(null);
//		System.out.println("selects=" + selects);
		
		CityBean bean = new CityBean();
		bean.setCityid(6);
//		List<CityBean> bean2 = cityService.select(bean);
//		System.out.println("selects=" + bean2);
		
		bean.setCity("埔里");
		bean.setArea("中部");
//		cityService.insert(bean);
		
//		cityService.update(bean);
		
//		cityService.delete(bean);
//		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();
		
	}
	
	
}
