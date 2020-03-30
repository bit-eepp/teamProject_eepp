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

/* 닉네임 중복확인 */
var ncCheck = 0;
function nickCheck() {
    var inputed = $("#changeNickname").val();
    $.ajax({
        dataType : "json",
        type : "post",
        url : getContextPath() + "/nickNameCheck",
        data : {
        	"uNickname" : $("#changeNickname").val()
        },
        success : function(data) {
            if(inputed=="" && data==0) {
            	$("#checkNickInfo").html("")
                ncCheck = 0;
            } else if (data == 0) {
                $("#checkNickInfo").html("사용가능한 닉네임입니다.")
                ncCheck = 1;
            } else if (data == 1) {
            	$("#checkNickInfo").html("사용중인 닉네임입니다.")
                ncCheck = 2;
            } 
        }
    });
}

$('#submit').click(function(event) {
	if (ncCheck == 0) {
		alert("닉네임을 입력해주세요.");
		$("#changeNickname").focus();
		return false;
	}else if(ncCheck == 2){
		alert("이미 사용중인 닉네임입니다.")
		$("#changeNickname").focus();
		return false;
	}else{
		return true;	
	}

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
	alert("회원탈퇴 페이지로 이동합니다.");
	// if (confirm("회원탈퇴 페이지 입니다. 계속 하시겠습니까?") == true) {
	// document.form.submit();
	// } else {
	// return;
	// }
}

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
 if (!$('#mpInfo').val()) {
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

// 스크랩 보여주고 닫기
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

// 포인트 사용내역 보여주고 닫기
$(document).ready(function() {
	if (!$('#mpPoint').val()) {
		$("#point_list").hide();
	} else {
		$("#point_list").show();
	}
})
$("#mypointbtn").click(function() {
	$("#point_list").slideToggle();
});

//클래스 내역 보여주고 닫기
$(document).ready(function() {
	if (!$('#mpclass').val()) {
		$(".myclass_list").hide();
	} else {
		$(".myclass_list").show();
	}
})
$("#myclassbtn").click(function() {
	$(".myclass_list").slideToggle();
});

// // 회원탈퇴 질문
// function confirm_event() {
// if (confirm("지금 탈퇴하시면 60일 동안 재가입 하실 수 없습니다. 정말 삭제하시겠습니까??")== true) {
// alert("탈퇴되었습니다.");
// // 삭제페이지나 submit처리를 해준다 //
// document.form.submit();
// } else {
// return;
// }
// }
