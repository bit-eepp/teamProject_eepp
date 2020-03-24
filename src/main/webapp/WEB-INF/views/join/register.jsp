<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EE 회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login_join/loginAndJoin.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<section class="sc-chooseJoin">
<h2 class="welcomeEE"><span>e</span>mployees<span>,</span><br><span>e</span>scape from work</h2>
<p class="subTitle">EE는 대한민국 직장인을 위한 커뮤니티입니다.<br>
계정 생성 후<img src="${pageContext.request.contextPath}/img/EE_logo.png">의 모든 기능을 이용하실 수 있습니다.</p>
	
	<div class="container col-md-4 normalBtnWrap">
		<div class="normal_join">
			<div class="registerBtn">
				<a href="${pageContext.request.contextPath}/join/joinForm">일반회원가입</a>
			</div>
	    </div>
	</div>
	
	<div class="container col-md-4 snsBtnWrap">
		<h6 class="snsLoginTitle">SNS회원가입</h6>
			<div class="sns_login_button">
				<span>
					<button class="naverBtn" type="button" onclick="location.href='${naver_url}'">
						<img src="${pageContext.request.contextPath}/img/naver_account_login_small.PNG"/>
					</button>
				</span>
				
				<span>
					<button class="kakaoBtn" type="button" onclick="location.href='${kakao_url}'">
						<img src="${pageContext.request.contextPath}/img/kakao_account_login_small.png"/>
					</button>
				</span>
				
				<span>
					<button class="googleBtn" type="button" onclick="location.href='${google_url}'">
						<img src="${pageContext.request.contextPath}/img/google_account_login_small.png"/>
					</button>
				</span>
			</div>
</div>
<p class="isMember"><a href="${pageContext.request.contextPath}/login/login.do">이미 계정이 있으신가요?</a></p>
</section>
<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->

</body>
</html>