<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user/msg.css">
</head>

<body class="messageView_body">
	<c:choose>
		<%-- 받은쪽지 --%>
		<c:when test="${not empty receiveMsg.uNickname}">
		<section id="receiveMessageForm" class="sc-messageView">
			<div class="container">
			<h1 class="sc-title">받은쪽지</h1>
			
			<form method="POST" action="sendMessage">
				<input type="hidden" name="messageType" class="messageType" value="${messageType}">
				<input type="hidden" name="mid" class="mid" value="${receiveMsg.mid}">
				<input type="hidden" class="sender_id" value="${receiveMsg.sender_id}">
				<input type="hidden" class="receiver_id" value="${loginUser.user_id}">
				<!-- 답장을 위한 parameter -->
				<input type="hidden" name="sender_id" class="forReply" value="${loginUser.user_id}">
				<input type="hidden" name="receiver_id" class="forReply" value="${receiveMsg.sender_id}">
				<input type="hidden" name="uNickname" class="forReply" value="${receiveMsg.uNickname}">
				<!-- 답장을 위한 parameter -->
				
				<div class="form-group">
					<table>
					<tbody>
					<tr class="form-title">
						<th class="input-title">보낸사람</th>
						<td>${receiveMsg.uNickname}</td>
					</tr>
					
					<tr class="form-title">
						<th class="input-title">수신일</th>
						<td>${receiveMsg.mdate}</td>
					</tr>
					
					<tr>
						<th class="input-title">내용</th>
						<td>
						<c:choose>
							<%-- 신고된 쪽지일경우 --%>
							<c:when test="${not empty isReported}">
							${isReported.dReason} 사유로 인해 신고된 쪽지입니다.
							</c:when>
							<%-- 신고된 쪽지일경우 --%>
							<c:otherwise>
							${receiveMsg.mcontent}
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					</tbody>
					</table>
				</div>

					<button type="submit" class="btn btn-submit" id="submit">답장</button>
					<button type="button" class="btn deleteBtn">삭제</button>
					<button type="button" class="btn closeBtn">닫기</button>
				</form>
			</div>
		</section>
	</c:when>
	<%-- 받은쪽지 --%>
	
	<%-- 보낸쪽지 --%>
	<c:when test="${not empty sendMsg.uNickname}">
	<section id="sendMessageForm" class="sc-messageView">
	
		<div class="container">
			<h1 class="sc-title">보낸쪽지</h1>
			<form method="POST" id="replyToSender">
				<input type="hidden" name="receiver_id" value="${user.snsType}">
				
				<div class="form-group">
					<input type="hidden" name="messageType" class="messageType" value="${messageType}">
					<input type="hidden" name="mid" class="mid" value="${sendMsg.mid}">
					<input type="hidden" name="sender_id" class="sender_id" value="${loginUser.user_id}">
					<input type="hidden" name="receiver_id" class="receiver_id" value="${sendMsg.receiver_id}">
					<table>
					<tbody>
					<tr class="form-title">
						<th class="input-title">받은사람</th>
						<td>${sendMsg.uNickname}</td>
					</tr>
					
					<tr class="form-title">
						<th class="input-title">송신일</th>
						<td>${sendMsg.mdate}</td>
					</tr>
					
					<tr>
						<th class="input-title">내용</th>
						<td>
						<c:choose>
							<%-- 신고된 쪽지일경우 --%>
							<c:when test="${not empty isReported}">
							${isReported.dReason} 사유로 인해 신고된 쪽지입니다.
							</c:when>
							<%-- 신고된 쪽지일경우 --%>
							<c:otherwise>
							${sendMsg.mcontent}
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					</tbody>
					</table>
				</div>
					<button type="button" class="btn deleteBtn">삭제</button>
					<button type="button" class="btn closeBtn">닫기</button>
				</form>
			</div>
		</section>
</c:when>
<%-- 보낸쪽지 --%>
</c:choose>

<script src="${pageContext.request.contextPath}/js/user/message/messageView.js"></script>
</body>
</html>