//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};
//취소
$(".cancle").click(function(event) {
	location.href = getContextPath()+"/login/login.do";
})

/* 아이디 or 비밀번호 찾기 선택 */
$(document).ready(function() {
	$("#findEmailBox").hide();
	$("#resetPasswordBox").hide();
});
$("#showPasswordBox").click(function(){
	$("#selectView").css("display", "none");
    $("#resetPasswordBox").show();
    $("#pw_step02").hide();
    $("#pw_step03").hide();
  });
$("#showEmailBox").click(function(){
	$("#selectView").css("display", "none");
    $("#findEmailBox").show();
    $("#email_step02").hide();
});
/*  */

/* 이메일 찾기 view */
$("#showPasswordBox02").click(function(){
    $("#showPasswordBox").show(500);
    $("#showEmailBox").hide();
  });
/* */
 

  
// 유효성검사
$("#registerInfo").click(function(event) {
	if ($(".uEmail").val() == "") {
		alert("이메일을 입력해주세요");
		$(".uEmail").focus();
		return false;
	}
	return true;
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
				 $("#email_step01").hide();
				var userEmail = JSON.stringify(data.uEmail);
				$("#showMyEmail").append('<p>' + "귀하의 가입 이메일 정보입니다." + '</p><p>'+userEmail+'</p>');
			    $("#email_step02").show();
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
				alert("인증번호가 발송되었습니다. \n 인증번호를 입력해주세요");
				$("#pw_step02").show();
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
			"authCode" : $(".forgotAuthCode").val(),
			"random" : $(".random").val()
		},
		success : function(data) {
			if (data != 0) {
				alert("인증이 완료되었습니다.");
				$("#pw_step03").show();
			} else if (data == 0) {
			alert("인증번호를 잘못 입력하셨습니다.")
			}
		}
	});
};