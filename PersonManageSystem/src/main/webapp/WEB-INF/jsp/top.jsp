<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <title>人事管理中心</title>

</head>
  <body>
    <div class="row">
			<div class="col-md-12">
				
		
		<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      
      <strong>
      <a class="navbar-brand" href="#"><font style="font-size: 30px;">人事管理系统 v3.0</font></a>
      </strong>
      
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
    
      <ul class="nav navbar-nav">
        <li class="active"><a href="${pageContext.request.contextPath }/Path/index.action" id="toIndexPage">首页 <span class="sr-only">(current)</span></a></li>
        <c:if test="${sessionScope.username.username =='超级管理员'}">
        	<li><a href="${pageContext.request.contextPath }/User/UserList.action" id="UserManage">用户管理</a></li>
        </c:if>
         <c:if test="${sessionScope.username.username =='普通用户'}">
         	<li><a href="${pageContext.request.contextPath }/Path/qiandao.action">签到|薪水</a></li>
         	<li><a href="${pageContext.request.contextPath }/Docu/DocuList.action">文档下载</a></li>
         </c:if>
      <c:if test="${sessionScope.username.username =='超级管理员'}">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">其他管理<span class="caret"></span></a>
          <ul class="dropdown-menu">
	            <li><a href="${pageContext.request.contextPath }/DeptJob/DeptJobList.action?tableName=dept_inf">部门管理</a></li>
	            <li><a href="${pageContext.request.contextPath }/DeptJob/DeptJobList.action?tableName=job_inf">职位管理</a></li>
	            <li><a href="${pageContext.request.contextPath }/Emp/EmpList.action">员工管理</a></li>
            	<li role="separator" class="divider"></li>
            	<li><a href="${pageContext.request.contextPath }/Notice/NotList.action">公告管理</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="${pageContext.request.contextPath }/Docu/DocuList.action">文件管理</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="${pageContext.request.contextPath }/log/sysloglist.action?perPageSize=10">系统日志</a></li>
          </ul>
        </li>
      </c:if>
      </ul>
      
      
      
		<ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
          <span class="glyphicon glyphicon-user"></span>${sessionScope.username.loginname}<span class="caret"></span></a>
          <ul class="dropdown-menu nav nav-pills" style="min-width: 100px;">
            <li><a href="${pageContext.request.contextPath }/Notice/NotList.action?tableName=1#section-1">个人中心</a></li>
            <li role="presentation"><a href="${pageContext.request.contextPath }/Notice/NotList.action?tableName=2#section-2">公告<span class="badge">3</span></a></li>
            <li role="separator" class="divider"></li>
            <li><a href="${pageContext.request.contextPath }/User/quitSys.action" style="color: red;font-weight: bold;">退出系统</a></li>
          </ul>
        </li>
      </ul>
      <form class="navbar-form navbar-right" action="https://www.baidu.com/s">     		
		   <div class="form-group">
		   		<img alt="" src="${pageContext.request.contextPath }/resources/images/search/baidu_web.png">
		      	<input type="text" class="form-control" placeholder="Search" name="wd"/>
		   </div>
		   <button type="submit" class="btn btn-default">搜索</button>
      </form>
    </div>
  </div>
</nav>
		</div>
	
	
</nav>

</div>

<div class="modal fade bs-example-modal-sm" id="errorDialog" tabindex="-1" role="dialog"
		aria-labelledby="mySmallModalLabel">
		<div class="modal-dialog modal-sm" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel" align="center">友情提醒</h4>
				</div>
				<div class="modal-body">
					<center><p style="color: red;" id="diaglogtxt"></p></center>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="button" class="btn btn-primary" id="diaglogtxtsubbutton" value="确认"/>
				</div>
			</div>
		</div>
	</div>

  </body>
</html>
