<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 보내기</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/msg.css">
</head>

<body class="messageView_body">

		<section id="sendMessage" class="sc-messageView">
			<div class="container">
			<h1 class="sc-title">쪽지보내기</h1>
			<form method="POST" id="sendMessage" action="messageSuccess">
				<input type="hidden" name="sender_id" class="sender_id" value="${loginUser.user_id}">
				<input type="hidden" name="receiver_id" class="receiver_id" value="${sendMessage.receiver_id}">
				<input type="hidden" name="messageType" class="messageType" value="${messageType}">
				<input type="hidden" name="from_message" class="from_message" value="${from_message}">
				
				<div class="form-group">
					<table>
					<tbody>
					<tr class="form-title">
						<th class="input-title">받는사람</th>
						<td>${sendMessage.uNickname}</td>
					</tr>
					
					<tr>
						<th class="input-title">내용</th>
						<td><textarea class="mcontent" name="mcontent" style="resize:none;height:220px;width:100%;" placeholder="내용을 작성해주세요."></textarea></td>
					</tr>
					</tbody>
					</table>
				</div>

					<button type="button" class="btn submitBtn">전송</button>
					<button type="button" class="btn closeBtn">닫기</button>
				</form>
			</div>
		</section>
<script src="${pageContext.request.contextPath}/js/user/message/sendMessage.js"></script>
</body>
</html>