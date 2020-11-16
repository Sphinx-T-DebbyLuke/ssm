package com.xj.Service.Impl;

import com.xj.Mapper.EmpMapper;
import com.xj.POJO.Employee;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.Service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpMapper empdao;

	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Employee> getEmpList(PageSize pageSize) {
		Integer totolEmpNum = empdao.getTotolEmpNum(pageSize);
		pageSize.handledata(totolEmpNum);
		return empdao.getEmpList(pageSize);
	}
	@Override
	public void EmpAdd(Employee emp) {
		Date date=new Date();
		emp.setCreate_date(date);
		emp.setJobstatus(1);
		empdao.EmpAdd(emp);
	}
	@Override
	public void EmpDeleteByIds(QueryVo vo) {
		empdao.EmpDeleteByIds(vo);
	}
	@Override
	public void EmpUpdateByemp(Employee emp) {
		empdao.EmpUpdateByemp(emp);
	}
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public Employee CheckEmpById(Integer id) {
		return empdao.CheckEmpById(id);
	}
	@Override
	public List<Employee> getallEmpidOrnameTobind() {
		return empdao.getallEmpidOrnameTobind();
	}

}
