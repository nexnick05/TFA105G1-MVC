package com.order.orderdetail.model;

import java.time.LocalDateTime;
import java.util.List;

import com.order.order.model.OrderBean;

public interface OrderdetailInterface {
	
	public abstract List<OrderdetailBean> select();
	
	public abstract OrderdetailBean insert(OrderdetailBean bean);

	public abstract OrderdetailBean update(Integer orderdetailno, Integer orderid,
			Integer productid, Integer numberoftraveler, Integer productprice, Integer orderrewardpoints, String specialneeds );

	public abstract OrderdetailBean findByPrimaryKey(Integer orderdetailno);
	
	public abstract List<OrderdetailBean> ProductOrderdetailSelect(Integer productid);
	
	public abstract boolean delete(Integer orderdetailno);
}
