<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:choose>

		<c:when test="${loginUser.uNickname != null}">
			<!-- 로그인 성공 -->
			<h3>'${loginUser.uNickname}' 님 하이루~!</h3>
			<br>
			<button type="button" onclick="location.href='logout.do'">로그아웃</button>
		</c:when>

		<c:otherwise>
			<!-- 로그인 전 -->
			<h3>* Main Page *</h3>
			<button type="button" onclick="location.href='login/login.do'">로그인 </button>

		</c:otherwise>
	</c:choose>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
/* 회원가입후, 메인페이지로 리다이렉트한 경 */
$(function(){
    var responseMessage = "<c:out value="${joinSuccess.message}" />";
    if(responseMessage != ""){
        alert(responseMessage)
    }
})</script>
</body>
</html>