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