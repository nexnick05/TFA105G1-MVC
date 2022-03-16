package com.order.order.model.memberupdate;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class MemberService {

	@Autowired
	private MemberDAO memberDao;

	public MemberService(MemberDAO memberDao) {
		this.memberDao = memberDao;
	}


	public MemberBean update(MemberBean bean) {
		MemberBean result = null;
		if (bean != null && bean.getMemberid() != null) {
			result = memberDao.update(bean.getMemberid(), bean.getFirstname(), bean.getLastname(), bean.getEmail(), bean.getIdno(),
					bean.getPhone());
		}
		return result;

	}
	
}
