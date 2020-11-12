package com.xj.Mapper;

import java.util.List;

import com.xj.POJO.Notice;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import org.springframework.stereotype.Repository;

@Repository
public interface NoticeMapper {
	//公告列表
	List<Notice> getNoticeList(PageSize pageSize);
	//公告数量
	Integer getTotalNotice(PageSize pageSize);
	//添加公告
	void addNotice(Notice notice);
	//根据id查询信息
	Notice CheckNotById(Integer id);
	//修改信息
	void NotUpdate(Notice notice);
	//批量删除
	void DeleteNotByIds(QueryVo vo);
}
