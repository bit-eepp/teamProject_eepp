	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};

//회원정보 - 메세지 보내기
function sendMessage(uNickname, receiver_id){
	var tw = window.open("http://localhost:8282/eepp/message/sendMessage?receiver="+uNickname+"&receiver_id="+receiver_id+"&from=out", "sendmessage","left="+(screen.availWidth-370)/2
			+",top="+(screen.availHeight-425)/2+",width=370,height=425");
}
//회원정보 - 회원정보 보기
function memberInfo(uNickname, user_id){
	var member = window.open("http://localhost:8282/eepp/memInfo?memberWho="+uNickname+"&user_id="+user_id,"memberInfo","left="+(screen.availWidth-700)/2
				 +",top="+(screen.availHeight-560)/2+",width=425,height=560");
}

//유저 신고 메서드
function reportUser(formId,reportedNickname) {
	var dReasonUser =  document.getElementById("declaration_user_"+formId).dReason;
		
	if(dReasonUser.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url:getContextPath()+'/declaration/doUserDeclaration',
			data:$('#declaration_user_'+ formId +'[role=formDeclaration_user_' + formId +']').serialize(),
			success:function(msg){
				alert(reportedNickname +'님을 신고했습니다.');
				$('#report_user_' + formId).modal('hide');
				ResetForm(formId);
			}
		});
	}
}

function ResetForm(formId) {
	$('#report_user_' + formId).on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}

//댓글 유저 신고 메서드
function reportRpUser(userId,reportedNickname) {
	var dReasonRpUser = document.getElementById("declaration_rp_user_"+userId).dReason;
	
		if(dReasonRpUser.value == "") {
			alert("신고사유를 선택 해주세요.");
			return false;
		} else {
			$.ajax({
				type:'POST',
				url:getContextPath()+'/declaration/doUserDeclaration',
				data:$('#declaration_rp_user_'+ userId +'[role=formDeclaration_rp_user_' + userId +']').serialize(),
				success:function(msg){
					alert(reportedNickname +'님을 신고했습니다.');
					$('#report_rp_user_' + userId).modal('hide');
					ResetRpForm(userId);
				}
			});
		}
	
}
function ResetForm(userId) {
	$('#report_rp_user_' + userId).on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}