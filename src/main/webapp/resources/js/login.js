//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};
//취소
$(".cancle").click(function(event) {
	location.href = getContextPath()+"/login/login.do";
})
//엔터키 처리
$(".uEmailInput").keydown(function(key) {
	if (key.keyCode == 13) {
		$('#registerInfoPW').click();
		return false;
	}
});

$(document).ready(function() {
	$("#findMyEmail02").hide();
	$("#findMyPW02").hide();
	$("#findMyPW03").hide();
	
	if(!$(".loginFailInfo").val()){
		return true;
	}
	else if($(".loginFailInfo").val() == 'grade3'){
		alert("신고 10회가 누적되어 정지된 계정입니다.");
		return true;
	}
	else if($(".loginFailInfo").val() == 'grade4'){
		alert("탈퇴처리된 계정입니다.\n계정 탈퇴일로부터 90일 후에 재가입 가능합니다.");
		return true;
	}
	else if ($(".loginFailInfo").val() == 'notSns'){
		alert("일반계정으로 가입된 아이디입니다.");
		return true;
	}
	else if($(".otherSNS").val() == 'otherSNS'){
		alert("다른 SNS계정으로 가입된 아이디입니다.");
		return true;
	}
})

$("#registerInfoID").click(function() {
	if ($(".uPhone_2").val() == "") {
		alert("핸드폰 번호를 입력해주세요.");
		$(".uPhone_2").focus();
		return false;
	}else if($(".uPhone_3").val() == ""){
		alert("핸드폰 번호를 입력해주세요.");
		$(".uPhone_3").focus();
		return false;
	}else{
		phoneCheck()
	}
});

/* 휴대폰 DB 확인 */
var phCheck = 0;
function phoneCheck() {
  $.ajax({
	  url : getContextPath() + "/phoneNumCheck",
	  type : "post",
	  dataType : "json",
      data : {
    	  "uPhone" : $(".uPhone_1").val() + "-" + $(".uPhone_2").val() + "-" + $(".uPhone_3").val()
      },
      success : function(data) {
         if(data != 0){
        	 sendSms()
         }else {
        	 alert("등록되지않은 휴대폰번호입니다.");
        	 $(".uPhone_2").focus();
         }
      }
  });
}

/* 인증번호 문자 발송 */
function sendSms() { 
	$.ajax({ 
		url: getContextPath()+"/sendSms",
		data: { 
			receiver:$(".uPhone_1").val() + $(".uPhone_2").val() + $(".uPhone_3").val()
		}, 
		type: "post", 
		success: function(result) {
			alert("인증번호가 발송되었습니다. \n인증번호를 입력해주세요.");
			$(".sendAuthBtnWrap").hide(500);
			$("#findMyEmail02").show(500);
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	}); 
}
/* 핸드폰 인증 및 중복확인 */
$("#findRegisterEmail").click(function() {
	if($(".findIDAuthCode").val() == ""){
		alert("인증번호를 입력해주세요.");
		return false;
	}else{
		findRegisterEmail();
	}
});
/* 인증번호 검사 후 이메일 표시 */
function findRegisterEmail() {

	var uPhone = $(".uPhone_1").val() +"-"+$(".uPhone_2").val() +"-"+ $(".uPhone_3").val()
	$.ajax({
		url : getContextPath()+"/findRegisterEmail",
		type : "post",
		dataType : "json",
		data : {
			"uPhone" : uPhone,
			"authCode" : $(".findIDAuthCode").val()
		},
		success : function(data) {
			if (data != "") {
				alert("인증에 성공했습니다.")
				var userEmail = JSON.stringify(data.uEmail);
				$(".inputUserInfo").hide();
				var show = "";
				show += '<p class="isYourEmail">귀하의 가입 이메일 정보입니다.</p>';
				show += '<p>'+userEmail+'</p>';
				show += '<div class="loginBtnWrap">';
				show += '<a class="loginBtn" href="'+getContextPath()+'/login/login.do">로그인 하러가기</a>';
				show += '</div>';
				$("#showMyEmail").append(show);
				return;
			} else if (data == "") {
				alert("등록되지않은 휴대폰번호입니다.");
				$(".uPhone_2").focus();
			}
			return false;
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};


$("#registerInfoPW").click(function(event) {
	if ($(".uEmail").val() == "") {
		alert("이메일을 입력해주세요");
		$(".uEmail").focus();
		return false;
	}else{
		sendPasswordAuth()
	}
});
/* 이메일로 인증번호 발송 */
function sendPasswordAuth() {
	
	$.ajax({
		url : getContextPath()+"/sendPasswordAuth",
		type : "post",
		dataType : "json",
		data : {
			"uEmail" : $(".uEmail").val(),
			"random" : $(".random").val()
		},
		success : function(data) {
			if (data != 0) {
				alert("인증번호가 발송되었습니다. \n인증번호를 입력해주세요");
				$(".sendAuthBtnWrap").hide();
				$("#findMyPW02").show();
				return;
		} else if (data == 0) {
			alert("등록되지 않은 이메일입니다.")
			$(".uEmail").focus();
		}
		return false;
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};

$(".authCheckBtn").click(function(event) {
	if ($(".findPWAuthCode").val() == "") {
		alert("인증번호를 입력해주세요.");
		return false;
	}else{
		checkPasswordAuth()
	}
});
/* 이메일 인증 번호 확인 */
function checkPasswordAuth() {
	
	$.ajax({
		url : getContextPath()+"/checkPasswordAuth",
		type : "post",
		dataType : "json",
		data : {
			"authCode" : $(".findPWAuthCode").val(),
		},
		success : function(data) {
			if (data != 0) {
				alert("인증이 완료되었습니다.");
				$("#findMyPW01").hide();
				$("#findMyPW02").hide();
				$("#findMyPW03").show();
			} else if (data == 0) {
			alert("인증번호를 잘못 입력하셨습니다.")
			}
		}
	});
};