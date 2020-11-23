package com.xj.Controller;

import com.xj.POJO.*;
import com.xj.Service.DocumentService;
import com.xj.Service.SyslogService;
import com.xj.util.imageUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@RequestMapping(value="/Docu")
public class DocumentController {
	@Autowired
	private DocumentService docuService;
	@Autowired
	private SyslogService logservice;

	@RequestMapping(value="/DocuList.action")
	public String DocumentList(PageSize pageSize,Model model){
		List<Document> documentList = docuService.getDocumentList(pageSize);
		pageSize.setDocumentList(documentList);
		model.addAttribute("pageSize", pageSize);
		return "document";
	}
	@RequestMapping(value="/DocuAdd.action")
	public String DocumentAdd(Document document,MultipartFile multipartFile,HttpServletRequest req){
		document.setFilename(multipartFile.getOriginalFilename());//将获取到的文件名放入ducument对象
		String fileNamePath= imageUtil.generateThumbnail(document.getFilename(),document.getId(), req, "Document");
		System.out.println("文件存放路径："+req.getServletContext().getRealPath("upload")+"\\document\\"+document.getFilename());
		try {
			multipartFile.transferTo(new File(fileNamePath));
			User user=(User) req.getSession().getAttribute("username");
			document.setUser(user);
		}  catch (Exception e) {
			e.printStackTrace();
		}
		docuService.AddDocument(document);

		Syslog syslog=new Syslog("文档管理","添加了["+document.getTitle()+"]文档");
		logservice.addSyslog(syslog, req);
		return "redirect:/Docu/DocuList.action";
	}
	//根据id查询文档信息
	@RequestMapping(value="/CheckDocuById.action")
	public @ResponseBody Document CheckDocuById(Integer id){
		return docuService.CheckDocuById(id);
	}
	//修改文档信息
	@RequestMapping(value="/UpdateDocu.action")
	public @ResponseBody String UpdateDocu(Document document,HttpServletRequest req){
		Syslog syslog=new Syslog("文档管理","修改了["+document.getTitle()+"]的文档信息");
		try {
			logservice.addSyslog(syslog, req);
			String oldFileName = imageUtil.generateThumbnail(document.getOldfilename(),document.getId(), req, "Document");
			String newFileName = imageUtil.generateThumbnail(document.getFilename(),document.getId(), req, "Document");
			docuService.UpdateDocu(document);
			File oldfile=new File(req.getServletContext().getRealPath(oldFileName));
			File newfile=new File(req.getServletContext().getRealPath(newFileName));
			if(oldfile.exists()){
				if(!newfile.exists()){
					oldfile.renameTo(newfile);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}
	//批量删除
	@RequestMapping(value="/DeleteDocuByIds.action")
	public String DeleteDocuByIds(QueryVo vo,HttpServletRequest req){
		String logdetail="";
		for (int i=0;i<vo.getIds().size();i++) {
			Document checkDocuById = null;
			try {
				checkDocuById = docuService.CheckDocuById(vo.getIds().get(i));
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(i==0){
				logdetail+=checkDocuById.getTitle();
			}else{
				logdetail+=","+checkDocuById.getTitle();
			}
		}
		Syslog syslog=new Syslog("文档管理","删除了["+logdetail+"]的文档信息");
		logservice.addSyslog(syslog,req);

		docuService.DeleteDocuByIds(vo);
		List<Document> documentFilenameList = docuService.getDocumentFilenameList();
		boolean delorno=true;
		for(int i=0;i<vo.getFilenameList().size();i++){
			for(int j=0;j<documentFilenameList.size();j++){
				if(vo.getFilenameList().get(i).equals(documentFilenameList.get(j).getFilename())){
					delorno=false;
				}
			}
			if(delorno){
				String documentName = imageUtil.generateThumbnail(vo.getFilenameList().get(i),vo.getIds().get(i), req, "Document");
				File file=new File(documentName);
				try {
					file.delete();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return "redirect:/Docu/DocuList.action";
	}
	//文档下载
	@RequestMapping(value="/DocDownload.action")
	public ResponseEntity<byte[]> DocDownload(String filename,int id,HttpServletRequest req) throws IOException{
		String createfilename=imageUtil.generateThumbnail(filename,id,req,"Document");
		File file=new File(createfilename);
		//创建springframework的HttpHeader对象
		HttpHeaders headers=new HttpHeaders();
		//下载显示的文件名，解决中文名称乱码问题
		try {
			String downloadFielName=new String(filename.getBytes("UTF-8"),"iso-8859-1");
			//通知浏览器以attachment(下载方式)打开图片
			headers.setContentDispositionFormData("attachment", downloadFielName);
			//application/octet-steam:二进制流数据（最常见的文件下载）
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

			Syslog syslog=new Syslog("文档管理","下载了["+filename+"]文档");
			logservice.addSyslog(syslog, req);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//201  HttpStatus.CREATED
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers,HttpStatus.CREATED);
	}
}
