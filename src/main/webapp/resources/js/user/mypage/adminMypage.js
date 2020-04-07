//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
}
function changeGrade() {

	var checkRow = "";
	$("input[name='pickCheck3']:checked").each(function() {
		checkRow = checkRow + $(this).val() + ",";
	});
	checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); // 맨끝 콤마 지우기
	if (checkRow == '') {
		alert("변경할 대상을 선택하세요.");
		return false;
	} else {
		$.ajax({
			url : getContextPath() + "/changeGrade",
			type : "post",
			data : {
				"checkRow" : checkRow,
				"selectgrade" : $(".selectgrade").val()
			},
			success : function(data) {
				alert("등급이 변경되었습니다.");
				location.href = "/eepp/adminPage";

			},
			error : function(request, status, error) {
				alert("에러가 발생했습니다.");
				console.log(request.responseText);
				console.log(error);
			}
		})
	}
}
$(function() {
	// 전체선택 체크박스 클릭
	$(".allCheck3").click(function() {
		if ($(".allCheck3").prop("checked")) {
			$("input:checkbox[name='pickCheck3']").prop("checked", true);
		} else {
			$("input:checkbox[name='pickCheck3']").prop("checked", false);
		}
	})
})
// 게시물 검색
$('#searchBtn1').click(
		function() {
			if ($('select[name=searchType]').val() == 'n') {
				alert('검색조건을 지정해주세요');
				return;
			} else {
				self.location = "adminPage" + $("#MemberMakeQuery").val()
						+ "&searchType=" + $("select[name=searchType]").val()
						+ "&keyword="
						+ encodeURIComponent($('#keywordInput1').val())
						+ "&board=yes"
			}
		});

// 엔터키로 검색
$('#keywordInput1').keydown(
		function(event) {
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if (keycode == 13) {
				if ($('select[name=searchType]').val() == 'n') {
					alert('검색조건을 지정해주세요');
					return;
				} else {
					self.location = "adminPage" + $("#MemberMakeQuery").val()
							+ "&searchType="
							+ $("select[name=searchType]").val() + "&keyword="
							+ encodeURIComponent($('#keywordInput1').val())
							+ "&board=yes";
				}
			}
		});
$(document).ready(function() {
	
	var pageNum1 = $('#NoticeCriPage').val();
	pageColor1(pageNum1);
	
	var pageNum2 = $('#UserReportCriPage').val();
	pageColor2(pageNum2);
	
	var pageNum3 = $('#BoardReportCriPage').val();
	pageColor3(pageNum3);
	
	var pageNum4 = $('#ReplyReportCriPage').val();
	pageColor4(pageNum4);
	
	var pageNum5 = $('#MemberCriPage').val();
	pageColor5(pageNum5);
});

// 페이징
function pageColor1(pageNum1) {
	$('#vo_' + pageNum1).css("background-color", "#59bfbf");
	$('#vo_' + pageNum1).css("color", "#ffffff");
}
function pageColor2(pageNum2) {
	$('#URLP_' + pageNum2).css("background-color", "#59bfbf");
	$('#URLP_' + pageNum2).css("color", "#ffffff");
}
function pageColor3(pageNum3) {
	$('#BRLP_' + pageNum3).css("background-color", "#59bfbf");
	$('#BRLP_' + pageNum3).css("color", "#ffffff");
}
function pageColor4(pageNum4) {
	$('#RRLP_' + pageNum4).css("background-color", "#59bfbf");
	$('#RRLP_' + pageNum4).css("color", "#ffffff");
}
function pageColor5(pageNum5) {
	$('#ML_' + pageNum5).css("background-color", "#59bfbf");
	$('#ML_' + pageNum5).css("color", "#ffffff");
}