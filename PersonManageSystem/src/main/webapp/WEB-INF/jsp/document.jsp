<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/document.js"></script>
<head>
<style type="text/css">
table tbody tr td{
	overflow: hidden; 
    text-overflow:ellipsis;  
    white-space: nowrap; 
}
.mousetable{
	background-color: gray;
}
</style>
</head>
  <body>
  
 <div class="container-fluid">
	<div class="container">
		<div id="wrapper">
			<jsp:include page="top.jsp" />
			
			

			<div class="row">
	<br />
	<div class="col-md-2">
		<div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
					
					
				<ul class="nav" id="side-menu" style="padding-top: 20px;">

					<li><a href="#" class="active" id="DocumentSelect"><span class="glyphicon glyphicon-folder-open"></span><br class="visible-md"/> 文档查询</a></li>
					<li><a href="#" class="active" id="DocumentAdd"><span class="glyphicon glyphicon-send"></span><br class="visible-md"/> 上传文档</a></li>
				
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
	</div>
	
	
	<div class="col-md-10" id="managePage">
		<!-- 查询 -->
		<div id="DocumentSelect">
		<c:if test="${empty pageSize.documentList}">
			<div id="page-wrapper">
				
				<img id="nodataimg" style="width: 80%;height: 80%;display: none;" src="${pageContext.request.contextPath }/resources/images/nodata.gif">
				
			</div>
		</c:if>
		<c:if test="${not empty pageSize.documentList}">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">文档管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/Docu/DocuList.action" method="post" id="form1">
						<div class="form-group">
							<label for="loginName">标题:</label> 
							<input type="text" class="form-control" id="loginName" value="${pageSize.loginname}" name="loginname"/>
						</div>
						<div class="form-group">
							<label for="username">文件类型:</label> 
							<input type="text" class="form-control" id="username" value="${pageSize.username}" name="username"/>
						</div>
						<input type="hidden" name="perPageSize" value="${pageSize.perPageSize}">
						<button type="submit" class="btn btn-primary">查询</button>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">文档列表<span style="padding-left: 10%;" class="text-muted"></span></div>
						<!-- /.panel-heading -->
						<form id="formbydelete">
						<input type="hidden" name="filename">
						<table class="table table-bordered table-striped table-hover" style="table-layout: fixed;">
							<thead>
								<tr>
									<th style="width: 60px;">
									<input type="checkbox" id="selectalldelete" data-toggle="tooltip" title="全选" >&nbsp;&nbsp;
									<a href="#" data-toggle="tooltip" title="批量删除" class="glyphicon glyphicon-trash" style="display: none;" id="alldeleteBychecked"></a>
									</th>
									<th class="hidden-xs hidden-sm">标题</th>
									<th style="width: 170px;">文件名</th>
									<th class="hidden-md hidden-xs" style="width: 90px;">文件类型</th>
									<th style="width: 100px;">上传时间</th>
									<th style="width: 20%;">上传人</th>
									<th style="width: 95px;">操作</th>
									<th style="width: 60px;">下载</th>
								</tr>
								
							</thead>
							<tbody>
								<c:forEach items="${pageSize.documentList}" var="row">
									<tr>
										<td><input type="checkbox" name="ids" value="${row.id}"></td>
										<td class="hidden-xs hidden-sm"><span class="glyphicon glyphicon-file"></span>${row.title}</td>
										<td class="mytooltip" style="cursor: pointer;">${row.filename}</td>
										<td id="filenameList" class="hidden-md hidden-xs">${row.filetype}
											<input type="checkbox" style="display: none;" value="${row.filename}" name="filenameList">
										</td>
										<td>${row.createdateStr}</td>
										<td>${row.user.loginname}(${row.user.username})</td>
										<td>
											<c:if test="${sessionScope.username.username=='超级管理员'}">
												<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#EditDialog" onclick="editdocument(${row.id})">修改</a>
												<a href="#" class="btn btn-danger btn-xs" name="deleteByoneid">删除</a>	
											</c:if>
											<c:if test="${sessionScope.username.username=='普通用户'}">
												<c:if test="${row.user.loginname==sessionScope.username.loginname}">
													<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#EditDialog" onclick="editdocument(${row.id})">修改</a>
													<a href="#" class="btn btn-danger btn-xs" name="deleteByoneid">删除</a>
												</c:if>
												<c:if test="${row.user.loginname!=sessionScope.username.loginname}">
													<input type="button" class="btn btn-danger btn-xs" disabled="disabled" value="无法操作"/>
												</c:if>
											</c:if>
										</td>
										<td><center><a href="${pageContext.request.contextPath }/Docu/DocDownload.action?filename=${row.filename}&id=${row.id}" data-toggle="tooltip" title="下载文件" class="glyphicon glyphicon-save"></a></center></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</form>
						<div class="col-md-12 text-right">
						
