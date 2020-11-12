package com.xj.Service;

import java.util.List;

import com.xj.POJO.Notice;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;

public interface NoticeService {
	//公告列表
	List<Notice> getNoticeList(PageSize pageSize);
	//添加公告
	void addNotice(Notice notice);
	//根据id查询信息
	Notice CheckNotById(Integer id);
	//修改信息
	void NotUpdate(Notice notice);
	//批量删除
	void DeleteNotByIds(QueryVo vo);
}
