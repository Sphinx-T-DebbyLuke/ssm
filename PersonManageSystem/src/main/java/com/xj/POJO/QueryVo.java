package com.xj.POJO;

import java.util.List;

public class QueryVo {
	private List<Integer> ids;
	private String tableName;
	private List<String> filenameList;

	public List<Integer> getIds() {
		return ids;
	}
	public void setIds(List<Integer> ids) {
		this.ids = ids;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public List<String> getFilenameList() {
		return filenameList;
	}
	public void setFilenameList(List<String> filenameList) {
		this.filenameList = filenameList;
	}

	@Override
	public String toString() {
		return "QueryVo [ids=" + ids + ", tableName=" + tableName + ", filenameList=" + filenameList + "]";
	}

	

	
}
