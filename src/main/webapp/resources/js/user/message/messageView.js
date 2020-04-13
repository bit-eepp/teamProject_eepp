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
	 var tw = window.open(getContextPath()+"/eepp/message?messageType="+msgType,"message","left="+(screen.availWidth-700)/2
			 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
}

function reset(msgType){
	window.open('about:blank', '_self').close();
	openMsg(msgType);
}