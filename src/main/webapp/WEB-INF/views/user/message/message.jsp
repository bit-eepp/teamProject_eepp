<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/message.css">
</head>
<body>
<script type="text/javascript">
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

$(document).ready(function(){
	var userId = $("#user_id").val();
	if(userId != 0){
		showReceiveMessage();
		showSendMessage();
	}
})

function opewMsgView(){
 var tw = window.open("http://localhost:8282/eepp/message/messageView?mid="+$(".messageId").val(), "message_view", "width=700,height=440" );
}

function resetForm() {
	$('#modalForm').on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}

function showReceiveMessage() {
	var receiverId = $("#receiver_id").val();
	
	$.ajax({
		url : getContextPath()+"/receiveMessage",
		type : "post",
		dataType : "json",
		data : {
			"receiver_id" : receiverId
		},
		success : function(data) {
			if (!data) {
				var messageList = '';
				messageList += '<ul>';
				messageList += '<li>받은메세지가 없습니다.</li>';
				messageList += '</ul>';
				$("#showMyReceiveMsg").append(msgList);
				return;
			} else{
				var msgList =  Object.values(data["messageList"]);
				$.each(msgList, function(key, msg){
					var mcontentEdit = msg.mcontent;
					if(mcontentEdit.length >= 30){
					    return mcontentEdit.substr(0,30)+"...";
					}
					var messageList = '';
					messageList += '<form id="msgForm" method="get">';
					messageList += '<input type="hidden" name="mid" class="messageId" value="'+msg.mid+'" />';
					messageList += '<ul class="notelist_head">';
					messageList += '<li class="note_cont note_check"><input type="checkbox" id="msgCheck" value="pickCheck" /></li>'
					messageList += '<li class="note_cont note_sender">' + msg.uNickname+ '</li>';
					messageList += '<li class="note_cont note_content">';
					messageList += '<a class="openMsgView" onclick="opewMsgView();">';
						if(msg.mcontent.length >= 25){
							messageList += msg.mcontent.substr(0,25)+"...";
						}else{
							messageList += msg.mcontent;
						}
						messageList += '</a></li>';
					messageList += '<li class="note_cont note_mdate">' + msg.mdate+ '</li>';
					messageList += '<li class="note_cont note_mstatus">' + msg.status+ '</li>';
					messageList += '</ul>';
					messageList += '</form>';
					$("#showMyReceiveMsg").append(messageList);
				});
				return;
			}
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};

function showSendMessage() {
	var senderId = $("#sender_id").val();
	
	$.ajax({
		url : getContextPath()+"/sendMessage",
		type : "post",
		dataType : "json",
		data : {
			"sender_id" : senderId
		},
		success : function(data) {
			if (!data) {
				var messageList = '';
				messageList += '<ul>';
				messageList += '<li>보낸메세지가 없습니다.</li>';
				messageList += '</ul>';
				$("#showMySendMsg").append(msgList);
				return;
			} else{
				var msgList =  Object.values(data["messageList"]);
				$.each(msgList, function(key, msg){
					var messageList = '';
					messageList += '<form id="msgForm">';
					messageList += '<input type="hidden" name="mid" class="messageId" value="'+msg.mid+'" />';
					messageList += '<ul class="notelist_head">';
					messageList += '<li class="note_cont note_check"><input type="checkbox" id="msgCheck" value="pickCheck" /></li>'
					messageList += '<li class="note_cont note_receiver">' + msg.uNickname+ '</li>';
					messageList += '<li class="note_cont note_content">';
					messageList += '<a class="openMsgView" onclick="window.open("http://localhost:8282/eepp/message/messageView?mid='+msg.mid+'","message_view","width=400,height=400");">';
					if(msg.mcontent.length >= 25){
						messageList += msg.mcontent.substr(0,25)+"...";
					}else{
						messageList += msg.mcontent;
					}
					messageList += '</a></li>';
					messageList += '<li class="note_cont note_mdate">' + msg.mdate+ '</li>';
					messageList += '<li class="note_cont note_mstatus">' + msg.status+ '</li>';
					messageList += '</ul>';
					messageList += '</form>';
					$("#showMySendMsg").append(messageList);
				});
				return;
			}
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};
</script>
<input type="hidden" id="user_id" value="${loginUser.user_id}" />
<input type="hidden" id="uNickname" value="${loginUser.uNickname}" />

	<!-- 쪽지 -->
	<div class="messageForm">
		<ul class="nav nav-tabs">
  			<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#receiveMsgTab">받은쪽지</a></li>
  			<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#sendMsgTab">보낸쪽지</a></li>
		</ul>
		
		<div class="tab-content">
  			<div class="tab-pane fade show active" id="receiveMsgTab">
   				<input type="hidden" id="receiver_id" value="${loginUser.user_id}" />
    			<div class="notelist">
					<ul class="notelist_head note_title">
						<li class="note_cont note_check"><input type="checkbox" id="msgAllCheck" value="allCheck"></li>
						<li class="note_cont note_sender">보낸사람</li>
						<li class="note_cont note_content">내용</li>
						<li class="note_cont note_mdate">수신일</li>
						<li class="note_cont note_mstatus">수신확인</li>
					</ul>
				</div>
				<div id="showMyReceiveMsg" class="notelist"></div>
			</div>
			
			<div class="tab-pane fade" id="sendMsgTab">
				<input type="hidden" id="sender_id" value="${loginUser.user_id}" />
				<div class="notelist">
					<ul class="notelist_head note_title">
						<li class="note_cont note_check"><input type="checkbox" id="msgAllCheck" value="allCheck"></li>
						<li class="note_cont note_receiver">받는사람</li>
						<li class="note_cont note_content">내용</li>
						<li class="note_cont note_mdate">수신일</li>
						<li class="note_cont note_mstatus">수신확인</li>
					</ul>
				</div>
				<div id="showMySendMsg" class="notelist"></div>
			</div>
		</div>
	</div>
</body>
</html>