<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>존재하지 않는 페이지입니다.</title>
<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:900" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/errorPage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
	<div id="notfound">
		<div class="notfound">
			<div class="notfound-404">
				<h3>Oops! Page not found</h3>
				<h1><span>4</span><span>0</span><span>4</span></h1>
			</div>
			<h2>요청하신 페이지가 제거되었거나, 이름이 변경되었거나,<br>일시적으로 사용이 중단되었습니다.</h2>
			<p class="backToHome"><a href="${pageContext.request.contextPath}">EE 메인홈으로</a></p>
		</div>
	</div>
</body>
</html>