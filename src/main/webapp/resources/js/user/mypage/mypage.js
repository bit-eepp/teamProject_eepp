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

function nickCheck() {
	$.ajax({
		url : getContextPath() + "/mypagenickNameCheck",
		type : "post",
		dataType : "json",
		data : {
			"uNickname" : $("#changeNickname").val()
		},
		success : function(data) {
			if ($("#changeNickname").val() == "") {
				alert("닉네임을 입력해주세요.");
				$("#changeNickname").focus();
				return false;
			} else if (data == 0) {
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

	if ($("#changeNickname").val() == "") {
		alert("닉네임을 입력해주세요.");
		$("#changeNickname").focus();
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

//페이징
function pageColor(pageNum) {
	   $('#boardpaging_'+pageNum).css("background-color", "#59bfbf");
	   $('#boardpaging_'+pageNum).css("color", "#ffffff");
	}
function pageColor(pageNum) {
	   $('#pointpage_'+pageNum).css("background-color", "#59bfbf");
	   $('#pointpage_'+pageNum).css("color", "#ffffff");
	}
function pageColor(pageNum) {
	   $('#scrapBoardPage_'+pageNum).css("background-color", "#59bfbf");
	   $('#scrapBoardPage_'+pageNum).css("color", "#ffffff");
	}
function pageColor(pageNum) {
	   $('#scrapClassPage_'+pageNum).css("background-color", "#59bfbf");
	   $('#scrapClassPage_'+pageNum).css("color", "#ffffff");
	}
function pageColor(pageNum) {
	   $('#scrapBoardPage_'+pageNum).css("background-color", "#59bfbf");
	   $('#scrapBoardPage_'+pageNum).css("color", "#ffffff");
	}
function pageColor(pageNum) {
	   $('#clJoinPage_'+pageNum).css("background-color", "#59bfbf");
	   $('#clJoinPage_'+pageNum).css("color", "#ffffff");
	}
function pageColor(pageNum) {
	   $('#clOpenPage_'+pageNum).css("background-color", "#59bfbf");
	   $('#clOpenPage_'+pageNum).css("color", "#ffffff");
	}

$(document).ready(function() {
	$(".selectDeleteBtn1").click(function() {
		deleteScrap();
	});
});

// 전체 선택 or 해제
$(function() { 
	// 전체선택 체크박스 클릭
	$(".allCheck").click(function() {
		if ($(".allCheck").prop("checked")) {
			$("input:checkbox[name='pickCheck']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck']").prop("checked", false);
		}
	})
})

// 체크박스 선택 삭제
function deleteScrap() {
	var checkRow = "";
	$("input[name='pickCheck']:checked").each(function() {
		checkRow = checkRow + $(this).val() + ",";
	});
	checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); // 맨끝 콤마 지우기

	if (checkRow == '') {
		alert("삭제할 대상을 선택하세요.");
		return false;
	} else {
		if (confirm("정말 삭제하시겠습니까?") == true) {
			$.ajax({
				url : getContextPath() + "/deleteScrap",
				type : "post",
				data : {
					"checkRow" : checkRow,
					"scrap1" : $(".scrap1").val()
				},
				success : function(data) {
					alert("스크랩이 삭제되었습니다.");
					location.href="http://localhost:8282/eepp/mypage?&scrap=yes";
				},
				error : function(request, status, error) {
					alert("에러가 발생했습니다.");
					console.log(request.responseText);
					console.log(error);
				}
			})
		} else {
			return false;
		}
	}
}

// 클래스 구입자 보기
function classjoin_list(cId){
	var member = window.open("http://localhost:8282/eepp/classjoin_list?cId="+cId,"classjoin_list","left="+(screen.availWidth-700)/2
			+",top="+(screen.availHeight-560)/2+",width=530,height=560");
}
