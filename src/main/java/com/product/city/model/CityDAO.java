package com.product.city.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;


public interface CityDAO {

	public abstract CityBean select(Integer cityid);

	public abstract List<CityBean> select();

	public abstract CityBean insert(CityBean bean);

	public abstract CityBean update(Integer cityid, String city, String area);

	public abstract boolean delete(Integer cityid);
}
