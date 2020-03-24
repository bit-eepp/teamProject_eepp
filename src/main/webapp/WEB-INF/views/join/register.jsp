<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login_join/loginAndJoin.css">
<%@ include file="/WEB-INF/include/header.jspf"%>
</head>
<body>
	<br>
	<br>

	<div class="container text-center">
		<div class="company-box">
		<h1 style="text-align: center; width: 15%; margin: 0 auto">
			<img style="max-width: 100%" src="${pageContext.request.contextPath}/img/EE_logo.png" />
		</h1>
		<p style="text-align: center; font-weight:bold; margin:0;">Community EE</p>
		</div>
	</div>

	<div class="container col-md-4">

		<form:form name="f" class="px-4 py-3" action="${pageContext.request.contextPath}/join/joinForm" method="post">
		<button class="btn btn-normalJoin">일 반 회 원 가 입</button>
		</form:form>
		
		<hr>
		
		<div class="snsJoin" class="px-4 py-3">
		<h6 style="text-align:center; margin-bottom:20px;">S N S 간 편 회 원 가 입</h6>
			<div class="sns_login_button">
			
			<form:form name="f" class="px-4 py-3" action="${naver_url}">
			<input type="hidden" name="naver_join" value="naverjoin">
					<button style="">
						<img style="max-width:100%"
							src="${pageContext.request.contextPath}/img/naver_account_login_small.PNG"/>
					</button>
			</form:form>
			
			<form:form name="f" class="px-4 py-3" action="${kakao_url}">
			<input type="hidden" name="kakao_join" value="kakaojoin">
					<button style="">
						<img style="max-width:100%"
							src="${pageContext.request.contextPath}/img/kakao_account_login_small.png"/>
					</button>
			</form:form>
			
			<form:form name="f" class="px-4 py-3" action="${google_url}">
			<input type="hidden" name="google_join" value="googlejoin">
					<button style="">
						<img style="max-width:100%"
							src="${pageContext.request.contextPath}/img/google_account_login_small.png"/>
					</button>
			</form:form>
			
			</div>
		</div>

	</div>

</body>
</html>