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
<script type="text/javascript">
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
	
	$(".submitBtn").click(function() {
		if($(".mcontent").val == ""){
			alert("내용을 입력해주세요.");
			return false;
		}else{
			replyMsg();
			return true;
		}
	});

});

function replyMsg(){
	var messageType = "";
	if($(".from_message").val()!=""){
		messageType = $(".from_message").val()
	} else{
		messageType = $(".messageType").val()
	}
	$.ajax({
		url : getContextPath()+"/messageSuccess",
		type: "post",
		data : {
			"sender_id" : $(".sender_id").val(),
			"receiver_id" : $(".receiver_id").val(),
			"mcontent" : $(".mcontent").val(),
			"messageType" : messageType,
		},
		success : function(data) {
			alert("쪽지가 전송되었습니다.");
			reset(messageType);
		},
		error : function(request, status, error) {
			alert("에러가 발생했습니다.");
			console.log(request.responseText);
			console.log(error);
		}
	})
}

function reset(msgType){
	window.open('about:blank', '_self').close();
	if($(".from_message").val() != ""){
		return true;
	}else{
		openMsg(msgType);
	}
}

function openMsg(msgType){
	 var tw = window.open("http://localhost:8282/eepp/message?messageType="+msgType,"message","left="+(screen.availWidth-700)/2
			 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
}


</script>
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

</body>
</html>