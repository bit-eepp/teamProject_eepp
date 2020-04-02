<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러가 발생했습니다.</title>
<!-- Google font -->
<link href="https://fonts.googleapis.com/css?family=Cabin:400,700" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Montserrat:900" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/errorPage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
	<div id="isErrorPage">
		<div class="isErrorPage">
			<div class="isErrorPage-er">
				<h3>Oops!</h3>
				<h1><span>e</span><span>r</span><span>r</span><span>o</span><span>r</span></h1>
			</div>
			<h2>죄송합니다. 기술적인 문제로 일시적으로 접속되지 않았습니다.<br>
			잠시 후 다시 이용 부탁드리며 이용에 불편을 드려 사과드립니다.</h2>
			<p class="backToHome"><a href="${pageContext.request.contextPath}">EE 메인홈으로</a></p>
		</div>
	</div>
</body>
</html>