<span>第</span>${pageSize.currentPage}<span>页</span>&nbsp;&nbsp;&nbsp;&nbsp;
<span>共</span>${pageSize.totalPageSize}<span>页</span>&nbsp;&nbsp;&nbsp;&nbsp;
<font>每页显示数:</font>
<select name="perPageSize">
	<c:forEach var="num" begin="1" end="10">
		<option value="${num }" 
			<c:if test="${pageSize.perPageSize==num}">selected</c:if>
		>${num }</option>
	</c:forEach>
</select>

<nav>
  <ul class="pagination">
   <c:if test="${pageSize.currentPage>1}">
    <li>
      <a href="${pageContext.request.contextPath }/Docu/DocuList.action?currentPage=${pageSize.currentPage-1}&loginname=${pageSize.loginname}&username=${pageSize.username}&perPageSize=${pageSize.perPageSize}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/Docu/DocuList.action?currentPage=${p}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}&username=${pageSize.username}">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/Docu/DocuList.action?currentPage=${pageSize.currentPage+1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}&username=${pageSize.username}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </c:if>
 
  </ul>
</nav>


						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
		</div>
		
		</c:if>
			
		</div>
		
		
		
		<!-- 添加 -->
		<div id="DocumentAdd" style="display: none;">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">文档上传</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			
				<div class="col-lg-12">
					<div class="panel panel-default">
					<div class="panel-body">
						<form class="form-inline" action="${pageContext.request.contextPath }/Docu/DocuAdd.action" method="post" enctype="multipart/form-data">
								<table class="table" id="table2">
									<tr>
									<td>
											<div class="form-group">
												<label for="Name">文档标题:</label>
												<input type="text" class="form-control" name="title" id="Name"/>
												<div class="input-group">
              										 <input type="file" id="i-check" value="浏览文件" class="btn btn-info" name="multipartFile">
      											 </div>
												&nbsp;&nbsp;&nbsp;&nbsp;
												<span class="alert alert-danger" style="display: none;width: 400px;height: 50px;">文档标题不能为空！</span>
											</div>
									</td>
										</tr>
									<tr>
					
									<td>
											
												<label for="Name">文档描述:</label>
												<textarea rows="3" class="form-control" name="remark" style="max-width: 872px;max-height: 210px;width: 100%;resize: none;height: 210px;"></textarea>
											
									</td>
									</tr>
			
									
									<tr><td>
											<button type="submit" class="btn btn-primary" id="buttonaddDocument">添加</button>
											<input type="button" class="btn btn-success" value="重置" id="resetDocument"/>
											
									</td></tr>
								</table>
								
						</form>
					</div>
						<div class="col-md-12 text-right">

						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
		</div>
		</div>
		
		
		</div>	
</div>




		<!-- 编辑对话框 -->
	<div class="modal fade" id="EditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">文档编辑</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_document_form">
						<input type="hidden" id="edit_document_id" name="id"/>
						<div class="form-group">
							<label for="edit_title" class="col-sm-2 control-label">文档标题:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_title" placeholder="文档标题" name="title"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_filename" class="col-sm-2 control-label">文件名:</label>
							<div class="col-sm-10">
								<input type="hidden" class="form-control" id="edit_oldfilename" placeholder="文档文件名" name="oldfilename"/>
								<input type="text" class="form-control" id="edit_newfilename" placeholder="文档文件名" name="filename"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_remark" class="col-sm-2 control-label">文档说明:</label>
							<div class="col-sm-10">
								<textarea rows="3" class="form-control" id="edit_remark" placeholder="文档说明" style="height: 250px;width: 100%;resize: none;" name="remark"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="edit_update">保存修改</button>
				</div>
			</div>
		</div>
	</div>





	</div>
</div>
  
  

  </body>
</html>
