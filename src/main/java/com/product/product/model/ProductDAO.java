package com.product.product.model;

import java.sql.Date;
import java.util.List;


public interface ProductDAO {

	public abstract ProductBean select(Integer productid);

	public abstract List<ProductBean> select();

	public abstract ProductBean insert(ProductBean bean);

	public abstract ProductBean update(Integer productid, String productname, String producttype, 
			Integer productprice, Double traveltime, Integer state, Date startdate, Date enddate,
			String productintro, String attention, Integer memberrequired);

	public abstract boolean delete(Integer productid);
}
