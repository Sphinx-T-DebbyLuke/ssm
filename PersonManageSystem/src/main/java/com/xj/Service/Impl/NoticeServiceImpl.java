package com.xj.Service.Impl;

import com.xj.Mapper.NoticeMapper;
import com.xj.POJO.Notice;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.Service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeMapper noticemapper;
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Notice> getNoticeList(PageSize pageSize) {
		Integer totalNotice = noticemapper.getTotalNotice(pageSize);
		pageSize.handledata(totalNotice);
		return noticemapper.getNoticeList(pageSize);
	}
	@Override
	public void addNotice(Notice notice) {
		Date date=new Date();
		notice.setCreate_date(date);
		noticemapper.addNotice(notice);
	}

	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public Notice CheckNotById(Integer id) {
		return noticemapper.CheckNotById(id);
	}

	@Override
	public void NotUpdate(Notice notice) {
		noticemapper.NotUpdate(notice);
	}

	@Override
	public void DeleteNotByIds(QueryVo vo) {
		noticemapper.DeleteNotByIds(vo);
	}

}
