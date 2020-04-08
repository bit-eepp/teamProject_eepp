function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

/* ***************** */
/*	 content View 	 */
/* **************** */

$(document).ready(function(){

var bId = $("#contentBid").val();	// 게시글 번호
var rpCount;				// 해당 게시글의 댓글 수 
var uNickname = $("#userNickname").val();

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
	
	$('.share').on('click', function(){
		shareLink();
	});
		
	// 해당 게시글이 공지사항이면 게시물 신고 버튼 안보이게 하기
	var bSubject = $("#content_bSubject").val();

	if(bSubject == '공지') {
		$('.declarationForm').remove();
	}
	//로그인 하지않은 경우, 새글쓰기 버튼 삭제 및 게시글신고버튼삭제
	if(!uNickname){
		$('.writeBtn').remove();
		$(".modal-footer .reportBtn").remove();
		
		var a = "";
			a += '<button type="button" class="btn reportBtn" data-dismiss="modal">취소</button>';
		$(".modal-footer").append(a);
	}
	// 자기가 작성한 게시글일 경우 게시물 신고버튼 표시안됨
	if(uNickname == $("#content_uNickname").val()){
		$('.declarationForm').remove();
	}
	
	var title = $("#bCategory").val();
	boardTitle(title);
		
});

//게시판 카테고리
function boardTitle(title) {	
	if(title == '') {
		$(".ct-all").addClass("onCategory");
	} else if(title == 'notice' || title == '공지') {
		$(".ct-notice").addClass("onCategory");
	} else if(title == 'it_dev' || title == 'IT/개발') {
		$(".ct-it").addClass("onCategory");
	} else if(title == 'service' || title == '서비스') {
		$(".ct-service").addClass("onCategory");
	} else if(title == 'finance' || title == '금융') {
		$(".ct-finance").addClass("onCategory");
	} else if(title == 'design' || title == '디자인') {
		$(".ct-design").addClass("onCategory");
	} else if(title == 'official' || title == '공무원') {
		$(".ct-offi").addClass("onCategory");
	} else if(title == 'etc' || title == '기타') {
		$(".ct-etc").addClass("onCategory");
	} 
}

//카카오 링크 공유
Kakao.init('55d4b3987a46162ad1d899676af601c4');
function shareLink() {
    Kakao.Link.sendCustom({
      templateId: 22997,
      templateArgs: {
        title: '#'+$("#bCategory").val()+'게시판 \n'+$("#contentBtitle").val(),
        description: 'Community EE에서 확인하세요!',
        pathLink : 
        	'eepp/board/contentView?bId='+$("#contentBid").val()+'&bCategory=&sortType=',
      },
    })
  }

// 해당 댓글 신고 메서드
function submitRpDeclarationForm(rpId) {
	var dReasonRp =  document.getElementById("rpDeclaration_"+rpId).dReason;
		
	if(dReasonRp.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	}else {
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
		$(this).find('form')[0].reset();
	});
}
	
// 해당 게시글 신고 JS메서드
function submitDeclarationForm(){
	var dReason = document.getElementById("declaration").dReason;
			
	if(dReason.value == "") {
		alert("신고사유를 선택 해주세요.");
		return false;
	} else {
		$.ajax({
			type:'POST',
			url: getContextPath() + '/declaration/doDeclaration',
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
		$(this).find('form')[0].reset();
	});
}

// 해당 게시글 삭제 확인 JS메서드(댓글이 있는 게시글의 경우 삭제 불가)
function deleteConfirm() {
	
	if(confirm("정말 삭제 하시겠습니까?")){
		deleteContent(bId);
	}
	
	
	/*if(rpCount > 0){
		alert("댓글이 달린 게시물은 삭제 할 수 없습니다.");	
		return;
	} else {
		if(confirm("정말 삭제 하시겠습니까?")){
			deleteContent(bId);
		}
	}*/
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
	location.href='boardList?page='+$("#scriPage").val()+'&perPageNum='+$("#scriPageNum").val()+'&searchType='+$("#scriSearchType").val()
	+'&keyword='+$("#scriKeyword").val()+'&sortType='+$("#boardSortType").val()+'&bCategory='+$("#bCategory").val();
}
				
// 해당 게시글의 추천수를 불러오는  JS메서드(Ajax-Json)
function likeCount(bId) {
	$.ajax({
		url: getContextPath()+'/recommend/blikeCount',
		type: 'get',
		data: {'bId' : bId},
		success: function(data){
			$('.blike').html('<i class="far fa-thumbs-up"></i> '+data)
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
			url: getContextPath() + '/recommend/blikeUp',
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
				$('.bunlike').html('<i class="far fa-thumbs-down"></i> '+data)	
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
			data: {'board_id' : bId, 'user_id' : $("#userId").val()},
			success: function(data){
				if(data == 1){
					alert("이미 스크랩한 게시글입니다.");
				}else{
					alert(bId +"번 게시글이 스크랩 되었습니다.");
				}
			},
			error : function(request, status, error) {
				console.log(request.responseText);
				console.log(error);
			}
		});
	}
}