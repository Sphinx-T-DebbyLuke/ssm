package com.xj.POJO;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Notice implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String title;
	private String content;
	private Date create_date;
	private User user;
	private String createdateStr;//用户显示给用户的日期
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		this.createdateStr=sdf.format(create_date);
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
	@Override
	public String toString() {
		return "Notice [id=" + id + ", title=" + title + ", content=" + content + ", create_date=" + create_date
				+ ", user=" + user + "]";
	}
	
	
}
