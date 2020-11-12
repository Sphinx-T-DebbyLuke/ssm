package com.xj.POJO;

import java.io.Serializable;

public class Job implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String name;
	private String remark;
	private Integer salary;
	private String tableName;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getSalary() {
		return salary;
	}
	public void setSalary(Integer salary) {
		this.salary = salary;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	@Override
	public String toString() {
		return "Job [id=" + id + ", name=" + name + ", remark=" + remark + ", salary=" + salary + "]";
	}
	
	
}
