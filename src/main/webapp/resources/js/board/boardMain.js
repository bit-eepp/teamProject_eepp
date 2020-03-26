	function getContextPath() {
		var hostIndex = location.href.indexOf( location.host ) + location.host.length;
		return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
	
	var uNickname = $("#userNickname").val();
	var boardbId = $("#boardbId").val();
	
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
		
		var sortType = $("#sortType").val();
		sortTypeTitle(sortType);

		//로그인 하지않은 경우, 새글쓰기 버튼 삭제
		if(!$("#userNickname").val()){
			$('.writeBtn').remove();
		}
		
		var newArticle = Number($("#newArticle").val());
		var bWrittenDate = Number($("#bWrittenDate_"+boardbId).val());
		console.log(newArticle)
		console.log(bWrittenDate)
		if(newArticle >= bWrittenDate){
			$(".isNew_"+boardbId).addClass("newArticle");
		}
	});

	// 게시판 타이틀 
	function boardTitle(title) {
		
		if(title == '') {
			$('.boardTitle').append('<h2>ALL</h2>');
		} else if(title == 'notice') {
			$('.boardTitle').append('<h2>공지사항</h2>');
		} else if(title == 'it_dev') {
			$('.boardTitle').append('<h2>IT / 개발</h2>');
		} else if(title == 'service') {
			$('.boardTitle').append('<h2>서비스</h2>');
		} else if(title == 'finance') {
			$('.boardTitle').append('<h2>금융</h2>');
		} else if(title == 'design') {
			$('.boardTitle').append('<h2>디자인</h2>');
		} else if(title == 'official') {
			$('.boardTitle').append('<h2>공무원</h2>');
		} else if(title == 'etc') {
			$('.boardTitle').append('<h2>기타</h2>');
		} 
	}
	
	// 정렬 타이틀 
	function sortTypeTitle(sortType) {
		if(sortType == 'bWrittenDate'){
			$(".selectSortType a").removeClass("active");
			$(".sort-Date").addClass("active");
		} else if(sortType == 'bHit'){
			$(".selectSortType a").removeClass("active");
			$(".sort-Hit").addClass("active");
		} else if(sortType == 'bLike'){
			$(".selectSortType a").removeClass("active");
			$(".sort-Like").addClass("active");
		} else if(sortType == 'rpCount'){
			$(".selectSortType a").removeClass("active");
			$(".sort-Reply").addClass("active");
		}
	}
