package com.product.productloc.model;

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
public class ProductLocDAOHibernate implements ProductLocDAO{
	@Autowired
	private SessionFactory sessionFactory;

	public ProductLocDAOHibernate(SessionFactory sessionFactory2) {
		this.sessionFactory = sessionFactory2;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public ProductLocBean select(Integer locid) {
		if (locid != null) {
			return this.getSession().get(ProductLocBean.class, locid);
		}
		return null;
	}

	@Override
	public List<ProductLocBean> select() {
		return this.getSession().createQuery("FROM ProductLocBean", ProductLocBean.class).list();
		
	}

	@Override
	public ProductLocBean insert(ProductLocBean bean) {

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
	public ProductLocBean update(Integer locid, Integer productid, Integer cityid) {
		if (locid != null) {
			ProductLocBean temp = this.getSession().get(ProductLocBean.class, locid);
			if (temp != null) {
				temp.setLocid(locid);
				temp.setProductid(productid);
				temp.setCityid(cityid);
			
				return temp;
			}
		}
		return null;
	}

	@Override
	public boolean delete(Integer locid) {

		if (locid != null) {
			ProductLocBean temp = this.getSession().get(ProductLocBean.class, locid);
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
