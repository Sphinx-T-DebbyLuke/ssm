package com.xj.Service.Impl;

import com.xj.Mapper.SyslogMapper;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.POJO.Syslog;
import com.xj.POJO.User;
import com.xj.Service.SyslogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
@Service
public class SyslogServiceImpl implements SyslogService {
	@Autowired
	private SyslogMapper syslogmapper;
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Syslog> getSyslogList(PageSize pageSize) {
		Integer totalSyslog = syslogmapper.getTotalSyslog(pageSize);
		pageSize.handledata(totalSyslog);
		return syslogmapper.getSyslogList(pageSize);
	}
	@Override
	public void addSyslog(Syslog syslog,HttpServletRequest req) {
		User u=(User)req.getSession().getAttribute("username");
		syslog.setUser(u);
		Date date=new Date();
		syslog.setCreate_date(date);
		syslogmapper.addSyslog(syslog);
	}

	@Override
	public void deleteSyslogByIds(QueryVo vo) {
		syslogmapper.deleteSyslogByIds(vo);
	}

	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<String> getSyslogtypeList() {
		List<Syslog> syslogtypeList = syslogmapper.getSyslogtypeList();
		List<String> realList=new ArrayList<String>();
		realList.add(syslogtypeList.get(0).getLog_type());
		for(int i=0;i<syslogtypeList.size();i++){
			if(!realList.contains(syslogtypeList.get(i).getLog_type())){
				realList.add(syslogtypeList.get(i).getLog_type());
			}
		}
		return realList;
	}

}
