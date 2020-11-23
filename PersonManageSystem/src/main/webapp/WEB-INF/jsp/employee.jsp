<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/employee.js"></script>
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

					<li><a href="#" class="active" id="EmpSelect"><span class="glyphicon glyphicon-th-list"></span><br class="visible-md"/> <span id="listordetail">员工查询</span></a></li>
					<li><a href="#" class="active" id="EmpAdd"><span class="glyphicon glyphicon-user"></span><br class="visible-md"/> 添加员工</a></li>
			
				</ul>
				
			</div>
			<!-- /.sidebar-collapse -->
		</div>
	
	</div>
	
	
	<div class="col-md-10" id="managePage">
		<!-- 用户查询 -->
		<div id="EmpSelect">
		<c:if test="${empty pageSize.emplist}">
			<div id="page-wrapper">
				
				<img id="nodataimg" style="width: 80%;height: 80%;display: none;" src="${pageContext.request.contextPath }/resources/images/nodata.gif">
				
			</div>
		</c:if>
		<c:if test="${not empty pageSize.emplist}">
			<div id="page-wrapper">
			
			<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/Emp/EmpList.action" method="post" id="form1">
						<div class="row">
						
						
							<div class="col-md-12">
								<div class="form-group col-md-3">
									<label for="name">名称:</label> 
									<input type="text" class="form-control" id="name" value="${pageSize.emp.name}" name="emp.name"/>
								</div>
								<div class="form-group col-md-3">
									<label for="card_id">身份证号码:</label> 
									<input type="text" class="form-control" id="card_id" value="${pageSize.emp.card_id}" name="emp.card_id"/>
								</div>
								<div class="form-group col-md-3">
									<label for="jobstatus">在职/离职:</label> 
									<select name="emp.jobstatus" class="form-control" id="jobstatus">
										<option value="">--请选择--</option>
										<option value="1"
											<c:if test="${pageSize.emp.jobstatus==1 }">selected</c:if>
										>在职</option>
										<option value="0"
											<c:if test="${pageSize.emp.jobstatus==0 }">selected</c:if>
										>离职</option>
									</select>
								</div>
							</div>
							
							
							
							<div class="col-md-12">
									<div class="form-group col-md-3">
							<label for="sex">性别:</label> 
							<select name="emp.sex" class="form-control" id="sex">
								<option value="">--请选择--</option>
								<option value="1"
									<c:if test="${pageSize.emp.sex==1 }">selected</c:if>
								>男</option>
								<option value="0"
									<c:if test="${pageSize.emp.sex==0 }">selected</c:if>
								>女</option>
							</select>
						</div>
						<div class="form-group col-md-3">
							<label for="job_id">职位:</label> 
							<select name="emp.job.id" class="form-control" id="job_id">
								<option value="">--请选择--</option>
								<c:forEach items="${jobTableList }" var="job">
									<option value="${job.id}"
										<c:if test="${pageSize.emp.job.id==job.id }">selected</c:if>
									>${job.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group col-md-3">
							<label for="dept_id">所属部门:</label> 
							<select name="emp.dept.id" class="form-control" id="dept_id">
								<option value="">--请选择--</option>
								<c:forEach items="${deptTableList }" var="dept">
									<option value="${dept.id}" 
										<c:if test="${pageSize.emp.dept.id==dept.id }">selected</c:if>
									>${dept.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-md-3">
							<input type="hidden" name="perPageSize" value="${pageSize.perPageSize}">
							<button type="submit" class="btn btn-primary">查询</button>
						</div>
							</div>
							
							
						</div>
						
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">员工信息列表
						<small>(<span class="glyphicon glyphicon-eye-open"></span>表示在职;<span class="glyphicon glyphicon-eye-close"></span>表示已离职)</small></div>
						<!-- /.panel-heading -->
						<form id="formbydelete">
						<table class="table table-bordered table-striped table-hover">
							<thead>
								<tr>
									<th style="width: 60px;"><input type="checkbox" id="selectalldelete" data-toggle="tooltip" title="全选" >&nbsp;&nbsp;
									<a href="#" data-toggle="tooltip" title="批量删除" class="glyphicon glyphicon-trash" style="display: none;" id="alldeleteBychecked"></a>
									</th>
									<th>姓名</th>
									<th>性别</th>
									<th>手机号码</th>
									<th>职位</th>
									<th>部门</th>
									<th>建档日期</th>
									<th>操作</th>
								</tr>
								
							</thead>
							<tbody>
								<c:forEach items="${pageSize.emplist}" var="emp">
									<tr>
										<td><input type="checkbox" name="ids" value="${emp.id}"></td>
										<td>
										<c:if test="${emp.jobstatus==1}">
											<span class="glyphicon glyphicon-eye-open"></span>
										</c:if>
										<c:if test="${emp.jobstatus==0}">
											<span class="glyphicon glyphicon-eye-close"></span>
										</c:if>
										${emp.name}</td>
										<td>
											<c:if test="${emp.sex==0}">女</c:if>
											<c:if test="${emp.sex==1}">男</c:if>
										</td>
										<td>${emp.phone}</td>
										<td>${emp.job.name}</td>
										<td>${emp.dept.name}</td>
										<td>${emp.create_dateStr}</td>
										<td>
											<a href="#" class="glyphicon glyphicon-list-alt" data-toggle="tooltip" title="详细信息" onclick="editEmpByid(${emp.id})"></a>
											&nbsp;&nbsp;&nbsp;<a href="#" class="glyphicon glyphicon-trash" onclick="deleteEmpByid(${emp.id})"></a>
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
      <a href="${pageContext.request.contextPath }/Emp/EmpList.action?currentPage=${pageSize.currentPage-1}&emp.name=${pageSize.emp.name}&emp.card_id=${pageSize.emp.card_id}&emp.jobstatus=${pageSize.emp.jobstatus}&perPageSize=${pageSize.perPageSize}
      &emp.sex=${pageSize.emp.sex}&emp.job.id=${pageSize.emp.job.id}&emp.dept.id=${pageSize.emp.dept.id}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
   </c:if>
    <c:if test="${pageSize.totalPageSize!=1 }">
    	<c:forEach  var="p" begin="1" end="${pageSize.totalPageSize }">
  		 <li><a href="${pageContext.request.contextPath }/Emp/EmpList.action?currentPage=${p}&emp.name=${pageSize.emp.name}&emp.card_id=${pageSize.emp.card_id}&emp.jobstatus=${pageSize.emp.jobstatus}&perPageSize=${pageSize.perPageSize}
      &emp.sex=${pageSize.emp.sex}&emp.job.id=${pageSize.emp.job.id}&emp.dept.id=${pageSize.emp.dept.id}">${p }</a></li>
  		</c:forEach>
    </c:if>
  <c:if test="${pageSize.currentPage<pageSize.totalPageSize}">
  	<li>
      <a href="${pageContext.request.contextPath }/Emp/EmpList.action?currentPage=${pageSize.currentPage+1}&emp.name=${pageSize.emp.name}&emp.card_id=${pageSize.emp.card_id}&emp.jobstatus=${pageSize.emp.jobstatus}&perPageSize=${pageSize.perPageSize}
      &emp.sex=${pageSize.emp.sex}&emp.job.id=${pageSize.emp.job.id}&emp.dept.id=${pageSize.emp.dept.id}" aria-label="Next">
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
		
		
		<!-- 员工详细信息 -->
<div id="empdetail" style="display: none;">
	<div class="panel panel-default">
				<div class="panel-body">
					<form class="form-inline" action="${pageContext.request.contextPath }/Emp/EmpUpdateByemp.action" id="edit_emp_form" enctype="multipart/form-data" method="post">
						<input type="hidden" name="id" id="ee_id">
						<input type="hidden" name="imageUrl" id="ee_imageUrl">
						<div class="row" id="emptabletoUpdate">
							<div class="row">
								<div class="col-xs-12 visible-xs">
									<center><img src="" style="width: 170px;height:170px;cursor: pointer;" class="img-circle" data-toggle="tooltip" title="点击上传头像"></center>
								</div>
								<div class="col-lg-9 col-md-9 col-sm-8 col-xs-12">
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_name"><font color="red">*</font>姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label><input type="text" name="name" class="form-control" id="ee_name" style="width: 100%;"></div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_sex"><font color="red">*</font>性&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
										<select name="sex" class="form-control" id="ee_sex" style="width: 100%;">
											<option value="">--请选择--</option>
											<option value="1">男</option>
											<option value="0">女</option>
										</select>
									</div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_party">政治面貌:</label><input type="text" class="form-control" name="party" id="ee_party" style="width: 100%;"/></div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_race">民&nbsp;&nbsp;&nbsp;&nbsp;族：</label><input type="text" class="form-control" name="race" id="ee_race" style="width: 100%;"/></div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_education">学&nbsp;&nbsp;&nbsp;&nbsp;历:</label><input type="text" class="form-control" name="education" id="ee_education" style="width: 100%;"/></div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_birthday"><font color="red">*</font>出生年月：</label><input type="text" class="form-control" name="birthday" id="ee_birthday" style="width: 100%;"/></div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_phone"><font color="red">*</font>手机号:</label><input type="text" class="form-control" name="phone" id="ee_phone" style="width: 100%;"/></div>
									<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6"><label for="ee_tel">电话号：</label><input type="text" class="form-control" name="tel" id="ee_tel" style="width: 100%;"/></div>
								</div>
								<div class="col-lg-3 col-md-3 col-sm-4 hidden-xs">
									<center><img src="" style="width: 170px;height:170px;cursor: pointer;" class="img-circle" data-toggle="tooltip" title="点击上传头像"></center>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-3 col-md-3 col-sm-3 col-xs-6"><label for="ee_qq_num">QQ号码:</label><input type="text" class="form-control" name="qq_num" id="ee_qq_num" style="width: 100%;"/></div>
								<div class="col-lg-3 col-md-3 col-sm-3 col-xs-6"><label for="ee_email"><font color="red">*</font>邮&nbsp;&nbsp;&nbsp;&nbsp;箱：</label><input type="text" class="form-control" name="email" id="ee_email" style="width: 100%;"/></div>
								<div class="col-lg-3 col-md-3 col-sm-3 col-xs-6"><label for="ee_hobby">爱&nbsp;&nbsp;&nbsp;&nbsp;好:</label><input type="text" class="form-control" name="hobby" id="ee_hobby" style="width: 100%;"/></div>
								<div class="col-lg-3 col-md-3 col-sm-3 col-xs-6"><label for="ee_speciality">所学专业：</label><input type="text" class="form-control" name="speciality" id="ee_speciality" style="width: 100%;"/></div>
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"><label for="ee_card_id"><font color="red">*</font>身份证号:</label><input type="text" class="form-control" name="card_id" style="width: 100%;" id="ee_card_id"/></div>
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"><label for="ee_address"><font color="red">*</font>联系地址：</label><input type="text" class="form-control" id="ee_address" name="address" style="width: 100%;"/></div>
							</div>
							<div class="row">
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12"><label for="ee_remark">个人简介：</label><textarea rows="2" name="remark" id="ee_remark" class="form-control" style="width: 100%;height: 157px;resize: none;"></textarea></div>
								<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6"><label for="ee_job_id"><font color="red">*</font>职&nbsp;&nbsp;&nbsp;&nbsp;位：</label>
										<select name="job.id" class="form-control" id="ee_job_id" style="width: 100%;">
											<option value="">--请选择--</option>
											<c:forEach items="${jobTableList }" var="job">
												<option value="${job.id}">${job.name}</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-6"><label for="ee_dept_id"><font color="red">*</font>所属部门：</label>
										<select name="dept.id" class="form-control" id="ee_dept_id" style="width: 100%;">
											<option value="">--请选择--</option>
											<c:forEach items="${deptTableList }" var="dept">
												<option value="${dept.id}">${dept.name}</option>
											</c:forEach>
										</select>
									</div>
									<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
										<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
											<label for="ee_post_code">邮政编码：</label><input type="text" class="form-control" name="post_code" id="ee_post_code" style="width: 100%;"/>
										</div>
										<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
											<label for="ee_jobstatus"><font color="red">*</font>在职/离职：</label>
											<select name="jobstatus" class="form-control" id="ee_jobstatus" style="width: 100%;">
												<option value="">--请选择--</option>
												<option value="1">在职</option>
												<option value="0">离职</option>
											</select>									
										</div>
									</div>
								</div>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<input type="file" class="btn btn-info" style="width: 90px;display: none;" name="multipartFile">
									<div style="padding-top: 10px;">
										<center><input style="width: 170px;display: none;" type="button" class="btn btn-success" value="更改信息"></center>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
</div>

		
		
		
		
		<!-- 添加用户 -->
		<div id="EmpAdd" style="display: none;">
			<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">添加员工</h1>
					
				</div>
				<!-- /.col-lg-12 -->
			</div>
			
				<div class="col-lg-12">
					<div class="panel panel-default">
					<div class="panel-body">
						<form class="form-inline" action="${pageContext.request.contextPath }/Emp/EmpAdd.action" method="post" id="formadd" >
								<div class="row" id="table2" >
									<div class="col-lg-3 col-md-4 col-sm-4">
											<label for="name"><font color="red">*</font>姓&nbsp;&nbsp;&nbsp;&nbsp;名:</label>
											<input type="text" class="form-control" name="name" id="name"/>
									</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="card_id"><font color="red">*</font>身份证号:</label>
												<input type="text" class="form-control" name="card_id" id="card_id"/>
									</div>
										<div class="col-lg-3 col-md-4 col-sm-4">
											<label for="education">学&nbsp;&nbsp;&nbsp;&nbsp;历:</label>
											<input type="text" class="form-control" name="education" id="education"/>
										</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="sex"><font color="red">*</font>性&nbsp;&nbsp;&nbsp;&nbsp;别:</label>
												<select name="sex" class="form-control" id="sex" style="width: 100%;">
													<option value="">--请选择--</option>
													<option value="1">男</option>
													<option value="0">女</option>
												</select>
									</div>
									
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="email"><font color="red">*</font>邮&nbsp;&nbsp;&nbsp;&nbsp;箱:</label>
												<input type="text" class="form-control" name="email" id="email"/>
									</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="phone"><font color="red">*</font>手机号码:</label>
												<input type="text" class="form-control" name="phone" id="phone"/>
									</div>
										<div class="col-lg-3 col-md-4 col-sm-4">
											<label for="tel">电&nbsp;&nbsp;&nbsp;&nbsp;话:</label>
											<input type="text" class="form-control" name="tel" id="tel"/>
										</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="job_id"><font color="red">*</font>职&nbsp;&nbsp;&nbsp;&nbsp;位:</label>
												<select name="job.id" class="form-control" id="job_id" style="width: 100%;">
													<option value="">--请选择--</option>
													<c:forEach items="${jobTableList }" var="job">
														<option value="${job.id}">${job.name}</option>
													</c:forEach>
												</select>
									</div>
									
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="race">民&nbsp;&nbsp;&nbsp;&nbsp;族:</label>
												<input type="text" class="form-control" name="race" id="race"/>
									</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="party">政治面貌:</label>
												<input type="text" class="form-control" name="party" id="party"/>
									</div>
										<div class="col-lg-3 col-md-4 col-sm-4">
											<label for="qq_num">QQ号码:</label>
											<input type="text" class="form-control" name="qq_num" id="qq_num"/>
										</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="dept_id"><font color="red">*</font>所属部门:</label>
												<select name="dept.id" class="form-control" id="dept_id" style="width: 100%;">
													<option value="">--请选择--</option>
													<c:forEach items="${deptTableList }" var="dept">
														<option value="${dept.id}">${dept.name}</option>
													</c:forEach>
												</select>
									</div>
									
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="hobby">爱&nbsp;&nbsp;&nbsp;&nbsp;好:</label>
												<input type="text" class="form-control" name="hobby" id="hobby"/>
									</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="post_code">邮政编码:</label>
												<input type="text" class="form-control" name="post_code" id="post_code"/>
									</div>
										<div class="col-lg-3 col-md-4 col-sm-4">
											<label for="speciality">所学专业:</label>
											<input type="text" class="form-control" name="speciality" id="speciality"/>
										</div>
									<div class="col-lg-3 col-md-4 col-sm-4">
												<label for="birthday"><font color="red">*</font>出生日期:</label>
												<input type="text" class="form-control" name="birthday" id="birthday"/>
									</div>
									
									<div class="col-lg-6 col-md-8 col-sm-8">
												<label for="address"><font color="red">*</font>联系地址:</label>
												<input type="text" class="form-control" name="address" id="address" style="width: 100%;"/>
									</div>
									<div class="col-lg-6 col-md-8 col-sm-8">
												<label for="remark">备&nbsp;&nbsp;&nbsp;&nbsp;注:</label>
												<input type="text" class="form-control" name="remark" id="remark" style="width: 100%;"/>
									</div>
									
									<div class="col-lg-3 col-md-12 col-sm-12">
											<button type="submit" class="btn btn-primary" id="buttonaddEmp">添加</button>
											<input type="button" class="btn btn-success" value="重置" id="resetEmp"/>
											
									</div>
								</div>

							
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




	
	




	</div>
</div>
  
  

  </body>
</html>
