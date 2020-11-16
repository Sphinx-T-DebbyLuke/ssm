package com.xj.Controller;

import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.POJO.Syslog;
import com.xj.POJO.User;
import com.xj.Service.SyslogService;
import com.xj.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping(value="/log")
public class SyslogController {
	@Autowired
	private UserService userservice;
	@Autowired
	private SyslogService sysservice;

	//日志列表
	@RequestMapping(value="/sysloglist.action")
	public String sysloglist(PageSize pageSize,Model model){
		try {
			List<Syslog> syslogList = sysservice.getSyslogList(pageSize);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("syslogList", syslogList);
			//日志类型
			List<String> syslogtypeList = sysservice.getSyslogtypeList();
			model.addAttribute("syslogtypeList", syslogtypeList);
			//操作人
			List<User> userListIdName = userservice.getUserListIdName();
			model.addAttribute("userListIdName", userListIdName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Syslog";
		
	}
	//清理日志
	@RequestMapping(value="/DeleteNotByIds.action")
	public String deletelogByIds(QueryVo vo){
		try {
			sysservice.deleteSyslogByIds(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/log/sysloglist.action";
		
	}
}
