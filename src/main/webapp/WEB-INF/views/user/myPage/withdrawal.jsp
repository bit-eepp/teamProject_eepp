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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css">
<%@ include file="/WEB-INF/views/header.jsp"%>
<%@ include file="/WEB-INF/include/forImport.jspf"%>

</head>
<body>
			<div class="form-group">
			<div class="container text-center">
				<h1 style="text-align: center; width: 15%; margin: 0 auto">
					<img style="max-width: 100%"src="${pageContext.request.contextPath}/img/EE_logo.png" />
				</h1>
				<p style="text-align: center; font-weight: bold; margin: 0;">Community EE</p>
				<p style="text-align: center; font-weight: bold;">탈 퇴 페 이 지</p>
			</div>
			<br>
			
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<c:choose>
				<c:when test="${loginUser.snsType != null}">
					<br>
						<form role="form" method="post" class="drop_form">
					<p>회원 가입 하신 아이디와 닉네임을 정확히 입력해주세요</p>
						<span class="required">•</span>이메일 : <input type="text" name="uEmail" placeholder="이메일"> <br>
						<br>
						<span class="required">&#8226;</span>닉네임 : <input type="text"name="uNickname" placeholder="닉네임">
						<br><br>
							<button type="submit" class="btn btn-info" id="dropBtn" >탈퇴</button>
						
					</form>
				</c:when>
			
				<c:otherwise>
				<br><br><br><br>
					<p>회원 탈퇴를 위해 정확한 비밀번호를 입력해주세요</p>
					<form role="form" method="post">
						<span class="required">•</span>이메일 : ${loginUser.uEmail} <br>
						<span class="required">&#8226;</span>비밀번호 : 
						<input type="password" name="uPassword" placeholder="Password">
						<p>
							<button type="submit" class="btn btn-info" id="dropBtn">회원 탈퇴</button>
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
<script src="${pageContext.request.contextPath}/js/user/mypage/mypage.js"></script>	
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>