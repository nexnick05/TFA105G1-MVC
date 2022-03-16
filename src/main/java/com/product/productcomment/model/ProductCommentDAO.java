package com.product.productcomment.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;


public interface ProductCommentDAO {

	public abstract ProductCommentBean select(Integer commentid);

	public abstract List<ProductCommentBean> select();

	public abstract ProductCommentBean insert(ProductCommentBean bean);

	public abstract ProductCommentBean update(Integer commentid, Integer productid, Integer memberid, 
			String commentcontext, Timestamp commenttime, Integer score, Integer commentrewardpoints);

	public abstract boolean delete(Integer commentid);
}
