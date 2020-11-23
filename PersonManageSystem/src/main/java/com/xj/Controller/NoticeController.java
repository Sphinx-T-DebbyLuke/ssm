package com.xj.Controller;

import com.xj.POJO.*;
import com.xj.Service.NoticeService;
import com.xj.Service.SyslogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value="/Notice")
public class NoticeController {
	@Autowired
	private NoticeService noticeservice;
	@Autowired
	private SyslogService logservice;

	@RequestMapping(value="/NotList.action")
	public String NoticeList(PageSize pageSize,Model model){
		List<Notice> noticeList = null;
		try {
			noticeList = noticeservice.getNoticeList(pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pageSize.setNoticelist(noticeList);
		model.addAttribute("pageSize", pageSize);
		String uri="Notice";
		if(pageSize.getTableName()!=null){
			uri="UserCenter";
		}
		return uri;
	}
	@RequestMapping(value="/NotAdd.action")
	public String NoticeAdd(Notice notice,HttpServletRequest req){
		try {
			Syslog syslog=new Syslog("公告管理","添加了["+notice.getTitle()+"]通知");
			logservice.addSyslog(syslog, req);
			User user = (User) req.getSession().getAttribute("username");
			notice.setUser(user);
			noticeservice.addNotice(notice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/Notice/NotList.action";
	}
	//根据id查询公告信息
	@RequestMapping(value="/CheckNotById.action")
	public @ResponseBody Notice CheckNotById(Integer id){
		return noticeservice.CheckNotById(id);
	}
	//修改公告信息
	@RequestMapping(value="/NotUpdate.action")
	public @ResponseBody String NotUpdate(Notice notice,HttpServletRequest req){
		try {
			noticeservice.NotUpdate(notice);
			Syslog syslog=new Syslog("公告管理","修改了["+notice.getTitle()+"]的通知信息");
			logservice.addSyslog(syslog, req);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	//批量删除公告
	@RequestMapping(value="/DeleteNotByIds.action")
	public String DeleteNotByIds(QueryVo vo,HttpServletRequest req){
		String logdetail="";
		for (int i=0;i<vo.getIds().size();i++) {
			Notice checkNotById = noticeservice.CheckNotById(vo.getIds().get(i));
			if(i==0){
				logdetail+=checkNotById.getTitle();
			}else{
				logdetail+=","+checkNotById.getTitle();
			}
		}
		Syslog syslog=new Syslog("公告管理","删除了["+logdetail+"]的通知信息");
		try {
			logservice.addSyslog(syslog,req);

			noticeservice.DeleteNotByIds(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/Notice/NotList.action";
	}
}
