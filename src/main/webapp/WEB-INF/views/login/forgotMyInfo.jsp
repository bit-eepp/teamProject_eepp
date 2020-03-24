<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 / 비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login_join/loginAndJoin.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<section class="sc-forgot">
	<div class="container text-center">
		<h2>아이디 / 비밀번호 찾기</h2>
		<p class="infoText">아이디 또는 비밀번호가 생각나지 않으세요?<br>회원정보를 입력 하신 후 확인 버튼을 클릭해주세요.</p>
	</div>
	
	<div class="container text-center col-md-4 forgot-wrapper">
	
	<ul class="forgot-nav nav nav-tabs">
		<li class="nav-item findEmail">
			<a class="nav-link active" data-toggle="tab" href="#findMyEmail">아이디 찾기</a>
		</li>
		<li class="nav-item findPW">
			<a class="nav-link" data-toggle="tab" href="#findMyPW">비밀번호 찾기</a>
		</li>
	</ul>
	
	<div class="tab-content">
		<div class="tab-pane fade show active" id="findMyEmail">
    		<!-- 가입 이메일 찾기 -->
    		<div class="container">
			<div class="form-group inputUserInfo">
				<label class="title-phone">휴대폰번호</label>
					<select name="uPhone_1" class="uPhone_1 custom-select">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="019">019</option>
						<option value="080">080</option>
					</select>
					- <input type="text" name="uPhone_2" class="uPhone_2 custom-select" maxlength="4" size="6">
					- <input type="text" name="uPhone_3" class="uPhone_3 custom-select" maxlength="4" size="6">
				
				<div class="findEmailBtnWrap">
					<a class="findEmailBtn" id="findRegisterEmail">확인</a>
				</div>
			</div>
			<!-- inputUserInfo -->
			
			<div id="showMyEmail"></div>
    		</div>
    	</div>
    	<!-- #findMyEmail -->
    	
    	<div class="tab-pane fade" id="findMyPW">
    		<!-- 비밀번호 재설정 -->
			<div class="container" id="resetPasswordBox">
			
			<form:form name="f" action="resetPassword.me" method="post">
			<div class="form-group" id="findMyPW01">
				<label class="title-uEmail">회원가입시 등록한 이메일을 적어주세요.</label>
				<input type="text" name="uEmail" class="form-control uEmail" placeholder="yourEmail@example.com">
			</div>
			
			<div class="sendAuthBtnWrap">
				<a class="sendAuthBtn" id="registerInfo" onclick="sendPasswordAuth();">인증번호 전송</a>
			</div>
			
			<div id="findMyPW02">
				<input type="hidden" class="random" value="${random}" />
				<input type="text" name="forgotAuthCode" class="form-control findAuthCode" placeholder="인증번호를 입력해주세요.">
				<div class="authCheckBtnWrap">
					<a class="authCheckBtn" onclick="checkPasswordAuth();">확인</a>
				</div>
			</div>
			
			<div id="findMyPW03">
				<label class="title-changePw">비밀번호 재설정</label>
				<input type="password" name="uPassword" class="form-control uPassword">
				<label class="title-changePwCheck">비밀번호 확인</label>
				<input type="password" name="uPasswordCheck" class="form-control uPasswordCheck">
				<div class="changePwBtnWrap">
					<button type="submit" class="changePwBtn">확인</button>
				</div>
			</div>
			
		</form:form>
			</div>
			<!-- 비밀번호 재설정 -->
  		</div>
	</div>
	
	</div>
</section>

<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->

<script src="${pageContext.request.contextPath}/js/login.js"></script>

</body>
</html>