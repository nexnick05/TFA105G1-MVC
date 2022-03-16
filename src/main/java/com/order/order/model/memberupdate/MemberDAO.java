package com.order.order.model.memberupdate;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.order.order.model.OrderBean;

@Repository
public class MemberDAO implements MemberInterface{

	@Autowired
	private SessionFactory sessionFactory;
	//建立getSession()Factory建構值
	public MemberDAO(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	//資料庫連線
	public Session getSession() {
		return this.sessionFactory.getCurrentSession();
	}
	
	@Override
	public MemberBean update(Integer memberid, String firstname, String lastname, String email, String idno, String phone) {
		if(memberid!=null) {
			MemberBean temp = getSession().get(MemberBean.class, memberid);//用id去取出VO
			if(temp!=null) {//temp代表整個VO物件
				temp.setEmail(email);; //修改PK以外其他欄位的值
				temp.setFirstname(firstname);
				temp.setIdno(idno);
				temp.setLastname(lastname);
				temp.setPhone(phone);
				return temp;
			}
		}
		return null;
	}
	
	

}
