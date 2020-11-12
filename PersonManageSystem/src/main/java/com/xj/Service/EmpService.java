package com.xj.Service;

import java.util.List;

import com.xj.POJO.Employee;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;

public interface EmpService {
	//员工列表
	List<Employee> getEmpList(PageSize pageSize);
	//添加员工
	void EmpAdd(Employee emp);
	//批量删除
	void EmpDeleteByIds(QueryVo vo);
	//根据id查询员工信息
	Employee CheckEmpById(Integer id);
	//修改信息
	void EmpUpdateByemp(Employee emp);
	//查询所有员工简要信息，用于绑定系统用户
	List<Employee> getallEmpidOrnameTobind();
}
