function getContextPath() {
	var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};
/* ***************** */
/*	  class Content	 */
/* **************** */
$(document).ready(function() {
	
	var cId = $("#class_cid").val();
	var questionCount;
	var uNickname = $("#userNickname").val();
	
	questionCnt();
	questionList();
	
	var formObj = $('form[role="form"]');
	
	$('.classList').on('click', function(){
		formObj.attr('method','post');
		formObj.attr('action','classList');
		formObj.submit();
	});
	
	$('.classModify').on('click', function(){
		formObj.attr('method','post');
		formObj.attr('action','classModifyView');
		formObj.submit();
	});
	
	$('.classDelete').on('click', function(){
		deleteConfirm();
	});
});

function resetForm() {
	$('#modalForm').on('hidden.bs.modal', function (e) {
	$(this).find('form')[0].reset()

	});
}

// 해당 class강좌 신청 JS메서드
function classJoinForm(){
	var cjIntroduce = document.cjform.cjIntroduce;
					
	if(cjIntroduce.value == "") {
		alert("Class강좌 가입을 위한 간단한 본인소개를 작성해주세요");
		document.cjform.cjIntroduce.focus();
		return false;
	} else {
		$.ajax({
			type:'POST',
			url: getContextPath() + '/class/classJoin',
			data:$('#classJoin[role=classJoinRole]').serialize(),
			success:function(msg){
				alert(cId +'번 클래스 수강신청이 완료되었습니다.');
				$('#modalForm').modal('hide');
				resetForm();
			}
		});
	}
}
			
// 해당 class 강좌 삭제 확인 JS메서드(댓글이 있는 강좌의 경우 삭제 불가)
function deleteConfirm() {
	if(questionCount > 0){
		alert("문의가 있는 class강좌는 삭제 할 수 없습니다.");	
		return;
	} else {
		if(confirm("Class 강좌를 정말 삭제 하시겠습니까?")){
			deleteContent(cId);
		}
	}
}

// 해당  class 강좌 삭제하는  JS메서드(Ajax-Json)
function deleteContent(cId) {
	$.ajax({
		url: getContextPath() + '/class/deleteClass',
		type: 'get',
		data: {'cId' : cId},
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
			

// 해당 class강좌 삭제 후 class강좌목록으로 전환
function reset() {
	location.href='classList?page='+$("#cscriPage").val()+'&perPageNum='+$("#cscriPageNum").val()+'&searchType='+$("#cscriSearchType").val()
	+'&keyword='+$("#cscriKeyword").val()+'&cCategory='+$("#cCategory").val();
}

// 해당 class강좌 스크랩  JS메서드(Ajax-Json)
function cScrap(cId) {
	$.ajax({
		url: getContextPath() + '/scrap/doClassScrap',
		type: 'post',
		data: {'class_id' : cId},
		success: function(data){
			console.log(data)
			alert(cId +"번 class강좌가 스크랩 되었습니다.");
		},
		error : function(request, status, error) {
			console.log(request.responseText);
			console.log(error);
		}
	});
}