package com.product.productcomment.model;

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
@Table(name = "PRODUCT_COMMENT")
public class ProductCommentBean implements Serializable{
	
	@Id
	@Column(name="COMMENT_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer commentid;
	
	@Column(name="PRODUCT_ID")
	private Integer productid;
	
	@Column(name="MEMBER_ID")
	private Integer memberid;
	
	@Column(name="COMMENT_CONTEXT")
	private String commentcontext;
	
	@Column(name="COMMENT_TIME")
	private Timestamp commenttime;
	
	@Column(name="SCORE")
	private Integer score;
	
	@Column(name="COMMENT_REWARD_POINTS")
	private Integer commentrewardpoints;

	@Override
	public String toString() {
		return "ProductCommentBean [commentid=" + commentid + ", productid=" + productid + ", memberid=" + memberid
				+ ", commentcontext=" + commentcontext + ", commenttime=" + commenttime + ", score=" + score
				+ ", commentrewardpoints=" + commentrewardpoints + "]";
	}

	public Integer getCommentid() {
		return commentid;
	}

	public void setCommentid(Integer commentid) {
		this.commentid = commentid;
	}

	public Integer getProductid() {
		return productid;
	}

	public void setProductid(Integer productid) {
		this.productid = productid;
	}

	public Integer getMemberid() {
		return memberid;
	}

	public void setMemberid(Integer memberid) {
		this.memberid = memberid;
	}

	public String getCommentcontext() {
		return commentcontext;
	}

	public void setCommentcontext(String commentcontext) {
		this.commentcontext = commentcontext;
	}

	public Timestamp getCommenttime() {
		return commenttime;
	}

	public void setCommenttime(Timestamp commenttime) {
		this.commenttime = commenttime;
	}

	public Integer getScore() {
		return score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Integer getCommentrewardpoints() {
		return commentrewardpoints;
	}

	public void setCommentrewardpoints(Integer commentrewardpoints) {
		this.commentrewardpoints = commentrewardpoints;
	}
	

	
	
	
	
	
	
}
