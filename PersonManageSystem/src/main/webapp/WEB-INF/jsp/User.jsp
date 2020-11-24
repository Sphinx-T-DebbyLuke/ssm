<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/User.js"></script>
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
					<li><a href="#" class="active" id="UserSelect"><span class="glyphicon glyphicon-th-list"></span><br class="visible-md"/> 用户查询</a></li>
					<li><a href="#" class="active" id="UserAdd"><span class="glyphicon glyphicon-user"></span><br class="visible-md"/> 添加用户</a></li>
				</ul>
				
			</div>
			<!-- /.sidebar-collapse -->
		</div>
	
	</div>
	
	
	<div class="col-md-10" id="managePage">
		<!-- 用户查询 -->
		<div id="UserSelect">
		<c:if test="${empty pageSize.userlist}">
			<div id="page-wrapper">
				
				<img id="nodataimg" style="width: 80%;height: 80%;display: none;" src="${pageContext.request.contextPath }/resources/images/nodata.gif">
				
			</div>
		</c:if>
		<c:if test="${not empty pageSize.userlist}">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">用户管理</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/User/UserList.action" method="post" id="form1">
						<div class="form-group">
							<label for="loginName">登录名</label> 
							<input type="text" class="form-control" id="loginName" value="${pageSize.loginname}" name="loginname"/>
						</div>
						<div class="form-group">
							<label for="loginName">用户身份</label> 
							<select name="username" class="form-control" id="select01">
								<option value="">--请选择--</option>
								<option value="普通用户" 
									<c:if test="${pageSize.username=='普通用户' }">selected</c:if>
								 >普通用户</option>
								<option value="超级管理员" 
									<c:if test="${pageSize.username=='超级管理员' }">selected</c:if>
								>超级管理员</option>
							</select>
						</div>
						<input type="hidden" name="perPageSize" value="${pageSize.perPageSize}">
						<button type="submit" class="btn btn-primary">查询</button>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">用户信息列表</div>
						<!-- /.panel-heading -->
						<form id="formbydelete">
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th style="width: 60px;"><input type="checkbox" id="selectalldelete" title="全选" >&nbsp;&nbsp;
									<a href="#" data-toggle="tooltip" title="批量删除" class="glyphicon glyphicon-trash" style="display: none;" id="alldeleteBychecked"></a>
									</th>
									<th>登录名</th>
									<th>密码</th>
									<th>用户身份</th>
									<th>状态</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
								
							</thead>
							<tbody>
								<c:forEach items="${pageSize.userlist}" var="row">
									<tr>
										<td><input type="checkbox" name="ids" value="${row.id}"></td>
										<td style="display: none;" id="${row.id}">${row.id}</td>
										<td>${row.loginname}</td>
										<td>${row.password}</td>
										<td>${row.username}</td>
										<td id="dymicStatus">
											<c:if test="${row.userstatus==1}">
												离线
											</c:if>
											<c:if test="${row.userstatus==2}">
												<font style="font-weight: bold;color: green;">在线</font>
											</c:if>
										</td>
										<td>${row.createdateStr}</td>
										<td>
											<a href="#" title="编辑" class="glyphicon glyphicon-pencil" data-toggle="modal" data-target="#EditDialog" onclick="editUser(${row.id})"></a>
											&nbsp;&nbsp;<a href="#" title="删除" class="glyphicon glyphicon-trash" onclick="deleteByoneid(${row.id})"></a>
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
      <a href="${pageContext.request.contextPath }/User/UserList.action?currentPage=${pageSize.currentPage-1}&loginname=${pageSize.loginname}&username=${pageSize.username}&perPageSize=${pageSize.perPageSize}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/User/UserList.action?currentPage=${p}&loginname=${pageSize.loginname}&username=${pageSize.username}&perPageSize=${pageSize.perPageSize}">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/User/UserList.action?currentPage=${pageSize.currentPage+1}&loginname=${pageSize.loginname}&username=${pageSize.username}&perPageSize=${pageSize.perPageSize}" aria-label="Next">
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
		<div id="UserAdd" style="display: none;">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">用户添加</h1>
					
				</div>
				<!-- /.col-lg-12 -->
			</div>
			
				<div class="col-lg-12">
					<div class="panel panel-default">
					<div class="panel-body">
						<form class="form-inline" action="${pageContext.request.contextPath }/User/UserAdd.action" method="post" id="formadd">
								<table class="table" id="table2">
									<tr>
										<td>
											<div class="form-group"><label for="customerName">登录名:</label></div>
										</td>
									<td>
											<div class="form-group">
												<input type="text" class="form-control" name="loginname" id="toRegisterByloginname"/>
											</div>
									</td>
										<td>
											<div class="form-group"><label for="customerName">密码:</label></div>
										</td>
									<td>
											<div class="form-group">
												<input type="text" class="form-control" name="password"/>
											</div>
									</td></tr>
								
									<tr>
										<td>
											<div class="form-group"><label for="customerName">用户身份:</label> </div>
										</td>
									<td>
											<div class="form-group">
												<select name="username" class="form-control">
													<option value="">--请选择--</option>
													<option value="普通用户">普通用户</option>
													<option value="超级管理员">超级管理员</option>
												</select>
											</div>
									</td>
									</tr>
									
									<tr><td colspan="2">
											<button type="submit" class="btn btn-primary" id="buttonaddUser">添加</button>
											<input type="button" class="btn btn-success" value="重置" id="resetUser"/>
											
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
					<h4 class="modal-title" id="myModalLabel">修改人事信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit_User_form">
						<input type="hidden" id="edit_id" name="id"/>
						<input type="hidden" id="edit_password" name="password"/>
						<input type="hidden" id="edit_userstatus" name="userstatus"/>
						<input type="hidden" id="edit_createdate" name="createdate"/>
						<div class="form-group">
							<label for="edit_Name" class="col-sm-2 control-label">用户名称</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="edit_Name" readonly="readonly" placeholder="用户名称" name="loginname"/>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_From" style="float:left;padding:7px 15px 0 27px;">用户身份</label> 
							<div class="col-sm-10">
								<select	class="form-control" id="edit_From" placeholder="用户身份" name="username">
									<option value="">--请选择--</option>
								<option value="普通用户">普通用户</option>
								<option value="超级管理员">超级管理员</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit_From" style="float:left;padding:7px 15px 0 27px;">绑定员工</label>
							<div class="col-sm-10">
								<select name="emp.id" class="form-control" id="emp_id"> 
									<option value="0">--请选择--</option>
									<c:forEach items="${allEmpidOrnameList }" var="emp">
									<option value="${emp.id}">${emp.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="button" class="btn btn-primary" value="保存修改" id="edit_update"/>
				</div>
			</div>
		</div>
	</div>
	
	


	</div>
</div>
  
  

  </body>
</html>
