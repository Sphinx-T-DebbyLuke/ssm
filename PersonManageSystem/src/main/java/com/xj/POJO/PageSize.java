package com.xj.POJO;

import java.io.Serializable;
import java.util.List;

/*
 * 分页
 */
public class PageSize implements Serializable{
	private static final long serialVersionUID = 1L;
	private Integer operateId;//操作人
	private String loginname;//用户名,日志类型
	private String username;//身份,日期
	private Integer currentPage=1;//当前页
	private Integer perPageSize=4;//每页数量
	private Integer totolPage;//总记录数
	private Integer startRow;//开始行
	private Integer totalPageSize;//总页数
	private String tableName;//表名
	private Employee emp;
	private List<User> userlist;
	private List<Dept> deptlist;
	private List<Employee> emplist;
	private List<Notice> noticelist;
	private List<Document> documentList;
	public Integer getOperateId() {
		return operateId;
	}
	public void setOperateId(Integer operateId) {
		this.operateId = operateId;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getPerPageSize() {
		return perPageSize;
	}
	public void setPerPageSize(Integer perPageSize) {
		this.perPageSize = perPageSize;
	}
	public Integer getTotolPage() {
		return totolPage;
	}
	public void setTotolPage(Integer totolPage) {
		this.totolPage = totolPage;
	}
	public Integer getStartRow() {
		return startRow;
	}
	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}
	public List<User> getUserlist() {
		return userlist;
	}
	public void setUserlist(List<User> userlist) {
		this.userlist = userlist;
	}
	public Integer getTotalPageSize() {
		return totalPageSize;
	}
	public void setTotalPageSize(Integer totalPageSize) {
		this.totalPageSize = totalPageSize;
	}
	public Employee getEmp() {
		return emp;
	}
	public void setEmp(Employee emp) {
		this.emp = emp;
	}
	public List<Dept> getDeptlist() {
		return deptlist;
	}
	public void setDeptlist(List<Dept> deptlist) {
		this.deptlist = deptlist;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public List<Employee> getEmplist() {
		return emplist;
	}
	public void setEmplist(List<Employee> emplist) {
		this.emplist = emplist;
	}
	public List<Notice> getNoticelist() {
		return noticelist;
	}
	public void setNoticelist(List<Notice> noticelist) {
		this.noticelist = noticelist;
	}
	public List<Document> getDocumentList() {
		return documentList;
	}
	public void setDocumentList(List<Document> documentList) {
		this.documentList = documentList;
	}
	@Override
	public String toString() {
		return "PageSize [ emp=" + emp + "]";
	}
	public void handledata(Integer totolPage){
		this.totolPage=totolPage;
		if(this.currentPage<1){
			this.currentPage=1;
		}
		this.startRow=(this.currentPage-1)*this.perPageSize;
		if(this.totolPage%this.perPageSize==0){
			this.totalPageSize=this.totolPage/this.perPageSize;
		}else{
			this.totalPageSize=this.totolPage/this.perPageSize+1;
		}
	}
}
