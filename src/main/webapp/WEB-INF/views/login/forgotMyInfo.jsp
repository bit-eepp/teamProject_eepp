<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/loginAndJoin.css">
<%@ include file="/WEB-INF/include/header.jspf"%>
</head>
<body>
	<br>
	<br>

	<div class="container text-center">
		<h1 style="text-align: center; width: 15%; margin: 0 auto">
			<img style="max-width: 100%" src="${pageContext.request.contextPath}/img/EE_logo.png" />
		</h1>
		<p style="text-align: center; font-weight:bold; margin:0;">Community EE</p>
		<p style="text-align: center; font-weight:bold; margin:0;">비밀번호 재설정</p>
		<p class="infoText">아이디 또는 비밀번호가 생각나지 않으세요?<br>
		회원정보를 입력 하신 후 확인 버튼을 클릭해주세요.</p>
	</div>
	
	<div class="container text-center">
	<div id="selectView">
	<button type="button" class="btn btn-select btn-lg" id="showEmailBox">가입이메일 찾기</button>
	<button type="button" class="btn btn-select btn-lg" id="showPasswordBox">비밀번호 재설정</button>
	</div>
	
	<!-- 가입 이메일 찾기 -->
	<div class="container col-md-4" id="findEmailBox" action="login.do" method="post">

		<form:form name="f">

			<div class="form-group">
				<div class="form-group">
						<label for="exampleFormControlInput1">핸드폰번호</label>
						 <select name="uPhone_1" class="custom-select uPhone_1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="019">019</option>
							<option value="080">080</option>
						</select> - <input type="text" name="uPhone_2" class="uPhone_2" maxlength="4" size="6">
						- <input type="text" name="uPhone_3" class="uPhone_3" maxlength="4" size="6">
					</div>
			</div>
			
			<div id="email_step01">
			<button type="button" class="btn btn-primary" id="InfoforEmail" onclick="findRegisterEmail();">확인</button>
			<button type="cancle" class="btn btn-primary cancle">취소</button>
			</div>
			
			<div id="email_step02">
			<div id="showMyEmail"></div>
			<button type="button" class="btn btn-primary" id="showPasswordBox02">비밀번호 재설정</button>
			<button type="submit" class="btn btn-primary" id="SignIn">로그인</button>
			</div>
		</form:form>

	</div>
	
	<!-- 비밀번호 재설정 -->
	<div class="container col-md-4" id="resetPasswordBox">

		<form:form name="f" action="resetPassword.me" method="post">
		
			<div class="form-group">
				<label for="exampleFormControlInput1">이메일</label>
				<p>회원가입시 등록한 이메일을 적어주세요.</p>
				<input type="text" name="uEmail" class="form-control uEmail" id="exampleFormControlInput1" placeholder="yourEmail@example.com">
			</div>
			
			<div id="pw_step01">
			<button type="button" class="btn btn-primary" id="registerInfo" onclick="sendPasswordAuth();">확인</button>
			<button type="cancle" class="btn btn-primary cancle">취소</button>
			</div>
			
			<div class="form-group" id="pw_step02">
				<label for="exampleFormControlInput1">인증번호</label>
				<input type="hidden" path="random" class="random" value="${random}" />
				<input type="text" name="forgotAuthCode" class="form-control forgotAuthCode" id="exampleFormControlInput1">
				<button type="button" class="btn btn-primary" id="authIsCorrect" onclick="checkPasswordAuth();">확인</button>
			</div>
			
			<div class="form-group" id="pw_step03">
				<label for="exampleFormControlInput1">비밀번호 재설정</label>
				<input type="text" name="uPassword" class="form-control uPassword" id="exampleFormControlInput1">
				<label for="exampleFormControlInput1">비밀번호 확인</label>
				<input type="text" name="uPasswordCheck" class="form-control uPasswordCheck" id="exampleFormControlInput1">
				<button type="submit" class="btn btn-primary">확인</button>
			</div>
			
		</form:form>

	</div>
	</div>
	
<script src="${pageContext.request.contextPath}/js/login.js"></script>

</body>
</html>