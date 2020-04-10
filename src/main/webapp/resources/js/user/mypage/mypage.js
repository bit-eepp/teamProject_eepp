/*
 * 
 * MYPAGE JAVASCRIPT
 *
 */


// ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};
// 프로필 이미지 미리 보기
$("#showImg").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".img-circle").attr("src", data.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	}
});

//프로필 사진 있는지 확인 - 있으면 변경
$('#register_Btn').click(function() {
	var fileCheck = document.getElementById("showImg").value;
	if (!fileCheck) {
		alert("프로필 사진 첨부해 주세요");
		return false;
	} else {
		alert("프로필 변경 완료");
	}
});

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
			if (inputed == "" && data == 0) {
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
	} else if (ncCheck == 2) {
		alert("이미 사용중인 닉네임입니다.")
		$("#changeNickname").focus();
		return false;
	} else {
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
				self.location = "myContent" + $("#mypageMakeQuery").val()
						+ "&searchType=" + $("select[name=searchType]").val()
						+ "&keyword="
						+ encodeURIComponent($('#keywordInput').val())
						+ "&board=yes"
			}
		});

// 엔터키로 검색
$('#keywordInput').keydown(
		function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == 13) {
				if ($('select[name=searchType]').val() == 'n') {
					alert('검색조건을 지정해주세요');
					return;
				} else {
					self.location = "myContent" + $("#mypageMakeQuery").val()
							+ "&searchType="
							+ $("select[name=searchType]").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput').val())
							+ "&board=yes";
				}
			}
		});

// 회원탈퇴 알림
function drop() {
	alert("회원탈퇴 페이지로 이동합니다.");
}

// 회원탈퇴 - 숫자만 가능
function onlyNumber(e) {
	var keyValue = event.keyCode;
	if (((keyValue >= 48) && (keyValue <= 57)))
		return true;
	else
		return false;
}

// 기본 이미지로 변경 alert
$('#changeImg').click(function() {
	alert("기본 이미지로 변경됩니다.")
});

// 페이징
$(document).ready(function() {
	var pageNum1 = $('#mypageMakerCriPage').val();//myPagePageMaker
	pageColor1(pageNum1);
});

function pageColor1(pageNum1) {
	$('#boardpaging_' + pageNum1).css("background-color", "#59bfbf");
	$('#boardpaging_' + pageNum1).css("color", "#ffffff");
}

// 전체 선택 or 해제 (게시판 스크랩)
$(function() {
	$(".allCheck").click(function() {
		if ($(".allCheck").prop("checked")) {
			$("input:checkbox[name='pickCheck']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck']").prop("checked", false);
		}
	})
})
// 게시글 스크랩 삭제
$(document).ready(function() {
	$("#selectDeleteBtn_Sboard").click(function() {
		deleteScrap_Sboard();
	});
});

function deleteScrap_Sboard() {
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
			$
					.ajax({
						url : getContextPath() + "/deleteScrap",
						type : "post",
						data : {
							"checkRow" : checkRow
						},
						success : function(data) {
							alert("스크랩이 삭제되었습니다.");
							location.href = "http://localhost:8282/eepp/myScrap?tabType=myScrapBoard"
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

//전체 선택 or 해제(클래스 스크랩)
$(function() {
	$(".allCheck1").click(function() {
		if ($(".allCheck1").prop("checked")) {
			$("input:checkbox[name='pickCheck1']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck1']").prop("checked", false);
		}
	})
})

//클래스 스크랩 삭제
$(document).ready(function() {
	$("#selectDeleteBtn_SClass").click(function() {
		deleteScrap_SClass();
	});
});

function deleteScrap_SClass() {
	var checkRow = "";
	$("input[name='pickCheck1']:checked").each(function() {
		checkRow = checkRow + $(this).val() + ",";
	});
	checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); // 맨끝 콤마 지우기
	if (checkRow == '') {
		alert("삭제할 대상을 선택하세요.");
		return false;
	} else {
		if (confirm("정말 삭제하시겠습니까?") == true) {
			$
					.ajax({
						url : getContextPath() + "/deleteScrap",
						type : "post",
						data : {
							"checkRow" : checkRow
						},
						success : function(data) {
							alert("스크랩이 삭제되었습니다.");
							location.href = "http://localhost:8282/eepp/myScrap?tabType=myScrapClass";
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

//전체 선택 or 해제(맛집 스크랩)
$(function() {
	$(".allCheck2").click(function() {
		if ($(".allCheck2").prop("checked")) {
			$("input:checkbox[name='pickCheck2']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck2']").prop("checked", false);
		}
	})
})

// 맛집 스크랩 삭제
$(document).ready(function() {
	$("#selectDeleteBtn_SEating").click(function() {
		deleteScrap_SEating();
	});
});

function deleteScrap_SEating() {
	var checkRow = "";
	$("input[name='pickCheck2']:checked").each(function() {
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
							"checkRow" : checkRow
						},
						success : function(data) {
							alert("스크랩이 삭제되었습니다.");
							location.href = "http://localhost:8282/eepp/myScrap?tabType=myScrapEating";
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
function classjoin_list(cId) {
	var member = window.open("http://localhost:8282/eepp/classjoin_list?cId="
			+ cId, "classjoin_list", "left=" + (screen.availWidth - 530) / 2
			+ ",top=" + (screen.availHeight - 620) / 2
			+ ",width=530,height=620");
}


// 스크랩, 클래스 탭 유지
$(document).ready(function() {
	var title = $(".tabType").val();
	tabTypeTitle(title);
	console.log(title);
});

function tabTypeTitle(title) {
	if (title == 'myScrapBoard') { // 게시글 스크랩
		$(".linkToBo").addClass("active");
	}else if (title == 'myScrapClass') { // 클래스 스크랩
		$(".linkToCL").addClass("active");
	}else if (title == 'myScrapEating') { // 맛집 스크랩
		$(".linkToEA").addClass("active");
	}else if (title == 'myClassJoin') { // 가입한 클래스
		$(".linkToCJ").addClass("active");
	}else if (title == 'myClassOpen') { // 개설한 클래스
		$(".linkToOP").addClass("active");
	}
}