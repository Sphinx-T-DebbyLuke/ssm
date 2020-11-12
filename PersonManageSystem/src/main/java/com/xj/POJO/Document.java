package com.xj.POJO;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.io.FilenameUtils;

public class Document implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String title;
	private String filename;
	private String remark;
	private Date create_date;
	private User user;
	private String createdateStr;//用户显示给用户的日期
	private String filetype;//显示文件类型
	private String oldfilename;
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
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filetype=FilenameUtils.getExtension(filename);
		this.filename = filename;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getFiletype() {
		return filetype;
	}
	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}
	
	public String getOldfilename() {
		return oldfilename;
	}
	public void setOldfilename(String oldfilename) {
		this.oldfilename = oldfilename;
	}
	@Override
	public String toString() {
		return "Document [id=" + id + ", title=" + title + ", filename=" + filename + ", remark=" + remark
				+ ", create_date=" + create_date + ", user=" + user + ", createdateStr=" + createdateStr + ", filetype="
				+ filetype + ", oldfilename=" + oldfilename + "]";
	}
	

}
