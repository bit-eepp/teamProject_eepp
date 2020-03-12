<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/msg.css">
</head>
<body>
	<script type="text/javascript">
	//ContextPath
	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
$(document).ready(function(){			
	var title = $(".messageType").val();
		messageTypeTitle(title);
		
	$(".deleteBtn").click(function() {
		deleteMsg();
	});
});
// 전체 선택 or 해제
$(function(){ //전체선택 체크박스 클릭 
	$(".allCheck").click(function(){ 
		if($(".allCheck").prop("checked")) { 
			$("input:checkbox[name='pickCheck']").prop("checked",true);
		} else {
			$("input:checkbox[name='pickCheck']").prop("checked",false); 
		} 
	}) 
})

//체크박스 선택 삭제
function deleteMsg(){
	var checkRow = "";
	  $( "input[name='pickCheck']:checked" ).each (function(){
	    checkRow = checkRow + $(this).val()+"," ;
	  });
	  checkRow = checkRow.substring(0,checkRow.lastIndexOf( ",")); //맨끝 콤마 지우기
	 
	  if(checkRow == ''){
	    alert("삭제할 대상을 선택하세요.");
	    return false;
	  }else{
		  if(confirm("정말 삭제하시겠습니까?") == true){
		  $.ajax({
				url : getContextPath()+"/deleteMessage",
				type: "post",
				data : {
					"checkRow" : checkRow,
					"messageType" : $(".messageType").val()
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
		  }else{
			  return false;
		  }
	  }
}

// 타이틀
function messageTypeTitle(title) {
	
	if(title == 'myReceiveMsg') {
		$('#messageType_title').append('보낸사람');
		$('#messageType_date').append('수신일');
	}else if(title == 'mySendMsg'){
		$('#messageType_title').append('받는사람');
		$('#messageType_date').append('송신일');
	}
}

function openReceiveMsg(mid, sender_id){
 var msgvw = window.open("http://localhost:8282/eepp/message/messageView?messageType="+$(".messageType").val()+"&mid="+mid+"&sender_id="+sender_id,"message_view","left="+(screen.availWidth-370)/2
		 +",top="+(screen.availHeight-425)/2+",width=370,height=425");
}
function openSendMsg(mid, receiver_id){
var msgvw2 = window.open("http://localhost:8282/eepp/message/messageView?messageType="+$(".messageType").val()+"&mid="+mid+"&receiver_id="+receiver_id,"message_view2","left="+(screen.availWidth-370)/2
		+",top="+(screen.availHeight-425)/2+",width=370,height=425");
}

function reset(msgType){
	 var tw = window.open("http://localhost:8282/eepp/message?messageType="+msgType,"message","left="+(screen.availWidth-700)/2
			 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
}

</script>
	<input type="hidden" id="user_id" value="${loginUser.user_id}" />
	<input type="hidden" id="uNickname" value="${loginUser.uNickname}" />
	<div class="messageForm">
		<ul class="nav nav-tabs">
			<c:choose>
				<c:when test="${messageType eq 'myReceiveMsg'}">
					<li class="nav-item">
						<a class="nav-link active" href="message?messageType=myReceiveMsg">받은쪽지</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="message?messageType=mySendMsg">보낸쪽지</a>
					</li>
				</c:when>

				<c:when test="${messageType eq 'mySendMsg'}">
					<li class="nav-item">
						<a class="nav-link" href="message?messageType=myReceiveMsg">받은쪽지</a>
					</li>
					<li class="nav-item">
						<a class="nav-link active" href="message?messageType=mySendMsg">보낸쪽지</a>
					</li>
				</c:when>

			</c:choose>

		</ul>

		<div class="tab-content">
			<div class="tab-pane fade show active">
				<div class="notelist">
					<ul class="notelist_head note_title">
						<li class="note_cont note_check">
							<!--  전체선택 -->
							<input type="checkbox" class="allCheck">
						</li>
						<li class="note_cont note_type" id="messageType_title"></li>
						<li class="note_cont note_content">내용</li>
						<li class="note_cont note_mdate" id="messageType_date"></li>
						<li class="note_cont note_mstatus">확인</li>
					</ul>
				</div>
				<div id="showMyMessage" class="notelist">
					<form>
						<c:forEach items="${messageList}" var="msg">
						<input type="hidden" class="messageType" value="${messageType}">
						<input type="hidden" class="mid" name="mid" value="${msg.mid}">
						
							<ul class="notelist_head">
								<li class="note_cont note_check">
									<input type="checkbox" name="pickCheck" class="pickCheck" value="${msg.mid}" />
								</li>
								<li class="note_cont note_type">${msg.uNickname}</li>
								<li class="note_cont note_content">
									<!-- 받은 메세지를 확인할경우 status 변경을 위해 parameter생성 -->
									<c:choose>
										<c:when test="${messageType eq 'myReceiveMsg'}">
											<input type="hidden" name="changeStatus" value="${msg.receiver_id}">
											<a class="openMsgView" onclick="openReceiveMsg(${msg.mid},${msg.sender_id});">
												${msg.mcontent}
											</a>
										</c:when>
										
										<c:when test="${messageType eq 'mySendMsg'}">
											<a class="openMsgView" onclick="openSendMsg(${msg.mid},${msg.receiver_id});">
												${msg.mcontent}
											</a>
										</c:when>
									</c:choose>
								</li>
								<li class="note_cont note_mdate">${msg.mdate}</li>
								<li class="note_cont note_mstatus">${msg.status}</li>
							</ul>
						</c:forEach>
					</form>
				</div>
			</div>
		</div>
	</div>

	<button type="button" class="selectDeleteBtn">삭제</button>

	<!-- 페이징 -->
	<div>
		<c:if test="${pageMaker.prev}">
			<a style="text-decoration: none" href="message${pageMaker.makeQuery(pageMaker.startPage - 1)}&messageType=${messageType}">
				«
			</a>
		</c:if>

		[
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}"
			var="idx">
			<a style="text-decoration: none" href="message${pageMaker.makeQuery(idx)}&messageType=${messageType}">${idx}</a>
		</c:forEach>
		]

		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<a style="text-decoration: none" href="message${pageMaker.makeQuery(pageMaker.endPage + 1)}&messageType=${messageType}">
				» 
			</a>&nbsp;&nbsp;
		</c:if>
	</div>

</body>
</html>