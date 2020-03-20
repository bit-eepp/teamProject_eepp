<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/loginAndJoin.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>
<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

	<div class="container text-center">
		<h1 style="text-align: center; width: 15%; margin: 0 auto">
			<img style="max-width: 100%" src="${pageContext.request.contextPath}/img/EE_logo.png" />
			
		</h1>
		<p style="text-align: center; font-weight:bold; margin:0;">Community EE</p>
		<p style="text-align: center; font-weight:bold;">로 그 인</p>
	</div>

	<div class="container col-md-4">

		<form:form name="f" class="px-4 py-3" action="${pageContext.request.contextPath}/nomal_login.do" method="post">
			<c:if test="${param.error != null}">
				<p>아이디와 비밀번호가 잘못되었습니다.</p>
			</c:if>

			<c:if test="${param.logout != null}">
				<p>로그아웃 하였습니다.</p>
			</c:if>

			<div class="form-group">
				<label for="exampleDropdownFormEmail1">Email</label>
				<input type="text" class="form-control" name="uEmail" placeholder="example">
			</div>
			<div class="form-group">
				<label for="exampleDropdownFormPassword1">Password</label>
				<input type="password" class="form-control" name="uPassword" placeholder="Password">
			</div>

			<button type="submit" class="btn btn-primary">로그인</button>
			
			<br>
			
			<div class="form-check">
	              <label class="form-check-label">
	              <input type="checkbox" class="form-check-input" name="rememberMe">
	              Remember me
	              </label>
	          </div>
			
			<hr>
			
			<h6 style="text-align:center; margin-bottom:20px;">S N S 간 편 로 그 인</h6>
			<div class="sns_login_button">
				<span>
					<button type="button" onclick="location.href='${naver_url}'" style="">
						<img style="max-width:100%"
							src="${pageContext.request.contextPath}/img/naver_account_login_small.PNG"/>
					</button>
				</span>
				
				<span>
					<button type="button" onclick="location.href='${kakao_url}'">
						<img style="max-width:100%" 
						src="${pageContext.request.contextPath}/img/kakao_account_login_small.png"/>
					</button>
				</span>
				
				<span>
					<button type="button" onclick="location.href='${google_url}'">
						<img style="max-width:100%" 
						src="${pageContext.request.contextPath}/img/google_account_login_small.png"/>
					</button>
				</span>
			</div>
		</form:form>

		<div class="dropdown-divider"></div>
		<a class="dropdown-item" href="${pageContext.request.contextPath}/join/register">회원가입</a>
		<a class="dropdown-item" href="${pageContext.request.contextPath}/login/forgotMyInfo">가입이메일 / 비밀번호 찾기</a>

	</div>
	
<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->
<script type="text/javascript">
$(function(){
    var responseMessage = "<c:out value="${loginInfo.message}" />";
    if(responseMessage != ""){
        alert(responseMessage)
    }
})
</script>
</body>
</html>