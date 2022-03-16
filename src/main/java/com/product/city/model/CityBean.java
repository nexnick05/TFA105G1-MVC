package com.product.city.model;

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
@Table(name = "CITY")
public class CityBean implements Serializable{
	
	@Id
	@Column(name="CITY_ID")
	private Integer cityid;
	
	@Column(name="CITY")
	private String city;
	
	@Column(name="AREA")
	private String area;

	public Integer getCityid() {
		return cityid;
	}

	public void setCityid(Integer cityid) {
		this.cityid = cityid;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	@Override
	public String toString() {
		return "CityBean [cityid=" + cityid + ", city=" + city + ", area=" + area + "]";
	}

	

	
	
	
}
