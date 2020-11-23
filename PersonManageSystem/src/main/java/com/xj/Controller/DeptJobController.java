package com.xj.Controller;

import com.xj.POJO.*;
import com.xj.Service.DeptJobService;
import com.xj.Service.SyslogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value="/DeptJob")
public class DeptJobController {
	@Autowired
	private DeptJobService deptService;
	@Autowired
	private SyslogService logservice;

	@RequestMapping(value="/DeptJobList.action",method={RequestMethod.GET,RequestMethod.POST})
	public String DeptJobList(PageSize pageSize,Model model){
		List<Dept> deptList = null;
		try {
			deptList = deptService.getDeptJobList(pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pageSize.setDeptlist(deptList);
		model.addAttribute("pageSize", pageSize);
		String uri="";
		if("dept_inf".equals(pageSize.getTableName())){
			uri="dept";
		}else if("job_inf".equals(pageSize.getTableName())){
			uri="job";
		}
		return uri;
	}
	@RequestMapping(value="/DeptJobAdd.action")
	public String DeptJobAdd(Dept dept,HttpServletRequest req){
		deptService.DeptJobAdd(dept);
		if("dept_inf".equals(dept.getTableName())){
			Syslog syslog=new Syslog("部门管理","添加了["+dept.getName()+"]部门信息");
			logservice.addSyslog(syslog, req);
		}else if("job_inf".equals(dept.getTableName())){
			Syslog syslog=new Syslog("职位管理","添加了["+dept.getName()+"]职位信息");
			logservice.addSyslog(syslog, req);
		}
		String url= "redirect:/DeptJob/DeptJobList.action?tableName="+dept.getTableName();
		return url;
	}
	//根据id查询信息
	@RequestMapping(value="/getDeptJobById.action")
	public @ResponseBody Job getDeptJobById(Job dept){
		Job d= null;
		try {
			d = deptService.getDeptJobById(dept);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return d;
	}
	//修改信息
	@RequestMapping(value="/updateDeptJobInfo.action")
	public @ResponseBody String updateDeptJobInfo(Job dept,HttpServletRequest req){
		deptService.updateDeptJobInfo(dept);
		if("dept_inf".equals(dept.getTableName())){
			Syslog syslog=new Syslog("部门管理","修改了["+dept.getName()+"]的部门信息");
			logservice.addSyslog(syslog, req);
		}else if("job_inf".equals(dept.getTableName())){
			Syslog syslog=new Syslog("职位管理","修改了["+dept.getName()+"]的职位信息");
			logservice.addSyslog(syslog, req);
		}
		return "success";
	}
	//批量删除
	@RequestMapping(value="/deleteDeptJobInfo.action")
	public String deleteDeptJobInfo(QueryVo vo,HttpServletRequest req){
		try {
			deptService.deleteDeptJobByids(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/DeptJob/DeptJobList.action?tableName="+vo.getTableName();
	}
}
