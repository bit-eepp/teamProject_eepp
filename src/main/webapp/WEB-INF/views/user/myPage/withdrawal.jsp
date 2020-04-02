<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta charset="UTF-8">
<title>withdrawal</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
			<div class="form-group">
			<div class="container text-center">
				<h1 style="text-align: center; width: 15%; margin: 0 auto">
					<img style="max-width: 100%"src="${pageContext.request.contextPath}/img/EE_logo.png" />
				</h1>
				<p style="text-align: center; font-weight: bold; margin: 0;">Community EE</p>
				<p style="text-align: center; font-weight: bold;">탈 퇴 페 이 지</p>
			</div>
			
	<c:choose>
		<c:when test="${loginUser.uNickname != null}">
			<c:choose>
				<c:when test="${loginUser.snsType != null}">
					<form role="form" method="post" class="drop_form">
						<p>회원탈퇴를 위해 회원가입시 등록한 휴대폰번호를 입력해주세요.</p>
						
						<p><span class="required">&#8226;</span>핸드폰 번호</p>
						<select name="uPhone_1" class="custom-select" id="uPhone">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="019">019</option>
						<option value="080">080</option>
						</select> 
						- <input type="text" class="uPhone_2" name="uPhone_2" maxlength="4" size="6" onkeypress="return onlyNumber(event);">
						- <input type="text" class="uPhone_3"  name="uPhone_3" maxlength="4" size="6" onkeypress="return onlyNumber(event);">
						
						<c:if test="${msg == false}">
							<p>입력하신 정보가 잘못되었습니다.</p>
						</c:if>
	
						<button type="submit" class="btn btn-info" id="dropBtn" >탈퇴</button>
					</form>
				</c:when>
			
				<c:otherwise>
					<p>회원 탈퇴를 위해 정확한 비밀번호를 입력해주세요</p>
					<form role="form" method="post">
						<span class="required">•</span>이메일 : ${loginUser.uEmail} <br>
						<span class="required">&#8226;</span>비밀번호 : 
						<input type="password" name="uPassword" placeholder="Password">
						
						<c:if test="${msg == false }">
							<p>입력하신 정보가 잘못되었습니다.</p>
						</c:if>
						
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
	
<!-- chatting -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chatting -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->

<script src="${pageContext.request.contextPath}/js/user/mypage/mypage.js"></script>	
</body>
</html>