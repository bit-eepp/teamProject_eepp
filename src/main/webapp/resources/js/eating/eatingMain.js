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
				self.location = "eatingList" + $("#pageMakeQuery").val() + "&searchType=" + $("select[name=searchType]").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val()) 
				+ "&sortType=" + $("#sortType").val() + "&eCategory=" + $("#eCategory").val();
				}
			});
					
		// 게시글 n개씩 보기
		$('#cntPerPage').change(function() {
			var totalCount = $("#EatingPageMakerTotalCount").val();
			var perPageNum = this.value;
			var page = $("#eatingPageMakerCriPage").val();
			
			if(perPageNum * page > totalCount) {
				alert('정렬이 불가합니다.');
				return;
			} else {
				location.href="eatingList?page="+$("#EatingPageMakerCriPage").val()+"&perPageNum=" +perPageNum +"&searchType="+$("#escriSearchType").val()+"&keyword="+$("#escriKeyword").val()+"&sortType="+$("#sortType").val()+"&eCategory="+$("#eCategory").val();
			}
		});
		
		var formObj = $('form[role="form"]');
		
		$('.writeBtn').on('click', function(){
			formObj.attr('method','post');
			formObj.attr('action','writeView');
			formObj.submit();
		});				
		
		var title = $("#eCategory").val();
		eatingTitle(title);
			
		//로그인 하지않은 경우, 새글쓰기 버튼 삭제
		if(!$("#userNickname").val()){
			$('.writeBtn').remove();
		}
	});

	// 게시판 타이틀 
	function eatingTitle(title) {
 
	}