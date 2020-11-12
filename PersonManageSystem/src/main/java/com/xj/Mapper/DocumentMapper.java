package com.xj.Mapper;

import java.util.List;

import com.xj.POJO.Document;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import org.springframework.stereotype.Repository;

@Repository
public interface DocumentMapper {
	//文档列表
	List<Document> getDocumentList(PageSize pageSize);
	//获取文档数量
	Integer getTotalDocumentNum(PageSize pageSize);
	//上传文件
	void AddDocument(Document document);
	//根据id查询文档信息
	Document CheckDocuById(Integer id);
	//修改文档信息
	void UpdateDocu(Document document);
	//批量删除
	void DeleteDocuByIds(QueryVo vo);
	//查询所有文档文件名（用户文件删除时比较）
	List<Document> getDocumentFilenameList();
}
