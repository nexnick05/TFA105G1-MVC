package com.product.productloc.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PRODUCT_LOC")
public class ProductLocBean implements Serializable{
	
	@Id
	@Column(name="LOC_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer locid;
	
	@Column(name="PRODUCT_ID")
	private Integer productid;
	
	@Column(name="CITY_ID")
	private Integer cityid;

	public Integer getLocid() {
		return locid;
	}

	public void setLocid(Integer locid) {
		this.locid = locid;
	}

	public Integer getProductid() {
		return productid;
	}

	public void setProductid(Integer productid) {
		this.productid = productid;
	}

	public Integer getCityid() {
		return cityid;
	}

	public void setCityid(Integer cityid) {
		this.cityid = cityid;
	}

	@Override
	public String toString() {
		return "ProductLocBean [locid=" + locid + ", productid=" + productid + ", cityid=" + cityid + "]";
	}


	
	
	
}
