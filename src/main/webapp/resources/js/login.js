//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};
//취소
$(".cancle").click(function(event) {
	location.href = getContextPath()+"/login/login.do";
})

$(document).ready(function() {
	$("#findMyPW02").hide();
	$("#findMyPW03").hide();
})

// 유효성검사
$("#registerInfo").click(function(event) {
	if ($(".uEmail").val() == "") {
		alert("이메일을 입력해주세요");
		$(".uEmail").focus();
		return false;
	}
	return true;
});

$("#findRegisterEmail").click(function(event) {
	if ($(".uPhone_2").val() == "") {
		alert("핸드폰 번호를 입력해주세요.");
		$(".uPhone_2").focus();
		return false;
	}else if($(".uPhone_3").val() == ""){
		alert("핸드폰 번호를 입력해주세요.");
		$(".uPhone_3").focus();
		return false;
	}
	findRegisterEmail();
});

// 가입 이메일 찾기
function findRegisterEmail() {

	var uPhone = $(".uPhone_1").val() +"-"+$(".uPhone_2").val() +"-"+ $(".uPhone_3").val()
	$.ajax({
		url : getContextPath()+"/findRegisterEmail",
		type : "post",
		dataType : "json",
		data : {
			"uPhone" : uPhone
		},
		success : function(data) {
			if (data != "") {
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
				alert("존재하지않는 핸드폰번호입니다.");
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
		
/* 이메일 인증 번호 확인 */
function checkPasswordAuth() {
	
	$.ajax({
		url : getContextPath()+"/checkPasswordAuth",
		type : "post",
		dataType : "json",
		data : {
			"authCode" : $(".findAuthCode").val(),
			"random" : $(".random").val()
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