package com.order.order.model.memberupdate;


public interface MemberInterface {
	
	public abstract MemberBean update(Integer memberid, String firstname,String lastname,String email
			,String idno,String phone);

}
