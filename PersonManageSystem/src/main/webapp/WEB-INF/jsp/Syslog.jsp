<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/Syslog.js"></script>
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
				<h3 class="page-header">系统日志</h3>
			</div>
			<!-- /.sidebar-collapse -->
		</div>
	
	</div>
	
	
	<div class="col-md-10" id="managePage">
		<!-- 查询 -->
		<div id="NoticeSelect">
		<c:if test="${empty syslogList}">
			<div id="page-wrapper">
				
				<img id="nodataimg" style="width: 80%;height: 80%;display: none;" src="${pageContext.request.contextPath }/resources/images/nodata.gif">
				
			</div>
		</c:if>
		<c:if test="${not empty syslogList}">
			<div id="page-wrapper">
			
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/log/sysloglist.action" method="post" id="form1">
						<input type="hidden" name="perPageSize" value="${pageSize.perPageSize}">
						<div class="form-group">
							<label for="loginName">日志类型</label> 
							<select name="loginname" class="form-control" id="loginName"> 
									<option value="">--请选择--</option>
									<c:forEach items="${syslogtypeList }" var="log">
										<option value="${log}" 
										<c:if test="${pageSize.loginname==log}">selected</c:if>
										>${log}</option>
									</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label for="username">创建日期</label> 
							<input type="text" class="form-control" id="username" value="${pageSize.username}" name="username"/>
						</div>
						<div class="form-group">
							<label for="operateId">操作人</label> 
							<select name="operateId" class="form-control" id="operateId"> 
									<option value="">--请选择--</option>
									<c:forEach items="${userListIdName }" var="log">
										<c:if test="${log.emp_name!=null}">
											<option value="${log.id}" 
											<c:if test="${pageSize.operateId==log.id}">selected</c:if>
											>${log.emp_name}</option>
										</c:if>
									</c:forEach>
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
						<form id="formbydelete">
						<table class="table table-bordered table-striped table-hover" style="table-layout: fixed;">
							<thead>
								<tr>
									<th style="width: 60px;"><input type="checkbox" id="selectalldelete" title="全选" >&nbsp;&nbsp;
									<a href="#" data-toggle="tooltip" title="批量删除" class="glyphicon glyphicon-trash" style="display: none;" id="alldeleteBychecked"></a>
									</th>
									<th style="width: 100px;">日志类型</th>
									<th>详情</th>
									<th style="width: 200px;">创建日期</th>
								</tr>
								
							</thead>
							<tbody>
								<c:forEach items="${syslogList}" var="row">
									<tr>
										<td><input type="checkbox" name="ids" value="${row.id}"></td>
										<td>${row.log_type}</td>
										<td><font color="#DE1F55">
										<c:if test="${row.user.emp_name!=''}">
											${row.user.emp_name}
										</c:if>
										<c:if test="${row.user.emp_name==null}">
											${row.user.loginname}
										</c:if>
										</font>&nbsp;&nbsp;${row.log_detail}</td>
										<td>${row.createdateStr}</td>
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
	<c:forEach var="num" begin="1" end="30">
		<option value="${num }" 
			<c:if test="${pageSize.perPageSize==num}">selected</c:if>
		>${num }</option>
	</c:forEach>
</select>

<nav>
  <ul class="pagination">
   <c:if test="${pageSize.currentPage>1}">
   	 <li><a href="${pageContext.request.contextPath }/log/sysloglist.action?currentPage=1&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}">首页</a></li>
    <li>
      <a href="${pageContext.request.contextPath }/log/sysloglist.action?currentPage=${pageSize.currentPage-1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/log/sysloglist.action?currentPage=${p}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/log/sysloglist.action?currentPage=${pageSize.currentPage+1}&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
    <li><a href="${pageContext.request.contextPath }/log/sysloglist.action?currentPage=${pageSize.totalPageSize }&loginname=${pageSize.loginname}&perPageSize=${pageSize.perPageSize}">尾页</a></li>
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
		
		
		
		
		</div>
		
		
		</div>	
</div>


	</div>
</div>
  
  

  </body>
</html>
