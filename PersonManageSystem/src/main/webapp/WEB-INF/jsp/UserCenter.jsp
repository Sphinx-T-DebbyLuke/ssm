<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta name="description" content=""></meta>
<meta name="author" content=""></meta>

<title>用户中心</title>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<link type="text/css" href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript">
	$(function(){
		$("#foundation").click(function(){
			$(this).parent().addClass("active");
			$("#changePassword").parent().removeClass("active");
			$(".midleftdiv>.row").show();
			$(".midrightdiv>.row").hide();
		});
		$("#changePassword").click(function(){
			$(this).parent().addClass("active");
			$("#foundation").parent().removeClass("active");
			$(".midrightdiv>.row").show();
			$(".midleftdiv>.row").hide();
		});
		$("#loginname").keydown(function(){
			$("input[name='submitbutton']").eq(0).removeAttr("disabled");
		});
		$("#currentpassword2").keydown(function(){
			$("input[name='submitbutton']").eq(1).removeAttr("disabled");
		});
		$("input[name='submitbutton']").click(function(){
			//获取路径
			var pathName=window.document.location.pathname;
			//截取，得到项目名称
			var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
			if($(this).val()=="更新"){
				$("#password").val($("#currentpassword").val());
				$("#errorDialog .modal-body>center").html("<p style='color:#ff0000'>确认修改？</p>");
				$("#diaglogtxtsubbutton").bind("click",function(){
					$.post(projectName+"/User/updateUserInfo.action",$("#UserCenterInfo").serialize(),function(data){
						window.location.reload();
						return;
					});
				});
				$(".modal-footer>.btn-default").bind("click",function(){
					$("#password").val(null);
				});
				$("#errorDialog").modal("show");
			}else if($(this).val()=="修改密码"){
				$("#diaglogtxtsubbutton").unbind("click");
				$(".modal-footer>.btn-default").unbind("click");
				if($("#currentpassword").val().trim()==$("#currentpassword2").val().trim()){
					if($("#password").val().trim()==$("#password2").val().trim()&&$("#password").val().trim()!=''){
						$.post(projectName+"/User/updateUserInfo.action",$("#UserCenterInfo").serialize(),function(data){
							window.location.reload();
							return;
						});
					}else{
						if($("#password").val().trim()==''){
							$("#errorDialog .modal-body>center").html("<p style='color:red'>新密码不能为空！</p>");
						}else{
							$("#errorDialog .modal-body>center").html("<p style='color:red'>两次密码输入不一致！</p>");
						}
					}
				}else{
					$("#errorDialog .modal-body>center").html("<p style='color:red'>旧密码输入错误！</p>");
				}
				$("#diaglogtxtsubbutton").attr("data-dismiss","modal");
				$("#errorDialog").modal("show");
			}
		});
		$("[data-toggle='tooltip']").tooltip();//提示工具
	});
function showNotice(id){
	$.post("CheckNotById.action", { id: id},
	  function(data){
	    $("#edit_content").val(data.content);
	 });
}
</script>
<style>
.backimg{
	background: url(${pageContext.request.contextPath }/resources/images/timg7.jpg) no-repeat;
	background-size: 600px 480px;
	width: 600px;
}
</style>
</head>


