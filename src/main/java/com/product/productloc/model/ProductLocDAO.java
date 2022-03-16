package com.product.productloc.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;


public interface ProductLocDAO {

	public abstract ProductLocBean select(Integer locid);

	public abstract List<ProductLocBean> select();

	public abstract ProductLocBean insert(ProductLocBean bean);

	public abstract ProductLocBean update(Integer locid, Integer productid, Integer cityid);

	public abstract boolean delete(Integer locid);
}
