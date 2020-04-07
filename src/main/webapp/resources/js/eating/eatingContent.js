function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

/* ***************** */
/*	 content View 	 */
/* **************** */

$(document).ready(function(){

var eId = $("#eContentViewEid").val(); //가게 번호
var rvCount; //리뷰 수
var uNickname = $("#userNickname").val();
var eTitle = $("#eContentViewEtitle").val();

	reviewCount(eId);
	reviewList();
		
	var formObj = $('form[role="form"]');
		
	$('.list').on('click', function(){
		formObj.attr('method','get');
		formObj.attr('action','eatingList');
		formObj.submit();
	});
		
	$('.modify').on('click', function(){
		formObj.attr('method','get');
		formObj.attr('action','modifyView');
		formObj.submit();
	});
		
	$('.delete').on('click', function(){
		deleteConfirm();
	});
		
	//가게 정보는 유저가 삭제, 신고 불가. 스크랩 가능.
	//비 로그인 상태에서 리뷰 작성, 스크랩 버튼 클릭 시 "로그인 후 작성 가능합니다."
		
});


	
function rvResetForm(rvId) {
	$('#rpModalForm_' +rpId).on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}
	
// 해당 게시글 스크랩  JS메서드(Ajax-Json)
function eScrap(eTitle) {
	if(!uNickname){
		alert("로그인 해주세요.");
		return false;
	}else{
		$.ajax({
			url: getContextPath()+'/scrap/doEatingScrap',
			type: 'post',
			data: {'eTitle' : eTitle},
			success: function(data){
				console.log(data)
				alert("맛집" + eTitle +"이 스크랩 되었습니다.");
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}