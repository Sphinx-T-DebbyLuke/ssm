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
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/bootstrap-table.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/qiandao.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/qiandao.css" rel="stylesheet"></link>
</head>

<body>
    <div class="container-fluid">
	<div class="container">
		<div id="wrapper">
			<jsp:include page="top.jsp" />
			<div id="otherPage">





    <div class="row">
        <c:if test="${username.emp_id==0}">
            <div class="col-lg-12" style="height: 50px;"></div>
            <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3">
                <img src="${pageContext.request.contextPath}/resources/images/qiandao/haha.png" style="width: 100%;"/>
            </div>
        </c:if>
        <c:if test="${username.emp_id!=0}">
            <div class="qiandao-warp visible-lg">
                <input type="hidden" id="currentMon"/>
                <input type="hidden" id="dataString"/>
                <div class="qiandap-box">
                    <div class="qiandao-con clear">
                        <div class="qiandao-left">
                            <div class="qiandao-left-top clear">
                                <div class="current-date">2020年1月1日</div>
                            </div>
                            <div class="qiandao-main" id="js-qiandao-main">
                                <ul class="qiandao-list" id="js-qiandao-list">
                                </ul>
                            </div>
                        </div>
                        <div class="qiandao-right">
                            <div class="qiandao-top">
                                <div class="just-qiandao qiandao-sprits" id="js-just-qiandao">
                                </div>
                                <p class="qiandao-notic" id="qiandao-notic1" style="display: none;">今日已签到，请明日继续签到</p>
                                <p class="qiandao-notic" id="qiandao-notic2">今日还未签到，请注意签到哦</p>
                            </div>
                            <div class="qiandao-bottom">
                                <div class="qiandao-rule-list">
                                    <br/>
                                    <br/>
                                    <h4>该月共签到数：</h4>
                                    <p id="qiandaoNum"></p>
                                </div>
                                <div class="qiandao-rule-list">
                                    <h4>该月可获薪水约：</h4>
                                    <p id="salary"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- 签到 layer start -->
            <div class="qiandao-layer qiandao-active" >
                <div class="qiandao-layer-con qiandao-radius" style="height: 200px;">
                    <a href="javascript:;" class="close-qiandao-layer qiandao-sprits"></a>
                    <div class="yiqiandao clear">
                        <div class="yiqiandao-icon qiandao-sprits"></div>
                    </div>
                </div>
            </div>
        </c:if>




    </div>



			</div>
		</div>
	</div>
</div>
</body>



</html>
