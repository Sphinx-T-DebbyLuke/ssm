package com.xj.Service.Impl;

import com.xj.Mapper.DocumentMapper;
import com.xj.POJO.Document;
import com.xj.POJO.PageSize;
import com.xj.POJO.QueryVo;
import com.xj.Service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=false)
@Service
public class DocumentServiceImpl implements DocumentService {
	@Autowired
	private DocumentMapper domapper;
	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Document> getDocumentList(PageSize pageSize) {
		Integer totalDocumentNum = domapper.getTotalDocumentNum(pageSize);
		pageSize.handledata(totalDocumentNum);
		return domapper.getDocumentList(pageSize);
	}
	@Override
	public void AddDocument(Document document) {
		Date date=new Date();
		document.setCreate_date(date);
		domapper.AddDocument(document);
	}

	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public Document CheckDocuById(Integer id) {
		return domapper.CheckDocuById(id);
	}

	@Override
	public void UpdateDocu(Document document) {
		domapper.UpdateDocu(document);
	}

	@Override
	public void DeleteDocuByIds(QueryVo vo) {
		domapper.DeleteDocuByIds(vo);
	}

	@Transactional(isolation=Isolation.DEFAULT,propagation=Propagation.REQUIRED,readOnly=true)
	public List<Document> getDocumentFilenameList() {
		return domapper.getDocumentFilenameList();
	}

}
