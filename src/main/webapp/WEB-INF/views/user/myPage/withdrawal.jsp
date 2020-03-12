<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="UTF-8">
<title>withdrawal</title>

<%@ include file="/WEB-INF/include/forImport.jspf"%>
<style>
	.sc-title {
	text-align: center;
	font-size: 22px;
	color : #59bfbf;
	position: relative;
	margin-bottom: 40px;
}

.sc-title:before {
	content: "";
	position: absolute;
	width: 40%;
	height: 2px;
	margin: auto;
	top: 0;
	left: 0;
	bottom: 0;
	background: #59bfbf;
}

.sc-title:after {
	content: "";
	position: absolute;
	width: 40%;
	height: 2px;
	margin: auto;
	top: 0;
	right: 0;
	bottom: 0;
	background: #59bfbf;
}
.form-group{
	margin : 0 auto;
	width : 80%;
	text-align:center;
}
</style>

</head>
<body>
			<button type="button" onclick="location.href='logout.do'">로그아웃</button>
			<div class="form-group">
			<div class="container text-center">
				<h1 style="text-align: center; width: 15%; margin: 0 auto">
					<img style="max-width: 100%"src="${pageContext.request.contextPath}/img/EE_logo.png" />
				</h1>
				<p style="text-align: center; font-weight: bold; margin: 0;">Community EE</p>
				<p style="text-align: center; font-weight: bold;">탈 퇴 페 이 지</p>
			</div>
			<br>
			<h1 class="sc-title">회원 탈퇴</h1>
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<c:choose>
				<c:when test="${loginUser.snsType != null}">
					<h1>${loginUser.snsType}으로 로그인 하신 ${loginUser.uNickname}' 님의 탈퇴 페이지</h1>
					<br>
					<p>회원 가입 하신 아이디와 닉네임을 정확히 입력해주세요</p>
						<form role="form" method="post">
						<span class="required">•</span>이메일 : <input type="text" class="form-control" name="uEmail" placeholder="닉네임"> <br>
						<span class="required">&#8226;</span>닉네임 : <input type="text" class="form-control" name="uNickname" placeholder="닉네임">

						<p>
							<button type="submit">탈퇴</button>
						</p>

					</form>
					
				</c:when>
				<c:otherwise>
					<%-- <h1>'${loginUser.uNickname}' 님의 회원탈퇴 페이지~!~!~!~!~!~!~!~!~!</h1> --%>
					<p>회원 탈퇴를 위해 정확한 비밀번호를 입력해주세요</p>
					<form role="form" method="post">
						<span class="required">•</span>이메일 : ${loginUser.uEmail} <br>
						<span class="required">&#8226;</span>비밀번호 : 
						<input type="password" name="uPassword" placeholder="Password">

						<p>
							<button type="submit">탈퇴</button>
						</p>

					</form>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<h1>Please Login</h1>
			<button type="button" onclick="location.href='login/login.do'">로그인</button>
		</c:otherwise>
	</c:choose>
	</div>

	<c:if test="${msg == false }">
		<p>입력하신 정보가 잘못되었습니다.</p>
	</c:if>
</body>
</html>