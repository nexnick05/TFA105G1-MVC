package com.order.travelerlist.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "traveler_list")
public class TravelerlistBean {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "TRAVELER_LIST_NO")
	private Integer travelerlistno;
	@Column(name = "ORDER_DETAIL_NO")
	private Integer orderdetailno;
	@Column(name = "FIRST_NAME")
	private String firstname;
	@Column(name = "LAST_NAME")
	private String lastname;
	@Column(name = "GENDER")
	private String gender;
	@Column(name = "BIRTHDAY")
	private Date birthday;
	@Column(name = "ID_NO")
	private String idno;

	public Integer getTravelerlistno() {
		return travelerlistno;
	}

	public void setTravelerlistno(Integer travelerlistno) {
		this.travelerlistno = travelerlistno;
	}

	public Integer getOrderdetailno() {
		return orderdetailno;
	}

	public void setOrderdetailno(Integer orderdetailno) {
		this.orderdetailno = orderdetailno;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	
	public String getIdno() {
		return idno;
	}

	public void setIdno(String idno) {
		this.idno = idno;
	}

	@Override
	public String toString() {
		return "TravelerlistBean [travelerlistno=" + travelerlistno + ", orderdetailno=" + orderdetailno
				+ ", firstname=" + firstname + ", lastname=" + lastname + ", gender=" + gender + ", birthday="
				+ birthday + ", idno=" + idno + "]";
	}
}
