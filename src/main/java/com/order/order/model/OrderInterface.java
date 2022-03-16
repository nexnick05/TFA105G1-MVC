package com.order.order.model;

import java.time.LocalDateTime;
import java.util.List;

public interface OrderInterface {
	
	public abstract OrderBean select(Integer orderid);
	
	public abstract List<OrderBean> select();

	public abstract OrderBean insert(OrderBean bean);

	public abstract OrderBean update(Integer orderid, Integer memberid,
			String orderdate, Integer orderpriceamount, Integer usedfunpoints);

	public abstract OrderBean findByPrimaryKey(Integer orderid);
	
	public abstract OrderBean findByMemberid(Integer memberid );
	
	public abstract boolean delete(Integer orderid);


}
