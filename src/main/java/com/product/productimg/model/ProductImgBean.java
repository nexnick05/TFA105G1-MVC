package com.product.productimg.model;

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
@Table(name = "PRODUCT_IMG")
public class ProductImgBean implements Serializable{
	
	@Id
	@Column(name="IMG_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer imgid;
	
	@Column(name="PRODUCT_ID")
	private Integer productid;
	
	@Column(name="PRODUCT_IMG" , updatable = false, columnDefinition = "LONGBLOB")
	private byte[] productimg;
	
	@Column(name="IMG_NAME")
	private String imgname;
	
	@Override
	public String toString() {
		return "ProductImgBean [imgid=" + imgid + ", productid=" + productid + ", productimg="
				+ Arrays.toString(productimg) + ", imgname=" + imgname + "]";
	}

	public Integer getImgid() {
		return imgid;
	}

	public void setImgid(Integer imgid) {
		this.imgid = imgid;
	}

	public Integer getProductid() {
		return productid;
	}

	public void setProductid(Integer productid) {
		this.productid = productid;
	}

	public byte[] getProductimg() {
		return productimg;
	}

	public void setProductimg(byte[] productimg) {
		this.productimg = productimg;
	}

	public String getImgname() {
		return imgname;
	}

	public void setImgname(String imgname) {
		this.imgname = imgname;
	}
	
	
}
