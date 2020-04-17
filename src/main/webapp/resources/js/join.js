//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

$(document).ready(function() {
	$("#afterSendSMSAuth").hide();
	
	$('html .joinTable input').click(function(e) {
		if(!$(e.target).hasClass("checkInfo")) {
			$(".checkInfo").html("")
		}
	});
		
});

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

	if (emCheck == 0) {
		if($(".snsEmail").text() != ""){
			return;
		}
		alert("아이디를 입력해주세요.");
		$("#email_01").focus();
		return false;
	}else if (emCheck == 2) {
		if($(".snsEmail").text() != ""){
			return;
		}
		alert("사용중인 아이디입니다.");
		$("#email_01").focus();
		return false;
	}
	
	if (ncCheck == 0) {
		alert("닉네임을 입력해주세요.");
		$("#uNickname").focus();
		return false;
	}else if(ncCheck == 2){
		alert("사용중인 닉네임입니다.");
		$("#uNickname").focus();
		return false;
	}

	if (pwCheck == 0) {
		alert("비밀번호를 입력해주세요.");
		$("#uPassword").focus();
		return false;
	}else if(pwCheck == 2){
		alert("비밀번호가 다릅니다.");
		$("#uPasswordCheck").focus();
		return false;
	}
	
	if (phCheck == 0) {
		alert("휴대폰 번호를 입력해주세요.");
		$(".uPhone_2").focus();
		return false;
	}else if(phCheck == 2){
		alert("이미 가입된 휴대폰번호입니다.");
		$(".uPhone_2").focus();
		return false;
	}
	
	var phoneChkVal = $("#phoneNumCheck").val();
	if (phoneChkVal == "N") {
		alert("휴대폰 인증을 해주세요.");
		return false;
	}
	
	var phoneAuthChkVal = $("#smsAuthBtn").val();
	if (phoneAuthChkVal == "N") {
		alert("휴대폰 인증번호를 확인해주세요.");
		return false;
	}

	return true;
});

/* 이메일 중복확인 */
var emCheck = 0;
function checkEmail() {
	var uEmail = $("#email_01").val() + "@" + $("#emailSelection").val();
	var email01 = $("#email_01").val();
	var email02 = $("#email_02").val();
  $.ajax({
      dataType : "json",
      type : "post",
      url : getContextPath() + "/checkEmailDuplicate",
      data : {
    	  "uEmail" : uEmail,
      },
      success : function(data) {
          if(email01 == "" && email02 == "" && data==0) {
          	  $("#checkEmailInfo").html("")
          	  $(".joinTable input").not(".emailInput, #file_route").attr('disabled', false).css("background","transparent");
              emCheck = 0;
              return false;
          } else if (data == 0) {
        	  emCheck = 1;
        	  $(".joinTable input").not(".emailInput, #file_route").attr('disabled', false).css("background","transparent");
              $("#checkEmailInfo").html("사용가능한 아이디입니다.")
              return true;
          } else if (data == 1) {
          	$("#checkEmailInfo").html("사용중인 아이디입니다.")
          	$(".joinTable input").not(".emailInput, #file_route").attr('disabled', true).css("background","#ececec");
            emCheck = 2;
            return false;
          } 
      }
  });
}
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

/* 비밀번호 재입력 확인 */
var pwCheck = 0;
function passWordCheck() {
	var orgpw = $("#uPassword").val();
    var checkpw = $("#uPasswordCheck").val();
    
    if(checkpw=="") {
    	$("#checkPwInfo").html("")
    	$(".joinTable input").not("#uPassword,#uPasswordCheck, #file_route, .emailInput").attr('disabled', false).css("background","transparent");
        pwCheck = 0;
        return false;
    } else if (checkpw == orgpw) {
    	$("#checkPwInfo").html("")
    	$(".joinTable input").not("#uPassword,#uPasswordCheck, #file_route, .emailInput").attr('disabled', false).css("background","transparent");
        pwCheck = 1;
        return true;
    } else if (checkpw != orgpw) {
    	$("#checkPwInfo").html("비밀번호가 다릅니다.");
    	$(".joinTable input").not("#uPassword,#uPasswordCheck, #file_route, .emailInput").attr('disabled', true).css("background","#ececec");
    	pwCheck = 2;
    	return false;
    }
    
}

