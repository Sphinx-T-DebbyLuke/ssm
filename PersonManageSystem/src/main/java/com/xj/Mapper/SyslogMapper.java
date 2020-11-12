package com.xj.Mapper;

import java.util.List;

import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.POJO.Syslog;
import org.springframework.stereotype.Repository;

@Repository
public interface SyslogMapper {
	//日志列表
	List<Syslog> getSyslogList(PageSize pageSize);
	//日志添加
	void addSyslog(Syslog syslog);
	//定期清理日志与批量删除
	void deleteSyslogByIds(QueryVo vo);
	//查询总条数
	Integer getTotalSyslog(PageSize pageSize);
	//日志类型前端显示
	List<Syslog> getSyslogtypeList();
}
