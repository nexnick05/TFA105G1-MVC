package com.product.product.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "PRODUCT")
public class ProductBean implements Serializable{
	
	@Id
	@Column(name="PRODUCT_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer productid;
	
	@Column(name="PRODUCT_NAME")
	private String productname;
	
	@Column(name="PRODUCT_TYPE")
	private String producttype;
	
	@Column(name="PRODUCT_PRICE")
	private Integer productprice;
	
	@Column(name="TRAVEL_TIME")
	private Double traveltime;
	
	@Column(name="STATE")
	private Integer state;
	
	@Column(name="START_DATE")
	private Date startdate;
	
	@Column(name="END_DATE")
	private Date enddate;
	
	@Column(name="PRODUCT_INTRO")
	private String productintro;
	
	@Column(name="ATTENTION")
	private String attention;
	
	@Column(name="MEMBER_REQUIRED")
	private Integer memberrequired;

	@Override
	public String toString() {
		return "ProductBean [productid=" + productid + ", productname=" + productname + ", producttype=" + producttype
				+ ", productprice=" + productprice + ", traveltime=" + traveltime + ", state=" + state + ", startdate="
				+ startdate + ", enddate=" + enddate + ", productintro=" + productintro + ", attention=" + attention
				+ ", memberrequired=" + memberrequired + "]";
	}

	public Integer getProductid() {
		return productid;
	}

	public void setProductid(Integer productid) {
		this.productid = productid;
	}

	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public String getProducttype() {
		return producttype;
	}

	public void setProducttype(String producttype) {
		this.producttype = producttype;
	}

	public Integer getProductprice() {
		return productprice;
	}

	public void setProductprice(Integer productprice) {
		this.productprice = productprice;
	}

	public Double getTraveltime() {
		return traveltime;
	}

	public void setTraveltime(Double traveltime) {
		this.traveltime = traveltime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getProductintro() {
		productintro = productintro.replaceAll("\n", "<br>");
		return productintro;
	}

	public void setProductintro(String productintro) {
		this.productintro = productintro;
	}

	public String getAttention() {
		attention = attention.replaceAll("\n", "<br>");
		return attention;
	}

	public void setAttention(String attention) {
		this.attention = attention;
	}

	public Integer getMemberrequired() {
		return memberrequired;
	}

	public void setMemberrequired(Integer memberrequired) {
		this.memberrequired = memberrequired;
	}

	
	
	
	
	
	
}
