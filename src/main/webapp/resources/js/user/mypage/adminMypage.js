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
	var pageNum = $('#MemberCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#UserReportCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#BoardReportCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#ReplyReportCriPage').val();
		pageColor(pageNum);
	});
$(document).ready(function() {
	var pageNum = $('#NoticeCriPage').val();
		pageColor(pageNum);
	});


// 페이징
function pageColor(pageNum) {
	$('#URLP_' + pageNum).css("background-color", "#59bfbf");
	$('#URLP_' + pageNum).css("color", "#ffffff");

	$('#BRLP_' + pageNum).css("background-color", "#59bfbf");
	$('#BRLP_' + pageNum).css("color", "#ffffff");

	$('#RRLP_' + pageNum).css("background-color", "#59bfbf");
	$('#RRLP_' + pageNum).css("color", "#ffffff");

	$('#ML_' + pageNum).css("background-color", "#59bfbf");
	$('#ML_' + pageNum).css("color", "#ffffff");

	$('#vo_' + pageNum).css("background-color", "#59bfbf");
	$('#vo_' + pageNum).css("color", "#ffffff");
}