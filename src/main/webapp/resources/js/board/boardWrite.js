/* ***************** */
/*	 write View 	 */
/* **************** */


$(document).ready(function(){
	// 게시판 리스트로 다시 돌아가기
	var formObj = $('form[role="form"]');
	
	$('.list').on('click', function(){
        // self.location : 현재 창 변경하는 JQuery 메서드
	    formObj.attr('method','get');
	    formObj.attr('action','boardList');
	    formObj.submit();
    });
	
	$('#summernote').summernote({
		height: 450,   // set editor height
		minHeight : '450px',
		maxHeight : '600px',
		focus : true,
		lang: 'ko-KR', // 언어 세팅
		placeholder: '내용을 작성해 주세요',
		tabsize: 2,
		disableResize: true,
	    disableResizeEditor: true,
	    resize: false,
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