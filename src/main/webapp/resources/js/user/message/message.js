//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
}

$(document).ready(function() {
	
	var title = $(".messageType").val();
	messageTypeTitle(title);
	$(".selectDeleteBtn").click(function() {
		deleteMsg();
	});
	
});

// 전체 선택 or 해제
$(function() { 
	// 전체선택 체크박스 클릭
	$(".allCheck").click(function() {
		if ($(".allCheck").prop("checked")) {
			$("input:checkbox[name='pickCheck']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck']").prop("checked", false);
		}
	})
})

// 체크박스 선택 삭제
function deleteMsg() {
	var checkRow = "";
	$("input[name='pickCheck']:checked").each(function() {
		checkRow = checkRow + $(this).val() + ",";
	});
	checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); // 맨끝 콤마 지우기

	if (checkRow == '') {
		alert("삭제할 대상을 선택하세요.");
		return false;
	} else {
		if (confirm("정말 삭제하시겠습니까?") == true) {
			$.ajax({
				url : getContextPath() + "/deleteMessage",
				type : "post",
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
		} else {
			return false;
		}
	}
}

// 발송취소
function sendCancle(mid, uNickname) {
	if (confirm(uNickname + "님에게 보낸쪽지를 발송취소 하시겠습니까? \n발송취소 전에 " + uNickname
			+ "님이 받은쪽지함에 접속하였다면, 읽지않음 상태라도 목록에서 일부 내용을 확인했을 수 있습니다.") == true) {
		$.ajax({
			url : getContextPath() + "/cancleMessage",
			type : "post",
			data : {
				"mid" : $(".mid").val()
			},
			success : function(data) {
				if (data == 1) {
					alert(uNickname + "님에게 보낸 쪽지가 발송취소되었습니다.");
					var msgType = $(".messageType").val();
					reset(msgType);
				} else {
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
	} else {
		return false;
	}
}

// 쪽지 신고
function submitDeclarationForm(mid, uNickname) {
	var reporter_id = $(".reporterId").val();
	var reported_id = $(".reportedId").val();
	var dReason = $("input[name='dReason_msg']:checked").val();

	if (dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type : 'POST',
			url : getContextPath() + '/declaration/doMsgDeclaration',
			data : {
				"reporter_id" : reporter_id,
				"reported_id" : reported_id,
				"mid" : mid,
				"dReason" : dReason
			},
			success : function(msg) {
				alert(uNickname + '님의 쪽지가 신고되었습니다.');
				$('#modalForm_user_' + mid).modal('hide');
				var msgType = $(".messageType").val();
				reset(msgType);
			}
		});
	}
}

// 유저 신고
function reportUser(uNickname) {
	var reporter_id = $(".reporterId").val();
	var reported_id = $(".reportedId").val();
	var dReason = $("input[name='dReason']:checked").val();

	if (dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type : 'POST',
			url : getContextPath() + '/declaration/doUserDeclaration',
			data : {
				"reporter_id" : reporter_id,
				"reported_id" : reported_id,
				"dReason" : dReason
			},
			success : function(msg) {
				alert(uNickname + '님을 신고했습니다.');
				$('#modalForm_msg' + reported_id).modal('hide');
				var msgType = $(".messageType").val();
				reset(msgType);
			}
		});
	}
}

// 타이틀
function messageTypeTitle(title) {

	if (title == 'myReceiveMsg') {
		$(".linkToreceive").addClass("active");
		$('#messageType_title').append('보낸사람');
		$('#messageType_date').append('받은날짜');
		$('#messageType_active').append('신고');
		$(".messageIsEmpty li").append("받은 쪽지가 없습니다.");
	} else if (title == 'mySendMsg') {
		$(".linkTosend").addClass("active");
		$('#messageType_title').append('받는사람');
		$('#messageType_date').append('보낸날짜');
		$('#messageType_active').append('발송취소');
		$(".massageIsEmpty li").append("보낸 쪽지가 없습니다.");
	}
}

function openReceiveMsg(mid, sender_id) {
	var msgvw = window.open(
			"http://localhost:8282/eepp/message/messageView?messageType="
					+ $(".messageType").val() + "&mid=" + mid + "&sender_id="+ sender_id, "message_view", 
					"left="+ (screen.availWidth - 370) / 2 
					+ ",top=" + (screen.availHeight - 425) / 2 + ",width=370,height=425");
}
function openSendMsg(mid, receiver_id) {
	var msgvw2 = window.open(
			"http://localhost:8282/eepp/message/messageView?messageType="
					+ $(".messageType").val() + "&mid=" + mid + "&receiver_id=" + receiver_id, "message_view2",
					"left=" + (screen.availWidth - 370) / 2 
					+ ",top=" + (screen.availHeight - 425) / 2 + ",width=370,height=425");
}

function reset(msgType) {
	var tw = window.open("http://localhost:8282/eepp/message?messageType="
			+ msgType, "message", "left=" + (screen.availWidth - 700) / 2
			+ ",top=" + (screen.availHeight - 440) / 2 + ",width=700,height=440");
}

function sendMessage(uNickname, receiver_id, msgType) {
	var tw = window.open(
			"http://localhost:8282/eepp/message/sendMessage?receiver="
					+ uNickname + "&receiver_id=" + receiver_id
					+ "&messageType=" + msgType + "&from=in", "sendmessage",
			"left=" + (screen.availWidth - 370) / 2 + ",top="
					+ (screen.availHeight - 425) / 2 + ",width=370,height=425");
}