<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>聚成教育-网上学习</title>
    <link rel="shortcut icon" href="${path }/static/proscenium/logo/favicon2.ico" />
	<link href="${path }/static/proscenium/css/bootstrap.min.css" rel="stylesheet">
	<link href="${path }/static/proscenium/css/style.css" rel="stylesheet">

</head>
<body>
<div class="wrapper">
    <jsp:include page="/static/proscenium/commons/head.jsp"></jsp:include>
    <div><img src="${path }/static/proscenium/images/learn.jpg" width="100%"></div>
    <div class="container">
        <div class="row clearfix" style="text-align: center;margin-top: 20px; color: #d58512;">
            <div class="col-xs-4 column">
                <a href="http://m.kuaiji.com/">
                    <img alt="80x80" src="${path }/static/proscenium/icon/clock.png" class="img-circle apply-ico" />
                    <br>
                    <span class="home_operation">会计网</span>
                </a>
            </div>
            <div class="col-xs-4 column">
                <a href="http://m.yikaow.com/">
                    <img alt="80x80" src="${path }/static/proscenium/icon/compose.png" class="img-circle apply-ico" />
                    <br>
                    <span class="home_operation">艺考网</span>
                </a>
            </div>
            <div class="col-xs-4 column">
                <a href="http://m.jxzkwz.com/">
                    <img alt="80x80" src="${path }/static/proscenium/icon/document.png" class="img-circle apply-ico" />
                    <br>
                    <span class="home_operation">成考网</span>
                </a>
            </div>
        </div>
    </div>
    <jsp:include page="/static/proscenium/commons/bottom.jsp"></jsp:include>
    
</div>
<jsp:include page="/static/proscenium/commons/scroll.jsp"></jsp:include>
<!--	*******************************************************  -->
<script src="${path }/static/proscenium/js/jquery.min.js"></script>
<script src="${path }/static/proscenium/js/bootstrap.min.js"></script>
<script src="${path }/static/proscenium/plugin/goup/jquery.goup.min.js"></script>
<script src="${path }/static/proscenium/js/app.js"></script>
</body>
</html>