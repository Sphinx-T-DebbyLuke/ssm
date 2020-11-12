package com.xj.POJO;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class User implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String loginname;
	private String password;
	private Integer userstatus;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdate;
	private String username;
	
	private Integer emp_id;
	private String emp_name;
	private String checkNum;
	private Employee emp;
	private String createdateStr;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getUserstatus() {
		return userstatus;
	}
	public void setUserstatus(Integer userstatus) {
		this.userstatus = userstatus;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		this.createdateStr=sdf.format(createdate);
		this.createdate = createdate;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCreatedateStr() {
		return createdateStr;
	}
	public void setCreatedateStr(String createdateStr) {
		this.createdateStr = createdateStr;
	}
	
	public String getCheckNum() {
		return checkNum;
	}
	public void setCheckNum(String checkNum) {
		this.checkNum = checkNum;
	}
	public Employee getEmp() {
		return emp;
	}
	public void setEmp(Employee emp) {
		this.emp = emp;
	}
	public Integer getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(Integer emp_id) {
		this.emp_id = emp_id;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", loginname=" + loginname + ", emp_id=" + emp_id + ", emp_name=" + emp_name
				+ ", emp=" + emp + "]";
	}
	
}
