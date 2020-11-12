package com.xj.Service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.POJO.Syslog;

public interface SyslogService {
	//日志列表
	List<Syslog> getSyslogList(PageSize pageSize);
	//日志添加
	void addSyslog(Syslog syslog, HttpServletRequest req);
	//定期清理日志与批量删除
	void deleteSyslogByIds(QueryVo vo);
	//日志类型前端显示
	List<String> getSyslogtypeList();
}
