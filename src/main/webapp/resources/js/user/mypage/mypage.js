/*
 * 
 * mypage javascript
 *
 */

// 프로필 업로드 사진 미리보기
$("#showImg").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".img-circle").attr("src", data.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	}
});

// ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

function nickCheck() {
	$.ajax({
		url : getContextPath() + "/mypagenickNameCheck",
		type : "post",
		dataType : "json",
		data : {
			"uNickname" : $("#uNickname").val()
		},
		success : function(data) {
			if (data == 0) {
				alert("사용가능한 닉네임입니다.");
				$('#mypagenickNameCheck').attr("value", "Y");
				return;
			} else if (data != 0) {
				alert("사용중인 닉네임입니다.")
				$('#mypagenickNameCheck').attr("value", "N");
				$("#uNickname").focus();
			}
		},
		error : function(data) {
			alert("에러가 발생했습니다.");
			return false;
		}
	})
};

$('#submit').click(function(event) {

	if ($("#uNickname").val() == "") {
		alert("닉네임을 입력해주세요.");
		$("#uNickname").focus();
		return false;
	}

	var nickChkVal = $("#mypagenickNameCheck").val();
	if (nickChkVal == "N") {
		alert("닉네임 중복확인을 해주세요.");
		return false;
	}

	return true;

});

// 게시물 검색
$('#searchBtn').click(
		function() {
			if ($('select[name=searchType]').val() == 'n') {
				alert('검색조건을 지정해주세요');
				return;
			} else {
				self.location = "mypage" + $("#mypageMakeQuery").val()
						+ "&searchType=" + $("select[name=searchType]").val()
						+ "&keyword="
						+ encodeURIComponent($('#keywordInput').val())
						+ "&sortType=" + $("#sortType").val() + "&bCategory="
						+ $("#bCategory").val();
			}
		});
// 회원탈퇴 알림
function drop() {
	alert("회원탈퇴 페이지 입니다. 계속 하시겠습니까?")
};

// 프로필 사진 있는지 확인 - 있으면 변경
$('#register_Btn').click(function() {
	var fileCheck = document.getElementById("showImg").value;
	if (!fileCheck) {
		alert("프로필 사진 첨부해 주세요");
		return false;
	} else {
		alert("프로필 변경 완료");
	}
});
;
// 기본 이미지로 변경 alert
$('#changeImg').click(function() {
	alert("기본 이미지로 변경됩니다.")
});

// 회원정보 수정 보여주고 닫기
$(document).ready(function() {
	if (!$('#showInfo').val()) {
		$(".info").hide();
	} else {
		$(".info").show();
	}
})
$("#myinfobtn").click(function() {
	$(".info").slideToggle();
});

// 게시글 보여주고 닫기
$(document).ready(function() {
	if (!$('#board').val()) {
		$(".content_list").hide();
	} else {
		$(".content_list").show();
	}
})
$("#mycontentbtn").click(function() {
	$(".content_list").slideToggle();
});

//스크랩 보여주고 닫기
$(document).ready(function() {
	if (!$('#scrap').val()) {
		$(".scrap_list").hide();
	} else {
		$(".scrap_list").show();
	}
})
$("#myscrapbtn").click(function() {
	$(".scrap_list").slideToggle();
});

//포인트 사용내역 보여주고 닫기
$(document).ready(function() {
	if (!$('#point').val()) {
		$("#point_list").hide();
	} else {
		$("#point_list").show();
	}
})
$("#mypointbtn").click(function() {
	$("#point_list").slideToggle();
});
