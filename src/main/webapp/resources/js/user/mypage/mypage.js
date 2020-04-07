/*
 * 
 * mypage javascript
 *
 */

// 프로필 업로드 사진 미리보기
// ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

$("#showImg").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".img-circle").attr("src", data.target.result);
		}
		reader.readAsDataURL(this.files[0]);
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
				self.location = "mypage" + $("#mypageMakeQuery").val()
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
					self.location = "mypage" + $("#mypageMakeQuery").val()
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

function onlyNumber(e){
	var keyValue = event.keyCode; 
	if( ((keyValue >= 48) && (keyValue <= 57)) ) 
		return true; 
	else 
		return false;
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
$("#myinfobtn").click(function() {
	$(".info").slideToggle(500);
});

// 게시글 보여주고 닫기
$(document).ready(function() {
	if (!$('#board').val()) {
		$(".content_list").hide("slow");
	} else {
		$(".content_list").show("slow");
	}
})
$("#mycontentbtn").click(function() {
	$(".content_list").slideToggle(500);
	$(".info").hide();
});

// 스크랩 보여주고 닫기
$(document).ready(function() {
	if (!$('#scrap').val()) {
		$(".scrap_list").hide("slow");
	} else {
		$(".scrap_list").show("slow");
	}
})
$("#myscrapbtn").click(function() {
	$(".scrap_list").slideToggle(500);
	$(".info").hide();
});

// 포인트 사용내역 보여주고 닫기
$(document).ready(function() {
	if (!$('#mpPoint').val()) {
		$("#point_list").hide("slow");
	} else {
		$("#point_list").show("slow");
	}
})
$("#mypointbtn").click(function() {
	$("#point_list").slideToggle(500);
	$(".info").hide();
});

// 클래스 내역 보여주고 닫기
$(document).ready(function() {
	if (!$('#mpclass').val()) {
		$(".myclass_list").hide("slow");
	} else {
		$(".myclass_list").show("slow");
	}
})
$("#myclassbtn").click(function() {
	$(".myclass_list").slideToggle(500);
	$(".info").hide();
});

//리뷰 보여주고 닫기
$(document).ready(function() {
	if (!$('#rv').val()) {
		$(".review_list").hide("slow");
	} else {
		$(".review_list").show("slow");
	}
})
$("#mpRVBtn").click(function() {
	$(".review_list").slideToggle(500);
	$(".info").hide();
});

$(document).ready(function() {
	var pageNum = $('#mypageMakerCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#OpenClassCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#JoinClassCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#PointCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#ScrapboardCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#ScrapClassCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#MyReviewCriPage').val();
		pageColor(pageNum);
	});

// 페이징
function pageColor(pageNum) {
	$('#boardpaging_' + pageNum).css("background-color", "#59bfbf");
	$('#boardpaging_' + pageNum).css("color", "#ffffff");

	$('#pointpage_' + pageNum).css("background-color", "#59bfbf");
	$('#pointpage_' + pageNum).css("color", "#ffffff");

	$('#scrapBoardPage_' + pageNum).css("background-color", "#59bfbf");
	$('#scrapBoardPage_' + pageNum).css("color", "#ffffff");

	$('#scrapClassPage_' + pageNum).css("background-color", "#59bfbf");
	$('#scrapClassPage_' + pageNum).css("color", "#ffffff");

	$('#clJoinPage_' + pageNum).css("background-color", "#59bfbf");
	$('#clJoinPage_' + pageNum).css("color", "#ffffff");

	$('#clOpenPage_' + pageNum).css("background-color", "#59bfbf");
	$('#clOpenPage_' + pageNum).css("color", "#ffffff");
	
	$('#rv_' + pageNum).css("background-color", "#59bfbf");
	$('#rv_' + pageNum).css("color", "#ffffff");
}

$(document).ready(function() {
	$("#selectDeleteBtn1").click(function() {
		deleteScrap();
	});
});

//전체 선택 or 해제 (게시판 스크랩)
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
// 전체 선택 or 해제(클래스 스크랩)
$(function() {
	// 전체선택 체크박스 클릭
	$(".allCheck1").click(function() {
		if ($(".allCheck1").prop("checked")) {
			$("input:checkbox[name='pickCheck1']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck1']").prop("checked", false);
		}
	})
})
// 전체 선택 or 해제(맛집 스크랩)
$(function() {
	// 전체선택 체크박스 클릭
	$(".allCheck2").click(function() {
		if ($(".allCheck2").prop("checked")) {
			$("input:checkbox[name='pickCheck2']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck2']").prop("checked", false);
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
							location.href = "http://localhost:8282/eepp/mypage?&scrap=yes";
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

//체크박스 선택 삭제
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
							"checkRow" : checkRow
						},
						success : function(data) {
							alert("스크랩이 삭제되었습니다.");
							location.href = "http://localhost:8282/eepp/mypage?&scrap=yes";
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

function deleteScrap2() {
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
			$.ajax({
						url : getContextPath() + "/deleteScrap",
						type : "post",
						data : {
							"checkRow" : checkRow
						},
						success : function(data) {
							alert("스크랩이 삭제되었습니다.");
							location.href = "http://localhost:8282/eepp/mypage?&scrap=yes";
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
$(document).ready(function() {
	$("#selectDeleteBtn2").click(function() {
		deleteScrap2();
	});
});

function deleteScrap3() {
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
			$.ajax({
						url : getContextPath() + "/deleteScrap",
						type : "post",
						data : {
							"checkRow" : checkRow
						},
						success : function(data) {
							alert("스크랩이 삭제되었습니다.");
							location.href = "http://localhost:8282/eepp/mypage?&scrap=yes";
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
$(document).ready(function() {
	$("#selectDeleteBtn3").click(function() {
		deleteScrap2();
	});
});

// 클래스 구입자 보기
function classjoin_list(cId) {
	var member = window.open("http://localhost:8282/eepp/classjoin_list?cId="
			+ cId, "classjoin_list", "left=" + (screen.availWidth - 530) / 2
			+ ",top=" + (screen.availHeight - 620) / 2
			+ ",width=530,height=620");
}