<body data-spy="scroll" data-target="#myScrollspy">
<div class="container-fluid">
	<div class="container">
		<div id="wrapper">
			<jsp:include page="top.jsp" />
			<div id="otherPage">




       <h1 class="page-header">欢迎你！
       <c:if test="${sessionScope.username.emp_name==null}">${sessionScope.username.loginname}</c:if>
       <c:if test="${sessionScope.username.emp_name==''}">${sessionScope.username.loginname}</c:if>
       <c:if test="${sessionScope.username.emp_name!=null}">${sessionScope.username.emp_name}</c:if>
       </h1>
    <div class="row">
        <div class="col-sm-3 col-md-3 col-lg-3 hidden-xs" id="myScrollspy">
            <ul class="nav nav-tabs nav-stacked" data-spy="affix" data-offset-top="125">
                <li class="active"><a href="#section-1">个人中心</a></li>
                <li><a href="#section-2">公告</a></li>
            </ul>
        </div>
        <div class="col-xs-12 col-sm-9 col-md-9 col-lg-9">
            <h2 id="section-1"><span class="glyphicon glyphicon-user"></span>个人中心</h2>
            <ul class="nav nav-tabs nav-justified">
  				<li role="presentation" class="active"><a id="foundation">基本信息</a></li>
  				<li role="presentation"><a id="changePassword">更改密码</a></li>
			</ul>

            <form action="" id="UserCenterInfo">
			<div class="midleftdiv">
			 	<div class="row">
				<div class="form-group col-md-12" style="width: 100%;">
						<label for="loginname">登录名</label>
						<input type="text" class="form-control" id="loginname" value="${sessionScope.username.loginname}" name="loginname"/>
				</div>
				<div class="form-group col-md-12">
						<label for="createdate">创建日期</label>
						<input type="text" class="form-control" readonly="readonly" id="createdate" value="${sessionScope.username.createdateStr}" name="createdate"/>
				</div>
				<div class="form-group col-md-12">
						<label for="username">角色</label>
						<input type="text" class="form-control" readonly="readonly" id="username"
						<c:if test="${sessionScope.username.emp_name==null}">value="${sessionScope.username.username}" name="username"</c:if>
							   <c:if test="${sessionScope.username.emp_name==''}">value="${sessionScope.username.username}" name="username"</c:if>
							   <c:if test="${sessionScope.username.emp_name!=null}">value="${sessionScope.username.emp_name}" name="emp_name"</c:if> />
				</div>
				<div class="form-group col-md-12">
						<input type="button" class="form-control btn btn-info" value="更新" disabled="disabled" name="submitbutton"/>
				</div>
				</div>
			</div>
			<div class="midrightdiv">
			 	<div class="row" style="display: none;">
				<div class="form-group col-md-12 col-lg-12">
						<label for="currentpassword">当前密码</label>
						<input type="hidden" class="form-control" value="${sessionScope.username.password}" id="currentpassword"/>
						<input type="text" class="form-control" id="currentpassword2"/>
				</div>
				<div class="form-group col-md-12 col-lg-12">
						<label for="password">创建新密码</label>
						<input type="password" class="form-control" id="password" name="password" />
				</div>
				<div class="form-group col-md-12 col-lg-12">
						<label for="password2">重复新密码</label>
						<input type="password" class="form-control" id="password2"/>
				</div>
				<div class="form-group col-md-12 col-lg-12">
						<input type="hidden" class="form-control" name="id" value="${sessionScope.username.id}"/>
						<input type="hidden" class="form-control" name="userstatus" value="${sessionScope.username.userstatus}"/>
						<input type="button" class="form-control btn btn-info" value="修改密码" disabled="disabled" name="submitbutton"/>
				</div>
				</div>
			</div>
			</form>

            <hr>
            <h2 id="section-2"><span class="glyphicon glyphicon-bell"></span>系统公告</h2>
            	<table class="table table-bordered table-striped table-hover" style="table-layout: fixed;">
							<thead>
								<tr>
									<th>公告名称</th>
									<th>公告日期</th>
									<th>预览</th>
								</tr>

							</thead>
							<tbody>
								<c:forEach items="${pageSize.noticelist}" var="row">
									<tr>
										<td><span class="glyphicon glyphicon-envelope"></span> ${row.title}</td>
										<td>${row.createdateStr}</td>
										<td>
											<a href="#" class="glyphicon glyphicon-file" data-toggle="modal" data-target="#EditDialog" onclick="showNotice(${row.id})"/>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>


<span>第</span>${pageSize.currentPage}<span>页</span>&nbsp;&nbsp;&nbsp;&nbsp;
<span>共</span>${pageSize.totalPageSize}<span>页</span>&nbsp;&nbsp;&nbsp;&nbsp;
<br/>
<nav>
  <ul class="pagination">
   <c:if test="${pageSize.currentPage>1}">
    <li>
      <a href="${pageContext.request.contextPath }/Notice/NotList.action?currentPage=${pageSize.currentPage-1}&tableName=2#section-2" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/Notice/NotList.action?currentPage=${p}&tableName=2#section-2">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/Notice/NotList.action?currentPage=${pageSize.currentPage+1}&tableName=2#section-2" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </c:if>

  </ul>
</nav>




<!-- 编辑对话框 -->
	<div class="modal fade" id="EditDialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content backimg">
				<div class="modal-header" style="padding-top: 47px;">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<textarea rows="3" class="form-control" id="edit_content" placeholder="公告内容"
					style="max-width: 555px;max-height: 320px;height: 320px;min-width:555px;opacity:0.7;position: relative;left: 8px;font-weight: bold;"></textarea>


				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" style="position: relative;left: -6px;">关闭</button>
				</div>
			</div>
		</div>
	</div>




        </div>
    </div>



			</div>
</div>
	</div>
</div>
</body>

</html>
