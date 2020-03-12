<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community EE</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
</head>

<body>
<script type="text/javascript">
function openMsg(){
 var tw = window.open("http://localhost:8282/eepp/message", "message", "width=700,height=440" );
}
</script>
<input type="hidden" id="user_id" value="${loginUser.user_id}" />
<input type="hidden" id="uNickname" value="${loginUser.uNickname}" />

<c:choose>
	<c:when test="${loginUser.uNickname != null}">
	<!-- 로그인 성공 -->
		<div>
			<h3>'${loginUser.uNickname}' 님 하이루~!</h3>
			<br>
			<button type="button" onclick="location.href='logout.do'">로그아웃</button>
		</div>

		<div>
			<p><a href="${pageContext.request.contextPath}/board/boardList">직무게시판</a></p>
			<p><a href="${pageContext.request.contextPath}/class/classList">클래스</a></p>
			<p><a href="${pageContext.request.contextPath}/eating/eatingList">오늘뭐먹지</a></p>
			<p><a href="${pageContext.request.contextPath}/mypage">MyPage</a></p>
			<br>
			<button type="button" value="open_message" onclick="openMsg();">쪽지</button>
		</div>
		</c:when>

		<c:otherwise>
			<!-- 로그인 전 -->
			<div>
				<h3>* Main Page *</h3>
				<button type="button" onclick="location.href='login/login.do'">로그인</button>
				<br>
				<button type="button" onclick="location.href='join/register'">회원가입</button>
			</div>

			<div>
				<p>
					<a href="${pageContext.request.contextPath}/board/boardList">직무게시판</a>
				</p>
				<p>
					<a href="${pageContext.request.contextPath}/class/classList">클래스</a>
				</p>
				<p>
					<a href="${pageContext.request.contextPath}/eating/eatingList">오늘뭐먹지</a>
				</p>
			</div>

		</c:otherwise>
	</c:choose>

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script type="text/javascript">
/* 회원가입후, 메인페이지로 리다이렉트한 경 */
$(function(){
    var responseMessage = "<c:out value="${joinSuccess.message}" />";
    if(responseMessage != ""){
        alert(responseMessage)
    }
})

</script>
</body>
</html>