<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/DeptJob.js"></script>
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

					<li><a href="#" class="active" id="DeptJobSelect"><span class="glyphicon glyphicon-th-list"></span><br class="visible-md"/> 职位查询</a></li>
					<li><a href="#" class="active" id="DeptJobAdd"><span class="glyphicon glyphicon-wrench"></span><br class="visible-md"/> 添加职位</a></li>
			
				</ul>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
	
	</div>
	
	
	<div class="col-md-10" id="managePage">
		<!-- 用户查询 -->
		<div id="DeptJobSelect">
		<c:if test="${empty pageSize.deptlist}">
			<div id="page-wrapper">
				
				<img id="nodataimg" style="width: 80%;height: 80%;display: none;" src="${pageContext.request.contextPath }/resources/images/nodata.gif">
				
			</div>
		</c:if>
		<c:if test="${not empty pageSize.deptlist}">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">职位管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/DeptJob/DeptJobList.action?tableName=job_inf" method="post" id="form1">
						<div class="form-group">
							<label for="loginName">职位名称</label> 
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
						<div class="panel-heading">职位信息列表</div>
						<!-- /.panel-heading -->
						<form id="formbydelete">
						<input type="hidden" value="job_inf" name="tableName">
						<table class="table table-bordered table-striped table-hover" style="table-layout: fixed;">
							<thead>
								<tr>
									<th style="width: 60px;"><input type="checkbox" id="selectalldelete" title="全选" >&nbsp;&nbsp;
									<a href="#" data-toggle="tooltip" title="批量删除" class="glyphicon glyphicon-trash" style="display: none;" id="alldeleteBychecked"></a>
									</th>
									<th>职位名称</th>
									<th>详细信息</th>
									<th>操作</th>
								</tr>
								
							</thead>
							<tbody>
								<c:forEach items="${pageSize.deptlist}" var="row">
									<tr>
										<td><input type="checkbox" name="ids" value="${row.id}"></td>
										<td>${row.name}</td>
										<td>${row.remark}</td>
										<td>
											<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#EditDialog" onclick="editDeptJob(${row.id},'job_inf')">修改</a>
											<a href="#" class="btn btn-danger btn-xs" onclick="deleteByoneid(${row.id},'job_inf')">删除</a>
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
      <a href="${pageContext.request.contextPath }/DeptJob/DeptJobList.action?currentPage=${pageSize.currentPage-1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}&tableName=job_inf" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/DeptJob/DeptJobList.action?currentPage=${p}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}&tableName=job_inf">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/DeptJob/DeptJobList.action?currentPage=${pageSize.currentPage+1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}&tableName=job_inf" aria-label="Next">
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
		
		
		
		<!-- 添加用户 -->
		<div id="DeptJobAdd" style="display: none;">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">职位添加</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			
				<div class="col-lg-12">
					<div class="panel panel-default">
					<div class="panel-body">
						<form class="form-inline" action="${pageContext.request.contextPath }/DeptJob/DeptJobAdd.action?tableName=job_inf" method="post">
								<table class="table" id="table2">
									<tr>
									<td>
											<div class="form-group">
												<label for="Name">职位名称:</label>
												<input type="text" class="form-control" name="name" id="Name"/>&nbsp;&nbsp;&nbsp;&nbsp;
												<span class="alert alert-danger" style="display: none;width: 400px;height: 50px;">职位名称不能为空！</span>
											</div>
									</td>
										</tr>
									<tr>
					
									<td>
											
												<label for="Name">职位详细信息:</label>
												<textarea rows="3" class="form-control" name="remark" style="max-width: 774px;max-height: 209px;height: 209px;width: 100%;resize: none;"></textarea>
											
									</td>
									</tr>
			
									
									<tr><td>
											<button type="submit" class="btn btn-primary" id="buttonaddDeptJob">添加</button>
											<input type="button" class="btn btn-success" value="重置" id="resetDeptJob"/>
											
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
					<h4 class="modal-title" id="myModalLabel">职位信息编辑</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_DeptJob_form">
						<input type="hidden" id="edit_id" name="id"/>
						<input type="hidden" value="job_inf" name="tableName">
						<div class="form-group">
							<label for="edit_Name" class="col-sm-2 control-label">职位名称</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_Name" placeholder="职位名称" name="name"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_Name" class="col-sm-2 control-label">月工资</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_Salary" placeholder="月工资" name="salary"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_Name" class="col-sm-2 control-label">详细信息</label>
							<div class="col-sm-10">
								<textarea rows="3" class="form-control" id="edit_remark" placeholder="详细信息" style="width: 100%;resize: none;height: 250px;" name="remark"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateDeptJob">保存修改</button>
				</div>
			</div>
		</div>
	</div>



	</div>
</div>
  
  

  </body>
</html>
