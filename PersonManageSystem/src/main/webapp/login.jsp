<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'index.jsp' starting page</title>
	<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
  <script type="text/javascript">
  	$(function(){
  		$("#RegisterButton").click(function(){
  			$("#UserLoginPage").hide();
  			$("#toRegisterByloginname").val(null);
  			$("#toRegisterBypassword").val(null);
  			$("#toRegisterBypassword2").val(null);
  			$("#AgreeUserCer").removeAttr("checked");
  			$("#UserRegisterPage").show();
  		});
  		$("#toLoginButton").click(function(){
  			$("#UserRegisterPage").hide();
  			$("#UserLoginPage").show();
  			$("#toRegisterByloginname").val(null);
  			$("#toRegisterBypassword").val(null);
  			$("#toRegisterBypassword2").val(null);
  			$("#AgreeUserCer").removeAttr("checked");
  		});
  		$("[data-toggle='tooltip']").tooltip();//提示工具
  		$("#imgcheckcode").click(function(){
  			$(this).attr("src","${pageContext.request.contextPath }/User/GetCheckCode.action?"+Math.random());
  		});
  		$("#submitforlogin").click(function(){
  			if($("#loginnameforlogin").val().trim()==""||$("#passwordforlogin").val().trim()==""){
  				$("#diaglogtxt").text("请输入账号密码！");
				$("#errorDialog").modal("show");
				return false;
  			}
  		});
  		var repeatOrNo=false;
  		$("#registerButton").click(function(){
  			if(repeatOrNo){
  				if($("#toRegisterByloginname").val().trim()!=""&&$("#toRegisterBypassword").val().trim()!=""
  				&&$("#toRegisterBypassword2").val().trim()!=""){
  					if($("#AgreeUserCer").prop("checked")){
  						if($("#toRegisterBypassword").val().trim()==$("#toRegisterBypassword2").val().trim()){
  							$.post("${pageContext.request.contextPath }/User/UserRegister.action",$("#registerForm").serialize(),
							function(data){
								if(data=="success"){
								$("#diaglogtxt").text("注册成功！");
								$("#errorDialog").modal("show");
								$("#toRegisterByloginname").val(null);
  								$("#toRegisterBypassword").val(null);
  								$("#toRegisterBypassword2").val(null);
  								$("#AgreeUserCer").removeAttr("checked");
								}
							});
  						}else{
  							$("#diaglogtxt").text("两次密码输入不一致！");
							$("#errorDialog").modal("show");
  						}
  					}else{
  						$("#AgreeUserCer").trigger("mouseenter");
  					}
  				}else{
  					$("#diaglogtxt").text("所填参数不能为空！");
  					$("#errorDialog").modal("show");
  				}
  			}
		});
		$("#toRegisterByloginname").focusout(function(){
			var $loginname=$("#toRegisterByloginname").val().trim();
			$.get("${pageContext.request.contextPath }/User/checkLoginnameRepeat.action", { loginname: $loginname },
  			function(data){
    			if(data=="false"){
    				$("#toRegisterByloginname").attr("data-original-title","用户名已被占用");
    				$("#toRegisterByloginname").tooltip("show");
    				$("#toRegisterByloginname").focus();
    				repeatOrNo=false;
    			}else if(data=="success"){
    				$("#toRegisterByloginname").removeAttr("data-original-title");
    				repeatOrNo=true;
    			}
  			});
		});
  	});
  </script>
  </head>

  <body style="background-color: #3C3C3C;">
    <div class="container">
    	
    	
    	<div class="row">
    		<div class="col-md-2 col-sm-2">
    			
    		</div>
    		<div class="col-md-8 col-sm-8 col-xs-12">
    			<div class="row">
    				<div class="col-md-12 visible-lg hidden-xs" style="height: 220px;">
    					<img alt="" src="${pageContext.request.contextPath }/resources/images/timg5.jpg" style="width: 750px;">
    				</div>
    				<div class="col-md-12 hidden-lg hidden-xs" style="height: 110px;">
    					
    				</div>
    				<div class="col-md-12 col-xs-12">
    					
    					
    					<div class="jumbotron">
					<div class="row" id="UserLoginPage">
						<h2 class="visible-xs col-xs-offset-1" style="color:green;">人事管理登录页面</h2>
						
						<div class="col-md-12 col-lg-6 hidden-xs" style="height: 260px;">
							<img alt="" class="visible-lg visible-sm" src="${pageContext.request.contextPath }/resources/images/timg4.jpg" style="width: 310px;height: 260px">
							<img alt="" class="visible-md" src="${pageContext.request.contextPath }/resources/images/timg4.jpg" style="width: 520px;height: 260px">
						</div>
						<div class="col-md-12 col-lg-6 col-xs-12">
							 <form action="${pageContext.request.contextPath }/User/login.action" method="post">
  								<div class="form-group col-xs-12">
    								<label for="exampleInputEmail1">Username</label>
    								<input type="text" class="form-control" placeholder="Username" name="loginname" id="loginnameforlogin">
  								</div>
  								<div class="form-group col-xs-12">
    								<label for="exampleInputPassword1">Password</label>
    								<input type="password" class="form-control" placeholder="Password" name="password" id="passwordforlogin">
  								</div>
  								<div class="form-group col-xs-12">
    								<label for="Verification">Verification Code</label>
    								<div class="row">
    									<div class="col-lg-7 col-md-5 col-sm-6 col-xs-7">
    										<input type="text" class="form-control" name="username" placeholder="Verification Code" style="width: 180px;">
    									</div>
    									<div class="col-lg-5 col-md-5 col-sm-4 col-xs-4">
    										<img src="${pageContext.request.contextPath }/User/GetCheckCode.action" data-toggle="tooltip" 
    										title="看不清换一张？" data-placement="top" id="imgcheckcode" style="cursor: pointer;" class="img-thumbnail">
  										</div>
  									</div>
  								</div>
  								<input type="submit" class="btn btn-info col-md-offset-3 col-lg-offset-0 col-sm-offset-2 col-xs-offset-1" value="Login in" id="submitforlogin">
  								<button type="button" id="RegisterButton" class="btn btn-primary btn-lg" style="font-size: 10px;position: relative;left: 80px;">
  									<span class="glyphicon glyphicon-user"></span> Register
								</button>
  								<c:if test="${error !=null}">
  								<div class="alert alert-warning alert-dismissible" role="alert">
  									<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
  									<strong>Warning!</strong><font color="red"> ${error }</font> 
								</div>
  								</c:if>
							</form>
						</div>	
					</div>
					
					
					<!-- 用户注册 -->
					<div class="row" id="UserRegisterPage" style="display: none;">
						<div class="col-md-12 col-md-offset-0  col-lg-offset-0 col-lg-12 col-xs-offset-1 col-xs-10" style="background: url(${pageContext.request.contextPath }/images/page_bg.jpg);">
						<h2 class="register_text">User Registration</h2>
						<form id="registerForm">
						<div class="form-group">
    								<label for="exampleInputEmail1">登录名</label>
    								<input type="text" class="form-control" id="toRegisterByloginname" placeholder="Username" name="loginname" 
    								 data-toggle="tooltip" data-placement="bottom">
  								</div>
  								<div class="form-group">
    								<label for="exampleInputPassword1">输入密码</label>
    								<input type="password" class="form-control" id="toRegisterBypassword" placeholder="Password" name="password">
  								</div>
  								<div class="form-group">
    								<label for="exampleInputPassword1">再次输入</label>
    								<input type="password" class="form-control" id="toRegisterBypassword2" placeholder="Password">
  								</div>
  								<div class="form-group">
								<span>I have read and agree<a href="#">Membership registration agreement</a>And<a href="#">Privacy protection protocol</a></span><br>
  								<label for="">Agreement:</label>
								<input type="checkbox" id="AgreeUserCer" data-toggle="tooltip" title="请确认用户协议" data-placement="right" />
  								</div>
  								<input type="button" class="btn btn-success" value="注册" id="registerButton">
  								<button type="button" id="toLoginButton" class="btn btn-primary btn-lg" style="font-size: 10px;position: relative;left: 80px;">
  									<span class="glyphicon glyphicon-user"></span> 返回登录
								</button>
								</form>
							</div>
					</div>
					
					
					
					<div class="row">
						<div class="col-md-12">
							<div style="padding-top: 50px;">
								<font style="color: green;">
								<center>Copyright ©  SSYG 2018, All Rights Reserved</center> <br>
		  						<center>Support:2690053948@qq.com &nbsp;&nbsp;&nbsp;&nbsp;  Facebook: MIKU WU &nbsp;
							&nbsp;&nbsp;&nbsp;  Discord:Miku Wu#0853</center>
								</font>
							</div>
						</div>
					</div>
				</div>
    					
    					
    				</div>
    				
    			</div>
    		</div>
    		<div class="col-md-2 col-sm-2">
    			
    		</div>
    	</div>
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
					<input type="button" class="btn btn-primary" id="diaglogtxtsubbutton" data-dismiss="modal" value="确认"/>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>
