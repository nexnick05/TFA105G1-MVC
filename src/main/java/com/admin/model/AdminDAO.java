package com.admin.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.order.order.model.OrderBean;

@Repository
public class AdminDAO implements AdminDAOInterface {
	@Autowired
	private SessionFactory sessionFactory;

	public AdminDAO(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public AdminVO insert(AdminVO admin) {
		this.getSession().save(admin);
		return admin;
	}

	@Override
	public boolean delete(Integer empno) {
		if (empno != null) {
			AdminVO temp = this.getSession().get(AdminVO.class, empno);
			if (temp != null) {
				this.getSession().delete(temp);
				return true;
			}
		}
		return false;
	}

	@Override
	public AdminVO update(AdminVO admin) {
		if (admin.getEmpno() != null) {
			AdminVO temp = this.getSession().get(AdminVO.class, admin.getEmpno());
			if (temp != null) {
				temp.setEname(admin.getEname());
				temp.setAccount(admin.getAccount());
//				temp.setPassword(admin.getPassword());
				return temp;
			}
		}
		return null;
	}

	@Override
	public AdminVO select(Integer empno) {
		if (empno != null) {
			return this.getSession().get(AdminVO.class, empno);
		}
		return null;
	}

	@Override
	public AdminVO selectAccount(AdminVO admin) {
		String account = admin.getAccount();
		String password = admin.getPassword();

		String hql = "from AdminVO where account = :account AND password = :password";
		Query<AdminVO> query = this.getSession().createQuery(hql, AdminVO.class).setParameter("account", account)
				.setParameter("password", password);
		AdminVO result = query.uniqueResult();
		return result;
	}

	@Override
	public List<AdminVO> select() {
		return this.getSession().createQuery("FROM AdminVO", AdminVO.class).list();
	}

}
