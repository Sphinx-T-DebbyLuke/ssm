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

<title>人事管理系统</title>
<!-- Bootstrap Core CSS -->
<link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet"></link>
<link type="text/css" href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
</head>

<body>
<div class="container-fluid">
	<div class="container">
		<div id="wrapper">
			<jsp:include page="top.jsp" />
			<div id="otherPage" class="row">
				
<section class="banner">
<ul>
<li class="active visible-lg">
<div id="myCarousel" class="carousel slide" style="width: 600px;height: 350px;">
	<!-- 轮播（Carousel）指标 -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
		<li data-target="#myCarousel" data-slide-to="3"></li>
		<li data-target="#myCarousel" data-slide-to="4"></li>
	</ol>   
	<!-- 轮播（Carousel）项目 -->
	<div class="carousel-inner">
		<div class="item active">
			<img src="${pageContext.request.contextPath }/resources/images/tag/tag2.gif" alt="First slide" style="width:600px;height: 350px;"/>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath }/resources/images/tag/tag.gif" alt="Second slide" style="width:600px;height: 350px;"/>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath }/resources/images/tag/tag3.gif" alt="Third slide" style="width:600px;height: 350px;"/>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath }/resources/images/tag/tag4.gif" alt="Third slide" style="width:600px;height: 350px;"/>
		</div>
		<div class="item">
			<img src="${pageContext.request.contextPath }/resources/images/tag/tag5.gif" alt="Third slide" style="width:600px;height: 350px;"/>
		</div>
	</div>
	<!-- 轮播（Carousel）导航 -->
	<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		<span class="sr-only">Previous</span>
	</a>
	<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		<span class="sr-only">Next</span>
	</a>
</div> 
</li>
</ul>
</section>

					
		<section class="main">
			<aside class="midleft hidden-md">
				<h1>系统简介</h1>
				<dl>
					<dt>Q: 什么是人事管理系统?</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/06_04.png" /></dd>
					<dd>人事管理系统是办公自动化的小小体现，它为人事管理大量有繁琐的员工数据工作提供了方便，提高了人事管理工作的效率，为办公自动化的普及奠定了基础...</dd>
				</dl>
				<dl>
					<dt>Q: 人事管理的效率</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/05_05.png" /></dd>
					<dd>认识管理系统能够为用户提供充足的信息和快捷的查询手段。使用计算机对人事资料进行管理，会给使用者带来诸多方便，例如检索迅速、查找方便、可靠性高、储存量大、保密性好、寿命长、成本低...</dd>
				</dl>
				<dl>
					<dt>Q: 人事管理产生背景</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/09_07.png" /></dd>
					<dd>当企业职工人数达上万人时，人力进行人事管理任务艰巨。随着信息技术的发展，人们对于运用计算机来辅助，协调和管理自身工作的需要正在逐步提高。在计算机、网络等技术发展相对快的国家，基本上创...</dd>
				</dl>
				<dl>
					<dt>Q: 发展道路</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/02_09.png" /></dd>
					<dd> 这是企业的科学化、正规化管理以及世界先进管理技术接轨的重要条件。人事管理系统是现代企业管理工作不可或缺的一部分，是适应现代企业制度要求、推动企业劳动人事管理走向科学化、规范化的必要条...</dd>
				</dl>
				

			</aside>
			<article class="midright visible-lg">
				<h1>系统介绍<span>你理想的系统</span></h1>
				<img src="${pageContext.request.contextPath }/resources/images/timg.jpg" style="width: 90%;"/>
			</article>
			<div class="col-md-12 visible-md">
			<h1>系统简介</h1>
				<dl>
					<dt>Q: 什么是人事管理系统?</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/06_04.png" /></dd>
					<dd>人事管理系统是办公自动化的小小体现，它为人事管理大量有繁琐的员工数据工作提供了方便，提高了人事管理工作的效率，为办公自动化的普及奠定了基础...</dd>
				</dl>
				<dl>
					<dt>Q: 人事管理的效率</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/05_05.png" /></dd>
					<dd>认识管理系统能够为用户提供充足的信息和快捷的查询手段。使用计算机对人事资料进行管理，会给使用者带来诸多方便，例如检索迅速、查找方便、可靠性高、储存量大、保密性好、寿命长、成本低...</dd>
				</dl>
				<dl>
					<dt>Q: 人事管理产生背景</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/09_07.png" /></dd>
					<dd>当企业职工人数达上万人时，人力进行人事管理任务艰巨。随着信息技术的发展，人们对于运用计算机来辅助，协调和管理自身工作的需要正在逐步提高。在计算机、网络等技术发展相对快的国家，基本上创...</dd>
				</dl>
				<dl>
					<dt>Q: 发展道路</dt>
					<dd><img src="${pageContext.request.contextPath }/resources/images/date/02_09.png" /></dd>
					<dd> 这是企业的科学化、正规化管理以及世界先进管理技术接轨的重要条件。人事管理系统是现代企业管理工作不可或缺的一部分，是适应现代企业制度要求、推动企业劳动人事管理走向科学化、规范化的必要条...</dd>
				</dl>
				</div>
				<div class="col-md-12 visible-md">
					<h1>系统介绍<span>你理想的系统</span></h1>
					<img src="${pageContext.request.contextPath }/resources/images/timg.jpg" style="width: 50%;"/>
					<img src="${pageContext.request.contextPath }/resources/images/timg2.jpg" style="width: 40%;"/>
				</div>
		</section>



			</div>
</div>
	</div>
</div>
</body>

</html>
