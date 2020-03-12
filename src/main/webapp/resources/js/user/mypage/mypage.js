/**
 * mypage javascript
 */

//프로필 업로드 사진 미리보기
$("#showImg").change(function() {
	if (this.files && this.files[0]) {
		var reader = new FileReader;
		reader.onload = function(data) {
			$(".img").attr("src", data.target.result);
		}
		reader.readAsDataURL(this.files[0]);
	}
});

//ContextPath
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host)
			+ location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf(
			'/', hostIndex + 1));
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

//게시물 검색
$('#searchBtn').click(function() {
	if($('select[name=searchType]').val() == 'n') {
		alert('검색조건을 지정해주세요');
		return;
	} else {
		self.location = "mypage" + $("#mypageMakeQuery").val() + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) 
		+ "&sortType=" + $("#sortType").val() + "&bCategory=" + $("#bCategory").val();
		}
	});
//회원탈퇴 알림
function drop(){
	alert("회원탈퇴 페이지 입니다. 계속 하시겠습니까?")
};