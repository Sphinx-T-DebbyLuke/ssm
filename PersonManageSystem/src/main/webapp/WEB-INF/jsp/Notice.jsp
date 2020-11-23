<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/Notice.js"></script>
<head>
<style type="text/css">
table tbody tr td{
	overflow: hidden; 
    text-overflow:ellipsis;  
    white-space: nowrap; 
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
					

					<li><a href="#" class="active" id="NoticeSelect"><span class="glyphicon glyphicon-th-list"></span><br class="visible-md"/> 公告查询</a></li>
					<li><a href="#" class="active" id="NoticeAdd"><span class=" 	glyphicon glyphicon-envelope"></span><br class="visible-md"/> 添加公告</a></li>
			
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
	
	</div>
	
	
	<div class="col-md-10" id="managePage">
		<!-- 查询 -->
		<div id="NoticeSelect">
		<c:if test="${empty pageSize.noticelist}">
			<div id="page-wrapper">
				
				<img id="nodataimg" style="width: 80%;height: 80%;display: none;" src="${pageContext.request.contextPath }/resources/images/nodata.gif">
				
			</div>
		</c:if>
		<c:if test="${not empty pageSize.noticelist}">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">公告管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/Notice/NotList.action" method="post" id="form1">
						<div class="form-group">
							<label for="loginName">公告名称</label> 
							<input type="text" class="form-control" id="loginName" value="${pageSize.loginname}" name="loginname"/>
						</div>
						<input type="hidden" name="perPageSize" value="${pageSize.perPageSize}">
						<button type="submit" class="btn btn-primary">查询</button>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">公告列表</div>
						<!-- /.panel-heading -->
						<form id="formbydelete">
						<table class="table table-bordered table-striped table-hover" style="table-layout: fixed;">
							<thead>
								<tr>
									<th style="width: 60px;"><input type="checkbox" id="selectalldelete" data-toggle="tooltip" title="全选" >&nbsp;&nbsp;
									<a href="#" data-toggle="tooltip" title="批量删除" class="glyphicon glyphicon-trash" style="display: none;" id="alldeleteBychecked"></a>
									</th>
									<th>公告名称</th>
									<th>公告内容</th>
									<th>创建时间</th>
									<th>公告人</th>
									<th>操作</th>
								</tr>
								
							</thead>
							<tbody>
								<c:forEach items="${pageSize.noticelist}" var="row">
									<tr>
										<td><input type="checkbox" name="ids" value="${row.id}"></td>
										<td><span class="glyphicon glyphicon-envelope"></span>${row.title}</td>
										<td>${row.content}</td>
										<td>${row.createdateStr}</td>
										<td>${row.user.loginname}(${row.user.username})</td>
										<td>
											<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#EditDialog" onclick="editNotice(${row.id})">修改</a>
											<a href="#" class="btn btn-danger btn-xs" onclick="deleteByoneid(${row.id})">删除</a>
										</td>
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
      <a href="${pageContext.request.contextPath }/Notice/NotList.action?currentPage=${pageSize.currentPage-1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/Notice/NotList.action?currentPage=${p}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/Notice/NotList.action?currentPage=${pageSize.currentPage+1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}" aria-label="Next">
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
		<div id="NoticeAdd" style="display: none;">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">公告添加</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			
				<div class="col-lg-12">
					<div class="panel panel-default">
					<div class="panel-body">
						<form class="form-inline" action="${pageContext.request.contextPath }/Notice/NotAdd.action" method="post">
								<table class="table" id="table2">
									<tr>
									<td>
											<div class="form-group">
												<label for="Name">公告名称:</label>
												<input type="text" class="form-control" name="title" id="Name"/>&nbsp;&nbsp;&nbsp;&nbsp;
												<span class="alert alert-danger" style="display: none;width: 400px;height: 50px;">公告名称不能为空！</span>
											</div>
									</td>
										</tr>
									<tr>
					
									<td>
											
												<label for="Name">公告内容:</label>
												<textarea rows="3" class="form-control" name="content" style="max-width: 872px;max-height: 210px;height: 210px;width: 100%;resize: none;"></textarea>
											
									</td>
									</tr>
			
									
									<tr><td>
											<button type="submit" class="btn btn-primary" id="buttonaddNotice">添加</button>
											<input type="button" class="btn btn-success" value="重置" id="resetNotice"/>
											
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
					<h4 class="modal-title" id="myModalLabel">公告信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_notice_form">
						<input type="hidden" id="edit_notice_id" name="id"/>
						<div class="form-group">
							<label for="edit_title" class="col-sm-2 control-label">公告名称:</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_title" placeholder="公告名称" name="title"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_content" class="col-sm-2 control-label">公告内容:</label>
							<div class="col-sm-10">
								<textarea rows="3" class="form-control" id="edit_content" placeholder="公告内容" style="width: 100%;resize: none;height: 319px;" name="content"></textarea>
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
