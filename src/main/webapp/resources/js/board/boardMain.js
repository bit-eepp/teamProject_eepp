function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

$(document).ready(function(){
	
	var uNickname = $("#userNickname").val();
	
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
	
/* content View */
	
var bId = $("#bId").val();	// 게시글 번호
var rpCount;				// 해당 게시글의 댓글 수 
	
$(document).ready(function() {
	replyCount(bId);
	replyList();
	likeCount(bId);		// 추천수
	unlikeCount(bId);	// 비추천수
		
	var formObj = $('form[role="form"]');
		
	$('.list').on('click', function(){
		formObj.attr('method','get');
		formObj.attr('action','boardList');
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
		
	// 해당 게시글이 공지사항이면 게시물 신고 버튼 안보이게 하기
	var bSubject = '${content.bSubject}';

	if(bSubject == '공지') {
		$('.declarationForm').remove();
	}
	//로그인 하지않은 경우, 새글쓰기 버튼 삭제
	if(!uNickname){
		$('.writeBtn').remove();
	}
	// 자기가 작성한 게시글일 경우 게시물 신고버튼 표시안됨
	if(uNickname == $("#content_uNickname").val()){
		$('.declarationForm').remove();
	}
		
});

// 해당 댓글 신고 메서드
function submitRpDeclarationForm(rpId) {
	var dReasonRp =  document.getElementById("rpDeclaration_"+rpId).dReason;
		
	if(dReasonRp.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url:getContextPath()+'/declaration/doRpDeclaration',
			data:$('#rpDeclaration_'+rpId  +'[role=formRpDeclaration_' +rpId +']').serialize(),
			success:function(msg){
				alert(rpId +'번 댓글이 신고되었습니다.');
				$('#rpModalForm_' +rpId).modal('hide');
				rpResetForm(rpId);
				replyList(); 
			}
		});
	}
}
	
function rpResetForm(rpId) {
	$('#rpModalForm_' +rpId).on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}
	
// 해당 게시글 신고 JS메서드
function submitDeclarationForm(){
	var dReason = document.dform.dReason;
			
	if(dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url:'getContextPath()+/declaration/doDeclaration',
			data:$('#declaration[role=formDeclaration]').serialize(),
			success:function(msg){
				alert(bId +'번 글이 신고되었습니다.');
				$('#modalForm').modal('hide');
				resetForm();
			}
	       });
	}
}
	
function resetForm() {
	$('#modalForm').on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset()
	});
}

// 해당 게시글 삭제 확인 JS메서드(댓글이 있는 게시글의 경우 삭제 불가)
function deleteConfirm() {
	if(rpCount > 0){
		alert("댓글이 달린 게시물은 삭제 할 수 없습니다.");	
		return;
	} else {
		if(confirm("정말 삭제 하시겠습니까?")){
			deleteContent(bId);
		}
	}
}
	
// 해당 게시글 삭제하는  JS메서드(Ajax-Json)
function deleteContent(bId) {
	$.ajax({
		url: getContextPath()+'/board/deleteContent',
		type: 'get',
		data: {'bId' : bId},
		success: function(data){
			console.log(data)
			reset();
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}
	
// 해당 게시글 삭제 후 글목록으로 전환
function reset() {
	location.href='boardList?page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}';
}
				
// 해당 게시글의 추천수를 불러오는  JS메서드(Ajax-Json)
function likeCount(bId) {
	$.ajax({
		url: getContextPath()+'/recommend/blikeCount',
		type: 'get',
		data: {'bId' : bId},
		success: function(data){
			console.log("게시글 추천수 : "+data)
			var a = '<div>';
				a += data;
				a += '</div>';
			$('.like').html(a)
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}
		
// 해당 게시글의 추천수를 올려주는  JS메서드(Ajax-Json)
function like(bId) {
	if(!uNickname){
		alert("로그인 해주세요.");
	}else{
		$.ajax({
			url: 'http://localhost:8282/eepp/recommend/blikeUp',
			type: 'get',
			data: {'bId' : bId,'user_id' : $("#userId").val()},
			success: function(data){
				if (data == 0) {
					alert(bId + "번 글을 추천하셨습니다.");
				} else if (data != 0) {
					alert("추천은 한번만 가능합니다.");
				}
				likeCount(bId);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}
		
// 해당 게시글의 비추천수를 불러오는  JS메서드(Ajax-Json)
function unlikeCount(bId) {
	$.ajax({
		url: getContextPath()+'/recommend/bUnlikeCount',
		type: 'get',
		data: {'bId' : bId},
		success: function(data){
			console.log("게시글 비추천수 : "+data)
			var a = '<div>';
				a += data;
				a += '</div>';
				$('.unlike').html(a)		
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}
	
// 해당 게시글의 비추천수를 올려주는  JS메서드(Ajax-Json)
function unlike(bId) {
	if(!uNickname){
		alert("로그인 해주세요.");
	}else{
		$.ajax({
			url: getContextPath()+'/recommend/bUnlikeUp',
			type: 'get',
			data: {'bId' : bId,'user_id' : $("#userId").val()},
			success: function(data){
				if (data == 0) {
					alert(bId + "번 글을 비추천하셨습니다.");
				} else if (data != 0) {
					alert("비추천은 한번만 가능합니다.");
				}
				unlikeCount(bId);
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}
	
// 해당 게시글 스크랩  JS메서드(Ajax-Json)
function bScrap(bId) {
	if(!uNickname){
		alert("로그인 해주세요.");
		return false;
	}else{
		$.ajax({
			url: getContextPath()+'/scrap/doBoardScrap',
			type: 'post',
			data: {'board_id' : bId},
			success: function(data){
				console.log(data)
				alert(bId +"번 게시글이 스크랩 되었습니다.");
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}

/* modify View */
$(document).ready(function() {
	$('#summernote').summernote({
		height: 500,   // set editor height
		minHeight : null,
		maxHeight : null,
		focus : true,
		lang: 'ko-KR', // 언어 세팅
		placeholder: '내용을 작성해 주세요',
		tabsize: 2,
		toolbar: [
			['style', ['style']],
			['font', ['bold', 'underline','superscript', 'subscript', 'strikethrough', 'clear']],
			['fontname', ['fontname']],
	        ['fontsize', ['fontsize']],
			['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['table', ['table']],
			['insert', ['link', 'picture', 'video']],
			['view', ['fullscreen', 'codeview', 'help']]
		],
		fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
		fontNamesIgnoreCheck : [ '맑은고딕' ]
	});  
});

function checkForm() {
	var bTitle = document.mform.bTitle;
	
	 if(bTitle.value == '') {
		alert("제목을 입력해주세요");
		document.mform.bTitle.focus();
		return false;
	} else {
		return true;
	}
}

/* write View */
function writeCheckForm() {
	var bCategory = document.wform.bCategory;
	var bSubject = document.wform.bSubject;
	var bTitle = document.wform.bTitle;
	
	if(bCategory.value == '') {
		alert("게시판 카테고리를 선택 해주세요.");
		document.wform.bCategory.focus();
		return false;
	} else if(bSubject.value == '') {
		alert("주제를 선택해주세요.");
		document.wform.bSubject.focus();
		return false;
	} else if(bTitle.value == '') {
		alert("제목을 입력해주세요");
		document.wform.bTitle.focus();
		return false;
	} else {
		return true;
	}
}