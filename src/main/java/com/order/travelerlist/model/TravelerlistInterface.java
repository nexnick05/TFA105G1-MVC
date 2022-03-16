package com.order.travelerlist.model;

import java.sql.Date;
import java.util.List;

public interface TravelerlistInterface {
	
		public abstract List<TravelerlistBean> select();
		
		public abstract TravelerlistBean insert(TravelerlistBean bean);

		public abstract TravelerlistBean update(Integer travelerlistno, Integer orderdetailno,
				String firstname, String lastname, String gender,Date birthday ,String idno );

		public abstract TravelerlistBean findByPrimaryKey(Integer travelerlistno);
		
		public abstract boolean delete(Integer travelerlistno);
	}

