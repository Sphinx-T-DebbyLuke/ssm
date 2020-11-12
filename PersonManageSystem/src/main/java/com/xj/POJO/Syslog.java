package com.xj.POJO;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class Syslog implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String log_type;
	private String log_detail;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date create_date;
	private User user;
	private String createdateStr;//用户显示给用户的日期
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLog_type() {
		return log_type;
	}
	public void setLog_type(String log_type) {
		this.log_type = log_type;
	}
	public String getLog_detail() {
		return log_detail;
	}
	public void setLog_detail(String log_detail) {
		this.log_detail = log_detail;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.createdateStr=df.format(create_date);
		this.create_date = create_date;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getCreatedateStr() {
		return createdateStr;
	}
	public void setCreatedateStr(String createdateStr) {
		this.createdateStr = createdateStr;
	}
	public Syslog(String log_type,String log_detail) {
		this.log_type=log_type;
		this.log_detail=log_detail;
	}
	public Syslog() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Syslog [id=" + id + ", log_type=" + log_type + ", log_detail=" + log_detail + ", create_date="
				+ create_date + ", user=" + user + "]";
	}
	
	
}
