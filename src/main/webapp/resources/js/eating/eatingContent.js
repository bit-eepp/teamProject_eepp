function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};

/* ***************** */
/*	 content View 	 */
/* **************** */

$(document).ready(function(){

var eId = $("#contentEid").val();	// 게시글 번호
var rvCount;				// 해당 게시글의 댓글 수 
var uNickname = $("#userNickname").val();

	reviewCount(eId);
	reviewList();
	//likeCount(bId);		// 추천수
	//unlikeCount(bId);	// 비추천수
		
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
		
	// 해당 게시글이 공지사항이면 게시물 신고 버튼 안보이게 하기
	//var bSubject = $("#content_bSubject").val();
	/*
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
	*/
		
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
	
/* 해당 게시글 신고 JS메서드
function submitDeclarationForm(){
	var dReason = document.dform.dReason;
			
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
*/
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