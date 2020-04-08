function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/',
			hostIndex + 1));
};

$(document).ready(function() {
	var formObj = $('form[role="form"]');

	$('.writeBtn').on('click', function() {
		formObj.attr('method', 'post');
		formObj.attr('action', getContextPath() + '/board/writeView');
		formObj.submit();
	});

	// 로그인 하지않은 경우, 새글쓰기 버튼 삭제 및 댓글신고버튼삭제
	if (!$("#uNickname").val()) {
		$('.writeBtn').remove();
	}
});