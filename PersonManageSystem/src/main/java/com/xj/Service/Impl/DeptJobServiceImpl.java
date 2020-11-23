package com.xj.Service.Impl;

import com.xj.Mapper.DeptJobMapper;
import com.xj.POJO.Dept;
import com.xj.POJO.Job;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.Service.DeptJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
@Service
public class DeptJobServiceImpl implements DeptJobService {
	@Autowired
	private DeptJobMapper deptdao;

	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Dept> getDeptJobList(PageSize pageSize) {
		Integer totolDept = deptdao.getTotolDeptJob(pageSize);
		pageSize.handledata(totolDept);
		return deptdao.getDeptJobList(pageSize);
	}
	@Override
	public void DeptJobAdd(Dept dept) {
		deptdao.DeptJobAdd(dept);
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Dept> getDeptJobByTableName(String tableName) {
		return deptdao.getDeptJobByTableName(tableName);
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public Job getDeptJobById(Job dept) {
		return deptdao.getDeptJobById(dept);
	}
	@Override
	public void updateDeptJobInfo(Job dept) {
		deptdao.updateDeptJobInfo(dept);
	}
	@Override
	public void deleteDeptJobByids(QueryVo vo) {
		deptdao.deleteDeptJobByids(vo);
	}
}
