<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<meta http-equiv="Con tent-Type" content="text/html; charset=UTF-8">
		<title> No.${chatRoomSelect.chId} EE Chat</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chat/chatRoomPage.css">
		
		<script type="text/javascript">
			var chId= ${chatRoomSelect.chId};
			var chatMasterId = ${chatRoomSelect.user_id};
			var chatMemberId = ${user_id};
			var currentUserNickname = '${loginUser.uNickname}';
	
			$(document).ready(function() {
				connect();
				
				if(chatMasterId != chatMemberId){	// 해당 채팅방에서 방장이 아니면 방삭제 버튼을 안보이게함
					$('#deleteBtn').remove();
				}
				
				/* setInterval('getMemberList(chId)', 1000); */ // 10초간격으로 채팅방 인원변경 확인, Ajax통신
				
				$('#message').keypress(function(event) {	// 채팅메세지를 엔터를 쳐서 보낼수 있게해주는 것
					var keycode = (event.keyCode ? event.keyCode : event.which);
					if (keycode == '13') {
						send();
					}
					event.stopPropagation();
				});
				
				$('#sendBtn').click(function() {
					send();
				});
			});
	
			// 웹소켓 접속
			var webSocket;
	
			function connect() {
				webSocket = new SockJS("/eepp/echo");
				webSocket.onopen = onOpen;
				webSocket.onmessage = onMessage;
			}
	
			// 채팅방 접속할때 실행되는 메세지
			function onOpen(evt) {
				var a = currentUserNickname;
				var text = '님이 참여하셨습니다.';
				var msg = 
				{
					"type" : "notice",
			    	"text": text,
					"uNickname" : a,
					"date" : Date.now()
				};
				
				webSocket.send(JSON.stringify(msg));	
			}
	
			//채팅 메세지를 보내는 메서드
			function send() {				 
				var a = currentUserNickname;
				var text = $("#message").val();
				var msg = 
				{
					"type" : "msg",
			    	"text": text,
					"uNickname" : a,
					"date" : Date.now()
				};
				
				webSocket.send(JSON.stringify(msg));
				
				$("#message").val("");
			}
	
			// 채팅메세지를 받는 메세지
			function onMessage(evt) {
				console.log(evt.data);
	
				var tag = "";
				var text = "";
				var msg = JSON.parse(evt.data);
				var time = new Date(msg.date);
				var ampm = (time.getHours() > 12 ?  "PM" : "AM");
				var h = (time.getHours() > 12 ? time.getHours() - 12 : time.getHours());
				var m = time.getMinutes();
				
				if (m >= 0 && m <= 9){
					m = "0" +m;
				}
				
				var timeStr = ampm +" " +h + ":" +m;
				
				if(msg.type == "notice") {
					tag += '<div class="notice">';
					tag += '<div class="notice-body">';
					tag += '<div class="notice-message">';
					tag += '<br>';
					tag += '<h6><b style="color:#26274c;">' +msg.uNickname +msg.text +' ['+timeStr +'] </b></h6>';
					tag += '</div>';
					tag += '</div>';
					tag += '</div>';
					appendMessage(tag); 	
				} else if(msg.type == "delete") {
					tag += '<div class="notice">';
					tag += '<div class="notice-body">';
					tag += '<div class="notice-message">';
					tag += '<br>';
					tag += '<h6><b style="color:red;">' +msg.text +' ['+timeStr +'] </b></h6>';
					tag += '</div>';
					tag += '</div>';
					tag += '</div>';
					appendMessage(tag);
				} else if(msg.type == "msg") {
					if(msg.uNickname == currentUserNickname) {
			    		tag += '<li class="out">';
			    		tag += '<div class="chat-img">';
			    		tag += '</div>';
			    		tag += '<div class="chat-body">';
			    		tag += '<div class="chat-message">';
			    		tag += '<h6 style="color:#ffffff">' +msg.text +'</h6>';
			    		tag += '<p style="color:#26274c;">' +msg.uNickname +'</p>';
			    		tag += '<p style="color:#26274c;">' +timeStr +'</p>' ;
			    		tag += '</div>';
			    		tag += '</div>';
			    		tag += '</li>';
			    		appendMessage(tag);    		
			    	} else {
			    		tag += '<li class="in">';
			    		tag += '<div class="chat-img">';
			    		tag += '<img alt="Avtar" src="https://bootdey.com/img/Content/avatar/avatar6.png">';
			    		tag += '</div>';
			    		tag += '<div class="chat-body">';
			    		tag += '<div class="chat-message">';
			    		tag += '<h6 style="color:#ffffff">' +msg.text +'</h6>';
			    		tag += '<p style="color:#26274c;">' +msg.uNickname +'</p>';
			    		tag += '<p style="color:#26274c;">' +timeStr +'</p>' ;
			    		tag += '</div>';
			    		tag += '</div>';
			    		tag += '</li>';
			    		appendMessage(tag);
			    		
			    		var a = '<i class="fas fa-comment-alt fa-2x" style="color:#e7438b;"></i>';
			    		var b = '<i class="fas fa-comment-alt fa-2x"></i>';
			    		$('.noticeMsg').html(a);
			    		setTimeout(function(){$('.noticeMsg').html(b);}, 700);
			    	}
				}
			}
	
			// 보낸 채팅메세지를 화면에 나타내는 메서드
			function appendMessage(tag) {
				$(".chat-list").append(tag + "<br>");
				$(".chatMessageArea").scrollTop($(".chatMessageArea")[0].scrollHeight);	
			}
	
			// 현재 채팅방에 접속한 유저를 파악하는 메서드
			function getMemberList(chId) {
				$('.chatMemberList').children().remove();
				
				$.ajax({
					type:'POST',
					url:'/eepp/chat/getMemberList',
					async: false,
					data:{'chatting_id' : chId},
					success:function(data){
						$.each(data, function(key, value) {
							var currentMemberCount = data.length;
							var memberCount = '';
								memberCount += '<div class="count"> 참여자수 : ' +currentMemberCount +' / ' +${chatRoomSelect.chTotalPeopleCount} +'</div>'; 
								
							$('.count').html(memberCount);
							
							var memberList = "";
								memberList += "<span>" +value.uNickname +" / " +"</span>";
								
							$('.chatMemberList').append(memberList);	
						});
					}
			    });
			}
	
			// 채팅방 삭제 메서드 : 방개설자만 가능
			function chatRoomDelete(chId, user_id) {
				if(confirm("EE Chat을 정말 삭제하시겠습니까? 삭제하면 다시 참여가 불가합니다.") == true) {
					$.ajax({
						type:'POST',
						url:'/eepp/chat/chatRoomDelete',
						data:{'chId' : chId, 'user_id' : user_id},
						success:function(data){
							alert("EE Chat이 삭제되었습니다.");
	
							var text = '[알  림] 모임장이 해당 EE Chat을 삭제했습니다. 나가면 다시 참여가 불가합니다.';
							var msg = 
								{
									"type" : "delete",
					            	"text": text,
									"date" : Date.now()
								};
							
							webSocket.send(JSON.stringify(msg));
							window.close();
						}
			        });	
				} else {
					return false;
				}
			}
	
			// 채팅방 나가는 메서드 
			function chatRoomExit(chId, user_id) {
				if(confirm("EE Chat에서 나가시겠습니까?") == true) {					
					$.ajax({
						type:'POST',
						url:'/eepp/chat/chatRoomExit',
						data:{'chId' : chId, 'user_id' : user_id},
						success:function(data){
							var a = currentUserNickname;
							var text = '님이 나가셨습니다.';
							var msg = 
								{
									"type" : "notice",
					            	"text": text,
									"uNickname" : a,
									"date" : Date.now()
								};
							
							webSocket.send(JSON.stringify(msg));
							window.close();
						}
			        });
				} else {
					return false;
				}
			}
	
			//새로고침 방지
			function noEvent() { // 새로 고침 방지
			    if (event.keyCode == 116) {
			        event.keyCode = 2;
			        return false;
			    } else if (event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) {
			        return false;
			    }
			}
	
			document.onkeydown = noEvent;
		</script>
	</head>
	
	<body oncontextmenu="return false">
		<div class="container content">		
			<div class="row">
				<div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
					<div class="card">
					
						<div class="card-header">
							<span class="noticeMsg">
								<i class="fas fa-comment-alt fa-2x"></i>
							</span>
							
							No.${chatRoomSelect.chId}
							
							<div class="chatTitle">${chatRoomSelect.chTitle}</div>
							<br>
							
							<div class="chatMaster">모 임 장 : ${chatRoomSelect.uNickname}</div>
							<div class="openTime" >개설시간 : <fmt:formatDate value="${chatRoomSelect.chDate}" pattern="yyyy.MM.dd HH:mm" /></div>
							<div class="count"></div>
							
							<div>
								<div class="chatMemberList"></div>
							</div>
							<br>
							
							<span class="chMenu">
								<button title="EE Chat 삭제" id="deleteBtn" class="btn btn-default btn-sm" onclick="chatRoomDelete(${chatRoomSelect.chId}, ${loginUser.user_id})"><i class="fas fa-trash-alt fa-2x"></i></button>
								<button title="EE Chat 나가기" id="exitBtn" type="button" class="btn btn-default btn-sm" onclick="chatRoomExit(${chatRoomSelect.chId}, ${loginUser.user_id})"><i class="fas fa-door-open fa-2x""></i></button>
							</span>
							
							<div class="meetInfo">
								<p><i title="모임장소" class="fas fa-map-marker-alt">&nbsp;<b>${chatRoomSelect.chPlace}</b></i></p>
								<p><i title="모임시간" class="far fa-clock">&nbsp;<b>${chatRoomSelect.chMeetTime}</b></i></p>
							</div>
							
						</div>
						
						<div class="chatMessageArea">
							<ul class="chat-list"></ul>
						</div>

						 <div class="panel-footer">
		                    <div class="input-group">
		                        <input id="message" type="text" class="form-control input-sm chat_input" placeholder="Write your message here..." />
		                        <span class="input-group-btn">
		                        	<button title="메세지 전송" class="btn btn-default btn-sm" id="sendBtn"><i class="fas fa-paper-plane fa-2x"></i></button>
		                        </span>
		                    </div>
		                </div>
					</div>
				</div>		
			</div>
		</div>
	</body>
</html>
