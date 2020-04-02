<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>400 Bad Request</title>
<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:900" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/errorPage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
	<div id="pageNotWorking">
		<div class="pageNotWorking">
			<div class="pageNotWorking-400">
				<h3>Oops! Bad Request</h3>
				<h1><span>4</span><span>0</span><span>0</span></h1>
			</div>
			<h2>문제가 계속되면 Community EE에 문의해주세요.</h2>
			<p class="backToHome"><a href="${pageContext.request.contextPath}">EE 메인홈으로</a></p>
		</div>
	</div>
</body>
</html>