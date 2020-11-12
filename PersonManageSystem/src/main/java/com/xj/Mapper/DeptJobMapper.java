package com.xj.Mapper;

import com.xj.POJO.Dept;
import com.xj.POJO.Job;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeptJobMapper {
	//部门职位列表
	List<Dept> getDeptJobList(PageSize pageSize);
	//总记录数
	Integer getTotolDeptJob(PageSize pageSize);
	//添加部门或职位
	void DeptJobAdd(Dept dept);
	//根据表名查部门和职位名称
	List<Dept> getDeptJobByTableName(String tableName);
	//根据id查信息
	Job getDeptJobById(Job dept);
	//修改信息
	void updateDeptJobInfo(Job dept);
	//批量删除
	void deleteDeptJobByids(QueryVo vo);
}
