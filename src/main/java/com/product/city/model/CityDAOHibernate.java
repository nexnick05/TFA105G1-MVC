package com.product.city.model;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class CityDAOHibernate implements CityDAO{
	@Autowired
	private SessionFactory sessionFactory;

	public CityDAOHibernate(SessionFactory sessionFactory2) {
		this.sessionFactory = sessionFactory2;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public CityBean select(Integer cityid) {
		if (cityid != null) {
			return this.getSession().get(CityBean.class, cityid);
		}
		return null;
	}

	@Override
	public List<CityBean> select() {
		return this.getSession().createQuery("FROM CityBean", CityBean.class).list();
		
	}

	@Override
	public CityBean insert(CityBean bean) {

//		if (bean != null && bean.getRecordid() != null) {
//			PostGoodRecordBean temp = this.getSession().get(PostGoodRecordBean.class, bean.getRecordid());
//			if (temp == null) {
				this.getSession().save(bean);
				return bean;
//			}
//		}
//		return null;  這幾行註解掉才會成功 因為PK是自動產生 產生之前根本不可能重複 所以直接加入 或者是要判斷這筆資料是否存在要用別的條件
	}

	@Override
	public CityBean update(Integer cityid, String city, String area) {
		if (cityid != null) {
			CityBean temp = this.getSession().get(CityBean.class, cityid);
			if (temp != null) {
				temp.setCity(city);
				temp.setArea(area);
				temp.setCityid(cityid);
			
				return temp;
			}
		}
		return null;
	}

	@Override
	public boolean delete(Integer cityid) {

		if (cityid != null) {
			CityBean temp = this.getSession().get(CityBean.class, cityid);
			if (temp != null) {
				this.getSession().delete(temp);
				return true;
			}
		}
		return false;
	}
	
	
	public static void main(String[] args) throws IOException {

//		SessionFactory sessionFactory = HibernateUtil.getSessionfactory();
//		Session session = sessionFactory.getCurrentSession();
//		Transaction transaction = session.beginTransaction();
		
//		ProductCommentDAO dao = new ProductCommentDAOHibernate(sessionFactory);
//		List<ProductCommentBean> beans = dao.select();
//		System.out.println("bean=" + beans);
//		
//		PostGoodRecordBean postGoodRecordBean = dao.select(1);
//		System.out.println("bean=" + postGoodRecordBean);
		
//		PostGoodRecordBean productBean2 = new PostGoodRecordBean();
//		productBean2.setMemberid(1);
//		productBean2.setPostid(2);
//		productBean2.setGoodstatus(true);
//		dao.insert(productBean2);
		
//		FileInputStream in = new FileInputStream("C:\\JavaFramework\\eclipse-workspace"
//				+ "\\G1test\\src\\main\\webapp\\images\\08.jpeg") ;
//		byte[] x= new byte[in.available()];
//		in.read(x);
//		dao.update(3, "永和豆漿", 2, "今天跑去台北101看夜景真是太好玩啦!而且裡面的鼎泰豐又很好吃", new Timestamp(System.currentTimeMillis()),
//				0, 5, x, 8);
//		
//		dao.delete(11);
		
//		transaction.commit();
//		session.close();
//		sessionFactory.close();

	}
}
