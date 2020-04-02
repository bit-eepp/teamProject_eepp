<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>500 InternalError</title>
<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:900" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/errorPage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
	<div id="InternalError">
		<div class="internalError">
			<div class="internalError-500">
				<h3>Oops! Internal Server Error</h3>
				<h1><span>5</span><span>0</span><span>0</span></h1>
			</div>
			<h2>요청 처리 과정에서 에러가 발생하였습니다.<br>빠른시간 내에 문제를 해결하도록 하겠습니다.</h2>
			<p class="backToHome"><a href="${pageContext.request.contextPath}">EE 메인홈으로</a></p>
		</div>
	</div>
</body>
</html>