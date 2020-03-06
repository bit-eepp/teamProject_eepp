/* ***************** */
/*	  class List 	 */
/* **************** */

$(document).ready(function(){
	// 게시물 검색
	$('#classSearchBtn').click(function() {
		if($('select[name=searchType]').val() == 'n') {
			alert('검색조건을 지정해주세요');
			return;
		} else {
			self.location = "classList" + $("#classPageMaker").val() + "&searchType=" + $("select[name=searchType]").val() 
			+ "&keyword=" + encodeURIComponent($('#keywordInput').val()) +"&cCategory="+$("#cCategory").val();
		}
	});
	
	// 게시글 n개씩 보기
	$('#cntPerPage').change(function() {
		var totalCount = $("#classTotalCount").val();
		var perPageNum = this.value;
		var page = $("#classCriPage").val();
		 
		if(perPageNum * page > totalCount) {
			alert('정렬이 불가합니다.');
			return;
		} else {
			location.href="classList?page="+$("#classCriPage").val()+"&perPageNum=" +perPageNum +"&searchType="+$("#classSearchType").val()
			+"&keyword="+$("#keywordInput").val()+"&cCategory="+$("#cCategory").val();
		}
	});
	
	var title = '${cCategory}';
	classTitle(title);
	
	//로그인 하지않은 경우, 강좌개설 버튼 삭제
	if(!$("#userNickname").val()){
		$('#openNewClass').remove();
	}
});

// 게시판 타이틀 
function classTitle(title) {
	if(title == '') {
		$('.classTitle').append('<h2>전체 CLASS 강좌</h2>');
	} else if(title == 'it_dev') {
		$('.classTitle').append('<h2>IT/개발 관련 CLASS 강좌</h2>');
	} else if(title == 'workSkill') {
		$('.classTitle').append('<h2>업무스킬 관련 CLASS 강좌</h2>');
	} else if(title == 'daily') {
		$('.classTitle').append('<h2>일상관련 CLASS 강좌</h2>');
	} else if(title == 'financialTechnology') {
		$('.classTitle').append('<h2>재테크 관련 CLASS 강좌</h2>');
	} else if(title == 'etc') {
		$('.classTitle').append('<h2>기타 CLASS 강좌</h2>');
	} 
}