/* 닉네임 중복확인 */
var ncCheck = 0;
function nickCheck() {
    var inputed = $("#joinNickname").val();
    $.ajax({
        dataType : "json",
        type : "post",
        url : getContextPath() + "/nickNameCheck",
        data : {
        	"uNickname" : $("#joinNickname").val()
        },
        success : function(data) {
            if(inputed=="" && data==0) {
            	$("#checkNickInfo").html("")
            	$(".joinTable input").not("#joinNickname, #file_route, .emailInput, .pwInputBox").attr('disabled', false).css("background","transparent");
                ncCheck = 0;
                return false;
            } else if (data == 0) {
            	ncCheck = 1;
            	$(".joinTable input").not("#joinNickname, #file_route, .emailInput, .pwInputBox").attr('disabled', false).css("background","transparent");
                $("#checkNickInfo").html("사용가능한 닉네임입니다.")
                return true;
            } else if (data == 1) {
            	$("#checkNickInfo").html("사용중인 닉네임입니다.")
            	$(".joinTable input").not("#joinNickname, #file_route, .emailInput, .pwInputBox").attr('disabled', true).css("background","#ececec");
                ncCheck = 2;
                return false;
            } 
        }
    });
}


/* 휴대폰 중복확인 */
var phCheck = 0;
function phoneCheck() {
  $.ajax({
	  url : getContextPath() + "/phoneNumCheck",
	  type : "post",
	  dataType : "json",
      data : {
    	  "uPhone" : $("#uPhone").val()+"-"+$(".uPhone_2").val()+"-"+ $(".uPhone_3").val()
      },
      success : function(data) {
          if($(".uPhone_2").val() == "" && $(".uPhone_3").val() == "" && data==0) {
          	$("#checkPhoneInfo").html("")
              phCheck = 0;
          }else if (data == 0) {
        	  $("#checkPhoneInfo").html("사용가능한 휴대폰번호입니다.")
        	  phCheck = 1;
          } else if (data == 1) {
          	$("#checkPhoneInfo").html("이미 가입된 휴대폰번호입니다.")
              phCheck = 2;
          } 
      }
  });
}

$(".sendSmsBtn").click(function() {
	if(phCheck == 0){
		alert("휴대폰번호를 입력해주세요.");
		return false;
	}else if(phCheck == 2){
		alert("이미 가입된 휴대폰번호입니다.");
		return false;
	}else{
		$("#checkPhoneInfo").html("")
		$('#phoneNumCheck').attr("value", "Y");
		sendSms();
		return true;
	}
});

/* 인증번호 문자 발송 */
function sendSms() { 
	$.ajax({ 
		url: getContextPath()+"/sendSms",
		data: { 
			receiver:$("#uPhone").val()+$(".uPhone_2").val()+$(".uPhone_3").val()
		}, 
		type: "post", 
		success: function(result) {
			alert("인증번호가 발송되었습니다. \n인증번호를 입력해주세요.");
			$("#smsAuth").attr('disabled', false).css("background","transparent");
			$("#afterSendSMSAuth").show(500);
			return true;
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	}); 
}
/* 핸드폰 인증 및 중복확인 */
$(".smsCheckBtn").click(function() {
	if($("#smsAuth").val() == ""){
		alert("인증번호를 입력해주세요.");
		return false;
	}else{
		checkPhoneAuth();
		return true;
	}
});
/* 인증번호 검사 */
function checkPhoneAuth() {
	$.ajax({ 
		url: getContextPath()+"/smsCheck",
		type: "post",
		data: { 
			authCode: $("#smsAuth").val()
		},
		success: function(result) { 
			if (result == "ok") { 
				alert("인증에 성공했습니다.");
				$('#smsAuthBtn').attr("value", "Y");
				$("#smsAuth").attr('disabled', true).css("background","#ececec");
				return true;
			} else { 
				alert("인증에 실패했습니다./n인증번호를 확인해주세요.");
				return false;
			} 
		} 
	}); 
}

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
