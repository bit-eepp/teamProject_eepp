	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	
	var uNickname = $("#userNickname").val();
	
	$(document).ready(function() {
		// 게시물 검색
		$('#searchBtn').click(function() {
			if($('select[name=searchType]').val() == 'n') {
				alert('검색조건을 지정해주세요');
				return;
			} else {
				self.location = "boardList" + $("#pageMakeQuery").val() + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) 
				+ "&sortType=" + $("#sortType").val() + "&bCategory=" + $("#bCategory").val();
				}
			});
					
		// 게시글 n개씩 보기
		$('#cntPerPage').change(function() {
			var totalCount = $("#pageMakerTotalCount").val();
			var perPageNum = this.value;
			var page = $("#pageMakerCriPage").val();
			
			if(perPageNum * page > totalCount) {
				alert('정렬이 불가합니다.');
				return;
			} else {
				location.href="boardList?page="+$("#pageMakerCriPage").val()+"&perPageNum=" +perPageNum +"&searchType="+$("#scriSearchType").val()+"&keyword="+$("#scriKeyword").val()+"&sortType="+$("#sortType").val()+"&bCategory="+$("#bCategory").val();
			}
		});
		
		var formObj = $('form[role="form"]');
		
		$('.writeBtn').on('click', function(){
			formObj.attr('method','post');
			formObj.attr('action','writeView');
			formObj.submit();
		});				
		
		var title = $("#bCategory").val();
		boardTitle(title);
			
		//로그인 하지않은 경우, 새글쓰기 버튼 삭제
		if(!$("#userNickname").val()){
			$('.writeBtn').remove();
		}
	});

	// 게시판 타이틀 
	function boardTitle(title) {
		
		if(title == '') {
			$('.boardTitle').append('<h2>직장인 커뮤니티</h2>');
		} else if(title == 'notice') {
			$('.boardTitle').append('<h2>공지사항</h2>');
		} else if(title == 'it_dev') {
			$('.boardTitle').append('<h2>IT/개발 직군 커뮤니티</h2>');
		} else if(title == 'service') {
			$('.boardTitle').append('<h2>서비스 직군 커뮤니티</h2>');
		} else if(title == 'finance') {
			$('.boardTitle').append('<h2>금융 직군 커뮤니티</h2>');
		} else if(title == 'design') {
			$('.boardTitle').append('<h2>디자인 직군 커뮤니티</h2>');
		} else if(title == 'official') {
			$('.boardTitle').append('<h2>공무원 직군 커뮤니티</h2>');
		} else if(title == 'etc') {
			$('.boardTitle').append('<h2>기타 직군 커뮤니티</h2>');
		} 
	}