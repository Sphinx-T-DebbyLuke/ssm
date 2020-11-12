package com.xj.POJO;

public class qiandao {
	private Integer currentMon;
	private String nowdataString;
	private Integer qiandaoNum;//可用作修改用户时的id
	private Double salary;
	public Integer getCurrentMon() {
		return currentMon;
	}
	public void setCurrentMon(Integer currentMon) {
		this.currentMon = currentMon;
	}
	public String getNowdataString() {
		return nowdataString;
	}
	public void setNowdataString(String nowdataString) {
		this.nowdataString = nowdataString;
	}
	public Integer getQiandaoNum() {
		return qiandaoNum;
	}
	public void setQiandaoNum(Integer qiandaoNum) {
		this.qiandaoNum = qiandaoNum;
	}
	public Double getSalary() {
		return salary;
	}
	public void setSalary(Double salary) {
		this.salary = salary;
	}
	@Override
	public String toString() {
		return "qiandao [currentMon=" + currentMon + ", nowdataString=" + nowdataString + ", qiandaoNum=" + qiandaoNum
				+ ", salary=" + salary + "]";
	}
	
}
