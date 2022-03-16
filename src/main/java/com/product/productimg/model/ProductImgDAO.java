package com.product.productimg.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;


public interface ProductImgDAO {

	public abstract ProductImgBean select(Integer imgid);

	public abstract List<ProductImgBean> select();

	public abstract ProductImgBean insert(ProductImgBean bean);

	public abstract ProductImgBean update(Integer imgid, Integer productid, byte[] productimg, 
			String imgname);

	public abstract boolean delete(Integer imgid);
}
