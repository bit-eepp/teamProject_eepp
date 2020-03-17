<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/msg.css">
<!-- <script type="text/javascript">
//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

$(document).ready(function() {
	
	$(".closeBtn").click(function() {
		var msgType = $(".messageType").val();
		window.open('about:blank', '_self').close();
		openMsg(msgType);
	});
	
	$(".deleteBtn").click(function() {
		var msgType = $(".messageType").val();
		deleteMsg(msgType);
	});
	
});

function deleteMsg(msgType){
	$.ajax({
		url : getContextPath()+"/deleteMessage",
		type: "get",
		data : {
			"mid" : $(".mid").val(),
			"messageType" : msgType
		},
		success : function(data) {
			alert("쪽지가 삭제되었습니다.");
			var msgType = $(".messageType").val();
			reset(msgType);
		},
		error : function(request, status, error) {
			alert("에러가 발생했습니다.");
			console.log(request.responseText);
			console.log(error);
		}
	})
}

function openMsg(msgType){
	 var tw = window.open("http://localhost:8282/eepp/message?messageType="+msgType,"message","left="+(screen.availWidth-700)/2
			 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
}

function reset(msgType){
	window.open('about:blank', '_self').close();
	openMsg(msgType);
}

</script> -->
</head>
<body class="messageView_body">
	<c:choose>
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
							<c:when test="${not empty isReported}">
							${isReported.dReason} 사유로 인해 신고된 쪽지입니다.
							</c:when>
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
							<c:when test="${not empty isReported}">
							${isReported.dReason} 사유로 인해 신고된 쪽지입니다.
							</c:when>
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
</c:choose>
<script src="${pageContext.request.contextPath}/js/user/message/messageView.js"></script>
</body>
</html>