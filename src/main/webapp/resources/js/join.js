//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

$(document).ready(function() {
	$("#afterSendEmailAuth").hide();
});
// 취소
$(".cancle").click(function(event) {
	location.href = getContextPath() + "/main.ma";
})

// 로그인 유효성검사
$('#submit').click(function(event) {
	// 약관동의
	var isAgreeChk01 = $("#isAgree_01").is(":checked");
	if (!isAgreeChk01) {
		alert("이용약관에 동의하셔야 회원가입이 가능합니다.");
		return false;
	}
	var isAgreeChk02 = $("#isAgree_02").is(":checked");
	if (!isAgreeChk02) {
		alert("개인정보이용 및 사용에 동의하셔야 회원가입이 가능합니다.");
		return false;
	}

	if ($("#email_01").val() == "") {
		alert("이메일을 입력해주세요.");
		$("#email_01").focus();
		return false;
	}

	if ($("#email_02").val() == "select") {
		alert("이메일을 선택해주세요.");
		$("#email_02").focus();
		return false;
	}

	var emChkVal = $("#emailBtn").val();
	if (emChkVal == "N") {
		alert("이메일 인증을 해주세요.");
		return false;
	}

	var authChkVal = $("#emailAuthBtn").val();
	if (authChkVal == "N") {
		alert("이메일 인증번호를 확인해주세요.");
		return false;
	}

	if ($("#uPassword").val() == "") {
		alert("비밀번호를 입력해주세요.");
		$("#uPassword").focus();
		return false;
	}

	var orgPW = $("#uPassword").val();
	var checkPW = $("#uPasswordCheck").val();
	if (orgPW != checkPW) {
		alert("비밀번호가 다릅니다.");
		$("#uPasswordCheck").focus();
		return false;
	}

	if ($("#uNickname").val() == "") {
		alert("닉네임을 입력해주세요.");
		$("#uNickname").focus();
		return false;
	}

	var nickChkVal = $("#nickNameCheck").val();
	if (nickChkVal == "N") {
		alert("닉네임 중복확인을 해주세요.");
		return false;
	}

	return true;
});

/* 닉네임 중복확인 */
function nickCheck() {
	$.ajax({
		url : getContextPath() + "/nickNameCheck",
		type : "post",
		dataType : "json",
		data : {
			"uNickname" : $("#uNickname").val()
		},
		success : function(data) {
			if (data == 0) {
				alert("사용가능한 닉네임입니다.");
				$('#nickNameCheck').attr("value", "Y");
				return;
			} else if (data != 0) {
				alert("사용중인 닉네임입니다.")
				$('#nickNameCheck').attr("value", "N");
				$("#uNickname").focus();
			}
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};

// 이메일 입력방식
$('#emailSelection').change(function() {
	$("#emailSelection option:selected").each(function() {
		if ($("#selectEmail").val() == '') {
			// 직접입력
			$("#email_02").val('');
			$("#email_02").attr("readonly", false);
		} else {
			// 선택
			$("#email_02").val($(this).val());
			$("#email_02").attr("readonly", true);
		}
	});
});

$(".emailBtn").click(function() {
	$("#afterSendEmailAuth").show(500);
});

/* 이메일 인증 메일 발송 */
function sendEmailAuth() {
	var uEmail = $("#email_01").val() + "@" + $("#email_02").val();
	var random = $("#random").val();

	$.ajax({
		url : getContextPath() + "/sendEmailAuth",
		type : "post",
		dataType : "json",
		data : {
			"uEmail" : uEmail,
			"random" : random
		},
		success : function(data) {
			if (data != 0) {
				alert("인증번호가 발송되었습니다. 인증번호를 입력해주세요.");
				$('#emailBtn').attr("value", "Y");
				return;
			} else if (data == 0) {
				alert("이미 등록된 이메일입니다. \n 로그인 해주세요.")
				$('#emailBtn').attr("value", "N");
			}
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};

/* 이메일 인증 번호 확인 */
function checkEmailAuth() {
	var authCode = $("#emailAuth").val();
	var random = $("#random").val();

	$.ajax({
		url : getContextPath() + "/checkEmailAuth",
		type : "post",
		dataType : "json",
		data : {
			"authCode" : authCode,
			"random" : random
		},
		success : function(data) {
			if (data != 0) {
				alert("인증이 완료되었습니다.");
				$('#emailAuthBtn').attr("value", "Y");
				return;
			} else if (data == 0) {
				alert("인증번호를 잘못 입력하셨습니다.")
				$("#emailAuthBtn").attr("value", "N");
			}

			return false;
		}

	});
};

/* 닉네임 중복확인 */
function phoneCheck() {
	$.ajax({
		url : getContextPath() + "/phoneNumCheck",
		type : "post",
		dataType : "json",
		data : {
			"uPhone" : $("#uPhone").val() + "-" + $(".uPhone_2").val() + "-"
					+ $(".uPhone_3").val()
		},
		success : function(data) {
			if (data == 0) {
				alert("사용가능한 핸드폰번호 입니다.");
				$('#phoneNumCheck').attr("value", "Y");
				return;
			} else if (data != 0) {
				alert("이미 등록된 핸드폰번호 입니다.")
				$('#phoneNumCheck').attr("value", "N");
				$(".uPhone_2").focus();
			}
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};
//프로필 사진 업로드시 미리보기
$("#showImg").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".basic_img").attr("src", data.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	}
});
