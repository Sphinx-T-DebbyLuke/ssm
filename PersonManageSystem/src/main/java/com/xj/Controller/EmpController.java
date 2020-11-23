package com.xj.Controller;

import com.xj.POJO.*;
import com.xj.Service.DeptJobService;
import com.xj.Service.EmpService;
import com.xj.Service.SyslogService;
import com.xj.util.imageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping(value="/Emp")
public class EmpController {
	@Autowired
	private EmpService empService;
	@Autowired
	private DeptJobService djService;
	@Autowired
	private SyslogService logservice;
	@Value(value="${table.job}")
	private String jobtableName;
	@Value(value="${table.dept}")
	private String depttableName;

	@RequestMapping(value="/EmpList.action")
	public String EmpList(PageSize pageSize,Model model){
		try {
			List<Employee> empList = empService.getEmpList(pageSize);
			//用于前端下拉框显示
			List<Dept> jobTableList = djService.getDeptJobByTableName(jobtableName);
			List<Dept> deptTableList = djService.getDeptJobByTableName(depttableName);
			pageSize.setEmplist(empList);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("jobTableList", jobTableList);
			model.addAttribute("deptTableList", deptTableList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "employee";
	}
	@RequestMapping(value="/EmpAdd.action")
	public String EmpAdd(Employee emp,HttpServletRequest req){
		try {
			empService.EmpAdd(emp);
			Syslog syslog=new Syslog("员工管理","添加了["+emp.getName()+"]员工");
			logservice.addSyslog(syslog, req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/Emp/EmpList.action";
	}
	//批量删除
	@RequestMapping(value="/EmpDeleteByIds.action")
	public String EmpDeleteByIds(QueryVo vo,HttpServletRequest req){
		String logdetail="";
		for (int i=0;i<vo.getIds().size();i++) {
			Employee checkEmpById = empService.CheckEmpById(vo.getIds().get(i));
			if(i==0){
				logdetail+=checkEmpById.getName();
			}else{
				logdetail+=","+checkEmpById.getName();
			}
		}
		Syslog syslog=new Syslog("员工管理","删除了["+logdetail+"]的员工信息");
		try {
			logservice.addSyslog(syslog,req);
			empService.EmpDeleteByIds(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/Emp/EmpList.action";
	}
	//根据id查询员工信息
	@RequestMapping(value="/CheckEmpById.action")
	public @ResponseBody Employee CheckEmpById(Integer id){
		Employee emp= null;
		try {
			emp = empService.CheckEmpById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return emp;
	}
	//修改信息
	@RequestMapping(value="/EmpUpdateByemp.action")
	public String EmpUpdateByemp(Employee emp,MultipartFile multipartFile,HttpServletRequest req){
		if(multipartFile.getOriginalFilename()!=null&&multipartFile.getOriginalFilename()!=""){
			emp.setImageUrl(multipartFile.getOriginalFilename());
			Employee employee = empService.CheckEmpById(emp.getId());
			if(employee.getImageUrl()!=null){
				String willdeletefile=imageUtil.generateThumbnail(employee.getImageUrl(),emp.getId(),req,"headerImg");
				File deletefile=new File(willdeletefile);
				try {
					deletefile.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			try {
				String headerImg = imageUtil.generateThumbnail(emp.getImageUrl(),emp.getId(), req, "headerImg");
				multipartFile.transferTo(new File(headerImg));
				empService.EmpUpdateByemp(emp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Syslog syslog=new Syslog("员工管理","修改了["+emp.getName()+"]的员工信息");
		try {
			logservice.addSyslog(syslog, req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/Emp/EmpList.action";
	}
}
