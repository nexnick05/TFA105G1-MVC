package com.order.orderdetail.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "order_detail")
public class OrderdetailBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ORDER_DETAIL_NO")
	private Integer orderdetailno;
	@Column(name = "ORDER_ID")
	private Integer orderid;
	@Column(name = "PRODUCT_ID")
	private Integer productid;
	@Column(name = "NUMBER_OF_TRAVELER")
	private Integer numberoftraveler;
	@Column(name = "PRODUCT_PRICE")
	private Integer productprice;
	@Column(name = "ORDER_REWARD_POINTS")
	private Integer orderrewardpoints;
	@Column(name = "SPECIAL_NEEDS")
	private String specialneeds;
	@Column(name = "IMG_ID")
	private Integer imgid;

	public Integer getImgid() {
		return imgid;
	}

	public void setImgid(Integer imgid) {
		this.imgid = imgid;
	}

	public Integer getOrderdetailno() {
		return orderdetailno;
	}

	public void setOrderdetailno(Integer orderdetailno) {
		this.orderdetailno = orderdetailno;
	}

	public Integer getOrderid() {
		return orderid;
	}

	public void setOrderid(Integer orderid) {
		this.orderid = orderid;
	}

	public Integer getProductid() {
		return productid;
	}

	public void setProductid(Integer productid) {
		this.productid = productid;
	}

	public Integer getNumberoftraveler() {
		return numberoftraveler;
	}

	public void setNumberoftraveler(Integer numberoftraveler) {
		this.numberoftraveler = numberoftraveler;
	}

	public Integer getProductprice() {
		return productprice;
	}

	public void setProductprice(Integer productprice) {
		this.productprice = productprice;
	}

	public Integer getOrderrewardpoints() {
		return (int) (Math.round(productprice*0.01));
//		return orderrewardpoints;
	}

	public void setOrderrewardpoints(Integer orderrewardpoints) {
		this.orderrewardpoints = orderrewardpoints;
	}

	public String getSpecialneeds() {
		return specialneeds;
	}

	public void setSpecialneeds(String specialneeds) {
		this.specialneeds = specialneeds;
	}

	@Override
	public String toString() {
		return "OrderdetailBean [orderdetailno=" + orderdetailno + ", orderid=" + orderid + ", productid=" + productid
				+ ", numberoftraveler=" + numberoftraveler + ", productprice=" + productprice + ", orderrewardpoints="
				+ orderrewardpoints + ", specialneeds=" + specialneeds + ", imgid=" + imgid + "]";
	}


	


	
	

}
