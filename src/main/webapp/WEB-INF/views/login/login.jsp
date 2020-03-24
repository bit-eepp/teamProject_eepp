<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login_join/loginAndJoin.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<section class="sc-login">
<div class="normal-login-wrap">
	<div class="container text-center">
		<p class="loginMainTitle">직장인 커뮤니티
		<img src="${pageContext.request.contextPath}/img/EE_logo.png">에서
		<br>즐거운 담소를 나누어보세요.</p>
	</div>

	<div class="container col-md-4">

		<form:form name="f" class="px-4" action="${pageContext.request.contextPath}/nomal_login.do" method="post">

			<div class="form-group">
				<input type="text" class="form-control" name="uEmail" placeholder="아이디">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" name="uPassword" placeholder="비밀번호">
			</div>
			
			<c:if test="${failedLogin != null}">
				<p class="faildLogin">아이디 또는 비밀번호가 잘못되었습니다.</p>
			</c:if>
			
			<div class="form-check">
	              <label class="form-check-label rememberMeCheck">
	              <input type="checkbox" class="form-check-input" name="rememberMe">
	              로그인 상태 유지
	              </label>
	        </div>
	        
	        <div class="loginOrRegister">
	        	<div class="loginBtn"><button type="submit">로그인</button></div>
	        	<div class="registerBtn"><a href="${pageContext.request.contextPath}/join/register">회원가입</a></div>
	        	<div class="forgotBtn"><a href="${pageContext.request.contextPath}/login/forgotMyInfo">아이디 / 비밀번호 찾기</a></div>
	        </div>
		</form:form>
		</div>
</div>
</section>

<section class="sc-snsLogin">
	<div class="container col-md-4 snsBtnWrap">
		<h6 class="snsLoginTitle">SNS간편로그인</h6>
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
</section>
	
<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->

</body>
</html>