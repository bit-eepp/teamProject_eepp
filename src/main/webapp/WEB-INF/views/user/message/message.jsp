<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/msg.css">
</head>
<body class="message_body">
	<script type="text/javascript">
	//ContextPath
	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
$(document).ready(function(){			
	var title = $(".messageType").val();
		messageTypeTitle(title);
	$(".selectDeleteBtn").click(function() {
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

//발송취소
function sendCancle(mid, uNickname){
		  if(confirm(uNickname+"님에게 보낸쪽지를 발송취소 하시겠습니까? \n발송취소 전에 " 
				  + uNickname + "님이 받은쪽지함에 접속하였다면, 읽지않음 상태라도 목록에서 일부 내용을 확인했을 수 있습니다.") == true){
		  $.ajax({
				url : getContextPath()+"/cancleMessage",
				type: "post",
				data : {
					"mid" : $(".mid").val()
				},
				success : function(data) {
					if(data == 1){
						alert(uNickname+"님에게 보낸 쪽지가 발송취소되었습니다.");
						var msgType = $(".messageType").val();
						reset(msgType);
					}else{
						alert("수신상태가 읽음인 경우에는 발송취소 할 수 없습니다.");
						var msgType = $(".messageType").val();
						reset(msgType);
					}
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
	  
//쪽지 신고
function submitDeclarationForm(mid, uNickname){
	var reporter_id = $(".reporterId").val();
	var reported_id = $(".reportedId").val();
	var dReason = $("input[name='dReason_msg']:checked").val();
			
	if(dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url: getContextPath() + '/declaration/doMsgDeclaration',
			data:{
				"reporter_id": reporter_id,
				"reported_id" : reported_id,
				"mid" : mid,
				"dReason" : dReason
			},
			success:function(msg){
				alert(uNickname +'님의 쪽지가 신고되었습니다.');
				$('#modalForm_user_'+mid).modal('hide');
				var msgType = $(".messageType").val();
				reset(msgType);
			}
	       });
	}
}

//유저 신고
function reportUser(uNickname){
	var reporter_id = $(".reporterId").val();
	var reported_id = $(".reportedId").val();
	var dReason = $("input[name='dReason']:checked").val();

	if(dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url: getContextPath() + '/declaration/doUserDeclaration',
			data:{
				"reporter_id": reporter_id,
				"reported_id" : reported_id,
				"dReason" : dReason
			},
			success:function(msg){
				alert(uNickname +'님을 신고했습니다.');
				$('#modalForm_msg'+reported_id).modal('hide');
				var msgType = $(".messageType").val();
				reset(msgType);
			}
	       });
	}
}

// 타이틀
function messageTypeTitle(title) {
	
	if(title == 'myReceiveMsg') {
		$(".linkToreceive").addClass("active");
		$('#messageType_title').append('보낸사람');
		$('#messageType_date').append('받은날짜');
		$('#messageType_active').append('신고');
		$(".messageIsEmpty li").append("받은 쪽지가 없습니다.");
	}else if(title == 'mySendMsg'){
		$(".linkTosend").addClass("active");
		$('#messageType_title').append('받는사람');
		$('#messageType_date').append('보낸날짜');
		$('#messageType_active').append('발송취소');
		$(".massageIsEmpty li").append("보낸 쪽지가 없습니다.");
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

function sendMessage(uNickname, receiver_id, msgType){
	 var tw = window.open("http://localhost:8282/eepp/message/sendMessage?receiver="+uNickname+"&receiver_id="+receiver_id+"&messageType="+msgType+"&from=in", "sendmessage","left="+(screen.availWidth-370)/2
			 +",top="+(screen.availHeight-425)/2+",width=370,height=425");
}

</script>

<input type="hidden" id="user_id" value="${loginUser.user_id}" />
<input type="hidden" id="uNickname" value="${loginUser.uNickname}" />

	<div class="messageForm">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link linkToreceive" href="message?messageType=myReceiveMsg">받은쪽지</a>
			</li>
			<li class="nav-item">
				<a class="nav-link linkTosend" href="message?messageType=mySendMsg">보낸쪽지</a>
			</li>
		</ul>

	<div class="tab-content">
		<div class="tab-pane fade show active">
		
			<div class="notelist">
				<ul class="notelist_head note_title" id="m-title">
					<li class="note_cont note_check">
						<!--  전체선택 -->
						<input type="checkbox" class="allCheck">
					</li>
					<li class="note_cont note_type" id="messageType_title"></li>
					<li class="note_cont note_content">내용</li>
					<li class="note_cont note_mdate" id="messageType_date"></li>
					<li class="note_cont note_mstatus">확인</li>
					<li class="note_cont note_active" id="messageType_active"></li>
				</ul>
			</div>
			
			<div id="showMyMessage" class="notelist">
				<c:choose>
				<c:when test="${empty messageList}">
					<input type="hidden" class="messageType" value="${messageType}">
					<ul class="massageIsEmpty"><li class="note_cont"></li></ul>
				</c:when>
						
				<c:otherwise>
					<c:forEach items="${messageList}" var="msg" varStatus="btn">
					<form>
					<input type="hidden" class="messageType" value="${messageType}">
					<input type="hidden" class="mid" name="mid" value="${msg.mid}">
					<input type="hidden" class="uNickname" name="uNickname" value="${msg.uNickname}">
						
						<ul class="notelist_head">
							<li class="note_cont note_check">
								<input type="checkbox" name="pickCheck" class="pickCheck" value="${msg.mid}" />
							</li>
							<li class="note_cont note_type">
								<div class="dropdown">
								<a href="#" class="userBtn" id="user_${msg.uNickname}${btn.index}" data-toggle="dropdown">${msg.uNickname}</a>
           							<ul class="dropdown-menu" role="menu" aria-labelledby="user_${msg.uNickname}${btn.index}">
                						<li><a href="#">회원정보</a></li>
                						<li><a onclick="sendMessage('${msg.uNickname}',${msg.user_id},'mySendMsg');">쪽지 보내기</a></li>
                						<li><a data-toggle="modal" data-target="#userForm_user_${msg.user_id}${btn.index}" data-backdrop="static" data-keyboard="false">신고하기</a></li>
                					</ul>
								</div>
								
                						<div class="modal fade" id="userForm_user_${msg.user_id}${btn.index}" role="dialog">
                						<div class="modal-dialog">
                						<div class="modal-content">
                						
                						<!-- Modal Header -->
                						<div class="modal-header">
                							<button type="button" class="close" data-dismiss="modal">
                							<span aria-hidden="true">&times;</span>
			                    			<span class="sr-only">Close</span>
			                				</button>
			               					<h4 class="modal-title">${msg.uNickname}님 신고</h4>
			            				</div>
			            				
			            				<!-- Modal Body -->
			            				<div class="modal-body">
			            				<div class="declaration">
			            				<input type="hidden" name="reporter_id" value="${lgoinUser.user_id}">
			            				<input type="hidden" name="reportec_id" value="${msg.user_id}">
			            				
			            				<div class="form-group">
			            				<label for="inputMessage">신고사유</label><br>
			            				<input type="radio" name="dReason" value="부적절한 홍보 게시글" onclick="this.form.etc_${msg.user_id}${btn.index}.disabled=true">  부적절한 홍보 게시글<br>
			            				<input type="radio" name="dReason" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_${msg.user_id}${btn.index}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
			            				<input type="radio" name="dReason" value="명예훼손/사생활 침해 및 저작권침해등" onclick="this.form.etc_${msg.user_id}${btn.index}.disabled=true">  명예훼손/사생활 침해 및 저작권침해등<br>
			            				<input type="radio" name="dReason" value="etc" onclick="this.form.etc_${msg.user_id}${btn.index}.disabled=false">  기타<br>
			            				<textarea style="resize:none;height:80px;width:100%;" cols="30" rows="10" class="form-control" id="etc_${msg.user_id}${btn.index}" name="dReason" disabled></textarea>
			            				</div>
			                	</div>
			           		 </div>
            
			            				<!-- Modal Footer -->
			            				<div class="modal-footer">
			                			<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reset()">취소</button>
			                			<button type="button" class="btn btn-primary submitBtn" onclick="reportUser('${msg.user_id}')">신고</button>
			            				</div>
			        		</div>
    						</div>
							</div>
							</li>
							
							<c:choose>
							<c:when test="${messageType eq 'myReceiveMsg'}">
								<li class="note_cont note_content">
									<a class="openMsgView" onclick="openReceiveMsg(${msg.mid},${msg.sender_id});">
										<c:choose>
											<c:when test="${msg.mblind eq 1}">
											신고된 쪽지입니다.
											</c:when>
											<c:when test="${fn:length(msg.mcontent) >= 22}">
											${fn:substring(msg.mcontent, 0, 22)}...
											</c:when>
											<c:otherwise>
											${msg.mcontent}
											</c:otherwise>
										</c:choose>
									</a>
								</li>
								<li class="note_cont note_mdate">${msg.mdate}</li>
								<li class="note_cont note_mstatus">${msg.status}</li>
								<li class="note_cont note_active">
									<a class="reportMsg" data-toggle="modal" data-target="#modalForm_msg_${msg.mid}${btn.index}" data-backdrop="static" data-keyboard="false">신고</a>
									<!-- 쪽지 신고 폼 -->
									<div class="modal fade" id="modalForm_msg_${msg.mid}${btn.index}" role="dialog">
									<div class="modal-dialog">
									<div class="modal-content">
										<!-- Modal Header -->
										<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span>
										<span class="sr-only">Close</span>
										</button>
										<h4 class="modal-title" id="myModalLabel">${msg.uNickname}님의 쪽지 신고</h4>
									</div>
									<!-- Modal Body -->
									<div class="modal-body">
										<div id="messageDeclaration_${msg.mid}" role="formMsgDeclaration_${msg.mid}">
										<input type="hidden" name="reporter_id" class="reporterId" value="${loginUser.user_id}">
										<input type="hidden" name="reported_id" class="reportedId" value="${msg.user_id}">
											 
											<div class="form-group">
											<label for="inputMessage">신고사유</label><br>
											<input type="radio" name="dReason_msg" value="부적절한 홍보 내용" onclick="this.form.etc_msg_${msg.mid}.disabled=true">  부적절한 홍보 내용<br>
											<input type="radio" name="dReason_msg" value="음란성 또는 청소년에게 부적합한 내용" onclick="this.form.etc_msg_${msg.mid}.disabled=true">  음란성 또는 청소년에게 부적합한 내용<br>
											<input type="radio" name="dReason_msg" value="명예훼손/사생활 침해 등" onclick="this.form.etc_msg_${msg.mid}.disabled=true">  명예훼손/사생활 침해 등<br>
											<input type="radio" name="dReason_msg" value="etc" onclick="this.form.etc_msg_${msg.mid}.disabled=false">  기타<br>
											<textarea style="resize:none;height:80px;width:100%;" class="form-control" id="etc_msg_${msg.mid}" name="dReason_msg" disabled></textarea>
										</div>
									</div> 
								</div>
											 
									<!-- Modal Footer -->
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal" onclick="reset()">취소</button>
										<button type="button" class="btn btn-primary submitBtn" onclick="submitDeclarationForm(${msg.mid},'${msg.uNickname}')">신고</button>
									</div>
								</div>
							</div>
							</div>
								</li>
							</c:when>
	
							<c:when test="${messageType eq 'mySendMsg'}">
								<li class="note_cont note_content">
									<a class="openMsgView" onclick="openSendMsg(${msg.mid},${msg.receiver_id});">
										<c:choose>
										<c:when test="${msg.mblind eq 1}">
										신고된 쪽지입니다.
										</c:when>
										<c:when test="${fn:length(msg.mcontent) >= 22}">
										${fn:substring(msg.mcontent, 0, 22)}...
										</c:when>
										<c:otherwise>
										${msg.mcontent}
										</c:otherwise>
										</c:choose>
									</a>
								</li>
								<li class="note_cont note_mdate">${msg.mdate}</li>
								<li class="note_cont note_mstatus">${msg.status}</li>
								<li class="note_cont note_active">
									<c:choose>
									<c:when test="${msg.status eq '읽음'}"></c:when>
									<c:otherwise>
										<a class="send_cancle" onclick="sendCancle(${msg.mid},'${msg.uNickname}');">발송취소</a>
									</c:otherwise>
									</c:choose>
								</li>
							</c:when>
						</c:choose>
					</ul>
					</form>
					
				</c:forEach>
			</c:otherwise>
		</c:choose>
		</div>
		</div>
	</div>
</div>
	
	<div class="message_footer">
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
	</div>

</body>
</html>